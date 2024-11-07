Return-Path: <linux-kernel+bounces-399165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9E9BFBC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D8C283A71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115747F53;
	Thu,  7 Nov 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFU7HAVw"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0022338;
	Thu,  7 Nov 2024 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943542; cv=none; b=aGjnoR0AbApZ77PvQ89j2Pa0M3rQNqBN4SVHVS12reGoZ2phbEv1KPvXN2RmO5ezXXIDv8ugX4PIogmeFKCAfMdHZgwFnqGeVH9q77mIsTJc9mIbMbuF3Jsry5qjadTfAFlZdtZQ4w11X8KDun+WYTftKWsIzlccddltTKxEQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943542; c=relaxed/simple;
	bh=qcmO3butkyf9S9hDvHNO6PAqc4S2Y1RMp5t9xb/uy+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tiYWp6g5yOj0rZFogIQYoOkXhmwu5p3X+NcPrNLCioj468KGZbrvotsXCja7KUihjYt3VPbIGpTxOx4GS7WrLQj1gJbVyptf0si6j2X75RH+OvUpY8t7CDETC7Gvntz77YM2I0gnAKiyA3UVwQLQ74/EML268WaLZj9IGPNdMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFU7HAVw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21145812538so4229465ad.0;
        Wed, 06 Nov 2024 17:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730943541; x=1731548341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdhiRbRVANeH5DxJ2qjyPpR9WFDsKtpXSkfdoqxRRKQ=;
        b=XFU7HAVwikokTzjOn9GVJvNWF1zl9ql/i6E761SYBvUiw58YdlOj98A65Ka5KS4hSk
         /rwXa1Y1OxWRgtkRTBd7F2yZidsQbGRzYFPYM1PO8lFF3zkji4efTYHDosS2eJmpeBEp
         gwy+T17wn3dav61qUUl04os/R69hxZxLjaMOfgqcLO03NFzPHcZkhAB2ONVjrniPikPs
         wyiAwWJQSvB5J3SeNqS3+5crPetTtSJEmAIMuYe/zf9+2dpY8vVnfk/w9JDgk/ElL0md
         gfYnPKKdRpBpRn41tltx+P7AalC0NSKA86RLZs0CLetezkBMOZZ4KGLBDym/+JWFpJpW
         JNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730943541; x=1731548341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdhiRbRVANeH5DxJ2qjyPpR9WFDsKtpXSkfdoqxRRKQ=;
        b=c33Rdk+MzYV0ZPlCY2Hs4wbi79JuatwL1NWuBS8KH/9Jaym42r4ypnZCZakY3WHo97
         SvqsF6grvA+C1XO1uUmJTkVShBm0OR6dfK4cInRn0rCzH1Hh0MOj5+hzs/QAS68J93KB
         I6ccwjoll9hsoZnj/8FPdteBULrGBivQRh9G657lXgc/YFtsvCkgsl8t+avNwHaOW0x1
         W69bO/Ggl5lLmjYtsEUOadT76LpYosDlpkXaUJvYulSc5Hkqu9GqSlFcJKfPucRJYkpR
         6B5wudPa2E1N3Y1LItL51Xwqh6QEkrJlanMj86/LJOq0QS8KBfjr/AMlFrO4FHztBl4b
         W+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWYkKSG8Z4CRPe7qQ4qSjwYE2W3CzVseBMn04dWoaPX/NAv4MtUteh4u1C6m5EDV+62Yp6TRhkh7ZQ=@vger.kernel.org, AJvYcCX0Txh5BdZdRTq0+flCvlb0QYZ1I0e2vkA+BQh1Uz+r4muKJJWoD6w54QEBkNuooCUmAQ0kMrvw+MgG+MKR@vger.kernel.org, AJvYcCXXHa6nj+V4d8eFQNGRYRJ/Y8WPtBbTsmTUVqoKiXvjqEKLlQqaU+EeEHVFR6Wfpqc+TvgbmxDaEVhX+Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IcXUybfWqAJI/n79i8Ig80gkDNBYdDWGlKLy/U7qTDCfFUHR
	EeCou8KsyT6dvOlKOyPIrbsvSyMoMGnFwnt+TKQti8mBdIgokJFt
X-Google-Smtp-Source: AGHT+IHuTqOh4eTJddN7RSk1s0qxdkb7hTuRGT/uf32xnm0L9Kp3Vgyr8KgWO9NbuFzi+vHhn7dc3Q==
X-Received: by 2002:a17:903:230e:b0:20c:bf43:938e with SMTP id d9443c01a7336-210c68d3ee4mr597180145ad.15.1730943540680;
        Wed, 06 Nov 2024 17:39:00 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41890sm1172905ad.147.2024.11.06.17.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 17:39:00 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH] hwmon: Documentation: Fix grammar in fan speed trip points explanation
Date: Wed,  6 Nov 2024 18:38:49 -0700
Message-Id: <20241107013849.47833-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several grammatical issues in the fan speed trip points documentation:
- Replace awkward "which % the fan should run at at" construction with
 clearer "that specify the percentage at which"
- Fix incorrect "is chip depended" to "are chip dependent" for correct
 verb agreement and adjective form
- Improve readability by reorganizing first sentence and separating the
 complex explanation into simpler parts
- Add hyphen before "see" to improve readability
- Remove redundant "at" in temperature description

No functional changes, documentation only.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/hwmon/f71882fg.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/f71882fg.rst b/Documentation/hwmon/f71882fg.rst
index 38e30fbd4806..53d32bf06b70 100644
--- a/Documentation/hwmon/f71882fg.rst
+++ b/Documentation/hwmon/f71882fg.rst
@@ -178,10 +178,11 @@ Writing an unsupported mode will result in an invalid parameter error.
   available on the F71858FG / F8000 if the fan channel is in RPM mode.
 
 * 2: Normal auto mode
-  You can define a number of temperature/fan speed trip points, which % the
-  fan should run at at this temp and which temp a fan should follow using the
-  standard sysfs interface. The number and type of trip points is chip
-  depended, see which files are available in sysfs.
+  You can define a number of temperature/fan speed trip points that specify
+  the percentage at which the fan should run at each temperature, and which
+  temperature sensor a fan should follow, using the standard sysfs interface.
+  The number and type of trip points are chip dependent - see the available
+  files in sysfs.
   Fan/PWM channel 3 of the F8000 is always in this mode!
 
 * 3: Thermostat mode (Only available on the F8000 when in duty cycle mode)
-- 
2.37.3


