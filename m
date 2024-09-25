Return-Path: <linux-kernel+bounces-339247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C29861AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A543128C8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217264F5FB;
	Wed, 25 Sep 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="wnV5yGb8"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467B49620;
	Wed, 25 Sep 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274721; cv=none; b=BhbQHSoujsTAcLZhv8Ta+9eI1exUa8vDaXYV5PF0T+1XO9AWxeEdjeQMq2c9YwfluYp2Afd6j1WzaHKPndS+fOoCDYkVOBX1++hL6Ce80cCMdfgpZWCjyTcsL5o4KwyHCzXvtmQKHlzokp6An7xc0cEDmk3Vgw3HCfgUWa4Olxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274721; c=relaxed/simple;
	bh=P6Q8H/nVfZxoli/QLkCamvYcqkoFGaMes991H56nXKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tmu1CYkGuY/9nwSPhu9nd4xbzhhaiY2a3OL2rOgzkFbu9U+Abzkh/XLKydlYmLt2ovWYACTQVDO/fHlSHdsYuV2KAVilIqJVcG1dbBVzEQPtey2mljeQD6wBYwTqbEl2eAv0bw87G6MKZvlVVelZ4ibUHML2u7HXELDUgYCaJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=wnV5yGb8; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BA5EF85B66;
	Wed, 25 Sep 2024 16:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727274712;
	bh=Lu4rvVtjeWbLqPkpe2uf4LN2PWTpI6uvoia3eK+/qII=;
	h=From:To:Cc:Subject:Date:From;
	b=wnV5yGb8IhjheI7hU3yaeiRng4byjGK6k5+smvKVFI+B1+42LfkkSoQz7gNU9fWeO
	 O0YrgaPxwBCnvb2PD4VxcIkZ0qF9JqZyMwJvMhy78PDzB5U5O7ranO4Fb1LSXcERiv
	 YLD3O3FoLZmzx4LgeQ8+GeeJ1MBsbbNwQakFSif3TCAQPvsPdPXNMel7JWlvdZZ04k
	 P8nN6mdJm/SvrtZfTw6CXnlTGLCeiFswKHstf/exJks4MHmea4u+Wle5dhL7Ozt08d
	 3deArbxt3GcBM2F8yW4uKpOysx+HHuunNuAHjiHPXvXHUz35GU67O1Rk7Sav+LMx+M
	 EnKciuilwzmAA==
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
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v7 1/2] dt-bindings: arm: Document the btt3 i.MX28 based board
Date: Wed, 25 Sep 2024 16:31:28 +0200
Message-Id: <20240925143129.4081815-1-lukma@denx.de>
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
2.39.2


