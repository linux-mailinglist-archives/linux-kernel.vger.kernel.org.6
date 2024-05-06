Return-Path: <linux-kernel+bounces-170356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9D8BD5A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77CA1F21258
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1E15B106;
	Mon,  6 May 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwuNRY29"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885B157E62;
	Mon,  6 May 2024 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024642; cv=none; b=h1F5g02L0avPHl6YfFavYQs7Izw4MgMcmLZJbG0F5HnTJrhIDD/ZXrakdhRBjge+T9tjiPpyruYxGAC0GmwE7N6HRXez2Df32f85YE28GWtuEDxrDM1VrwbkQvRVFUdhrf++1SKzlKhUUWp0r4XacchU6M+p9OyxUBC6ITogjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024642; c=relaxed/simple;
	bh=5YiE+uz1NsSlI6JfLKqXfR1/pbEwfjJl/75w4y4ipKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM664T7XfwU4AoJBIU8hxESrqihOp4wa13QcB5wnsaHcS8t9H06JeWc43JQTk4aO0KP0goSUNlcFTSKt1qPJcpT6c0EFLcTUkrbMYwOCO99NJ+pwmA0JXcw+jvS4qYD1WB91YTdOY0TFnFiv7Peb1NZJRH27fnyowMTq1m09ai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwuNRY29; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so2789644e87.1;
        Mon, 06 May 2024 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024639; x=1715629439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiy2vL57H3KzFyuIeojalhw0sromROUcEPl800VpgDs=;
        b=WwuNRY29YLdLTt/eo11B2Il23GG7zmLGcD/2UuPWYBLu8CybjSaZNy1SV+n3GhE3bf
         OpQ2GBi5uCiPHTgo+Hfc+CTbhiyGT9DhCPFcHPRlfYlAeroIBB1iaB1EpWcgB8JfdPfL
         iOxWGskPWZFptby/1IH/Akco1ptJ6+k9n4kc5Ti5oE4S78oy14+I0UfhPmBb2wK+Suor
         6PYxKWKMJw60tjdl4lyGUx2kQF2jU//CqOXMxXV/QJSDw4RGdbrq/VN4+EuGPRW01bB1
         hliWsIvgVsPxpbJ0s17Ti12R1OiHY1/o18Pe5mQtqf6BIL1yBA1G+YR/vUxhUBQW8iXz
         2r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024639; x=1715629439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiy2vL57H3KzFyuIeojalhw0sromROUcEPl800VpgDs=;
        b=nSueDAReBJaANqQVRpeGOPcwZvh75PVZ4shOCqNsXxdbE8DPj3qCLqHIvw/Tj4QeY1
         oQFAybqiU2zZ9+VP9EWSO8yv15fK0f+GFKgdQkPCR04HaaVX8VF/RmKMC+EBW9QRbjZR
         Eq/FBz9wb3G/Ls2ih2tLZXp3QjOtN4ex2hS5pEsX9DaNpE9wX3ybjQU61LrBywODkTg+
         SzV2/OEpTEEMPJcuOYikok6pV7duzCEuBw8WMIPrxTjvgRCxMwtciEUciwx2UJTxBLtU
         qH3O9x2/E3I2jtnHz6E90brJQEL+htV+iCeKN5o1TFQhfwkt/p0oNEzDtarISa/h9NVn
         1T0A==
X-Forwarded-Encrypted: i=1; AJvYcCWF9dqaAOPAweNqfc3T0fY43m7IlCgEp+1gE/LDiN+n9qp7xOvWjZIFVLSbfMTo/M9USt2HHJzcptOgH2oghRpTLo2TsBiEMNJ/2tc3O9IfZKLytACoIV3+f91+yKHE++D1BI/5sGeoXmH1lsgpNJ6s6WcEMx622EEwc4EJTa+dTKlGgA==
X-Gm-Message-State: AOJu0YyGXKUAmMaGv28TsMU3K1wfQwWeOYBGL3bOXCYCmzub6elRkftU
	veOZe92Dk8zF48DkOFp2TOObYvpICdVgkoPHeBrvgBDTPkMd1Jw=
X-Google-Smtp-Source: AGHT+IE3JAd8h4TS07pAYS2PxovxmJduheJelK1ti9csXaOuNGCuxVp7c/O9qhjmBPiNhSTXCswuGQ==
X-Received: by 2002:a05:6512:2090:b0:515:9abe:6c46 with SMTP id t16-20020a056512209000b005159abe6c46mr6362105lfr.34.1715024638800;
        Mon, 06 May 2024 12:43:58 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:43:58 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/7] dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
Date: Mon,  6 May 2024 21:43:36 +0200
Message-ID: <20240506194343.282119-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506194343.282119-1-knaerzche@gmail.com>
References: <20240506194343.282119-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the MIPI DSI controller for Rockchip RK3128. The integration is
similar to PX30 so it's bindings-constraints can be re-used.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
index ccf79e738fa1..ccd71c5324af 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
@@ -15,6 +15,7 @@ properties:
     items:
       - enum:
           - rockchip,px30-mipi-dsi
+          - rockchip,rk3128-mipi-dsi
           - rockchip,rk3288-mipi-dsi
           - rockchip,rk3399-mipi-dsi
           - rockchip,rk3568-mipi-dsi
@@ -77,6 +78,7 @@ allOf:
           contains:
             enum:
               - rockchip,px30-mipi-dsi
+              - rockchip,rk3128-mipi-dsi
               - rockchip,rk3568-mipi-dsi
               - rockchip,rv1126-mipi-dsi
 
-- 
2.43.2


