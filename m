Return-Path: <linux-kernel+bounces-231444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40379198CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681921F22580
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AD6192B7A;
	Wed, 26 Jun 2024 20:13:02 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3C598190686
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432782; cv=none; b=rKoNhH1RY1N2efmzJuK40WJQgMKLUvLiyPFN7XdkbdvlIJbI1VAlDMQ8EGEm4Zr75zvaVG+4fw+D7apRusqaqrHzUAl+nQ+jeEGA52YU8ClFZ2gA+zOxstwPKaFfH9ock/ePug5eXqWr+PdeqZrepoY3OHkmCYjU4cl5Egjrjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432782; c=relaxed/simple;
	bh=FkxG7fRF+wMVcAc0Q5SWjOgn88PKXvdKEXGjxxZg/II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IItl6k/AYRX3+T2kZnJQeIxXVlSvW5aczCq3lDhGSM2wPP2XDHl7SSlBJDUCzFjobXQEvHTGktMco4sc8qMT33/nQwRzYbF4i5eRQoHmmdaU9G+M2TWu3Irzgv1zAeiC8vfehrSg27CSBtaamh9aS9FKZtyq7TuqiVr2mg7QcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 716269 invoked by uid 1000); 26 Jun 2024 16:12:58 -0400
Date: Wed, 26 Jun 2024 16:12:58 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
  syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [bluetooth?] WARNING in
 btusb_submit_intr_urb/usb_submit_urb
Message-ID: <f3ab10ab-38e0-4856-9d89-3b5409da0e55@rowland.harvard.edu>
References: <6d1f6bcc-2918-48cd-bbb3-e8cca46622a1@rowland.harvard.edu>
 <00000000000077d198061bcf30f1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000077d198061bcf30f1@google.com>

On Wed, Jun 26, 2024 at 11:29:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         66cc544f Merge tag 'dmaengine-fix-6.10' of git://git.k..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=15a59299980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
> dashboard link: https://syzkaller.appspot.com/bug?extid=8693a0bb9c10b554272a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=169b3789980000
> 
> Note: testing is done by a robot and is best-effort only.

Somewhat different approach.  Let's see if this works.

Alan Stern

#syz test: upstream 66cc544fd75c

Index: usb-devel/drivers/usb/core/config.c
===================================================================
--- usb-devel.orig/drivers/usb/core/config.c
+++ usb-devel/drivers/usb/core/config.c
@@ -291,6 +291,19 @@ static int usb_parse_endpoint(struct dev
 	if (ifp->desc.bNumEndpoints >= num_ep)
 		goto skip_to_next_endpoint_or_interface_descriptor;
 
+	/* Save a copy of the descriptor and use it instead of the original */
+	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	memcpy(&endpoint->desc, d, n);
+	d = &endpoint->desc;
+
+	i = d->bEndpointAddress &
+			(USB_ENDPOINT_DIR_MASK | USB_ENDPOINT_NUMBER_MASK);
+	if (i != d->bEndpointAddress) {
+		dev_notice(ddev, "config %d interface %d altsetting %d has an endpoint descriptor with address 0x%X, changing to 0x%X\n",
+		    cfgno, inum, asnum, d->bEndpointAddress, i);
+		endpoint->desc.bEndpointAddress = i;
+	}
+
 	/* Check for duplicate endpoint addresses */
 	if (config_endpoint_is_duplicate(config, inum, asnum, d)) {
 		dev_notice(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
@@ -308,10 +321,8 @@ static int usb_parse_endpoint(struct dev
 		}
 	}
 
-	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	/* Accept this endpoint */
 	++ifp->desc.bNumEndpoints;
-
-	memcpy(&endpoint->desc, d, n);
 	INIT_LIST_HEAD(&endpoint->urb_list);
 
 	/*


