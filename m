Return-Path: <linux-kernel+bounces-268655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A97942767
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E6284547
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7B1A4F2D;
	Wed, 31 Jul 2024 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vk5/mINM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22016938C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409552; cv=none; b=iCs4E3u0J4/I0dOB90xttbhN6d7FHIZ6uuDqa/T8v4nduVQlyE4IXPdddeoUeLJzCHRSudk/hJ5n2LjEV6pn9dIxknkzltMz4PU0kF02ABj321XBq/RfHXlFcsYrNbCegoeTC6iDo5BDhkjC14FBuz9dMpefmLA+0an12NdLrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409552; c=relaxed/simple;
	bh=TwW9uB5kaXzH10sP2oUv5k/SP6QlVLmAcTZDbEgNWKI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dYRf+IMZ3Y8kty8a9UeTVGL+WDqLUWbwczN/No+3sGJbIC9bclsTyN6btJ+ByUGUNYmMVUeN1P8hxFROKygsTIxXXkx2KKqDT872CN9/R3bK2fLTNxTslH9Rv1flJEvhKDwQ33Po1IBrxEip9vCmXRNCO9noJTxTgMD1/GI9EJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vk5/mINM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281f00e70cso22770595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722409548; x=1723014348; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFYqoVjdKBqJJ0AMbWdTPPMfMKO5hEJlX7ZoGx1Cdks=;
        b=vk5/mINMtK9KA3lithVX6Ez2AKmN8S8jDnO+Cie0cYWE0YQM1IbUo+OfDsO56MAuze
         prPp5oTpoJqpEo2JrghsqAjUSy1E9R++xYgIwwb9VcQrb9IZ9a+dyAg/WZ2CfdHfvZNt
         mQZgg9LMgTiZ5Q1Ja+pSPpzBUn27/9tdyR7VdTLNdeLzWCQ0/L9K9uMmg3noztxDlTpF
         cNUnbb08ajJZ3jAyv158gTPXLS+X+53ZGhYr6f1AD/1IJseM/3ulbv3M5LtpUYr1qoqM
         /NvwIRauVv4Jd3slHqT7CYMboL4HHUrTV+e8vkWu1YJF1JyNMccHiI0g163+3qnkHCP4
         fqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409548; x=1723014348;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFYqoVjdKBqJJ0AMbWdTPPMfMKO5hEJlX7ZoGx1Cdks=;
        b=W0MJGViFbl2Un06jA0DG+U3lif6ru2st+Qjie/Gf1ABwVlwBq8wTe61Hxs0CEmHFiP
         S9W38fBJlx8Sl32oY7cC3Nq+6tx+fbMkAO0Cudfr+eSKh7IpD2kr8GIFBWHWUiqFXURB
         UT1LQgKoH0EsprL/g2rQMoyss2FIjxXiaUXCFHaAf7YWrWxEyGFFW3TPcHi9CQ2wx94F
         acJT0N1m/BVUcz5wefqSOjna5OR1nS950V/ZZAeW+/KJLE2wlzkuGzl8BiePoI1T97j6
         NQeccvUcwZVkspHbA/lUTTFDq6E5QRqhTKCpTpaXREBx4j2bZ98GQZjwM9uTfAZPbF8R
         QLzw==
X-Forwarded-Encrypted: i=1; AJvYcCUjuG/3kPLS3iRQdOvkiW8Pro9UVvQur1bPArK3RlS+KM/BJQsBwMhQmcnHGa/eU8BznGTYqYY1f8JN83zzefIIWR21Vpo0x21Lg2Iu
X-Gm-Message-State: AOJu0YyJq8AQ8TlaLFXyhQKH+KJqTUYo9wVeYaVQY/5uv5xIlepi3f9V
	SCVl59oQJ0rW2IIrqNK1RoH1Qhw0PIGRGPWsn1AJbwX35ShSOq+h0cG9A+qCenI=
X-Google-Smtp-Source: AGHT+IHiaaerw1bIXIQ7OlZ/stjeMwoVSRVTt931IpiunAkahT1taTu6u3snufdLGDK++gGWIHW7dA==
X-Received: by 2002:a05:600c:1551:b0:426:67f0:b4fa with SMTP id 5b1f17b1804b1-42811d739c9mr85120175e9.1.1722409548067;
        Wed, 31 Jul 2024 00:05:48 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2593sm9953215e9.4.2024.07.31.00.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:05:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/7] ad7380: add support for single-ended parts
Date: Wed, 31 Jul 2024 09:05:41 +0200
Message-Id: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXiqWYC/42NQQqDMBBFryKz7pQkioaueo/iwmSmOmCjJCVUx
 Ls39QRdfd5fvLdD4iic4FbtEDlLkiUUMJcK/DSEkVGoMBhlGtWZFgfqaqvKECYJ48zIgZjQT7I
 mdE3dkfbeOuugONbIT/mc/kdfeJL0XuJ25rL+vf+as0aFhlpjXau8J313wzaLi3z1ywv64zi+n
 AOtGc0AAAA=
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

This series will add support for ad7386/7/8 (16/14/12 bits) unsigned,
dual simultaneous sampling, single-ended compatible parts, and the
corresponding ad7386-4/7-4/8-4 4 channels to ad7380 driver.

These parts have a 2:1 multiplexer in front of each ADC. They also include
additional configuration registers that allow for either manual selection
or automatic switching (sequencer mode), of the multiplexer inputs.

From an IIO point of view, all inputs are exported, i.e ad7386/7/8
export 4 channels and ad7386-4/7-4/8-4 export 8 channels.

Inputs AinX0 of multiplexers correspond to the first half of IIO channels
(i.e 0-1 or 0-3) and inputs AinX1 correspond to second half (i.e 2-3 or
4-7). Example for AD7386/7/8 (2 channels parts):

          IIO   | AD7386/7/8
                |         +----------------------------
                |         |     _____        ______
                |         |    |     |      |      |
       voltage0 | AinA0 --|--->|     |      |      |
                |         |    | mux |----->| ADCA |---
       voltage2 | AinA1 --|--->|     |      |      |
                |         |    |_____|      |_____ |
                |         |     _____        ______
                |         |    |     |      |      |
       voltage1 | AinB0 --|--->|     |      |      |
                |         |    | mux |----->| ADCB |---
       voltage3 | AinB1 --|--->|     |      |      |
                |         |    |_____|      |______|
                |         |
                |         +----------------------------

To ease the review, this series is split on several commits, in
particular, sequencer mode is added as an additional commit.

Cheers
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Adding a new commit to fix the previously missing trailing comas
- Adding a new commit to introduce a new core function
  `iio_active_scan_mask_index`
- reword commit messages to add the `iio: adc:` prefix
- fix minor comments from Jonathan
- use the new iio_active_scan_mask_index and use some enum definition to
  make the code more readable

- Link to v1: https://lore.kernel.org/r/20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com

---
Julien Stephan (7):
      dt-bindings: iio: adc: ad7380: add single-ended compatible parts
      iio: core: add function to retrieve active_scan_mask index
      iio: adc: ad7380: add missing trailing commas
      iio: adc: ad7380: prepare driver for single-ended parts support
      iio: adc: ad7380: add support for single-ended parts
      iio: adc: ad7380: enable sequencer for single-ended parts
      docs: iio: ad7380: add support for single-ended parts

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  13 +
 Documentation/iio/ad7380.rst                       |  42 ++
 drivers/iio/adc/ad7380.c                           | 525 +++++++++++++++++----
 drivers/iio/industrialio-core.c                    |  43 ++
 include/linux/iio/iio.h                            |   2 +
 5 files changed, 543 insertions(+), 82 deletions(-)
---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240726-ad7380-add-single-ended-chips-b437d1cc8b8b

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


