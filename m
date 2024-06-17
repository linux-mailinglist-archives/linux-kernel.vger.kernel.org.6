Return-Path: <linux-kernel+bounces-216985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536990A95C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38D51F21A21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C1195F02;
	Mon, 17 Jun 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeWZB1Yu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F4191487;
	Mon, 17 Jun 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615676; cv=none; b=e1B4ko0OljZYf2aXhuwTOh9Z82va0tKcrQlSli+7hVyqSdX8fCkr7kkTYUAYd2MfKE+KlsODD6WxCauJlbYwjGiyigb40L4+NUxsBR7rOylibKrTZCZSHVo3bo+THjeB6f0m6lrOXD4R+w+1TSKRwbl82deP+6paKtxQOvCdY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615676; c=relaxed/simple;
	bh=RlPWeWXjhvnYwwTMXwCVHKOnptTzdjxk1lMBqmrQsYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lINKwtHqeZ4/slagvybrlaqh0MF29ANbsXUbLo6PTeq7yooJzd5atSy6Nqvss0ewFaADf4M+k3WtR3jnGSMWJ0lKX1hAJZmCys+fqpL4zp/1ZvNhPdidmhDhdzLZqa9dAHgKe7FyDbxCbamGQk+zTcueBXowIHELCpCQ0BHqV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeWZB1Yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAC9C4AF1D;
	Mon, 17 Jun 2024 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615675;
	bh=RlPWeWXjhvnYwwTMXwCVHKOnptTzdjxk1lMBqmrQsYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeWZB1YumCqPsTcKN0L8sJBtZSltuamDJN5SOMEQ5Kaq2IZsHBhmjUCOg0WVwBebF
	 zDoeEjpo4uthc2UcisiZwWED6h+0z3by3IQufGqSkar3QEyrj+mQDx2Umc+ot5suTC
	 1K+CbBSx/QrktYF7dvM1XZHp30q79JpuxRxBnMOqFDb67EnlSI/ADw1bXcA7Q9NLOp
	 mz5pnUFLd0EMdXG6kjF8TeKNYPNrOn/qGQoViSz2Ed1lOe74Zb4AhQycJsQjTZJW0j
	 jZgcfEpFbFBNg/bHZhkGH/eht84WBwY4c5EV6Ok6tEeqcqXXG9KrwOK7DqtmdPr4Rh
	 05iOEoNX7YcKQ==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Li Yang <leoyang.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 12/13] dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
Date: Mon, 17 Jun 2024 11:13:40 +0200
Message-Id: <20240617091341.2375325-13-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617091341.2375325-1-mwalle@kernel.org>
References: <20240617091341.2375325-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kontron SMARC-sAMX6i is just a module. There was no device tree for
an actual board for now. Document the binding to use the module on the
evaluation carrier.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..f731fb5b5e2a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -363,6 +363,12 @@ properties:
           - const: gw,ventana
           - const: fsl,imx6q
 
+      - description: i.MX6Q Kontron SMARC-sAMX6i on SMARC Eval Carrier 2.0
+        items:
+          - const: kontron,imx6q-samx6i-ads2
+          - const: kontron,imx6q-samx6i
+          - const: fsl,imx6q
+
       - description: i.MX6Q PHYTEC phyBOARD-Mira
         items:
           - enum:
@@ -544,6 +550,12 @@ properties:
           - const: gw,ventana
           - const: fsl,imx6dl
 
+      - description: i.MX6DL Kontron SMARC-sAMX6i on SMARC Eval Carrier 2.0
+        items:
+          - const: kontron,imx6dl-samx6i-ads2
+          - const: kontron,imx6dl-samx6i
+          - const: fsl,imx6dl
+
       - description: i.MX6DL PHYTEC phyBOARD-Mira
         items:
           - enum:
-- 
2.39.2


