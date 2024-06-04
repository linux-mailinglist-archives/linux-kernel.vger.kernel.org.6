Return-Path: <linux-kernel+bounces-201104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AC88FB98E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B71B24FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3D1494D6;
	Tue,  4 Jun 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWu7nnPw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101214883F;
	Tue,  4 Jun 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519932; cv=none; b=s4Pi2HuU5I2MHVbWu8sRnNnGsoQ2vpp16ws8ImU2YTQHTx9wXHTKm3feZNCXqySLSePlLPjUbvCupxsXBKYW27LDXW6aicqeCjBqToivmNRpU9Tx3iQj+y5Ezf93bep2WrLkMFw2EeEq8JnVA1rYAfZKa6b4d4cA+koJxsyFid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519932; c=relaxed/simple;
	bh=BELGNXDVAkqqXCc4dLbvmbySgNy49Uo74JyB1/ef4lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmvmAvPwhMa4mkqzvJXgabXPlb//THNpsLWi/tvgJSFK+bC4JO4Q/hal/ZS8y5GwBXBEL3UNGp4Bqf6s8OlK/xaIaUIOF6VSbOEz5gRN2g16PRKW1w/9odW74upW1ecK+n9oTBOZUv0G29cf+VaVSGqp+hxY5RtDBWOH9jQwRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWu7nnPw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42137366995so40026815e9.3;
        Tue, 04 Jun 2024 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717519929; x=1718124729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRulz81tVLUQ7MQwYzOPpqvuMJX0O6/cWDZhJocTjrA=;
        b=KWu7nnPwmhzQDiQu9M4LJ8+9LSlnJ6HSCz9R9/wG5DsHymt46JjJ9svZxFkIpUBbCS
         ke3HrPtzSu+SZbQ2guu9CdmL8gFqeV6IquHySAojpJPosvHHZYGt0tPOoYx+Eu082DVk
         +/Kl5NNkUYiIS4t7J0EUzFqJgetM4rcceH01lMJA5794yZEbm2hOeid3WpARsu8x2KlH
         6vs0aENWw9Zk1SPmo0P9ECVjgHwDfty1s49Yk0HWD81DcUkitPIXFEnpu7gIOgcC40bv
         +X72SaX95JyRulWhE2mvtAGVATMNxFu3kq8sSQLDEbuGz5swBkEAW7ideCNaxDIasmfl
         U76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519929; x=1718124729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRulz81tVLUQ7MQwYzOPpqvuMJX0O6/cWDZhJocTjrA=;
        b=uUmL+4OjqvJZjCmIPABNsyEMwD+9Qip7YxYg0kd23uwuoyPc8zXbYHsAvHoxew1JFC
         mVp4AqNliCXhlAjugoFHbwNxASdzMy7uOS6rUNrz3k2Tj9/qG6BnPA6BSFommtx842qt
         KN3EKe1pgPkppvyEQax3V1dMhUPDIZjK6G/hNwlrClkmrcA8hdgIbwih0XFKYLL+HvkI
         7DOJTpjHUuGxkAkaHVwbtgTjHUgI0S4XNi/eZ50vMkdJ6dKXRv27dBRNV+wNQlGATzkk
         X16EqJmwEInsKlAH11xpb26ziW1+mn+u7V71QbYuNHys9l3lU/QS4ZUFNIyNNkd6b39C
         I5tw==
X-Forwarded-Encrypted: i=1; AJvYcCWBn09DMdijF4WS5s5m6htuW52ZhVJO+zq4gP8BmKvUnjmT6E7keR7dFbeTZyvtgx8aSF2/Jv2YjbH5R/8OGRYyC2FA4J0PbVZU8ZdWQ1t7dC+zMVMjGo8tl28EL/KBUq36XtAyqwfpzMt3yB8bAa7UqJpE3ff/3AbTHJvxO7ENZWV/R02W
X-Gm-Message-State: AOJu0Yyy5WHPk/atWh74BKqh0ts4uHnjvwtUjvEw21CnGo1faJ0JE8/4
	ZNLF+FmloFysIKYeDvY/o8I3ztyX01ttfv+8d6ONRA7itUKtt1DU
X-Google-Smtp-Source: AGHT+IE916y6jLYbgcm2SKAxb3WiMQ4gU1AO5+IVHgSHGmOwRx7XRxY33j54+wTCc2hyXuGJ1W8SIw==
X-Received: by 2002:a05:600c:19c6:b0:421:1717:2cf0 with SMTP id 5b1f17b1804b1-421562df8e7mr2043635e9.24.1717519929092;
        Tue, 04 Jun 2024 09:52:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212b85c61dsm162465555e9.28.2024.06.04.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:52:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/3] dt-bindings: hwmon: g76x: Add support for g761
Date: Tue,  4 Jun 2024 18:43:42 +0200
Message-ID: <20240604164348.542-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604164348.542-1-ansuelsmth@gmail.com>
References: <20240604164348.542-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for g761 PWM Fan controller. This is an exact copy of g763
with the difference that it does also support an internal clock
oscillator.

With clocks property not defined, the internal clock oscillator is used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes v3:
- Add Reviewed-by tag
Changes v2:
- Drop internal-clock property

 .../devicetree/bindings/hwmon/gmt,g762.yaml   | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
index 762779da5ba2..8e1bffd252e6 100644
--- a/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
+++ b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
@@ -4,13 +4,17 @@
 $id: http://devicetree.org/schemas/hwmon/gmt,g762.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: GMT G762/G763 PWM Fan controller
+title: GMT G761/G762/G763 PWM Fan controller
 
 maintainers:
   - Christian Marangi <ansuelsmth@gmail.com>
 
 description: |
-  GMT G762/G763 PWM Fan controller.
+  GMT G761/G762/G763 PWM Fan controller.
+
+  G761 supports an internal-clock hence the clocks property is optional.
+  If not defined, internal-clock will be used. (31KHz is the clock of
+  the internal crystal oscillator)
 
   If an optional property is not set in DT, then current value is kept
   unmodified (e.g. bootloader installed value).
@@ -22,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - gmt,g761
       - gmt,g762
       - gmt,g763
 
@@ -51,7 +56,17 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - gmt,g762
+          - gmt,g763
+then:
+  required:
+    - clocks
 
 additionalProperties: false
 
@@ -69,4 +84,12 @@ examples:
             fan_startv = <1>;
             pwm_polarity = <0>;
         };
+
+        g761@1e {
+            compatible = "gmt,g761";
+            reg = <0x1e>;
+            fan_gear_mode = <0>;
+            fan_startv = <1>;
+            pwm_polarity = <0>;
+        };
     };
-- 
2.43.0


