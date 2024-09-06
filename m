Return-Path: <linux-kernel+bounces-318540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66A96EF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B6C1C23A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614C1C7B9D;
	Fri,  6 Sep 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OXj/OZA6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71551C86EE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615276; cv=none; b=HMEQogDWgMihS9yn0FA2IH4TYLyerOWhwvxp0Atg1c2SAqUCZWuwpUTC6fAEdp8fm3etttMBhFFsl81nlbG0VMcPFFKdg7fXMahx1cdzyYBcnZp3M6KjuArkyHC8MLjgKawObe2qMumSQKk25FkOq0y7WjezqXHhhQfvdvGaHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615276; c=relaxed/simple;
	bh=LAhSTPhTR1kPbNBM9J93kO3uduBEsaKNKcW2jIBoyfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzSErp4vCcqvXwFNOFEShrJ3IJdY3I8PwPRL8lGKJ7mccjXZgWEB8xIaDPhSQdaGSDxBrz8wVW4NK4j6uguqPEglO5CXIsMkjGiliZhdDQMEO+nv+PvYrzvOQl+ZAokpW5kl5xtTEZ+aAs6CwMWjPGKgVe5ukJz2TvlfwipRGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OXj/OZA6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c7d14191so1578720f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725615271; x=1726220071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5cGUBAD/3eZ2qDRIuYLdtjOoYZxul0t5wVc0LvHf48=;
        b=OXj/OZA61Re5MU3a66I9D0z6xGYK1hPC3pdwerWjll5XEtip69OPUDxmPqTQHVWcxD
         lKYrSVwPf8OkanYwdbb5iDNRv2qU/WdS8K0bHW5KF/ZYJIikIRQ3wfaePJXa2N5eCKpG
         EUAQ+3ub/8yTgEJ6zvD36izkkQIu9t+5blrdWhZLqtcoGXlbbABl7jjlYQmPWKp20Ty2
         68mJd5bOkcmEdvfIYOGTF010vdUtdF6U5b/g9xV2utJaRJtPxJvWAKoXJKhC2yBbw+Pt
         hj62pnXZBSw9dOudRpIkYR+c/z4N+KxJzLQ2JNzRA05GMV1pIXN2W37RuDIRgDbmZEGQ
         R5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725615271; x=1726220071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5cGUBAD/3eZ2qDRIuYLdtjOoYZxul0t5wVc0LvHf48=;
        b=KVNgb1SPg/+1CKwa7KxP2id2/d2SPv0biDWS2ovTG9looFE7aY6PGygUu2+OnoGo/P
         AWx4EKIglOlzTx4hdcDyJa3heQTxNdVWVMX8bANJgmmyEdHeJa3Pm+6oUW9v1atVTouc
         OyTlZjdY8okDJNk3TQfcnXLM+SukUfTBBsM8MrrtHwqGr0kYXlW5lC8L+SnFe2QjRmn2
         MiHlLGGgrBCSD6Z2rywcHFBR1X550bFeG99YKnsyI/S97CczxU/TPLT3pje/oNTo8vMr
         daJSArWdZIrXNQ89FMZQnsYCNXFipbaNGa0rZrEJ1paEeImNaHU4DLeWB7IzzZ5Nzznu
         KvgA==
X-Forwarded-Encrypted: i=1; AJvYcCUt3GCCPPwS6zi/xp6qvx8qdcMIUsZkhRkhtoUxnU/ghxcuKwMEfciHujkNyjGDQg2FXM9Gol5u5DHyrVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMg9P+npCMnoPXPVUNl6DjsQ80jvCCGdZ0ynwLfSje45ud9LQF
	ufgQ+iJbEzf2uzM8vJl4saw67VbOVrtCyMI27tX1xVnQVOv1HAqWvOFj8oOml8E=
X-Google-Smtp-Source: AGHT+IHPwi4fiSVRQwZiSneJMvLj61lfvtYJZ9hCg6GS9aV5QZX6/0gc6chMfY2bYol3699nLIhwlw==
X-Received: by 2002:a5d:53d1:0:b0:374:b9ca:f1e8 with SMTP id ffacd0b85a97d-3779b847b95mr5575492f8f.20.1725615270476;
        Fri, 06 Sep 2024 02:34:30 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:4e33:801c:cee0:ee57])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749ee4a5edsm21412206f8f.1.2024.09.06.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:34:30 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] ALSA: IEC958 definition for consumer status channel update
Date: Fri,  6 Sep 2024 11:34:16 +0200
Message-ID: <20240906093422.2976550-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add 128kHz, 352.4kHz, 384kHz and 705.6kHz.
These definitions have been found working on eARC using a Murideo
Seven Generator.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi,

 As explained in the commit description, I don't a have strong references
 to back the new values up. I've found them through testing.

 The value must exist somehow since the related sample rates are allowed
 over an IEC958 link. It would be better to get confirmation from the
 actual specification rather than just rely on testing.

 I don't mind if this does not get applied. I just want to make the
 data public, giving others the possibility to confirm or deny it.

 include/sound/asoundef.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
index 9fdeac19dadb..09b2c3dffb30 100644
--- a/include/sound/asoundef.h
+++ b/include/sound/asoundef.h
@@ -110,18 +110,22 @@
 #define IEC958_AES2_CON_SOURCE_UNSPEC	(0<<0)	/* unspecified */
 #define IEC958_AES2_CON_CHANNEL		(15<<4)	/* mask - channel number */
 #define IEC958_AES2_CON_CHANNEL_UNSPEC	(0<<4)	/* unspecified */
-#define IEC958_AES3_CON_FS		(15<<0)	/* mask - sample frequency */
+#define IEC958_AES3_CON_FS		((1<<7) | (15<<0)) /* mask - sample frequency */
 #define IEC958_AES3_CON_FS_44100	(0<<0)	/* 44.1kHz */
 #define IEC958_AES3_CON_FS_NOTID	(1<<0)	/* non indicated */
 #define IEC958_AES3_CON_FS_48000	(2<<0)	/* 48kHz */
 #define IEC958_AES3_CON_FS_32000	(3<<0)	/* 32kHz */
 #define IEC958_AES3_CON_FS_22050	(4<<0)	/* 22.05kHz */
+#define IEC958_AES3_CON_FS_384000	(5<<0)	/* 384kHz */
 #define IEC958_AES3_CON_FS_24000	(6<<0)	/* 24kHz */
 #define IEC958_AES3_CON_FS_88200	(8<<0)	/* 88.2kHz */
 #define IEC958_AES3_CON_FS_768000	(9<<0)	/* 768kHz */
 #define IEC958_AES3_CON_FS_96000	(10<<0)	/* 96kHz */
 #define IEC958_AES3_CON_FS_176400	(12<<0)	/* 176.4kHz */
+#define IEC958_AES3_CON_FS_352400	(13<<0) /* 352.4kHz */
 #define IEC958_AES3_CON_FS_192000	(14<<0)	/* 192kHz */
+#define IEC958_AES3_CON_FS_128000	((1<<7) | (11<<0)) /* 128kHz */
+#define IEC958_AES3_CON_FS_705600	((1<<7) | (13<<0)) /* 705.6kHz */
 #define IEC958_AES3_CON_CLOCK		(3<<4)	/* mask - clock accuracy */
 #define IEC958_AES3_CON_CLOCK_1000PPM	(0<<4)	/* 1000 ppm */
 #define IEC958_AES3_CON_CLOCK_50PPM	(1<<4)	/* 50 ppm */
-- 
2.45.2


