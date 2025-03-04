Return-Path: <linux-kernel+bounces-543271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC3A4D3AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FBB16E482
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7311F4E5D;
	Tue,  4 Mar 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXhHQ86Z"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E391F0E44;
	Tue,  4 Mar 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069247; cv=none; b=C14og4djxQ01Ap9sSYsDTEX+j7P4PUzabr+yR8IeiIpZ8o5pU723gbACJarIrnZVbqz2qcp8HvpaPNG7MH6RuFmx2Zs9bVcYChy6jiHCZ9wKcuFWmnMW79Ru7RCDCbidl1OR5/I1KByeW4oUOfMK5C6gXm6Vj8ZST336bpUERvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069247; c=relaxed/simple;
	bh=29e1foEzVUT393VyN7CvvZrGq5WWpisvVO6kxre8Glg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s5Prlkykc8PioTnRe4h9py6Af19pWivMfMK3fspAe2sRZHjVBLp+x5v1C8emw3eUjLrBQaGBv8JySIIZmGaoFDnflI+W0/6gcmPtxBHf/kIecNsfS9ZNXbXOQLdYf015IE6l4J9DXL15vW+NShaQSP5yqrqJ8oIQPRXYIBcHycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXhHQ86Z; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso8240929a12.2;
        Mon, 03 Mar 2025 22:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069243; x=1741674043; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWGxRqXYwXVjQF2VgpDkF8UFWF+toXnMX0eHKDEnOmg=;
        b=gXhHQ86ZIGiMaXVxNL8DQFx666TJDloMZbYIwRzEMNyGPXtmOCJlsJViNR/LCySQBa
         6fTnNNh92OJN32h676h4VekKW1lEL8b98xxAx0gFM23g9+IQQLExsY5Bw+Y1e3TjlGOc
         wBufh5m1+QqUytD6kMlJijWKK4UK7YSimFen4G9w3SIw4/Wz0xwbPUlGkhblyUO5+Qxy
         cxNhOwXhewflyzjQglAKcrH6fY3mj8DNJM7uhH+XOTLloPYYoQqpcIjixoya+/B6v5ys
         kcM2mELIsPVXcLhNqC/rBr1PR5TQJTms9BxR9bLnhGecWlSEP78FzSfutCsCQ5+9ueJy
         /OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069243; x=1741674043;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWGxRqXYwXVjQF2VgpDkF8UFWF+toXnMX0eHKDEnOmg=;
        b=ESwQsoqceSI/RicScZuIatNp/OtemBy4HJ7OGcyxwmMpLO2AqHH6N7nP90DSgvwm+X
         j4q6B82Ihc0ya39SsU8tUoZw3dsFvKuhth538j4GO2xHhHuQAHsGpQF2B+KEUqdkR+T3
         dSinnmB4WwcWzrYCMxi3UfKE50x9o8A7VmQmM+CC29q9N3FA0s1M2Hwo/UE5ZTSnxh8n
         /yxT6dnwwzf//JWLpbR/leH34DtmtbKXVlcolot2BV+qScZQOXEHph1CKcDnB2gWsgjY
         sdWkl6tZaqj1mCeDzVBFEgCmCTQUs4nlbUQRUyde44m5mT3QgXTjmTLicAd3rlE4jkqG
         b4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV1We4NUtuf5ua5XOEoadRT2ZPMIzmSMZ/G+rhZ+271H7ePmTjzQY4wkmLwyBUmoRfxwnIHrR/TB5vs@vger.kernel.org, AJvYcCVDwkJVZ4UYLzGYt96ZSLanJcvjcHmEBFSiU7ciLVz7aku4b0N4JEOxl7Uc3GXlIRORIVPhq6LAt4Ba6FLV@vger.kernel.org
X-Gm-Message-State: AOJu0YyCX7lSDToEL++9m4b2wlgAPxggb33p96Sliy7pzKWv3VRDEqGc
	W57ocEIca3j/zhw++Bbv9w3ZHDafHRnfmXXpAHSbg4BzdY4BKaj4
X-Gm-Gg: ASbGncvo/sRpG0RA4mpxYIX/hamoSxuHk5eV1DWKc7M9731aPmrS5cv9KfrUa07z+/4
	Tst93BKsPeh3pQ3oKRPD/v4xwX7XNmUhzSd0TSKsK6ogASAq9A6pafS1sry4bpv7AEj+qC1OXbU
	GOFu/EZEQYA9MVL5JTaK3mzz0KXX5Wy4q43RnYsiRDZR/cZvzW5lTZlil1BLs2hIVw8BnIhF5nP
	nnPg3//ZBANbbK7kbkFldWxBQzorVn4XyQh3bxEXzP6mogJJldqh+wPUFB4U0VPLNI51bTvH7kL
	DqPEdnTNA2LgJs42AJ42Eccf16d9hx3SiXMAO4iq/32YHUvbas1Q2WyuC64qGcFxB+jCdEOMyLb
	jKKqy4/2Cg3jB2i4=
X-Google-Smtp-Source: AGHT+IHPqYvIb0WFOWiV7MEh3Cm4vFkXr2XKwuCciEXdcMZInaLH7urDEXy1v5oXsJLy6d62i9zjpw==
X-Received: by 2002:a05:6402:1e8c:b0:5e4:95d0:7e1f with SMTP id 4fb4d7f45d1cf-5e4d6b75f1cmr16105945a12.29.1741069242594;
        Mon, 03 Mar 2025 22:20:42 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:41 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v6 00/10] mfd: bcm590xx: Add support for BCM59054
Date: Tue, 04 Mar 2025 07:20:31 +0100
Message-Id: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCbxmcC/3XNwWrEIBDG8VdZPNcyMzrG9NT3KD2MRneFZlOSE
 lqWvHvNQlkJ9PgN/v7e1JLmkhb1crqpOa1lKdO1Dvd0UvEi13PSZahbEZAFj06HOHIPbLV4D67
 nZDF5VZ9/zimX73vq7b3uS1m+pvnnXl5xv+4Rg2DgEVlRgzaMXe49REzm9TxK+XiO06j2yEr/Q
 aqQs1hAFOEgR2j+IAMabKCpMASJTOJt57sjtA9IyA20FQ4hBxo6J575CLmB1P7IFYLjzOikB0s
 t3LbtF0YZ+MOEAQAA
X-Change-ID: 20240816-bcm59054-a880695e41e8
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069239; l=4021;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=29e1foEzVUT393VyN7CvvZrGq5WWpisvVO6kxre8Glg=;
 b=Nuw0ZhUmMHFnovXiZpVbRlxc/06GUSzDGbD0tl1k0d3cJwti2ACiIABpaEszUQM+a1834RJRi
 wS+clW7KXlfD1FBnmJ6RYSpMecGawWxgNsi/YqCGpRcdCWb7R7RKFr9
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add support for the BCM59054 MFD to the bcm590xx driver and fix a
couple of small bugs in it that also affected the already supported
BCM59056.

While we're at it - convert the devicetree bindings to YAML format
and drop the bcm59056 DTS in favor of describing the PMU in users'
DTS files, as is done for most other MFDs.

The BCM59054 is fairly similar to the BCM59056, with the primary
difference being the different number and layout of regulators.
It is primarily used in devices using the BCM21664 and BCM23550
chipsets.

This patchset has been tested on a Samsung Galaxy Grand Neo
(baffinlite rev02; DTS not in mainline yet) with a BCM59054 PMIC.
Testing on a BCM59056 would be appreciated.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Rename mfd/brcm,bcm590xx.yaml to mfd/brcm,bcm59056.yaml again
- Use PMU ID value as device type
- Rename rev_dig and rev_ana to rev_digital and rev_analog
- Link to v5: https://lore.kernel.org/r/20250221-bcm59054-v5-0-065f516a9042@gmail.com

Changes in v5:
- Make regulator binding descriptions reference mfd/brcm,bcm590xx.yaml
  instead of mfd/brcm,bcm59056.yaml
- Move regmap type enum to common MFD header
- Link to v4: https://lore.kernel.org/r/20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com

Changes in v4:
- Fix yamllint warnings in DT bindings
- Address miscelaneous review comments related to DT bindings
  - Note that I did not end up moving the regulator refs from
    allOf compatible matches; I explained my reasoning in [1].
    [1] https://lore.kernel.org/lkml/ab853605-859d-44c6-8cbd-44391cd677e6@gmail.com/
- Add PMU ID/revision parsing to MFD driver
- Fix instances of regulator data not matching vendor kernel for
  BCM59054
- Use different voltage table for BCM59054 VSR reg based on PMU
  revision
- Link to v3: https://lore.kernel.org/r/20250131-bcm59054-v3-0-bbac52a84787@gmail.com

Changes in v3:
- Split out regulator DT bindings into separate YAML
- Use tables of regulator info instead of get_XXX_register, reg_is_XXX
  functions
- Drop "regulator: bcm590xx: Add proper handling for PMMODE registers";
  it adds unnecessary noise to the series and will be submitted separately
- Link to v2: https://lore.kernel.org/r/20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com

Changes in v2:
- Fixed BCM59054 ID being passed to BCM59056 function in the
  regulator driver
- Dropped linux-rpi-kernel from the CC list
- Link to v1: https://lore.kernel.org/r/20231030-bcm59054-v1-0-3517f980c1e3@gmail.com

---
Artur Weber (10):
      dt-bindings: mfd: brcm,bcm59056: Convert to YAML
      dt-bindings: mfd: brcm,bcm59056: Add compatible for BCM59054
      ARM: dts: Drop DTS for BCM59056 PMU
      mfd: bcm590xx: Drop unused "id" member of bcm590xx MFD struct
      mfd: bcm590xx: Add support for multiple device types + BCM59054 compatible
      mfd: bcm590xx: Add PMU ID/revision parsing function
      regulator: bcm590xx: Use dev_err_probe for regulator register error
      regulator: bcm590xx: Store regulator descriptions in table
      regulator: bcm590xx: Rename BCM59056-specific data as such
      regulator: bcm590xx: Add support for BCM59054 regulators

 .../devicetree/bindings/mfd/brcm,bcm59056.txt      |   39 -
 .../devicetree/bindings/mfd/brcm,bcm59056.yaml     |   76 ++
 .../bindings/regulator/brcm,bcm59054.yaml          |   56 +
 .../bindings/regulator/brcm,bcm59056.yaml          |   51 +
 arch/arm/boot/dts/broadcom/bcm28155-ap.dts         |   68 +-
 arch/arm/boot/dts/broadcom/bcm59056.dtsi           |   91 --
 drivers/mfd/bcm590xx.c                             |   75 +-
 drivers/regulator/bcm590xx-regulator.c             | 1289 ++++++++++++++++----
 include/linux/mfd/bcm590xx.h                       |   28 +-
 9 files changed, 1366 insertions(+), 407 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20240816-bcm59054-a880695e41e8

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


