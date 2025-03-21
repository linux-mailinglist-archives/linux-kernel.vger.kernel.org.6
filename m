Return-Path: <linux-kernel+bounces-571725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47153A6C14B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C603B7737
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68622DFBF;
	Fri, 21 Mar 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXFejIhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6622DFBC;
	Fri, 21 Mar 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577796; cv=none; b=dFt44+J8WsyrYf77TbjkKXbWETCXzJ6S8cpNBvW0n3N4kwmzf3y2FQbVZPIsuhZG+gOEpebUVJFSXRDRjn7HmUi4R6MEB0W88aZHe/YoAYZyG4k31VLwcqVXyyoNNQ00BNXKCUUmGTmcnDMvecD/pwVQzjO2lz3YOFU9AvbwUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577796; c=relaxed/simple;
	bh=LdttrVC9LW2Uc3o+DVofFcVX4D2cSxS5O7oMwf4zgfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpi44Mnaj5SdXT1GrJHQ5ermVeOHyApigrF5HiaAN2uQI5/yJyPGYAGhjIJBGUHgs8bGeNZCONHm7jlMTYdfadan6sBr8aQfrFCfqByWa++rI5k/kW8wqLKFaK2f9nUdribhe8kn8U8hXFLfUuXpLH7Cy8BFyO4Nmp7Y/c/KP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXFejIhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E91BC4CEEC;
	Fri, 21 Mar 2025 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577795;
	bh=LdttrVC9LW2Uc3o+DVofFcVX4D2cSxS5O7oMwf4zgfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXFejIhekIOHt6FPHNmavV3/wo1faMIUIPdbQPRHIv9Yp4TujjIF3RQQmVtOP6Q0K
	 FrjvuKZhXWmY3hGWT8CU4+WiedUsXo8pAzDvUWLBJZGfM3ToEY9jVjZKgdRRpZfbJc
	 ARbuy8DQMrmhd+4wGV4QXKWxh/f7qXXo92WZn9eCayt08ddyz7A1c9hMqAYPdqT/Hh
	 pXqPYCSyI2FZ9KwJ7RMtumoSvG9o+54ddYPaPqF5ZvdzdgE8JRrVeIPTTFlZT5F9vz
	 af6LCWAJ5y/zssaebvm5BGxJ4/yHK5HJ4zY9gtHm7GZz8KWE6tSNZRoI5OAskMbyiF
	 wlIbc9uibJDZQ==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/9] dt-bindings: mfd: syscon document the control-scb syscon on PolarFire SoC
Date: Fri, 21 Mar 2025 17:22:34 +0000
Message-ID: <20250321-idiom-remedial-daeddab1dcd8@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Y7+f8bm7u98Yh7HV7dNWDNUXNbue9Uy4E1rY4YoJEmg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0Q4t8aefREhwSHkvseLkTn27609HtOlZGeucZ0eK 578Ky22o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPJ0mb4ydgruO2n4uf2nS85 OBvrHh8pSk9ZkMoicVT2xLdg3l/lhgz/07Yb6J1iX1azQ7L4nWP0iVxhnoSe92eaVBovrlwoM3c LCwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The "control-scb" region, contains the "tvs" temperature and voltage
sensors and the control/status registers for the system controller's
mailbox. The mailbox has a dedicated node, so there's no need for a
child node describing it, looking the syscon up by compatible is
sufficient.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2:
add the control-scb syscon here too, since it doesn't have any children.
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4d67ff26d445..777a7a5b22dc 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -88,6 +88,7 @@ select:
           - mediatek,mt8173-pctl-a-syscfg
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-control-scb
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7g5-ddr3phy
@@ -187,6 +188,7 @@ properties:
           - mediatek,mt8173-pctl-a-syscfg
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-control-scb
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7g5-ddr3phy
-- 
2.45.2


