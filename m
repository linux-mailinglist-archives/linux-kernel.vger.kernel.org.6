Return-Path: <linux-kernel+bounces-295215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BCB9598B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B62B1C21650
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E31E617A;
	Wed, 21 Aug 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IUbTljQ0"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846D1CC894
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232439; cv=none; b=cSa/4jxW0hSoLivK/Li0U6gncOh86T+6p6vjJeeg9lJmI9xfFZOqKEVe5GcOahVXSkUoRIMaXzHvfjfNvvPY22wsI/a/7KY2YRKUX4SHtlpfSq51HIywwbqXxnxBxrwPgXtntTE8Bw6yK8ua1JSXddDBw1yE2MF8/k5yqxenicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232439; c=relaxed/simple;
	bh=Ko/U0ZTio5veCSyXN84vMAqEzuoy9/q8A3dbSGWJ70A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RitC6l+Alb3F8OULk7e3S33OXnzXVNIXO3K2rjXgawYrpMeqFsBHqjrLFWIDZ+W2Qn5ZwBwXPDeX9D+jlf4jOjD9AfUsoEORib/Qi6+2cuG5mulqTQh01BJ0pMDpprTFzFzsrJlplVeJE4bn23LL0rQB9yW1lJSFxbkSWPi5kQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IUbTljQ0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3ec4bacc5so414518a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724232437; x=1724837237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpLoj/GHdJ90mGMNH9UOi6XZ//oOyZzmQ1SqbdjiU5Q=;
        b=IUbTljQ0dakLi1limk0JL47iaRhtqNcg6BknBjOO9G7ewyIzrFUNkz7LYA4hoU9grZ
         ms0tHYIqj1f77dTDz9Tu76AsGZglyEQpn3PfrFgBXIkTI0Gl4qQkoR42VuGiLRKBA8T7
         +TrLEUm5zclQascoseRnMTehXsLaY/h0PbHvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232437; x=1724837237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpLoj/GHdJ90mGMNH9UOi6XZ//oOyZzmQ1SqbdjiU5Q=;
        b=qy/VpbPvNVNyC4rYbvnlT4bGwaPNscKXE/ebQXm0CCkzS5q+kfWn2gETEmkEO9He5E
         0KO5lRo6oRIpzLkHKUlC7vO4a7BvoUYZvAScQuZbmA21DuytwfE31ljDaylOiAziO0a1
         cZWGbzfg2ch5MBVagJcSaKhGWd0p2zBp3Kwjnd/8wcafG12PfnRB09dhm/fNMDDl27ro
         vFWRGBAlcEG/o/Uoj7OGUT8aE1s/Kb8TqGHtof5legJZgdivJFCQojq6rgyyCd9YHCx4
         kUMa06dw7Iq3MD6D+LUEB42nHkuEdmxTz6LHlhCNm7ulT4QRpRbOtW11AqmFQhvyA1k5
         U1rg==
X-Forwarded-Encrypted: i=1; AJvYcCXNHahLECkpXLngEOSRJNw+ftqmMSGEtrR0qEMQIum/+lkgEF9O9qLZCtjrC850QX5mpHRBK4GvAGAvJHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR92tNuEs2ixGZdIdOVlWTDFBsuPvnu3NYAO0s/6jEX5wGW9eF
	5uBWm5GRkezAyYMyS2OcqMd4fnt4TY6pDzEUSLP8H/GlekBIdL+FOyd3Xuis/Q==
X-Google-Smtp-Source: AGHT+IH2Uik2B9V5fu3Btspt6fJZ1exe9FDCGD9hvpgvwCy8I2HfWJgIXUX3gWybKSU8xAPUw5kyAw==
X-Received: by 2002:a17:90a:cf87:b0:2d3:d79f:e8b7 with SMTP id 98e67ed59e1d1-2d5e995b72emr3035904a91.5.1724232436829;
        Wed, 21 Aug 2024 02:27:16 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d5eb8cf420sm1246810a91.10.2024.08.21.02.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:27:16 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [PATCH v2 1/3] dt-bindings: display: mediatek: dpi: Add power domains
Date: Wed, 21 Aug 2024 09:26:57 +0000
Message-ID: <20240821092659.1226250-2-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240821092659.1226250-1-rohiagar@chromium.org>
References: <20240821092659.1226250-1-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power domain binding to the mediatek DPI controller
for MT8186.
Also, add power domain binding for other SoCs like
MT6795 and MT8173 that already had power domain property.

Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
---
 .../display/mediatek/mediatek,dpi.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 5ca7679d5427..864b781fdcea 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -62,6 +62,8 @@ properties:
       - const: default
       - const: sleep
 
+  power-domains: true
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:
@@ -76,6 +78,23 @@ required:
   - clock-names
   - port
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt6795-dpi
+              - mediatek,mt8173-dpi
+              - mediatek,mt8186-dpi
+    then:
+      properties:
+        power-domains:
+          maxItems: 1
+    else:
+      properties:
+        power-domains: false
+
 additionalProperties: false
 
 examples:
-- 
2.46.0.295.g3b9ea8a38a-goog


