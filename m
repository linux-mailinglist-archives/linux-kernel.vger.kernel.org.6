Return-Path: <linux-kernel+bounces-327090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563B9770E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ADC1C2113F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089D218FDD7;
	Thu, 12 Sep 2024 18:47:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEF126BED
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166829; cv=none; b=gk7PXs/2Se6If+BUGw0r6kZI85pvqfiMYs2XIkA7wvtzWcrxmZiFk1pEsupMtwmvYnv3Ow1fsSvsCxMyQcONC1BehnbmA7UA8ch7wKoyO/2uVMPl/5Ho+e9G+T8Ku9FsXl6y9iRBYI+k/YeCkdVPw7p/dFSMowJ8Cs1dXu2yZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166829; c=relaxed/simple;
	bh=QKkqhboMpL6Ppzrgbt7M7/0kaoZFCqc1D4To632GgNc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C0RW53keJsvbBPmeYhBqPBH6+EhVd+NHpEB3CJzHEozj4dER2cymNhVcuNVghoan8nhj3F0viHxIO1z+pQFbtMNEypW4mps8JhcVou6+yN5yGr3EbV4pkgEZJ9EWCJWaE1g96mmRVfejVOryTPCPW80Bs/iqhS99LJBzDGEgaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f510b3f81so29391525ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726166827; x=1726771627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JK2SriJKpJWHUpQ+e0KaZ7bVbfS8v3GYNB/iLwvRnY=;
        b=t4fipFj0KsEhgwPYYniusegdD8JJni1BLokxObk1LG+dYPuVkWX0JV3uHLZ5xUJMxw
         wyBUbeFH43lGLiwhgePAhrIPy8Rm/7DAGbc/rNckjRcoIUtPmtVNzLmFsisefltTFs+K
         UtTXo8sx9qIignJ/BjzWt/7lj8yPlRFsNSPUbHivtK4ItaE4dgNkEXnaUsm7UVRD9IPR
         y1PARSFrIDiMnJWr2GbfDC8MqEAueB85vqNpnzLvAmRtvjG9yZFf+v2VQXpCVSEGvgH2
         9xjIl0L+Y6jiZZcz3uorUkERz/nvMFn0E8XjV3DzWDKk88JduQam6np7bA2rnVBtEd08
         2oRg==
X-Gm-Message-State: AOJu0YwcqCHeiHzS/4Uc9oTM55KkUfgsnvya9RAajc98kmc0MOC/bWlh
	1tFeVqUw8TgTW9T95zcTSkH9niHgIzXmBMCbCA2ykfaUnpkHx3t13HgC75NAliPXAStRzz2D01J
	U58l8fybKy1x8Zih80jEW28xfBAHtH6fzSGsHvbj6hlsjzz5vQ6dwbuU=
X-Google-Smtp-Source: AGHT+IG9IVimFQf4qmlxdQk6tZs4yaszKHSIKa/Hj/KMb7PjMVL7mLQ27Ev5J24QkSpXhpVeTLhCfxjLjGWMKQs6M2gfL+mBIZOQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc2:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a084645daamr30674365ab.8.1726166827362; Thu, 12 Sep 2024
 11:47:07 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:47:07 -0700
In-Reply-To: <0000000000001fdbd80621e28ae3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000917bac0621f0888e@google.com>
Subject: Re: [syzbot] KMSAN: kernel-infoleak in iowarrior_read
From: syzbot <syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: kernel-infoleak in iowarrior_read
Author: djahchankoike@gmail.com

#syz test

iowarrior_callback may send uninitialized data if memcpy fails
copying data from urb to read_queue, check if memcpy is successful
before waking waiting readers.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 drivers/usb/misc/iowarrior.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..6f5cd6251d76 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -201,8 +201,9 @@ static void iowarrior_callback(struct urb *urb)
 
 	/* +1 for serial number */
 	offset = intr_idx * (dev->report_size + 1);
-	memcpy(dev->read_queue + offset, urb->transfer_buffer,
-	       dev->report_size);
+	if (!memcpy(dev->read_queue + offset, urb->transfer_buffer,
+	       dev->report_size))
+		goto exit;
 	*(dev->read_queue + offset + (dev->report_size)) = dev->serial_number++;
 
 	atomic_set(&dev->intr_idx, aux_idx);
-- 
2.43.0


