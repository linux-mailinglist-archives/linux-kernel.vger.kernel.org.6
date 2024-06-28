Return-Path: <linux-kernel+bounces-234179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEFA91C35A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB92B23595
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4631C9EB1;
	Fri, 28 Jun 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EItXhLRG"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC75157E91;
	Fri, 28 Jun 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591026; cv=none; b=q25dsrrFn/ecH8gUTN2tLOs2Lk8AWinX6c6ReRsykYqeMdvcET6NAXZT23g+ZFnkh6247fdf2qjrcYitdveyNr1hJa5ztte3Pw9mUYvg2J+821Cn+9mT13gM9Tz91SMPleF1PGJoq37u4Bfhpe3PN5YXLx7oQ7LJJIKFosWL6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591026; c=relaxed/simple;
	bh=RtQqm1McMtxf6W/mdzxe40Y+rdMCPpe2ZlNzJ84WwWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IVf4bwoGvTXKd6JccSlGcUYViX9ny0ycbUzLpPEaDbsQ3bDC+12OAcZVzvyZv7vb6VooSUSPDbFxDCL1NCwBNdyLZlHV0m1X6ueupaejglQqudSKN5z5xFFdvVuETviL6zqwh6froacKi/AbUv7hoHOjtEcHQMf1Dv3teFCxRUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EItXhLRG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 119EB2000A;
	Fri, 28 Jun 2024 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719591021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5WLgrTDOFmurSLAwvaiMAmnMimWYX0+hxgnWVemBDfU=;
	b=EItXhLRGJeaIwfbVCLvluh4CM3VENYODmlUQpcbTWFUSiaYi4gUfOEOf2nX4gEGT+s6nhy
	Yq5r9mFCOEn7oOMFMO4qZ5TyePt6MbhXZasBcK+ABtDr7EzN+sgEmN/5norIiuUunLnGgS
	e1pjjP36nCTK5jiixSRRKLJnqgzBt5AFuHXxb+7TenDVqtdAZ5Wg8abAWnhLQW5v580Qv3
	9ei9TK0TyK2rLS111Ee8I/yCY9Sr5qmvpv7tbwIlvSr6xZke034nzbZGl88YyG46nIM0dO
	qO2nCovQKt+eoYgZZP3CKRfRKKu/T8+Phb9XlHDJgATNysbzFmbf+hxUUU10NA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/4] Add Mobileye EyeQ clock support
Date: Fri, 28 Jun 2024 18:10:06 +0200
Message-Id: <20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF7gfmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyML3dyknErd5JxsXZNks9SkZHNDM2MTcyWg8oKi1LTMCrBR0bG1tQA
 nUqgYWgAAAA==
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev-13183
X-GND-Sasl: theo.lebrun@bootlin.com

This is a new iteration on the Mobileye system-controller series [0].
It has been split into separate series to facilitate merging.

This series adds a platform driver dealing with read-only PLLs derived
from the main crystal, and some divider clocks based on those PLLs. It
also acts at the one instantiating reset and pinctrl auxiliary devices.

One special feature is that some clocks are required before platform
bus infrastructure is available; we therefore register some clocks at
the of_clk_init() stage.

We support EyeQ5, EyeQ6L and EyeQ6H SoCs. The last one is special in
that there are seven instances of this system-controller. All of those
handle clocks.

Related series are targeted at reset [1], pinctrl [2] and MIPS [3].

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240620-mbly-olb-v3-0-5f29f8ca289c@bootlin.com/
[1]: https://lore.kernel.org/lkml/20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com/
[2]: https://lore.kernel.org/lkml/20240628-mbly-pinctrl-v1-0-c878192d6b0a@bootlin.com/
[3]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-0-f53f5e4c422b@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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


