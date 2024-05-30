Return-Path: <linux-kernel+bounces-195973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393F8D558A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0009A284CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F96183995;
	Thu, 30 May 2024 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIFzCHa4"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FC1802B1;
	Thu, 30 May 2024 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108785; cv=none; b=pUgmO/QjtcVUxi+QPAz9vCEUbFoEkb7lzQ0vKGiREogxPMljjeI/BBhNGu1G+bto0lCnI4J6vKQ4ICPTi3ZjyglJFooi9J79zKsIM+mWeq8zLXgBR5u6iame5ZjDPEmTx6yf2MNh9liTspFlRR+jpEe++wjXDK6yFPKmXKsDobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108785; c=relaxed/simple;
	bh=ofGw7/Ge7WBz5qMYrDYoKIYc/M2oPcchQzIyC4hEIyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqKn0rZRASvNszsfc7BEApVfnqmwYyNTLKWGwh5XZnwAKfx7Sdyynk932RBz8y0KWoBtbc3ewUW4yhNdLlQCHd2FmfEepPHWcWVkZ6NxHeX5wWHZnEfYBQ2fozOpmHLvueYyAvCV065GJKUMK97hpcs3ydMJby5bpA1gldU8eTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIFzCHa4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7023b6d810bso677145b3a.3;
        Thu, 30 May 2024 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717108783; x=1717713583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsuGUamW29699gCC/95HWoSSeAKd2RQxA8flwqqR5aw=;
        b=mIFzCHa4K0odrtrwxPZfofYTIAbYsMaXwFtsFVbgAZm3ahuY+b6+0ruy9gZJXPsKjV
         eME1fSXbwQSKEMsxUfSreWgR7aP+RevWpBUOtUn8LcRZL5Q3S9EXiW/13O5tD8Jka32e
         EIg7linulN5XtUmaNZqZjXN6tlJBESEUYeHZf6kgEyCgcDvNcZffSQycS7KUuqcwLpoV
         8e2PqP0pSvW6hgYEUDo0fZu4c1dctMqTAookjVvCHrC0ElraBKX3Hn5JURyy/SnCgxAh
         CdMxtimqZo4or8GjdsKkG2ysSu563EJcciAAcXe1rridRdKbmu/dKmFHoeLdIkVxVcG7
         AO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717108783; x=1717713583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AsuGUamW29699gCC/95HWoSSeAKd2RQxA8flwqqR5aw=;
        b=G+ftxdHy3WOUbNUJxg5bO1nw8CRiWKJ7Z7yuRu90AOG3yw+h/WDhAJqxESapvIIcGV
         jphIo4X+PPWfL8MweVmXLmo9Zr51f7tsJvvDWxGT9bS1JwWDgO0Fe5uOjSWlFgADlWbM
         yVAU2EQsHYsGK0JQAaq0gnhLazuaAO2tFNIlzKJWg1tDZ62/j00L56gatP15vSmAuAdW
         /bn3jmanBmxFK97b1GFQbXWQZMjh+1LFf4y2snLyHTTGKP88XdpvKYxqmgMVXynGm9/2
         7uV35f0qJTFOt8T7pKztuorIet4i6n3Ip/RJYsdIccO2FjbzyoC3CKgA4cOdBLOwUM3R
         Oqjg==
X-Forwarded-Encrypted: i=1; AJvYcCWcXYGX85BbX6YNpMjJqnpD/dclxUXtrg+t9XqQOrmb+T2h+hd0tWWDT6rseIYzDLeHM3ygpGHLVrIWueRz6SA4koRZ/QbhlkkiUIqo
X-Gm-Message-State: AOJu0YxdffZO9e1MZApBkPslMfKk0JmsHUuPmSdaKH5kd4QGd5CN37dQ
	AaeUsk/WMEMbVNSGS1TTPSbkiZ7iAUk60VDimBjmZNQHgLMXnJSw4anNMA==
X-Google-Smtp-Source: AGHT+IHLkX6hrU59wyxmdEs1l16B3BWOYf1k4sF/C3RAMNiNqq5kc6iUwEevdIXBg8ucEPVmTJJUMw==
X-Received: by 2002:a05:6a00:3cc4:b0:6ed:4a97:5dec with SMTP id d2e1a72fcca58-70247830606mr190592b3a.20.1717108783095;
        Thu, 30 May 2024 15:39:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35937a4c5sm173576a12.68.2024.05.30.15.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:39:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/3] dt-bindings: hwmon: jedec,spd5118: Add bindings
Date: Thu, 30 May 2024 15:39:37 -0700
Message-Id: <20240530223939.1027659-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530223939.1027659-1-linux@roeck-us.net>
References: <20240530223939.1027659-1-linux@roeck-us.net>
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
v2: Drop pec-enable property

 .../bindings/hwmon/jedec,spd5118.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml b/Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml
new file mode 100644
index 000000000000..05c39f7083db
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml
@@ -0,0 +1,48 @@
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


