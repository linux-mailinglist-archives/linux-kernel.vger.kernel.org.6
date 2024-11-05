Return-Path: <linux-kernel+bounces-395923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD69BC50B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF762815E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49AB1FF5FD;
	Tue,  5 Nov 2024 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ateP6/u8"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A81FCF65;
	Tue,  5 Nov 2024 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786065; cv=none; b=BS4FMyncDo+T6UFJxRNb66iMfIJi1UwAQdkGiNuK1WenOkrXlOPBt9PzoJXPv38KtuloKl6csCg+zpL6/5H6SUo7SIllmib/vTZwfbMVkfPbJ6R2KAurMDLtFhTkWNDMiq9OHQh3BW3MHFOVbUA5oh/MsR5yN/KY0Z8stVFUBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786065; c=relaxed/simple;
	bh=T0DAr6FcgIxgmRGTofKbibKjlCJ4Ihxg4cSL2NvEjzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEnZ84+peqUJae99eS3Uyav42z2mao4NKzPQks0I9eNnCkJ7o2l/seYrdgF7nbhL+tibBzLbn2N/tN+R0yjrxI+G2FxDQ+d1INYrOZJVr0GZSjdzHqEcrTB4lwQDgA4ZgETXwt3OYegegiDjhTELGtbibSRqRg0465mhVN4A1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ateP6/u8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c8c50fdd9so39793145ad.0;
        Mon, 04 Nov 2024 21:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786063; x=1731390863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu3iWX+PIdxCmyj98z3UhWO9EwBSIx2b0bruUc7U5YE=;
        b=ateP6/u812q3VAfggAf8d0yS3BlVa1RdmuaHH6KwOiYOxVkZ4Dlyxi+Yuz+XQ/b3MB
         K4n+tDwBiibFaQyzOmYK4dZM1rCdNrB2Bx26InXeJOqwCrU/jiydIz9cmaS3R9WeTeAt
         Esn+RTLATlJ0IMVozc6wOpTrFaF0SLfzlmV7R2qFqw6LDy1KtfoSFzP7p2Gf9b/em1n1
         WFPwoY48qeIpbABJQAkh8Liz87deZGY0K66MnNnY7iTp5XUm0cmhgLXNuQcCYaag+aUh
         +hHNYRsdY255UX6fGGbPEhahCXL3slDgvuwXVHygPYa2kDXb1RZVhjWIijCfD0z6MmHb
         967Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786063; x=1731390863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu3iWX+PIdxCmyj98z3UhWO9EwBSIx2b0bruUc7U5YE=;
        b=luzFGV2NPuPjjfMhRggQ3hCclpJj8pUsTi7Zv9iqwfWWDl43Ytmlyhtxg/DxwZ2HFl
         5U4QcwOunWCuhFACeaDQkqbLBKhR5v3YIut5irroW5stJuyaPL+CVcmQ+1rFB1lM/joz
         G2KtfulEDNXbbgi4btObk2FCv3jfG0Iw/rc3legh0P8h422yAIeINy4wfxxIMdSTPRlN
         jYAu4RhrnBIkL34GFn+jM/nFKu6uJoLeN50ZbyigrJOJqwr9jBtC3ldfd04MQLzhMPsx
         PN5NAkCjxm7X8xS33QuOu8+PIcovYelStm27Vtc7EzYYBouNLLjOXF784Eq4PzbVUZGq
         FRBA==
X-Forwarded-Encrypted: i=1; AJvYcCUR1U38Carfvz1D75E2y+0ne27NtRCD9Z/PLk/WPAf9oycXLb5cx4wyEDv1Dx50u4SGm9vTdZXqbz7r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bNhkZoDLM47siUuOKBNOtHEaylHt8Q9tztSoQmLQfU/KQBy5
	uPst0hP4qgUcaTZ1LsGdkX1mbgM6lumTIT6Ov8nyGPsvTZRAQ/6zf1RToMEQ
X-Google-Smtp-Source: AGHT+IGfCrkf0dN1Ln9SRnU0x+KVoSzW11pkwrRaxrJSTLgEAs+ITuPRBxd3yW0Msiz23lQ8nisieQ==
X-Received: by 2002:a17:90b:4d0d:b0:2e9:3056:71dd with SMTP id 98e67ed59e1d1-2e94bce054fmr22580242a91.7.1730786062957;
        Mon, 04 Nov 2024 21:54:22 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:54:22 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 6/7] dt-bindings: display: panel: Add YLM-LBV0400001X-V1 panel
Date: Tue,  5 Nov 2024 14:52:34 +0900
Message-ID: <20241105055239.1577275-7-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105055239.1577275-1-kikuchan98@gmail.com>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YLM-LBV0400001X-V1 panel is a display panel used in the Anbernic
RG40XX series (H and V), a handheld gaming device from Anbernic. It is
4.00 inches in size (diagonally) with a resolution of 640x480.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../panel/anbernic,ylm-lbv0400001x-v1.yaml    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0400001x-v1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0400001x-v1.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0400001x-v1.yaml
new file mode 100644
index 00000000000..68e1a705469
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0400001x-v1.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anbernic,ylm-lbv0400001x-v1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anbernic RG40XX H/V (YLM-LBV0400001X-V1) 4.00" 640x480 24-bit IPS LCD panel
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
+    oneOf:
+      - const: anbernic,ylm-lbv0400001x-v1
+      - items:
+          - enum:
+              - anbernic,rg40xx-panel
+          - const: anbernic,ylm-lbv0400001x-v1
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
+            compatible = "anbernic,ylm-lbv0400001x-v1";
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


