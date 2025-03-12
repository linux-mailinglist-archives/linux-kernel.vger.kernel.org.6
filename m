Return-Path: <linux-kernel+bounces-557552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C8A5DAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13381890700
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F8723F36C;
	Wed, 12 Mar 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQPrXnrk"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FB23E34F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776237; cv=none; b=GdaB90oCnWjmd+IyhGXNvDbiYnFTWpKNhAY07SIfhmUewgNaLb2O3/LNIJk4HaevYDCr9yk5oz0SiEsrafJs7Q6pPFalR//1YccNMHWnSp0lgZQU3bMwuHp9qQC77iLQO7H9k5Zl97MtxyjJn7z2pkJppPosvrbN2NHCHvtW9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776237; c=relaxed/simple;
	bh=3DmkBeiH+EVYQGbZv+HVXY4sUC3b266LNBE6ycsAuV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/lZ4up+v6FiraTbQM252gn2chqhmkGpV7WcPHKCMYFPzic71Gd9B0UBUhas+Teu5um57mGMVQkSajugZSN4c3vS1+b+Is/8CQlTRs6OcfTZmF2vpQbI/nix1CYnmEAK108iu5lBfkPEKvk6aJRK8q0hMzohFf0aXnLL99HQqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VQPrXnrk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso9900841a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741776235; x=1742381035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1sMzDBP5vuN2BAfvXEAvEWElSEvZrTJL7A1Fg+i1ek=;
        b=VQPrXnrke5aU53sQy//AONm+nq809/wtDpWLQIqTKPTSTr5pls9koC3Bb7XVAuNSoN
         PSUtRCeWFOLy75qlnx0uIyYxKDyy4IuShbHffYZGx3KR+xeaj6fnfzcKLxP3KrI4U8Yf
         PDo0hmQI4J9STpCDMaMsNxmI1tj6KoWuVdh4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776235; x=1742381035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1sMzDBP5vuN2BAfvXEAvEWElSEvZrTJL7A1Fg+i1ek=;
        b=Lc3V5HteLioFMBElEsFi+vbQb9to/Vdzu4JLqgujlRPyN2cj4+jPfwmDvGsEjhTJ3h
         BZiKp+78PDLifREY6QEs4ovpStfU0ek4rAyu4cx2VLASdZTOqo5Jy+CDoZb+9EN3O7Qh
         dSqFjG4yRP0Nw1wUZto5zMW3hIDPNjd6Q8rEoB86YilCGxkya7Kv80/PFsA22vh5E7xQ
         PWDaLyY4XdWmyEoJZqg7GNPKQYNfvohiPn51+Ooj+h6PGjSDrlf7OuZ5c8IKkghcVAJv
         7J8wgwFbXV0Ps3fiK1upLChhGZt3Jypvol/ZmTGLVSWmOvssnL+9KsbtMZ+yKufyj/m9
         QHug==
X-Forwarded-Encrypted: i=1; AJvYcCVEqIGAUf47ATKLOmqn8mV7xpIWu9i+aFslgFwWcJM8ezwIwDlrqfVFNAHMUNfk35AcqOD7AXtIE8sHn8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPJ6CP3ojN2TDLSkOxiKwQaKe7+IOTWPmtJWqwqe8EGmdVdMx
	AIirdz30ax3yNyE1j1BHcAEiErNFRiCpPaZlbNCFh/bEFHqvsTC9Jj9ydwGzwg==
X-Gm-Gg: ASbGnctIUNsR0rfWv40lVomHpSH7dSM9PHFrH5gQoEnQbppo6FHIJqaDM9Wmocpy/fH
	wArdzhrYH87oTUg/RWc+K+7PdPh2ntyF0xLHhF7g5Nb/BCEvnrWdph9q9T5/VPhG9lQe7rNGAqI
	rnkA0durPjq4lS4wSoDg2eR48ww4jwoVsZ/lunfUvZcFshiPil5SQIKygVmtdMg5m1mWfs59RQO
	Xlbu5sUVy6BlNApAFywuAwNdm1mC9n44T/XXJdH1wArl18d23FvxAzh42srsKssWzNHJxgiD5Ve
	jRjfajFUUxApGCuW9C0U1GjhwoJm0koDCr2Qd/frIH21/jwslUWHtazIKSSrE32xXC4cwGjC1Q=
	=
X-Google-Smtp-Source: AGHT+IHVXoxHlRkSlosQqT/eYj9vz6fvVJZ92k/ncUOz6qh5Nk9iYgHkhQ9d0PdxTZIJWqbKDgo8qA==
X-Received: by 2002:a17:90b:2d83:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-2ff7cf22df2mr28755341a91.30.1741776235345;
        Wed, 12 Mar 2025 03:43:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b5ed:b71c:fb14:a696])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011926599csm1405675a91.35.2025.03.12.03.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:43:54 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/8] dt-bindings: HID: i2c-hid: elan: Introduce Elan eKTH8D18
Date: Wed, 12 Mar 2025 18:43:35 +0800
Message-ID: <20250312104344.3084425-2-wenst@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312104344.3084425-1-wenst@chromium.org>
References: <20250312104344.3084425-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Elan eKTH8D18 touchscreen controller is an I2C HID device with a
longer boot-up time. Power sequence timing wise it is compatible with
the eKTH6A12NAY, with a power-on delay of at least 5ms, 20ms
out-of-reset for I2C ack response, and 150ms out-of-reset for I2C HID
enumeration. Enumeration and subsequent operation follows the I2C HID
standard. The eKTH6A12NAY requires longer times for both parts.

Add a compatible string for it with the ekth6a12nay one as a fallback.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bindings/input/elan,ekth6915.yaml         | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index cb3e1801b0d3..81c391952ccc 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/input/elan,ekth6915.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Elan eKTH6915 touchscreen controller
+title: Elan I2C-HID touchscreen controllers
 
 maintainers:
   - Douglas Anderson <dianders@chromium.org>
 
 description:
-  Supports the Elan eKTH6915 touchscreen controller.
-  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+  Supports the Elan eKTH6915 and other I2C-HID touchscreen controllers.
+  These touchscreen controller use the i2c-hid protocol with a reset GPIO.
 
 allOf:
   - $ref: /schemas/input/touchscreen/touchscreen.yaml#
@@ -23,12 +23,18 @@ properties:
           - enum:
               - elan,ekth5015m
           - const: elan,ekth6915
+      - items:
+          - enum:
+              - elan,ekth8d18
+          - const: elan,ekth6a12nay
       - enum:
           - elan,ekth6915
           - elan,ekth6a12nay
 
   reg:
-    const: 0x10
+    enum:
+      - 0x10
+      - 0x16
 
   interrupts:
     maxItems: 1
@@ -58,6 +64,21 @@ required:
   - interrupts
   - vcc33-supply
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - elan,ekth8d18
+then:
+  properties:
+    reg:
+      const: 0x16
+else:
+  properties:
+    reg:
+      const: 0x10
+
 additionalProperties: false
 
 examples:
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


