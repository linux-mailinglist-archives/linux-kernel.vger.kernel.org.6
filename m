Return-Path: <linux-kernel+bounces-442609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92299EDF56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440E5188AA03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BDF1DE3D4;
	Thu, 12 Dec 2024 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="FPZoz2rK"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304E1AF0BF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984462; cv=none; b=UUGG6JBpFcP8Z1a2PCoJ/X5ubzC1Cxu42njCeEjri5MYwYzTy0iqmaK+erl9OjVKjbLK9hMeGs0zmfXceyYG6gODKyh9k8AhLSVWCQXV4btAWTIfK1AF5sMH0bYvPpUtct+Ra8KEFbpwERACCu4t4T4wFg2V08DC31Y//0Z+Dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984462; c=relaxed/simple;
	bh=0zzDXqoNKXIdZBWEgfCcO3lS4FJiOYRX5/8FZdHN9Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=okkbXIufyhhnm3b2tuVjkTk3zVp1YBKO3JH6NwCe+6ShaZTiKo3DR2brGPBNdTKdBZINwkfmY6eboUkvI5Q7Hp44uz+ecIx7AmcmmWUcuTaB1DKEn/hPoWNg/vVcr3VbqeS4kuYhtYM3ybNf2KEr/B7XJjlhT+DPxWEd3BwS+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=FPZoz2rK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21564262babso509935ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1733984460; x=1734589260; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gmhFFd9OZS3YcXJsK70hE90ScOtfqunHCKFsvNhGnPk=;
        b=FPZoz2rKn9ukdbki8K9py/UchBnNaG1ex6WwYbqsfLpNI70LEWC/s66zmv5Lsox/uH
         vGPdrXtjNlAtezYy/sKoAH7/c1nTqsGdusxJRZxayqEijB4mOOSHSlPOUP0og1hhQltk
         UIunvn0WXwqecxzMnOeN3vRwwIhUSknyEOStHnm605bzlGfSwNbHt9fWy6w5YhXBJT84
         GvTDl27x3/9LIAGfcZKtfGIlv2v8ZwHOgJ1O6BojkZmfskDnAv+gsXzLhLFFoBeJmrnS
         1yiPJYPcLbLJj2W1f48xyq5QTOjE/SPe8yBO8NXfHLoqNuYsbcN1EK60IMi5/WbAxagw
         7Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733984460; x=1734589260;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmhFFd9OZS3YcXJsK70hE90ScOtfqunHCKFsvNhGnPk=;
        b=I3R043p0wy4qKJsPxdupb6np4WaGOvGdexRI0xq4OwrCuzSR4JHwDjDiRoIgF1h3/K
         zvMiXwjMAlvaif1qonPLOmAPhtlimbt3iCi5xkKTvyaMv0UmLrM0FUmAb/9jo1wO+iVz
         l8zuiwVnMYfuMJJmIjzt/KmWo9EJFDMmG7CM0p1Kj9cA9NRC/HUMa55NwPQlhspvDK1O
         V18+FVt1+4WfnyaiO0/0pMbdjajqd4DQ5+dPNrmvjVxlGhzbxINTQfMMhtAL5UHXsjGO
         N/02Xi9PMDFnrIRB/TaFp0iQ41fIKfKnULAnygKCA64Rzgx2ezJlVZZ5gBj7jHXTVcWR
         huDg==
X-Forwarded-Encrypted: i=1; AJvYcCWvxiFXLE8teI93RA5fpW//Uj3RHG6XcWUMrv3nM0m2GDxzmdorfhEuw7uzSKtpQrRyPaE0T/rXaKDiHbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3DtEtKtl4hxMzO9/h3dv6R6KaP0TlrwRTyF+qK/0MsSMMQrM
	0xrHTDFmzPUyuoYCIfJQ+YPEewZ2kUnGrhW5j+eZCoq7EZX/pWuMEMsriQvAc3c=
X-Gm-Gg: ASbGnctZmY3QHI6V+SbAJWq9zUJ716Z68gQ0fAY+0Mtpht3klM7dZgUFvyAj2V/OjKc
	N8bm7CO/NyvdhQjJ2J9T5wjApcaHMVXYVyLkhI6zww1QoPIKhXL9mM/fxbV6Eow9dyUU8OoQxJM
	3vbJXyJu0CuWmwFWTRCovS8hI3hV3fwK4nmwM/kp+YnPAZekV/XxnhB07nWHtaW047om1rXb4oi
	eZiuCB0g/Z+5oyB2w+IAB5DeDiU+N2JKftlobB01wK3E4rXk7rNDtFF3YaFxfQGceyc6ZN7QLA0
	OfQUZxmplt0HA4zpkJLK
X-Google-Smtp-Source: AGHT+IGNhqg7BDa95UyNmBCMDwuy5gdbsBxRXNYNtSRIJSSwK0euI41N/BGBIkwVFECyb3kJ4tXPWA==
X-Received: by 2002:a17:903:32cd:b0:216:3083:d043 with SMTP id d9443c01a7336-2177856a6eamr36242165ad.12.1733984459913;
        Wed, 11 Dec 2024 22:20:59 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162c278668sm83579165ad.81.2024.12.11.22.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:20:59 -0800 (PST)
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
Subject: [PATCH v5 1/4] dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
Date: Thu, 12 Dec 2024 14:20:43 +0800
Message-Id: <20241212062046.22509-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an entry for the MT8186 based Chinchou Chromebook, also known as the
ASUS Chromebook CZ12 Flip (CZ1204F) and CZ12(CZ1204C).

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..d3cc6fbad8d0 100644
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
+          - const: google,chinchou-sku3
+          - const: google,chinchou-sku6
+          - const: google,chinchou-sku7
+          - const: google,chinchou-sku17
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


