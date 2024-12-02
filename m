Return-Path: <linux-kernel+bounces-427246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763509DFE91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350A1281CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980481FCFFF;
	Mon,  2 Dec 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o2qHcMqc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A71FC119
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134472; cv=none; b=owr1wTmVPBlS3CNPuyIqYJbO7W4BbgEZsuj4R9SJzJwB41gqPh6IdUI7ggZl9fHFm+KUpyiKDxgMH020dvLRWiXWXjXDFbRiJHKOWaHPDdi34M4wOMsmqGIQlMyCoErXemAk1o/OcszPf6V8B5HAOd9PBy5gNHm5TdM3WCtqKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134472; c=relaxed/simple;
	bh=gUUTuRBqFh6i1HpXlE6OB83LoDsqVr3hA6U4CkK7QvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+qWK6IglSJF6joq9hejEiNE0o15u5GnSSKI0dhY48T9wHj3JguvDtIgIzp1wPvp9qnmQ29DyQ4u3d6OPpm/OtZ3ZWbiel6QSDzpDWe8sVjgiSpJZ7DzlI5pjp1siry7BPxA/2gArM8I/IrrLjl7q5mogIhMCaxSvj7go2mEX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o2qHcMqc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434aa472617so33820115e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733134469; x=1733739269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UShwHa1ujiu/7K4Zm9WNENd64U85UqA/kqLEIbdrEk4=;
        b=o2qHcMqcYMvouPrItrEazojopPjPbTAevmFGOHISVHdHtCPtB1icC70Kx+hDkpXfHn
         o7UKuRLklBY6KukcRYWQ/1m7KVNInrsSzk1BqiRKTMmYe5sKQMoc69fH8TD7ZoIEugOx
         +CEA+XjT4OrUQrQDRH9M0sdMFVfjsIc8LlO3igSXCFC99O1SYMroRwF31Y+6krqfd9h+
         e8/qgq7K44DETVg+2F0Ydy/R3cE29Dr02sIoaWQhWjWYThrEo21205keyLZC9UOxmxLL
         tX5sGcrIMrSnx6MrhEH2X2xDgC4G0MYXWzmtGcasek2RteplzJJMZM8aVs9V+dqEbE5g
         F+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134469; x=1733739269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UShwHa1ujiu/7K4Zm9WNENd64U85UqA/kqLEIbdrEk4=;
        b=movnzDxHsg7R6sXQNy14pUMk1pnc+2W+wf3wXhxl8X125yCPqrAd1vld/3Qj1a5LSi
         XAptO1ZTh8Bz/uVbxb7Ist3zhuRkwos6wkBzcToKlqbi5OZlKdU3tDgWQ2fG9rVVodUu
         MZ30wCGEtkg55yv6lQ7qaGqy215dvtE3FF8CojfLf5TSVLE66DikNSUSlCVqVcq3aW4G
         DqE10N1tlYa5r6iidrDOYu04/2R4qUb8MZ+WFdIth9AvE/cl7IfOc9uJNS+/UXv8Eb68
         wVIpE9UGRTlGfivGUpakvShCH8m85hotaHY33A+7A2ptBD3yUJMkWzYPYr9fQCmp34ad
         xhXg==
X-Forwarded-Encrypted: i=1; AJvYcCXJbtAg7okiz2HQyMLaOqJhQTBzvhDrx+DWq2TIYcDoUfqjHGIISG684BzpOjTGdKdTHeguSvmD2gnTNOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGh1BDbcPzTJVDFlpeELANU11HPM2ghCfeukcmsWU4ivx5vDR
	2DuuTo3H5F7Z1v4k9QVpX7ovhELcUTWtdKmZO2zssMzdiQxCn23YbyXj7+4/O3g=
X-Gm-Gg: ASbGnctRcqhzkr1gC962RniyrGNoX4tQGA6tbMyrebJlWFAxQ6wf1aQVuLwehZi2pDE
	9o+qP1QHZzqDFKGe8f0sjTx0uY97GuXSOfJPeq8vh1IAvQ5pq0F+5N2k+HtReiUwfCP0OHwCm7L
	RAI82IWhVnDYdQZTLrsi/Kl7LUq93dg0yQZIuzplsdKJTIZj6PFjZIN42FFgpxHkLjsd3p2HW4q
	8Kx4gUanMVaXEc/NkbKokgmuxkHlUEvdnmZWPvMyZXa+g+U9EGeZ4fLykhyTnVAzpsK7zPUb5qk
	ltYvDZ/9930jbLp4hEza
X-Google-Smtp-Source: AGHT+IG99R6RmHPizsPQYmPL6FxUEvS09nH38X0UgGDDBVNTdkRxoIeaJaNsFnED1YOxtAcH9liGCg==
X-Received: by 2002:a05:600c:314d:b0:434:a75b:5f6c with SMTP id 5b1f17b1804b1-434a9dbea45mr229123865e9.10.1733134468819;
        Mon, 02 Dec 2024 02:14:28 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5e59sm181138325e9.44.2024.12.02.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:14:28 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Mon, 02 Dec 2024 11:09:53 +0100
Subject: [PATCH v3 2/2] iio: adc: ad-sigma-delta: Document ABI for sigma
 delta adc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-ad411x_calibration-v3-2-beb6aeec39e2@baylibre.com>
References: <20241202-ad411x_calibration-v3-0-beb6aeec39e2@baylibre.com>
In-Reply-To: <20241202-ad411x_calibration-v3-0-beb6aeec39e2@baylibre.com>
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
index 0000000000000000000000000000000000000000..a5a8a579f4f34d5982d4d7d4545a0bc246505910
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_sys_calibration
+KernelVersion: 5.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, initiates the system calibration procedure. This is done on a
+		single channel at a time. Write '1' to start the calibration.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_sys_calibration_mode_available
+KernelVersion: 5.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, returns a list with the possible calibration modes.
+		There are two available options:
+		"zero_scale" - calibrate to zero scale
+		"full_scale" - calibrate to full scale
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_sys_calibration_mode
+KernelVersion: 5.5
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


