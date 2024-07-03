Return-Path: <linux-kernel+bounces-239620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D5926325
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC78728D452
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B63183093;
	Wed,  3 Jul 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VwLRCtq5"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0D17DA2E;
	Wed,  3 Jul 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016007; cv=none; b=KmEuXAA+hn2qsWDcoQqXL/1gFfWAI3E3qmvirAiGAs5N91wANxEodR8QNc4SHovzcHOgiKzm6SKC+GcTyeUiqm2XcLmtd5SEslJiy1Y30S6emaTYu1d8kQ1AIIPGarWyWLSY0h+yPflAnbS8PIgsWQfcF3vOrtOabU5w1Ggmc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016007; c=relaxed/simple;
	bh=U6DEP19ygCkPXuQKLLxorLJXfz+rnBG5Pwv8YMdO/Bw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KT3XYjJcEwu2gwCJNewsixCxaW1CrOKy/628S5vEHbupXoYJSJKrHGoDu4leJ3ds24FTGXAsE2G4VTdgMmljjszNHVzeBODPTnD1L6Aofb+ZL6p0lscCKlVOtVJoqe5S22Q+P/i6auu9B4z4XzyaVQ0+weDJkBvUXyaWYZEyzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VwLRCtq5; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id E2503C6D04;
	Wed,  3 Jul 2024 13:46:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BFDC240002;
	Wed,  3 Jul 2024 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720014371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SAmBKY6TaaS5jkk7Ij5yPeOvb0Ktt8dFf3y/RyTt1Mk=;
	b=VwLRCtq57OxU0fIL81TJ2PS+HkQ3vz3Pu7v0mgKdcxXoI+DE6kjBn47ygcKfAwVFZ4xuI3
	nNC5KFsuvTGXWqSlj6AEvADdDRprmppH6Wp+bd1V8AV/hLdcJyHT41pJMt0ykaAdyDD+vT
	8n7Wk7a77SKzhMxRjebnhDFGfB26V9fKSdeEsw2ovgOXizY6RFv2xvZpRv4fxxKdKnD8cG
	RQjTQY1GEdNd6DN9wIMLybhhFfv06OsTF5YvFDmb8B+bA8RGuw8GHjR8fmB2FrpEg3xdym
	R2mIQ728UiuCltmAdEGnXs/GEiXKZrW0drmDnrFWzkm6F109ASXNfgGjoJxFNw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 0/4] Add Mobileye EyeQ clock support
Date: Wed, 03 Jul 2024 15:46:04 +0200
Message-Id: <20240703-mbly-clk-v2-0-fe8c6199a579@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABxWhWYC/23MQQ7CIBCF4as0s3YMIKHqynuYLgod7URaDDTEp
 uHuYtcu/5eXb4NEkSnBtdkgUubEYa6hDg24sZ+fhDzUBiWUFkadcbJ+RedfqJ0h61ppTrqFen9
 HevBnp+5d7ZHTEuK6y1n+1j9IliiQBitJXajXTt5sCIvn+ejCBF0p5Qt39+ZvogAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-13183
X-GND-Sasl: theo.lebrun@bootlin.com

This is a new iteration on the Mobileye system-controller series. It
used to be sent as a single series [0], but has been split in the
previous revision (see [1], [2], [3], [4]) to faciliate merging.

This series adds a platform driver dealing with read-only PLLs derived
from the main crystal, and some divider clocks based on those PLLs. It
also acts at the one instantiating reset and pinctrl auxiliary devices.

One special feature is that some clocks are required before platform
bus infrastructure is available; we therefore register some clocks at
the of_clk_init() stage.

We support EyeQ5, EyeQ6L and EyeQ6H SoCs. The last one is special in
that there are seven instances of this system-controller. All of those
handle clocks.

Related series are targeted at reset [5], pinctrl [6] and MIPS [4]. The
first two are receiving a second version. The last one has no change
and stays at its V1.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240620-mbly-olb-v3-0-5f29f8ca289c@bootlin.com/

[1]: https://lore.kernel.org/lkml/20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com/
[2]: https://lore.kernel.org/lkml/20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com/
[3]: https://lore.kernel.org/lkml/20240628-mbly-pinctrl-v1-0-c878192d6b0a@bootlin.com/
[4]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-0-f53f5e4c422b@bootlin.com/

[5]: https://lore.kernel.org/lkml/20240703-mbly-reset-v2-0-3fe853d78139@bootlin.com/
[6]: https://lore.kernel.org/lkml/20240703-mbly-pinctrl-v2-0-eab5f69f1b01@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- bindings: take Acked-by: Krzysztof Kozlowski.
- driver: eqc_auxdev_create(): cast the `void __iomem *base` variable to
  (void __force *) before putting it in platform_data, to avoid sparse
  warning.
- Link to v1: see [1]

Changes since OLB v3 [0]:
 - MAINTAINERS: Move changes into a separate commit to avoid merge
   conflicts. This commit is in the MIPS series [3].
 - dt-bindings: split include/dt-bindings/ changes into its own commit.
   It is part of this clk series.
 - dt-bindings: Take Reviewed-by: Rob Herring. The include/dt-bindings/
   new commit has NOT inherited from it, just to make sure.

---
Théo Lebrun (4):
      Revert "dt-bindings: clock: mobileye,eyeq5-clk: add bindings"
      dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H clock indexes
      clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
      clk: eyeq: add driver

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  51 --
 drivers/clk/Kconfig                                |  12 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-divider.c                          |  12 +-
 drivers/clk/clk-eyeq.c                             | 789 +++++++++++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 +
 include/linux/clk-provider.h                       |  11 +-
 7 files changed, 839 insertions(+), 58 deletions(-)
---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240628-mbly-clk-4c6ebc716347

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


