Return-Path: <linux-kernel+bounces-526577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459CA40086
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A1B4258AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27625332D;
	Fri, 21 Feb 2025 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+cdmgjI"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1721FBC86;
	Fri, 21 Feb 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168995; cv=none; b=NXUA/EoIp4ByeI+QMxn20MSl+Jx/PSutmhWkRAssWhBdxiamqJVgk8UFJPAWGuopqyXCTqf/Qt9Vhx6D1ziFjvSJ3KV4aNqvYhFl1eoEzmrJkNCn9vtQPmM7+YGAanfhcm6++thZT5gxBXuWjWDOK3+Tpj7bhrW818sbOYnRZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168995; c=relaxed/simple;
	bh=s9Ca1JGprDjYoElIXiW7zquH+1K14cmVqWxpnGGfyR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cM9VbK/R9a4iwmZXLOmQY2uOgPcftmBoZIKW0pzklz+SFoqbJafEyvhIw2xpfO0g0LcQkf3VkEY33rThAgWtPojfyCeTf8lHdVlA7XUKhdKkzcntnnygPYoJAnVm4gjBNjp3s1fdYJ54VJTTShhXbeyOm7IYq2j7G7Ue3g9Aex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+cdmgjI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so4606518a12.2;
        Fri, 21 Feb 2025 12:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740168992; x=1740773792; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOnW1Ydd3mEGmkYd1wAkSF1KEHTUQp/FI13uGVZWzx4=;
        b=U+cdmgjIJfGbd7FHXpSVNQM3Sz86Wk2mi0VErowyWv5m+Zgn6uqquexbYGfAwC3zbD
         3txe2hx2QAArVjO6npmp/BXCaOFlJ8EmmdrQuwBmfkWUP3UvthfR7SAVJXMg+jSi5Etz
         CXbou7r6/Q0u2mW4p4gBu3uhr5z6Q2V3Uih9m1Y51qKJy68o4M//8TydgGSUaXi3VhHw
         VuJvFyPBJ0KG47hV0lWI6zXhQ+PsWhhEfWlgxhT42xFnJ1CUtNpvT4oYLeTxpfezI6nX
         nNrtFndZNgKkvUETejSZES9U4d3GY30ogMvF40etm+b6Jm22g5Ug4zHG8Dk531lqxQNX
         67xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168992; x=1740773792;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOnW1Ydd3mEGmkYd1wAkSF1KEHTUQp/FI13uGVZWzx4=;
        b=cyKhZSZBAJBLpzbV6RF857Bt2KF8rMa+wxQFKlRz1y4zO+IhgK49/0JUkTZkzgs49A
         z2keo03n9uTcePKMs9hm6hDHwLJHoZS6K30JbUapZ1+8B+FZZUx7QgeDSVRZmt+FEtVE
         tzFJmpma4w0BxDxKjQofPs4/TkoowXg+tHW9cdsHAogEQTBvuzVbEjS3s8KPhB3d1Ljv
         4zbCrH742Ei0en1rTEWahb9BGwHBLA7Dqdk0g71g8pyPZoVbYlQTGNiMN6fLu6xymuPX
         W05o9ParR5+eEZ2vQ4spDyJ/dK2n4KjczcotUp50omjhy374YiDhiFTzQcY0YZHVRTgM
         3Kfg==
X-Forwarded-Encrypted: i=1; AJvYcCVtdcWgkpCTPWsCgLtARGUxjv5P0mNblxoFzUSweZjXMLEnhLD5MQ7e/Oov6CiuREfSwG0dqqnKpzCvRcCe@vger.kernel.org, AJvYcCW9FwIcxVYhs7ElsEHSxms92AajP7azVHPU1hGEPHeP8vS/aGUNifixh5uXoLuR4x30rADkNdZ39YjK@vger.kernel.org
X-Gm-Message-State: AOJu0YzRq2xBDtEP0pQSm7B8X/6mvwGXX31uW7zpKAYVY0y/n9/PkfUK
	W/dOzG/LDOIjrU13+CvQRAJ0xcNGAkDt/aeVB+m16jUyY8eXLVQx
X-Gm-Gg: ASbGncuAcpr4e2lEsx05ACFmodGfEbWhKSb79VluJYP41VczFXi4pHcTdn8njjNzoSP
	lWWoxGVUKcIGIOSH41NJ/dKUJLn4ivkfRqeq521DYUF5izprTx9LV/WeWIjTgxw5WPZHcZBi73J
	LyQlczSOOw/8WAOwuH/UFFVmP10tfSYZ+EXPEUfKmmB0G7OHhFzDH4Kae8qjJyBA9vX3yvi6zZm
	ygU2z8DTSj8bOVjHqqqWrZ7DhNvVChWeM6wWtQFG7gB/9l56JPI51uZnAp67JKsq/eXor6BgrJt
	I9TVELA4wc5gnXmYW4TAPCbgc0ud/WSju+O9bdXjmaPiFRBMDUf3rLGknPLtimpXsVeliVlE
X-Google-Smtp-Source: AGHT+IGBCXqFh6dVss0FJaa0R4w77fQmveolGcalYyOeZbZ8ZnN8wMd3he5AW2qgmgbfNBz9J/WLBA==
X-Received: by 2002:a17:906:3291:b0:aa6:7737:1991 with SMTP id a640c23a62f3a-abc0d99370emr406213066b.2.1740168991705;
        Fri, 21 Feb 2025 12:16:31 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:30 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v5 0/9] mfd: bcm590xx: Add support for BCM59054
Date: Fri, 21 Feb 2025 21:16:22 +0100
Message-Id: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABbfuGcC/3XM0QqCMBTG8VeRXbc4Z9vR2VXvEV2czVmD1NCQI
 nz3ZhCK0OV3OL//Wwyhj2EQh+wt+jDGIXZtGrTLhL9yewkyVmkLBcqAxVw631AJZCRbC3lJwWC
 wIr3f+1DH5zd1Oqd9jcOj61/f8ojzdY5oBA1LZEQJUhMWdWnBY9DHS8PxtvddI+bIqP5BlSDVb
 ACRmRxvof5BAtS4gjpB59iTYmsKW2yhWaBCWkGTYOVqp6oiZ0u0htM0fQAr3mnuSwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=3685;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=s9Ca1JGprDjYoElIXiW7zquH+1K14cmVqWxpnGGfyR0=;
 b=aFJpFuZ+ebHX70O5WBucS7JoKsGSEuk18Xndc8WOLJhnTnDv+6bbkju8vARTfhpQSZwSEV28T
 6RaTBMzd0jCDJCgqyKCSaWEc7TatABVG4UfnieAtNegNHC00gssBy/5
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
Artur Weber (9):
      dt-bindings: mfd: brcm,bcm59056: Convert to YAML
      dt-bindings: mfd: brcm,bcm59056: Add compatible for BCM59054
      ARM: dts: Drop DTS for BCM59056 PMU
      mfd: bcm590xx: Add support for multiple device types + BCM59054 compatible
      mfd: bcm590xx: Add PMU ID/revision parsing function
      regulator: bcm590xx: Use dev_err_probe for regulator register error
      regulator: bcm590xx: Store regulator descriptions in table
      regulator: bcm590xx: Rename BCM59056-specific data as such
      regulator: bcm590xx: Add support for BCM59054 regulators

 .../devicetree/bindings/mfd/brcm,bcm59056.txt      |   39 -
 .../devicetree/bindings/mfd/brcm,bcm590xx.yaml     |   76 ++
 .../bindings/regulator/brcm,bcm59054.yaml          |   56 +
 .../bindings/regulator/brcm,bcm59056.yaml          |   51 +
 arch/arm/boot/dts/broadcom/bcm28155-ap.dts         |   68 +-
 arch/arm/boot/dts/broadcom/bcm59056.dtsi           |   91 --
 drivers/mfd/bcm590xx.c                             |   86 +-
 drivers/regulator/bcm590xx-regulator.c             | 1289 ++++++++++++++++----
 include/linux/mfd/bcm590xx.h                       |   28 +
 9 files changed, 1378 insertions(+), 406 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20240816-bcm59054-a880695e41e8

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


