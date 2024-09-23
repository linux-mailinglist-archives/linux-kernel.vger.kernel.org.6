Return-Path: <linux-kernel+bounces-334575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8505697D90F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F831F235D9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7A817E47A;
	Fri, 20 Sep 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uLa9Iq+y"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D7376E0
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853610; cv=none; b=oRJ7BageIgStySnpIH6AUgiG/nBEMwV3AP2R+h7GC5thTENbsfDLFygdgrQAIRU5J0eClh5cW6hFKmuryp8HFBrJf0d2Vdv+WDUvP/a46nHguMKy85K2AcC7c6YCwlJNCG65DAKZTeS3AxSf4OEytHdp4aLAu8DcJKxci1DyDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853610; c=relaxed/simple;
	bh=1IlR2iZrx1TWLUUVujKhfxFMAELLRAU+i32cLvFkSvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q5v5GpcwyYpElJwl+OLxbxuSO/xZbGcBms5xTuo3l8cWiRSMD+m3/K5x7Zsu/Z8q6RtrGy5vFTYxR0p2abZYYaqOfIJ8tan9b1Mg2OkIXumQBtRvq8TnsxMj5xMr8eHRBEZ7dQg1XJoUQrKPziHbqTgsXxQp83ruQKzQsumAZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uLa9Iq+y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so20618375e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853606; x=1727458406; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UUFhGcTyiJvlWI+WlBNBe2epzsWpe+JtKV2K/AcAmk=;
        b=uLa9Iq+y2zz500I+S7qTrtoi5u02SKxSkBsp4IJ8Nktj6I15/rQZwDpP+/0PIJeUgC
         z6XEjjWiDeAz0ySrQu0llV/+2K9eF/yIE+GmnCVX29J2G4cIh+CdyixQz43cohnnBgwO
         x2RQ+2D6SkZZv9MMi12n3Ue/hwcomRBgu2wwb2eCBzJ5jzf2aoFBAaAWHMvN/mJz0xkN
         /NWnCYDbFcMfvEfew5e8kQJQyFT1RT799iEb6UGAtN034cORmgCVG9Jk/LfjKDmB4/FF
         LeWCkSGSd+WU2U1IggZzUkhAiJc0ukKRvjiGz/+uaKGRndQAFEIsppBEQ0nFcW4sb8nQ
         /cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853606; x=1727458406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UUFhGcTyiJvlWI+WlBNBe2epzsWpe+JtKV2K/AcAmk=;
        b=cvQJsQmPU91yppcICqLV91FRe1H0Jr98Cy5nI30DdiWfTs61Ezh+C2nWPh9nBeam5Q
         OHG16J51841JYrNYqC14/PlC7U0uxvC7oOreTqb3jGf/ZRkALiu24sJVJI3KlGzULcuL
         onky9E4egMQGkjyMdTQgBQhm6rzV6YA8JMLytia3GHHSvxm8+V/ARnKwYZJUBiqgBWqy
         v2yHv9hp+HlorGAXHaUkS3zJpERmSyQEdOoAUfzs3PullV3s+NOyCKF1mqWtf85zOFwT
         xt5ylU7W0HtWakCy9XbSqMWFLaTeBh4YXMDpwQLSKaXV/fquMGOl73rDi2B7gWs16e2M
         y8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY23iwuhbwA03UjIpOUsClynWWUNDyc1UCnsXaVNIm8gl2hnKHi7JTFOuMYYhFxXo/MfaJEAt3hVYWDW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdIkEk7TgOmP4oMkS3jIKB3rNPhHVqxBv19pAbIO/NrTfspw1
	RflnHGOKXXEj9kDPBD8IfGxJigy1uK5QiUEHd1MzqW1uzFeRXhKjq+wWCN0tZ80=
X-Google-Smtp-Source: AGHT+IGgCKLlGsFVnLPMMsSCnB8uD2rlgl4JGpdbipw0lqW+P0JA7xndJNxMakwiINiRxxfTey9q+w==
X-Received: by 2002:a05:600c:1553:b0:42c:b180:d452 with SMTP id 5b1f17b1804b1-42e7ac4b610mr28776055e9.19.1726853605527;
        Fri, 20 Sep 2024 10:33:25 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:25 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH v2 00/10] Add iio backend compatibility for ad7606
Date: Fri, 20 Sep 2024 17:33:20 +0000
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCx7WYC/4WOQW7CMBBFrxLNuka24yQuK+6BUDS2J2XUEgc7R
 CCUu2PCAbp8f/H+e0KmxJRhXz0h0cKZ41hAf1Xgzzj+kOBQGLTURna6ERi6VrY9htAzx96h/6U
 x9Pk2TTHNwhupatlg+60NFMmUaOD7dnA8fTjR9VZ+5s8IDjMJHy8XnveVdYS17SyqRinnCYPXg
 xu0NU5K532DmgoFeLvOnOeYHlv7ojbZlmnVv5mLElIUfU3lRiGag8PHH7tEu5ICp3VdXyRD0Nc
 bAQAA
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michal Marek <mmarek@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=4064;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=1IlR2iZrx1TWLUUVujKhfxFMAELLRAU+i32cLvFkSvg=;
 b=BkWA5UZ8sbnmCANhIMAVsLd2+kn0lyBQ/wmDqoeiqChuNU9MI4wLyBlKGIVmoeIkIMZWlUAnz
 HBqJyUAgKfrBimDDhdOZCtUAJeQfvVoU3mTMM+xAWQRyPa8roudXHYd
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This series aims to add iio backend support for AD7606X ADCs.

In a nutshell, iio backend is a paradigm to shift the logic establishing
the connexion between iio buffers and backend buffers into the backend's
driver.  This provides a more stable programming interface to the driver
developers, and give more flexibility in the way the hardware communicates.

The support will be first added on AD7606B, and on next patches AD7606C16
and AD7606C18 will be added.  The series have been tested on a Zedboard,
using the latest HDL available, i.e
https://github.com/analogdevicesinc/hdl/commit/7d0a4cee1b5fa403f175af513d7eb804c3bd75d0
and an AD7606B FMCZ EKV.  This HDL handles both the conversion trigger
(through a PWM), and the end of conversion interruption, and is compatible
with axi-adc, which is "iio-backendable".

More information about this HDL design can be found at:
https://wiki.analog.com/resources/eval/user-guides/ad7606x-fmc/hdl

The support is thus separated in two parts:

- PWM support was first added.  My first intention was to make it available
  for any version of the driver, but the time required to handle the
  interruption is not neglectable, and I saw drifts that would eventually
  cause an overlapping SPI read with a new conversion trigger, whith
  catastrphic consequences. To mitigate this, CRC check must be
  implemented, but indeed increasing the samplerate causes more sample to
  be lost.  Therefore, I decided to only allow PWM for iio-backend
  powered device as a first intention, leaving open the possibility to
  add the general compatibility afterwards.

- IIO backend support was added: Once the PWM support was ready, the driver
  can be extended to iio-backend. The iio-backend powered version of the
  driver is a platform driver, and an exemple devicetree node is available
  in the bindings.

The following features will be added in subsequent patch series:
 - software mode for iio backend
 - 18 bits mode (AD7606C18)
 - single read (IIO_CHAN_READ_RAW)

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Changes in v2:
- Logical change in dt-bindings, using a flag for the interface instead of
  infering it from the value of the "reg" property.
- Removal of get_platform_match_data addition, instead the logic is
  directly used in the file.
- Removal of use and export of pwm_get_state_hw, returning the configured
  frequency instead of the running one.
- Correction on various typos, whitespaces, bad order of includes.
- Separation of SPI conditions and PWM disabling for no backend in other
  commits.
- Link to v1: https://lore.kernel.org/r/20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com

---
Guillaume Stols (10):
      dt-bindings: iio: adc: ad7606: Set the correct polarity
      dt-bindings: iio: adc: ad7606: Make corrections on spi conditions
      dt-bindings: iio: adc: ad7606: Add iio backend bindings
      Documentation: iio: Document ad7606 driver
      iio: adc: ad7606: Sort includes in alphabetical order
      iio: adc: ad7606: Add PWM support for conversion trigger
      iio: adc: ad7606: Add compatibility to fw_nodes
      iio: adc: ad7606: Fix typo in the driver name
      iio: adc: ad7606: Add iio-backend support
      iio: adc: ad7606: Disable PWM usage for non backend version

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  97 ++++-
 Documentation/iio/ad7606.rst                       | 143 +++++++
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad7606.c                           | 474 +++++++++++++++------
 drivers/iio/adc/ad7606.h                           |  51 ++-
 drivers/iio/adc/ad7606_par.c                       | 126 +++++-
 drivers/iio/adc/ad7606_spi.c                       |  33 +-
 7 files changed, 749 insertions(+), 179 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20240725-ad7606_add_iio_backend_support-c401305a6924

Best regards,
--
Guillaume Stols <gstols@baylibre.com>


