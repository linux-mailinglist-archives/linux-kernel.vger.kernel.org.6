Return-Path: <linux-kernel+bounces-226429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F5A913E44
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EBC280F43
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864618508A;
	Sun, 23 Jun 2024 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PmkQ/C3S"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040E2232A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719176232; cv=none; b=ByvoTBLDGAqfGx1Ot+B3V5iiJP3sn+Ft/ftzw4NSthfxtGn2LWN1GfTdCjcJmrdhUGB3DbMLkFLujfy4VNFjr3Xorbn8kkA7c1b8cdI2IrO0V+JWn7+Ez6hHLXjq5rn610Mk0n7kEnV9xitq5dwQvPwSSnE5Y9wFsvYHbcKuHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719176232; c=relaxed/simple;
	bh=BvsSNs6M1+Wol/E5Sgq2l2B+PO0WygPLnm7ln/eneSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adWEOL/gJ81ham5oXqVCxtjbMB3oonAj2vLPD+Z7qACs40y6mzW/ox9jvbgw5+u+F3RGaNlQN04ncoB2EjZrAgadDTyKjk4RH2CXK5Cf0dJScQxrESHth4yhScahIpBrzmVagHwzdwWoOvx4qeIpV8/RygWuh0eHNYkbo2K8e2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PmkQ/C3S; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+3d2944b5612507034fc4@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719176225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aY4yvMIfzUfwBBt9ejIwG1doYduFxIGDSPwDncBw5tE=;
	b=PmkQ/C3SgXLteJMuS42Jo8ysUBWgQ/hrxASc4bvXALJyXVRq0+hTI6Ficzo5pbgaCBav72
	0U40K0TqoNBSxVmZCMi9poaJ0iemADaAInWVn/FYNi1akb/Fk409uPsQ6/puWvjhhDnQos
	xY5sg7KaPlB6Lv9pqBJs9f/xn4DZjfw=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Sun, 23 Jun 2024 16:56:59 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+3d2944b5612507034fc4@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_bucket_alloc_freelist
Message-ID: <hh3cy3o6k5aajz37dbo5u7mrjjyxnqhddj5zh6w6rmezdrnm7x@imzt47yjy2ac>
References: <0000000000004492c2061b8b3796@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004492c2061b8b3796@google.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 23, 2024 at 02:23:21AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b13146980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
> dashboard link: https://syzkaller.appspot.com/bug?extid=3d2944b5612507034fc4
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3d2944b5612507034fc4@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/bcachefs/alloc_foreground.c:489!

So it turns out, this one is from onlining a device (already a member of
the filesystem) that doesn't have a journal allocated; we end up using
bch2_bucket_alloc_new_fs() when we're not supposed to.

I started a rework of the early filesystem bringup allocation paths
awhile ago to get rid of that entirely, perhaps I shall finish that.

