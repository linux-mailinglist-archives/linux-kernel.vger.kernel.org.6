Return-Path: <linux-kernel+bounces-395970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD159BC5D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DD31F222EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C111FA25C;
	Tue,  5 Nov 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="UOE/pQF0"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA21FDFAD;
	Tue,  5 Nov 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788949; cv=none; b=gb18Rr+SLMBkIsiE1/RFiQ0Q7TpSCkBkmu4IzLMCfGb4Ydv53pZp+zhgP7XJR86REGBr21ZA06Y8vLcLs9uFvzKZWg/aLkzQBYe0MCchnpBZPGcuC8KMNSAUTZ8vXeYQCr1vKkJo3CMK/B+mfzBTu/+VWDMWpWInbwdKprFJgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788949; c=relaxed/simple;
	bh=/N/tBcY5Ap6L0FyIz7W+ZKJeqrPEXK9I9dM7w+tRjIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZ8Ysazm6AE0SdCIZa65/Pq301sN1jhiTnqkXyrjdqB3W00aBebfj6/2n69dSThUkDKXHNZxVt6OePeYu9Naz1s6z5TkTWEyFbaE5zkITBF+kpUoSgzj21ukGmDr62zyOpzyfTx4i5Hg/cmO7DGwv6chnJY7Am9wU0l/XBnXA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=UOE/pQF0; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu [87.97.112.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2220A88EDE;
	Tue,  5 Nov 2024 07:42:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730788939;
	bh=xhHi+o5Mgt4vE62+EN185nyzLfwnIHMnzNtTNTjPFfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOE/pQF0fr5eZRf5Fq8jpI55EHP9/kiZYNJ6x2vS3lBp6H2XraRZYjcYoB2qOvkNf
	 2XZyu5qM9kkh2F8azEF9d+uN2OKHtf84dy+9Z1WD6fE7r1BBaCqHgpBTVLvMznCgqb
	 bMcGN6hhju2KbVsTppnJFqTAeuwBW+2WgTdFNh9ryRstSGD9mFxLcfHsusC/cdAghY
	 omCTM/n5ZPFBbBeEstXsqCYRUIBKc9jBXsnaqap9X9T5kOhxcHWbzOsQcA/P4on/O2
	 MtB4gOEAkSBVVIQ5Nv6rFM+GYEdwacy47RVV37nAs6azQNJgszCNMGv1jbz4jCuBaX
	 E/OeHq1CS+NNg==
From: Heiko Schocher <hs@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: Add ABB SoM and carrier
Date: Tue,  5 Nov 2024 07:42:04 +0100
Message-Id: <20241105064206.43626-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241105064206.43626-1-hs@denx.de>
References: <20241105064206.43626-1-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

add support for the i.MX8MP based SoM and carrier from ABB.

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
added Reviewed-by from Krzysztof

Changes in v2:
reworked the compatible strings for ABB imx8mp based boards
called dtb checks, no errors for this patch

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..b933788f756b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1090,6 +1090,15 @@ properties:
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp
 
+      - description: ABB Boards with i.MX8M Plus Modules from ADLink
+        items:
+          - enum:
+              - abb,imx8mp-aristanetos3-adpismarc # i.MX8MP ABB SoM on PI SMARC Board
+              - abb,imx8mp-aristanetos3-helios    # i.MX8MP ABB SoM on helios Board
+              - abb,imx8mp-aristanetos3-proton2s  # i.MX8MP ABB SoM on proton2s Board
+          - const: abb,imx8mp-aristanetos3-som    # i.MX8MP ABB SoM
+          - const: fsl,imx8mp
+
       - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
         items:
           - const: avnet,sm2s-imx8mp-14N0600E-ep1 # SM2S-IMX8PLUS-14N0600E on SM2-MB-EP1 Carrier Board
-- 
2.20.1


