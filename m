Return-Path: <linux-kernel+bounces-239555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7F926215
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D1284BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909CD17B43C;
	Wed,  3 Jul 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HLOuQYVI"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2A173336;
	Wed,  3 Jul 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014399; cv=none; b=aev9C5wPJ2Jb7CGksTGKG7HuhCBerJ8WWcjBYSySMzWtyCRLUKgfGU3L2jf3osfEV3sZmPmPxoTXYgsMsT62LCx1iNMgDBw4EbXm8jxfG+yqQtSyUFOapsv4OUQzpBLQxAKw08wrH5Nj1tTAaL+uIAC+yp5HbeQdKKqP+ulOTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014399; c=relaxed/simple;
	bh=3rbejkaedxT29XraRDTu4kmwtIuQe1JLN2aB8gV80O8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ATDLAzm0ViRMeIL5GpaDSXzU10avm1kxRYz7LFSYJ6ZcR5CzS8X33W1DHO/XDr58uEF+L08HVi+rHF/pzpJE1D0SNJom3KVy9MLpndfLFjW0+7jld/dyePW6/xHAevTvZyd9msJyVfkg1SJ4Y26Kwl6CGJxcU12ioSjATgQ0EIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HLOuQYVI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8507540006;
	Wed,  3 Jul 2024 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720014396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E7nyC9xIhY3z4m+xbftKrt+sa3nij1VWrsRiYkc5o3Q=;
	b=HLOuQYVITl7k2zCLupO8rAknJ2K1RP6pGqJxly+lnIkGMi/siYfz6esXL1H7C9s1mxnFWM
	9P1F2lAAx9/0/vaw04AyVhLMw2+GEH5Tpp4kLGNkZzEi3GeeUn5fG1xYdmw1xdvLsxs6g8
	NiB2fFUJNAZjIGOObmr4O7t9rbXpOUVX1Rz/bBtkrMqe5dhhkXWypei5PBQfqUGAca4Qtp
	MwqyZ1dMmaQF8x/SGKT5QkVmnauoY3AYXxXsSrDneVwEjm9JzGCmFe2d1VMm9jbTPgweaL
	5w1zcPi4/insa7NfTwiNQIi/PjT2CrtMh397pU7LITx0jApQ4Z/rpl1+8RuuUg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 0/2] Add Mobileye EyeQ reset support
Date: Wed, 03 Jul 2024 15:46:31 +0200
Message-Id: <20240703-mbly-reset-v2-0-3fe853d78139@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADdWhWYC/23MQQ6DIBCF4auYWZcGR0u0q96jcaEw1ElUGiCkx
 nD3Utdd/i953wGBPFOAe3WAp8SB3VYCLxXoedxeJNiUBpTYSoWdWKdlF54CRTFqpZUyzWT7G5T
 D25Plz4k9h9Izh+j8ftqp/q1/mVQLKXDssG+taZseH5NzceHtqt0KQ875C81y78amAAAA
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

This is a new iteration on the Mobileye system-controller series. It
used to be sent as a single series [0], but has been split in the
previous revision (see [1], [2], [3], [4]) to faciliate merging.

This series adds a platform driver handling SoC controllers resets. It
is an auxiliary driver being instantiated by the platform clk driver.

We support EyeQ5, EyeQ6L and EyeQ6H SoCs. The last one is special in
that there are seven instances of this system-controller. Three of
those (west, east, acc) contain a reset section.

Related series are targeted at clk [5], pinctrl [6] and MIPS [4]. The
first two are receiving a second version. The last one has no change
and stays at its V1.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240620-mbly-olb-v3-0-5f29f8ca289c@bootlin.com/

[1]: https://lore.kernel.org/lkml/20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com/
[2]: https://lore.kernel.org/lkml/20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com/
[3]: https://lore.kernel.org/lkml/20240628-mbly-pinctrl-v1-0-c878192d6b0a@bootlin.com/
[4]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-0-f53f5e4c422b@bootlin.com/

[5]: https://lore.kernel.org/lkml/20240703-mbly-clk-v2-0-fe8c6199a579@bootlin.com/
[6]: https://lore.kernel.org/lkml/20240703-mbly-pinctrl-v2-0-eab5f69f1b01@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- Kconfig: replace "depends on AUXILIARY_BUS" by "select AUXILIARY_BUS".
- driver:
  - turn rcdev_to_priv() into a static function to avoid a gnarly
    container_of(rcdev, ..., rcdev) bug and use the typesystem.
  - eqr_busy_wait_locked():
    - assign values to base, sleep_us and timeout_us in the variable
      declaration block rather than later down the function.
    - fix indent of the conditional in the read_poll_timeout() call.
    - rename val0 to rst_status and val1 to clk_status.
  - eqr_status(): reorder variable declarations for offset and domain to
    be next to each other.
  - add comment expanding on usage of mutexes in the device private data.
  - add comments mentioning that both RST_REQUEST and CLK_REQUEST
    registers must be kept in sync, in both assert and deassert code.
- Link to v1: see [2]

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
 drivers/reset/reset-eyeq.c                         | 570 +++++++++++++++++++++
 4 files changed, 584 insertions(+), 43 deletions(-)
---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240628-mbly-reset-ac6c66d3bf95

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


