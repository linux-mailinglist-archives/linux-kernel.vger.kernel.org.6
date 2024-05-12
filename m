Return-Path: <linux-kernel+bounces-177037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA95B8C38FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE3281694
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441F55C1A;
	Sun, 12 May 2024 22:23:48 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2E54FB5
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715552628; cv=none; b=QBXprFTgpDSkJ+QdagSid9T+sgNHgINHzlSQpvLpb8RwajSWGWBglgxZBa2fzoQjAfibcd6L/3/EYA8u0R4TqOQPLdlASiK6D+9le6vwaR/CHwmzwgqSk9BoeoOVb2YcK5Dg7cM1UUlIe2fmcITHLDLX2EOtmbWEsjU1U0dXBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715552628; c=relaxed/simple;
	bh=57JtyPVf76aon2GPuKt+8OfmA6LySffEBd1IpY7gwtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ln8MeVXLRONIOB8LZ7+wLQbLXlHC4DFE9thhszzUmL8rKm5rhHj93Mxk5z55H0zGLkI8IPVGVlbjpVsETiMIY8XZj3OlvmAW+QOjfgEXz4JHOXlaAmLvVuoXKM9/dwGWB/qofJNNckC4Y0LUHyfGYBEJk7iWq3QMkCxPupz1lQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.17])
	by sina.com (172.16.235.24) with ESMTP
	id 6641416300004C20; Sun, 13 May 2024 06:23:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 42685145089200
X-SMAIL-UIID: 05ADD407A2664070883F42FA7DFE4856-20240513-062334-1
From: Hillf Danton <hdanton@sina.com>
To: lee bruce <xrivendell7@gmail.com>
Cc: syzbot+68619f9e9e69accd8e0a@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Edward Adam Davis <eadavis@qq.com>,
	clf700383@gmail.com,
	michael.christie@oracle.com,
	mst@redhat.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in kill_orphaned_pgrp (2)
Date: Mon, 13 May 2024 06:23:22 +0800
Message-Id: <20240512222322.2835-1-hdanton@sina.com>
In-Reply-To: <CABOYnLxHfNwD_9WthyVS+9xhczUxFYkpAhRQ0mNugwzqwzZwiw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 12 May 2024 21:36:56 +0800 lee bruce <xrivendell7@gmail.com>
> 
> I test the kernel linux-next: d558664602d3906866e604a618dcf67f66d79967
> and comfired reproducer and didn’t trigger any crashes.

Thank you for testing on top of the next tree.

> I notice maybe this bug is duplicated with
> https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f and
> https://syzkaller.appspot.com/bug?extid=c6d438f2d77f96cae7c2.
> Should we need to close or tag duplicated or fix to them?

Feel free to do so.

BTW, git send-email is one of the tools for posting to lore.

