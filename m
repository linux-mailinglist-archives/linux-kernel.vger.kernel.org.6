Return-Path: <linux-kernel+bounces-212430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2390605D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5E11C20A91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66801DF42;
	Thu, 13 Jun 2024 01:23:22 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AF479C2D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241802; cv=none; b=YwX390Lk0kL1Jl94X+oTjMEsaMQ0dV0rMaJj8F1hyiWh4qH1qxA0cvepGz1wfVLLlaWr8rD5oHL2oaFsYEcpcCrfmSXB6/mueSYyXKr8n/tC7b2GwhxKXPDflzS1j4TLzKqlb/0d5c9eUAQ0UfeLIQRmCpd+oK3fuB3KK2YWH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241802; c=relaxed/simple;
	bh=tl13HOFJCymRly5X6WxSw4qih6uoNtD88ObLIrANbDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5WOgv+c9Zj2TKo0OivkJzL+BCr54MGk3edmSCEotwT2uqhemsiEGrQIgyMsKXmYYycqYIaeKD7+5/cXRAHXrjmGLz2yJUJJMADCELSt1NcyyvWVx+DGRceBjtcNL0/9W437vZFVDonjLK6CW397OgJEktA8TLHXJPe6xFYt5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 244083 invoked by uid 1000); 12 Jun 2024 21:23:17 -0400
Date: Wed, 12 Jun 2024 21:23:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
Message-ID: <871507d8-b4ff-4af8-8bba-9a3149c41e8a@rowland.harvard.edu>
References: <684687e4-8be4-42ee-a125-8ef9acc3fec9@rowland.harvard.edu>
 <000000000000babbf8061aa113df@google.com>
 <2bfca69a-b7e0-4f66-9025-1324af803318@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bfca69a-b7e0-4f66-9025-1324af803318@rowland.harvard.edu>

Try again, with the "#syz test:" command present this time.  Sigh.

On Tue, Jun 11, 2024 at 11:03:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e092de980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=137c697e980000
> 
> Note: testing is done by a robot and is best-effort only.

Let's try Greg's suggestion to replace dev_err() with 
dev_err_ratelimited().

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



