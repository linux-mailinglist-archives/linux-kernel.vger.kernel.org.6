Return-Path: <linux-kernel+bounces-353362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C886992CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5451F21149
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E11D3631;
	Mon,  7 Oct 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBkAR9ll"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACA1D359F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306894; cv=none; b=OHg3xl1W+5ozNEyr9VHXErcBSdBTddT2rQoFJjkHxKHry/T1BfLxT4/yB4fqMmBvTan0pNY9BQ/P+z6Z0VkN2hq1Rfwn5mPaxJbw+UtzPmn1mFfZ8+pZhDtqutIJPVXNTxLmsKpoQYXNUu8BHCAxQk34FmWG/pioRXyWpclhB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306894; c=relaxed/simple;
	bh=H4ObjvN0nM/3v8VDUiTn+mUQT+EEmB8rYxi9I1hNLKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppUyHpq4qPis8+yHOWWYdUkTP6cHvE9UeycapaXcVNcjXOUvHk+y9hUqjgJ3mymu10iJPRHd7SY7ZhSMRe0sfispYN3UrdrM/8mQV3PkwXwbefcFx0znvjDBcWBNprnUOewyNm6K4OpSHbhreOw1fKM9wEA6WUWR62rym+k/rUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBkAR9ll; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so44789815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728306891; x=1728911691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CCZJJBtK8atSax2d7TJ7ZHIJjcc9DRIi9nr/S9f1lc=;
        b=aBkAR9llH4T1uSWD5V7LqwpuCjsPE7/rqUvfswmJLgCfELsW32mASzUWFtdtJ78t+O
         Xpu6jdOBxrELbzHiS2E4UqO2VsoSeU9vTOUa8Ql0yystvwKTDX3hv9cqjQaWM8ilXk/V
         qLr6dg7esrg7X4VkuMO80CVciQju+ZyUaXCz8FhN+K7FP5ELbN4QzB9RzDmHqKcbhqyq
         v+bQJVWqR2NkOs0/phl/d0qD31tLdDBchOw98yar0XRUvk0VYhqLy20fZdEtOmYzW8nl
         30M0L8OA5QsbP7Q+cLOQIanLUUbNmXuFHTzOFKUZaspApguTkIlR9mw3V9/AoBZA9VWc
         ZWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306891; x=1728911691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CCZJJBtK8atSax2d7TJ7ZHIJjcc9DRIi9nr/S9f1lc=;
        b=XjPARvgjKGqVVREpbeIwzWv7Dn7OwWXShRXVTVAwnohDEu59ODmtqElumU1SX7oPqs
         6Ft1a1DJXz4P0GwU8gd5xLTDgpY47dqsuiEHJ4pvRSAmCprzTuG5IHYpvFG6s8qctIcG
         Q7C50LBdv+UjbwJ1hDZpc2LHozCzsrZyRfJUkdSmVThBkPJmdD5XetTV9QvAYjP8Wgaz
         Le6MLitksWbqZu3lgQLyNrdEq3LtAsdZGyCGMgDTlgnQM1P9XQqOukmwZ/0oxUhUFBkO
         YAuZIKl67wzAMdmARNhgrlOWdhmqeZFIhqbvaWneYJXn8Olmt3aZME4NJq317F9e+OEW
         QvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd3Jxk10SdHzu8fIJkSx1amoRuTJZE7VzyyneCy8fwxSTzDczJb/8Jfuf91o27ppHOw591OjCFCJ/oGZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjLRxp0Wo2tv/syLhRyzShJ0qdQ5lqCnJiVvdL72Tz6wMX1SyF
	Vwn4zIl47+fYB7rYoD6VDLQjZmqJHBGA73NZq1qUQwhQRMw54Gf26qeTHcuv3jY=
X-Google-Smtp-Source: AGHT+IFH8mT9JQ2UhUQAKAdjDiD6vIiJkgJvhFkZk6WbJsQEr+WF0X2sqF18a+jXLdJiblvS1B3Xhg==
X-Received: by 2002:a05:600c:511d:b0:42c:b22e:fc3e with SMTP id 5b1f17b1804b1-42f85ab86d9mr78582735e9.15.1728306890898;
        Mon, 07 Oct 2024 06:14:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec6396sm73916475e9.30.2024.10.07.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:14:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Oct 2024 15:14:39 +0200
Subject: [PATCH 2/3] dt-bindings: iio: magnetometer: document the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-topic-input-upstream-als31300-v1-2-2c240ea5cb77@linaro.org>
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
In-Reply-To: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=H4ObjvN0nM/3v8VDUiTn+mUQT+EEmB8rYxi9I1hNLKI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA97GrFEAK0faKwe/Odebv7QR41u64zNeFM/acM8c
 VR7MX8iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPexgAKCRB33NvayMhJ0WyZD/
 oCEIijPad632p6K5xtEVKcUPUQ+fgFzIP4z3oP53WvrfA20NLlQACXZdFBGUNdXlj6BNcHsUR03KDL
 PHE3kHztM8as0MawBg8JK9V4yJKNVIQE+APaVNoK5+fDC03Ze8xeBl5BEMtzZAL6qilUz1kkb8jvWD
 diDsy1klcggqdEx6j9jBgC9ITeLL7NicDq3a0uaNalB9vuc2hUFYrTUyI8KZUxYkbSuIiBFHQTm1ZM
 cQbv2cHWtaaoB5R1nWtcZwSfDLhkqW7+UyXwMLdaqpynvQO59SlFTEjkwe0wlixutctzZZ0bz3YVTh
 gGhhpaRndnu4hyqGhaBS2FUpWMIBFXH7cJCd0sf0qe+R657i2HLjTOULxvYhrbIzBGnia69UB6lU5f
 nbyRHhAPLm15iUKKGnn9GdDMT4Av7K/5vbo3q78Rf0DYTh2aH7Wge1b731s6Vze0uTeVMsulR1OchV
 Rk18bdv/HNQfP4JlqYBUZrCMr0T4aKXuWs7FNw2iKvgEmpYXa7mmjRIgjmOpi1lOKuLuYT0MjEEHM9
 8vf/3mLWjd3Y69u/DRsibrM/yEfe3b61KfWfOhPW2bktgcK2EkVFrMmtetfvkjUHz3JE6CNf6fd9N+
 WG/SJU61AtDRRZ3wbnA5r/3mrOvbHxqWAPU652w4XGMj+CTACQauZSipidLg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the bindings for the Allegro MicroSystems ALS31300 3-D Linear Hall
Effect Sensor controller by an I2C interface, mainly used in 3D head-on
motion sensing applications.

The device can be configured with different sensitivities in factory,
but the sensitivity value used to calculate value into the Gauss
unit is not available from registers, thus the sensitivity is
provided by the compatible/device-id string which is based
on the part number as described in the datasheet page 2.

The datasheet is available on the product website at [1].

[1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../iio/magnetometer/allegro,als31300.yaml         | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml b/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml
new file mode 100644
index 000000000000..0a08e769f3aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/allegromicro,als31300.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allegro MicroSystems ALS31300 3-D Linear Hall Effect sensor
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  $nodename:
+    pattern: '^magnetometer@[0-9a-f]+$'
+
+  compatible:
+    enum:
+      - allegromicro,als31300-500 # Factory configured at 500 Gauss input range
+      - allegromicro,als31300-1000 # Factory configured at 1000 Gauss input range
+      - allegromicro,als31300-2000 # Factory configured at 2000 Gauss input range
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: 5.5V supply
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sensor@61 {
+        compatible = "allegromicro,als31300";
+        reg = <0x61>;
+        vcc-supply = <&hall_vcc>;
+      };
+    };

-- 
2.34.1


