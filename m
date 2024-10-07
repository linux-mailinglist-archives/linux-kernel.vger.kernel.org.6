Return-Path: <linux-kernel+bounces-353035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE499278B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CEB23106
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19E18BBB7;
	Mon,  7 Oct 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="SMbomuSf"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B31537C8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291153; cv=none; b=Lf5rLc/6gDBFaLkaMLqs0PSP279ks50lFO0Hf+FITrFAdJf1RlYwFkZJYNxx5N3ruNoQZW3imxTP6ezG9wRX4VSceF0bid8HAxQSqOwJWxc2ymja5fJlvjzUDlJitEw1Y0BXOP1bNj2geMZhiV2QPr4GFK4IfQWu1vsplJxHHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291153; c=relaxed/simple;
	bh=B9zujzAKvv5sce8cu4Pj2ClVC8Ea3SSfSYNnhTHta+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWqzn33ErmlWFnVWe45xpdjNWNj8wBXHMVW/PH87YAHaB2LEXZOOePHdZPAu8Mhoiao6/uOSMY8luGgiW/BhAMpoWE82Yhd39AE4Cdlh6feg6DsP8u22AYLG8wo64jSVT67Kix83D0gkteFk+I+KnC6iWkb/hIxHSzfJzJhMCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=SMbomuSf; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1728291142; x=1730883142;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B9zujzAKvv5sce8cu4Pj2ClVC8Ea3SSfSYNnhTHta+g=;
	b=SMbomuSfNW7slXUQ/g9mHEfFmJL0ab5CUzVoUcjNnvM/qUROzeqPuQpte5XZiGLx
	SbRKbaKOS2qKbV9RrLFxmsPSkAlgpaIW6xqgVPpnxxVyQNlVJk5gnZc9RLtvVwwv
	GU6nxa+pxHp3jRF9Ya2SOPx5j4koLAgcNs0IUV/XuJE=;
X-AuditID: ac14000a-ecaea24000004e2a-f6-6703a1461352
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 43.A0.20010.641A3076; Mon,  7 Oct 2024 10:52:22 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 7 Oct 2024
 10:52:21 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<bbrezillon@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 1/2] dt-bindings: display: bridge: sil,sii9022: Add bus-width
Date: Mon, 7 Oct 2024 10:52:12 +0200
Message-ID: <20241007085213.2918982-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007085213.2918982-1-w.egorov@phytec.de>
References: <20241007085213.2918982-1-w.egorov@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWyRpKBR9dtIXO6webrohYnri9isri/+DOL
	xeqW6YwWa/aeY7KYf+Qcq8WVr+/ZLJ7PX8docfLNVRaLl7PusVl0TlzCbnF51xw2i4Uft7JY
	tHUuY7V4v/MWo8WkeTdZLf7v2cFuMfvdfnaLLW8mslp0v1N3EPbY+20Bi8fOWXfZPWZ3zGT1
	WLznJZPHplWdbB4nJlxi8rhzbQ+bx7yTgR73u48zefR3t7B6bD5d7fF5k1wATxSXTUpqTmZZ
	apG+XQJXxqXNixkLVvBUvDl/jKWBcTZnFyMnh4SAicTVo49Yuhi5OIQEljBJdDdtZYVwHjFK
	3P/ymhGkik1AXeLOhm+sILaIgJ/ErS/72EGKmAU2MUt8fr0bLCEsECDR2LCdDcRmEVCRmDJt
	JzuIzStgKbHnXRMTxDp5iZmXvoPFOQWsJKbfn8IMYgsB1Xw/u40Jol5Q4uTMJywgNjNQffPW
	2cwQtoTEwRcvoOrlJV5cWs4CM3PaudfMEHaoxJFNq5kmMArNQjJqFpJRs5CMWsDIvIpRKDcz
	OTu1KDNbryCjsiQ1WS8ldRMjKJZFGLh2MPbN8TjEyMTBeIhRgoNZSYQ3Yg1juhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZJg5OqQbGogOmH/3PLtxn//en+KYm
	8fy1K/72iH660jtnx9/1L9Ju3LO3NP+qtHiRjdeRrvtMnfvefDnjHTnhS4nUnrNrf35YlrtF
	KmLP4RWrKzeZ/Ne5NidbpVtI3ul0yIli+6Pr2q13GGX6inTXad+zTOKfmZTEt+/SurkHDy1Z
	3uN6u0LHNentrcNCzUosxRmJhlrMRcWJAPD479HTAgAA

The SI9022 HDMI transmitter can be configured with a bus-width of 16,
18, or 24 bits. Introduce a bus-width property to the input endpoint,
specifying the number of parallel RGB input bits connected to the
transmitter.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2: 
  - Use bus-width instead of data-lines as suggested by Krzysztof
  - Provide a default
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


