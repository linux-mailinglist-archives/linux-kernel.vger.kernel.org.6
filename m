Return-Path: <linux-kernel+bounces-349385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4AD98F528
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAEB20998
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8E1AC43B;
	Thu,  3 Oct 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NT5Odzan"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1F1ABEB5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976641; cv=none; b=fGhJZZS4MNBiB7Um0ZpS6Zvs3jp3jLcGGv7sxJvc7Bu4rBiMdLZU8HSRxQ8Vvy9Tn2FkXLQjc5XrXZDMmbKOumD9NL3kybdHiLpi26an0UAerCeRGKtu/ESWkzF0TWDI7SI9m0q/8/Mb0WK+unjot5BJpwE/JoA2ahXEZlC3Jvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976641; c=relaxed/simple;
	bh=MIEEwkhOG38M5YbxH7EoM65zJvKWZr3llNeZYrc+gKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVCcm1/nFSJA2nLU1TH72IZMBtYdRhfw4aA4E7LakKFfv7GgZdTOKIf5bDt7FdGfLtGwsMHc03uOWRj1CFHicakhDYmByXQqzOQDbV6+GtYRmy6imLAZKRj1xnFqj5pVOwk3kTjFxxwU/qTbtOGk92hLUF0aknvrR/RCpzGfXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NT5Odzan; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso11056685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727976639; x=1728581439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQNtccmxgXmF+t4Bajj5fcsgTgHr+MMu0di7epZS8fc=;
        b=NT5OdzanMOqHTkseI4R/mdLNXDln6vnLuH7fxVizTAiWi/7YonS1BvhFGOXsPAQwbm
         7I55Fcvxtao8UBAui/UzCqKRxtrqmdRRs+j5uysS/ld0l/7sJuHvQIKGsL/WdbGLubrv
         8po79+aliDp4eeYT6XGmnWQRDUaiLZK9/3jgIZl/+DBvUgXVgYQcwrmiEuw/RsmdRxcZ
         OzD2PZtrWCYki1oFfvoLPwK+2o9cM4op6gyY3HlFcpWJJdrkJ0DufCrnz6glhk0/3urt
         MZNajS8E450IiHr8dPrahSHiaTcHoBmtW8aGLLlvXJUJd+JufeOiXT8UDcMgYoCoMN1f
         mabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976639; x=1728581439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQNtccmxgXmF+t4Bajj5fcsgTgHr+MMu0di7epZS8fc=;
        b=pmF10JjCjUFIRbztAkNtcSnZpOI/dyNGWumwrPG4SHCL0F7vMnyVBMuYWEp/tMK7vB
         NkIBtqt54mJR36L8zbGXNZomWhERps6dyUMI1WZEUR2lq8DHEnU96lGhWsfxnTmqFI7M
         aLD2nhcVP0NGpJGMF0NUJJOIZlJivpcz31w8uKWPgGLqs8x4jeKRqVLTdNSFJbOw/ldH
         mltqsUkJQ8ssBuhi3ZdBSNDehVeYXUROtkPttOJ5q0UFhcG6c+/TxTnhg0tE1m1BFw5H
         K6GbY5VSDEuMPadAFIJrB7CAdK30ioscSScGqHkdNVOlwSBzaP2W5EnqqUa4M67gHZvQ
         Q7vA==
X-Forwarded-Encrypted: i=1; AJvYcCXTH6A6Qp/HNPwpFHLqPBsAWRyUUg77eevUCeIMLyI/iQ7VKUjQdVjt+m4Q44TfGkxiSzgw1WevYRJ9pnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaPOp2dxlh6bWhb9uB3iVzi0GNOayRVD35xhSan5/jvPJHUsC
	+79mQjLVTjpfDcVD9DZ3HZIgeP5Y8hAOCad+UZB1Cj/Hccnv//6mlBuRsroa984=
X-Google-Smtp-Source: AGHT+IFWFa/T8ohFET/z2ApjgDzCWK+faSk91oifc7Bz+kdUCIvf6iPYh8V9AH8b7A5z30jFcZMdTA==
X-Received: by 2002:a05:6000:184e:b0:374:becb:d9de with SMTP id ffacd0b85a97d-37d0e8df8dbmr100042f8f.44.1727976638546;
        Thu, 03 Oct 2024 10:30:38 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d116asm1703735f8f.90.2024.10.03.10.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:30:37 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 03 Oct 2024 19:29:02 +0200
Subject: [PATCH v4 05/11] dt-bindings: iio: dac: ad3552r: add iio backend
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-5-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version of AXI DAC IP block (for FPGAs) that provides
a physical QSPI bus for AD3552R and similar chips, so supporting
spi-controller functionalities.

For this case, the binding is modified to include some additional
properties.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 41fe00034742..2d2561a52683 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,6 +60,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      Device can be optionally connected to the "axi-ad3552r IP" fpga-based
+      QSPI + DDR (Double Data Rate) controller to reach high speed transfers.
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -128,6 +134,7 @@ patternProperties:
           - custom-output-range-config
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:

-- 
2.45.0.rc1


