Return-Path: <linux-kernel+bounces-269017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8F942C56
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1D028430A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41881AD9D3;
	Wed, 31 Jul 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5VcKQD3"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B51AD402
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422858; cv=none; b=PtsxzIrdtzoMQrDpTgUmwV47WKNZ5n7CAjiS+q9iYCC6Qfci4gcSfE0X3fyYnZ5kY2phkwAVCogVf7SY6c5iFW6s8cGNnBqcgsh2em98kcP69HVNaPe+M+7LCq/FT2Ah6uyJFW8kmYAJJsMN+h+YR8wi8t3VAXBDr2LwJrCuuiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422858; c=relaxed/simple;
	bh=VZdIXqKX8+BtnGEue87IdkU66HWYpcqJc6vqGEu6vOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JP3N7+LYCxU5kDa34jC9V4k8pAB0LMW+ReCaurDGlO02ItmE8LyS/WAPDD7JxgCP1+nMKP9DzZsrqaXs2xiBuWoPSkqoA4OofJKa4sCclMDGwtAMo21Olv2T8Hg66TWaUMCQWlOXSSvGF/CY9SRL2Yhom3oos9WjVDqCy9CO2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k5VcKQD3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db14cc9066so3483691b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722422854; x=1723027654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qem02ElTOfIEGBZ9hs4Pgv/bXYxn4uT7NZSUdA1BxY=;
        b=k5VcKQD3qaMUE0JLaSmHz4V5LCiBem/85sNlDVnzSuqrf6odMJimgMcpHVHGh4Gbx/
         BBWXsmJsciAV1DurJyBrAqgyKz3a395TV8Jwt9UFkan2hO+ZGvklZoFDs+giabW47eVY
         HqInNdSktGcLF8Iqnu2PLqUAl1E35CxM0YwBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422854; x=1723027654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qem02ElTOfIEGBZ9hs4Pgv/bXYxn4uT7NZSUdA1BxY=;
        b=byP5bYvaPWpRuF3HK4+lZlnyxzTKLLhViOspIUv/Ac3GxfPsKUQbX0OSRHNmI50vlk
         YMq2uoMGdigAArIdjxjQ8ywtT8KOCMYV2xfInZfZlGVkmytG4SXd2L3aoLi4dSv8UVJt
         l81cqhWz56tzH1vwpPnjKITqzwbnltmryzqz6mVjL3bVeRXgosvsL9Cr9PBIuIkcsa2N
         CoGK5l21RXsw7SLdFDuw8PhSFF7BSAtXoaLga/OzUjR3ViPZn8RNaryxCsRwqs3rSJ0a
         mCtVqPB8fpJUcH65NMOlokgJy7o/wcifPm0aofqvO55/oKmUyCtJtjxpm2zCH2OcntqQ
         qYBw==
X-Forwarded-Encrypted: i=1; AJvYcCW9VO4sSddrBgZ5MSy52/lC2SRyqY5vWlT0GZAjCxa1ElhkDHFew42Qgd4QJ/bFDO+u17+sSXpXhtufx0IlgHFcu7+n88MGNVFnQ414
X-Gm-Message-State: AOJu0YzFsK2veQj6ega6F3wOyC5uZvxYQdv3CblzibE9Zv7h6jayaP/g
	GRpKHr4CkwVc1MGH2vfuVhihw/Td4wqOQXB+yNr5b6Fyzpyo9aazMqX0PtNQTQ==
X-Google-Smtp-Source: AGHT+IH5bC6y2xO5nokTVAVKXYLk/DLl9mJhg1O6q+f7058Iueo2iMjXfYVgLff9hn3UfbyamVgNaQ==
X-Received: by 2002:a05:6808:2185:b0:3db:1db4:5b1d with SMTP id 5614622812f47-3db23a640d1mr14284005b6e.48.1722422854540;
        Wed, 31 Jul 2024 03:47:34 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa5a0bcesm8788400a12.89.2024.07.31.03.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:47:33 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 31 Jul 2024 10:47:26 +0000
Subject: [PATCH v3 2/2] dt-bindings: arm64: mediatek: Add
 kukui-jacuzzi-cerise board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-jacuzzi_dt-v3-2-1c4314e8962f@chromium.org>
References: <20240731-jacuzzi_dt-v3-0-1c4314e8962f@chromium.org>
In-Reply-To: <20240731-jacuzzi_dt-v3-0-1c4314e8962f@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-a9570

Cerise is known as ASUS Chromebook CZ1.
Stern is known as ASUS Chromebook Flip CZ1.

They are almost identical. The only difference is that Cerise is a
clamshell device without touchscreen and Stern is a convertible device.

Although the commercial names are different, the bootloader still
expects these cerise compatible strings even on stern.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..087773a43673 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -146,6 +146,20 @@ properties:
         items:
           - const: google,burnet
           - const: mediatek,mt8183
+      - description: Google Cerise (ASUS Chromebook CZ1)
+        items:
+          - enum:
+              - google,cerise-sku0
+              - google,cerise-rev3-sku0
+          - const: google,cerise
+          - const: mediatek,mt8183
+      - description: Google Stern (ASUS Chromebook Flip CZ1)
+        items:
+          - enum:
+              - google,cerise-sku1
+              - google,cerise-rev3-sku1
+          - const: google,cerise
+          - const: mediatek,mt8183
       - description: Google Cozmo (Acer Chromebook 314)
         items:
           - const: google,cozmo

-- 
2.46.0.rc1.232.g9752f9e123-goog


