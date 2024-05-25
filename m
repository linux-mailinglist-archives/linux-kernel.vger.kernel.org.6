Return-Path: <linux-kernel+bounces-189292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F898CEE10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 08:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290AAB20F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9691E57B;
	Sat, 25 May 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkJfagWM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF5B65C;
	Sat, 25 May 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716619036; cv=none; b=UUIrRMTQnb+B8vWyDqtTBmm+JDyDq+p+OV5dAFAgubaaQuP1VcgLiPl1SmSmK6EayQuRnnlpe7DfodzVpuTZkw5d9KeoYkgcISd7iD4kHiRl4KNzt2ZU3dvV4EH9EyCiDZ1D2X9qDBdfZjHZKqj7Iy9bR7SVisThB8Ie5uuRkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716619036; c=relaxed/simple;
	bh=IaBN4OegfEqGp4LXl0T6T/bRkjklgczJbY0XyG5aKkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=so6uyux/l27H2vUxbwJD5TnRTLGI/0NLaYcyBBPw6/wudEfKaCdHETyWHGBLDm2J3QGxfbqbyQt5Kx2saaHxBCi1zvTsXmQ8Y+umOr15pvwccO+ZNmGc6d5fFJr8MN+PY9RuawQfbR/KXo84JkJYf+AD96wstDILcv/F7d/WLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkJfagWM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f3469382f2so18333885ad.0;
        Fri, 24 May 2024 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716619034; x=1717223834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snFoe0q0ALLzJ5j768mscpErlOXOCkjNvxMBdv946eQ=;
        b=hkJfagWM1LlI3LsIfkRyl1j/94PtWEYD3XiLMuhMFKh/sxng36Js1utZzsocLrBRDk
         PIUNh9C4mMEdneZYfO2HBXVo5tKDnvqlFexJapaJC+sCziKbMJeroHJJepGIw63BBW/o
         FZZZYpOoY8bPTBn5FWQJWyAJbw0K2eMFIgUgmAozka48W4yPoXtyf047sCpKs3g/nubY
         Gxve79IxU4+yFmYJcj/dNT43QqCti3jkYplGhAQ2VmAc6MXU7KQZp6EKgb2XQx4B65Tf
         MadkWUmEiumk+BUPUdhyZFzZO9uXpqo3FkVi1aWEtDoKwIS6XOIuevGWvNCjFNWtoMGL
         0v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716619034; x=1717223834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snFoe0q0ALLzJ5j768mscpErlOXOCkjNvxMBdv946eQ=;
        b=wfHM4FUTAeaWSfeUzFI0eLZLq/wzkiSiHZcqSIziT6+eJpgeWuqOoe7OMmcEB4EGgM
         EFGYF5aT3qPsGK0YmJPK0VX97EUuMSK1lzqODenCHlz9lId1+WDM+4PXl5ouL0gtexb3
         j1+axJCDvNjzfgu3i56R1KXFIMVgHyBJayCga5PfVvMn4AZ/SHM3ZOidyqWsEiXzioes
         RoE0dPOJJetMoA9U+0MwQYabWw41tr0+xYYM4C1dtvta/w5lhCFXgsTrxoz5pOk3XET8
         edjb+feduANZ9ECS5WgExeyyWkg/nPFOPEPPQ3uRnSxFQMzZDNAnmvtWhnpW96oZbUt/
         ytQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9d185PO5bVAX7mK8r6d5MvKsMh8Zg8xihFjXQNOlVbzMmjX5LKl3ME5Aq8E+IeGbFlGAdjhAyOIITkjZHGfM+FSDTbtn1WR5sRg/u
X-Gm-Message-State: AOJu0Yw7r5bi2hnJI0QQvD6rquffBnv/vfSL02Bjeiq7wW4NF4k6Nf5u
	1G32s29PdBNeTpIXj9kcUR7eUY7leaKQRl/o4oiD1+Pijn9B58rV
X-Google-Smtp-Source: AGHT+IFKAgrY1NtB8X5hqMQNIcotZoxSJSjwzIEdgyswHO6q5fcrXCvWclqe4kVGQTOTWJxhG5o6ow==
X-Received: by 2002:a17:902:e5cf:b0:1f4:64d6:91b2 with SMTP id d9443c01a7336-1f464d6936bmr19294875ad.22.1716619034006;
        Fri, 24 May 2024 23:37:14 -0700 (PDT)
Received: from velvet.. ([111.42.148.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f471edd1a5sm2621275ad.184.2024.05.24.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 23:37:13 -0700 (PDT)
From: Shichao Lai <shichaorai@gmail.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	oneukum@suse.com
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Shichao Lai <shichaorai@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH v4] usb-storage: Check whether the media is initialized successfully
Date: Sat, 25 May 2024 14:36:53 +0800
Message-Id: <20240525063653.2331587-1-shichaorai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The member "uzonesize" of struct alauda_info will remain 0
if alauda_init_media() fails, potentially causing divide errors
in alauda_read_data() and alauda_write_lba().
- Add a member "initialized" to struct alauda_info as a symbol
  for media initialization.
- Change a condition in alauda_check_media() to ensure the
  first initialization.
- Add an error check for the return value of alauda_init_media().

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Suggested-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
Changes since v1:
- Check the initialization of alauda_check_media() 
  which is the root cause.

 drivers/usb/storage/alauda.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..ddf0da203481 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -105,6 +105,8 @@ struct alauda_info {
 	unsigned char sense_key;
 	unsigned long sense_asc;	/* additional sense code */
 	unsigned long sense_ascq;	/* additional sense code qualifier */
+
+	bool initialized;           /* true if the media is initialized */
 };
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
@@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
 	}
 
 	/* Check for media change */
-	if (status[0] & 0x08) {
+	if (status[0] & 0x08 || !info->initialized) {
 		usb_stor_dbg(us, "Media change detected\n");
 		alauda_free_maps(&MEDIA_INFO(us));
-		alauda_init_media(us);
-
+		rc = alauda_init_media(us);
+		if (rc == USB_STOR_TRANSPORT_GOOD)
+			info->initialized = true;
 		info->sense_key = UNIT_ATTENTION;
 		info->sense_asc = 0x28;
 		info->sense_ascq = 0x00;
@@ -1120,6 +1123,7 @@ static int init_alauda(struct us_data *us)
 	info->wr_ep = usb_sndbulkpipe(us->pusb_dev,
 		altsetting->endpoint[0].desc.bEndpointAddress
 		& USB_ENDPOINT_NUMBER_MASK);
+	info->initialized = false;
 
 	return 0;
 }
-- 
2.34.1


