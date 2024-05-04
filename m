Return-Path: <linux-kernel+bounces-168570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC38BBA46
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC754B20953
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1517BA6;
	Sat,  4 May 2024 09:26:21 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04C17550
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714814781; cv=none; b=c3ZZFLva0SA5K3gkG+FVxoDOPzCz1EqgoyvsCBJeF8cmw85HFIX8K6E5v1pGrRz8yZROSiQIfu9C4vjV6Z0kADYBXRD+QPZz2nO19x1/ccgeAMUrpvHCXn6ucvK9MSiQf+Z9rJA0VDeRcUvbo4q8jKMWWDi8bpFNH/IwbjqdpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714814781; c=relaxed/simple;
	bh=AdDjbW/grP1x1u3VjOS+sOEPGRWpZymJUUHRPXG9+w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l31qUwHrQDMVye1qC1GRqsBSd5IWjG4xbzyHrzlldpck+2092S4xG/M/1Y6Gc+Y59eRATRawnr3gTJCUy34CbF+0Zxt90+HLeOqrnn89RFYvtFz9nQaHJcwdL4EHePUzO6v33SwDCbBeJAG9nco2mog8g1Xu1aGT2CZFYdKDoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.195])
	by sina.com (10.75.12.45) with ESMTP
	id 6635FF2C00000D24; Sat, 4 May 2024 17:26:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 72955031457681
X-SMAIL-UIID: F6B917177A7A48A99FB77799E769FF11-20240504-172606-1
From: Hillf Danton <hdanton@sina.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Christian Konig <christian.koenig@amd.com>,
	minhquangbui99@gmail.com,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
Date: Sat,  4 May 2024 17:25:55 +0800
Message-Id: <20240504092555.2071-1-hdanton@sina.com>
In-Reply-To: <20240503212428.GY2118490@ZenIV>
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 3 May 2024 22:24:28 +0100 Al Viro wrote:
> On Fri, May 03, 2024 at 02:11:30PM -0700, Linus Torvalds wrote:
> > epoll is a mess, and does various invalid things in the name of
> > performance.
> > 
> > Let's try to rein it in a bit. Something like this, perhaps?
> 
> > +/*
> > + * The ffd.file pointer may be in the process of
> > + * being torn down due to being closed, but we
> > + * may not have finished eventpoll_release() yet.
> > + *
> > + * Technically, even with the atomic_long_inc_not_zero,
> > + * the file may have been free'd and then gotten
> > + * re-allocated to something else (since files are
> > + * not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
> 
> Can we get to ep_item_poll(epi, ...) after eventpoll_release_file()
> got past __ep_remove()?  Because if we can, we have a worse problem -

Nope but mtx can help poll go before remove, see below.

> epi freed under us.
> 
> If not, we couldn't possibly have reached ->release() yet, let
> alone freeing anything.

Actually poll can see a file with zero f_count, and LT's idea with
trival change survived the syzbot repro [1].

I think fput currently can race with epoll wrt f_count, and checking
it in dma-buf is necessary if his idea looks too aggressive.

	wait_epoll()			__fput()
	do_epoll_wait()			eventpoll_release_file()
	ep_poll()
	ep_send_events()
	mutex_lock(&ep->mtx)
	ep_item_poll()
	vfs_poll()
	mutex_unlock(&ep->mtx)
					mutex_lock(&ep->mtx)
					dispose = __ep_remove(ep, epi, true)
					mutex_unlock(&ep->mtx)

[1] https://lore.kernel.org/lkml/000000000000f1c99d061798ac6d@google.com/

