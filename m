Return-Path: <linux-kernel+bounces-228316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D6915E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD11C22442
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511D144D35;
	Tue, 25 Jun 2024 05:14:32 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAF143C77;
	Tue, 25 Jun 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292471; cv=none; b=bUSuNszonsD7+830WuKqxljBng9NjyBY1FT/5xNqYuEvmj5PLD3QNjOBwBHbowhEhTAEZ7P6bQD+GbvUH5ZU17LPVshKUnoXG3E9xeGZBvAydmO8kKbBP/cGt8r3C0GflfpV2kmd1fu2ur6mr6VyuDH5HEgP+o5Twjx55qPXGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292471; c=relaxed/simple;
	bh=r1yUKOqJ3m3RgFQKXy+x0TEjISedETflcnkkUpwtfNg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=SJhWlgy4glmOaaRjwvdffZjmBW7svWY13igWzd6+Rh5iTP6uNg3ZXtQzS/G/YpeJwIx8FoODx/6v/o1qDfyhsmoWzB3UwURLVTXtVh1EmcHZR3fMvvlDW3f19OLujLKY6QlOkH/DlNvUNsTgwexarJG11lyhJoYe7wCung1aBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A359D1A04EF;
	Tue, 25 Jun 2024 07:14:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 598FB1A0385;
	Tue, 25 Jun 2024 07:14:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 49696180226C;
	Tue, 25 Jun 2024 13:14:20 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
Date: Tue, 25 Jun 2024 12:56:53 +0800
Message-Id: <1719291415-1168-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
References: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On i.MX8MP, there are 3 interrupts, the third interrupt is
SPDIF wakeup interrupt from PHY

Add ref: dai-common.yaml for #sound-dai-cells is needed and
XCVR is a DAI device.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
index 197ae8ba9c30..7470866e11c6 100644
--- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
@@ -42,6 +42,7 @@ properties:
     items:
       - description: WAKEUPMIX Audio XCVR Interrupt 1
       - description: WAKEUPMIX Audio XCVR Interrupt 2
+      - description: SPDIF wakeup interrupt from PHY
     minItems: 1
 
   clocks:
@@ -88,6 +89,7 @@ required:
   - dma-names
 
 allOf:
+  - $ref: dai-common.yaml#
   - if:
       properties:
         compatible:
@@ -112,7 +114,7 @@ allOf:
     else:
       properties:
         interrupts:
-          maxItems: 1
+          maxItems: 3
 
   - if:
       properties:
@@ -128,7 +130,7 @@ allOf:
         clock-names:
           maxItems: 4
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


