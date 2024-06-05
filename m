Return-Path: <linux-kernel+bounces-202226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD28FC986
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7451C23A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D119306B;
	Wed,  5 Jun 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IysyEhz7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67557192B67
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585027; cv=none; b=u4OzjDdeF+ZS87+M9e9c+H3TPMCRpOlvZwYXn4Gi2EZAXkFguuQnlz6vyfGYXH3HwgVFE5FLerbHKtXV8w7tg4Y0DtoN1ib4IIn1Ez8ZFkoCzht7gydEdbcrM+ZcXX9kM7PQ9mdjMiuslyeyE4qk+MuRoAStx7zYs9iuoiHk5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585027; c=relaxed/simple;
	bh=9tQ/hGgrkJZB1S9WoG+UsA5FM2H+BHL7GGjXI+1Ppxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEskhSC+/pRNxZYglxtpZax+vk1nl9fJFYW4R7bs9ouboKQeu3xGEL4lHaqsaVxob+JMXGZMYXSl7Q5Z7AT79W4sRFF9lb5EkBuqozaftZ9FnHqngmAhUV9MKGaeKzJTKmZtL+2CfQXiwINwUrpgi+ss8AhqdZWJjrQ63DhOD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IysyEhz7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so20460915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717585024; x=1718189824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h23rJhkzcdNUIkugpoAcaZsXI84pnHqCrii/WaDJ/bw=;
        b=IysyEhz7Ehc7cC1S6B7awofqaWZdlsmC7HJ6jogRmhgHdpFJUcR6/SS/JN/hx3dSu4
         wy/LfveccdXstM1HSYbY39F03YtbHjAl7qLtBuTYja7wMCSWtOzjMg5awfOBPDZDLHO0
         iuyoWfgF+YtgivjZbCD763eO3Wd3AzE4JlM23vnEl1WUXVmQZisPKQer1aS2Q9nUJYLj
         Bxm8rVnQtFVYkAq9ovXvAXNmgoFAYt7RCr8RVMw/Yme+S/+poquFJYUpVh3VhAJ8U3hj
         HexqbIhEVRuZ2bumrQjSzUmuKRrpyEkMSBwfqg3OqxhG8DC0AuyNn5NChoZL3pVMbrXV
         XTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717585024; x=1718189824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h23rJhkzcdNUIkugpoAcaZsXI84pnHqCrii/WaDJ/bw=;
        b=thIxZNLsB9Iv4md2t3O/U88+ujLRcTKdDQ5uUUVSP+Vy/ICYQE3c0jK5czw3FCD1dH
         gqZkmG8qYVDn2ymYRdTpDCMxrIyfuJXcK9lRclwU5z5BVUl9Q9iQV7vHlkGdfKEXbYMX
         Q4JlnpbL8OY3+TZBC0l+nFpFfa+MbEzjtqZhqUq5hJrjzdz8QKT1RETo0jxLgR1+Ze1y
         tCgYZfCuRQhGVW5+w2aKbVcEs7vLg/5sAkCyrBzqbZA/SvaOgSLUpbUY+frIh9A45uFC
         SjQh6/TKedKg7FqZIePl9hE+pWopooHLp6P1X1/d+UF7kha/obBRtj42+w2t/OUQIPLy
         B1fw==
X-Forwarded-Encrypted: i=1; AJvYcCUUPwaZVadxE2T2O3lsnjzazeurGPwet3BFde5yFIYuYlh0p6gKnx6LPWTkwlHbRu2FOX8ujltG/myLbXIfGhmu6BjUb6GJ9qVI0L2p
X-Gm-Message-State: AOJu0Ywvh37lSJQk7j5LmaG+sHNWYUC9VbZIeuE612VMypBVu7vv0eYx
	Rsvk98hv+k0v/LSk5WA1m2d8EE+x4GdD5I0DFPIAlQ//Z5ntaACo7OI3vBn7oN8=
X-Google-Smtp-Source: AGHT+IFGPo/96hccbojOu1aKs4N1JEV7FxLvULnYmJBPJcHF19qcyQLnJ1sfkfuMEPY2OxD9IK1ZTg==
X-Received: by 2002:a05:600c:4fd3:b0:41b:855b:5d26 with SMTP id 5b1f17b1804b1-421562c2773mr17454165e9.2.1717585023717;
        Wed, 05 Jun 2024 03:57:03 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581016e0sm17653855e9.9.2024.06.05.03.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:57:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wronek <david@mainlining.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: panel: constrain 'reg' in DSI panels (part two)
Date: Wed,  5 Jun 2024 12:56:59 +0200
Message-ID: <20240605105659.27433-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSI-attached devices could respond to more than one virtual channel
number, thus their bindings are supposed to constrain the 'reg' property
to match hardware.  Add missing 'reg' constrain for DSI-attached display
panels, based on DTS sources in Linux kernel (assume all devices take
only one channel number).

Few bindings missed previous fixup: LG SW43408 and Raydium RM69380.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This should apply on any tree.
---
 .../devicetree/bindings/display/panel/lg,sw43408.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/raydium,rm69380.yaml   | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
index 1e08648f5bc7..bbaaa783d184 100644
--- a/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
@@ -21,7 +21,9 @@ properties:
     items:
       - const: lg,sw43408
 
-  reg: true
+  reg:
+    maxItems: 1
+
   port: true
   vddi-supply: true
   vpnl-supply: true
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
index b17765b2b351..ec445ff5631c 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
@@ -28,6 +28,9 @@ properties:
       to work with the indicated panel. The raydium,rm69380 compatible shall
       always be provided as a fallback.
 
+  reg:
+    maxItems: 1
+
   avdd-supply:
     description: Analog voltage rail
 
@@ -38,8 +41,6 @@ properties:
     maxItems: 1
     description: phandle of gpio for reset line - This should be active low
 
-  reg: true
-
 required:
   - compatible
   - reg
-- 
2.43.0


