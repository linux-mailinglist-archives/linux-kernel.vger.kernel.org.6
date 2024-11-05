Return-Path: <linux-kernel+bounces-395916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268F19BC4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588201C2141C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D421FE0F5;
	Tue,  5 Nov 2024 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inu1AGK+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA771FE0E0;
	Tue,  5 Nov 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786045; cv=none; b=VsfDk+jfI4h6vBpZBSCejPGEaW8gpZA6GaDQdiBELiPsIBeWPi0KAXPUOhx3+ms4fqSdnn+vCA6qlKXkE9tL+u+wJxtb8OR2wqOMurwNGA+41Kl7CMKdgNlDQqGs9muBAivgjEePLjVKCnpzOHr5MgtyQmFRCCpSW1j3zjfZta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786045; c=relaxed/simple;
	bh=LYoCzm5U9uO6BZ8Fv2yXUPun41hyujCLPW2JBHBFNJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5/RvqkLz1N/xkAN7i91jbFNWPiAvWvJ4T7GR4ZBCrYkS8SZbywTaUWFzx9cNAXUZV5ugR9nDwwPxlW036dq9h0Ss4GTYXATDvM5CmQEt9BHejYlKRQYBsi5tF/u8mKTUaAqO8pYe5I+gxD7hfNRmM7J+6VV3OJZIXLQYNXsL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inu1AGK+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso2632974a12.1;
        Mon, 04 Nov 2024 21:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786043; x=1731390843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVpANjYVnSdNgI8t8ZHWxaEPt2RisjdkbcnHwj4iqRU=;
        b=inu1AGK+91bfttT+zl/v+IYbQCFQANqlQ97Lq5lxprdoZ87HVDXMATEkFwOYc+Stpo
         5cSU0F7tsjeOb73BJA62rDukG9CAoh9YJev4iGZUct15/+kyWQ940mgWPXpz9L39Y87x
         oBI+UbZ5Rl/dJC6MsqOzChK2ZLg9YK85Er1rTcN+w+OdXTS7WhAZx6rLKNSPhn/vxo0Z
         bCCsDdhqT3PbqQcwoK4hT0a8vjZOjz2XIKZ3QR9JI23PzRsBkXUdzhAU2HcR7+N8PR+z
         im/YPRfybgXJSj09OT8ThZlzNmc8ecEhV60j63lREmNNBrHNUfh9H4ZPrJzfyajztgyK
         Cx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786043; x=1731390843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVpANjYVnSdNgI8t8ZHWxaEPt2RisjdkbcnHwj4iqRU=;
        b=W2GRteOYx160BDGoeQUcvRqHnpl4o3GPmQwIBVBliR+zQvleT8gll5IsJ/LRyjvLvD
         KWS9kLOO2xuFdHW53D/YcZrqf0n0C42j1P1rBY/Qa3CU4mou1lpLShHsNNohjHXXKM9v
         6j77JVzQ8ljF2QXSBlvbJY+/gGDMwUREFTowjy0FHck1Pbscd1/PLJPtd/Em9gLu1kj1
         AqD0ychzgdee1FWHPOxlTF1x2w4oZnO7Vh9mEN+mdGYP7Cyxgw5NB+Oyc3zR3zA38vxW
         VQlSMsHLLWr1q4qNbnzLayT0IQSBAxYrcRlvV2K3zaQOA4SCIxJ5ctNjTGsVC/LNrVsi
         E98Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJEY5d/CUQIalcNtjQi5cyseq0dkGQ+zHCG5NQXaHTZfCt9tVHvRrXy1GNXrQuu2ov1MKmiEPes6y1@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFZidJ/aTp/onLC/BsdknVRKBygEWhAbPRL6FfyvYqWXwtDxB
	RPW+q/XSaFnjF9g0XSCK+ccNwRL5om1mv2p9nAUtc83c2lU448IbMJWjHwUP
X-Google-Smtp-Source: AGHT+IGlkn1erL5hAYmFs9VsSoSvV0kmc2vM4CscfaA71QZ6w2n5YnE0MGNy6DaE1gWYMRXpRMFvvw==
X-Received: by 2002:a17:90b:5249:b0:2e2:cd2f:b919 with SMTP id 98e67ed59e1d1-2e93c1e4763mr24635881a91.28.1730786043077;
        Mon, 04 Nov 2024 21:54:03 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:54:02 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: display: panel: Rename rg35xx-plus-panel back to WL-355608-A8
Date: Tue,  5 Nov 2024 14:52:29 +0900
Message-ID: <20241105055239.1577275-2-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105055239.1577275-1-kikuchan98@gmail.com>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panel assembly is changed in the recent revision of Anbernic RG35XX
Plus, so the `anbernic,rg35xx-plus-panel` identifier is neither suitable
nor unique for the panel anymore.

Fortunately, the panel can be distinguished by a label printed on the
FPC cable, so use the label "WL-355608-A8" as an identifier instead.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 ...rg35xx-plus-panel.yaml => anbernic,wl-355608-a8.yaml} | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{anbernic,rg35xx-plus-panel.yaml => anbernic,wl-355608-a8.yaml} (83%)

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-panel.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,wl-355608-a8.yaml
similarity index 83%
rename from Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-panel.yaml
rename to Documentation/devicetree/bindings/display/panel/anbernic,wl-355608-a8.yaml
index 1d67492ebd3..5e8afbea690 100644
--- a/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-panel.yaml
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,wl-355608-a8.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/display/panel/anbernic,rg35xx-plus-panel.yaml#
+$id: http://devicetree.org/schemas/display/panel/anbernic,wl-355608-a8.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Anbernic RG35XX series (WL-355608-A8) 3.5" 640x480 24-bit IPS LCD panel
@@ -16,13 +16,14 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: anbernic,rg35xx-plus-panel
+      - const: anbernic,wl-355608-a8
       - items:
           - enum:
               - anbernic,rg35xx-2024-panel
               - anbernic,rg35xx-h-panel
               - anbernic,rg35xx-sp-panel
-          - const: anbernic,rg35xx-plus-panel
+              - anbernic,rg35xx-plus-panel
+          - const: anbernic,wl-355608-a8
 
   reg:
     maxItems: 1
@@ -47,7 +48,7 @@ examples:
         #size-cells = <0>;
 
         panel@0 {
-            compatible = "anbernic,rg35xx-plus-panel";
+            compatible = "anbernic,wl-355608-a8";
             reg = <0>;
 
             spi-3wire;
-- 
2.47.0


