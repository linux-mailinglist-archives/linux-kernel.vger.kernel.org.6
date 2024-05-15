Return-Path: <linux-kernel+bounces-179972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50C8C684B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58941F2102F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367AB13F430;
	Wed, 15 May 2024 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB983cTZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FD57CA1;
	Wed, 15 May 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782114; cv=none; b=VhjplV0mu/rxoYEjKqun+Y3UszcpSupDkMlOmsgWzI0G6H8QLfYFJjij9H1Mcj/wjo90Pp+TIhzabK6odSUNy2gg+7FTMrN+ZkhEqHQG8Iz/AKATw9CEgL6d7fHHLWobkNQBHJ5vKbs44/YLqDoBDkJGmH6NWh5SLFVjmGnEaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782114; c=relaxed/simple;
	bh=2o16aLD+vJUhmgKsy9/fcWJADcd6QUogtZiRFPAWens=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gg9LMSfWllZN2YMIgQH8LRCVD4fQ/UPVagaO80zyyCCNHP8Y7Ata30RCS8wc2KQlTBS5HJIB2pdoflvUdI70xJ+3sdOF/nU+Mx/DGWQdfV45fo8uPEBt+UgY+a4jTXdFCpf9ccM7qNPE6FnpgbZNv+kFPO0GwSkpPO77BFNSMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB983cTZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f40b5e059so8261712e87.0;
        Wed, 15 May 2024 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715782111; x=1716386911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPRt+KH9PEWEf8y8D7biJqUDsvZAC9qRLt3CEmg7xEg=;
        b=TB983cTZlNqAz7Z8NPWYvPxC4dfs0aX5Se3/IOGZ/JXSztIudKB3xh6W4T2jokw88U
         7nBtyPGyKerh6jrwXw1jiD+OlAMzLRctPNDQ/yB+dHcvbmzv3iyOpEc87ok/JDexSQ0e
         TXtw9BSAIgzxSRQ1hIeUyWq0cI+th3Gf6KJLvWU0Uq1ZxAVsbzmuyUSZKqMde3hOBqK0
         KS44Mje6Dx2bIAMZO8jzyDMdtOb+JgDvahn3O8JYRUTo2SVyFrhZipFtLQjqp/Nw4ciU
         d0fGdwCblc8EjRlc1Pr+h8KG4wzDWftV4g7sJ30C8aF8SHg3kSw75304qEGbv32jjrwa
         mCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715782111; x=1716386911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPRt+KH9PEWEf8y8D7biJqUDsvZAC9qRLt3CEmg7xEg=;
        b=cUgVocDIV0nOB9nssmjKqea80Sd1dS3k+MvmB7ruwk/kUNIJIT4wxPTkXCNXFEUvZI
         e5S2IAq9N6Z4SuaXpA9mzQ5V9fHrX5Tp0FQlR2wk2slUsbevrw/EreQoIkaC1m5xbdMB
         U9S0xzsnn5VwxC6axcA7qKWf46XzYqfTo7w2HRp0olObKwGHqAUH+imL24F0GxsY06Hf
         ykqKbVVBJ8AGLMM/kGdllsjxOTfnVQUECkck6rbyNjonIkU5U5q1x5n1XBb+t4y+1DNO
         FjVNK5Kh/SHhnxBlNrWCkg7jPARoOdvWRhaqTGHVjlFooJZWzhd/2OZaK4MNj4mdNibs
         9I1A==
X-Forwarded-Encrypted: i=1; AJvYcCUj7wW7k+Qn4Aughi8AoDoAOQNXExYP1RzeL1zZJ/hEVJeBzs5eI/H7U8WXWkFlOnxZ5TwU/5Auo4ENRek+PdeVDQwpwSWFABSs+UiEgRni/3+UNOBSvzLIH4djvMXVkU0p/KJEsbeV1g==
X-Gm-Message-State: AOJu0YxhmsuPgbe3okwP6thhQWuF/O2hy9nwRY8sieHO1IZmvKHyHvbg
	scX1EQjuOkipmk05CjC1QZY/rZHf4hIHCxwQoRcLQhGVUTjvgRoR
X-Google-Smtp-Source: AGHT+IHusrVdtGaECVr/u6UpMBgta0LnZGfkVTiO27TcSRbMJwnJW7lVznPwNZDNH43jmxpv8r5CTA==
X-Received: by 2002:ac2:5f49:0:b0:51f:b781:728f with SMTP id 2adb3069b0e04-5220fc72ffamr8682329e87.32.1715782110537;
        Wed, 15 May 2024 07:08:30 -0700 (PDT)
Received: from pratik-IdeaPad.lan (customer-145-40-29-195.stosn.net. [145.40.29.195])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-521f35ba4c9sm2523145e87.76.2024.05.15.07.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:08:30 -0700 (PDT)
From: Pratik Farkase <pratikfarkase94@gmail.com>
X-Google-Original-From: Pratik Farkase <pratik.farkase@wsisweden.com>
To: 
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pratik Farkase <pratikfarkase94@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Convert the Broadcom OTP memory controller to newer DT schema. Created DT schema based on the .txt file which had `compatible`, `reg` `brcm,ocotp-size` as the required properties.
Date: Wed, 15 May 2024 16:07:29 +0200
Message-Id: <20240515140731.63927-1-pratik.farkase@wsisweden.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
---
 .../devicetree/bindings/nvmem/brcm,ocotp.txt  | 17 --------
 .../devicetree/bindings/nvmem/brcm,ocotp.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
deleted file mode 100644
index 0415265c215a..000000000000
--- a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Broadcom OTP memory controller
-
-Required Properties:
-- compatible: "brcm,ocotp" for the first generation Broadcom OTPC which is used
-  in Cygnus and supports 32 bit read/write. Use "brcm,ocotp-v2" for the second
-  generation Broadcom OTPC which is used in SoC's such as Stingray and supports
-  64-bit read/write.
-- reg: Base address of the OTP controller.
-- brcm,ocotp-size: Amount of memory available, in 32 bit words
-
-Example:
-
-otp: otp@301c800 {
-	compatible = "brcm,ocotp";
-	reg = <0x0301c800 0x2c>;
-	brcm,ocotp-size = <2048>;
-};
diff --git a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml
new file mode 100644
index 000000000000..58091e69594e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/brcm,ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom OTP memory controller
+
+maintainers:
+  - Pratik Farkase <pratikfarkase94@gmail.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,ocotp
+      - brcm,ocotp-v2
+
+  reg:
+    maxItems: 1
+
+  brcm,ocotp-size:
+    description: Amount of memory available, in 32 bit words
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - brcm,ocotp-size
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otp@301c800 {
+        compatible = "brcm,ocotp";
+        reg = <0x0301c800 0x2c>;
+        brcm,ocotp-size = <2048>;
+    };
-- 
2.34.1


