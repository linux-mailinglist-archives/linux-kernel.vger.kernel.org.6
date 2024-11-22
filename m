Return-Path: <linux-kernel+bounces-418122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384B9D5D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D201F2144A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE31DE4C2;
	Fri, 22 Nov 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ffXCv0Dv"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BB1DE4CE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272595; cv=none; b=lY/1gBXxd4zHBezWEg9Ubyp4zra5bmIjg4ctu9CZy5pawmXIYqRxf1FOTOwu7GtpF+4S+9pG/bYsYOr2EufGPhIJsEOMIGiJh0cQcxOmZVfs8T2L2XKM39xa20l9imZgL1vwYHbdhPMJItWnigOwjj226efrgekc12piWg2oJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272595; c=relaxed/simple;
	bh=tgRUJj6ITNEzj0a1c6+NTV/uxYtD9IZiLPipY7pVz8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4cAxJo9L3pLtxZxNFKkChbqDnEDx0L6lRi8n+AaaNU/HltYfW49PhMYT+5bVNAiELyPKzNo3VysF3hjoOJbfP9LspVY1CSpltYc1n1aatWVUyufX92H2xWpSAy9kT/oKYs0kvgxrlzJZIJMyJgf3ZfoL94QSgBKN0Fl6wKPQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ffXCv0Dv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so298437766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732272592; x=1732877392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrinVQn1Cbi8/ijEcpv1A5N1VQp4jJYPom9JnVjcWsM=;
        b=ffXCv0Dv5i11x3IOovzSZPJNze0P9Qk7EnjHsGCCZxZy3N0k7oo5vSu3pR23eYIZtp
         1hGDaPEnkkgQK0+y8RXK8dd4Ki1O9AwWbeAJglmLLh85POsmRQlcBU7hwuYYruiAZeI2
         bfcDhm/jBq57rcRL8pK2dcPQ0+lZF8zL1ethM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732272592; x=1732877392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrinVQn1Cbi8/ijEcpv1A5N1VQp4jJYPom9JnVjcWsM=;
        b=V6N/h5xc/JpuZlqjAqn0PeH9uSBcubUpkOucj4q4VvqEilKSaB9ccOHQhu+ptkTS5N
         ttH3Xl7/v/qHe0MbXKEhaO1+vH//P6W5gV/rBGPi5PsZGppOTOMcqN7u2i/flvFPsti9
         oWADD63ZN9kdoJfDbTPfusJTtazBHDdcfx8NDtMD46nxcBophC7o0tns8Y7ViXe/m+5Y
         gGRjBujMLP/3GrqHvEdNjl4U8jDdvtW09U9fhCenumHAA7qmRZp78SVkJNRrkcPrBruv
         WE++kAhFxKAzljNEbM8pRh8t0cNPKnC7+WpheOxSQRMECs5zMkPZ8P76QfhlpTjHfHrD
         CIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN7mK4rqzBp0i9/J6n1ujMKjrG8/6a1gEvCtDFak0TcYtkQFsnZ37Zze/T52wDp6vWF8LpYzGCDnRjamo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3dIwy1U9+qag7uM73LS3FmFXH63pnYfnkV2JRPA764bfVBWH
	KdwBeeUsUUNNghBUAv3myw2Pw0PAclxmBWDeRFXg0mvt/2Az9hom7hpSbzL4MQ==
X-Gm-Gg: ASbGncvJhGa/OXuE0QG2C+W6hwGL4Z0egvjGgNjIlJcaw2UiycBWP3uZsvLWsMRxjAv
	drNnKt+0D3LccNvMowZvbJePK74nhPScMsGZ4PDLtKHRtanAXrYARBF4FJG9VIZrQtoykbPqxW1
	U7czS8VU04mXgjMacbk1Oymuwh1PyZ4oJB2iNbu3UpmpAiTvey5fydOnGdcOT/TxgGN+WVX0tEd
	RGZOex9dtDZTmV5HHo6W7UL2rDLp01hX97pBsdiDsZY9FhJq5OQP0DJ5fmnDRZ40CCk/yXTM/TM
	6oYl6PS8
X-Google-Smtp-Source: AGHT+IHZnZfKf7gehP3fB8C/hlSWOPVc1U3PpxHVeONSc0QcHH0SfvWm4T58Y60rMJ4GvxkG1gycAw==
X-Received: by 2002:a17:906:1daa:b0:aa5:73c:8d33 with SMTP id a640c23a62f3a-aa5099fc310mr200688966b.35.1732272592002;
        Fri, 22 Nov 2024 02:49:52 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa50b52fe87sm82614666b.117.2024.11.22.02.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 02:49:51 -0800 (PST)
From: Wojciech Macek <wmacek@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v1 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
Date: Fri, 22 Nov 2024 10:49:37 +0000
Message-ID: <20241122104938.1437925-2-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241122104938.1437925-1-wmacek@chromium.org>
References: <20241122104938.1437925-1-wmacek@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Starmie Chromebooks, also known as the
ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
a tablet style chromebook.

Signed-off-by: Wojciech Macek <wmacek@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d9..df38bcf7c1b61 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -263,6 +263,14 @@ properties:
           - const: google,steelix-sku196608
           - const: google,steelix
           - const: mediatek,mt8186
+      - description: Google Starmie (ASUS Chromebook Enterprise CM30 Detachable)
+          - const: google,starmie-sku0
+          - const: google,starmie-sku1
+          - const: google,starmie-sku2
+          - const: google,starmie-sku3
+          - const: google,starmie-sku4
+          - const: google,starmie
+          - const: mediatek,mt8186
       - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
         items:
           - enum:
-- 
2.47.0.371.ga323438b13-goog


