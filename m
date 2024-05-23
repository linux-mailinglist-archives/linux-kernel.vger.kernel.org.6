Return-Path: <linux-kernel+bounces-187508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69338CD2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB891F23086
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48114F10F;
	Thu, 23 May 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KGaAWlUw"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFA14EC40
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468580; cv=none; b=OmWX7/KZqPuNp7mAX+65rRP7qChbC91OWrl9uje23v9ZMVJIMqno2WSEnjK+8K/R/JXPRorTlr8p2zlFukMTk0zIzlde8b9dtchYQWU6frKQNxsgOyEF4rgJ4q59VXIUFLqS+V+fO6l7Lra/wz1b2MLbErE4u+k0xf0r+JUoP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468580; c=relaxed/simple;
	bh=DEIUlOZDb8oCu073O6xdZzPGpsJSPUdkpGXdE5hcq90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkmcvPrOCBqAnAg3Zpi4aATehSCdHms52brr36SDyel5i6VTJ4dwnqMUzdZW4nw+SZFxd3Gk5absbr/AccvlQe31M5DAqakG1Q7eKocRQrQFMut5EaQCdzZgYKE54oDq3338aRktOFUuoEpezRvhSiWw0uFIZNdw0ohNGSDET+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KGaAWlUw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354de97586cso2215584f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468577; x=1717073377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkJmBq6onyQSq+T7hLJMjqQJ9w5LaJXZraoLV+X8Auc=;
        b=KGaAWlUwfWyRpvogIjZGCvQFdSDspVoabAr0oMx/9NOlpzTDGl5KUzX6DaUyZz/4oK
         fEhaoPLLAWNeT3GB2gEbxsuskr4G9w5z1gH9Vwk9Z5drwdKjvPjTN8ATRPmEHHlW8a2v
         RIJfKkM9yMnsQkWJxEhkXsbyGHehoI00eTGsyD6NUGVh7akJplVYHf6W70jtVewc5jqd
         gKss2V0lM/844hbUkXORwctGzgPmTAvEFcCGrUOjZQkmDPKxaZEvrRQkSTt45SGAX/AF
         R+LUaG98SEXDU1DH63MtTmRGaSnvVjrKvRwVUKT5HTfYqqgszlz8LmfGvT0fSVqhlX3x
         nfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468577; x=1717073377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkJmBq6onyQSq+T7hLJMjqQJ9w5LaJXZraoLV+X8Auc=;
        b=ltfECala7D5sICfT2fgLrZcR9uu+j4ep8j0NrO1pTEziyLMDA0QP2RKlY26t7X6zsK
         Ll8fVFKEPd5y9MqwmEbBI132avkQtXhAhkSBQMvMBOOdQ/up9xA6mnJ/D8g/Wjhm0qec
         hJ+wO1CeKr8D4Y7XFVqqjZD6DTHIbOWi/ez8dD7GoimHyDVpQLXD3ebIrKxl/My746Z6
         aA1VGHzcA+R6YkVYzg7MvKPEgUb3Kzgfx4GV/q3lD8Ipl+WcUFZwXGd16jFiA+7h9wWX
         lTbYpzBXm5/jqdfMipPmS4B6Qi8ED5uD43PcvJ9E4FkN8+VHgh7P1vKL6wAVblFNZFNe
         9NEA==
X-Forwarded-Encrypted: i=1; AJvYcCVtVZNnDZq/JNFyUC85Zv6KSVMCYoow2imUmkDC1Ya4fsbdmBLyMHA9AzkPO6NHDrhEmXrLgnmIyvCs3lZOAxfTGCwNqCT2FoIEuQ5G
X-Gm-Message-State: AOJu0YxQ4cuRCcUiG+ppSWJsnHkfSemos7qLySES3CsdADBW2DhTEbEr
	F7N3IDj71Pq86Nfrgj5xC7Pyol5R7jBruDdFO8PsjwYqBstiut+sGb3JdzzmUtE=
X-Google-Smtp-Source: AGHT+IGdHb+2nhRmWTFg31x3CwTvhs3p8/U6MNgzEjblZfe0qTk58c4045NP6jEabYi5nerCmPBVUA==
X-Received: by 2002:a5d:638d:0:b0:349:eb59:c188 with SMTP id ffacd0b85a97d-354d8c7428fmr4286365f8f.5.1716468577068;
        Thu, 23 May 2024 05:49:37 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:36 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:21 +0200
Subject: [PATCH v4 08/15] dt-bindings: display: mediatek: gamma: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-8-ed82eb168fb1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=DEIUlOZDb8oCu073O6xdZzPGpsJSPUdkpGXdE5hcq90=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTYUWDKmTXjiazVz8jH3hWP22eE7eomiqm8qhE
 7KBFP8CJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURVWlEA
 CR4mlMMfr4kWE7n8zvTLVPBqU48Mean15/WOP/9YSkzRk0mkEJlhQZNGddl9H4UEws3ztdlyaUajcE
 vASa/78GPL64xAd8qk+iljbwhBf46pmz5lPRdNWspQWq/vBk1n2FWYG0TVNyprKK1kZLF77oksMym3
 uGoxmsU8St6XPBrptLM+rbuxtvNhnahTdqCr9H3kSs0dGcphK6YgOnfBvzDiMzPtAc9z5WIN4BBG39
 3qU+Lh7JtybXGHrzgpYtmKBnipxE79PMZP4Kf22wFt7Q9s/nLh4OOCffZQStJxB8bDfn69OEiB9pW9
 lJVWcsxmvd69z5ElMA411LOggE5hHC45I87S1Zn6gGxGTiDrY4BVVtP1EkrDgylFY5SsRoyGKhKssc
 pKnBA+LuS9eLUTZocmwYHYEL1IRP8Q1ZDC2WLs6FUX/f5EnJs37vysiE8/0lw50RC2qoPa0YfI1J8U
 O0mzuiHQcMcBhE85ePeztAgrX7zkt0R3cDFvZnMnZwT2AShtOgY/baQaDpZAkipGnQ338BFxWVgOS8
 5JNbiL3/aQbUyRDKEZJtCZ2viL1VY57aNhSGVE21IqvKtSk7ZTaYarw+1fFt8fO1kHHz+YpbRPO8b1
 4U4mHHm66kI7zTG/XxnycuBYFEKnJPOnXhFyOrCVcFrEc0E9SA4c8KPv3MXg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Gamma on MT8365, which is compatible
with that of the MT8183.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index 17f299abda11..48542dc7e784 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt8188-disp-gamma
               - mediatek,mt8192-disp-gamma
               - mediatek,mt8195-disp-gamma
+              - mediatek,mt8365-disp-gamma
           - const: mediatek,mt8183-disp-gamma
       - items:
           - enum:

-- 
2.25.1


