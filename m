Return-Path: <linux-kernel+bounces-174636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE358C1201
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42C21F21A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652816F82B;
	Thu,  9 May 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ29uykF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34814A612;
	Thu,  9 May 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268676; cv=none; b=slm5hV+T76K1cg82AP44hjbs4goKPdN+CwPTcY7/SH1utUggX2C67l4GyAn7Ek63jq13DpNQ0UiGtyrMn3R71mmF8ERag7f/QS6qBmNkm6u8k0Co9tyH1nZ6W2JYd/Fe7kygo/yZcBVevo71WdR7AUPWNp0YzajHucBK5gMQaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268676; c=relaxed/simple;
	bh=E1T+WvvKQJ/1nv6nEvXpTe9Sga5sVZOQiVRom7AV5uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBLetPmD6Mm3WyT/nfvEOjriRT8hRfQqvdcKGyzv5OVwir17YMJ0nzNg+5jMKhOMSjPzgLynRvNil5gjkv20o2K3U2qkYCJrj1eFRUkS/MgQPh0z03B8Zg50XEz5y5QFtXO/xMV6QT0viB7DVM8+SCm92BV/egCnETTcUIwSX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ29uykF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233D4C2BD11;
	Thu,  9 May 2024 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715268676;
	bh=E1T+WvvKQJ/1nv6nEvXpTe9Sga5sVZOQiVRom7AV5uQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FJ29uykFQL3ACOuqQURRxlGidNafj5oQb6JnqYrJTZ+igXr14m9qaQcXnV8r2PpuI
	 8oKsmxqeElmZVd/V+fA7Z812L+J5qPfm0NQwhr/c8xXZ2O47DO7j1sfZAkBjf7h2iw
	 1i+ci9rIy2DTaNHJsSwTFaIkZQ85dZC2vxbThxa3fvXjqfd8Cj6+Ug1fUYe1rciV7g
	 mur4fq7pC1V8Fu2Wt9/iKO4JnGgmNn7vWmaOK45IuKSBMj9KbsAa7lA5GS5rbfyHm6
	 E5Z7X4fBFvXI429BaS5k7zR5gPvmK5Y4qpq08TRMQcPH1sep/bVlCQXvAHmCUMG5eI
	 TQop7fnXwcFrQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 9E69B5FB60; Thu,  9 May 2024 23:31:13 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v6 0/2] regulator: sun20i: Add Allwinner D1 LDOs driver
Date: Thu,  9 May 2024 23:31:05 +0800
Message-Id: <20240509153107.438220-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi,

This is v6 of the Allwinner D1 LDO driver series, separated by subsystem.
I've picked up this work from Samuel.  This part contains just the
regulator driver bits. The sunxi SRAM binding part will be sent out after
the merge window due to a conflict in next.

Unlike what the original cover letter mentioned, it is perfectly OK to
merge this part separately. The SRAM driver changes were already merged
some time ago, and the SRAM bindings depend on the regulator bindings,
not the other way around.

Changes in v6:
- Include linux/of.h in the regulator driver to fix the "implicit
  declaration of function of_'device_get_match_data'" and unknown
  type 'struct of_device_id' errors.


Original cover letter:

This series adds the binding and driver for one of the two pairs of LDOs
inside the Allwinner D1 SoC. I am splitting up the two pairs of LDOs to
unblock merging the SoC devicetree; the analog LDOs depend on the audio
codec binding, but they are not required to boot.

A binding and driver change is required for the SRAM controller, to
accept the regulators device as its child node.

The example for the regulator device binding is in SRAM controller
binding document, per Rob's request to keep MFD examples in one place.

Because of this, at least the first 3 patches need to be taken together
through the regulator tree, though it should be fine to merge the whole
series that way.

Changes in v5:
 - Correct the voltage calculation for the non-linearity around 1.6 V.

Changes in v4:
 - Fix the order of the maintainer/description sections
 - Replace unevaluatedProperties with "additionalProperties: false"
 - Drop the analog LDOs until the codec binding is ready
 - Drop the analog LDOs until the codec binding is ready
 - Remove unevaluatedProperties from regulators schema reference
 - Check the compatible string instead of the node name

Changes in v3:
 - Add "reg" property to bindings
 - Add "unevaluatedProperties: true" to regulator nodes
 - Minor changes to regulator node name patterns
 - Remove system-ldos example (now added in the parent binding)
 - Adjust control flow in sun20i_regulator_get_regmap() for clarity
 - Require the regulators node to have a unit address
 - Reference the regulator schema from the SRAM controller schema
 - Move the system LDOs example to the SRAM controller schema
 - Reorder the patches so the example passes validation

Changes in v2:
 - Remove syscon property from bindings
 - Update binding examples to fix warnings and provide context
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle


Samuel Holland (2):
  regulator: dt-bindings: Add Allwinner D1 system LDOs
  regulator: sun20i: Add Allwinner D1 LDOs driver

 .../allwinner,sun20i-d1-system-ldos.yaml      |  37 +++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sun20i-regulator.c          | 157 ++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
 create mode 100644 drivers/regulator/sun20i-regulator.c

-- 
2.39.2


