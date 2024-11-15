Return-Path: <linux-kernel+bounces-411135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683649CF403
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86FF7B2F10B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14401D90A2;
	Fri, 15 Nov 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="17WXqp05"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7071CF2B7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694050; cv=none; b=L617S87BMgLOdq+tGzrzSvLmO4O+TzKgc3ix9yq4zCfoc8kY3kOrWah3N3a/+zeU5m9enZxr72vqrB4gDUJhql7zWovJPHw6hZtf3di6eBn5AaUlYaw71Dr9sb4UZZMVaAcmig+bNQPkaW98eZy7XHy1nYjA0xrmbKcU/+IpZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694050; c=relaxed/simple;
	bh=AH9lmUK/nV3spgNCYYokydJm+WFX/Jy8tWVheghWbEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEC1Ujrv1d/VCEO8kQrpJeAhTa5onAVyOMANl5b+Mncz5AXO4k9uaQv/lRmuRvbmgRvBt9tF8NP3QC0YHG7NGqrCHwJ9s6cYF+npBs5ztO6UbsRsIGKWj2B5LyoQzSyJPhbL9Z3fixIErz0PTKr7477yMWQmSkaGBYCPl0WvdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=17WXqp05; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso22584655e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731694044; x=1732298844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o419LoPHEwZk9uqC04SIW17qJKyWQe/rAVJ23MnW91M=;
        b=17WXqp0579ZvxyQ9DfImD7X+mA9B4kj59aZMMqw8/xhnrfgYcrEUJBe3RE8yN3f5Jl
         izuahg5wYJGyaPF0wUjwvpxSHOlfI2hs0e1RDPST6dBUOmfKf286i6qsk4F71eSOSWzA
         okvEZSO3qr+r+jbNMI43tjRpTA3huL+hWQQHeijB15ynEF+fvNw0olb8KZMzE1oy235i
         5kzEGsgckpXD8+D5J0TXQngeT7e9qBrZBRWonMbsHgYj916JUBJCmdOpLWoh+WymlTXB
         hq+wgTzkAuvgDGxIH+f+Kl13Dz2JTfo4Z8inP+z0ElfPyC1RF62zzr9wVBByPXfZy6K+
         JTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731694044; x=1732298844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o419LoPHEwZk9uqC04SIW17qJKyWQe/rAVJ23MnW91M=;
        b=nvM0wznOHRRHqETI9QK1BcOz3h33zhfR2lWQRiZlA9a8p/a23kVKUQgFbWxxGWKzVJ
         joY30TWQTjCGy4glFappXM/FCpddyRfcBZ9XZHd/STNLRFab+yGXvWy2tyerUN98cgOe
         rD1wtibN2QzLwj8DPr1gCRiiiywyogMa3v6e6oCrkVlVXOJ2xqcdT8snsyBwOqLnXRZw
         joovzQYNrnrn4X5W07wtfrkvGrV1xKj8rKHTjxGfTK8wYO4uc0XB88rhWb88CbZaD4q0
         McZmTDwjpCrMmkJRY8FBFOwunO89uaG8UUqVnsaupAXjKRfb7+G9XaaU8/AVX2VyJYIZ
         XHog==
X-Gm-Message-State: AOJu0YwdS/hZr7q/5dZMkcWXhmCSnv5b4eJMU1OOVItRCbuqLtMpO+S6
	wp21IeQVHJpooBIjenmAQEIu8bqbfUmSbKL1+2zt/47H6vkFHb8/MOlrDzZ7giIag8u8V0R/3Hn
	g
X-Google-Smtp-Source: AGHT+IG7RtnvTlDkMryRojxaNybiE5sp971d9ovbcqBFKVQ5zzkyDuenimLIyd8f6VCrJr4dMs8DRQ==
X-Received: by 2002:a05:600c:3583:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-432df74fc2emr41328725e9.17.1731694043625;
        Fri, 15 Nov 2024 10:07:23 -0800 (PST)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbd82sm4957755f8f.52.2024.11.15.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:07:23 -0800 (PST)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	manivannan.sadhasivam@linaro.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	kieran.bingham@ideasonboard.com,
	naush@raspberrypi.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2] drivers: media: imx296: Add standby delay during probe
Date: Fri, 15 Nov 2024 20:07:17 +0200
Message-ID: <20241115180717.10820-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241115142021.574402-1-aardelean@baylibre.com>
References: <20241115142021.574402-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Naushir Patuck <naush@raspberrypi.com>

Add a 2-5ms delay when coming out of standby and before reading the
sensor info register durning probe, as instructed by the datasheet. This
standby delay is already present when the sensor starts streaming.

During a cold-boot, reading the IMX296_SENSOR_INFO register would often
return a value of 0x0000, if this delay is not present before.

Fixes: cb33db2b6ccfe ("media: i2c: IMX296 camera sensor driver")
Tested-by: Alexandru Ardelean <aardelean@baylibre.com>
Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
---

Changelog v1 -> v2:
* https://lore.kernel.org/linux-media/20241115142021.574402-1-aardelean@baylibre.com/
* Technically, this is not a true V2, but rather a new patch
  - But in V1, the attempt was to fix an issue found with the upstream
    IMX296 driver, which was pointed out by Kieran that it was already
    fixed (more elegantly) in the RPi tree.
  - The standby delay helps during a cold-boot so that the driver can read
    the IMX296_SENSOR_INFO register. If the delay isn't present the value
    read is 0xx0000.
  - Original patch can be found:
    https://github.com/raspberrypi/linux/commit/7713ce38e6a26425ace3a57b3d03ba0125c16f89
  - From the original patch of Naushir Patuck,
    - Added comment 
      -------
      During a cold-boot, reading the IMX296_SENSOR_INFO register would often 
      return a value of 0x0000, if this delay is not present before.
      -------
    - Added 'Tested-by: Alexandru Ardelean <aardelean@baylibre.com>
    - Added 'Fixes: cb33db2b6ccfe ("media: i2c: IMX296 camera sensor driver")'

 drivers/media/i2c/imx296.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/imx296.c b/drivers/media/i2c/imx296.c
index f942f66fa664..395bfe4fb23d 100644
--- a/drivers/media/i2c/imx296.c
+++ b/drivers/media/i2c/imx296.c
@@ -940,6 +940,8 @@ static int imx296_identify_model(struct imx296 *sensor)
 		return ret;
 	}
 
+	usleep_range(2000, 5000);
+
 	ret = imx296_read(sensor, IMX296_SENSOR_INFO);
 	if (ret < 0) {
 		dev_err(sensor->dev, "failed to read sensor information (%d)\n",
-- 
2.46.1


