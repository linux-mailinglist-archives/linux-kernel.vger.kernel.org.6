Return-Path: <linux-kernel+bounces-358508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27E99803B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD828107A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F971C3F1A;
	Thu, 10 Oct 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="jGWfc7LH"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDB1C3F19;
	Thu, 10 Oct 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548259; cv=none; b=b3adfU5SouQlaMRvEIYItDKGP2COJZh9vBmu/Dp5wy2N4v+7lbL/ZFPaDBuYiQ/xwLHmBI7WsJjS7uosAwuGnpZlyRA9SyVjpkjyQN0CBJk35MPLB/FlDUO//hCgrWBYbqb6Ksot4nEr7Cvo07adaWlOXD4gjdcyjC0d62B6+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548259; c=relaxed/simple;
	bh=u/RV5snKlz06wQqXDgWLX0hdoSNe/rd3n154CWQGdog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9zEManIRsii2o89wESxn8mgdg6B9HnxrxiM8YZSzvW1B8EdV0p++3MfenzAXg0ikickGUMC0ghjCRLygFvLNm6mG1FQURhdfkLMDy3o7g8cTSmQOwxLhHM9hECFYTXef0hZuznLOaScoV+XIZpoQEFxLqZYju4m+M/l3s5gb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=jGWfc7LH; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E960589253;
	Thu, 10 Oct 2024 10:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728548253;
	bh=0fhsYrDRoI1ChoLX0fTql2+AKk5927de0Mo+mllJGeo=;
	h=From:To:Cc:Subject:Date:From;
	b=jGWfc7LHMdoedGWJDpkGBv0Iq1uQAFE2cVd4u2jGQL6dOlBFMQQz0854mce1522Vo
	 ir/ub9/EtvNMinQUpE81hD1gyfHwNExkQoo+k5q13d7paS5R/sVFTjAjVMYrj2vGq5
	 j9OnW0TrTC8P/jCYggpAaIscmt67m/L7jzxZWHQ2HRdChwmhYsFKx7Av7NtxR0lyMx
	 1crYhiYAenSvfp6KK/pRbZj2Dyn2+RIJpUfoLs9aZMdxP7X0xypoOw2UXcyCXB0wXQ
	 tHTaT0quga8JqAD3xwe7rPgw2dM764iC0nYNMl2jyTArMzwMIEWDe/VAxC3ltQDeuP
	 Hk7yAvd+Z+eyA==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Lukasz Majewski <lukma@denx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/2] dt-bindings: arm: Document the btt3 i.MX28 based board
Date: Thu, 10 Oct 2024 10:17:18 +0200
Message-Id: <20241010081719.2993296-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The imx287 based btt3 board is very similar to xea in terms of used SOM
module.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
Changes for v8:
- None
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..2b5c405d15ef 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -97,6 +97,7 @@ properties:
               - i2se,duckbill
               - i2se,duckbill-2
               - karo,tx28                 # Ka-Ro electronics TX28 module
+              - lwn,imx28-btt3
               - lwn,imx28-xea
               - msr,m28cu3                # M28 SoM with custom base board
               - schulercontrol,imx28-sps1
-- 
2.39.5


