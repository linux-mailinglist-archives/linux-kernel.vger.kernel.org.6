Return-Path: <linux-kernel+bounces-170638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E418BDA14
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC311F238E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04307548F8;
	Tue,  7 May 2024 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSllRN4Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282B54911;
	Tue,  7 May 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055231; cv=none; b=KQ30GjwvcEs/KvTy6J1mRfO0Qopilh94EeriZ/cz/zA/v7EenX4iVX3q//8iT5KU81FDFY2frn4is9WYXns/XCKvzbhQMP2x4j/X180xYG3JlH4hy+NxHq40gQ+XN5cgD0MCSrhMa9C6GF7G6t0lLXRdqHDWlTONRW+XObCYseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055231; c=relaxed/simple;
	bh=DKpFFQJLudXl5q5EDowTbB8AIlbECgKiTc8spqPSV7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1TCLpjvL6MOuhIwumeXcmrjrURnv74HPrNcofnSFm6XE5brFPIVZutikKPDbwTN47zg8q1OIk1OSqYBTonoHzXIHxzNl2oBQ7LRPLb69VqJtcR4D3x2Q7oBoQuDNSzIry5Q9jC5iNopsutrlHrXBSt824zo85O3u0aG/Pkj6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSllRN4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF888C2BBFC;
	Tue,  7 May 2024 04:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715055230;
	bh=DKpFFQJLudXl5q5EDowTbB8AIlbECgKiTc8spqPSV7w=;
	h=From:To:Cc:Subject:Date:From;
	b=rSllRN4QHUKvRMyoS8yZW0F2AwQZhSttdbSiC9Q22IV+Lm/n2D6IjNBVOp8oyFV+G
	 b4Azf7LNAeFS553mVgf4vI+9ZBVPLQ5ynoT8jCv/5+CBQgskl5a7OGVDHzc0EEzIof
	 yWAhwSq+YPNqgD6kvKp5fD12VCCv3Hljlpg8XkSXU46/EnnkpSCrqYyfVQZx3S34tY
	 LV+QagkNJ47NCBvXoB3MIsjo8mOc/XJwZCFWTNKWBzeWnnvKKoKfhC9wA+HStz9bLZ
	 JOXz9jbeP9v9/AQ6kEWBVGdwa+mk5YCm90/zIsxgaUg8gHtPsX4mKfCFrzlT6l+IxN
	 y7q6x1bzMXRKQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 3DF815FE3B; Tue,  7 May 2024 12:13:48 +0800 (CST)
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
Subject: [PATCH RESEND v5 0/2] regulator: sun20i: Add Allwinner D1 LDOs driver
Date: Tue,  7 May 2024 12:13:41 +0800
Message-Id: <20240507041343.272569-1-wens@kernel.org>
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

This is a resend of the Allwinner D1 LDO driver series, separated by
subsystem. This part contains just the regulator driver bits. The sunxi
SRAM binding part will be sent out after the merge window due to a
conflict in next.

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
 drivers/regulator/sun20i-regulator.c          | 156 ++++++++++++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
 create mode 100644 drivers/regulator/sun20i-regulator.c

-- 
2.39.2


