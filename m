Return-Path: <linux-kernel+bounces-234184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06F91C367
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EDEB23E49
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB481C9ED0;
	Fri, 28 Jun 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AJLPegyF"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257CC1C8FC3;
	Fri, 28 Jun 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591081; cv=none; b=Ot7rWbv4wJteWVwozygL6Xcw2OQ5eQouGtJNzb3auW64x5CEjPuXOUPVDnTeOkeGB/aoprui+Cve8VThEa0Typoy6BJ1bzAzf6snbiruWVLERUZSlwaOJ9HZlJnGUNr8Aj4PXdB6Fw1YSaz1VjUkfryCmCUAx9N3yxiChCeGYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591081; c=relaxed/simple;
	bh=2TByJygFZRspviBZk7/R52/FvzLjFPV45m6rSItk78k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ox6ApFT0UXOTNTmYnNq4ddlV4zVnteMOK46PO93kG56G0OQ0Yfk+S1Vr0OA4JtnsvMOnxG9Gb4dEniwM/1KzDCEbSPyRRUic4fLw8d9MTU3rElkzpLIXiYIol19xkP9PChi8JUGrMWjLZfw6KcvirqQjzkxmxehXvF2pEzu8H3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AJLPegyF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB92F20003;
	Fri, 28 Jun 2024 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719591077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FhJNGKSniIttOxqa1sfiTaCpdgEUbL19s7yu7bVHg3k=;
	b=AJLPegyFuvFrH1jJ1/seupImC2j1Gc1cUGleG17KTfptiet82mF9FSn8SKRl57QRf4L1hT
	0ok1phio2wCdD8ikJvFQ0ModnqvupLDI456K6w3Z5YrKJ56g0lytRFSlsUrX/9e+1InQPo
	Y677+KmYuGr3cB0GQlTmtXvIjaGenZrTZokxYv0jaX2mm1qCp9CVHjgTk+zZiGK691Y18a
	jlpGwqDCG4QYWgZRpLMbrrRess8QqsAYrQFPx9Xm3rkL9C8hhc8yS72Z+/O3waeDLxm50w
	bxl3pavKm1E8/vQ+EOeRomRC59vuBDrZffPCv3yyGgdl9tyPOQY5lAsjEdfI4Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/2] Add Mobileye EyeQ reset support
Date: Fri, 28 Jun 2024 18:11:14 +0200
Message-Id: <20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKLgfmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyML3dyknErdotTi1BLdxGSzZDOzFOOkNEtTJaCGgqLUtMwKsGHRsbW
 1AEH/t/NcAAAA
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev-13183
X-GND-Sasl: theo.lebrun@bootlin.com

This is a new iteration on the Mobileye system-controller series [0].
It has been split into separate series to facilitate merging.

This series adds a platform driver handling SoC controllers resets. It
is an auxiliary driver being instantiated by the platform clk driver.

We support EyeQ5, EyeQ6L and EyeQ6H SoCs. The last one is special in
that there are seven instances of this system-controller. Three of
those (west, east, acc) contain a reset section.

Related series are targeted at clk [1], pinctrl [2] and MIPS [3].

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240620-mbly-olb-v3-0-5f29f8ca289c@bootlin.com/
[1]: https://lore.kernel.org/lkml/20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com/
[2]: https://lore.kernel.org/lkml/20240628-mbly-pinctrl-v1-0-c878192d6b0a@bootlin.com/
[3]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-0-f53f5e4c422b@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes since OLB v3 [0]:
 - MAINTAINERS: Move changes into a separate commit to avoid merge
   conflicts. This commit is in the MIPS series [3].
 - dt-bindings: Take Reviewed-by: Rob Herring.
 - Kconfig: do not depend on COMMON_CLK_EYEQ. This symbol is not defined
   in this series, it is defined in the clk series [1].
 - Kconfig: do depend on AUXILIARY_BUS.
 - Kconfig: remove outdated "depends on MFD_SYSCON".
 - driver: remove "#include <linux/platform_device.h>".
 - driver: cast platdata to (void _iomem *) explicitely.

---
Théo Lebrun (2):
      Revert "dt-bindings: reset: mobileye,eyeq5-reset: add bindings"
      reset: eyeq: add platform driver

 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  43 --
 drivers/reset/Kconfig                              |  13 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq.c                         | 562 +++++++++++++++++++++
 4 files changed, 576 insertions(+), 43 deletions(-)
---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240628-mbly-reset-ac6c66d3bf95

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


