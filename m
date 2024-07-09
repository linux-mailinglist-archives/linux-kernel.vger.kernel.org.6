Return-Path: <linux-kernel+bounces-245429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3CF92B26C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3791F21EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98FD1534FC;
	Tue,  9 Jul 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGAvct4Q"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0B55C3E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514655; cv=none; b=OhpaxQiet4DBYo243/cnD6N7n6z5IqhbpS3Jm6RjNPyyMseznv5hYLA9iNW5v4/fZbs6ZENFGzsOfBJNRrAKdSiGD6EYz12diaNKftm/kgiJ8B/49RDikxQXZilRVBcWff7mE58ffmjBGoma6RQ+b0pdSfHj23yL8m1G++wEvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514655; c=relaxed/simple;
	bh=s0jvCbYGLEo3OLqinJALPSAC6SagCi0vbWs5aTXRa/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnN/uuhWU6g0LZOVlcSe+rXy9mMBw0EWzAxxJ/3CFAksfI3YHxOoJReSWqX3AYCFUFAfR6BzX8YXS3x57vYiHwpvTKMaW3A8A174KD6pqn59f9p49VL+YZ5Px/AWHqOaSzZ53QdLfcMTF+2a1vrbgC9QTYG2GRKhK1hZ/1qhWtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGAvct4Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266fcb311cso5476745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720514652; x=1721119452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sE9pXbgkh0YhCqY/lhOE3+zughmoMS00TBY/FZhtbA=;
        b=eGAvct4Qe5Bb8tK4yPxBro1AnZAwEoxnglyH0EeHZ8+m2p4OsGYXwn0gFjGl8KqM5h
         Fxk+j/knYDPE27bKydMdtofuAJwnKHDLnL/d6hDf+OcUxvO1z1k5C7LTS1OmX1I3k50H
         TNZk3moDd/HHOtcVBWiAzU2pAMVVmMu8M6pVgMk4thuDySET0qKK9F459PeCJBjlB0Fi
         xFl2qqH4rk69+QWqdFxcfjvK5CSIMJGChEZ7c/eYIhrqqNery/vRqJbhw3g56WtjxjRI
         WN5YZhD/bVrYe8RXMRZVngqiNcDlP4DJiUb5Nkrh7lvHyfqgewbWR7Z35PrNRthS4C89
         es9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720514652; x=1721119452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sE9pXbgkh0YhCqY/lhOE3+zughmoMS00TBY/FZhtbA=;
        b=BNQE5loq+nI3tT4LRH+jJuMdfYA0pLAh/b2L+bITZ+W0PUI+QwZ553NEEYpbwFFxB8
         DGPsCVLu9rB4UOgcGwiJwGRgJPkI9sW2+4e7EdjmdCB+qBHU1mDhoFG8g238BnRlve+9
         SLGLvUh2K1f4OvfEFKj55Ftq8o/IEUknvR3TN7oNvTzoEG/Le1VVGTQ40PsGWxzs4jSf
         4b9rCvSg+j8Xqo4e2ZAU3NMF2CdKIpob04wZQ0R3qxKThVPCT2X6R8odcmKHznEIAOd1
         EpnX3u3wgVYhTNCKIlrcJ62yLC9p85LIMIBWr1tZYypNK/cM+wnHsVrQePZ1Px8oGSRB
         JOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnng8DIjD8+P0+1Q4kuY0/q6GJtvFTkWLkSJmYRlZWpb/pEUZMkXrgnRQi7hVJbwb/4W4FA9H0XElbPOtdGFFALwFhQ4xPusAOC0vl
X-Gm-Message-State: AOJu0Yzjbhl96qM0SDbr41y7cKW1hxSBldbwNTD2JiUNziLGXnUa1Y8+
	1FYw5rkYJeZQp1GN+2kP8DrddL5O88pN58HNSxDioS54FIY0Zq/obmaBgQXpmvU=
X-Google-Smtp-Source: AGHT+IGlzmpQAZpXG1fdqdRDyNaRuDJaOQFfwedBfXiToe6si7x56xbAg6qoaKAOY47lpfmVT2Pe5A==
X-Received: by 2002:adf:ec4d:0:b0:367:9279:c401 with SMTP id ffacd0b85a97d-367cea91dc7mr1353258f8f.34.1720514651725;
        Tue, 09 Jul 2024 01:44:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e1dcsm1889991f8f.12.2024.07.09.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:44:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] dt-bindings: non-dt-devices: document ltr,ltrf216a used via ACPI PRP0001
Date: Tue,  9 Jul 2024 10:44:01 +0200
Message-ID: <20240709084401.21108-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a device in the wild with non-updatable firmware coming with
ACPI tables with rejected "ltr,ltrf216a" compatible.  Linux kernel still
supports this device via ACPI PRP0001, however the compatible was never
accepted to bindings.  Lack of bindings causes checkpatch.pl warning
about undocumented compatible.

Add a schema for such ACPI PRP0001 devices purely to satisfy
checkpatch.pl and document consensus: ltr,ltrf216a compatible is allowed
only via ACPI PRP0001, but not bindings.

Link: https://lore.kernel.org/all/20240705095047.90558-1-marex@denx.de/
Link: https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
Cc: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/non-dt-devices.yaml   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/non-dt-devices.yaml

diff --git a/Documentation/devicetree/bindings/non-dt-devices.yaml b/Documentation/devicetree/bindings/non-dt-devices.yaml
new file mode 100644
index 000000000000..206334693c7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/non-dt-devices.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/non-dt-devices.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Non-devicetree Devices - Exception List
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description:
+  Some devices using ACPI with non-updatable firmware/ACPI tables use
+  incorrect Devicetree compatibles via ACPI PRP0001.  Developers want to
+  support these devices, thus use such compatibles in Linux drivers, however
+  usage of these within Devicetree sources was rejected.
+
+  Following list of devices is an incomplete schema with a goal to pass Linux
+  kernel scripts/checkpatch.pl checks about undocumented compatibles but also
+  reject any DTS file using such un-approved compatible.
+
+  Usage of any of following compatibles is not allowed in Devicetree sources,
+  even if they come from immutable firmware.  New entries can be added
+  only on the basis of non-updatable ACPI firmware on the device.
+
+properties:
+  compatible:
+    enum:
+      - ltr,ltrf216a
+
+required:
+  - compatible
+  - broken-usage-of-incorrect-compatible
+
+additionalProperties: false
-- 
2.43.0


