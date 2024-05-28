Return-Path: <linux-kernel+bounces-191843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921F78D1507
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14681B21FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD9873447;
	Tue, 28 May 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="X4sQRpfW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="V+4VRrue"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C78446AF;
	Tue, 28 May 2024 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880320; cv=none; b=sPaZSi4uzkvcssrgvWSVlgSBV3Q/HuSHvPkE9HqkWzHuH04q2qfR0pyG6XRvNBxrrYRTZ3J0+WVzptz9c41h51urE0j2ivSyBVzkQxi2pgjgDdhDiiG6akW4SdLvl7LkYGy/im5W+R+vRU8aBLzS+usxz83YjwRJG4OC5NVvx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880320; c=relaxed/simple;
	bh=3SuIiVs4ex3dKgKjRY4GThiMcpkSuoZTjKwprnKlHC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C57v73uffn0xNrb8rcvWsHtZwOMf0SQCvmGpV70GDZg74rWCKYK2DJmsce41Bqx34OagrOlnVx6NhNfaUkUxZHnrxTWtyYsmIDqt+0rAC+lIR10NImneQCZ9ifCvLEsqeLWkn4/Mz9AS1rCJlMUJ0hEYO5cT+ET71VAAdZeCm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=X4sQRpfW; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=V+4VRrue reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716880318; x=1748416318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dHKIs/KoK2vU5Vx0u2qFk5vGdrktdeEflK3UPvVVUsg=;
  b=X4sQRpfWrNo4Udtx+A6H9xJ9efYypxoOJ38I08V9mKTWLzW8N8he7zLF
   PKRBi4QHSVHUGPizd5oj/lC0BEyQfEF4HtqmX4X3pUJi28dQOR15LyeT/
   Oo1tyKFIIz47VOEBlpmwr480hpH4+rYvgLFspKuY1Fjzoni1YV9vylwES
   EhPlTZB5Ua5PMZQci0EEoPhVDd9D5zDsel8eFHtvc/KlvuLz8Tl89FaAj
   rMcvnroEZc17VWWoeYY0rXYfNT9A1wnEHkUsm6RH31Eb3U694d5mJfeGc
   1ajxrPsAyC68tmg6GZN0UV7+6c2Oo0K6wDvgLGp5FN3JYGQxMGKO2hyMF
   w==;
X-CSE-ConnectionGUID: ZN0Rvt3yQa+vyBonDSWnLQ==
X-CSE-MsgGUID: 6ROlfigfQbmWuUvnB2TSUg==
X-IronPort-AV: E=Sophos;i="6.08,194,1712613600"; 
   d="scan'208";a="37094739"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 May 2024 09:11:55 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F9FA1641FA;
	Tue, 28 May 2024 09:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716880311; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dHKIs/KoK2vU5Vx0u2qFk5vGdrktdeEflK3UPvVVUsg=;
	b=V+4VRrueizZhPW5Uq0k6hT3bRdJ9fFRyKH+Y3dYMGAeCNel8NW6qTT/9a3sTplPsHvaDnT
	jAC27dz5eDXRTr2+BOqfjBE/HdHcaEKwVjD0qTJGvct1aOaP9b9jHoqaWXlHA3iDHN/cHJ
	62iIlA2iSeCy1eMcKd5Ub3srYGMTpcODgUrfQ0jHkCNiidUUBp1Cw9Hb01FIQSs3M4g9RV
	bzDc2C718GXngwkMNSc0hPMCPZL7f9XSZq70eOAPcqTtSzqi0kGOFx//bnm7odr5X6fpM/
	4YoRMmvaAd5jBc2gA6NtBG1ZZSwOVhrEVIty3E9w9M4g65NsE8pHVTo2jp5xNQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: interrupt-controller: fsl,irqsteer: Add imx8mp/imx8qxp support
Date: Tue, 28 May 2024 09:11:40 +0200
Message-Id: <20240528071141.92003-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528071141.92003-1-alexander.stein@ew.tq-group.com>
References: <20240528071141.92003-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Some SoC like i.MX8MP or i.MX8QXP use a power-domain for this IP. Add
SoC-specific compatibles, which also requires a power-domain.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../interrupt-controller/fsl,irqsteer.yaml    | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 20ad4ad82ad64..aae676ba30edc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -14,7 +14,10 @@ properties:
     oneOf:
       - const: fsl,imx-irqsteer
       - items:
-          - const: fsl,imx8m-irqsteer
+          - enum:
+              - fsl,imx8m-irqsteer
+              - fsl,imx8mp-irqsteer
+              - fsl,imx8qxp-irqsteer
           - const: fsl,imx-irqsteer
 
   reg:
@@ -42,6 +45,9 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains:
+    maxItems: 1
+
   interrupt-controller: true
 
   "#interrupt-cells":
@@ -70,6 +76,21 @@ required:
   - fsl,channel
   - fsl,num-irqs
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mp-irqsteer
+              - fsl,imx8qxp-irqsteer
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


