Return-Path: <linux-kernel+bounces-360607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A599999D26
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C8C1F25005
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F920ADC1;
	Fri, 11 Oct 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP1M3YRx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DB209F56;
	Fri, 11 Oct 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629515; cv=none; b=afeIBBVKyFo8WsqWHs69ZC7+LtX+Krwkna98jR1pTzSbUR1aL+vih94bf6jkWDFiCMJANcpquAa20tajOvLY8xbso+l6PIW4IRITW7BfI4XQPrv3lGBlqNAk6Ha7JI1mVbsXjTrVebKOjQNJP5kDirxfXDYOQ3EHnI0pPipEpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629515; c=relaxed/simple;
	bh=akJPEqjhH9LuTqDWvnXLp4kmnis6ozcHNYQn9WwrF8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MI3CYhw7dZ1OhNYR6uUxIOKs/kxI42IdCmQAZUgP9ilKoQKNYPZrHkHTp1DMf5G/NdBFmY7zP2V+t1jU+MPneL/MkdQzcA0I99/lqO3qN5753509l7g+wYmsyLcHvrm8JiGeD5czohJDxWmmYHgGPINlryiySfssFn2q6qITE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP1M3YRx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e269e2145so133793b3a.0;
        Thu, 10 Oct 2024 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629513; x=1729234313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdDw79rH2ZZXFzCqs3bPN+dRZOAgzWUPfJIf5p7fl3c=;
        b=eP1M3YRx5bVhKqccBph2YJIZEU9D8Pkuh6StCAsRoEHVK8hqngUirPfUtdP9bWc9Xu
         Z3GOFBQJX2XuLMe1JE+AwyvDu6ZEcXvu1n5u5kIMif3NI4+fbm34gdSlWSWh3/EEmnOl
         nB99nnvb3tqUgx4XBMOq662BvyXqyh7k1GlRlgTe4AhS9VOy+zzvX636DlS0/CUFE+uu
         C67zbhuBMVMLIySIb6pUbcpJ4I/ZtEIuoujyxTpwAfxDu2vjqpmbh/MCwbHG7xFi/Q/Y
         XsZzgduqf0zYQAtsqngOik/5nUt2vGJO8mB85W/HEknjgR4QVv/Izra0Ix4vV1Ld3QlS
         YpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629513; x=1729234313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdDw79rH2ZZXFzCqs3bPN+dRZOAgzWUPfJIf5p7fl3c=;
        b=TrPBqnId1cJluCE/Rc0XBwtcAedgYSVDs1bx82LiHun6o2/K1OUDjpeMKV7ddH2q1p
         0cr/E+Yu8xFBA8qRCiwTKaOWiYDg95aC4jWGIRbVZIKSuwmyAnkARjQMTDJE0uWsS4Ke
         qpA5P9MfOfT215U6Sv446uPo9RDK8zotslGdS/lqEGq05VTG5uI0tGVt2wXPC4CODVJy
         CoPHKTbo6XZ0V4Afq/L9ZIKmkipyMorC04tBzADwwbUf7hu74qED0r6PY4mH1qcGviZW
         RNKf1rT5OQLnAbK/tk1esTIjiVKDV+bx7T0ht8w6i3CQkji3hp1Sl9j34tYRBbgQHPMM
         dfmw==
X-Forwarded-Encrypted: i=1; AJvYcCVZyIUfhnImAasLWO9NqdNrVWscQVEHp82xwDS2egBaA1zgOmJX3QqZZkhb3xms4kFFyIl0m8WXJRJVp3gV@vger.kernel.org, AJvYcCWhLsui0adQEeYMBQW0Yhw46yxaS3XYNl9m0gHuKj73Fw4UvPBmqdjwedvhuJmmZOLW0D8oMMb0YYfP@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHXv2IM7HVP3zE4iqo28CPeyOJW0nsPUixDLscqvzvdVvQ8AT
	BAmNxDdcldEAAmW+2B6ZHA2C9jmdhwkXungw40hCzzwAtz4srqUh
X-Google-Smtp-Source: AGHT+IEvzv0o+ss8gCY1Mp117fH1qmaJdW78qEOqQWOSBsVTBUkvz8aULfP30Jh+8lxMYgt+jtRYDg==
X-Received: by 2002:a05:6a00:92a8:b0:71e:3b51:e84d with SMTP id d2e1a72fcca58-71e3b51ea63mr796027b3a.4.1728629512713;
        Thu, 10 Oct 2024 23:51:52 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab109e4sm2036099b3a.206.2024.10.10.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:51:52 -0700 (PDT)
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
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v5 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Fri, 11 Oct 2024 14:51:39 +0800
Message-Id: <20241011065140.19999-2-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011065140.19999-1-frawang.cn@gmail.com>
References: <20241011065140.19999-1-frawang.cn@gmail.com>
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
---
Changelog:
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
2.45.2


