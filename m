Return-Path: <linux-kernel+bounces-350699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BE899082A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C3E1F218F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138CD1E3DE0;
	Fri,  4 Oct 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HcXt/Ln3"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFEC1E3DC0;
	Fri,  4 Oct 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056739; cv=none; b=jXJihJMzmXyGag6iBi6CKDmqeIkvGBAmgRnsgBkV7KSdI6K2a0NixV+LA5IX7zd2viE6s9HiF3UukyuXXVRnfwLL5cBKfmFBZQBhFHVN/TKHGsfq0naW0/jhJgT5353mMipAx/ZC8rPtl/x++lhFEs+jB2eQXZBSieWaCd/tAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056739; c=relaxed/simple;
	bh=ab1PecIfRTKnkqdeKaviUQY47Wi05JDzrwUy4cuI5is=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GIyy4RfbuG+ZKITgqheGtGFKMHsBA3ZTUw151sUJwBiSiJCDh09Yo1HZQZ+GRQSZRVqvMWWbIuP/D9thpNkgvy6sOmK2wgQcZ0VtDwy0sAxoLpGpIgx4cC9GgJGEdLUNnEgM1TFFKTiGmbVA7l3ETrJ69x4Z3jVJcfUUXpESKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HcXt/Ln3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29D70FF808;
	Fri,  4 Oct 2024 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728056734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QR4ObM/uww4dWpjkKCqDJeRlOK82odVV7nJTF9HuVQ4=;
	b=HcXt/Ln3aCaDWKs/mUfeh4HERNhYx/K8ngSzSl6tKjoecspkj2bJeAlxqn9v5Lr3v+M//H
	ijocPJfYaTMntDLAjvekgz8reGGpzGgW41FdIRE4igmCTOSqx7UTNiUTDea+TiZHccD3fF
	oL+Defih4MNDCeWu5Ep8ZUwfs9nr24g44LJvkoXFeBkIV23mog2iJlZrdyFy9lN6NH0pAD
	3AM60qYHXyJkvKNDqcn//XY2QtM3uoXATdJRNPa8cL5MzzDureAinhJzU6xxP4eZoFeSn9
	xzUQA2yaQW63p43R25fkeyzt8MhxnG+umqpmTyMtOH7BgH21D99uIDXbSmeu8A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v4 0/4] Add Mobileye EyeQ clock support
Date: Fri, 04 Oct 2024 17:45:32 +0200
Message-Id: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJwNAGcC/23N3w6CIBiH4VtxHEfjXyAddR+tA8CPZKk0dSznv
 PfQk2x1+PvG8zKjAfoAAzoXM+ohhSHELg9xKJCrTXcHHKq8ESNMEMlK3Npmwq55YOEkWKeo5EK
 h/PzZgw+vLXW95V2HYYz9tJUTXa9/IoligqGyFJgGIxy92BjHJnRHF1u0ZhL7UEX4jrJMPZROU
 q3NSelfyvd0/ytfKfeGArDSQ/VNl2V5A3+0Do8YAQAA
X-Change-ID: 20240628-mbly-clk-4c6ebc716347
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

This series adds a platform driver dealing with read-only PLLs derived
from the main crystal, and some divider clocks based on those PLLs. It
also acts at the one instantiating reset and pinctrl auxiliary devices.

One special feature is that some clocks are required before platform
bus infrastructure is available; we therefore register some clocks at
of_clk_init() stage.

We support EyeQ5, EyeQ6L and EyeQ6H SoCs. The last one is special in
that there are seven instances of this system-controller. All of those
handle clocks.

The clock driver instantiates reset and pinctrl auxiliary devices
present in the same system controller. Those drivers are upstream
already, as well as the devicetree patches to switch from static clocks
to using this driver:
 - 487b1b32e317 ("reset: eyeq: add platform driver") since v6.12-rc1
 - 41795aa1f56a ("pinctrl: eyeq5: add platform driver") since v6.12-rc1
 - bde4b22dc526 ("dt-bindings: soc: mobileye: add EyeQ OLB system
   controller") since v6.11-rc1

I had a pending question [0], asking for confirmation that the static
linked list to inherit cells from of_clk_init() stage to platform
device probe is indeed the right solution. As -rc1 got released I sent
the new revision anyway.

Have a nice day,
Thanks,
Théo

[0]: https://lore.kernel.org/lkml/D4ELMFAUQYZ7.3LXGQZJSX68UF@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v4:
- clk-divider:
  - Switch flags function arguments from u16 to unsigned long.
- clk-eyeq Kconfig:
  - Remove OF dependency that is not required.
- clk-eyeq driver:
  - eqc_pll_parse_registers():
    - Make clk accuracy computation more explicit using a comment.
    - Early return when not spread spectrum, to deindent code.
  - Rename eqc_init() to eqc_early_init().
  - Remove the early match table. Register a different function in each
    CLK_OF_DECLARE_DRIVER(), which calls eqc_early_init() with an
    additional match data argument.
  - Add __initconst to early match data structs.
  - Remove spinlock on static linked list.
- Link to v3: https://lore.kernel.org/r/20240708-mbly-clk-v3-0-f3fa1ee28fed@bootlin.com

Changes in v3:
- Kconfig: add "depends on 64BIT" because we use readq(). This removes
  the ability to COMPILE_TEST the driver on 32bit, which is fine as
  this is a SoC clk platform driver used on 64bit SoCs.
- driver: avoid `of_match_node(...)->data` because, if !CONFIG_OF,
  of_match_node(...) is resolved by the preprocessor to NULL.
  There is still a warning "eqc_early_match_table declared but unused"
  if !CONFIG_OF. We fix the <linux/of.h> header in a separate patch:
  https://lore.kernel.org/lkml/20240708-of-match-node-v1-1-90aaa7c2d21d@bootlin.com/
- Link to v2: see [1]

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
 drivers/clk/clk-divider.c                          |  16 +-
 drivers/clk/clk-eyeq.c                             | 783 +++++++++++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 +
 include/linux/clk-provider.h                       |  15 +-
 7 files changed, 839 insertions(+), 60 deletions(-)
---
base-commit: 31d10adec91d1b3e51d7eaea7fdf294f1ebe83df
change-id: 20240628-mbly-clk-4c6ebc716347

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


