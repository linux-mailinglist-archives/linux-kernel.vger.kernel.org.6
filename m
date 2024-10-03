Return-Path: <linux-kernel+bounces-349380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CA98F517
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288001C21963
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114C1AAE01;
	Thu,  3 Oct 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e7fH+/zj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116E45945
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976632; cv=none; b=q309OL/QyoInryBVAZbETvSaL6zCmTIaKi+fRM1/yZ7oVFG9mTiVOqxTO/tffr2yfHMmILEzxZ+/W90UpVaohafVMdPuAp7ZiOoqcFAcGB1X4zr3kknlf+9iX8Uv12TFBtxsM7rAhZ4Bx9E1/yOrdi6PuXzlRitLwE2L0dLS1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976632; c=relaxed/simple;
	bh=uc27P6VnnafEjEmGbzTR1uNC9EeE+6hsT3zNRyI144s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PP3YGZEVfnzkwc+HKQjl2V7c4FR6hd9NV2tP502Ot17TJ9rBtoaU4Fdb93MIhtLc8LSxAcvcjG95zu7sVtfS1/JcMY8WH6zllaBVDr72qMnnHcVO+uKvoghBLeeAyJjBI9Tb9u7+i7PQ0bww6q0iJ29cU5sn20q2VRImNJ0X8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e7fH+/zj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so11505765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727976628; x=1728581428; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9gp9Be3jODx//Gz396+P4LheyhP3qPB8cEv8qE5uzs=;
        b=e7fH+/zjpHj27jQguwiZFwFw6oYUQyYix+6srAaotzq1uHO/ObvHFgfBUGbgjk1aoE
         VaqCgyJrocJQ4YquTjDy4lfr4RBdSObONM+9qZou+eeRDA7qT3FCKqV3ZzTQQNgNad0M
         iBsELYnrH76FKmEQwdGy7CrnMPynuLR5L8czyCZCbrOwxiCm2P/V+u1wsuyk5yFOsKDj
         zkRHPTmCMXuPDAzNJrHGPos5GfbzF7i/uNtor7uCnl4272vhmKzdXTEN8ZVIeYtaGUNb
         XhgML6DV/XJq3Xvsoc35Osv3QO9N6Jb9hd3wVcOcYQhFXUvUxp+Bqs26hebCEXmnAbTs
         ULKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976628; x=1728581428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9gp9Be3jODx//Gz396+P4LheyhP3qPB8cEv8qE5uzs=;
        b=VrTMHIw21Zkfxiy/5xaH5HhPur/7KXPBxvrZsxIDpKzevPnykAA0c9GPPgESXU4TpE
         JLBFwTZSZCibdop+5xGZIs7MQ9cmDD1R8busOFRd+fCSUlxNe5T6iPDThs5Wqkj0WIOQ
         JE0kcRnppBiAiLWLvtQIG/qke3A2xvTmc3TQxALApR72JmKTd3bogeZ1T9KpOVBxBOr+
         f2B2UqH3bf2eLVc3KL5kxyrZtyF2QqWJ7HBTeDJkXRQ441ahhb3nxN7y146iSzIJAwqt
         +WnYkkQeFIUbJzPlxphHCXuon7PTsLjn7Kuw1GCw+EiB4DrDgAklyzDu+ZagLplz129x
         a47g==
X-Forwarded-Encrypted: i=1; AJvYcCVrtw3Nvy8KF8Z8Tkb4V7f3OWihx63aAGID/7xaxMI6rVhUpp5nUV5UNYdFq58AszP0XfpBaVWhLf5030E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAe6i5YRwZzubERuiCxwlMEMVm5RSlVkgbcV2AlG3QzPhXTm6S
	OGzqsnlIoI1+/5zMQfiHVTk2l5vTu/NH2zCW0hG2H2vPWsNOcoOljyk58KYLNy4=
X-Google-Smtp-Source: AGHT+IFQJqgSsd+ydWAEUk6ztH5sTLfuVzMUOXz/AOuEk7VjfxA0RDkH4s6BbDSdbo+slFntgYooVQ==
X-Received: by 2002:a5d:58f3:0:b0:37c:ccfe:fba1 with SMTP id ffacd0b85a97d-37d0e7d325emr83683f8f.47.1727976627658;
        Thu, 03 Oct 2024 10:30:27 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d116asm1703735f8f.90.2024.10.03.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:30:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v4 00/11] iio: add support for the ad3552r AXI DAC IP
Date: Thu, 03 Oct 2024 19:28:57 +0200
Message-Id: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnU/mYC/x3NQQqDMBRF0a3IH/dBTJTSbqV0kJof+6BEScQK4
 t4NDs/k3l2KZmqRZ7NL1pWFU6robo0MX59GBUO1WGO71hiHP2d8fvDB9b3N8BuxGpATFi0L0wi
 vQQenjzbGu9TOnDVyux6v93GciwwcKnMAAAA=
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
 Angelo Dureghello <adureghello@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

Purpose is to add ad3552r AXI DAC (fpga-based) support.

The "ad3552r" AXI IP, a variant of the generic "DAC" AXI IP,
has been created to reach the maximum speed (33MUPS) supported
from the ad3552r. To obtain the maximum transfer rate, a custom
IP core module has been implemented with a QSPI interface with 
DDR (Double Data Rate) mode.

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

Changes in v4:
- fix Kconfig
- fix backend documentation
- driver renamed to a more gneric "high speed" (ad3552r-hs)
- restyled axi-dac register names
- removed synchronous support, dead code
  (could be added in the future with David sugestions if needed)
- renaming backend buffer enable/disable calls
- using model_data in common code
- using devm_add_action_or_reset
- minor code style fixes

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

---
Angelo Dureghello (11):
      iio: dac: adi-axi-dac: update register names
      iio: dac: adi-axi-dac: fix wrong register bitfield
      dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi variant
      dt-bindings: iio: dac: ad3552r: fix maximum spi speed
      dt-bindings: iio: dac: ad3552r: add iio backend support
      iio: backend: extend features
      iio: dac: adi-axi-dac: extend features
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intended)
      iio: dac: ad3552r: add high-speed platform driver
      iio: dac: adi-axi-dac: add registering of child fdt node

 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   9 +-
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  49 +-
 drivers/iio/dac/Kconfig                            |  14 +
 drivers/iio/dac/Makefile                           |   3 +-
 drivers/iio/dac/ad3552r-common.c                   | 170 +++++++
 drivers/iio/dac/ad3552r-hs.c                       | 528 +++++++++++++++++++++
 drivers/iio/dac/ad3552r.c                          | 461 +++---------------
 drivers/iio/dac/ad3552r.h                          | 207 ++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 477 ++++++++++++++++---
 drivers/iio/industrialio-backend.c                 |  79 +++
 include/linux/iio/backend.h                        |  17 +
 include/linux/platform_data/ad3552r-hs.h           |  18 +
 12 files changed, 1563 insertions(+), 469 deletions(-)
---
base-commit: c81ca31b5191ef48b5e5fb2545fde7dd436c2bd5
change-id: 20241003-wip-bl-ad3552r-axi-v0-iio-testing-aedec3e91ff7

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


