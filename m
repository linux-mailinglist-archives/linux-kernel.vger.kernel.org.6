Return-Path: <linux-kernel+bounces-574874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA0A6EB00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAFD47A3F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E6254846;
	Tue, 25 Mar 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV7A77AN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A619F42D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889775; cv=none; b=QK0CDpWxNrypcSLUsxZ0vmXSEWiUNX3TDJOh3+YffKlS6ohgI0E3rCr2yZXjkqk2tG27eHrq8g/f1jW/YKMVJ8CRn7RapAJ46dZo3TFmmp5C1mJMPIDJsLyeNUttcywL+HR58HWFaQalfXyH8zYRJiAMyhb3iP/LcAP2sAA3w3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889775; c=relaxed/simple;
	bh=SPqlnkjtrS5DVFkshdhSurAaxj8Nd6Gmu/f6A5AIxGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZ123MjHToFRkO17q2iGa9EqTbp3E0ncNBsgX+OQfNJJgoTRBlivoT9LEiwA9chFia91Ilt6ij7SOqLGsnqhlD09Pc69XyIrFiDuZfQ+6GHac3GfVSx7FFmUoviaPGVvw1yQF0ULvMRUXkpwkhIE0RSSZxjbv5UV9WK9EPCEsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YV7A77AN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso806977066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742889771; x=1743494571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6hGtk8l3NJ5m0ZZ1f8dhJbnrFpOfREyFqNdfBX5qs4=;
        b=YV7A77AN2QHRQNEzMUUVL0ODg5ykfLN0b47U3KqnmW9sRxT1LWAxLiXI25VspD+v3U
         0ycmGp9M1lMT8yjdZ9wL6hIBR6heeONo5sdtieKqSNMnv+BN5ogclbn7v7O/+so3675Y
         gCY0NGULa/K4Rv0Rd1Sl3F6S8I5actofcSqPC67XpcbPjqs0FmXcfLJIfuJsuKAw4QSi
         zZyToiiygdKtwJvA9NxEUGdVNajd1hMeLIUG7+DjpT/ymmcSc/itAeITNZvt88QUT75e
         42UrLlVoHObCbNoEW5+EdLQZRWZcf8ftxZkzH245VR9EX93sKifliTDFJMT1C4VHCy+l
         LzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889771; x=1743494571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6hGtk8l3NJ5m0ZZ1f8dhJbnrFpOfREyFqNdfBX5qs4=;
        b=bTlTtwI13LP0PlusX2ltnHMckTK2EMNGGracrKYDPylYydEH69bTJ4BusPdFm+oaIx
         ECeJx9CaiZDGejR2jLo1ullxDobk7+eM20uw8kXaXJ7syP9vClKvYwms2T+XJGgK+9Wb
         NAPgm54AS9iYKAkOMK+2RkE/9X7gE8Ocjn42F4kt2q1pLtHvQWjaigd0FhuSe4hZROlI
         BqS6ywkYy1i3PRDwjXs8Os+ITgGX1VhjdoVYC0IMpL3p/K/ouvOGTdAlFJ1XP6KgBfTn
         uH8N/yu7Qs80kDDyZRMDPvNu/eTapOJc3BqHBbACnAXL1Na1ElXwe9sSQgoT1F24DnpU
         nOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2z9PdJnqv+IP7UI4GvRgP8CP3RbntUYOWWf5qaBtuJmkAqQAJBaMnKyPAbdiFu5gBj/cmYzMZ8v2qcgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfJkMPVfe27/Oww3Zmohfko2p0PUcU4NSIBMzPMaKzcOSTnTt
	G+ZGxMsd5yRtU4ZkNzvslScj/+dzIyKz378V3bHH1qd+XyAV1rIYjEU4vgoEPVG3s82kthW4tLY
	BLqQ=
X-Gm-Gg: ASbGnctdebNDhfxKYmjh8XZJLQBxxRmppZ+vgEVzkzM1AEaTrLya/1ItXfwSAM+exft
	EFw51bkSgilvDu24JV83vq5QvzqWulA0yqJZCXXgt8VuYVTDrbx8EDulrWcUSrmGIkZkIewtSx2
	0n5KZ0FSH4u4UCjRkXF1HQE/wCzAZgLKjCNcsp0rzzZ+weUd5sIdm0K2jTwKeUE7ji5kThw4t40
	Jfh8X9gPgFb7PSKKMDfxdZsS7/ggVeFgDZWnbs5RRfC+3oYqMk0nHbOhIRdWF6duM+m+BL5uV9L
	2EO+VdAlRiWvkT+3H2m6YuCBOy9Fnvn8pMtJBtv7vxYsRVfbp8qaFAKdyDTnIxt6Ex9Ak7pNDgp
	o9yGL7cJmY2fM2UXEBENHTXCMvfXd
X-Google-Smtp-Source: AGHT+IELkDVeKZ6AufhA6lJ7MjzTQsFQ3gFzAB+1T3Pvd2jU/2VAFg84gQd/PIk9YF8+lS/h85MrWg==
X-Received: by 2002:a17:907:cd04:b0:ac4:3e0:7ca3 with SMTP id a640c23a62f3a-ac403e0a6c8mr1292664066b.18.1742889770672;
        Tue, 25 Mar 2025 01:02:50 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb004fsm7446785a12.40.2025.03.25.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:02:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:02:25 +0000
Subject: [PATCH v5 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v5-2-69bd6f07a77b@linaro.org>
References: <20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org>
In-Reply-To: <20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes its storage module (NVMEM).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
* drop example as the MFD binding has a complete one (Rob)

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1e3bd4433007341a11040f513bf444866b9e38a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/maxim,max77759-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 Non Volatile Memory
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The MAX77759 is a PMIC integrating, amongst others, Non Volatile Memory
+  (NVMEM) with 30 bytes of storage which can be used by software to store
+  information or communicate with a boot loader.
+
+properties:
+  compatible:
+    const: maxim,max77759-nvmem
+
+  wp-gpios: false
+
+required:
+  - compatible
+
+allOf:
+  - $ref: nvmem.yaml#
+
+unevaluatedProperties: false

-- 
2.49.0.395.g12beb8f557-goog


