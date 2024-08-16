Return-Path: <linux-kernel+bounces-289121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25639954242
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7071F26B46
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4273112BEBE;
	Fri, 16 Aug 2024 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l48LXP++"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5C85626;
	Fri, 16 Aug 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791744; cv=none; b=HgPVUQzIoaR8V+q1bAC5f3uTJiH/XufAFN9Qim1QCd3MAmuGGgSJDxEBzo5sdgvsebzPIPEGdyMDSjbJpWduvt2T8QRxa34xyZPvZJOjI21EJ9EvT4EyJBUX/MCQFJNBIKYFWUZUvYBR0Uvg6SHTxRvyx7uAqXka9VP6g5svKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791744; c=relaxed/simple;
	bh=ZJas41ppseSW2EpIGy/CPYlNdVZswpcnnaanve53xsA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gBbLr7OKVcCabBV/AaIyC7550zvWoQ2c3e2exjY2QxXI4gTOxiIMYcZmNiZSFATxGHT5zyfzJZuxofbQsSCaDj1xFFtm46IrhfF3tOnFHGuzZ/y2uS6vEX/kAwayPPzXjn2adbkB5J/iukrgCDCXRlu02dkOpY5FOBHFAm6917s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l48LXP++; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec4e00978so1175197a12.0;
        Fri, 16 Aug 2024 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723791741; x=1724396541; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzev+Mzi7834P4z5pu8ad44NPYLLbytP5rCZIlHC56I=;
        b=l48LXP++B4cHV14m71/7aC1gX8cuJ+FvGhN9+2JmbsTmaOGdMnz6I6M8n6XWG2eDHI
         H26l7IE//XGoas5/mUxGprtZswcdkhkZjyzlwgC9qHldUyW6t3fdg9zHrxJUUAReK6Oh
         fKXuV/KXiZoOnsijP4n2CwK0zkTQbzhzohl8BOVlQmmMiUbZsdE3L1c7sv8hI7YZ62LN
         2I5CcZh9AfseWN3DJ5r89s5tCKd4VwYBDMy/1DemYi6aNOgaflJpRhyS9QTF8/DAeb8m
         1bzfvsUrNkr1vDBKBXB68jwLVapIo2tzrwJYMfqbb4vQ4VNsrjp1B1+yYPT15WMX0Ag7
         nKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723791741; x=1724396541;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzev+Mzi7834P4z5pu8ad44NPYLLbytP5rCZIlHC56I=;
        b=MPB1EJHDa/YjQnADJneW8vXwqpHzAQT+SdCacj0xcEMhMw9nE8fp2flkLWggd9kwhe
         kX1d//81NAagb+/LwD5bwlIa8lTZ8wg1mUIbR2oGRFO8LWIh/Snlih/j1nbYsGnSg0bG
         eH5HXFVpWFl0jC29QXhbplQp/nRq913COFxeTPcVkleeECK8rfIOft83DNokAtxZ4/y+
         dbH9/HY5EDgaZlmfsSgi6a37dESrE9Xr4GeCkWI41wywzG7uIM60W0Ajo737m6MG2MEL
         8x2cQLHufH7cOR5/fru+4rV6cP+ZvsUC1ZZAV/zQq9TlJ25rpTQNS2TSW/EazRm0h36c
         CNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCULahNAUJOJLW352QGNrNJ8Ev52degaslJZQQ4v5DIq0xC+Ew4yceSc2n061FZ2z4qOnjldqzP/hfPhxXCQ2ckkwxd5JB1P07fLM+DHA+EulsEFOKGPq2Ao+zoIlnYnD38mzEJz+SkZ
X-Gm-Message-State: AOJu0YzADZvXcLYlx8QE2UxQvwsYP8dmWsrVzSCqynH6ZrZIGhoi29N9
	/iInrI1yWjTwovZG6nCVnawqXNXoExesxD51uSPz2jBYllltgR0lHxcsKPTL
X-Google-Smtp-Source: AGHT+IEXmA1eKlUggNe9Hxgxrj3Q4KATYAc2SIw05ICsYmkvrCeRG137tY7DydonojO5UnUZDm4MrA==
X-Received: by 2002:a17:907:1c22:b0:a77:b516:3023 with SMTP id a640c23a62f3a-a83928a6444mr134157766b.4.1723791740476;
        Fri, 16 Aug 2024 00:02:20 -0700 (PDT)
Received: from localhost (85.64.140.6.dynamic.barak-online.net. [85.64.140.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6a58sm214392166b.17.2024.08.16.00.02.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2024 00:02:20 -0700 (PDT)
From: Eli Billauer <eli.billauer@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 1/2] char: xillybus: Refine workqueue handling
Date: Fri, 16 Aug 2024 10:01:59 +0300
Message-Id: <20240816070200.50695-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

As the wakeup work item now runs on a separate workqueue, it needs to be
flushed separately along with flushing the device's workqueue.

Also, move the destroy_workqueue() call to the end of the exit method,
so that deinitialization is done in the opposite order of
initialization.

Fixes: ccbde4b128ef ("char: xillybus: Don't destroy workqueue from work item running on it")
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 drivers/char/xillybus/xillyusb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 33ca0f4af390..e12d359194f8 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -2093,9 +2093,11 @@ static int xillyusb_discovery(struct usb_interface *interface)
 	 * just after responding with the IDT, there is no reason for any
 	 * work item to be running now. To be sure that xdev->channels
 	 * is updated on anything that might run in parallel, flush the
-	 * workqueue, which rarely does anything.
+	 * device's workqueue and the wakeup work item. This rarely
+	 * does anything.
 	 */
 	flush_workqueue(xdev->workq);
+	flush_work(&xdev->wakeup_workitem);
 
 	xdev->num_channels = num_channels;
 
@@ -2274,9 +2276,9 @@ static int __init xillyusb_init(void)
 
 static void __exit xillyusb_exit(void)
 {
-	destroy_workqueue(wakeup_wq);
-
 	usb_deregister(&xillyusb_driver);
+
+	destroy_workqueue(wakeup_wq);
 }
 
 module_init(xillyusb_init);
-- 
2.17.1


