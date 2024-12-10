Return-Path: <linux-kernel+bounces-439165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173879EABD0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9002289563
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1223279C;
	Tue, 10 Dec 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="pba+gmG0"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0A231CBE;
	Tue, 10 Dec 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822474; cv=none; b=JPgjJcUIjV+5V5cmOETFg5bF7JuAownIhzvSCNEX94t4ZhDOmwcN1niBc4geUL+lrj5Lru7faYg2H3GWQqjmAlXthTq6j57Y8PAMMvzQnLv2UcntTIwCXhLZ9s9Mz4CLrmB53wQoD2kHeVvUgUJV44eUDfnvzv87xIaJM4WKaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822474; c=relaxed/simple;
	bh=fOev1Y8BKB0FulfbIogwUx6WfrGatBVUBVtvVDp+04s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5/SZKO5G8cTHmSUf9P5KoAayHG9rzmg78EptQ3a/xOKoMzbOiAhOS2G4Chusw8JVJR4kBtKRa35lnn6TPqvt3zU9I2a5y9k1t0cKEXxkviyWp6deQxwqIm1BC14rLtzEjxXceheqccfKfuJ+2vptyKV/lHQY3655a9UlL/xWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=pba+gmG0; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Lj/s8jikWSL6aISEsHq6B0p2FlUzsQ0RtdLirGZ/Elo=; b=pba+gmG0oSVE71SGtAPQVYGW+U
	tEtJfiI4ohYZuiPQLohtM+YwE+5m4msuBKYuJynxGMh0Z+CYe8eBT5+0RmEMbVxsjPMKGVvdc4tTt
	CGLxBpCww9qwjNEppj10LZzLVBQrI10asnCmtgBGaodPmRCVWbIZiP9u1O9iM4doebC75fVp/ato3
	Jt38YXpUCx4QaMiP1nuvYexgb6tAQGMNWat1aCUJCAai5/UpB59sbSM10++aF92nGewJjM3/biqyV
	b7FrKXsmtmkyjsNjW8aRgctbrn/pFTiRDCopgyj/vvO5X2fPj/q340pUzwj0Imvc0kBP4Iq/HYI56
	AtngMHnw==;
Received: from [89.212.21.243] (port=59230 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tKwQT-001jvW-29;
	Tue, 10 Dec 2024 10:21:05 +0100
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
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH v5 1/3] dt-bindings: drm/bridge: ti-sn65dsi83: Add properties for ti,lvds-vod-swing
Date: Tue, 10 Dec 2024 10:18:59 +0100
Message-Id: <20241210091901.83028-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210091901.83028-1-andrej.picej@norik.com>
References: <20241210091901.83028-1-andrej.picej@norik.com>
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

Add properties which can be used to specify LVDS differential output
voltage. Since this also depends on near-end signal termination also
include property which sets this. LVDS differential output voltage is
specified with an array (min, max), which should match the one from
connected device.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v5:
- added Krzysztof's reviewed-by tag
Changes in v4:
- removed "additionalProperties: true" from the patch as it is not needed
Changes in v3:
- no change
Changes in v2:
- move LVDS port schema to a $defs and reference it from there
- properties are now defined in microvolts/ohms
- use 1 property for data-lane and 1 for clock-lane LVDS voltage swing
- add 1 property which sets LVDS near-end termination
- since major change was done change the authorship to myself
---
 .../bindings/display/bridge/ti,sn65dsi83.yaml | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index 48a97bb3e2e0..bad6f5c81b06 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -80,12 +80,12 @@ properties:
                   - const: 4
 
       port@2:
-        $ref: /schemas/graph.yaml#/properties/port
         description: Video port for LVDS Channel-A output (panel or bridge).
+        $ref: '#/$defs/lvds-port'
 
       port@3:
-        $ref: /schemas/graph.yaml#/properties/port
         description: Video port for LVDS Channel-B output (panel or bridge).
+        $ref: '#/$defs/lvds-port'
 
     required:
       - port@0
@@ -96,6 +96,36 @@ required:
   - reg
   - ports
 
+$defs:
+  lvds-port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          ti,lvds-termination-ohms:
+            description: The value of near end differential termination in ohms.
+            enum: [100, 200]
+            default: 200
+
+          ti,lvds-vod-swing-clock-microvolt:
+            description: LVDS diferential output voltage <min max> for clock
+              lanes in microvolts.
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+
+          ti,lvds-vod-swing-data-microvolt:
+            description: LVDS diferential output voltage <min max> for data
+              lanes in microvolts.
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+
 allOf:
   - if:
       properties:
-- 
2.34.1


