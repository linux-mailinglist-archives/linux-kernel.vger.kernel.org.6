Return-Path: <linux-kernel+bounces-419374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776EF9D6D14
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71C5161803
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43C188596;
	Sun, 24 Nov 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYrC6Hyn"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C77189F36;
	Sun, 24 Nov 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435403; cv=none; b=CjYcb5ij7M8c7gYGZdqSQmA8DwS3PyGcYSFObHZUbmY4kblfZvYblvgfcwW+jUiyzfVtSQE73KwHJdElMVVaLsG0lx4IrWDVDo+Bgge1wP7NCPNhbJ3FdsUKPC2cSDjO6Ex5Ab5GRcLL8lC6lIko65aCYy0u1Dv6pnsLUYA/V7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435403; c=relaxed/simple;
	bh=a5j7Io24LFIPUKBcYYsry+kVOyWQS053YfY4+OsM4qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG3e+fc7Ay8qXv5KXs4PooiRB451KQayhSjPCwfoROH7jBJjb88owwFC3pvNho8X4ChsssMXTydsDjH03PwtcDMFT5Q/ytbEmm6Pzxou0R0uKC6s58SXuAN1G5kjSwRjIUVxFVUKcwZ0Q2oGU/lYoTfTz64IiKW9uWMrUExHjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYrC6Hyn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724f42c1c38so686314b3a.1;
        Sun, 24 Nov 2024 00:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435401; x=1733040201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BH34sqlSKOe9iOZou+43GhfbA7c8h+EbLyzmlovlj4=;
        b=OYrC6Hyn+rGc6Kgwu4c4DEMHr7YnkrB7enPIfTo9LvbOKLHFzGa+mivVxvOduKyt+V
         cvHOoyMAkhej1WS7eH37GAn0JwhfRQcNjK7/jRTq+BXkitGcSrpUPE8KBEVI6HJWutih
         UcKfiCa22kRIpLEQHFiIzFm1eAKhORwm2vzbTr1O3aUQzVgTOZIFnLaRTku7ykiuPllj
         R8BfthwVJpkypTNN7YnvCZLYAxc1xpiumz35wE6IrMl8jk41oLcza2g85onbRsC406Ga
         h17eeEbheDPioTnOtFeQ9rUgP3R84giIFeZPJOysoCl3WQmLVAxq62De7WARjll22Fn5
         b5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435401; x=1733040201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BH34sqlSKOe9iOZou+43GhfbA7c8h+EbLyzmlovlj4=;
        b=cEdvOVyLproNFyEuE5i6MkPNUI87WUjBYGebYW2gzgbQd6v8jlC+7DGmD+wbb4285r
         gAFwZd8KWitOY5/RybjvTBIfjpS1kqtbsmIue7WCcf+3faWG+f6L0V54nygCjBC4Q0bD
         EKYlYPZHWObaC/vkNiTO4g2zqRPWAPGb1Z5G6W6mE4nHIISrr6GS0+lT8/PtL/jsw+sm
         XW9EJkYCs+wBaUKPKiCM2XOhfwOmi19ee9UYoLWv8SvysSkkDCfnFRii3h5JHwy45XLU
         1vRE6PIoMfq8bRxLxKqwkhSjwa4U22Y1Kn9BuG6j7wzDpBbKESOR8KHheEjop/GUrq6V
         o47w==
X-Forwarded-Encrypted: i=1; AJvYcCXpoudLjN81lTTM96NgSkBYIcYoMaJ6wKTTK667P6ha83hagzgneLNdSrMEINA+j7sH4ac1aEg8FzP/@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJfzWBOf7EcGdiXAt6B8OkreHrRHLgwFmYDkPg9GQdpXEexfA
	W7MfB4+tTTncvnJnS8KidQ6sf3b7bap9gvVRh7mJe1YoNE/LYSLKs3pe5wCmXTc=
X-Gm-Gg: ASbGncsIjFe9cttRaErj0Rtg+fTnCpf9Xh0HuYYmi9swHgnJxj56Ufdbasskc3fJVJ+
	y/XP2Hyrj/EYsnpC0HFZmS1kLW3J6jk5Bw+MN9z1vGzEeQqLdkrihzJpAGRwnD5hHL8/zzhmHpV
	dSQB1+zrDWf6DpGG3EzBI9XTGxL+Cq0FvIkdbVzMt52Raotv79qOeE2YkCE9NDbJqjYQW3Jw3XI
	2ul8YNVL3It8WHJTaaVtkeCt1xTNqKdZCySxnKrJK1umdI/zIFEaCMSC30weMg=
X-Google-Smtp-Source: AGHT+IGhvZ9kwy0Xr/geb5tz16xfptX1YZTk6nh2OmyjAzk03SO8bAiB+Y9rTFNC9wmMHaz163RmGw==
X-Received: by 2002:a17:90b:17cd:b0:2ea:7368:3359 with SMTP id 98e67ed59e1d1-2eb0e126a6cmr10208596a91.5.1732435401445;
        Sun, 24 Nov 2024 00:03:21 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de6f6sm7956708a91.34.2024.11.24.00.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:03:20 -0800 (PST)
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
Subject: [PATCH 5/6] dt-bindings: display: panel: Add a panel for RG CubeXX
Date: Sun, 24 Nov 2024 17:02:16 +0900
Message-ID: <20241124080220.1657238-6-kikuchan98@gmail.com>
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

This is a display panel used in the Anbernic RG CubeXX, a handheld
gaming device from Anbernic. It is 3.95 inches in size (diagonally)
with a resolution of 720x720.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../panel/anbernic,rgcubexx-panel.yaml        | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,rgcubexx-panel.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,rgcubexx-panel.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,rgcubexx-panel.yaml
new file mode 100644
index 00000000000..47c5174fad2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,rgcubexx-panel.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anbernic,rgcubexx-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anbernic RG CubeXX (YLM-LBN0395004H-V1) 3.95" 720x720 24-bit IPS LCD panel
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
+    const: anbernic,rgcubexx-panel
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
+            compatible = "anbernic,rgcubexx-panel";
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


