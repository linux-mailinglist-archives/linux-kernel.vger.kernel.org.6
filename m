Return-Path: <linux-kernel+bounces-187404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B88CD150
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621F528345B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047471487CB;
	Thu, 23 May 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NycWAibO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19214BA2F;
	Thu, 23 May 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464078; cv=none; b=kbaNwJwyeskX+EhpjZtFyU9AMpm/0huIJ3WCZ3GS6M/rcaYo9QNNS41Ooic+VPDGy8a2taq5c0BbiRdZtEIAYiSHWC/Mx3K3V6wRRGEa1/IlvGibKqnnuub9lJ+L7xNEQLzh0nSmGH8buKwoNsSUugU4LTNaYcCnew4tI+w8/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464078; c=relaxed/simple;
	bh=CeK6Tivq/xGw727Ec9ebA2/E9iSfftkX0NerKQy2wQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TUdHUL6MrSscSFIyNvmosysnHBH+rdUIqUSIqTUpqKa85KsYGfpvXu/9EWKISdPEGicS0L2MnjAaaA1/YuV+zAXlIm/d1aI+w1IV97Zurfl6NqSGi+p1w1YCf6tadNKhoDaM/Pjz2cvbsOPS6nMZy3oR5mR3cVP6pfpAlQSO3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NycWAibO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed96772f92so19999785ad.0;
        Thu, 23 May 2024 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716464076; x=1717068876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eshNdi8MhibtA7UrHJyZzzh5soo9ttxdAWbEOJelcIk=;
        b=NycWAibOW69+jxe0TTJkC34lE2CMXuOM5SQK6LX9vKk4Y1Nm0slBLZHO1UnS+sq7++
         afSFbOaiHo92BsFebsigFLu/bSHrWELXoaKUkIE5qMigXYitRQIt3D+CmlJVXr4lfTRl
         FcMgDHeU0HCryg7dEwd1MeSi9zC/BC7qJ0LjXSz6XWQIfAKsylAWh+w5Lr+SbOp+tDx2
         1yAgGRgzmrc9Vlkup5qcjS900bErUiWdgZKZu3Q03G1STlHi2HlRa6r1LH9TWB7K8c77
         s97Tyj27aSYigXeRBv4a72cLXMzOVlr3qaLZeT59tEOcUkLuJWXN/XUN4vcFljyVp4rm
         OaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716464076; x=1717068876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eshNdi8MhibtA7UrHJyZzzh5soo9ttxdAWbEOJelcIk=;
        b=Rcmro49aCSn/OWg8cuEzlees0GSdY7yx5Eo2Q8zdTMWtBxKj7mWHdSWw1ANZgtc6lC
         OktV6/3Qxfm/0iTInKruxPc7OvkaP6URYvHnKkb7Cg524UcWbmycXiG9cWvRTyXGlBrW
         ZQ2gy3ieXrS3yUDGiHAasHTMIzd2+NwOx7nXh37oe533fg3nF6D9YmuWSk17gHsq263T
         zk8gdZyibJgDeTKiAKNJlbG/yNivHDP4x2e2g2q4qLcC+bM32pRRDHPTGR4L6djvYbG1
         ta3KmavyhLSnsmbG2BF0ZAdZNvfp0q3IqHMJs1zjN4qba0MCKsdUaHjmOGbTVAkpunPT
         9w1g==
X-Forwarded-Encrypted: i=1; AJvYcCVqqMmpadv0bot8r3qlnxwHgjv7REZfT6luL3MKNX81TpiAhWyAsJ/B00aL9nZLv2wKPC5KxgdqcIZcBztXg4S757I0iV0jS8exQdyn
X-Gm-Message-State: AOJu0Yx7zfNZVJx9hLEKRumpqBumrGdDkvWfRGL571+UF00sROownyuh
	CXk4bJuklg1UOtlHN0lEEBzFNoHqvQVJT+AJoXeBGO/G1dfONFJI
X-Google-Smtp-Source: AGHT+IE8SOxrwx1ljyyMEm028rnBv7WzfSsEYDiOEUuOm+609SUiBrz6bgQ6DnjQC8IeJrYO2te8jA==
X-Received: by 2002:a17:903:950:b0:1eb:144f:63b7 with SMTP id d9443c01a7336-1f31c9e173bmr56580715ad.56.1716464076410;
        Thu, 23 May 2024 04:34:36 -0700 (PDT)
Received: from velvet.. ([111.42.148.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0958fd757sm146846395ad.45.2024.05.23.04.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:34:36 -0700 (PDT)
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
Subject: [PATCH v2] usb-storage: Check whether divisor is non-zero before division
Date: Thu, 23 May 2024 19:34:10 +0800
Message-Id: <20240523113410.983875-1-shichaorai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since uzonesize may be zero, so judgements for non-zero
are nessesary in both place.

Changes since v1:
- Add one more check in alauda_write_lba().
- Move check ahead of loop in alauda_read_data().

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
 drivers/usb/storage/alauda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..17c73acd3b02 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -813,6 +813,8 @@ static int alauda_write_lba(struct us_data *us, u16 lba,
 	unsigned char ecc[3];
 	int i, result;
 	unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
+	if (!uzonesize)
+		return USB_STOR_TRANSPORT_ERROR;
 	unsigned int zonesize = MEDIA_INFO(us).zonesize;
 	unsigned int pagesize = MEDIA_INFO(us).pagesize;
 	unsigned int blocksize = MEDIA_INFO(us).blocksize;
@@ -921,6 +923,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
 	unsigned int blocksize = MEDIA_INFO(us).blocksize;
 	unsigned int pagesize = MEDIA_INFO(us).pagesize;
 	unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
+	if (!uzonesize)
+		return USB_STOR_TRANSPORT_ERROR;
 	struct scatterlist *sg;
 	int result;
 
-- 
2.34.1


