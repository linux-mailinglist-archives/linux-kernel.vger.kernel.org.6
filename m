Return-Path: <linux-kernel+bounces-384617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87FD9B2C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9C280D69
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFABB1D3648;
	Mon, 28 Oct 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y59vsHYe"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2411D0F56
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110349; cv=none; b=dAYSBq0NqUQd0xr9/26D49JimxiMmS93+gywe75GoZHDHeZ8P0kLjC8UiUKiXQOxW2lCYvjy8sT3NBnc+aMeG2U5XkXFty0RAroRVIr2omVZg4rUGWP3YHttJ11SSQbrr8VZO43zdkhAO16r9cdtMPhirTb+2WsoXaYpJ1X2QZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110349; c=relaxed/simple;
	bh=E5IKpWlBrs6BrNxKGj8gL69lGAFGxkNE1Vi/39M/35Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVzbzg24YUMqATXCRUzFR+KElQ+rzoOAO3rCnfmKBPMYQ01/CBFGjYCDAr5IBhqyOFI3dIBiy4v09K/nLWBaVpeRYbAdKn6GcDu2IbE88b/hxe3zZU9c5fcx5E74vNbeFAKr+7b0BfOKu4TqoYw0NHNHw1m0Q+Cm6+UDV/lxN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y59vsHYe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b14443a71eso427142985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110345; x=1730715145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRIQcTwMhYqGctEPu/xoF4uEWBP35j2ZdxAtYHSbb2E=;
        b=Y59vsHYecOLkSWgZLMMjGcvS6rtWiYWPwkWp/UtBM2/+2/K1eeS7nRhcpxJ5FBqxLU
         fJNqw4hGZuJRDiCoNfOour4uOP6iYVMluRQy2rnZUXXE8DQOnC0M7LfmgFP1GR+g0DNO
         pgq9Rktkud2RsBaYUNC33C1O1tnkVbWZZbZP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110345; x=1730715145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRIQcTwMhYqGctEPu/xoF4uEWBP35j2ZdxAtYHSbb2E=;
        b=w/jvWtbVj4ZygZOuaV9cEMp/BRSXxgh1Ct6hSZvg80AMx1DJFCenn7UHs16bS7lVMx
         UUvemJAJzDq6aftiS/vlFs9pF+wCljXLFTjQI3FeVqokT6LsBq3lBj1pHj83fbafx8pr
         qhk2k/pbx2JU/93+VijkY0CEH3KKM6M3V132LB1IR3nrQIRaJsagrwSE6Ucs+R63zQFX
         1iLP2xLwf+SNUuhDolZbjkeurcAsCZ8Hhkv2dbLT+wJBuJFs4uERxtZZ490KhhVgLd3l
         rm2vKjsRb9wC9Q8SU9O6abp5a2rDQMBDsC6l+N1doRZrPxkfSL///qb/Tj0yN+lHaRTR
         7iVg==
X-Forwarded-Encrypted: i=1; AJvYcCXyltD4TESKgZrJoIpJwQGfO7R2clLdxXyYyl1OGZWxKFOcJp3WgrNJV7zZ6oqs3lkHjp18DyZjDUKSZ5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5+YvIIS+pQLAuhAm1anqIfJya6jLro/Y6G04s1d232t+7AYH
	G+NJRsLY/KFX6iq7Cn5U/LvGoj72aWpaBXKEKzOHfq/OrNG5wN/4966fpdViFTccgXEdRTitixg
	=
X-Google-Smtp-Source: AGHT+IHsZfrL95wV+H91XB+R0gfoIc0eDU5H8YGXxr3YjqWTDf3Oef34MoOXLotCH0ugOLZSOTidVw==
X-Received: by 2002:a05:620a:2482:b0:7a9:d14f:2374 with SMTP id af79cd13be357-7b193f3e043mr1206071685a.44.1730110345653;
        Mon, 28 Oct 2024 03:12:25 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279126sm305483385a.9.2024.10.28.03.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:12:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Oct 2024 10:12:21 +0000
Subject: [PATCH v2 1/5] iio: hid-sensors: Add proximity and attention IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241028-hpd-v2-1-18f6e79154d7@chromium.org>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
In-Reply-To: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The HID Usage Table at https://usb.org/sites/default/files/hut1_5.pdf
reserves:

- 0x4b2 for Human Proximity Range
Distance between a human and the computer. Default unit of
measure is meters;
https://www.usb.org/sites/default/files/hutrr39b_0.pdf

- 0x4bd for Human Attention Detected
Human-Presence sensors detect the presence of humans in the sensor’s
field-of-view using diverse and evolving technologies. Some presence
sensors are implemented with low resolution video cameras, which can
additionally track a subject’s attention (i.e. if the
user is ‘looking’ at the system with the integrated sensor).
A Human-Presence sensor, providing a Host with the user’s attention
state, allows the Host to optimize its behavior. For example, to
brighten/dim the system display, based on the user’s attention to the
system (potentially prolonging battery life). Default unit is
true/false;
https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.pdf

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/hid-sensor-ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6730ee900ee1..8a03d9696b1c 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -30,6 +30,8 @@
 #define HID_USAGE_SENSOR_PROX                                   0x200011
 #define HID_USAGE_SENSOR_DATA_PRESENCE                          0x2004b0
 #define HID_USAGE_SENSOR_HUMAN_PRESENCE                         0x2004b1
+#define HID_USAGE_SENSOR_HUMAN_PROXIMITY                        0x2004b2
+#define HID_USAGE_SENSOR_HUMAN_ATTENTION                        0x2004bd
 
 /* Pressure (200031) */
 #define HID_USAGE_SENSOR_PRESSURE                               0x200031

-- 
2.47.0.163.g1226f6d8fa-goog


