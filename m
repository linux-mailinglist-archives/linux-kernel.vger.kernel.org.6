Return-Path: <linux-kernel+bounces-521130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D0A3B4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F25A189C98F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072F1E5B71;
	Wed, 19 Feb 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfqhXf1P"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8A1E51F7;
	Wed, 19 Feb 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954265; cv=none; b=RRu01C009zvpQbzJtGB9L1HXjVGwF4tcdnkL5PeVsBq2iOe6v2LcH96pTF3DXyYXlpyDCMhbIllog1iAF6vuiQ2Yeq6lrxdbymlMUysnmh9KLZ5ez5xD9SPhtkuAwpJ6Yar2PJU4rQI/ry1ecdjeDU88GlvZsopry7Z6eHH/bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954265; c=relaxed/simple;
	bh=yZbiG8fVqkzzBxHxgsdvgj/ouf+ympNpqJ+EWQMu3p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qV4dHO3YGHQqxRbf76a2V3a+DC3Mow+tCHJTEyzKnGUXZZsnTbVZFxeiUmTPB6xib3W9PJx/rFS+K8kiOLPWQyWr639yuHeTpWSeHTh4z0UkEr+KrhoNbqTUq9i8il9W+FD1I8hxQ76SS+DWKNxwSnNXb1kUnV1z4G7nmofZGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfqhXf1P; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-546202d633dso3076393e87.2;
        Wed, 19 Feb 2025 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739954261; x=1740559061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3CFcnR135smaOvbfxPS9mVyTzTgMH51kZeCWuwrg2o=;
        b=YfqhXf1P034SW5X4YxlV/1joBayERydfcDqee2S0Dj2EGBLzxMzvKu4wDmiKWVuVq3
         uPzukE0IqRgCmysFur1DYY3bcRTYTpieXMMrXyfhGWgGrC+he5qaJtExgp8pMIpidFOU
         qf3l/WDfJ2INAQ23LWOzM4Mj/ysPlydGY0cnnwG9b0nh94zCHBT0sQca595aVwfYXC+V
         E+zPRehv0cCL/OmiZMGlo4U7CO0nNcd4tsCRY+yB8PD26ZDsKpFDgmQZ2zIUgMUTYW71
         LN9Fby0QOsnVL6wrqhJ2e7wuu0xUj0zVFWU52jeKu+WsGHvcBOkAMF3tdhqT7zYhZiWo
         gt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954261; x=1740559061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3CFcnR135smaOvbfxPS9mVyTzTgMH51kZeCWuwrg2o=;
        b=EzqTJqWEPsNpMCZCoi2BGmoAG79Hcc4FH0xCacYi8PZ8dVKo7GEmr6AJMsaPIvU/78
         qFNp7byDdwTc6JB5M5ZcoXOUczNW1kqDnpW3U6LnZdsr6mMSkIKTNGj5UzJevTEhupcx
         GirFM8WLVWmZD8D+sTCZCaYQDye4PHQZlsSrNLN//LRJ1pJr0rjSh1uZyRII8/HcIcz+
         8zlZMyzEFmZhhvHdQZE+g0o7lWG3YJOoBp9nj9wPLcf2D4OaIvSApMCu/iAwUuhZ5EHA
         j+tMlwtW3gndyGthsjqUYDxCUVlgGRBrnwdrV+VHY3ViMk1K4xypI6+VpGe+uBnwF7J7
         lB2A==
X-Forwarded-Encrypted: i=1; AJvYcCUc8OMbdvvaSRWMjmoGI5F34q81l6pSg2tIzj+1gCnQXBrPKxu53PsO67oOu9zURZNYNtRWxzYXD+HR@vger.kernel.org
X-Gm-Message-State: AOJu0YzalroPACydtEn0AVSQ2grCPsMVEGdmI9PrkaB3UNMOugGinxRz
	Pot1+cpK3mw4oXH5GGa9bjIQo16Rjrl5MmYuTLNXv4sJILn2olGB
X-Gm-Gg: ASbGncu+l7PmIYayVJKRk8v2lB64F8aLv2D+EZu/HqWhyRRMpe4uo/7IzSS9Pf1Kbrd
	sVQB8yBbOzPJysEq50iG/tb5cv1iYjlIfHFmk4sKy+LQG9UmuKZTUXCdf15cZGeiyW8QYZ7ztVk
	eqidw7fJ6J9BvaDq8QUbhD+Uh/SVibojaU4yC1kSV6FLHXI15ic559OJ455qutHZP7FHH1b6UnD
	xesSPynJO14G29lJrN5UPt1IioIJ5QJujMZn15/Gcf3gUaBb68hACciO52unvebvVTenLch/Y0q
	PQTGky0=
X-Google-Smtp-Source: AGHT+IF7N0m9fi7UNBnynmCrYtZ3nHLsyYGEDuj/ytM52ZzivFGmDorYqVT6d6ffaGAJC3tLFVpx3w==
X-Received: by 2002:a19:ca4e:0:b0:546:2fde:d2d9 with SMTP id 2adb3069b0e04-5462fded38cmr667284e87.28.1739954261340;
        Wed, 19 Feb 2025 00:37:41 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452d8e54f7sm1692319e87.9.2025.02.19.00.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:37:39 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: extcon: Document Maxim MAX14526 MUIC
Date: Wed, 19 Feb 2025 10:37:23 +0200
Message-ID: <20250219083724.56945-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219083724.56945-1-clamor95@gmail.com>
References: <20250219083724.56945-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Maxim MAX14526 MicroUSB Integrated Circuit.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/extcon/maxim,max14526.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml

diff --git a/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
new file mode 100644
index 000000000000..87cf7fd19ee9
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/maxim,max14526.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX14526 MicroUSB Integrated Circuit (MUIC)
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: maxim,max14526-muic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        muic@44 {
+            compatible = "maxim,max14526-muic";
+            reg = <0x44>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <72 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.43.0


