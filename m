Return-Path: <linux-kernel+bounces-352667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BA799226C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024C71F22032
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8F4430;
	Mon,  7 Oct 2024 00:14:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC683C0B;
	Mon,  7 Oct 2024 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728260094; cv=none; b=QlGnZTRYS+yogcMQr1wMwYt4jEIvP4ULqW9LsHQ1khPKzctqwE/bv7xXv3EU3gMT50I4gPNY3EEGfxWGdcYBumTBAAESv8qAnBamyBX03vHhuSymvfjIBvWEEfP/S/BwDILptledpbvjzUqzl9xDV996ifIvb8Pda4HnXcILLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728260094; c=relaxed/simple;
	bh=RyT9o8Ch970sUrCRC8I/o12vFYRePBQPkZMBzOBZPaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtCTHrJ5m8JjIfkqQMzKK6OFl4PBej8YJqy2iCOARIefDDVy5EsiN6g2Qzw9djHVnaJi4c51L2eV883Ccm5Dh05859yzUiY+iMR0ZWPoTgOzBuxe38YyNqgK6sGaNo8bRrRMbyvdNc0fYO9FJeWYowIQ4EL02VVZLY1qmAWxvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4933EFEC;
	Sun,  6 Oct 2024 17:15:20 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C92F3F640;
	Sun,  6 Oct 2024 17:14:48 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Martin Botka <martin.botka@somainline.org>,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v2 0/5] regulator: add X-Powers AXP323 support
Date: Mon,  7 Oct 2024 01:14:03 +0100
Message-ID: <20241007001408.27249-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A small update of version, just changing the regmap cache type to maple
tree, and adding the accrued tags (thanks to the reviewers!).
================================
The X-Powers AXP323 is a close sibling to the AXP313a PMIC, only that it
allows to dual-phase the first two DC/DC converters. This is controlled
via a new register. On the first glance that would sound like a
compatible extension, but any random AXP313a driver would not know about
the potential dual-phase nature of the second DCDC rail, so might want
to turn that off, spoiling the whole setup. So this patchset introduces
a new compatible string, without any fallbacks.

Patch 1 adds the DT binding documentation, patch 2 fixes some fragile
connection between PMIC IDs and an array. Patch 3 allows multiple AXP
chips, since the AXP323 seems to be often paired with the AXP717, and
there is some sysfs naming clash with the current code.
Patch 4 then adds the MFD bits, to introduce the new device type and that
extra register, while patch 4 eventually adds the new regulator device,
and takes care about the proper poly-phase detection.

One note: so far the poly-phased AXP PMICs had that setting already
enabled at reset time, so we just detected it and were good. However the
AXP323 on my board does not, so it requires enabling the dual-phase bit at
boot time. The BSP kernel does that in their boot0 (SPL) early boot code,
and the plan would be to do this either in U-Boot or TF-A for mainline.
But should we actually expose this in the DT, as some new property, to
give kernels a chance to set it? The rails in question power the secondary
cluster, so it's not strictly required at boot time, but it's probably too
late for the kernel anyway, given that SMP bringup is much earlier than
drivers? I would appreciate any thoughts here.

Thanks,
Andre

Changelog:
v1 ... v2:
- change regmap cache type to maple tree (as all the others use)
- add R-b: and ACK tags

Andre Przywara (5):
  dt-bindings: mfd: x-powers,axp152: Document AXP323
  mfd: axp20x: ensure relationship between IDs and model names
  mfd: axp20x: Allow multiple regulators
  mfd: axp20x: Add support for AXP323
  regulator: axp20x: add support for the AXP323

 .../bindings/mfd/x-powers,axp152.yaml         |  3 +
 drivers/mfd/axp20x-i2c.c                      |  1 +
 drivers/mfd/axp20x.c                          | 58 ++++++++++++++-----
 drivers/regulator/axp20x-regulator.c          | 13 ++++-
 include/linux/mfd/axp20x.h                    |  4 +-
 5 files changed, 61 insertions(+), 18 deletions(-)

-- 
2.46.2


