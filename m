Return-Path: <linux-kernel+bounces-423321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E139DA5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D792162DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432FB1991B2;
	Wed, 27 Nov 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="FIyOGmrP"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775261990AE;
	Wed, 27 Nov 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703472; cv=none; b=iE04cjvaBTM6GozV345pdvYQwQJ4cpbf7Y7n3gYgw3wWI6hS/+ADNvYgKoh1ZevYBGyWDoa1QSfNWdQG3Pz5a8opO7pv1eRO3eJcNBS7CrO3Mb3rEmnvMXJo5IXkX4cHWdYo+jQI1lvBLYHLpWkKKS0cyPeLkHxa/nNBIN1l+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703472; c=relaxed/simple;
	bh=LLoCLzPuLPuJxUAIwTRmXys0t2+M+r6M9pb8rRopLu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eguUTB4HXjdzSWQ6EvqhURxpBoS4TdzVIQzt2OgpalsMsrUEH8BKliM7x3iK12UoRIeRItLSloqtfuEY7h8/jz1GcGfcvKMAXECYF/01cpujCdIaISmxqQY875emw0cDEJDQxmt+W19uS1UxuWJiMK4vvuHnqZcdCbwPyxh+QlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=FIyOGmrP; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YDXSwxdQFKqF1c/3avYtLd4G9gMBk0YXaL0G1r3dLXc=; b=FIyOGmrPJwNmk5+OJm7laIa2/Z
	ir0dwoYtdw7FyovDD18pnqGkgveT4ngssKEaznw/AGRyt+LREHf0z5UBb1V+3EsyHAN2juTv4u/xu
	uu0MecOyXO1CFWjKrMQ9hei7Rb25PtLZ0ApM/wJ0umLEL62wjYp0/RyCuGLQIOj8t1Fe8/oWMnU2k
	8g67j2E8ybW8KjwylpZZSfPjfo+XrFdN4BudENEusn255TSLZ2mU4ASs4/jypJeMDENSWRvtcQS4t
	I82wv6s+TrMVO1vfLInB8TaGgZ9BCTZ4zCPomzcN/4nBikuz/XMmvYXu6+w79bZFqmOxilm/RsGVw
	7hsrZklA==;
Received: from [89.212.21.243] (port=49750 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tGFK3-007Rx6-2G;
	Wed, 27 Nov 2024 11:31:03 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: drm/bridge: ti-sn65dsi83: Add optional property ti,lvds-vcom
Date: Wed, 27 Nov 2024 11:30:29 +0100
Message-Id: <20241127103031.1007893-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127103031.1007893-1-andrej.picej@norik.com>
References: <20241127103031.1007893-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Janine Hagemann <j.hagemann@phytec.de>

Add an optional property to change LVDS output voltage. This depends on
the connected display specifications. With this property we directly set
the LVDS_VCOM (0x19) register.
Better register property mapping would be quite tricky. Please check
bridge's datasheet for details on how register values set the LVDS
data lines and LVDS clock output voltage.

Signed-off-by: Janine Hagemann <j.hagemann@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 .../bindings/display/bridge/ti,sn65dsi83.yaml      | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index 48a97bb3e2e0..5b2c0c281824 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -58,6 +58,12 @@ properties:
                   - const: 2
                   - const: 3
                   - const: 4
+              ti,lvds-vcom:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                description: LVDS output voltage configuration. This defines
+                  LVDS_VCOM (0x19) register value. Check bridge's datasheet for
+                  details on how register values set the LVDS data lines and
+                  LVDS clock output voltage.
 
       port@1:
         $ref: /schemas/graph.yaml#/$defs/port-base
@@ -78,6 +84,12 @@ properties:
                   - const: 2
                   - const: 3
                   - const: 4
+              ti,lvds-vcom:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                description: LVDS output voltage configuration. This defines
+                  LVDS_VCOM (0x19) register value. Check bridge's datasheet for
+                  details on how register values set the LVDS data lines and
+                  LVDS clock output voltage.
 
       port@2:
         $ref: /schemas/graph.yaml#/properties/port
@@ -120,7 +132,7 @@ allOf:
           properties:
             port@1: false
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
-- 
2.34.1


