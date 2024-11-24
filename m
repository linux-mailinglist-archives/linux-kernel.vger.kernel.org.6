Return-Path: <linux-kernel+bounces-419370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE789D6D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C525F1617B4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8F188015;
	Sun, 24 Nov 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQeLxnVK"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2026187561;
	Sun, 24 Nov 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435387; cv=none; b=fjERyT+kCuWU+Hc8rKzEGxJEkAGsyPzFqDaP8TbVzAC6bs34ZGy26As6+JJA7xbqaVNpGVi/7cC+beP06xcap7UoPXXFcNwER20h/tcY5RDzGH5dBAfVS08YO8rQvaHINy2MPYN6pjs3YP88mDsS/A30nzcnrjj6I1n7ccTgaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435387; c=relaxed/simple;
	bh=OjPRmJh/nasQX7h1lss1wBBZjoWPylXG4fswQr06XQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd3NZlT9he/64855KKOVC7vdzipK+oGDpQnDhELXzpn/ltZnb7lVYKd4TqNtjFRHzP4oORXic5fZH7guh3Z5FkzgTuLJpVRwAvsF2M3JeKwvLgAdRuhtaqmdNnxl9ChNq7Avi679lwhyjqxqqI/ADo3qLzlLV5FOZxdyIWHECD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQeLxnVK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so1819445b3a.0;
        Sun, 24 Nov 2024 00:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435385; x=1733040185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwiSSoyq95aS10ZR5ywHjvkOgOJUU0juZpwe2Ul98ro=;
        b=HQeLxnVKAQGv7FzmaDgyvKxtGt0OKfSIkwED+vhFOIAlI7vIBLVdCmcrnVXdE/5YaO
         uQfFmUyIBM4Ne99mkidoq3WL2r4Cpx8O28dqWfdcPLlG2Jqkp6e9l3tcL8QF7MDdCfSn
         ALnZKzAkyaPQ0dmV7JnQa6600ZDZBx73LvLSRZCKuKB4BnugJwLypGPNsTxtrLLgqF9q
         Hv+LyadpFhsDzl1LFlX/LIMWKjcblxjmq1Fy/cDx7T+FeQK0YEQPyeE5dpztArLsFJY3
         4NvU9E1EuvraTPDat0E5nm33o4/x13blAEnlrvhG0oLSUsg++d/F3lRf81I9KN3lbZYl
         EcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435385; x=1733040185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwiSSoyq95aS10ZR5ywHjvkOgOJUU0juZpwe2Ul98ro=;
        b=Se9BYByH1Wc70zD9RKpwshSyvN7zshfb+C1K9OMC8AfrrrWS+iU/fKozasSgy9eOe9
         iKN5DLp3qyB79OgkPBqVYouxGS0OtznOIzzvVxUNAdQfx17r6sv7PwBJgW55XkfDOYpP
         5z6PI2oZozCfs8OBrBD8ZW2qbZM+ydq7d34UE6lVZDTvv4JLcRYlWEqmyYOh4Oqerhbd
         1F089e28EuA2WNIvoUtQmdUmmGbPrRLZg/Xr2OlJUqXiV5yk/fe8GidaErjrWf/l8FRN
         pJ87aD6mpJJRi0enO/fXQrkX0rP+wOGIq/RpNJBe8+I1PsNknhVWvDJks7z+Z8EA1fbR
         1Sfw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ee3SUdUqt8gyyXWGTRpPnEMwbUgo1LrAmKXavBIsmgQCNlM+u/U9N0lzwMTQHDTWSbuDffCBkkj7@vger.kernel.org
X-Gm-Message-State: AOJu0YxHP9Xg0s/OkqdnBKwaClyfW1X/KUk/hDtXnPpNYvjvik773Co9
	U3JGYPIABxLL3kKD0ciXNKWTOEMTBQyTZOjQttBtXnuyIcsvQCgH2PPaeWPM5qk=
X-Gm-Gg: ASbGnct40LWm3Z1YZwOtFNTMeh8oVUo/4uEcDQekBntWLaZGZT0j+0M8G2ObFoX05GE
	der9t+rIwAlXZmVhZu4MVpo0DkvrgMGE2h10vp7xArQ7WEroPwbG3Ly3tPMHql1eqSDPTeBFZHX
	c1Eua0Oa9yAwJ85XeoZQSR4qHPKDvXVAqfsJV3FIPMw94/KptXizaXFBN0y8dNWrSnn14IM1a08
	JzsTxA3s+zi2mGTbsfhxe4Wf8jeaGsc2H0IGS2T3z8vjWAILSp1Be31gbVIs1w=
X-Google-Smtp-Source: AGHT+IHQm9ld2SgBp8RRxM0b4eURI6wePuJGMyF2B2CBhq2jEuS7t2RPu+JeZ89dNwX+SP0klI0u9w==
X-Received: by 2002:a17:90b:350e:b0:2ea:3d61:1849 with SMTP id 98e67ed59e1d1-2eb0e88201fmr11289217a91.35.1732435385109;
        Sun, 24 Nov 2024 00:03:05 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de6f6sm7956708a91.34.2024.11.24.00.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:03:04 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Christophe Branchereau <cbranchereau@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: display: panel: Add another panel for RG35XX Plus (Rev6)
Date: Sun, 24 Nov 2024 17:02:12 +0900
Message-ID: <20241124080220.1657238-2-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241124080220.1657238-1-kikuchan98@gmail.com>
References: <20241124080220.1657238-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a display panel used in the recent revision of the Anbernic
RG35XX Plus, a handheld gaming device from Anbernic.
It is 3.45 inches in size (diagonally) with a resolution of 640x480.

It has the same interface (pins and connector) as the panel of the former
revision of RG35XX Plus, but they differ in their init-sequence. So add
it as a new panel.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../anbernic,rg35xx-plus-rev6-panel.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-rev6-panel.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-rev6-panel.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-rev6-panel.yaml
new file mode 100644
index 00000000000..b60a4cf00f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-rev6-panel.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anbernic,rg35xx-plus-rev6-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anbernic RG35XX series (YLM-LBV0345001H-V2) 3.45" 640x480 24-bit IPS LCD panel
+
+maintainers:
+  - Hironori KIKUCHI <kikuchan98@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: anbernic,rg35xx-plus-rev6-panel
+
+  reg:
+    maxItems: 1
+
+  spi-3wire: true
+
+required:
+  - compatible
+  - reg
+  - port
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "anbernic,rg35xx-plus-rev6-panel";
+            reg = <0>;
+
+            spi-3wire;
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&pio 8 14 GPIO_ACTIVE_LOW>; // PI14
+
+            backlight = <&backlight>;
+            power-supply = <&reg_lcd>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&tcon_lcd0_out_lcd>;
+                };
+            };
+        };
+    };
-- 
2.47.0


