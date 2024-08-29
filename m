Return-Path: <linux-kernel+bounces-306857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101349644A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303FC1C2488D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B11B140E;
	Thu, 29 Aug 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bCYOTh5i"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938451B0114
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934810; cv=none; b=qEb7hc0Duk5g1NB+5Qb+0iyDufxiklb+RhISFKKfF2LKybySEpTpqlvBHRlPl7s5m8CiizgMmbfjCDpVks4f/rNbPksyUVfERDpN2v4e96QuMXdPopbsVVsvUv/Mt2KLZAjXBvTzfqwc9Wnl+n9xl5HEC/LkbNFuztuEdmXa2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934810; c=relaxed/simple;
	bh=2mPWOtyTd/YBLFdmdjfe2ZHlnUKUTSLx+XgVmvWKRLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjPbr6LvsUYSzzxBaDuUyvmJH4nD1Mf1gZy/iz3TKMDndyfeKVsKQ5W+kN0KdZHTX+Rbb9HpDbyHPCOTlqLqqCuwm8ZDD66+mP/VDISbAHTta4P9BGYswoYHh1PAyn7v9tplbvjZHfCM/yyzbfHtVvL8hBFmxkA+xkqIBs7XKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bCYOTh5i; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371bb8322b2so346267f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724934806; x=1725539606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1lPvyLwxDQjEGBnGsrIyA9bdmn+GnJfAmZj6pMaXAQ=;
        b=bCYOTh5iayHuymcaJQrT4KhXgZiJPYbfIfJxSdTbevM3yKaW03uOlJy/gyrFUs9mO8
         oQCEDAjGML3FHjU3AjOf4f7DmHm+CWUSAEbacILnMAuGvy4BiRrdRS8gyNuX6deOuWkA
         b295QL78osWwbjnAz35Wxbr3tf66mhFB+WEv2fAuFHWAFvlK1TjlRZwmRczYTKbghv33
         1/5Xeo9HHsPhqsjvXGbBmiId8SX9kxYcjSvo3RHaNohn5ipdRLpb6xUq36cPC8zF1CTt
         /gB0XyV4DuS066RH+0/JGtbbL94u5ESljZ1Qe/v4x1jq2D3AApy44NIGSkQ9jplGTAnV
         fI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934807; x=1725539607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1lPvyLwxDQjEGBnGsrIyA9bdmn+GnJfAmZj6pMaXAQ=;
        b=iegXNlJl8YpDHBCDnITsmpHW1I8CZuHlEMO4mKe5gAw2gBxoSMhtWZ8gf4KGpRPnia
         EpIUblH1hzn6p4SO2+eNx0tSMH5TZjLbz7G/LtQ+vhZ1GXfDv98U1Jbb5eNSJ558dLU6
         +djLYV3ioxRq5HIM8xGye11zUdPl/NOqPyKo0VjXhVv+0V3sTFDkVx/+sctubgm3x5rM
         Al0ncr69ruXU1FAQKVMoxDUx3V8pmHGSkmBd972eBlPNbEIiIaymKxN3kE2HEL6cVS1k
         CvzPtsn0nQABDQNbvhXqH1zreUI1HSjUAZ+GDyKfEJnUzSHEJm6UI2nHEuJiWgWtG44k
         m0AA==
X-Forwarded-Encrypted: i=1; AJvYcCWaRwRu/qUzOR9eybUr9rTa9ibaqahkVNs687BM2zFruUibzT1FUR3g40QHDL3oByjYtkpxmLJKW633qvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKm1H57e9WryWsoYf22kUeK1YIZ4Un719dGyCcZU6+7SUowjKT
	U53y3rO12iUQShCqUyypmSTZVKqD47jIGhf6ypEqk0+akQjtfumX/2Cfaxa8FvvZuiunQCTJ4dc
	A
X-Google-Smtp-Source: AGHT+IFN3lOIB6gGygWvS7enFigGG4fh8ywN6uYsYc1jl1ZrAvYUvR4AaWIuj9iAzaNIUxh1F8FLFg==
X-Received: by 2002:a5d:61c4:0:b0:360:70e3:ef2b with SMTP id ffacd0b85a97d-374a02318f1mr1095378f8f.26.1724934806553;
        Thu, 29 Aug 2024 05:33:26 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9978bsm1315042f8f.49.2024.08.29.05.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 Aug 2024 14:32:06 +0200
Subject: [PATCH RFC 8/8] iio: ABI: add DAC sysfs synchronous_mode parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wip-bl-ad3552r-axi-v0-v1-8-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Some DACs as ad3552r need a synchronous mode setting, adding
this parameter for ad3552r and for future use on other DACs,
if needed.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-dac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
index 810eaac5533c..a3012baf90b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-dac
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
@@ -59,3 +59,10 @@ Description:
 		multiple predefined symbols. Each symbol corresponds to a different
 		output, denoted as out_voltageY_rawN, where N is the integer value
 		of the symbol. Writing an integer value N will select out_voltageY_rawN.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows a specific synchronization mode, mainly
+		intended for DACs where multiple synchronization methods are available.

-- 
2.45.0.rc1


