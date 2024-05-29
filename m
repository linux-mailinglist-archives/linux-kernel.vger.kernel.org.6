Return-Path: <linux-kernel+bounces-194679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD18D3FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A897A1C21CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86C1C8FD3;
	Wed, 29 May 2024 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE7p/ULs"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D515CD42;
	Wed, 29 May 2024 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015932; cv=none; b=O7rz9RlqUOyd9qkbJB1e8gGGaAdRa+eLemdPxo+ke6XkrAxQL2iZQHTNdG+y2gNAft9huxBUtqcRvbnEaOyOxqCPpz7JPu0KS956gQX4U4IIwrXUsb6KTiUrZCUEdfy5j/pQCNEv7UDQtXg0CsOXzyfsowRyN4/frHnnjEVSano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015932; c=relaxed/simple;
	bh=bUSOfyZ1RS/JFlmZr8edz4J/gVf0uNdA3Hhjv4Qs/0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5COJe8Pq0RKiZwLTfg7nOgcT8E4SW8TjdLSI29r5rwX1xvuQMji4wyjFD8zmN9Hqz4iwCEaeg1iuhmCuU7r32sMxw75BkYkfA2EolyCgtoMf1A8FryBwuJZca47VuMrEgej7ExdPsgigiJWXMkjCbsAdrvEV9xzDgJBCjKneeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE7p/ULs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a52d2688so1596665ad.3;
        Wed, 29 May 2024 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717015930; x=1717620730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTb5O4K64K41d0IyPGOBYfXW5RgD3BIXwCmpDCC81V4=;
        b=kE7p/ULse+7+EOHOFMZ4/llWalkAE12lZevK23fAy1put7Njz8EY3kIett5aWcz48f
         id2/r/cIZ2lWq6C4QdkMbruEDMknfoE7SvykLPnJPSZt47tm50Cs8kt4hOotaScvijhz
         fS6cviA0mPUfCh89RYfdX4Fc7nS+cwby2GQBToEi4T5Y8Qw5jm6/7LQmRTAZtPWWan++
         Uwrn2Fy3b6QgPYVpkB/ETUO8/+9h33VvJQHrqZ8QYaRjBwlI7LwBdhZnyAX6GfyS27Kc
         cQjdM6utKpm8NcWWeaL7AgZt3rgXRq+RV+uLqljkGXjpDN49JzCvAkROb+JBU9EKT86w
         Ctbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015930; x=1717620730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTb5O4K64K41d0IyPGOBYfXW5RgD3BIXwCmpDCC81V4=;
        b=VzFxS8zlIwT5CY2Q4rlAxgUEFv42mQ57VPnP1z9yqJ7jxbItwbCnNwM2JnLtRc+atZ
         c6Png/hCvaY209YMCH7x8p0FYS8LUpa0HHbU/x8JBex/B/BRR2LdE5v2bMpH8L/0HKcc
         vwTEm8RaWeS4EogNhoqWi0IUJ7Z7T+BfPgB6hyjFGBXApjfDAg7InU7jTjFVqWssb2K1
         8g4Mp2s2bFunErdZs7pR7I8/RfRg8aB1EOC7m0Q0nndbsGeZUlCsdwEywfzXPCD4VACm
         901NQ9/qs9W1CG51M0ofvEGbcxhPnEv4w4ahbe7z4gWt6UhPfPSE/YOlp2vHfqygSJPU
         F18A==
X-Forwarded-Encrypted: i=1; AJvYcCVC9yXuEcBqA1pNRbmQgiFlwDuQ8XBoDrXsR56/zUo7Y1T90UkGlyTqTx8zjRCgzztkEqESzl9y+y73B8V06phHHv+1ojK2HDRoC5KFD5tly2p7fooN0dSb/4hqeftQQ/m6EqRSVigrug==
X-Gm-Message-State: AOJu0Yzz1OrvzXdqVGuPfOajbs+3QtSnAx/zUW707VomRi/G9p0NzX2N
	J76IEfeWP4RGjxMChjWD1NThPpT9nEtXBRnanZ93yY1KO4LuH1xeIFyWJA==
X-Google-Smtp-Source: AGHT+IF5WVT7A9L0jfAUQQkVxbQvTT/DWCF74Mtgf+FDPnpSah8a7TgliWV/e+E++4X64a6BXdJz+A==
X-Received: by 2002:a17:903:2b0e:b0:1f4:8bb7:6862 with SMTP id d9443c01a7336-1f61960240amr2634235ad.5.1717015929934;
        Wed, 29 May 2024 13:52:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f476f665b0sm79285365ad.250.2024.05.29.13.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 13:52:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] dt-bindings: hwmon: jedec,spd5118: Add bindings
Date: Wed, 29 May 2024 13:52:02 -0700
Message-Id: <20240529205204.81208-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529205204.81208-1-linux@roeck-us.net>
References: <20240529205204.81208-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the SPD hub present in DDR5 modules.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I am not sure about the "pec-enable" property since it is not really
a chip property but a SMBus property. It is also not chip specific;
there are other chips with the capability to enable or disable PEC
support. There are no generic SMBus bindings, though, so I don't know
a better place (or name - maybe it should be 'smbus,pec-enable', but
there are no other similar bindings, or at least I didn't find any).

 .../bindings/hwmon/jedec,spd5118.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml b/Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml
new file mode 100644
index 000000000000..1717f75129da
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/jedec,spd5118.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: JEDEC JESD300-5B (SPD5118) compatible DDR5 SPD hub
+
+maintainers:
+  - Guenter Roeck <linux@roeck-us.net>
+
+description: |
+  JEDEC JESD300-5B.01 SPD5118 Hub and Serial Presence Detect
+  https://www.jedec.org/standards-documents/docs/jesd300-5b01
+
+select:
+  properties:
+    compatible:
+      const: jedec,spd5118
+
+  required:
+    - compatible
+    - reg
+
+properties:
+  compatible:
+    const: jedec,spd5118
+
+  reg:
+    maxItems: 1
+
+  pec-enable:
+    description: Set to enable PEC (Packet Error Checking).
+    type: boolean
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
+
+        temp-sensor@51 {
+            compatible = "jedec,spd5118";
+            reg = <0x51>;
+        };
+    };
-- 
2.39.2


