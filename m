Return-Path: <linux-kernel+bounces-426857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793959DF97A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB72B2202B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977241E00B4;
	Mon,  2 Dec 2024 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="cG4uZ1J+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3F1DFE3B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109670; cv=none; b=fucv34w3URTcQyZaIbdkNFbDbJLTr157UbBu2mHVz6ayfLKDwgcGteIzcYiRfFduZ5/ODlWLqhzHQH/d2VodcCGvxOlZzeXSA/TRLOFJ/O3eHNa9quMXjDOAINWroJcFFqy4EakpzXFxdiJZ2E8253vhDpqibyZ0gdXxZ6I2lOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109670; c=relaxed/simple;
	bh=Nf205WAqCHR2VGdjsPbNFyLTEPAXvDbxA2mMvZ0PluU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pw8Ho3o3iaZi0VNig8oULsumi76DsxdXZR0vGlyj2lzwtJo8bqgpyLD/lQSDtIgzeZ+PWtG6TKZRDV6iJUNICdZ9Zv84rLTJPzvxYFEn6WOucjiYihMwCLAEVitLWuRNIFjgTyHhwIhuLZr2GXsL2/qPtMdBuX7XUv31cFYtoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=cG4uZ1J+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215279a599aso3722405ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1733109667; x=1733714467; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GouYOcgcE/dgc8yVEQqkmDyQoDCGAKL39BpZuNuexD4=;
        b=cG4uZ1J+bxs2NXnjZLoMhRC4nlm/mFdL835yAa/7IOuoIB9g7QUXYLww5sN2OpXTIx
         O15Qzl8LxMJLbe29gqRE3OMcv1hlv14i3UgTsgQLT3iKA+APQtVBXRYDRnBGzk2AN9ml
         nJKP+UEBmuLCWO3R25xJsnlMvpLHojLEzJaXQHyDGG/5ymBIw+E0gm32zuVFXJVdzH5p
         OZbjzV0CiBPf/2s+RdBVv9hUBFYFc1GB4P1rBZN20+6V7Cs+Ljij2V6Ml5E1AbHHjseT
         bfEJj7j5E8wFSEpLsLXOORQUfc27i7NoXVgA0nMFHzsDT9jYKjuAMzepvc0p4p3W89Dh
         a3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109667; x=1733714467;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GouYOcgcE/dgc8yVEQqkmDyQoDCGAKL39BpZuNuexD4=;
        b=wcy8WjXeHbrlVjoNrAONQTBACXp1v1nM685/RtdcwlUzY3mFru/G+Z69uB+sb3jG6u
         UFT2Dd9lfTYVL89G6nsR/F/PdZCSb7nF76+E5f5FoTTeQNomoCtVQCRJIi4y55S/LCMq
         hj8v+G1CwnUl97DQGymgRuOp0Jc6koGMe9EjySFFXLOgmdz+vxyvBVRR7eW4YQXvcUOR
         K/SSKr4qtaqwGY4QRpPXtHlXQw0Q7uJ8+YdHUrqIYU+uA+MbmrMd8Gkri8Ae5+JB4K0I
         28mBvAiX90z9MSqLj+5mXYh5e5CmAo1i4nlxX8oc+bl+ukrKIGG8Ctt77GIRZvi9drWS
         ysRw==
X-Forwarded-Encrypted: i=1; AJvYcCWSYrq6R23aqeB+VPD1HY0f/4DgEKTzbtkCz8U2lSlTjK59xAcGEMFpmjQtP23ICalnpfJJR3Zz5bJpdCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGGMEDwSP4zSSf/NM7e9Hofgko2MldbQtKVgOKbYbouFQR6Vw
	TTGy0YtANjw3fL1YlVvaRPTsHEVzc5MxeuI8xRkrTmSy2AGRghvUFwQ7FWPN3Ho=
X-Gm-Gg: ASbGncuRqS6uyZmXuHbilOQNA+rIbeM3BgP+5AmFDu22+bmWa88Jy3bvmrC+r0askWT
	WtiIXJcBSkTCGWI5q19jxJ3gdalgOSFuy+x0EFlB+scirR3vApfsC4gEODr6+EumoljKcLtWSV9
	IyZOjL10REUzVOyn4TMbvycq5DESmIGbp5Hi18qEe1QQ43mAanET269j0+olmdrB9t9T7JGWm1K
	HV/ItZR+/acI0LU9ydDMzaYwbeHi+5YRcot8c5rtqGzFUfVAFimmF/i2Qz0IQa+z2ZOO0954Ybi
	vf+ADoM5nyhQJg==
X-Google-Smtp-Source: AGHT+IG1juPxVoOQhPapzHNQkFJhJwBvKjBtiOLjbNYz3Lf0IR6DiUN4N76jIyqAurE7D9qaEV6q9Q==
X-Received: by 2002:a17:903:190:b0:215:94db:1287 with SMTP id d9443c01a7336-21594db1560mr11596255ad.3.1733109666817;
        Sun, 01 Dec 2024 19:21:06 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521986004sm66305725ad.184.2024.12.01.19.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 19:21:06 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	dianders@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v4 1/4] dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
Date: Mon,  2 Dec 2024 11:20:32 +0800
Message-Id: <20241202032035.29045-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an entry for the MT8186 based Chinchou Chromebook, also known as the
ASUS Chromebook CZ12 Flip (CZ1204F) and CZ12(CZ1204C).

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..3efab59b8a73 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -239,6 +239,34 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Chinchou (Asus Chromebook CZ1104CM2A/CZ1204CM2A)
+        items:
+          - const: google,chinchou-sku0
+          - const: google,chinchou-sku2
+          - const: google,chinchou-sku4
+          - const: google,chinchou-sku5
+          - const: google,chinchou
+          - const: mediatek,mt8186
+      - description: Google Chinchou (Asus Chromebook CZ1104FM2A/CZ1204FM2A/CZ1104CM2A/CZ1204CM2A)
+        items:
+          - const: google,chinchou-sku1
+          - const: google,chinchou-sku17
+          - const: google,chinchou-sku3
+          - const: google,chinchou-sku6
+          - const: google,chinchou-sku7
+          - const: google,chinchou-sku20
+          - const: google,chinchou-sku22
+          - const: google,chinchou-sku23
+          - const: google,chinchou
+          - const: mediatek,mt8186
+      - description: Google Chinchou360 (Asus Chromebook CZ1104FM2A/CZ1204FM2A Flip)
+        items:
+          - const: google,chinchou-sku16
+          - const: google,chinchou-sku18
+          - const: google,chinchou-sku19
+          - const: google,chinchou-sku21
+          - const: google,chinchou
+          - const: mediatek,mt8186
       - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
         items:
           - const: google,steelix-sku393219
-- 
2.17.1


