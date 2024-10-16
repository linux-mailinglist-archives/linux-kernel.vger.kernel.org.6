Return-Path: <linux-kernel+bounces-367469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C89A02BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CA71C24830
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3891C7B7C;
	Wed, 16 Oct 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac2QBb/T"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921D1C1724;
	Wed, 16 Oct 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064253; cv=none; b=c7Xjrzdla1AE77KAoqGFuSEImg168Yc78WK61CuaB+OHnUqAHUZJwB0PGC/5JMh9gf/E1FasKECc3ZHJbq+Y/T88H4oW/DMsG1mjMOSEBUW0FHqRO6S9JcK25GTixhKjYZAWmfcaWLB2ii6o1yImOFYLW/Zig7xxNN9/owgGaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064253; c=relaxed/simple;
	bh=veSUSFt4yvO5kIJ5gTqF85mcYrDti/OnhaxqHb/EqLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jD57CN1SrVgOi4pqOr6E5gWNxZ51kuLBgxhhM+TGyxuaiLqB96JSbl/bsYr01m4MZC6RWjaCIA8IhXjCbXyeSZc8yOi3DJ2j+gbWgpu2a8+RTg9hii/h/a4gkdU3dUtzUm7ffrgWxj+m34uXDasKUjvce4prYe7zCt8OlYbGph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac2QBb/T; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so1211780a91.0;
        Wed, 16 Oct 2024 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729064251; x=1729669051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWSEFSMMBQYiRpWJwnlSGcr6/Rh83dU+uSxZqVGEbSU=;
        b=Ac2QBb/TKg96jTRQiBNj6brd2dKn4yBXblj9P4SilcHrWQcvueNtXUDIW8OSuxwDiU
         Rn4JPCBUAeNO/U96lJqK3WFeqIEDKpxO4S42La3fYD/Q/tD+5GS07gpnJomOkQx8G/XS
         v107+h6bQc1qu2FyB0RDDnLW3fCoD8uz+u1AuJ/J/PLRWBDoa5a4eklnj6zdrYCo8DAz
         9XwGhPsW3+KttF+0W57v564MU+TzScYOq7ZnskIYoemDC1vRQ0SfTqEBLXQhen/ss+60
         2ZxRCZrGtbNSSXB8uCMNHv1rj19/44BGYEyWPmYf+8gvLkWykDpwS9KfM6+pZpatfLMa
         Uasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064251; x=1729669051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWSEFSMMBQYiRpWJwnlSGcr6/Rh83dU+uSxZqVGEbSU=;
        b=CEUxnVxZU+7vdWejbW21VDvFaIJE0oVaigdNKbRtygh+OWtOzoEix+NIA2npfFEjAk
         JfeEhUN30mM6WJEloeVX5heIGEP3nRDmhskNbNyk2pHnZBuc9XaXISSqTnpXYZbmQguK
         dVzBbe21LGMgrmd0iPd3ds1olfJnRzE+Rb+SM0sndKvjWn7Gq5QbaEi52KWIWR28l3z/
         6gCB9JTXUrSH0c4m+zwh0pIVPcHsPMx/BG+kFxOmz3sVeGCy+IWg8AVomJrWBmsUb0Gy
         II4/Kmu+lfUKt7HH6ZZODqwEMiz3pYCdeekHdu2mHgkt72ObruziEMLmkkLGXL+axtv8
         DBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqNni/8PY4S/iOAjV0p7yCuEJbrzpu/0PsQwQeHR4cEU7lz8cbvSQj97cpg/z++V+P7+E8K9/kZxh05hrG@vger.kernel.org, AJvYcCXVoJijYEsjLEDz6ufM1fRmS40vzcQN/I2aJncQyfwKN0J2ZKWKHqmR7SSKC6f9Y0qEFpv9/P3Unrr/@vger.kernel.org
X-Gm-Message-State: AOJu0YxDy+8lSsMr2D77lMPt07Fo040FQfL6xLqcWWnzhN7gwdCHHqyk
	AO+pF6oCJ/2Fg20M9tL/GuwFUB3Me/X8tZaGQ+xPahGnBnq+QFPXifu6dA==
X-Google-Smtp-Source: AGHT+IG+duC4aYKYaW4Rt7FIJuOoR2u1R7C7pf1VvmTfz6iWzqjOEFF3pQSPiFSy/hZ/ZE2cJCCmoQ==
X-Received: by 2002:a17:90a:d98a:b0:2e2:abab:c458 with SMTP id 98e67ed59e1d1-2e2f0dd1cb0mr8956565a91.8.1729064250913;
        Wed, 16 Oct 2024 00:37:30 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3b7e6339fsm765471a91.1.2024.10.16.00.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:37:30 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 3/4] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Wed, 16 Oct 2024 15:37:12 +0800
Message-Id: <20241016073713.14133-3-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016073713.14133-1-frawang.cn@gmail.com>
References: <20241016073713.14133-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Add compatible for the USB2 phy in the Rockchip RK3576 SoC.

This change also refactor the clocks list as there are new clocks
adding used for the USB MMU in RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changelog:
v6:
 - add Reviewed tag.

v5:
 - move the clock-names item list to top-level property.
 - only defined minItems/maxItems in each if: then block.

v4:
 - refactor the clocks list used if:then:

v3:
 - narrowed rk3576 clocks by compatible property.

v2:
 - Categorize clock names by oneOf keyword.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/

 .../bindings/phy/rockchip,inno-usb2phy.yaml   | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 5254413137c64..6a7ef556414ce 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3576-usb2phy
       - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
 
@@ -34,10 +35,15 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   clock-names:
-    const: phyclk
+    minItems: 1
+    items:
+      - const: phyclk
+      - const: aclk
+      - const: aclk_slv
 
   assigned-clocks:
     description:
@@ -172,6 +178,41 @@ allOf:
             - interrupts
             - interrupt-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-usb2phy
+              - rockchip,rk3128-usb2phy
+              - rockchip,rk3228-usb2phy
+              - rockchip,rk3308-usb2phy
+              - rockchip,rk3328-usb2phy
+              - rockchip,rk3366-usb2phy
+              - rockchip,rk3399-usb2phy
+              - rockchip,rk3568-usb2phy
+              - rockchip,rk3588-usb2phy
+              - rockchip,rv1108-usb2phy
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-usb2phy
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


