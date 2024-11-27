Return-Path: <linux-kernel+bounces-423222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344149DA485
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36328167045
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679F1925AE;
	Wed, 27 Nov 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rAeERaPi"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82959191F74
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698657; cv=none; b=rzfWDGTGEnS0IC9MlkacOSzkIucYTk1fnurIy2BhTzIoyUuPGSp31iKxzAXFa3Bon3bs+GY0sbnrp43lTKUFUiYE9zVjErA2Mf3ooYmtQVtpsAtBZvOZWMaQhvxTAIeomYCfcYYbv+kuaRXIcoPJIWqqRt84GNwAiueBNJaB7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698657; c=relaxed/simple;
	bh=hi7liUjxe5RX7PGtUMrmWW50QPKb3a7b4fHNFzjuy8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yj0uG0kVBbyJA1JtJbpFM+GHCF1hmJ1tJs0DoVhrsJadqfNfmZYsr64KwUZf6W9fAJs6ShLIpeRaX+LSuPgBiZNh+E3XYnUuPApBhAy1WGi5SNw3SJulOliGbkQcpuofe2hIBuNBQ/3QLilTTejAb5fMQ2Ur9yd3Ji1fp+n/CTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rAeERaPi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382376fcc4fso4020487f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732698654; x=1733303454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D++hmFkktyJpz8KdCoh+I0yzg35pIUrfCd8imheAkBM=;
        b=rAeERaPiTdAiFjKfP1n3AiaNPNT/gU9HVJeuKm4CZ7HsRJ1Os1ELUD8LR9fWH3S+Iy
         7J/N2JWIfzrhMzdhywuMgwKRnzpChJR1q2T3gDVA57gw3D9FeoPT27RtpvFipdeehKw+
         +FxcRPsBYBUKT12Y34EkMUvb4S8PQJ5I7OLVM/3ObV2SMdpCfA4LLWAoJ8A6J5DHUiUe
         MGxoLf40a2HUHjRAd9gUrDShsIW+kGlJQ5S/S/z7AGP2rJF4qUCKZNs2vuF0CZ3zCAqF
         dEPLuckfKQztzfETdJ9+6CBbw0vn28zT+v5yYz0NWwy6FpQugsaH3/y1tm7xR8ytgiX0
         qXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732698654; x=1733303454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D++hmFkktyJpz8KdCoh+I0yzg35pIUrfCd8imheAkBM=;
        b=j7Vm0MPDCIGMkoOLnLur3ehAEqeUc6G1hS4OLEkPb4veC48v8fr4J/QpeAR4w1SKQ4
         HwQlC4mYw28OPcKKPeW0L1YvzQncGACSc6gR2IuMhoXLXdOvDKDYf0YNgKly4opa/96U
         sglYKC9uecrTH9ixO94vnQP8o9nKj0vtufsR5/12GGe/wtwYXufUmd0X3NvKut+0v8bF
         m8YQAzHccCmqzz/N2x1IHi9PI7gOews2HWhWIEyqxlwYL/FskB2FA2tSTlJI1hmtP5VO
         y48IIjaCbO5mtnvEvbFgHTo5vr+nRlGpMBfrNjYiuQwEFTgaZhYg8pK4gGgo6iG3c88V
         uvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH4HiT6VNmNSIM49e/YQ20Jjw2MU+bvuOnf2hPDTeNLh3BbcdUhDrTp5d+NowQydj+P2ijRHBHKKuHrFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTZjkf6MTBGBXfLHEoz1/iYHiWFtz3tzo4Y3wRfo647gkELaf
	qBbMqU5Za22GINV2J85H01WcmbEHyUA7nPyDra55oOjNjbdOFiNZT90UvU0Tg1A=
X-Gm-Gg: ASbGncvLlXbBuzaaCUHf0UW675qA5SNXEB53PvxvkbYeH9LgFIPNyUSFuZ3ou7h6qoU
	YExxyRC+rHQcDcFZfmaBgXKtCDcUimAwGETolVgGhkPblVcZmG8P/c6AR4/0drMnhj+FawIoOX1
	ptNHE7rt0/+QU9HeYJi7MY3VIOGRGyQ9MwB85UMRtn3rC2ULo7SBHg0VwBPaywxkffwmzpWK4Ur
	qflzz0uZx831VEPE/itc8JsSrgC7VyBfTaE8BsXDHMAehpFWBPAx0RjpZxkZtwW0kbnMxUG4zI2
	XfR2b9CZi6Qz/Ju2jNGJ
X-Google-Smtp-Source: AGHT+IEFPftre0OsDTeBGSoRFHKJc3M1AJdfpQJilY19IR+WHfaPS6t600F3xsPWWTZA6Rf3QY3rhQ==
X-Received: by 2002:a05:6000:1844:b0:37d:5352:c83f with SMTP id ffacd0b85a97d-385c6ebbab6mr1844313f8f.17.1732698653797;
        Wed, 27 Nov 2024 01:10:53 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5285sm14529415e9.40.2024.11.27.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:10:53 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Wed, 27 Nov 2024 10:06:14 +0100
Subject: [PATCH v2 2/2] iio: adc: ad-sigma-delta: Document ABI for sigma
 delta adc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-ad411x_calibration-v2-2-66412dac35aa@baylibre.com>
References: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
In-Reply-To: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Add common calibration nodes for sigma delta adc.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   | 23 +++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 | 24 ----------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
new file mode 100644
index 0000000000000000000000000000000000000000..c2c55a966163736aea8d46fc5089c08dac747b84
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, initiates the system calibration procedure. This is done on a
+		single channel at a time. Write '1' to start the calibration.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, returns a list with the possible calibration modes.
+		There are two available options:
+		"zero_scale" - calibrate to zero scale
+		"full_scale" - calibrate to full scale
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, sets up the calibration mode used in the system calibration
+		procedure. Reading returns the current calibration mode.
+		Writing sets the system calibration mode.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index f8315202c8f0df2bd4b7216f5cf8d3c2780fcf3f..28be1cabf1124ac7593392e17e4759ddfac829e8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -19,33 +19,9 @@ Description:
 		the bridge can be disconnected (when it is not being used
 		using the bridge_switch_en attribute.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Initiates the system calibration procedure. This is done on a
-		single channel at a time. Write '1' to start the calibration.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Measure voltage from AIN2 pin connected to AIN(+)
 		and AIN(-) shorted.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Reading returns a list with the possible calibration modes.
-		There are two available options:
-		"zero_scale" - calibrate to zero scale
-		"full_scale" - calibrate to full scale
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Sets up the calibration mode used in the system calibration
-		procedure. Reading returns the current calibration mode.
-		Writing sets the system calibration mode.

-- 
2.47.0


