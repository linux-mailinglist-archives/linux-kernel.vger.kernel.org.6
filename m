Return-Path: <linux-kernel+bounces-189376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1538CEF3D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B771F21527
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7C4DA13;
	Sat, 25 May 2024 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egCEt90k"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1793BBD9;
	Sat, 25 May 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716646246; cv=none; b=Onui221HXjbbKaP/7ResDAf5D/MxjvB8IROAK0jC8hiTvPqew+Y2ruGk27LX93Zp9SIp/ejZq1VubrapPrSOmU5znKav9YSjNlLNdfLGEKN4qu13qJlXz/mt2iDeNw3iMNNX8bTiurHAzeDFdAjFRB3T+gcpqaxGk5OFc6BNYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716646246; c=relaxed/simple;
	bh=5tPLxvC76dR1u+c6dlH6TKfwLycW990n5KJ1pd7w9Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=olkJJBKYzSGQ+SV+2H5h1Zes3s6uJex7UkMxZXQ3fn5DpwhgwYMWDv55g0gJhNvYEZr2Pc78AGhb0n912lsK2tieAaqCvMi/wEU/AqL/cw//hGXVMrMHmiKGKcPz2jmIYAB+c7LXkL70IBgB4bJQeF1wkcnAs6mghV0jfFd5D2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egCEt90k; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6818e31e5baso1484195a12.1;
        Sat, 25 May 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716646244; x=1717251044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wldvmv7DWJTk5N8y48gKwHLB5rZ3GSfo3AcMZE5/l5w=;
        b=egCEt90kkAjJELLhaejDK1OslC4XLYMhrTPDA5wOD3YxZ1AarZzuFQdOgUF+gy/qNV
         XPiIWpz2vJ55k3uMGB4NwIxooVZ0AwWjBXI1Pe6p6ER27yVdVPvLcD3hH/EhdcvUBuL1
         wwjxqK23peBaN+RQaiVViYfBtKHH54leQWtdPyHwNS1as0R7N2+EaA/qeZWa9MBj3hOU
         nT/Hwf3aj/rRWFZh1BFEisrPILI8hYJKGCp/XdM2glEi33E1R1cvBDxXZcqbNbaKpmxc
         EGPTrCFMqIxrPH+RaRUfZ67yoati7knnrkxiHoHl4R407knNZ8FEtzF7jG31WZJQ1X/9
         iqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716646244; x=1717251044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wldvmv7DWJTk5N8y48gKwHLB5rZ3GSfo3AcMZE5/l5w=;
        b=p75J9nc/EDk/5ssd0O4YWj3DKOYu4CbBhDQMb7Eci5QDGBfcAX71de2yWZTSsJr8Hl
         PNhDXyLiCE4/pdk4OxIHgmhNbMeQ8hJbwep7CRIGnsvNiwMzfSD2exbnxQBPOwAWEoge
         3iPCpXtTHiy4DR6wQZW/LCOGfLVe2ugs1Exxgo1QKcgrXsLvVPJ/UfBaF8hH6a0G1BWz
         rn15vWM/H6wxqilng6R/z+F8LJ6e10r9V3yJGilbiWn/nGW8vmO6gCZ2QEKbkmUN4CSn
         f/oFxIhykyEwGX2psB1bnvSDW4IFL3W3bvp9RLXG4zpzqxNZJAImjRyMDjxNQp30x3Ol
         mzIA==
X-Forwarded-Encrypted: i=1; AJvYcCVjO/QZrN0hIC6Hea/ojE2/Qfv8XPwVtKmsLdTS8zFZRUUf/0/cMnyTvxu12X22qhYjo5QmAkp22R29vrYKZXentyksV8NPEJgToKTdNm7tapYGnyUNKWHRSMrCLpvxRUE4hC4YYrWo
X-Gm-Message-State: AOJu0Yxcfq9KZvD2vmrxUdPAXMBHr24NDT6Ya04dGjQ7z2dibWCiWU+e
	ClScGZOyJYIAVfFXfEP9Z9p3ghBym8g9nPOt2EIKMXZv0CBJJhwuBOklZCvd
X-Google-Smtp-Source: AGHT+IEg8rMeGLzZKcheJdBT8ESn2j0S+pLTTLWZAi0/jjq6B3TRoOdqPmTap5IKJupvkhMftX4INg==
X-Received: by 2002:a17:90b:4393:b0:2bf:7ccb:b8c0 with SMTP id 98e67ed59e1d1-2bf7ccbbec5mr3416578a91.26.1716646244073;
        Sat, 25 May 2024 07:10:44 -0700 (PDT)
Received: from velvet.. ([111.42.148.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bde078426bsm3404256a91.0.2024.05.25.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 07:10:43 -0700 (PDT)
From: Shichao Lai <shichaorai@gmail.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: oneukum@suse.com,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Shichao Lai <shichaorai@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH v5] usb-storage: Check whether the media is initialized successfully
Date: Sat, 25 May 2024 22:10:20 +0800
Message-Id: <20240525141020.2520942-1-shichaorai@gmail.com>
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
- Add a member "media_initialized" to struct alauda_info.
- Change a condition in alauda_check_media() to ensure the
  first initialization.
- Add an error check for the return value of alauda_init_media().

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
Changes since v1:
- Check the initialization of alauda_check_media()
  which is the root cause.

 drivers/usb/storage/alauda.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..40d34cc28344 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -105,6 +105,8 @@ struct alauda_info {
 	unsigned char sense_key;
 	unsigned long sense_asc;	/* additional sense code */
 	unsigned long sense_ascq;	/* additional sense code qualifier */
+
+	bool media_initialized;
 };
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
@@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
 	}
 
 	/* Check for media change */
-	if (status[0] & 0x08) {
+	if (status[0] & 0x08 || !info->media_initialized) {
 		usb_stor_dbg(us, "Media change detected\n");
 		alauda_free_maps(&MEDIA_INFO(us));
-		alauda_init_media(us);
-
+		rc = alauda_init_media(us);
+		if (rc == USB_STOR_TRANSPORT_GOOD)
+			info->media_initialized = true;
 		info->sense_key = UNIT_ATTENTION;
 		info->sense_asc = 0x28;
 		info->sense_ascq = 0x00;
-- 
2.34.1


