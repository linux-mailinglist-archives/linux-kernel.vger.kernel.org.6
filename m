Return-Path: <linux-kernel+bounces-399555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045689C00A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4161F2389C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73A1DF266;
	Thu,  7 Nov 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="pht0m1on"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CA1DE894;
	Thu,  7 Nov 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969865; cv=none; b=aC/ma3/p4UydKB1BzbNB/KbuHtSO+zjd/wXJAekkKhqTUpDEEVFhItGVragRTIbp7xiLxWI1Ao8aED7S4snKFSA8rQgFD0cRhCXidR+SmmdB+VnruneX5I5kYp9VMggvnw4iWpqdwoHc4yz/f2XHKHQo/4wz57aqDFLM+045y2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969865; c=relaxed/simple;
	bh=bGfpGeRsbvQDZQmgoKoy+eB9Y5aBJwApSlDs5wEthDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnukzMKXE/WFjEbOTAYKOHE1sw6vI3T8sR0UirJNNiXBzPuXTagCqphiLf/4QLK4oVjhrZd7ijUM0lq912GHSoD9jJ58kQ/4nUM4jT63Q6kpXUG4fLfGCy/sHPIpWdpb6py9O5YtfWnkkiLaAK9cN9zGqnrFTa4r7VPPC9EarYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=pht0m1on; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BF0DE8904D;
	Thu,  7 Nov 2024 09:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730969862;
	bh=FVx91PzaBK98MLZQYwY4FrPtcC5DxNlPD2xbYW+sIEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pht0m1onep92FMEx1yTFQwV0QkfLKjFLvHkjT3tJ7kf9n20jiHyNbsn24YvWuvHGp
	 FOXA/NzMBQ3OtXvp8gR19xjN8Iu8sij7yPPOI3+Q3GQjC31pCwiVHnGh6Cmzqjl74Y
	 aYLkhqM4YL0FxMT0uI/YlL85LQiujca+roAzk9adhsMn1L6AknmuvoDiqf0TbpoKW3
	 qKv6cjrL5zchsMYG34ULnCMht7g6YTYUNe6IbTRYbW6Pk3t1T1e69xz9/oYVBxZrVg
	 aLCIhZwSUHW97edrb66hzDv2xeJ/0DNWn6KOSQVKCypfNL5ZnyUImOjmYbJwUVGF0r
	 ZSLvP5/5mDygQ==
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
Subject: [PATCH v11 2/3] dt-bindings: arm: Document the btt3 i.MX28 based board
Date: Thu,  7 Nov 2024 09:57:04 +0100
Message-Id: <20241107085705.490940-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241107085705.490940-1-lukma@denx.de>
References: <20241107085705.490940-1-lukma@denx.de>
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

Changes for v9:
- None

Changes for v10:
- None

Changes for v11:
- None
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6e0dcf4307f1..abebf8e2a298 100644
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


