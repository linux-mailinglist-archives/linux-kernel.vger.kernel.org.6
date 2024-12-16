Return-Path: <linux-kernel+bounces-448295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110949F3E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9543C188B6DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA51D90A9;
	Mon, 16 Dec 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="thxwnVMw"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1492AD11
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391784; cv=none; b=e6QIAwTmQ8jPDcPq36c6VDaysxDhqr6dZH3QB0aIkSp0jeXXEZnpbiTza6PFX3oFa1TvpPWEjUOPWmncPgMCbacUDwW6tnoHWG45xguxXAPx0Q/eBya5s5ATvUkhOEe4BtWsEvH/HoObSFInENAanwh8cWuLdjNJs4eWozNGTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391784; c=relaxed/simple;
	bh=wgy+DGz95rLXZzGMLpViNOWP4xCIogo/C9prc+0HeWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rbmod5f5rrdWDUuTGggrx4S/PEzm8EtygBEnYCVc7xqBFNEXpCEuWyR9GMBfjK6l1X186UD2vkkQQu5Rkil4r10q6DFKiBX9uCFSOj6gIwnZCLj4Oz4flI21mX9WgHR27qm3JcdfIQuXTyFHMAvkCaEE0Zd1/sEMzix5PrxcEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=thxwnVMw; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e3005916aso745192a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734391780; x=1734996580; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZGKlIdzleOQOgogKiQHG+rlJ4na0K8drn/gaT8UmDI=;
        b=thxwnVMwr2QT4Uzm6cLzgrvzQQwM9PpcpxFMdWwTLXHp6K59R+n+Btr4F5dEPmxTA3
         jiLziBXJBu9sLA7ZjJD6o9dK/xr+mwWJYByNStEoLqSdBOmAfxqFHEN3wdB3Hor8Be4g
         d0j1dw9OWSXvZyaUsymCdq1B5iq8Yvs8jzE57lWVqak/ipmuj9qxF1Z4lY23/Pn1rPaF
         5520Iy8KH9ln2yaF+0bjT1AGbSU8M7YkKZqKEssPm/uLFgaTvtk/3J4wZygh0V6rfoyj
         NA9oblHcFw3L7qXEY5e2H7o3X7uiCRxRbqZQZXn0l9BPzdJT7hCtIsqOX/nmmDpxDLUN
         p4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391780; x=1734996580;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZGKlIdzleOQOgogKiQHG+rlJ4na0K8drn/gaT8UmDI=;
        b=MX/VOn3KonYxs6g/4NUr7ygJRj0G8A6DBKNS4iIilPUtePMxtkVOt6oI8D5yacZuGi
         ru4O4PgNs4mp8gyViyffj3ecLjsAiT+gGrY8peAV2q+lduZ8kq7CuJ/bSA0fwTAHqAjI
         AYX4mVeiWcLkOtQ8D/WD7TlrtXshL2MFjqIj8b71fePC1Vr2u2H5hZBgsiqhcLytFNRT
         VCQTMcXVKD7fXHAm8Iq+BvFWeiNyO+dfmvQFeRl+CaVH6B8sRn4yGkC1Nqc8kFILsH4E
         CusYF12OERDJ2lKWHwKM6ynX2lgiApZfHUrwOFiMyxdPFSGpF5m+geTVwCJHCLyIy8HF
         PRaA==
X-Forwarded-Encrypted: i=1; AJvYcCXgO74rGscKnqdHACxIl9cmx1+kHWYt3nxh7SFQBqjYVWVWSemYDeCZl4fb5WZFiqsJ3R+eZGpB+4WshzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbAfH7/CZS8egGUGhucRY1P2GluXuV/BPZeyPOdTRXF8ykZnz
	02CcZyRhhKV9PRgbkJnXAlv2m80+l47W3S4uitc+IiogH5snPWSxe6bt6YeARwjUF8rIgvTht3M
	n
X-Gm-Gg: ASbGnctsiz8b60cu9xezsWKAx+wo0JXyTbGuwHnUwNRY7P5wxumAjAv3NW24BNme9sH
	mECCy2+U5MB2WwOKxQlDXah94X1CqBY3P7DYhUuhpehqIMvjbmyh0gXVrcZOLiyBpDGZKQp4qWK
	8wSmbi/D5DY81EyyvANPrsbrrp9aj/avCyYornd5bOdi6NJcJrOv+JT2+HaXIS+n/Qb42BdftwP
	gzPYECPuXWDvzlDMKC5GgJkHTSnLEILNjo+lfV2Oxs5Erbku9Gp497II+pfl2DKjFmM5gRxu0Ez
	kql3+g2hziJB
X-Google-Smtp-Source: AGHT+IFTFZDOtZk5gcZZblKIymNzVXbS8q+btxlxMRcxZgFwith2AML98Xc6t+7AlU6rzTJT6WlQGg==
X-Received: by 2002:a05:6870:d106:b0:29e:766d:e969 with SMTP id 586e51a60fabf-2a3ac62d68emr7841252fac.10.1734391779730;
        Mon, 16 Dec 2024 15:29:39 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d29cedb7sm2352080fac.52.2024.12.16.15.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:29:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Dec 2024 17:29:36 -0600
Subject: [PATCH] iio: ABI: use Y consistently as channel number
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-doc-iio-use-voltagey-consistently-v1-1-9e34a72133bc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAN+3YGcC/x3NQQrCQAxG4auUrA10hlrFq4iLmv6tgTKRyVgsp
 Xd3cPlt3tvJkRVOt2anjFVdLVWEU0PyGtIM1rGaYhu7EEPPowmrGn8cvNpShhkbiyVXL0hl2bj
 FVS5Th/55Fqqdd8ak3//j/jiOH+JnSJZzAAAA
X-Change-ID: 20241216-doc-iio-use-voltagey-consistently-0e8c7f4e6b5c
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Change X to Y when referring to channel number in the ABI documentation.
There were only a few cases using X (and one using Z). By far, most
documented attributes are using Y for the channel number placeholder.
For consistency, we should follow the same convention throughout.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 50 ++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285cd507c493cfff088158228388b67..0e45996625cfea8bf7bbee30382f432273cfbbc4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -227,7 +227,7 @@ Description:
 		same scaling as _raw.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_ambient_raw
@@ -416,11 +416,11 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Scaled humidity measurement in milli percent.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_X_mean_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_Y_mean_raw
 KernelVersion:	3.5
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Averaged raw measurement from channel X. The number of values
+		Averaged raw measurement from channel Y. The number of values
 		used for averaging is device specific. The converting rules for
 		normal raw values also applies to the averaged raw values.
 
@@ -448,7 +448,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -660,10 +660,10 @@ What:		/sys/.../iio:deviceX/in_magn_scale_available
 What:		/sys/.../iio:deviceX/in_illuminance_scale_available
 What:		/sys/.../iio:deviceX/in_intensity_scale_available
 What:		/sys/.../iio:deviceX/in_proximity_scale_available
-What:		/sys/.../iio:deviceX/in_voltageX_scale_available
+What:		/sys/.../iio:deviceX/in_voltageY_scale_available
 What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
-What:		/sys/.../iio:deviceX/out_voltageX_scale_available
-What:		/sys/.../iio:deviceX/out_altvoltageX_scale_available
+What:		/sys/.../iio:deviceX/out_voltageY_scale_available
+What:		/sys/.../iio:deviceX/out_altvoltageY_scale_available
 What:		/sys/.../iio:deviceX/in_capacitance_scale_available
 What:		/sys/.../iio:deviceX/in_pressure_scale_available
 What:		/sys/.../iio:deviceX/in_pressureY_scale_available
@@ -1562,7 +1562,7 @@ Description:
 		This attribute is used to read the amount of quadrature error
 		present in the device at a given time.
 
-What:		/sys/.../iio:deviceX/in_accelX_power_mode
+What:		/sys/.../iio:deviceX/in_accelY_power_mode
 KernelVersion:	3.11
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1691,13 +1691,13 @@ Description:
 		Raw value of rotation from true/magnetic north measured with
 		or without compensation from tilt sensors.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentX_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentX_i_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentX_q_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
 KernelVersion:	3.18
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw current measurement from channel X. Units are in milliamps
+		Raw current measurement from channel Y. Units are in milliamps
 		after application of scale and offset. If no offset or scale is
 		present, output should be considered as processed with the
 		unit in milliamps.
@@ -1864,9 +1864,9 @@ Description:
 		hardware fifo watermark level.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_calibemissivity
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_calibemissivity
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_calibemissivity
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_calibemissivity
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_object_calibemissivity
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_object_calibemissivity
 KernelVersion:	4.1
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1887,17 +1887,17 @@ Description:
 		is considered as one sample for <type>[_name]_sampling_frequency.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_co2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_ethanol_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_h2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_o2_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_o2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_o2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_voc_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1905,9 +1905,9 @@ Description:
 		after application of scale and offset are percents.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw
-What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2096,7 +2096,7 @@ Description:
 		One of the following thermocouple types: B, E, J, K, N, R, S, T.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_calibambient
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_object_calibambient
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_object_calibambient
 KernelVersion:	5.10
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2172,9 +2172,9 @@ Description:
 
 		- a range specified as "[min step max]"
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_sampling_frequency
 KernelVersion:	5.20
 Contact:	linux-iio@vger.kernel.org
 Description:

---
base-commit: 01958cb8a00d9721ae56ad1eef9cd7b22b5a34bb
change-id: 20241216-doc-iio-use-voltagey-consistently-0e8c7f4e6b5c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


