Return-Path: <linux-kernel+bounces-189583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3A8CF262
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 03:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7711C20A04
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F410FF;
	Sun, 26 May 2024 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4U+w72A"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65A79C0;
	Sun, 26 May 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716686987; cv=none; b=s2IwoC/PVwVjQq1oSh2qsacuPtdZV2e11UJyMyDyvpaRo17qHL4zZGEcFYzjgLMJ5wFbH9TB5F9JZwEE0EsIuE9O2f9fa0TXxc8WOE1iiUE8goW5tbdssmj6s1gJhsAKhmlatrXVsF3IC/nJ8gUP9hAmwd1ma2dM3993wGp3boc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716686987; c=relaxed/simple;
	bh=bTy4rHKWsDHxnt4C0C4Rpj9eCADgsmB6J6v0c5MyoUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lq05dBgrcI5TokK81dATml6Zw9TiQ4IJVkVcak/MiY99SwESwizU3AYed8O7bzIfg/e6WFyhyQQ5rh3Hb1V6u/X73OFFnR9nZ0N2hqEUQqi4GsXzFYtK3n7EPoScHmZ6+Kd8nQwpJM3QLdvmHbovNNokdAZrqNja+U/vSBOUfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4U+w72A; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-681907af4e7so1592734a12.1;
        Sat, 25 May 2024 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716686985; x=1717291785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u07Iey81j3k5fLr1Slpz2mVuu45UdaoKvFPM3aZm1t0=;
        b=g4U+w72AYr9cSCMLwEq8euzsQ8PUg4LY7rAW0Qlf59ks5HGbf6OVmykg2J0VtulRd6
         u39XJQSlP6ekvXfSfGomilXMGDt30ETJ+dBhYnVKQKUyUwVB+bR2Xi5BDLteGNAQONrG
         YCNJUhVrD3iy3IM38wJx4Q7gY9qz8WuCJbFA0lbS2HrzJ/6ix6eMalJrZKor1qJqt2Ju
         juFKlcJ3IvKzLUk3tc51B6S0WogJQ1raXmBk5GJjhmgsw/hulX8hzG7HUWZTO/LVu2ma
         gkbp2Zxey6gxMfbJz6SZb3NrtyVHzWNd261bqxvBzmF10ROYJTctGPsuaZ4PIAwj9rmm
         YumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716686985; x=1717291785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u07Iey81j3k5fLr1Slpz2mVuu45UdaoKvFPM3aZm1t0=;
        b=cMQcilWYTWwNRJcT3SPgKonXjBNCDXMCk3Z6GwOeZED9gCj4Rvuv6lC2zAoNrp0Xc+
         kICDo3f8ErubXSVa1aHXHXt8PkDZ5mrZL3GA+mPWo5jrpMpq5bnyVO1eR8SGVfF/pxP2
         fgR/yoGgy4wIrrAIoOYdqSJhi2t/Kl2DyNxhpJ1xaMjQQ22izPRT7CE9IS6x8Ge6MPeW
         jYZRI0PvXvmqnBXg8sb8Qna2F4jKBTEYXnJvgievpdJna5MRaOHPKORxWqwl+/5MG/zx
         7C++KlLEOr188Is6r4UGWiN1sABpvFygusuJ+DCCQD2R3AABoFhsjy56ptsz1zQk08kL
         nQeA==
X-Forwarded-Encrypted: i=1; AJvYcCWlubc4i2iyVSil0uNqw7SPhgDmk6X13vy2liAp+CHcKguntgvTNePDCXT9COY9gmj2kkhU3hoDyYm29dt5jKXd7KWMe0+kUMCFZJZpJAAKNyXuUYOfvV4+y5layzvouIluMZhLHCRo
X-Gm-Message-State: AOJu0Yym/UlRIBwfy/82AiMBodsE1z1lJsJe0hkxtgoTsEQeJRR7onYq
	a9iEHCOUe4TfDaaYVjeZoI2K2f1V4c+h/1nsOm8pGgltXvsN0M+3
X-Google-Smtp-Source: AGHT+IG5H2A/t8sX5Ms0sIT+n4AmmQIpy5dhROCHQzOn8UTrX7OvQ49s52FnFHeI8dDjTcUPnGL/zA==
X-Received: by 2002:a17:902:e995:b0:1f3:50e7:36db with SMTP id d9443c01a7336-1f4498ec1ebmr49195605ad.48.1716686984752;
        Sat, 25 May 2024 18:29:44 -0700 (PDT)
Received: from velvet.. ([111.42.148.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f481de3d78sm4156025ad.75.2024.05.25.18.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 18:29:44 -0700 (PDT)
From: Shichao Lai <shichaorai@gmail.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	Markus.Elfring@web.de
Cc: oneukum@suse.com,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Shichao Lai <shichaorai@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH v6] usb-storage: alauda: Check whether the media is initialized
Date: Sun, 26 May 2024 09:27:45 +0800
Message-Id: <20240526012745.2852061-1-shichaorai@gmail.com>
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

Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
Changes since v5:
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


