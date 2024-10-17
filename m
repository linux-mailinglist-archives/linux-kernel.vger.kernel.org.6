Return-Path: <linux-kernel+bounces-369485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CD59A1DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EDAB24DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ABC1D88C7;
	Thu, 17 Oct 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="Foxwse/q"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC61D88C2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156336; cv=none; b=AGQEAossuUZLlOHeIU1F6qaaSzo8aBbbc4Q3+oV2LsaFTlIOy1wCX/NHaLgYJW1PIl85EpJ9HTIfj+LG5/3Hcc4FCP7tO5kHA6TWJcfkmqzj3kX/RvUMHnnmkgcI9tsS9uVvHYq+sEVu7Yoh5gEsEhITP/+XncwvocProRNS8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156336; c=relaxed/simple;
	bh=7FTIXUBTbKyS5duZobcY1RpkOFb9rEz3FlKeAXNHRxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2QCj+tglMeVMnh+EFFWdNNHyhb9uMuXy38CNMtUewvXgShHp+FSqG4igKnzuC6r4DqdRUo1YO63or7dnvmrx6uvngDELT3T+tNjq8Y7fjbx40tKwQXv+OJ1aYBNg1ft/Ulyo06NxYPpqkQU8vqyZTvCxdGYXniaW6/O1vuZbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=Foxwse/q; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1729155405; x=1731747405;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7FTIXUBTbKyS5duZobcY1RpkOFb9rEz3FlKeAXNHRxY=;
	b=Foxwse/qk5NDWw7eoxIPZhU6F8SJd353ef2SOtmD+vAZKuwHDZmmf1ZF52V3MfcG
	GLj0pUCy3YxfxH+vQ8PBVH0/g3jTRwM5MSIbyrUl6zfkrRGMB2R8k0+0MfydTJEq
	T4R1RYNFNK9bjosWldgStweGNUmy4q8E+A4ApJ1UzZY=;
X-AuditID: ac14000a-ecaea24000004e2a-87-6710d14d63d7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 31.81.20010.D41D0176; Thu, 17 Oct 2024 10:56:45 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 17 Oct
 2024 10:56:44 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<bbrezillon@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v3 1/2] dt-bindings: display: bridge: sil,sii9022: Add bus-width
Date: Thu, 17 Oct 2024 10:55:55 +0200
Message-ID: <20241017085556.3045686-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241017085556.3045686-1-w.egorov@phytec.de>
References: <20241017085556.3045686-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWyRpKBR9f3okC6QctyVosT1xcxWdxf/JnF
	YnXLdEaLNXvPMVnMP3KO1eLK1/dsFs/nr2O0OPnmKovFy1n32Cw6Jy5ht7i8aw6bxcKPW1ks
	2jqXsVq833mL0WLSvJusFv/37GC3mP1uP7vFljcTWS2636k7CHvs/baAxWPnrLvsHrM7ZrJ6
	LN7zkslj06pONo8TEy4xedy5tofNY97JQI/73ceZPPq7W1g9Np+u9vi8SS6AJ4rLJiU1J7Ms
	tUjfLoEr49Gvg4wFm3kqDq/ZzdrAuJGzi5GTQ0LAROLrxd/MXYxcHEICS5gk5v18wArhPGaU
	eHGtiRGkik1AXeLOhm+sILaIgJ/ErS/72EGKmAU2MUt8fr0bLCEsECBx7tVboFEcHCwCqhL7
	vkeBmLwClhLTLwRBLJOXmHnpOzuIzSlgJfHp31VmEFsIqGTDj+NsIDavgKDEyZlPWEBsZqD6
	5q2zmSFsCYmDL15A1ctLvLi0nAVm5rRzr5kh7FCJI5tWM01gFJqFZNQsJKNmIRm1gJF5FaNQ
	bmZydmpRZrZeQUZlSWqyXkrqJkZQHIswcO1g7JvjcYiRiYPxEKMEB7OSCO+kLt50Id6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYxNfMr75U8vOhy49LK/
	tku70D6/7/mOfKdsNu0KUTwrqNaQ+F275/jbPu43SsZN9V9+LXhX3WX8Ycm0qFONin53vh64
	fyGz7JRwg+ap5Y13Lmet8RGzCfj1IkdYmNPA4kHAOv0/p3d+DAlkVV5T63PKr+hC80r9/WGT
	H2vqzpqxQjrxUPLuNwuUWIozEg21mIuKEwFC3R1V0QIAAA==

The SI9022 HDMI transmitter can be configured with a bus-width of 16,
18, or 24 bits. Introduce a bus-width property to the input endpoint,
specifying the number of parallel RGB input bits connected to the
transmitter.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3: Add Reviewed-by tag from Krzysztof
---
 .../bindings/display/bridge/sil,sii9022.yaml      | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
index 5a69547ad3d7..1509c4535e53 100644
--- a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
@@ -81,9 +81,22 @@ properties:
 
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        $ref: /schemas/graph.yaml#/$defs/port-base
         description: Parallel RGB input port
 
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              bus-width:
+                description:
+                  Endpoint bus width.
+                enum: [ 16, 18, 24 ]
+                default: 24
+
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description: HDMI output port
-- 
2.34.1


