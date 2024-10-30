Return-Path: <linux-kernel+bounces-389047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2A9B67DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C4F1F21540
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADF213127;
	Wed, 30 Oct 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9xcXFqI"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D41F4737
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302231; cv=none; b=H8ARJNyFTBWKBhRgqJJMPWS1M3yCOdbICmEEEQICrQkxTBZKr2HRofQF54QB8Kdhb5xMe3X0X93AozAWMHpDJe1aMjWMLqxqMG5+ATA6IKPo2tpmt5dJAW0D9ppC2SstYNai3khaxJI2ARS13DD+Jq04To0LP842dbGaE5NTkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302231; c=relaxed/simple;
	bh=oGCPC4WQtceCeXznYVFm3J6HRXKtenOwpTRHuoSpNpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YLk36Wp6PxgHQ5umxlyIVRKX0O1GCuLf9F/lasQ36NGlZVy29bJOe9HHUeVDOY96h/8Oq+o+U3nmgij7vsYYc+TGkavbf2wYr0J0g+2k7t4tDcDBf5j0InSI+DpH4VaxkHg08c2fFhKaYlEMLUuNaEmdCQOJzOyhlLt+JBA50Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9xcXFqI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so2123f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730302227; x=1730907027; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Nm2tLAMuR5VQSjESa6r82m8ESUsEoS2u94Sem0i/oc=;
        b=F9xcXFqI71XNDzf2Rm6hb95hMv0/USsbRIc26zvanKtKlNaFVUB2nklT8UKkTngYNi
         MjCTiXqTrPI3KjCwpcm7hgZdqWsyw/5wHSJpt1rY0Er8yxBRB/bQ0GqIbAakwFDcYuTi
         xXrwyP0XlTzyq6KExqI7zNU1PUvHLL54hTn01tSdFpoHw6tnVsg1lLkrWYvc3Od/JJ7v
         S2HunmL8F9N4Ppryq20POwJOS8LjzuU7/eQZSXhs+fRTM3a6E7wUYWp7QYp6L5NAt+Ve
         EfIY+GH+X2WbRMyHE/2MfE01eWBuddb6BlPSuaMKc04q9ipGY3zUw+xsxYoVX5uyjXFf
         Kprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302227; x=1730907027;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Nm2tLAMuR5VQSjESa6r82m8ESUsEoS2u94Sem0i/oc=;
        b=dAf7FKzn89oIJo8qQ6z1A4wMYa6iXxmhXlNzv4KtllKAfjWp7F4mxtxgpR6ZXnos2B
         BVQ6umgxCQBOXAFnoG5PrxRGdQ+hN3jzmtGSK8BlVRL/JCWG7IFmZxcu4gXi2G73drgA
         /cXq40qiAOPLPCy0FzdwF+SDA9IYR2RhRdc5FIHqhYGZm9E53yDg1S54VSYMwKVY6XU5
         qEIlRRPUDnsj3N4phjlCqdfvTLwOjL2oa3PbTAhYzvNvLFZ22dfEwGwxeXxycytviVBl
         XFLQSo8i908RSMHiQWf9Bv8DCE2qFE37qsI0kRfm0rjSHFL2AJeLrCRmkRIEfSyilEzx
         P5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWZvuA4rsOhMUT5lt7U1n4075CogUvZ3G118z51OiYdtoU/GFe0KCWIBUEifsZbghqKAt8jPAa2pMReLdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35Kmb1q5+sT5zTXF88F5ZqACbXPHCWYAv1SelXfjXXojjHzfN
	Xo6F0GdLrSVdjZciQnlr3I+dg0CQDfjsZU0VDVomf7gdb9NpByqccTSZzVT56Cs=
X-Google-Smtp-Source: AGHT+IEcJIgJ0swoxDmGPVd8MDHoy/uFqvVvZeKiSkWZypEzyJHY+b113TcGuNYnM9giuhoFoQ0VfA==
X-Received: by 2002:a05:6000:dd0:b0:374:c3e4:d6de with SMTP id ffacd0b85a97d-380611e484bmr13072026f8f.41.1730302227251;
        Wed, 30 Oct 2024 08:30:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c236sm15604040f8f.35.2024.10.30.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:30:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/3] iio: magnetometer: add support for the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Date: Wed, 30 Oct 2024 16:30:21 +0100
Message-Id: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5RImcC/4XNQQrCMBCF4atI1kYmk9ioK+8hLqbpqAPalKQWR
 Xp3oyAoLrr83+J7D5U5CWe1mT1U4kGyxLaEm89UOFF7ZC1NaYWAzgCg7mMnQUvbXXt97XKfmC6
 aztkaC6ADeQeOa0c1qGJ0iQ9ye/u7femT5D6m+/tuMK/1I/sJeTAaNAZ0wLQMtffbs7SU4iKmo
 3rRA35xaKY4LJytyKFf0RJX/MfZb249xdnCGefXWDVNZWv7w43j+ATbp4/DaQEAAA==
X-Change-ID: 20241002-topic-input-upstream-als31300-ca7404eb4ab0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3603;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oGCPC4WQtceCeXznYVFm3J6HRXKtenOwpTRHuoSpNpE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIlEQZubupZBTZHeKsXpsUuCLGzSLXYYRsvV7uGrs
 Y++SfVSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyJREAAKCRB33NvayMhJ0aU0D/
 9emG6OtyX/dGjCOxQp4P8+m+/2BS6KWX0G6TDDhv6QJ69WqUsJJwuenAlzKI5MVK4gHqvrldIBxuZR
 fPkf6cyhyhpgvM9U7IPlymSi/tE9r6eiiM50oE1vVZeaWQkzl/LFacd4hzMzU0mhLf8eBdPfPQxaKD
 8MOZGJWsV/iC/6WE6oPn3mDXBcJOntmAt8VeQWluRJzmwMg1e6M6C3c2Tn4rOFJ14rAb0IWhfBdS03
 +uYK+ZnyQOlSQAs4PdxH+el+SSVBxi2VaU6itNKcGZp4ZuVRSGgMfcosdSgX2iC3wrFKsqnnZVZdaD
 j+wdod2BYz1674eYaJ3ijmDXB+mPtEYmORXkKGUui7UmRZlbMFrLB+StIwn50egyCp2LNyWegWE3j9
 IkEGYuf0VXBdv3RZng1RLUMsPvePGP5DLUNvka7n8b5AV5+q5pbrIb6r+Yg4s/Er2rGrQFRKeh1K9P
 R1s136kV/qegilPkSFAN2JQIxJb7GaVKBk3/c+55oEujSah5qAtK3IPJsNzdTOoioJA1yUv3xnlhOF
 NRvAjxcRjEE5k2QYBpzQMD2RD8scvWbzbOCR3IOmQ1Rgy/F1LjOd/iKuJpo6sByvCcSX2VBcfMgNkr
 Ckd21lliNUQrOMFlBFOmERgTvHzbZX0hb5na+69s7YaKfpmN71/cBdURoiSg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
mainly used in 3D sensing applications for head-on motion.

The device is configured over I2C, and as part of the Sensor
data the temperature core is also provided.

While the device provides an IRQ gpio, it depends on a configuration
programmed into the internal EEPROM, thus only the default mode
is supported and buffered input via trigger is also supported
to allow streaming values with the same sensing timestamp.

The device can be configured with different sensitivities in factory,
but the sensitivity value used to calculate value into the Gauss
unit is not available from registers, thus the sensitivity is
provided by the compatible/device-id string which is based
on the part number as described in the datasheet page 2.
    
The datasheet is available on the product website at [1].

[1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- reorder includes
- fix typos in comments
- drop spurious empty line
- use fsleep instead of usleep_range(600, 650);
- check return of devm_mutex_init
- add Andy's review tag
- Link to v3: https://lore.kernel.org/r/20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org

Changes in v3:
- Add missing includes
- Use read_poll_timeout() in als31300_get_measure()
- Use MILLI instead of 1000
- Remove __packed attribute
- Return 0 at the end of als31300_set_operating_mode()
- Use devm_mutex_init
- Use dev_err_probe() to handle devm_iio_triggered_buffer_setup() error
- Link to v2: https://lore.kernel.org/r/20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org

Changes in v2:
- Add rob's Ack on patch 1
- Fix commit message layout on patches 2 & 3
- Use Datasheet tag on patch 2
- Fix bindings file name, add options interrupts, fix example node name & compatible
- Fix driver with Jonathan's advices:
  - Reword top file comments
  - Reduce VOLATILE defines
  - Move registers values next to register define and add an indent
  - Use sign_extend32() to X/Y/Z macro, dtop cast on temperature macro
  - Add als31300_variant_info to pass to i2c/of device_id
  - Move scan buffer to irq function
  - Use guard(mutex)
  - Return fractional for millicelcius
  - switch to aligned_s64
  - use index 4 for IIO_CHAN_SOFT_TIMESTAMP
  - Add usleep after switching to ACTIVE state to avoid hitting read errors after wake up
  - simplify suspend/resume functions by returning als31300_set_operating_mode()
- Link to v1: https://lore.kernel.org/r/20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org

---
Neil Armstrong (3):
      dt-bindings: vendor-prefixes: Add Allegro MicroSystems, Inc
      dt-bindings: iio: magnetometer: document the Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
      iio: magnetometer: add Allegro MicroSystems ALS31300 3-D Linear Hall Effect driver

 .../iio/magnetometer/allegromicro,als31300.yaml    |  46 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/als31300.c                | 494 +++++++++++++++++++++
 5 files changed, 556 insertions(+)
---
base-commit: 57573ace0c1b142433dfe3d63ebf375269c80fc1
change-id: 20241002-topic-input-upstream-als31300-ca7404eb4ab0

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


