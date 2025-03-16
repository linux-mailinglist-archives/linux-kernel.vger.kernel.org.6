Return-Path: <linux-kernel+bounces-563091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF7A636E8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08127A6A57
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEA1C8638;
	Sun, 16 Mar 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU7mJr6h"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D514A4F0;
	Sun, 16 Mar 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149157; cv=none; b=F7zEIcLLE0YkChETWtknIUboxBFQ0ukh4f6R3MC7bmNoqiGNM+BlqUacsfaUuLi4ZoI6E3vMtvWPXhmguXdVE9bJTDhaHjkFepnCwCab2Whe498ERC5Q/3XyOPTrPawN1cn+SFlRl0tEZWFk6Xrwo0KkeUMr40xLCxrvoGDj9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149157; c=relaxed/simple;
	bh=/2qC3ys8iqY4ZhnW9xWMTHOrRpd3z4gIdVRcOiTewoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l+6Yi6w5fo10VtFrENgZOEUj+u6owMNSmRlw5Lg3EigSHCDTqBveFmMGbuPwovGzzERzkf73grfhxOcaV27HXGmt6xb3NMd3ycBADFVbykcq+0jiIMHJIs478YTdsLNYV9SN4Jhv4XgAwB7AR1Py9+h5typHUaW1u1vv03RiOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU7mJr6h; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2aeada833so726495266b.0;
        Sun, 16 Mar 2025 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149154; x=1742753954; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5llhXWaOgn+P9hsoG5ZPqzI/ueY0T33WAdcLaUmMduY=;
        b=kU7mJr6hKDIFSTywDMhhs0VTslZK/eqhGjhI366HemwK96wUYjqqB8rPk9s0d92Hve
         tTJ30AfaPYuNc9Wm/AtWhjNBRl3chxu6qBCqOOMvr+7OHx4UqMfaGUxOrZCN7kVWP3Gu
         eND5/2I4j6D52mHEZ44jDxccCnRWkn3pmA30HHTDe0XpSTclfSNYnYoMnQFB0zqJ6tDl
         nbwz4XGxwKaiNxetxu0ibWSrg+JJIEwcDA6WEWMfq7y4Tmex3Xguc4shxR14nuSgNxF7
         9kJNeMqxUvjrANhTa2Qbh0YNYzqjlYrQmT2u5+p/1dWN/98uQspA+mPmD6/c5n7xORy3
         z4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149154; x=1742753954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5llhXWaOgn+P9hsoG5ZPqzI/ueY0T33WAdcLaUmMduY=;
        b=JvIrO34qNkW+kC/+0Xeyt3kaWGEkOaQpAabZOF5WmZMC9S4r2kO28mup2ftVt95kfe
         TChqqoYJbB8lXrq1SdZOnpgFSPuPfug+Q6ZDMU43anOd4ugXzGaHhbX4I2rNKZJ43kwd
         EFUq4HNrHoq/hujFyOj4XAYecD0s1NAGAlJRAwfP1y+kHZYCyQ+iYHDHV5jpxou/JTJ0
         +ShYjRMflCc4SMbjwOPzUQ/eHjYmwEM+Pj6RqWpezW5duJxIUhVBbbi3SAGOUYGhUEtz
         sRK0fwbZ5IpHoj7ddL1c7SN6a2EUH0TuFmuBq/HSnVdQmEJq9zzRQKOhZ0LvdHJWm82b
         8Fxw==
X-Forwarded-Encrypted: i=1; AJvYcCU3UF4s1fy9Nayu7ELn0ehbGUNWc0zi4VL15w8KSvN11s7fJcZEcO0tqhJKtA+2WquBu/qO36bSSzqB@vger.kernel.org, AJvYcCVoPRzJl35lfqyO55OJ7X5ZF7kYwtGqQcfL/8fOwoBwmaGS+bCIM7vWoFUzaCtA00uN1OT6VT/tTQA7Mxla@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQLBvPhQgubvOYvgb9mkIy5VGvbD5P0gBJqD2RlDWrt3YPvBz
	pbA/+c+LQZcD8wOJ9syDEBCz5S+tjLgf6/fMsKzyMjc0mNgwmDZi
X-Gm-Gg: ASbGnctzmzapEiRWmNtUlIig+xTKkCj10vQNJKCd+riU+vA1JOCFrV5EEIRoPBGFayT
	qxGXnPIKjr943wCOeFowmIQLfwfRRbEcgSAOz1tmnSBqvVLFyYJCUfBkkRwCf/RZGv4/bqjbZqn
	UJ73rMvmPIeZXgv6xVdFg8GwsC1dHeAB3PSbJxY8GDSY9LtIQ3VOhDAkvejgVNv3CXLUYhOdzUC
	dW8xaEws1IwrbAubqg7pYvZWOif5M5VTjqQ+1f7WQy6jNTEvOK3mHWhPBvzU+14DbhahCqzv56K
	5UeHcuNdgnYO9NJULvWswEvTIYHbDtzdI4yizhCt8+yZE6avkAAXVuRT/CACimb1CMJ+kflV96j
	iw988XX4l/mbroz1ppg==
X-Google-Smtp-Source: AGHT+IGjBEUa5TpBWQvliNMZG68SgtFyRC14IY8B3fWdscOsontLpBleg5zWcEHDjbOsrk436S97fQ==
X-Received: by 2002:a17:907:6b88:b0:abf:6a8d:76b8 with SMTP id a640c23a62f3a-ac3122d2166mr1285016666b.11.1742149153915;
        Sun, 16 Mar 2025 11:19:13 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:13 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v7 00/10] mfd: bcm590xx: Add support for BCM59054
Date: Sun, 16 Mar 2025 19:18:48 +0100
Message-Id: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgW12cC/3XQwWrDMAwG4FcpPs9DsiXH2WnvMXaQHac1LE1JR
 tgoefc5hREvsOMv/P3Cuqs5TTnN6uV0V1Na8pzHawnN00nFi1zPSeeuZGXAEHh0OsSBW2DS4j2
 4lhNh8qo8v02pz1+Pqrf3ki95/hyn70fzgtt0K7EIFvaSBTVoy9j0rYeIyb6eB8kfz3Ec1Faym
 P+gKZB7IUAU4SBHaH8hA1qsoC0wBIlsxFPjmyOkHRrkClKBXeiD6RonnvkIuYKm3sgFguOe0Uk
 LZI7Q7dACVdAVKMnb8nv2RH+Os67rD7sxzI29AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=4285;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=/2qC3ys8iqY4ZhnW9xWMTHOrRpd3z4gIdVRcOiTewoI=;
 b=ZNfRtDgIBuMyG/Lbw1yMmSFngKHMU8KfJSYgTTvTpciFnYSzh4e8+9i6kYQPBw/CWqt1bMY2L
 Bz8HP0QT+0jDMhnal4cAJNilgxZQ9QL64bhGGsuv06TA9H3785fCCYy
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
Changes in v7:
- Return -ENODEV on PMU ID mismatch
- Drop "Check your DT compatible" from ID mismatch error message
- Pick up Reviewed-by trailers from Rob on DT bindings
- Link to v6: https://lore.kernel.org/r/20250304-bcm59054-v6-0-ae8302358443@gmail.com

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


