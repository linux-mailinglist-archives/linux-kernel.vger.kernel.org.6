Return-Path: <linux-kernel+bounces-203942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCEC8FE22C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8E21C21FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132215A848;
	Thu,  6 Jun 2024 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnAPR6YB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426A158D97;
	Thu,  6 Jun 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664582; cv=none; b=NdOYWIvDVHuDcLxqray11WLw95A/EjuQuz6kwMermujzSIJ+qoL0y9CL2iCyfCeQ7o+61jeiu+zAI7zthPo/Cnv4BB/AmrtcaJDdZofOEeLEkXjsfWNOnVJp28Jyo3A2yOirzF/21kfCaamgKkhqyCw83T3CqRN2lnOus7AvorE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664582; c=relaxed/simple;
	bh=RlPWeWXjhvnYwwTMXwCVHKOnptTzdjxk1lMBqmrQsYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IU1qjD7Mq5/uRy+3EpHZAXPcHedyPxQuBCuu4qjQos4LrUB/fohvj63GwplMW48u2IV0ND+ZQAaR48NDe3qiE87Xyb0c+UKzbAVo1hgiILAhX5Y8aQScMEjOmY+vRQoObJ9PdK/58l+rs/cni/irk8VYZeay0510kbw76mrZwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnAPR6YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF1C4AF61;
	Thu,  6 Jun 2024 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664581;
	bh=RlPWeWXjhvnYwwTMXwCVHKOnptTzdjxk1lMBqmrQsYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnAPR6YBV6SAMPU3L92YhfSkWaEWg7lywvO6Pbu1r9/6AhLb3h8v4On8qWjcsMqdK
	 yEGgOh9gxZa5LgFCXgUtTRQpRfgEFGiwsXvucgYQIf1X3mEeNe7rui/KctzrroFDWU
	 bVfDUh6C7ycKzD2f4aqx8AcuVtGkV/GxWLfQ5MizHUcYR6yAxhmD2xr/m6pFvzqsrx
	 rLCShOG7IJzL3E9zUmLzRfbhK1Cc6AROYRklBYfDvCxWJsnub5Vi29KfMnldp/eBBI
	 djdaEdPrE70x/SQ2UpNUE/3YOomzpebb9EX9gnhFnedDJb4mGEJ4yCf67q1TdRn7Zf
	 XCDOyByvMlNWg==
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
Subject: [PATCH v2 12/13] dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
Date: Thu,  6 Jun 2024 11:02:05 +0200
Message-Id: <20240606090206.2021237-13-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606090206.2021237-1-mwalle@kernel.org>
References: <20240606090206.2021237-1-mwalle@kernel.org>
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


