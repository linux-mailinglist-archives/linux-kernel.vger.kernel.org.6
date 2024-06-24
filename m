Return-Path: <linux-kernel+bounces-226874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B501F91451F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF3328111A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2461FE7;
	Mon, 24 Jun 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BhRtFaeg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2DB652;
	Mon, 24 Jun 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218537; cv=none; b=nm6JTqB+TQPUOXjMwFSIbx5uB8xpbYPjUtySmzrJjTsneqQQ/PpLQxCix3Vs0Rl4ZYXxfTcBgH9aRXCA6cIOT5N/A1h5D/b7L2Yk+tCOIhuYCkfnTAGZFakMvW+8Pv4JvatDo3hy1TEJvp0VHFHamdqSiPXxDDvIfcWGzMk+W2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218537; c=relaxed/simple;
	bh=MHK2ICleu1n31j1RXk0H5PLm4xU8IgWHnDSyT09cnQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqlqnRMwqgv6/y20FC8cKH9M5SCUY67R9J8gY4uFKqOQDi4xrhxxvfvxAl0Ih0zWT/HusPKmePCgtcMRwBNYUPvGtGnwP9/JuATd97ShCjPu77bgavCI08TWiPJ8P5cXBC+E+kBXMCPVw2HMpxcnGMazbka0BKf8AEMdqgwxmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BhRtFaeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C229BC2BBFC;
	Mon, 24 Jun 2024 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719218537;
	bh=MHK2ICleu1n31j1RXk0H5PLm4xU8IgWHnDSyT09cnQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhRtFaegQ1hVL2NoUE9TjYHYEtX0xhAAWd1DVqvOBnFRT/zxqSE6GcIj9D05OThmz
	 wagmtUJkYH4IqTN/HglxC3QFwYk3/CU5FaNF0fJ3yFe2BfSVKYeV1D7Sf2pKdql49t
	 otQ9QXIM7OS4b7QXdUSVlb8fTBKh2HzVq5lZol8w=
Date: Mon, 24 Jun 2024 10:42:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: lcx <lichunxiaona@mail.ustc.edu.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING in usbtmc_probe/usb_submit_urb
Message-ID: <2024062448-humble-pampers-6453@gregkh>
References: <b7711597-2aab-4097-8772-bbf3c8a50215@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7711597-2aab-4097-8772-bbf3c8a50215@mail.ustc.edu.cn>

On Mon, Jun 24, 2024 at 04:30:26PM +0800, lcx wrote:
> Dear Linux maintainers and reviewers:
> 
> We would like to report a linux kernel bug, found by a modified version of syzkaller.
> 
> Kernel Version: a3e18a540541325a8c8848171f71e0d45ad30b2c(6.10-rc3)
> 
> Kernel Config: see attach, config
> 
> reproducing program: see attach, repro.c
> 
> Feel free to email us if any other information is needed. Hope the provided materials will help finding and fixing the bug.
> 
> -------------------------
> 
> The full log crash log are as follows:
> 
> 
> Syzkaller hit 'WARNING in usbtmc_probe/usb_submit_urb' bug.
> 
> usb 1-1: config 0 descriptor??
> usb 1-1: usb_control_msg returned -71
> usbtmc 1-1:0.0: can't read capabilities
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 0 PID: 771 at drivers/usb/core/urb.c:503 usb_submit_urb+0xbf9/0x1490 drivers/usb/core/urb.c:503
> Modules linked in:
> CPU: 0 PID: 771 Comm: kworker/0:2 Not tainted 6.10.0-rc3-00021-g2ef5971ff345-dirty #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0xbf9/0x1490 drivers/usb/core/urb.c:503
> Code: 84 36 02 00 00 e8 97 16 2c fb 4c 89 f7 e8 df 3c f4 fe 45 89 e8 89 e9 4c 89 fa 48 89 c6 48 c7 c7 00 47 3e 8b e8 68 89 f1 fa 90 <0f> 0b 90 90 e9 61 fa ff ff e8 69 16 2c fb 49 81 c5 c8 05 00 00 e9
> RSP: 0018:ffffc90003b87010 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888017a59800 RCX: 0000000000000000
> RDX: ffff8880183c8000 RSI: ffffffff814af1dc RDI: 0000000000000001
> RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed1005905171
> R10: ffff88802c828b8b R11: 0000000000000001 R12: ffff888017a5985c
> R13: 0000000000000003 R14: ffff88801539a0a8 R15: ffff88801f75e220
> FS:  0000000000000000(0000) GS:ffff88802c800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f00c72d30a0 CR3: 000000000cd74000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  usbtmc_probe+0xd21/0x1a90 drivers/usb/class/usbtmc.c:2454

Ah, the usbtmc driver.  Probably just needs to check for proper
endpoints in the device descriptor.  Can you make up a patch for this?

thanks,

greg k-h

