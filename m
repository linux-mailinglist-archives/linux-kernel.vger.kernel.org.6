Return-Path: <linux-kernel+bounces-333322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E497C6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EE41F28142
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14308199E82;
	Thu, 19 Sep 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qtvIMknt"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CD1990C6
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737699; cv=none; b=NNMO/QgBp1/iBftRanUqb67QZk/IjqzImGCADir9caANjsuxypKWvjsq+T+ZGp2ki3nBO2nDFtLgasaIbNyiLrgUZRXrtrJxHC0LBFAKbMhn7qAbV9Ahm+WpgmdhBjD5eeC9fV/ntHmruKUqktUHYjmsaymQUHmyb8OYTBO7dVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737699; c=relaxed/simple;
	bh=9K94bsQInkxbf+bSNW5RZty39cCxuDTVv2CdbHV6Ex4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VVyRsDZD+cxa6xjkh3PUjNWeib6CmxnZUG0l7QAxYOhL4pQLYPQGFxsbqH8/57x9LMQnePdByZ3D8sFbVhe+SuUt6ieUGrZXI7ao++OoDEfCk+PD+GHtQhmRqFdefKIMI4ienq+Xhb6/PKWz1EfiF+FsA0fYdwx4DKA6sjhTUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qtvIMknt; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f74e468aa8so6656481fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737694; x=1727342494; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JMj5mfXiJJfo04AgibzT9+cKa765pGWiurrBxBDlrs=;
        b=qtvIMkntWFTIdUOYx9omD6UtlqwkvA6ZbOK0Ag2sueI1jgtB5BiWlf8PvL5WiS49QZ
         b6CWGk8HWLZLeiy7yQ5IyMeLCrNM/G9bWRLixHHsmEHiYzPUucixq7GIAOsZSZKBTylz
         6bVfUdyiJ4MCn5cuATQGdTe+IDvExcPK22WBYk+pk4mCg0GaQA0CVfyRwUxRW1B6e/U/
         vuj9LJ8EEki6TfZr4y3KW2BPPNP+WwMQBx734FsJS0QqpaEmNz/IpqUWBupvQ3jN67G0
         UIF4syFXFhy3zAGq55d4NYrPdvWx1ND2X/J2FpUXgT3eoTZxfC8O75gPNTBgnMCPHB9R
         O0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737694; x=1727342494;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JMj5mfXiJJfo04AgibzT9+cKa765pGWiurrBxBDlrs=;
        b=O8bPKojPEVwpnobg+tTSIlqHtE/18w7tfPweCA6Xznk2gOUodurQDRP/iXAxtbI012
         NGHzD3mcRXSUU7sYNSlIMgzrUbowYY9opsEY8F+Zcg9XHrRFHxU1JxNrgSWw0i0gumZM
         WW3fw2OGOFXmXbRWEfWknmFp4a+A/ExXbH0S2SdY/fkv3OqV4Ji7r0K18s/aNZ+yn2Kc
         pRAxq22lkwUFMVQXk2pMq+DPfviJ4NmqutfQV756Vf3PohophMY0VloPfGYtzcfxxONu
         OlP4jnTm0C0yPt3IX/y0q/PwFOYhOhQEtkZwlaMMKFN0D3dbzOEXsoS/HNkr+E2Hx4C7
         IVbw==
X-Forwarded-Encrypted: i=1; AJvYcCWXp6O/coaiytfqQAyZaFGGPJ5MQgajM/HWVKiUyM4hYTJD8M/3jP13X1qEEp28QtldtLHbiGYDNe+/ee0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWn8UY+ewPc+6wEhQl0coUSH99BuB/KLi1ZhwHdY0HXjGUvHNA
	5xJmC9yArXExl+HeXcU96AgprgIQs7FZ3U5FwLeHAj8SyYnh1QPgx4jWJhFJekU=
X-Google-Smtp-Source: AGHT+IGM0Y3r7+gNR/DSAnIT1d21KFJtZd49LfOQKMIvTneI3LyvlzrzglH45meyrNtV1yUu2X09Yg==
X-Received: by 2002:a05:651c:154a:b0:2f6:4aed:9973 with SMTP id 38308e7fff4ca-2f787f5833dmr154394841fa.44.1726737693720;
        Thu, 19 Sep 2024 02:21:33 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:33 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v3 00/10] iio: add support for the ad3552r AXI DAC IP
Date: Thu, 19 Sep 2024 11:19:56 +0200
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzs62YC/x3NQQqDMBBG4avIrB2YJBWJVxEXqY72hxIlERXEu
 zd0+W3euylrgmbqqpuSHshYY4GrKxo/IS7KmIrJin2JN55PbPz+cphc09jE4QIfwsDKu+YdceH
 We9eKETXjTKWzJZ1x/R/98Dw/3fA05XMAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

Purpose is to add ad3552r AXI DAC (fpga-based) support.

The "ad3552r" AXI IP, a variant of the generic "DAC" AXI IP,
has been created to reach the maximum speed (33MUPS) supported
from the ad3552r. To obtain the maximum transfer rate, the custom
module has been implemented with a QSPI interface with DDR mode.

The design is actually using the DAC backend since the register
map is the same of the generic DAC IP, except for some customized
bitfields. For this reason, a new "compatible" has been added
in adi-axi-dac.c.

Also, backend has been extended with all the needed functions
for this use case, keeping the names gneric.

The following patch is actually applying to linux-iio/testing.

---
Changes in v2: 
- use unsigned int on bus_reg_read/write
- add a compatible in axi-dac backend for the ad3552r DAC IP
- minor code alignment fixes
- fix a return value not checked
- change devicetree structure setting ad3552r-axi as a backend
  subnode
- add synchronous_mode_available in the ABI doc

Changes in v3: 
- changing AXI backend approach using a dac ip compatible
- fdt bindings updates accordingly
- fdt, ad3552r device must be a subnode of the backend
- allow probe of child devices
- passing QSPI bus access function by platform data
- move synchronous mode as a fdt parameter
- reorganizing defines in proper patches
- fix make dt_binding_check errors
- fix ad3552r maximum SPI speed
- fix samplerate calulcation
- minor code style fixes

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

---
Angelo Dureghello (10):
      iio: backend: adi-axi-dac: fix wrong register bitfield
      dt-bindings: iio: dac: axi-dac: add ad3552r axi variant
      dt-bindings: iio: dac: ad3552r: fix maximum spi speed
      dt-bindings: iio: dac: ad3552r: add io-backend support
      iio: backend: extend features
      iio: backend: adi-axi-dac: extend features
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intended)
      iio: dac: ad3552r: add axi platform driver
      iio: backend: adi-axi-dac: add registering of child fdt node

 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  44 +-
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  40 +-
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   3 +-
 drivers/iio/dac/ad3552r-axi.c                      | 567 +++++++++++++++++++++
 drivers/iio/dac/ad3552r-common.c                   | 173 +++++++
 drivers/iio/dac/ad3552r.c                          | 451 +++-------------
 drivers/iio/dac/ad3552r.h                          | 199 ++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 328 +++++++++++-
 drivers/iio/industrialio-backend.c                 | 111 ++++
 include/linux/iio/backend.h                        |  23 +
 include/linux/platform_data/ad3552r-axi.h          |  18 +
 12 files changed, 1572 insertions(+), 396 deletions(-)
---
base-commit: 4ff29e5af68e081473240420d5ba8fe1c410239f
change-id: 20240919-wip-bl-ad3552r-axi-v0-iio-testing-79937010e1cf

Best regards,
-- 

  o/ QW5nZWxvIER1cmVnaGVsbG8=
   www.kernel-space.org
    e: angelo at kernel-space.org
      c: +39 388 8550663
       


