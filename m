Return-Path: <linux-kernel+bounces-571907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB8A6C42B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FB04643CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F4230D3D;
	Fri, 21 Mar 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HG/7pIh+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E8230BFB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589009; cv=none; b=FSh7qH+VHs3rXFYXCN34zHqNp5ViBta9UfVfwLCFXbAJv0GUKrhPxA3WIM+BxmfaZ5NxiQzK9UPAahagBF7r5evr1Y41n8oHOj8q3g2E4eNH52c51Ltw5s0m/fpiVghh2I+yMYeRW8hdqUjlR/eISqov/LUm15l2s8YZabLjkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589009; c=relaxed/simple;
	bh=PlGObf3FoFSVjLZ3+lkHVytXNt5oNV1sykTKJih/nGY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K+TUEwEK1CnU/MPhPkjKbPVzjs0y+XbpWbraMJM5RG1+6+uPu7TZf0aAidD644HuPZHRR7THHoU2cH5cuaNnWV2pfVE2VCxVB24GjsO1/31AtrNOzw8nuMod2Ho3/lEfyhqXfDJ0l1925iK3Lw4l7uS28G1AO8yT7svjZrx65co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HG/7pIh+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso15510145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742589004; x=1743193804; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0lB23+k9X4O/rcO+siwkQMd1AepAsIgIgh1h0N3Brs=;
        b=HG/7pIh+UGrJ1vPiA+bcGEd9XkwrrJc18Qro3mnBfAX8Bf6N2ewUlT7aDKV7ArcetZ
         ccYidspGqMaBsELktOrO49nsBOlyG9Ej4gFewyJxUActmIJdWq8AVGolom652RQONhPw
         m4LTSi9TjT4DUzd7N5uBe4b8wjuQWFGdoYXLZNhCl4K1eGIuIjF3oBFKxBMHmmRYiBQi
         y67ecypptgTzyFfVXRs98xsI/+fbh/SOzkz6A5ghlP98why9T6+JvwueglxC6aOqOU+9
         ie7MX2V1NIfP+4xdXuAcB7I+i86p+FRXnmDCvEIMIxC2BSAdU1UPDyzD8mgL7fk2vVBs
         4AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589004; x=1743193804;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0lB23+k9X4O/rcO+siwkQMd1AepAsIgIgh1h0N3Brs=;
        b=ElbHeTpaU9fAb5rXxcXJDP6ElMIGnHOWW7bQlRCyUihZxwWkeDuyHBG01gNAVD3W+r
         D3IjsgsFusuaDNN0kpVVw2OjayE/pv0hCxFb9dVLmQVOLQdDb0VIYUHy3DSdJBiYBPss
         +OHkt1Q47DVq/KEWBeEkLYU9gPIzHxRH7nPjr9UJWPSfvBLD3AdxMsBFKSWgm0S5sr3B
         t0g5XA8hrwHC1oWpSBIsLVcuF0+JkXrpHjl5wESxnqhIW176DXDKZsIq+RwSMp2zjrcC
         JgAJlwKinIqgMYehSQCCZ4od4PfolkiZyg1hG+zz3bAk4wWEI7j6SB6eOHZyV4XaGGUA
         N6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUwdPXphbszTQMJWHFHAIzy8zee15EoxiAxh979+KAIwgO2COJHDe8vOPtWBwTI/tTs1YAQoih6vqnCa4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd8zUcOZlViOMT3IyLqdAxEYY7bChBrTShUMkHefIn8sHEx9DC
	LSmIDjThl6UTH3C+ThSMKNCioMK1UwO3RlkhJ7S6ij+2kEanIRsKbjsnLt/FzRo=
X-Gm-Gg: ASbGnctWUieckTfswqmasWsHJ18bWyPD2mD9ivFx1ibbQdAoSK48nsn/V79P/8/mGe+
	c/+ipvjr+Vq7VKraBaUr32IIdANlYxgvSwze2KMeoIgb54/+YmMUf/YxCwQIPuNX8GkSMNulV8m
	IThP7RcT7aF0y3CItt5Gb4K2Cl8+s9XjiFpywEwnbv2Xf118+c5jY+Ss2gm9XAYUFPh20SMloJq
	HSO7/WboJQ+ymDHIYHndJ02E1GZ3UsczbPZnatEekIoiuENoo/MMbeOvCtcfiww4/uUWB3MfuiL
	U2k4fKcYUQH96GW/YFLn2nZL7fUTJNOUDq0hbgtv+eewfJi1xjOoeV1/HyREWKWKB2friB2QO9D
	9UkanUAorxhtgBQ==
X-Google-Smtp-Source: AGHT+IGjVzjsQhl5rDbYi4VVK/fRtIMiZvFWgaXPd9JuriqnNE+STbPvOWFVdMkEYe4bCMacXf5xgg==
X-Received: by 2002:a05:600c:35ca:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-43d50a4adabmr38674315e9.25.1742589004317;
        Fri, 21 Mar 2025 13:30:04 -0700 (PDT)
Received: from [127.0.1.1] (host-87-8-62-49.retail.telecomitalia.it. [87.8.62.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9955c0sm3258380f8f.3.2025.03.21.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:03 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/4] iio: ad3552r-hs: add support for internal ramp
 generator
Date: Fri, 21 Mar 2025 21:28:47 +0100
Message-Id: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/L3WcC/x3LSQqAMAxA0atI1gY6Ol1FXFQbNSAqLahQvLvF5
 ePzE0QKTBG6IkGgiyMfe4YsC5hWty+E7LNBCWWFVhJvPnHc0HltrQo480MRjdNN1RozyVpAXs9
 Af8hnP7zvB2PT81VmAAAA
X-Change-ID: 20250321-wip-bl-ad3552r-fixes-4a386944c170
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Add support to enable the HDL IP core internal ramp generator,
actually managed by the adi-axi-dac backend. 

It works this way:

/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage0_en 
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage1_en                                           
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/enable 

Activating ramp generator:

/sys/kernel/debug/iio/iio:device0# echo -n backend-ramp-generator > data_source

Deactivating:

/sys/kernel/debug/iio/iio:device0# echo -n iio-buffer > data_source

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Angelo Dureghello (4):
      docs: iio: add documentation for ad3552r driver
      iio: backend: add support for data source get
      iio: dac: adi-axi-dac: add data source get
      iio: dac: ad3552r-hs: add support for internal ramp

 Documentation/iio/ad3552r.rst      |  65 +++++++++++++++++++++++
 Documentation/iio/index.rst        |   1 +
 MAINTAINERS                        |   1 +
 drivers/iio/dac/ad3552r-hs.c       | 106 ++++++++++++++++++++++++++++++++++---
 drivers/iio/dac/adi-axi-dac.c      |  27 ++++++++++
 drivers/iio/industrialio-backend.c |  28 ++++++++++
 include/linux/iio/backend.h        |   5 ++
 7 files changed, 227 insertions(+), 6 deletions(-)
---
base-commit: eb870a5af7db1e5ca59330875125230b28e630f9
change-id: 20250321-wip-bl-ad3552r-fixes-4a386944c170

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


