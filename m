Return-Path: <linux-kernel+bounces-526801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C290A4037A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121613A0F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7992046A7;
	Fri, 21 Feb 2025 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WClf+/8W"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34B20767C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180693; cv=none; b=b/73rWn+GlL8Q4jUnRMvtnYU+v1FaW1lRPPnzm3I7jBf5RhAaNOG1wz40s4VUXhAFqtVzTvdLefMSwDt49nQLBh7h1uoJELaWQG15b9kZPVD/qOmL3YbyQhCG2ofIVrjqFeUjKBQZsTSmQ+g/T/vhPXWd/ez9YXcKqckOJdMj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180693; c=relaxed/simple;
	bh=LsqVGCjtMo5lMpVB8FHpQNoTpKeLzijmuixmRj5EbJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnLyDAvS/fRfDTPnGnCAibu9IBOp5GhruZsnJxbo0BhUiE/uXYly4cb0NGMFXSW2gqf0lSh3aJckZ8AlIO9iDIezQINkYLGmAwWtqrLN3nDtfRAOrhwYFfURT8GfSQVxUiMTWaZnPzOwFAc5+tVBuviJ0/S0GixPcDK2aaU7Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WClf+/8W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21c2f1b610dso76388215ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180691; x=1740785491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApYHs/n7IfGYX7B4lQQ+p4O3G1a7OCsUKtghlEJmtj4=;
        b=WClf+/8WYSrQFspbYRX+vspu61ttzC7AeBm4QmuPfA/8B2DJe9yxgKnNHysqd7MtRO
         dLc4EqrYjJ8NrRWaKVokMwRjX9qMkYa528v+Vrx2LlWp9UJSQuupGOq5UynOFvzNsJ2r
         wadoN46oOpKqZwirsU2HyRMCNsujyhsu3048Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180691; x=1740785491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApYHs/n7IfGYX7B4lQQ+p4O3G1a7OCsUKtghlEJmtj4=;
        b=tpDQcO/0ZmtrAJ3ImpWv/BIzum7cVMFKOHxjU7k/aTc09w2yTC4sls89QrujuP8xKR
         FiuiYCT1vLBen24hZ3CKgCGfDkb+0P6qUO/eZ3qT8RVB6jjTiYrRyGERVPsdD9zETfM2
         2pMVZwyVCGSd4dHZTce03B1FHpvjAQE4GddQrVjHSRKpZZNffQxDq5pVWU5uGzGvRI0s
         az3axuMN08ze0/5iANPTRQER14ZujDV9wWPTbL+1YQRhsgscKBpnDSUQiXWLAItib54K
         IVolHz3bmEisRjwMXics/92EcOjX3iKJlGohQgRyXbXRUErKVscn1otVrfzzXKG0NbrZ
         2KOA==
X-Gm-Message-State: AOJu0YzWZ6paJRYNCDkKFZJ6/yMdixBh9NxcCMDPrwleQuSTwxKgci/2
	6eLUQX8W5jwt7sQjQt9He+HI1EiKIHx/JmaJKThVHWk2eCOx+2K8lDHjd+rFKQ==
X-Gm-Gg: ASbGncubGcTZ7NGF5lA0hXZiX1514EsDBa/A127E0rnEsQeA4gtU+mvOdMQBa2THT5J
	wGdajnH12X/3behEHHL3X43EWUIXpFtKR8xD+t66OE0Uq4fIcajpKrLKzkrVMNZprxZbZBu6x+/
	v7OtIyhBbFSrAZJChY8ZNgBhM/8PujwuMmiV2fwGQ1sDben/ekLmqwz7aLEF0Q/rfcklhQH2ER5
	CwGgyaNZszlGVHT+SW2GsLNFSmmVVIcjxnazdpbnSvGA9Ip7tKRhsv4dG8bEMuinDR8EH7DgHBo
	7/rLrB4Cl5/cHAGP4ipx4ZkawcTveA25p+C+r6EwiDpAfwD9tKzc48Si4OXEfN/46g==
X-Google-Smtp-Source: AGHT+IHTYhgMmZwtQMesyuqCsfU3X/GUFToquzYJeUC27Q625wzMr9+Lzr+YQe6mF0JuZ2Y4qKGonQ==
X-Received: by 2002:a17:902:ce05:b0:21f:baa:80c1 with SMTP id d9443c01a7336-2219fff2c88mr84742995ad.53.1740180690972;
        Fri, 21 Feb 2025 15:31:30 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com. [34.125.246.222])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d55b6ab7sm141979245ad.132.2025.02.21.15.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:31:24 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v4 1/2] dt-bindings: usb: Add binding for ChromeOS Pogo pin keyboard connector
Date: Fri, 21 Feb 2025 15:31:14 -0800
Message-ID: <20250221233120.3596158-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221233120.3596158-1-swboyd@chromium.org>
References: <20250221233120.3596158-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the set of pins used to connect the detachable keyboard on
detachable ChromeOS devices. The set of pins is called the "pogo pins".
It's basically USB 2.0 with an extra pin for base detection. We expect
to find a keyboard on the other side of this connector with a specific
vid/pid, so describe that as a child device at the port of the usb
device connected upstream.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../usb/google,usb-pogo-keyboard.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/google,usb-pogo-keyboard.yaml

diff --git a/Documentation/devicetree/bindings/usb/google,usb-pogo-keyboard.yaml b/Documentation/devicetree/bindings/usb/google,usb-pogo-keyboard.yaml
new file mode 100644
index 000000000000..053c1cfed6d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/google,usb-pogo-keyboard.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/google,usb-pogo-keyboard.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google USB Pogo Pin Keyboard
+
+maintainers:
+  - Stephen Boyd <swboyd@chromium.org>
+
+description:
+  ChromeOS devices with a detachable keyboard have a set of five pogo pins that
+  are the typical four pins for USB (D+/D-, VBUS, GND) and an extra pin for
+  base detection. The detachable keyboard is a USB device that connects to the
+  four USB pogo pins.
+
+properties:
+  compatible:
+    const: google,usb-pogo-keyboard
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Connection to USB2 port providing USB HS signals
+    required:
+      - endpoint
+
+patternProperties:
+  '^keyboard@[0-9a-f]{1,2}$':
+    description: The detachable keyboard
+    type: object
+    $ref: /schemas/usb/usb-device.yaml
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    connector {
+      compatible = "google,usb-pogo-keyboard";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      keyboard@2 {
+        compatible = "usb18d1,504c";
+        reg = <2>;
+      };
+
+      port {
+        pogo_connector_in: endpoint {
+          remote-endpoint = <&usb_hub_dsp3_hs>;
+        };
+      };
+    };
+
+...
-- 
https://chromeos.dev


