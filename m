Return-Path: <linux-kernel+bounces-233865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B091BE78
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762FE1C230F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD1158849;
	Fri, 28 Jun 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RQBHqawW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2D1BF37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577482; cv=none; b=mY1vnfXA8mof9PykRkwo9t3YjNGiwYTjQ2nyl8K9OK4bOZqnPByqeCSdfw0X+IRCbbnkJ7tSN40n0a/YwuXQH5FY4luUgyddLmJdZFQgp+INlJDqMhWhhT+cwwsTY92XKcmMzMMw+FkdFjVtQTBpATbGnex5tumhWeOgTouJz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577482; c=relaxed/simple;
	bh=3ts2gQuK9q5ifIXWwqQcZskJHVRf4IEqgfVfvltT1No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHvMLnQTX8xpPhGtIlOoVf4Fv2OKDU0/Cf4mJ8MD13YhwKL3Gksr67brRow8+IvKxpu9A3qYDIyGS3FeDnukiJNL2a/tzkA5HvQOa2R/eW7eX609TNOjWaCw3sf51nR7UL31Kf20+gVlct5VuqI1ipU/PTSkyLv1vRuHVgw4l98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RQBHqawW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so544199e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719577478; x=1720182278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8ilixuBZasrX5oPlMOZzvZHztGbrS/qDv+nWurvrjo=;
        b=RQBHqawWaRMbZ3L4RJaibrt2prb/8YtYuKsw1ExyOjwIKHdiOHkDmrhc/gLM7NtHJ2
         M/wWBm3cAwZMruEktftYWVmFgvNdJMKFDHnsFBlUa6YeQk1RxfCiQ6e8zEAoe0kMGZuB
         g+CkJa4K8KWjx0aA1j56jlwpJ/yTeHRbfZmDhdpDcImR6kCaSZsltviGJyu8IYuHWaIw
         Qg3hGQt1ZHLt8BgQRQln5s8noI8x2baZRxMEDWMyv7n8QSEcWKLE5zQ46wkcOe81U7wR
         MJHvQBAA3t1MiUObK846Wib1TK+17YrKvxab4xzFWO4s2jRkf+9JvVUlz2zQ8pYiWGmP
         SCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719577478; x=1720182278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8ilixuBZasrX5oPlMOZzvZHztGbrS/qDv+nWurvrjo=;
        b=Vwr7MdN8/wM3LXEgQlgqAx2uVZBOggJyl3gvLNI+Q0ztu7c9iz9JGy1KMxjZk/VjzT
         le08+K0lHPkmEwYW+kwtaqXwl+9PV/NIAjLmmyD9T9iqL+qzMQdu4Jt3ZKfP9YOseO0H
         /SOk+/biG9TpHlFYkB3PRXDWYPtqvS4bLpXvxZKC0ZQoLBHJ04eaowoPwzw7CheE+gSk
         m/6XvHJRBQa2Q/3xYoIM4NGXYqfPh93/UfPCbsfMr19gCUoUoWnfhxIkgpPO6kVaoPYy
         t9NNpxzW0vTN0yIpsad+6T5TRHZ3shTCcb3s3UBsqN+9whhC9o7+5qs2p5uS5OGsjVNs
         LcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz1FChk7+LMHkeJvhU9s+7XSOcCbgrCzJO6Ou3Yfu0wjSb6X6k/mxvlXF1cZMi9Khw4uuLnVM62R6tTc+JwQbrCqBXXN/3naWwe+uY
X-Gm-Message-State: AOJu0YweITI9mIKXSluGiixy9vaFfUHVG35GtUK4FzaKmjs+bF46/HRA
	zPvPCKxhe17yCedqRxreVN4JQApgRExxVW8mINK1KSlhOlWKO19gd3WJ3GtAVB4=
X-Google-Smtp-Source: AGHT+IHQNBdkp5sVhDZMNMGLlSLyCBg5ncNtuAz2wpbbCQJUMGI2AenlpBNeQiXbs7+OnFlxLeSLDQ==
X-Received: by 2002:ac2:4c84:0:b0:52e:7125:c70a with SMTP id 2adb3069b0e04-52e7125c847mr3014350e87.47.1719577478429;
        Fri, 28 Jun 2024 05:24:38 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:78b7:4c75:7e6e:807f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm2179013f8f.16.2024.06.28.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:24:37 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ALSA: IEC958 definition for consumer status channel update
Date: Fri, 28 Jun 2024 14:23:07 +0200
Message-ID: <20240628122429.2018059-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628122429.2018059-1-jbrunet@baylibre.com>
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
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

 NOTE: This patch needs to be reviewed/acked by someone with access
       to the IEC958 spec, to confirm the values inserted below.

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
2.43.0


