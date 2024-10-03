Return-Path: <linux-kernel+bounces-348753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37CE98EB74
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C38B285E57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F0145FE4;
	Thu,  3 Oct 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="gYT1MbKu"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAC137923
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943621; cv=none; b=cpC8IOw8o4C4es6Uy8B/gkgV6Tj+jMLWiEcm9Bq8A00L7wIkR0ZlKjFOBAbTiujv2tvKq4ltHO9dBBiyE7GDu5H1P/voGRPUoYIZz8j9IgIXfNpqT73lt3kY5jZBuEIUxrUidmSnqd37vKRpakhpM+A0t/+m6SEuHv7d5kjc/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943621; c=relaxed/simple;
	bh=CZS1DqAcLXOylqarIwLjyRPvbIyThJtJvm66m95KT0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWwtveGrKYSNbJJ9lCj5iKlLfwQw4RPDImQhkTmunCIj5QWqRgxrHDMBRmmW9wwugt7Vbs9tbi2aNivHLyyei/5eFYCPFkAZ4kXi3BSGVzp+8MMHqez7uh3i9XwK5OvcE45BQ8Sn8t1qBIt6zsWO/marnkEFYd8VaKxCZrZNSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=gYT1MbKu; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727943616; x=1730535616;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CZS1DqAcLXOylqarIwLjyRPvbIyThJtJvm66m95KT0M=;
	b=gYT1MbKuLOga+5NwnKc2gtoOTJZLOg7LQZWc3jlYIgsdseaibSb/6xZ4NLTD0Osi
	Tq7SQKqVJ9A3LoGFjQtLOl3wiuPPEo8kskuhg1AXe4Ktu2/L3ehn5LXHyeIxc6M9
	cTZUd8lL3uZaUosPt8EMvXEj/F7dlcelU0mti1KWeUQ=;
X-AuditID: ac14000a-4637f70000004e2a-a0-66fe53c07c40
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 0F.F4.20010.0C35EF66; Thu,  3 Oct 2024 10:20:16 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 3 Oct 2024
 10:20:15 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<bbrezillon@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 2/2] dt-bindings: display: bridge: sil,sii9022: Add data-lines
Date: Thu, 3 Oct 2024 10:20:06 +0200
Message-ID: <20241003082006.2728617-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003082006.2728617-1-w.egorov@phytec.de>
References: <20241003082006.2728617-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWyRpKBR/dA8L80g5ZD3BYnri9isri/+DOL
	xeqW6YwWa/aeY7KYf+Qcq8WVr+/ZLJ7PX8docfLNVRaLl7PusVl0TlzCbnF51xw2i4Uft7JY
	tHUuY7V4v/MWo8WkeTdZLf7v2cFuMfvdfnaLLW8mslp0v1N3EPbY+20Bi8fOWXfZPWZ3zGT1
	WLznJZPHplWdbB4nJlxi8rhzbQ+bx7yTgR73u48zefR3t7B6bD5d7fF5k1wATxSXTUpqTmZZ
	apG+XQJXxoO9nawFa7grni2awdzAeJeji5GTQ0LAROLrxn72LkYuDiGBJUwS7yc9Z4FwHjFK
	LJx9nh2kik1AXeLOhm+sILaIgJ/ErS/7wDqYBTYxS3x+vRssIQyUmLfwJBOIzSKgIvGo5S4b
	iM0rYClxp6mFDWKdvMTMS9/BhnIKWElsefEQaBsH0DZLiS1HCiDKBSVOznzCAmIzA5U3b53N
	DGFLSBx88QLMFgKKv7i0nAVm5LRzr5kh7FCJrV+2M01gFJqFZNQsJKNmIRm1gJF5FaNQbmZy
	dmpRZrZeQUZlSWqyXkrqJkZQJIswcO1g7JvjcYiRiYPxEKMEB7OSCO+87X/ThHhTEiurUovy
	44tKc1KLDzFKc7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTBOYorqylf56SFz9X2DorTA
	gYeXm4wixfau3DD1Ms9OzsfJj9L7XAy+JiXtPaAhyH/P01vhFuMW68/KoQu6ryUeef177+aa
	e6uzisrU3n1c5C5+rGHz6uZjDSxy65+UdWn/Wpj9ZN1p3Yg3S/49dq/OeH2561uGxUaxi7MC
	dP5+uBAZISa90u2gEktxRqKhFnNRcSIAdGjyYdICAAA=

The SI9022 HDMI transmitter can be configured with 16, 18, or 24 input
data lines. This commit introduces the data-lines property to the input
endpoint, specifying the number of parallel RGB input pins connected
to the transmitter.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../bindings/display/bridge/sil,sii9022.yaml        | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
index 5a69547ad3d7..24306f8eb107 100644
--- a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
@@ -81,9 +81,20 @@ properties:
 
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
+              data-lines:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                enum: [ 16, 18, 24 ]
+
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description: HDMI output port
-- 
2.34.1


