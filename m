Return-Path: <linux-kernel+bounces-516103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA05A36CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C1E18947A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF8319F438;
	Sat, 15 Feb 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/cYdYzU"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481621373;
	Sat, 15 Feb 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612388; cv=none; b=ZujZC4ZbWkFZ9sufzsuBH/zs/BWtGRKpaL7j5rkvA+S6gubdhcG/NabaPg1uitYyYC4RFAr+76pwvvFf+On+fcJPz4WpPObO/C6frTx9tq20tbQPdt1fCZ+pB21keALojm9zjBAPIPqZUUZZwrEvrMSBUN/riUp7CC4Cr5VooBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612388; c=relaxed/simple;
	bh=RvFKjUXvMlJHaw4Y9IUcOiSRqQLAk7/bwVL+DP39wkk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MlMqZXkd/6K09MG2h5W2vFQbANTcyJpI5wqXQX2/4b1h6ZFzCu5fkHDM24+EO0PQ8WyHK2LYfZhCH6UwxrIvt81SnI4YctdXzWch9hclMeCdtEKuaWqLxbOwKSxCmWFgGMLOVAZpeyTy6+E3nHspTPHCMrXoGnUJ3pVi/c8L5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/cYdYzU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so3012672a12.3;
        Sat, 15 Feb 2025 01:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612384; x=1740217184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86egy4ZfrN4CyOgF63gNBhcznnxcuqKUfVdI/qpLUQQ=;
        b=D/cYdYzU0em78KJwha2Yoq7OQky92ZgaaXn75Cr+GNDb1RkK6jzopvV2gWhjl5i2l3
         MrBBm7iyL4Lyjk/NriDaXI59EWoSHezex0ZyjgqAZV4RfM9FZoPjiaqneAxmMdsuiUAf
         WzRnB1t5MTJip2Mplzyxv5w7obGCxaMpwczChMNhP+xJ84wnPxGz61PvgMGrp8fHdQwy
         n0nJB3EG3ZdQ33Vv2rRNMOFV/ozuET+9eOIZFoaINDS9ihZIE9kTXlE+3J42PTd2++1s
         QXIKnmv0/jR02Km4eu1VMZ3oKfiMIt/lRc9nYgKMZ/ye16sSgv1ix5fvdqwGj1d1u+7R
         Dqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612384; x=1740217184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86egy4ZfrN4CyOgF63gNBhcznnxcuqKUfVdI/qpLUQQ=;
        b=Oq5zijw+jBytITjMbTHaWChxAuiGhq2iLfv+dR0Lx4XorbiGAbTKpkRNIG5mp3Lfbc
         RyZXzLdkvRpJH0SUJK28OA3CSCqA2YrygzBnfYUfWcDY2Ud6Y0dh6okhWB7WsVyGtx+i
         SsqTObqeS7lc7q4Mf7D8PEdxRI+tbazfHb4VykExqhWAWzpcpOLw6kGjpvf/OzYi0HJu
         nY3k/hdFLWJ9RE+04kKzwajCLTX8eZ4T9o4JuFspseq7A+PJlRwbz0gQAn4jupk0CJRk
         I5KBfSY75Rz38ii/+wb+hK9WRH0SCVkjftiNoS2syzDkZfSdHKEuwTek2X1qe7vMP0zl
         uAPw==
X-Forwarded-Encrypted: i=1; AJvYcCVvx61Q6zOTsEmD7D45drUWFDt45TgENpMqSqWGcqztcEvuWLGnLudYpaFBmgnWhjm4TmdnL1hvX7Fi@vger.kernel.org, AJvYcCX1YYVgWdUC2fx8Nh+xqpVEQ3S5/8AVghy3PhY8tvp3ZK5pwoBKg41EY+nVmdJdEPKAGlMSNOwrvvA0tGUb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dxBAtDrwGWKfGVawNxWY3f/Ih5lY+WEp7jiVMUn9e7Bg0GxI
	qdP4EV7JH2cpGOmr3uLlcVu99ir4FtbHXSB9SVWlPX3ABYjc1/E2
X-Gm-Gg: ASbGncud6SZ4TJNwJGhydolb0/B+iHcGVFffdh2fel4EqpzLtPkKnN9D6r8n9+grZlD
	+9uXHggRwn7hlsk2IT9y2l3+GZ0GYTxAkfrj5vdJvibJXK+GLmr1UL/aYOjTtpZaaXWjTC4aqY5
	uXnWUTC3rUZ2QhjiLIwGuMQ21+A6W1mIkxRrykpvDyq7WSYFveiQ0Ww5zKz3IXWmk0kaZJhW6R5
	3MVSTKQ/+M4Q92unWLw2RnwHvnZq/lDk57NFwbUW0Ohl/ok+Guk2u60GOmFHI+TJZtS20KQ5rHP
	55LbcLwn4yBWQQp+73gitOIA6qfc++vX4rmnZRZkBlAzCnCdUm96uH7qT28rBQ==
X-Google-Smtp-Source: AGHT+IENdkHZpBflakq0UhjZWZEzOJw6B5m80Y1ZAs6Zut0H92VjFPqffHpMVosJyAZk5ksaHWsloQ==
X-Received: by 2002:a17:906:c10f:b0:ab7:97ca:3276 with SMTP id a640c23a62f3a-abb70bad02emr186346866b.25.1739612384203;
        Sat, 15 Feb 2025 01:39:44 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:43 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v4 0/9] mfd: bcm590xx: Add support for BCM59054
Date: Sat, 15 Feb 2025 10:39:35 +0100
Message-Id: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdgsGcC/3XMTQrCMBCG4atI1kZm8tOmrryHuJjGtA3YVhIJS
 undTQtiEVx+wzzvxKIL3kV23E0suOSjH4c81H7HbEdD67i/5s0ECAUGC17bXlegFSdjoKi0U+g
 My+/34Br/XFPnS96dj48xvNZywuW6RCSChG8kIQcuNZZNZcCik6e2J3872LFnSySJf1BkqBtSg
 Eika/qF8gM1oMQNlBnWNVktyKjSlFs4z/MbJ+K+kRIBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=3425;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=RvFKjUXvMlJHaw4Y9IUcOiSRqQLAk7/bwVL+DP39wkk=;
 b=88mIlCjjPlj/GIGI1gc1wDt7c3aesuxLI9/WzIx6ZhQQkodOm6fp+3/hlDvA0J0CFno6V9Li+
 z2v/fs7jNWeCZnG3ayzCjXNdi+iIMiRPn3Mc+koFvwcrIclLwDKqqQs
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
 drivers/regulator/bcm590xx-regulator.c             | 1294 ++++++++++++++++----
 include/linux/mfd/bcm590xx.h                       |   22 +
 9 files changed, 1377 insertions(+), 406 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240816-bcm59054-a880695e41e8

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


