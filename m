Return-Path: <linux-kernel+bounces-333494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065A97C9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CA2B2237D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F219E7F8;
	Thu, 19 Sep 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BA4G58mx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB8194C61
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751094; cv=none; b=Rzv7f2EwIDWJAzwYITYmyIw0xRgo9SI+PnYMNAfLWEwclH7gtZv5I7rXLJofl4nvatqc99B02/mCV4Jy7r3twxaGjntTw0HFbuPRedSL9J76x+473fDQ1cN8RXJaIRvOARDFNO8/+CExJ90OA6g6hj7xu9StMAuPkBwdGUdKADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751094; c=relaxed/simple;
	bh=aQl/NxShUprnC2b+9grM0A4QGLny2bU7L4Qp5Whiz3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvnnATs+u2Gf79nkdyftScbqlIfqIvaHOnJHvTRBPSxWXzXyedDyYIkTo4UvMJkAwwLSU1TbsexEdOve4UKW4lfyco8qImFC5AA46JCfHcFWY1stQ4ruk7In2Ub6celrqcDJ/2FflWuIe5jgDMBTodZRI8ptzrG0Pkwxv8DxFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BA4G58mx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a81bd549eso103739066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726751089; x=1727355889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=515pEkcij4ovzOHSJEz5q2lTMiO5hOIlkb3+5UAM9PY=;
        b=BA4G58mxyGODspGXq7NQsCMO/K/dLMvZGt+sThxUdHu1fCSRhE0CInxvxXZO6Dv63D
         kccxCrZbl95KOHczTSMIEQLdEqVf9f1d99bjD22i1LJ0Nb2brc6zUBqoD+1+WJ5Nzn+e
         8YCrt5gkSHBgvU5UoOcKaU7quvk3FFpDQHNdSuim7k80olMQ8tSbNc2m+CMbL/PMNO0M
         9b+awUPhfhZbhgaMeTYZJNrcXwuhwDH4EYT8DTsk9Umk/wtN+88ydFZ9ZoWZuhy1HjPG
         Mk+sdIWvLRH59anR97kFnMoMgquJcjuF1T9syPkxg7ccRd9ogyY3mbZfhKy38UYwDvP6
         NoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726751089; x=1727355889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=515pEkcij4ovzOHSJEz5q2lTMiO5hOIlkb3+5UAM9PY=;
        b=qFRCOmPdQz7DPfusg7CfXWX2ruCDcupYSWQiMtF9gKVq+gfCAa6JygjjKFXwmJ6jaP
         MPteVndM3Wk3Ku031OxxOykgWyZBNZBb3lzz6uEl9pHrQmkygskYYtVV4XbnjpMqA7Ey
         8KS4rqG3TAZTLzFEa85NNXdbR8blrgqnMvSi1zDLaLFN/aLXBs7Jv0HVQvrGnpwuBak1
         S/MqJcDP6aguJEkF4nR6xNlp/qIeTE1B+k0IgkpcNisCQvkOOt3O624NWrP/0Y7AsW67
         sfVt3VEW2mRxuK2Qxsx8A++6dhZ9W0StwU154jvrqShLG7SJa/a3NST7EEB4+QDNXyo/
         b3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUglJiUi1F7VCabTNRzM+EXGaGHrWhXR/Vmo0XAYIzKvYRSMQeWOh1BGfmkFMzyUAmdN+qQFFxzYl/lw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyShQTjwkSGBShw5+t+rt3/CJZMGZVsTe8IK+60f5a++3+hGTYn
	b5+tB8p/iE0FGcJ6RmuFepXKSC/fo+Wrl1SY0/fT3rtpmH2j4Q39jdtJIgHQmUs=
X-Google-Smtp-Source: AGHT+IFlmJtpRYhHfx0BiwPz5JQmkQCTHftk3nBMgzKQ3/2NLRBrzYs1cqhAl7t0oRhqnDZOhq56aQ==
X-Received: by 2002:a17:907:944c:b0:a8d:68fd:cae6 with SMTP id a640c23a62f3a-a90296eab46mr2850005666b.49.1726751089105;
        Thu, 19 Sep 2024 06:04:49 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm53213166b.124.2024.09.19.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:04:48 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v7 0/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
Date: Thu, 19 Sep 2024 16:04:35 +0300
Message-ID: <20240919130444.2100447-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
The main difference between AD7606C-16 & AD7606C-18 is the precision in
bits (16 vs 18).
Because of that, some scales need to be defined for the 18-bit variants, as
they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).

Because the AD7606C-16,18 also supports bipolar & differential channels,
for SW-mode, the default range of 10 V or ±10V should be set at probe.
On reset, the default range (in the registers) is set to value 0x3 which
corresponds to '±10 V single-ended range', regardless of bipolar or
differential configuration.

Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.

This changeset, does a bit of rework to the existing ad7606 driver and then
adds support for the AD7606C-16 & AD7606C-18 parts.

Datasheet links:
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf

Changelog v6 -> v7:
  - v6: https://lore.kernel.org/linux-iio/20240913135744.152669-1-aardelean@baylibre.com/
  - Patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Properly implemented HW scales for AD7606C-{16,18} in 'ad7606c_18bit_chan_scale_setup'
      & 'ad7606c_16bit_chan_scale_setup()' ; I omitted them by accident in v6 as
      I was focusing too much on SW scales.

Changelog v5 -> v6:
  - v5: https://lore.kernel.org/linux-iio/20240907065043.771364-1-aardelean@baylibre.com/
  - Dropped patch 'iio: adc: ad7606: remove frstdata check for serial mode'
    - It's part of iio/testing now
  - For patch 'iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()'
    - Added early return 'if (ret) goto error_ret'
  - Reworked patch 'iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe'
    to 'iio: adc: ad7606: move scale_setup as function pointer on chip-info'
    - Splitting 'ad7606_sw_mode_setup()' & 'ad7606_chan_scales_setup()' from probe
    - Added scale_setup_cb hook to chip_info table
  - For patch 'iio: adc: ad7606: add 'bits' parameter to channels macros'
    - Adjusted paragraph 'Up until now, all chips were 16 bit.'
  - Patch 'iio: adc: ad7606: wrap channel ranges & scales into struct' re-applied
    on new context
  - Patch 'iio: adc: ad7606: rework available attributes for SW channels'
    re-applied on new context
  - Patch 'dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts'
    - Simplified 'bipolar' property ; it is now mandatory if channels node exists
    - If no channel node exists it's unipolar single-ended
    - Update descriptions to reflect this
  - For patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - In 'ad7606_spi_read_block18to32' change 'sizeof(uint32_t)' -> 'sizeof(u32)'
    - In ad7606.h  changed d16/d32 -> buf16/buf32; and types to u16/u32
    - Reworked channel setup logic

Changelog v4 -> v5:
  - v4: https://lore.kernel.org/linux-iio/20240905082404.119022-1-aardelean@baylibre.com/
  - Not all topics from v4 have been fully resolved; but I created a v5 in
    case it helps to spot other (new) topics
  - Added patch 'iio: adc: ad7606: remove frstdata check for serial mode'
    - This is from the 'fixes-togreg' branch
    - It should be ignored
    - Should help with a bit of context for this series
  - For patch 'iio: adc: ad7606: add 'bits' parameter to channels macros'
    - Added '.storagebits = (bits) > 16 ? 32 : 16'
    - Reduces the final patch a bit
      - i.e. 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
  - For patch 'iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct() '
    - Added 'Reviewed-by: David Lechner <dlechner@baylibre.com>'
  - For patch 'iio: adc: ad7606: rework available attributes for SW channels'
    - Added '.storagebits = (bits) > 16 ? 32 : 16'
    - Reduces the final patch a bit
      - i.e. 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
  - For patch 'dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts'
    - Added '"^channel@[1-8]$": false' if not 'adi,sw-mode'
    - Added 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'
    - Given the change, I would need confirmation that the Krzysztof's
      Reviewed-by tag is still valid
    - There is still an open topic about using
      'oneOf:required:{diff-channels,bipolar}' vs 
      'if:required: [diff-channels]then:required: [bipolar]'
      - I'm leaning towards 'oneOf:required:{diff-channels,bipolar}'
      - Let's see what a discussio will yield
  - For patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - In 'ad7606_spi_read_block18to32()' fixed 
       '.len = count * sizeof(uint32_t)' in 'struct spi_transfer xfer'
    - In 'ad7606_read_samples()' changed 'u16 *data = st->data;' to
      'void *data = st->data.d16;' ; both would compile though ;
      converting 'data' to 'void *' may show that it's not just 16 bits
    - In ad7606c_18_chan_setup() & ad7606c_16_chan_setup()
      - Added explicit 'cs->reg_offset = 0;'
    - In 'ad7606c_sw_mode_setup_channels()' :
      - If pins are specified incorrectly, an error is triggered (vs
        ignoring it before)
      - Updated comment about why 'st->bops->sw_mode_config()' is called
        first

Changelog v3 -> v4:
  - v3: https://lore.kernel.org/linux-iio/20240904072718.1143440-1-aardelean@baylibre.com/
  - For patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - Added 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'
  - Renamed patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    to 'dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts'
    - Updated based on notes from Krzysztof Kozlowski (from v3)
      - Dropped ()
      - Re-ordered the patternProperties:oneOf:required specification
      - Unified match-pattern to '^channel@[1-8]$'

Changelog v2 -> v3:
  - v2: https://lore.kernel.org/linux-iio/20240902103638.686039-1-aardelean@baylibre.com/
  - Applied checkpatch.pl changes
  - Managed to setup and run 'make dt_binding_check DT_SCHEMA_FILES=adi,ad7606.yaml'
    - Found the winning combination for this setup
    - David Lechner also helped
  - For patch 'iio: adc: ad7606: rework available attributes for SW channels'
    - Removed an extra space that checkpatch found
  - For patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - Removed 'the the' stutter (that I did in writing)
  - For patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    - Updated binding with some description for 'diff-channels' & 'bipolar'
      properties
    - Channel definitions are counted from 1 to 8 to match datasheet
    - Added more bindings rules for 'diff-channels' & 'bipolar' for AD7606C
      - Adapted some ideas from adi,ad7192.yaml
  - For patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Updated 'diff-channels' property with channel numbers (from 1 to 8)
      handling

Changelog v1 -> v2:
  - v1: https://lore.kernel.org/linux-iio/20240819064721.91494-1-aardelean@baylibre.com/
  - Fixed description in 'iio: adc: ad7606: add 'bits' parameter to channels macros'
  - Added patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - diff-channels = <reg reg> can be used to define differential channels
      with dedicated positive + negative pins
  - Re-worked patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    - Using standard 'diff-channels' & 'bipolar' properties from adc.yaml
  - Re-worked patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Reading 18-bit samples now relies on SPI controllers being able to
      pad 18-bits to 32-bits.
    - Implemented 'diff-channels = <reg reg>' setting
    - Removed some bad/left-over channel configuration code which I forgot
      during development and rebasing.

Alexandru Ardelean (8):
  iio: adc: ad7606: add 'bits' parameter to channels macros
  iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
  iio: adc: ad7606: move scale_setup as function pointer on chip-info
  iio: adc: ad7606: wrap channel ranges & scales into struct
  iio: adc: ad7606: rework available attributes for SW channels
  dt-bindings: iio: adc: document diff-channels corner case for some
    ADCs
  dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts
  iio: adc: ad7606: add support for AD7606C-{16,18} parts

 .../devicetree/bindings/iio/adc/adc.yaml      |   4 +
 .../bindings/iio/adc/adi,ad7606.yaml          | 120 +++++
 drivers/iio/adc/ad7606.c                      | 474 +++++++++++++++---
 drivers/iio/adc/ad7606.h                      |  86 +++-
 drivers/iio/adc/ad7606_spi.                   |   0
 drivers/iio/adc/ad7606_spi.c                  |  71 ++-
 6 files changed, 663 insertions(+), 92 deletions(-)
 create mode 100644 drivers/iio/adc/ad7606_spi.

-- 
2.46.0


