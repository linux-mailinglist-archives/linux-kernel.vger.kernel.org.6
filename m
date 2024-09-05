Return-Path: <linux-kernel+bounces-317420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24E96DDE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AB32816F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3251A0BC4;
	Thu,  5 Sep 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G2LzPf2D"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3019DFA4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549566; cv=none; b=BNwFIkpU4i30tKk3NkPseLrllZP55hod1csAd8qVYT1YClYZLxXO6j0ZC9iENUMPMTG6lyMWqUAtDmRlCIIHsT1ZIwcc0ej5V7tWbP43nRO9aa/5s/t4jMhmd3WVcDvQydqq5Gg775CrL25+GOUg5SmUQnALPSTlN/XpithUYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549566; c=relaxed/simple;
	bh=qn4Pz1FllPoafjD4D/Ys3jtfWUZjxE9556qRfvpMii8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+mAe1b2OLYiZ/+QkL8o2wMQOyR8TJwoIu9Xx83UBaTb31e71Qoa4DuBJNFAV98jh3SBx7a9TeYgLhgOy8V7Jwq9/0nUhSAfB3/2/gWim/QWJCZryEHFL9BqgwvpYdL6icNGHD9CGeWduGaFuigf67lXxDa5IJeQY0XDPwqkGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G2LzPf2D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so7500055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725549563; x=1726154363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=driisr0A3MH4MgRKuQS7KG+TfR2Tlhzey12qVcFwLZA=;
        b=G2LzPf2D21heF38NkGLIviwTrIilT7IgpccZlVSko2SWS8wTjsXsmA2w9SCOu47Qtx
         45xoiu6oM68HtzzwhrNR6f6xg6hpnshJMWpHiMS+TPG4QtsKd+R5sNw/u1wPNntJu94R
         KAcYQYMEibfkDp3ML2C6m5phHaT7KdlLFFTk/s60Owa9dzOV755pS9c6r/FaecJpl8Uv
         3O60s9B5xLTFzgCNsPyZwS3T9v5Byy2HQBIHo6yPStyAkI9FYPbIWYPmyYhUuih9RmFy
         48W0v/lImCbDhc3cxmYyRmtwn0ALBl/7A19+ufW22r5ENtMVBaz8aasXtSVjS/9PjC0n
         AamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549563; x=1726154363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=driisr0A3MH4MgRKuQS7KG+TfR2Tlhzey12qVcFwLZA=;
        b=LbZ7Dkr7Gkjgb9uR63NlwAc7GUXqsgRqVenDyztz+gJLE8+z4kXGUt6R1h1gJ3aErT
         fQxHkcW0ZT7hdLVQuZWG92PzL3b0HUvUz0lenWejOjKoRTQNaXn9Dp/Tw/9Vcijw0sSS
         S2gFrhcHrRut/L9+Hy13uvtdtZcAWwyRG0L6Xlx8gjryak93lh7OTWFtMAA7GNOPY4te
         jSB9X8E6m0R01mbu8+DgKggYAhcndJyzR9z+6O5URUnGbCxdRms28tOE13qRWt5uRs5h
         V0zO/kCVWaeRCRCgrpMk5YbwccgqBbln5y4qlRgu4pg7wEWw6cjsiooze7615fuq/ym9
         Oflg==
X-Forwarded-Encrypted: i=1; AJvYcCX1JAtRXDVYya6hrmFF4sphJSz5VXJvz9D/mEfUGj5Y/bG6Pv6XMwOQU+duWXt4+CHP723UYsXPhEhFbd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBntQlEf7lv8HpNe6tMpKRzdL5YrZ6h7cDvdrv+1QeZJhxJvS8
	uvpNOxGJK+oT9Gw4o+WjFyl6ryU1zBw3SulkzEhDcwmxbOeJJpWYqmocAQvtkkI=
X-Google-Smtp-Source: AGHT+IEC17EB/IJUmMU3G5MrSDuKVOJd/AkOUmfnYOuz4m0Ufmsilaa1BcxFoMVn0wGFcbEWuW6q2w==
X-Received: by 2002:a05:600c:1c90:b0:426:6d1a:d497 with SMTP id 5b1f17b1804b1-42c8de79fdemr60732675e9.12.1725549562913;
        Thu, 05 Sep 2024 08:19:22 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1de81b2sm14031076f8f.30.2024.09.05.08.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:19:20 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 05 Sep 2024 17:17:39 +0200
Subject: [PATCH v2 9/9] iio: ABI: add DAC sysfs synchronous_mode parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-9-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Some DACs as ad3552r need a synchronous mode setting, adding
this parameter for ad3552r and for future use on other DACs,
if needed.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-dac | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
index 810eaac5533c..2f4960c79385 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-dac
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
@@ -59,3 +59,19 @@ Description:
 		multiple predefined symbols. Each symbol corresponds to a different
 		output, denoted as out_voltageY_rawN, where N is the integer value
 		of the symbol. Writing an integer value N will select out_voltageY_rawN.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Arm or disarm a wait-for-synchronization flag. Arming this flag
+		means the DAC will wait for a synchronizatiopn signal on a
+		specific internal or external wired connection. I.e., there are
+		cases where multiple DACs IP are built in the same chip or fpga
+		design, and they need to start the data stream synchronized.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode_available
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available values for synchronous_mode.

-- 
2.45.0.rc1


