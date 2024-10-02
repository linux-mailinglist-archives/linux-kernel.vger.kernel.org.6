Return-Path: <linux-kernel+bounces-347356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC798D19C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C25B23E05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1731E767B;
	Wed,  2 Oct 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiPqEWpA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B71E765A;
	Wed,  2 Oct 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866106; cv=none; b=aNdKm8B5vX94RypFWBEEuH0swBUzIAinWPDNzZeAQsl+HdLbMYUUMFXyTl3vSnnFcig5e2PDTCGhTycu/nAgcntL9/2FGcgg3AbyuwXaf/j28ichNS6hOYrDvJ9D8S98LYTmyAD4P+vwuS5R+8YroScFiVc4uAiQcPLF5QiSPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866106; c=relaxed/simple;
	bh=iu6oBhUAOuMmbpup1hHGDc3avXmUfIwkO7bEe63eIVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvKwP+XomGEn/9hjQ+TcjqEsr7A6T1TOuswK1wADAwqI5nglcsiBnkxaudpeiYk65gODMH3tOJlKa7LBRDRpGgHqTFeultryUaMzrQBZGybAkb+B9QKalxbRGVawwvnxsNkGBhWMa+InfsNsIuDxQGBIuWC3BrIoLXZzq/0MqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiPqEWpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1B7C4CED3;
	Wed,  2 Oct 2024 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866105;
	bh=iu6oBhUAOuMmbpup1hHGDc3avXmUfIwkO7bEe63eIVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiPqEWpA5nCcwtH33o4XrUpfxikAz42cs9nDFndHzMGuHNTCjXb+ICf0oeNIliQf3
	 GwlERzS5SJiIUh6pZkI4IMUxPNvQtxFJUegF6Gj27hT5OtSvEi6lyPDcTFyZ5yPHNg
	 X6ouQE/epC1rKvWrNVwMSIfwsCyTGJ1t5XSIWSw6tgOdFIA5NQBWvzf8zmoXWkYNSs
	 Nkav9oHPhx8HR2DtervWg795PO7eInVxsDHf0U/k4ud6VXXsYoFz/9D9oP9cNnAjUR
	 L+qEpzHqYkEJ5Gvk7F6KwyT1eOgsLSQi9zyVkWG/ECMWYxRnsP+qG4u4mVIJtcnDlu
	 1vFUrfidcIr1Q==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 03/11] dt-bindings: mfd: syscon document the non simple-mfd syscon on PolarFire SoC
Date: Wed,  2 Oct 2024 11:48:01 +0100
Message-ID: <20241002-clambake-raider-a8cbb3a021a8@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=tHRWpiyQ8iCGyCWP4whQFJhUVatxkKCTPz6PLOlptNk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/VR7YfD0Ty3S3cb+Hf9Cfmd9/Nc6qfPvSy3v2Tbbv0 z/+2mTT01HKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICbfJnhF3NBYWLgZ7vXazy6 eOpnnTe7J+IzN6ZqRdKTWclH63ZfusbIcOAHi8fUy9PcLW9997Tut9AuXHDl9KKWCVo7JwZL3rE 4wgEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The "mss_top_scb" register region on PolarFire SoC contains many
different functions, including controls for the AXI bus and other things
mainly of interest to the bootloader. The interrupt register for the
system controller's mailbox is also in here, which is needed by the
operating system.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index cc9b17ad69f23..b414de4fa779b 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -88,6 +88,7 @@ select:
           - mediatek,mt8173-pctl-a-syscfg
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
@@ -185,6 +186,7 @@ properties:
           - mediatek,mt8173-pctl-a-syscfg
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
-- 
2.45.2


