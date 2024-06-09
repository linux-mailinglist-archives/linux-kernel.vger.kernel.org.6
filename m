Return-Path: <linux-kernel+bounces-207229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82E90142A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 03:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DC51C21175
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517146139;
	Sun,  9 Jun 2024 01:57:36 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B688D15B3
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717898255; cv=none; b=WNUX7IN3YftB7hL9Q6DxUfmOt0Rhq2gaPz8wyL9AoHX/P0wNXbXtR1k0X6AS5QzrjsIv4xdK4YSfKaXM12upzj6oytXvEcSK8VEKGDrSc0B04J0g7V+5mPPX5mp4E6IfJUMhpofHBLSnf4K/Kp/zmM1TAMpnFxf9+dxFjsy9uHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717898255; c=relaxed/simple;
	bh=OKxSyNLCpt84bJ2sRIOUG8HK0TRmHlit2OTn9Hhi3/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoYyT2hmUWB0VP9pyVlIh3KEfBqscNjymWICDu51QHExDnH5vaLhtar6IMQxYm5hooVWkRa+/Np6C6VnhS8A7F6hUM9Denufgos0u9DTN2yIHgEpMDcu0lwxIiijRi8CVYjATFxT5OqmtMDUHRuMxTpVG8mFDbQhCDnNmhNSxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 100687 invoked by uid 1000); 8 Jun 2024 21:57:25 -0400
Date: Sat, 8 Jun 2024 21:57:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
Message-ID: <8177975b-7eff-45db-9b4b-4a6d321ac7ab@rowland.harvard.edu>
References: <000000000000b1093b0608ff6979@google.com>
 <00000000000073d54b061a6a1c65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000073d54b061a6a1c65@google.com>

On Sat, Jun 08, 2024 at 05:28:26PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=10961932980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15be6dce980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101ca30a980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6ea21f50498b/disk-8867bbd4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e2fed09364aa/vmlinux-8867bbd4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4860173c7a18/Image-8867bbd4.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com
> 
> cdc_wdm 1-1:1.0: nonzero urb status received: -71
> cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
> cdc_wdm 1-1:1.0: nonzero urb status received: -71
> cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
> watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [syz-executor782:6625]

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8867bbd4a056

Index: usb-devel/drivers/usb/class/cdc-wdm.c
===================================================================
--- usb-devel.orig/drivers/usb/class/cdc-wdm.c
+++ usb-devel/drivers/usb/class/cdc-wdm.c
@@ -260,6 +260,9 @@ static void wdm_int_callback(struct urb
 		case -ESHUTDOWN:
 		case -ENOENT:
 		case -ECONNRESET:
+		case -EPROTO:
+		case -EILSEQ:
+		case -ETIME:
 			return; /* unplug */
 		case -EPIPE:
 			set_bit(WDM_INT_STALL, &desc->flags);

