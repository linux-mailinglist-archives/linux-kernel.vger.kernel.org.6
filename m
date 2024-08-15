Return-Path: <linux-kernel+bounces-288333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650E9538EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72698B23657
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98541BBBE0;
	Thu, 15 Aug 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NA4KPlho"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60C1B4C2D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742542; cv=none; b=hYjTnnCwuY4EIT/fSSj9XR5DwNiU9bjZFMc3CVQDIAbLGG/n99fFXyB0Ms8HFgV7KjNtpjwd858s4PpptqlTW5Z0tgJiWKFmZ5gHgivLQyw81nFMSrkYG00FrHUmc2Coh6ngE5hZOy9H7kr/0aeEvsD//bWD3icEE2ZbeN96Z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742542; c=relaxed/simple;
	bh=HTE9AF95FYEDE44Je5v0L+ZEBU/Bi9/yQL6SYE3InCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYPB4+zALXjuXZ2Jd6ig67q4xCcudZkIzv09vPU3BqxSJf+XMGx/SKra+3q/boIGRnRkhFFI2iilOYdeSuDuyuovO7i7KjGLN7//CPVFWROMp5f0GlNezSGVUNEbuvi1Q7ElnHIM9sLiZNimuuhZtO1U1yxZeXOjaRErlWm5K2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NA4KPlho; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5bb2ac2ddso569090eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723742539; x=1724347339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcesUZ+PyyZLACSq67B+2czdbFpwEBLROdXRTYzWgqs=;
        b=NA4KPlhoyQ0pL86j0qd0OgmEyLzMsi+VUWbx4uYhM6ba3h80OnPCRUNBemMVsFlZe9
         K4BqaMIVdCdL25C2hm+n6EWjj1TjBSnI4cUV6+dVN+VhK9SVHMBDMvlBb1LAUGN+THk1
         y4Zsa2hv/8JDszMYweQC0jEonM18oZFmMm+XigcVF6yYb3q9p4HhTVLt5VBqFRgTMY/+
         nFWGjgPAhQFfAW4EKry9w6SfWMahtSuzL7VdROJfzSV6rmu2ejbYCpvp8A+Oz4RItVBG
         2Os3JtRyi+sgrtu3CVFJegAjD8B0MbLmEzsFGrtyE0gZtiS8aM3oDJOUozQ25vLbQtGE
         j/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742539; x=1724347339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcesUZ+PyyZLACSq67B+2czdbFpwEBLROdXRTYzWgqs=;
        b=pC54M+u1xlyfAapcEmF7J3QjDYSjh+vyRmcnT5GG6FVlKZyOIaV0e+OC8PdwHhR/Eh
         47Zq74joiwbedHl+52tQN427TWMBJr/x/cKaXkNkN/Wvp5tvFmx1EAzuJLiDmTsTw7iH
         eew77aSxSi9bV1M/emzTj92C1hwWNufpuBxVBmMraypEiQcehMkDDEUSxeg6mZGSLisq
         QsIRboI01nFQ1yldRNGSCOcdHm0Y5nweUT9pco2SXQ1EvHiXtQ7cAw9X8l8n7ZHysOhN
         1vJ1X6ivWqVFscJmha2DwA+YCGasO8vwpWeVLy55RLYtE/jlHNwGM0O2L2eD+5bW3+vc
         xUBA==
X-Forwarded-Encrypted: i=1; AJvYcCXXx0EA5jWfUVBW4SFfkjGf0M4yoLuGrnefcYHqY34GVll/GTJY8bDWL9fTE0KLJjdwGCKSvBIHZ1qAsw4e9uBO5qG9wYOtfBRCyIL9
X-Gm-Message-State: AOJu0YxkJdthaVp+eZOJnFbsGYWBy24z31lZqP69r9f90t6jV7mwr1KC
	pmhApqbfEljwO/g5YZFpDe04Pi4NAYjPV1dkE+PJwWivePGN/x6a43LyrUf6cmpF6W2mc1RPN2x
	c
X-Google-Smtp-Source: AGHT+IE0IpVcxKXiE51xHAESEiTWRzrQ5ztPPnJYDYy6IwnEqG/maM6BAofsEHWuPvEpFKCslpu70w==
X-Received: by 2002:a05:6870:1b0d:b0:265:b32b:c465 with SMTP id 586e51a60fabf-26fff476ebdmr1895548fac.9.1723742539426;
        Thu, 15 Aug 2024 10:22:19 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66297d0sm345327a34.68.2024.08.15.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:22:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iio: ABI: sort calibscale attributes
Date: Thu, 15 Aug 2024 12:22:11 -0500
Message-ID: <20240815-iio-abi-calib-audit-v1-2-536b2fea8620@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
References: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Sort calibscale attributes so that when we add more, they can also be
added in alphabetical order.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 67d8d1df23d4..401e0a595aba 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -549,25 +549,25 @@ Description:
 		- a small discrete set of values like "0 2 4 6 8"
 		- a range specified as "[min step max]"
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:

-- 
2.43.0


