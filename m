Return-Path: <linux-kernel+bounces-174086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018C8C0A12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AEB1F2328A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9841487D4;
	Thu,  9 May 2024 03:18:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF41482F6;
	Thu,  9 May 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224724; cv=none; b=OgXIuC1cz8Ag6r5mainb69zyt/5zVQjJ8/Rt8OkcIt+4x/ZPAIjpbZhkUHkfqBm5jmtU0gkt7jN0kRLbnRFSjqxogJpDU+96T7+B4iUi5g+AcHKPO9WdOX35DS/80clLrbltmElxMyjl3W5FfGK7oThDE4TJSo4g+Si2iF3rYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224724; c=relaxed/simple;
	bh=qdWhQuPiR2R3ELWu+ak0dDzsK1A/aeOJ72l2vo5xF88=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=vBKyc2yzCk2mzakwWa2Q51TJb/6bZzm6mEFc0SwxKK4oyHGnvTTdJkpizv9ZXKezN1NIVdaMCGYx4OJNxMVtGwfFa9xnOP3lGm5sq3diQrqng+3W5kdHW47vk4q7yyXY5Sw01r8m0N7F2FiSXEXHiJZCgGuzZYEWXsnM+8KpnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FF3F200845;
	Thu,  9 May 2024 05:18:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D8AC42007D5;
	Thu,  9 May 2024 05:18:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B5AC3180222F;
	Thu,  9 May 2024 11:18:38 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] ASoC: dt-bindings: fsl,xcvr: Add two PLL clock sources
Date: Thu,  9 May 2024 10:57:38 +0800
Message-Id: <1715223460-32662-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add two PLL clock sources, they are the parent clocks of the root clock
one is for 8kHz series rates, named as 'pll8k', another one is for
11kHz series rates, named as 'pll11k'. They are optional clocks,
if there are such clocks, then the driver can switch between them to
support more accurate sample rates.

As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
clocks and clock-names properties.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
index 1c74a32def09..c4660faed404 100644
--- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
@@ -50,6 +50,9 @@ properties:
       - description: PHY clock
       - description: SPBA clock
       - description: PLL clock
+      - description: PLL clock source for 8kHz series
+      - description: PLL clock source for 11kHz series
+    minItems: 4
 
   clock-names:
     items:
@@ -57,6 +60,9 @@ properties:
       - const: phy
       - const: spba
       - const: pll_ipg
+      - const: pll8k
+      - const: pll11k
+    minItems: 4
 
   dmas:
     items:
-- 
2.34.1


