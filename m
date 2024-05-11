Return-Path: <linux-kernel+bounces-176417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A18C2F91
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D81C214B6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E142AA2;
	Sat, 11 May 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqU86ciu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB747A4C;
	Sat, 11 May 2024 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715402563; cv=none; b=Me1xAmacq0QQzNyNcILfxgsFOMWkUr+cfBpSbUU5PJWwx+B1kxVT+DAl7trIZyrfARxAad+X7m1K20vliCYHAl3jReu0vtxCGHuhuGYnqvnQ45Eb0wysbqvsdww0RUs7gOY+HZbfBxnHaUk900GyFkSH1MrbgPTzL03hhLxl49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715402563; c=relaxed/simple;
	bh=WPQTnFx4IHDSM1p8MbRIEMmnd6Js3m0S6fsdKO7d6iA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bGrQzEIPa3YiUai/L5TMAgGinTIvaGvR95CHpZEcnrnVroXZNJ8sYaoABMKB7e+XGIJJ/nbeFHezBD8jA4HU4QK0AnyLWk+HFFbZHE5OThOi0qRmzFYpeiRVOBYjjx+cqnnLPJyG4dMKXMD/FN2m1Eh0DHA5habNe8vw+O2yA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqU86ciu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f45020ac2cso2246300b3a.0;
        Fri, 10 May 2024 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715402560; x=1716007360; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSyZLcJE9KK8ZnIuIgfVwNv3Op1D7Z6QDEYK0ydcmS4=;
        b=XqU86ciuvv5UyKFsfzhCGwsu87zZAU8LeQGCi2MTEMioCjou9ZsFqNhEaFOZaxn/wG
         pBGaZEPVvBRM2cO1xvkngkQ1Ll4rdJYMN58UiuhrAN/Cunc1OM3P+fPWAFpk16LWeBfq
         GpEQaJVMvBDNi13qweADCQMeyVl3JtWtudS0worC6A/4RNr8YcPjMb6YXexFx5/GTb1K
         dRVYIsjyYmV83YGq/U1ng47Hh1YeM71O+y/URo9cfqNyVdSzk/g1+5e8MNctvOowwYvQ
         7DVyjeSdNCYX/0AdrdcNO1NOGN/016HG0IPnNcx/xYf1797m/LTXO+Z4lQKsFgaHMVRE
         4sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715402560; x=1716007360;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSyZLcJE9KK8ZnIuIgfVwNv3Op1D7Z6QDEYK0ydcmS4=;
        b=MeangRxAeD3kO8cDG+FcMx4qVmMfruhAedkHXn42/Q5tCJiYa71zNOY22uiKVKFcJF
         sxmWLWKgk5tf4bO/Z0Mx/muQHVG+iobLj1wkZ4MPlLL6/rZiTZQ8sUD8SzT1RgZYuYTJ
         c55QgdZvZ0PNG4XSXDmrVluduFJj+Aax6bDvP7AlhGSgwew1CtLbiW0Sx9Mvv5sp07mC
         cMmQD1Y+/0nDApEJ/7XpE6NzUEwgjNE/p80YNPBIDsQJa31yIqRZratjn0UPybtT8fxJ
         Cyrk5ELo51HPOyOeoOKvjR78Hia+I4/+Gc3EhkSUfnl7VzZXWCpesspEf95C1dj96VjD
         Ebqw==
X-Forwarded-Encrypted: i=1; AJvYcCUzQdzLwxUV39n9aaZPoQReoDBHVCutlLX2jLdStKS8yfA0LT8S2FIHKJxlzcLvNFxFXO3Jk0jf7IOUQggOYUmuoxIxsyuBRjapkfXHAXNNApbbdRlYNYZE6hRt/+rTM4DEy18OSmj3nw==
X-Gm-Message-State: AOJu0Yzdn1hh280jpIhHjyC9maJsMwlQdEzkCBzeCItpDdfIFAuZ7RVL
	TzBUqkWJEx/6IDnCzcj+eHMdr9ntgmS7GQb8SwSAlNOGc6TfGcJwPw9Atjdo
X-Google-Smtp-Source: AGHT+IGIU9YUzzt4L5YVBwXqaHR+qjWpl9nkrHdKYdZgHx5c9HbVadWk5KHj5Sr47W0quDEc5CbyEQ==
X-Received: by 2002:a05:6a00:3c91:b0:6f4:74b5:f536 with SMTP id d2e1a72fcca58-6f4e03e7fabmr5229271b3a.34.1715402559853;
        Fri, 10 May 2024 21:42:39 -0700 (PDT)
Received: from localhost ([115.96.146.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2ba4sm3708928b3a.168.2024.05.10.21.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 21:42:39 -0700 (PDT)
Date: Sat, 11 May 2024 10:11:24 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, javier.carrasco.cruz@gmail.com, 
	skhan@linuxfoundation.org
Subject: [RFC PATCH] ASoC: dt-bindings: alc5623: convert to dt schema
Message-ID: <j2f5m3lydlkipt3vnyikeoq5bx6tsf6z22ljpspcgtnohy65on@htyjjd3ojkde>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert Documentation/bindings/devicetree/alc5623.txt to yaml.

First attempt at a dt schema conversion patch.
Checked the yaml file with make dt_binding_check and make CHECK_DTBS=y.
Only warning being produced is
Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
Not sure how I should handle this.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 .../devicetree/bindings/sound/alc5623.txt     | 25 ----------
 .../bindings/sound/realtek,alc5623.yaml       | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5623.yaml

diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt b/Documentation/devicetree/bindings/sound/alc5623.txt
deleted file mode 100644
index 26c86c98d671..000000000000
--- a/Documentation/devicetree/bindings/sound/alc5623.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-ALC5621/ALC5622/ALC5623 audio Codec
-
-Required properties:
-
- - compatible:	"realtek,alc5623"
- - reg:		the I2C address of the device.
-
-Optional properties:
-
- - add-ctrl:	  Default register value for Reg-40h, Additional Control
-		  Register. If absent or has the value of 0, the
-		  register is untouched.
-
- - jack-det-ctrl: Default register value for Reg-5Ah, Jack Detect
-		  Control Register. If absent or has value 0, the
-		  register is untouched.
-
-Example:
-
-	alc5621: alc5621@1a {
-		compatible = "alc5621";
-		reg = <0x1a>;
-		add-ctrl = <0x3700>;
-		jack-det-ctrl = <0x4810>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
new file mode 100644
index 000000000000..207386e6d437
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,alc5623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5621/ALC5622/ALC5623 audio Codec
+
+maintainers:
+  - Aryabhatta Dey <aryabhattadey35@gmail.com>
+
+properties:
+  compatible:
+    const: realtek,alc5623
+
+  reg:
+    maxItems: 1
+
+  add-ctrl:
+    description:
+      Default register value for Reg-40h, Additional Control Register. If absent
+      or has the value of 0, the register is untouched.
+    type: object
+
+  jack-det-ctrl:
+    description:
+      Default register value for Reg-5Ah, Jack Detect Control Register. If absent
+      or has value 0, the register is untouched.
+    type: object
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "realtek,alc5632";
+            reg = <0x1a>;
+            add-ctrl = <0x3700>;
+            jack-det-ctrl = <0x4810>;
+        };
+    };
-- 
2.45.0


