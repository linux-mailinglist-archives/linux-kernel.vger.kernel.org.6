Return-Path: <linux-kernel+bounces-532642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FEA45049
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D443D3AD109
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45E219312;
	Tue, 25 Feb 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUSOCo5T"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881921764B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522643; cv=none; b=drBVKbZZ2OTv393KKSAO3QhyRxVFARWBy68W7rE0EdAvO0YDBUn887Ohs2/cVzzrU2GHZWJiom6Mg37D6qY7km/RmNpkxDXAQbR0v0stFTqIGXSI+XCcjiG94UZwWbZ2lu4AurU1GlgADvMEP9eiXr0BMAntI/CdZ3K0K889sUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522643; c=relaxed/simple;
	bh=LsqVGCjtMo5lMpVB8FHpQNoTpKeLzijmuixmRj5EbJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEJIZZ0xiO+R9fGKCZe+zmKWJe357mzzYG9gcTBK1c5poHX07mvrJMknDcS+T5wVrINIi/tGA+WXQOC9z3K+DOLND0RKIVYnnZDpb3Oj+/er8aL5q3iaCjP2ug7mtQ3lAQDO3gnScv1Vu+XtCM8dX66poSnGRJ3U+jCpn1a7F7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QUSOCo5T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220e989edb6so169989275ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740522641; x=1741127441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApYHs/n7IfGYX7B4lQQ+p4O3G1a7OCsUKtghlEJmtj4=;
        b=QUSOCo5TMPV7m/c4IaFjN5LLiPUH9ZpqLA9nAIx7iqaZpDPHcWtF1mGO5Te2vGdI0t
         Tnmz96DYETSS8HRiR7nTsFAfFREL5jXY0gus8pJSFvzZKuYTxdV/YtxFbA9GVAJTsoxX
         7sLOMp17vxRU6A5BLb8BwaM6OFD0rVQvAqZ8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522641; x=1741127441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApYHs/n7IfGYX7B4lQQ+p4O3G1a7OCsUKtghlEJmtj4=;
        b=vUgCDRMpPto9PKnEBEcUhv5yYunFh2YqHo/30DUsi02yK6UMFcqd3nDHY+l99VeeJs
         l1svohHobLpCE+SzBuz1nWw/xhbxueJ0IxBU80qW/fSGfeltyeBlWfPRwIkS4jFnoXaf
         tnctr13GvvNj16jhAjeoTSCYIw8iPq1VAQEQvJ9fJae67A7bKjASBl7/ObBBckMPzYQM
         R8c/wntPbIPqRzdb+HJDBXcUjI5iowon1GcLLTENF9go6hozhI1kcuZuX6nqHhA9W28v
         EIugpPOIKNk7wvAhNPyJ0Lrk3O9DRtm4gh5tJWQDNH/TZ0v7ufsi22BozdF5ZfUozoe4
         pHBA==
X-Gm-Message-State: AOJu0Yxhebr+rLwbEnRIcdluZyankl3VZjkNbb5c3kUjRZ7qaMcuiNPg
	MJ5RBR1f1fObv74lamz7UkfaNH8Mip73MtPp52fhJITtXbtlKoGhXkz0EA05PA==
X-Gm-Gg: ASbGnctr3rViXHLcEHKgmikbtqj4na4Qq9kxv9dhaNi6aC4Puc7MJC9Li0ijDm1OC4O
	8GosnOdhvjsDKErLAKcVlTwOd/KWBk2xS20p6Y1uRkcPIfETGBTmy+1QuIg6aqD+OVUQ4AvbNoy
	dIoULznughr9Gq9tyhNuqERbMfvIQJbkdMdUY8jl7XvyfQuVTx+zP6fb8do3BlbY3MsRGR8Ojoh
	u2D2H2zqDHsp5iA8eakHTZ2wpCcBcYZIwnLFHA5OsfMMepdAxc5OtnJdyeoP18tgtDqFZgv2EOF
	kUNzkXaCfr+jz/cLVMlDHEKnqSWdmS+v9YfczIemIh7x4MNWguz+eB+qQZ5NCQmBcQ==
X-Google-Smtp-Source: AGHT+IHW1xqPTBE6DlhH45+k6SdX/yDbLaHBxXJlSInk+OwmjcdfQ4C/YpQmsbuuwHQxPH6RrUiRJg==
X-Received: by 2002:a17:902:cf10:b0:215:853d:38 with SMTP id d9443c01a7336-22307b59639mr75965445ad.25.1740522641460;
        Tue, 25 Feb 2025 14:30:41 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com. [34.125.246.222])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825baa7fsm78653a91.11.2025.02.25.14.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 14:30:41 -0800 (PST)
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
Subject: [PATCH v5 1/2] dt-bindings: usb: Add binding for ChromeOS Pogo pin keyboard connector
Date: Tue, 25 Feb 2025 14:30:36 -0800
Message-ID: <20250225223038.879614-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250225223038.879614-1-swboyd@chromium.org>
References: <20250225223038.879614-1-swboyd@chromium.org>
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


