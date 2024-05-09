Return-Path: <linux-kernel+bounces-174468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C768C0F37
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5161B21DAF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2414BF8B;
	Thu,  9 May 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnHWkaUN"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DD14A90;
	Thu,  9 May 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256445; cv=none; b=oFODyez6yH2nFpSfj7t7SAQ1Sjd3l/POcYg/aojg+x09KlcQ8Q06rz8EniaZX8oRIE2rUnNmGSrqrcMlSZnqUWywSn04l5AJObpPEYGL4iOvS7tvtWe/AkfMxLQfPcm+Onb+MuNDSotcG4j1iJ1EnEZtEEXjKt6y9ZHeIyn75lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256445; c=relaxed/simple;
	bh=8rUSx8wLTQ0z1QSJtbAVIFlLK/E/zSFZyno6HqDh2Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lByPa1JsTNBIgv+Szube/2biQ+tYUJZzdasfmnWzbdmhKHBjEo1m96Ixs7e5wCexu4BYfeD5FUEC+0IN3BrTfyH0sLdV5InOfzdgS8hWJh8GAKBu9SXY+ORweD5eWhoIoxswoB1zo3f9Zp99KUV4rKLbavG2JaTjb6rioW7YiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnHWkaUN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41e82b78387so5974595e9.0;
        Thu, 09 May 2024 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256442; x=1715861242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAif8iJN8V1k3wa8UJdZQ5GifnX9nyDTgUZq5/d7HCc=;
        b=nnHWkaUN8GzO2r35V0WWQil33mYzjiu4jh6OYy9u54DqB4nQi8ahO11TRrAeEt00gI
         vsZGwI1nD9+LCsfsUtbWw7uUquh2BRxKjsvjtnB+senHtBkRCP+zgQ4LljsR4zV8/9aQ
         F+0lgDbcuIrYzQjOQ96PulSV+4GfOcJreVkplsb82Zq/MUWOrmdhxb3iISV4Fzm7sNxY
         wTT0CEMXUnBW4YBcNlDER8aIhTQX8HasTS9MD8we7ym0EEKN3bygqGcdpCakx2ltQOWd
         BzktPFZ2f6jNq1ZGlA6rP8Kxhh0K0BThljtU9xU9mplB9lmPBxVbKbA2Lf6VKm8LVLWx
         uu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256442; x=1715861242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAif8iJN8V1k3wa8UJdZQ5GifnX9nyDTgUZq5/d7HCc=;
        b=c6lEg3HHy5+eZb4YSH7M3Zt3rjx9t4Y/3gTTt3mu1E58dkVNVwH3tt6BUADwZLoAUu
         q85tGnyqSGgmcCoLLX8XQVV8BBJHm3lKAYK0xk+Rru3C/5i4gefJGDBIu+icfA06uxn8
         lOlU87WO6ZfJkOdweN2g1OHCaHSDCZV+GVcjdwVgS7QnUhzBEY5yUiAQILqv0oIs3u5E
         VpT+dgrg2Dr7UWL23VYpDO2eUlmvpZvJTCKJsIo3YBzIFklnLGOlKlvo48d1UyxDni5B
         rjBle/tXP46No+1I+jiHywx5K/ThgdeNunrVFjoAP+SRfzsVFA58JK1E9BiSz6VZrugk
         9w7g==
X-Forwarded-Encrypted: i=1; AJvYcCWWUdBAQftEybe7ClAoqkSd+O8tYYcqZA3ehON7Yfm9O4erobHlvhIu78eG5/F0RnrrN6n97MWdq1AhHY/IgGilGuDzzDOGIZmuX316H3X4FR/nw7GUTAnuVCDg4fOvECNrKpExKqOK6fCgGwatNSZo0UDg9rKz4ztlwGE8/UxOGHOn+g==
X-Gm-Message-State: AOJu0Yz5aHuFn9z4Z+ZZxp5f5pEqnwy+BenxgNCCm6gDI9Kaj38Om/D5
	BLHGIbIFdN2TPJ5WPlIdUN2hC13T/QY2uGwKq9g3ranL0pAjlWY=
X-Google-Smtp-Source: AGHT+IHTG1IHRUpJsEvbfsclIDD11n/Cn0Dv06smo6eYHnW+6ah5dzq6AfYFQdIT1VKgAJhmoFvavg==
X-Received: by 2002:a05:600c:5128:b0:418:2b26:47a3 with SMTP id 5b1f17b1804b1-41f71ecb1fcmr44191365e9.32.1715256442507;
        Thu, 09 May 2024 05:07:22 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:22 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
Date: Thu,  9 May 2024 14:07:09 +0200
Message-ID: <20240509120715.86694-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the MIPI DSI controller for Rockchip RK3128. The integration is
very similar to PX30, but it has an additional AHB clock.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - added ahb clock
 
 .../rockchip/rockchip,dw-mipi-dsi.yaml        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
index ccf79e738fa1..fdd1c8ad6045 100644
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
@@ -36,7 +37,10 @@ properties:
           - const: pclk
           - const: phy_cfg
           - const: grf
-      - const: pclk
+      - minItems: 1
+        items:
+          - const: pclk
+          - const: ahb
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -120,6 +124,25 @@ allOf:
         clock-names:
           minItems: 4
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3128-mipi-dsi
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          minItems: 2
+
+      required:
+        - phys
+        - phy-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.2


