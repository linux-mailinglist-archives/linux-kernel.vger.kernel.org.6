Return-Path: <linux-kernel+bounces-213460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC81990759D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5623D285F19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACBC1465A9;
	Thu, 13 Jun 2024 14:48:31 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B7EEB13D892
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290110; cv=none; b=ccuPpi45EtNMWv8bpgnTczfnp1oA5lzQafBNgYJH1sZr3/FaQUSRl6em6+UfqufKYtU5iuRz4FOExiGskry/uPraifsJ5nlsUMHwCqwYL9zbNwhSSHMwVPKA06KtUJwPm5sGgCWvqplGvb5IySA28i/7iLzscLt4EMZpp5B+wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290110; c=relaxed/simple;
	bh=WJfygxCiIGV+LFOhGdFIBNXZJXjEjMO9dlxerVwEtX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxNVIuv1swe4MTKONhYjI8LcnFdSrb6+dePhFZFsxp8iQv7W7HgoRPZ/Afg85c6XUtHaLr+MkTNnYEHCQXu4m815Mirfb0Wjzdfp74mprfQPSHbK8CQMORGwDkP4MFcJVlT8gdBoi1fYe3JPFMVQyIyya+dFfWCeDQypu6fCIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 263793 invoked by uid 1000); 13 Jun 2024 10:48:24 -0400
Date: Thu, 13 Jun 2024 10:48:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] [usb?] BUG: soft lockup in hci_cmd_timeout
Message-ID: <4e155544-60df-42d2-89ea-924ebc9f7057@rowland.harvard.edu>
References: <000000000000f45085061aa9b37e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f45085061aa9b37e@google.com>

On Tue, Jun 11, 2024 at 09:20:31PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=112ad20a980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
> dashboard link: https://syzkaller.appspot.com/bug?extid=1b2abad17596ad03dcff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1112d2ce980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c37286980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6ea21f50498b/disk-8867bbd4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e2fed09364aa/vmlinux-8867bbd4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4860173c7a18/Image-8867bbd4.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com
> 
> cdc_wdm 1-1:1.0: nonzero urb status received: -71
> cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
> cdc_wdm 1-1:1.0: nonzero urb status received: -71
> cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
> watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u9:2:6293]
> CPU#0 Utilization every 4s during lockup:
> 	#1:  97% system,	  1% softirq,	  4% hardirq,	  0% idle
> 	#2:  98% system,	  1% softirq,	  3% hardirq,	  0% idle
> 	#3:  97% system,	  0% softirq,	  3% hardirq,	  0% idle
> 	#4:  98% system,	  1% softirq,	  3% hardirq,	  0% idle
> 	#5:  98% system,	  1% softirq,	  3% hardirq,	  0% idle
> Modules linked in:
> irq event stamp: 150196

This patch fixed the problem in a different syzbot lockup.  Let's see if 
it also fixes this one.  The console log output suggests that it will.

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8867bbd4a056

Index: usb-devel/drivers/usb/class/cdc-wdm.c
===================================================================
--- usb-devel.orig/drivers/usb/class/cdc-wdm.c
+++ usb-devel/drivers/usb/class/cdc-wdm.c
@@ -266,14 +266,14 @@ static void wdm_int_callback(struct urb
 			dev_err(&desc->intf->dev, "Stall on int endpoint\n");
 			goto sw; /* halt is cleared in work */
 		default:
-			dev_err(&desc->intf->dev,
+			dev_err_ratelimited(&desc->intf->dev,
 				"nonzero urb status received: %d\n", status);
 			break;
 		}
 	}
 
 	if (urb->actual_length < sizeof(struct usb_cdc_notification)) {
-		dev_err(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
+		dev_err_ratelimited(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
 			urb->actual_length);
 		goto exit;
 	}


