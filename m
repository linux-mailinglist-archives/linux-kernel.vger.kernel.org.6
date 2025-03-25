Return-Path: <linux-kernel+bounces-575684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B97A705CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704183A6572
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49488259CBF;
	Tue, 25 Mar 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQbA1YTK"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFC20E30F;
	Tue, 25 Mar 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918341; cv=none; b=A6YrHuc67vTRS2s9x86UG90zJBSxwfQMtdo9YvlHu84cMA17R6MvC7N3sM6UbFUwtFaKLUV8pS1qcqP9Zx6DFZJv+Fa02uMGH7HduGBduGs4sWdv8D635iRhQDFkSvIP4pRZYFfPgvxyu0JozNJHwFH4ZIn08ifZ9Jc6HlO61ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918341; c=relaxed/simple;
	bh=5Pa2KeMTYBbfP4PheMtf3nFfMp9cm0iq0tk7K4wOOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDGa9Ul6718OOfrWBjaUL3IUml+eJ6vrtO5TP5gI/30P8EKZI+eaj/GfwhLXsNYiNVc1zw/XzXogLtK++2/afqHsRT/6aPrQ0WF8E5hWFBat9tp8XMwDwi0qCAztwSkX6KYT5VzUA/7O7DqAMyVc1r1D+pccneHCK8jdHadPkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQbA1YTK; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so6565774e87.1;
        Tue, 25 Mar 2025 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742918338; x=1743523138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAn0k+129G/lYAogRR6VU4mS8jgZ5heo+yrP5mQ+4s4=;
        b=HQbA1YTKqWPoND7Z1QN9YrPu8vehd73rbCK1OF/mFBGhIuvAT7P3YKgzvjotfrbZjl
         tt5hZsdTkp30x3eFLiyyMir6YR0Z6LXjXNRDWYC9z64YGhuMeDc5TDEzxbO8AKVZ5qCj
         bWXMRu4a78G7jjvKlIGFnqId+EzjOHJaVTTLzXypX56klAPpfL44LhA7OWbSbCWXlUtu
         4qoH02bZ5G4cyYVdUUfFZ/gKVJ8bANfFmbqKX9zT5iXCSJQac5C27GjzyFBG3m/umoLF
         gVqgoEztCkwUCo059xVrKWFB8tmuabVYbMgXRRofnam0c8FgtwJLiLoophY3+V6KBMPV
         Fg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918338; x=1743523138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAn0k+129G/lYAogRR6VU4mS8jgZ5heo+yrP5mQ+4s4=;
        b=NuATRIvbyK04LJhnWDLPHDFKNkE38pS4vvP1I69Oy6RpzraJNcpAMPghkObpxPjdG8
         RmDwZ+UGTvF/XJxaqNPNd/lBM+TDQs/AMzeq2tgT8WPubm/E+iZY+7N8VQYk5tgvzAVt
         TcZuwO0EI37scSYpaLe61hrQs5ziAT6nJqj4Re4TnporuJq+HpViPZT5LfOm24IoGoiH
         ZuQgYri93a0yFqc6ndw6h6HDZ7PYP4XBZwXg8Ra3F924MT7wwfdModXakD3zA/vLXHt0
         goQAiISuOHCCYD4Yatvge+w5lSO25awuDaQkvpP5s6IOQOO2XbF4yfOgivQVpDcwjSiX
         suow==
X-Forwarded-Encrypted: i=1; AJvYcCVIDk3Pq73liCVTyxG08Ayff6cEaImQpUuKm8V6a2Po5ueaDfn7zYKfBScwA+LrgmfQKevkq4SQBPKn@vger.kernel.org, AJvYcCVQszTjifyCBDnTrth+jagkVgsIgRdWSJMYnIzWjGqGlIdTtSWf8hUUedcVfZ7zRy4eB/Z6fq2jLDJNvNkp@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaiQlSYLLRE2usFluscdbf7tU6ws62DH4ndQL7Xx55nf2Ji2t
	t0O3Y/DQ2eW9U1S8qBNLPhvzcyA3WqGFEQaiNjg/3qUvfx68moJc
X-Gm-Gg: ASbGnct5yaH9AFYXhjAxVl/BT/VxPWbWCL2sm6eBhSkOuBnyPeXJzDii7pJuwjfWNJA
	EFhn9XloqedtyPWKFy7AYXZIIJSqKNYUXNRpRxAwIoiKJuiwsQc7i60dlgtuSRF0eJ3a9dfr8id
	hnAgopBEeFUFrUi12s5P1bWKOr/V2CNduuYX2xi9XtrlljuH2vWbIkZ1PwBdwneL1UNNAP18KG2
	eR0ULRbRY2FAqe/lJuF1XoMdGsswRYai01hyu3/JN2vdOy8WROga9yAZOdt4i/jMEOAZn8vj9Pc
	nC5NGuRjJ57PbxZ5bOrI8ILMWRzDgu8pilVnvcq8f+n5cxXzH8zzMEutBg==
X-Google-Smtp-Source: AGHT+IHbUVM9uZLUQY1MpYbYlpt+APtpb3ZkPfUBiPhkDsiHbQugIoIvF5XTmPwsJT7itPCp5BOgNg==
X-Received: by 2002:a05:6512:3d21:b0:542:28b4:23ad with SMTP id 2adb3069b0e04-54ad6489f85mr5949777e87.16.1742918337786;
        Tue, 25 Mar 2025 08:58:57 -0700 (PDT)
Received: from pilotmaintrash.lan ([178.34.180.83])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646cedfsm1544573e87.2.2025.03.25.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:58:57 -0700 (PDT)
From: Alexander Baransky <sanyapilot496@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Alexander Baransky <sanyapilot496@gmail.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Visionox G2647FB105
Date: Tue, 25 Mar 2025 18:57:48 +0300
Message-ID: <20250325155756.703907-2-sanyapilot496@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325155756.703907-1-sanyapilot496@gmail.com>
References: <20250325155756.703907-1-sanyapilot496@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Visionox G2647FB105 is a 6.47 inch 1080x2340 MIPI-DSI CMD mode
AMOLED panel used in:
- Xiaomi Mi Note 10 / CC9 Pro (sm7150-xiaomi-tucana)
- Xiaomi Mi Note 10 Lite (sm7150-xiaomi-toco)

Add a dt-binding for it.

Signed-off-by: Alexander Baransky <sanyapilot496@gmail.com>
---
 .../display/panel/visionox,g2647fb105.yaml    | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml b/Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml
new file mode 100644
index 000000000000..49dcd9b8f670
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/visionox,g2647fb105.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Visionox G2647FB105 6.47" 1080x2340 MIPI-DSI Panel
+
+maintainers:
+  - Alexander Baransky <sanyapilot496@gmail.com>
+
+description:
+  The Visionox G2647FB105 is a 6.47 inch 1080x2340 MIPI-DSI CMD mode OLED panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: visionox,g2647fb105
+
+  reg:
+    maxItems: 1
+
+  vdd3p3-supply:
+    description: 3.3V source voltage rail
+
+  vddio-supply:
+    description: I/O source voltage rail
+
+  vsn-supply:
+    description: Negative source voltage rail
+
+  vsp-supply:
+    description: Positive source voltage rail
+
+  reset-gpios: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd3p3-supply
+  - vddio-supply
+  - vsn-supply
+  - vsp-supply
+  - reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "visionox,g2647fb105";
+            reg = <0>;
+
+            vdd3p3-supply = <&vreg_l7c_3p0>;
+            vddio-supply = <&vreg_l13a_1p8>;
+            vsn-supply = <&vreg_ibb>;
+            vsp-supply = <&vreg_lab>;
+
+            reset-gpios = <&pm6150l_gpios 9 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.49.0


