Return-Path: <linux-kernel+bounces-244051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13AA929E6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56A0B214A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CF5674E;
	Mon,  8 Jul 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="SLV7V94N"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC33B290;
	Mon,  8 Jul 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428096; cv=none; b=hN+wl/TbkCGHTsPR3fbUbZQHRo07qHhe48VRUsFgaljv0t5jfx/oV0h9WdqochQWugtkFnyWBYpKogakvO0FgqtBKwRP2mjU6u5zhQtDEZVqjothmAI1AcDKseER4qrdJnMcflYkuL+ldqa7Qwoh6HQPTt63pXbeTopbXEccFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428096; c=relaxed/simple;
	bh=2cglFmVz1Xpw1R2sFVulz1T3QnWmHmbSEE+yMLLZFoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBHczwk9hUjlrdHPhjH2AZlpnLquhddRlOCWZ+Bgrkqyycwnhzuv0qF2KTgX13w1virHbuYN55cwjAdISsGUcJizLiey47dsi/Q+PzBRVyYihcF9wRX+rotYyQe1OVAMq2xJvm0vl5afjG7SOXvl5tcKERwHQrBbKKpFUVt2nvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=SLV7V94N; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F9AEBFBA8;
	Mon,  8 Jul 2024 10:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1720428087; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=D9oTaUMXzjcTo6Wf10s0ulRO2OkpFnNvTpduNNFrDRM=;
	b=SLV7V94NOqUs3KUx9onVyY3+nteYPa0rymNGgqQumEOUBCH7E0zxK0Dc+y05kqDsOk37f+
	4AwNiHgAA/E80SyJv5B4FkqQ+Sb+8sJR9SyGVQA1+NPUR9LGJ6ap7Wvj2XLSsHQnprq53v
	cKLtGrFMd8SIKZwhu5Jf8WO/0FRpAbEEBN2N1zdQ6lWrbQfxweInyO3Tmh8EaCRjcdkWQ9
	V/A6toWTj2SC1aPgNmXwtmDuLTIpPN4ftVibzBgNe8gUtBp+oOAGRrj0DLXNn2t3cJca63
	hH38D6yWArP/y3asGeFcuAQGCee4g3QftsfSPzZUTdIXEHdJFasZel+FgnEg6w==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/5] dt-bindings: regulator: pca9450: Make interrupt optional
Date: Mon,  8 Jul 2024 10:40:32 +0200
Message-ID: <20240708084107.38986-3-frieder@fris.de>
In-Reply-To: <20240708084107.38986-1-frieder@fris.de>
References: <20240708084107.38986-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The interrupt is optional in hardware and not connected on
some boards. Make it optional in the binding.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* improve commit message
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 849bfa50bdbab..f8057bba747a5 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -96,7 +96,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - regulators
 
 additionalProperties: false
-- 
2.45.2


