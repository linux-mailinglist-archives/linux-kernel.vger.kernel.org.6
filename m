Return-Path: <linux-kernel+bounces-187505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277968CD2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755C6B20AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E214A4FF;
	Thu, 23 May 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GCcrZNXb"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CD14BF8D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468576; cv=none; b=F5cOmTzolLK66HlOq0VIkO6pAKeK7a81V2wWp9c98OpZ+GmxjdVwqAZr72aPWRR5XlFoVmKgFkGv8NmnR1dWKtlB5O0WXmoGHZxfapUsbiWoFfAyREYASA+RfgzPUDtS8Z0svJ42RE5bXnJOdy3isP2TDwUT1Z6EAP29AP077es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468576; c=relaxed/simple;
	bh=9kh6UGARON/UIfmPWxGK3T+BbLphijrZt3nYZp9vdEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KADzepgjzBFr0RK8jMIb+mFMXJ+Pepy0k9+xFFGRdDaGrBPPubbuZFGwOHD9f47RThb+xgIfX+OMeZF73ZMZISdqAhAfSL1xIl/WSV+Jal+yoBou575Q/IfwJp1OZhHsBZOL8uTPF2Tp5AaZAp6q9/GotCSh3vtuAbViLXOENus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GCcrZNXb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354b722fe81so1984934f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468573; x=1717073373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIRR3PAsLDPeCVGxCiWamUF0dUalt0OAF0ONs7qTios=;
        b=GCcrZNXbC0m9g3XKdTf0NfMYMYdmWv4mE0sooKwEA0X7rLtDslBNqTYdXloCDta5Vi
         QD/fHsx8c0tqv8d6zBZ6QJdt55+npbwSSAhHFCseMQv8vG1qA0Af3wDFTn/HZnQK4l1r
         98StYc/AmxyPoMbhmL/UElQbDwKLd6D4C2krmhoTn74YCQ7Wf7gvp8h1z0U4gTd7zNAN
         oQ2GXGFA3YeazmLu/CjHBUBA6ldv4Qr0wT1XRAjqREE4VVNdyp0pZ//4/RccOc8LA7Tt
         tm9t4Ui87QfHSTmad3wycmkOcn7oCNSly44SEhql1vEJFieMRA1QAfVnTJ0wLyPCJt8G
         YukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468573; x=1717073373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIRR3PAsLDPeCVGxCiWamUF0dUalt0OAF0ONs7qTios=;
        b=RfYCSyNIwyVoystRVBeMDDarReBBCBTMcYqLGEPlV6APMKOHbM1+E0V/lZwKPH0tDx
         cwXQtTXbHtJ49tGEHUY282G0OnYbqbkcsEmHxpYm6ATuQ4Mx4kpgM8Iu7ciBN9MTu/8S
         XVS4bGMcEKsgWga10OfaEEw8KXRacKwPlljwL1mWMmC6qqxE0k3sZBLJ68u2e8n2RTC6
         UeDNbIDRgd9BpfACnLZenxilZj340JOFstycNvpy6W7XVoEBwpCnsMoxFajnBvtJ5/il
         0U3buRgp4oYOW+uGFHjnXVoRkkQjj9yf+Vnn9v3UUisi/t/DiaXRz5dU63l9htOzNVMS
         qk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPF6cEePTLE56o1ooiP87p9+X1Ks8qtdK6+kuTb8qlE/HZZPw70gZP6EKHmW/sv9FL8VmoGmrWLxseJ/JmZF8fvEe7ECWgDNIocaIK
X-Gm-Message-State: AOJu0YzGEYujqOjpFxQ9welGSqO/LUo1/c+g/lEJrvMPvtBrgne/bSTI
	5IgoUb9WCQLJLkUAGgtQBGhBBb+fEyeHN1dSdo/ksXnLnt8iERXgDNT/QPKuLoE=
X-Google-Smtp-Source: AGHT+IG8b4YiHAdHYRablfZZQ6Dn6FlVS/F/SaioWLZ8QofReLYA7LtmbLwTsCsrz9Ysprqw4ksAAA==
X-Received: by 2002:adf:f207:0:b0:354:eb2d:be00 with SMTP id ffacd0b85a97d-354eb2dbe62mr3152513f8f.62.1716468572639;
        Thu, 23 May 2024 05:49:32 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:32 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:18 +0200
Subject: [PATCH v4 05/15] dt-bindings: display: mediatek: dsi: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-5-ed82eb168fb1@baylibre.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9kh6UGARON/UIfmPWxGK3T+BbLphijrZt3nYZp9vdEk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTXxqS0hmmz99kc6jIQPW0PAPiCFWxDDtx6P/n
 7AXn33OJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURRbHEA
 C/PkBLP8vnZIf422AHZD2BfrARu79PMnaDfqDKnbla/IQshdf9BVJjs1L4BAXEA6TTpx+amUNn7Dc2
 9jwTLa8jJBcfFWRUV7TS7TYh2Cv7iUlFTXR0e/iYs0cVraWfpa+aJUSKJHM/+M994kskXCHFLvFq+8
 lTKzqpjzGkE8TX53gzag+3E7axudpA04GS48/fo53U5i9N2nyQhwjh6kS5RSFxp+G2UCjRFWCKsHY9
 uLFywRRlJxu0yJLN75GWz79zfVp5kPjxpTVroUms5GwioA7mp/NGlJwClop5dotRbE51BzhxUub6N3
 8uwIcG9Y2DMrhDCE1DCFiuXyMVDGjz8Knw1u0JEQuzCRIfV13wt7VRUsnI9EuynwCdbB2vw1bpqYa8
 I3HR1OdVZc6CT+7FBDGIv+9I6PJTbFsB87H+iXQzFpkfUmDmjBf5LBYbbPTZe+lUGkkPRE/sj7pFjm
 xCM8N/nqjYNPQiSoAIriUHuf/oiSqjbiX+O1rDSYgC0Dm5W4SLUOz5Mh2SzbJEYWf6CZcEg8kFcsPn
 jeeuPe/HtutARF0lGyaZ9bcb9nYYBgmgM+hvF6c1hLzd9C89tWyZrq2tgbSfLZ8ZTNd7TGgbWAcSjQ
 4sq9lPWc75OJQMVKtZfxRs3nUPCRPlUmTuHhN1lMqD3ooqGUTmuARdOWrjOg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the Display Serial Interface on MT8365, which is compatible
with that of the MT8183.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
index 2e9d3d23cbc1..27ffbccc2a08 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
@@ -37,6 +37,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8195-dsi
+              - mediatek,mt8365-dsi
           - const: mediatek,mt8183-dsi
 
   reg:

-- 
2.25.1


