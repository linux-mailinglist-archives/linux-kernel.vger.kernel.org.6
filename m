Return-Path: <linux-kernel+bounces-268726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60F94285C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5AE1F24032
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2D1A7F86;
	Wed, 31 Jul 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9qviyy6"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BC1A76D3;
	Wed, 31 Jul 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411962; cv=none; b=foQpFksjT2h4cck01Ga1XT0RdBgop//w4JUCz8eXEVhCiBrwPyDKV5Y6BC03XuwIk9OgApbU1juy6U/mD4jvoBdw5FG3uuRz7owKv917nNVv9CZ4vDV8dAJzoQf3DB8YpN60JQGBuhP0sfGW6UN8l3nWs+PSq/4fUNSewWmh10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411962; c=relaxed/simple;
	bh=IFlsBwR4bWRMJqNSAourFr1ygVrYaUDwK+LML6tYtak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/Fx004Chq88eceyjKFuQ5Eg6KvSniJFOsT9ppVs9BOM8rCLDWEqrqDoD/vEY8PeF73BThkJXt38z1vq3aaz3IQ8qcq/YaVp9EanZMDhx5BTKo7cGOLhcWeYAd/WIOaV8vFzRM5YQQSUlVLSzrbzgdAjtHSELzPN/pCOIxxwekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9qviyy6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so3452443a91.2;
        Wed, 31 Jul 2024 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722411960; x=1723016760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQbrJo4wrR+w0vLwwcAWRgEUCmmfSCZZD5nQAlef80M=;
        b=H9qviyy6BlSgpEagt0tC0f1BFw35af0y1NWj2kgRVhzI33Yfi6hsaX3eAAf2Z9nxz+
         IILxPDKiYfPe8A22BFSemOovBWfOSYXP2X7qEgLlqdCOTq4t2uznsmv2YzxELViejD8v
         XTocszErczUIoiMy44Yy/Ur++wnoDY5BxlMd5cEjuM8az2eHVqGaXmRRbiDb9hgAtNrf
         g5Nf6cA06uzIJEVwnuGURGEro59ecNvy7n2NdV3e/7F6hjUavprUDnwAZHSAFbxq30Fn
         R1pioj+/uPJS1nJ6N8ejU36K8qjQNjRqRxCvO1nci1AzHqPQp8iLYIizBN9yjvZ0Fw+x
         ia8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411960; x=1723016760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQbrJo4wrR+w0vLwwcAWRgEUCmmfSCZZD5nQAlef80M=;
        b=g+JdTLxKUCyd/1XXdJMKebkdyU3yH6AOSiJ+A15Y99fOTvylgZHC43PHX/VF/SOKKz
         qKFE4D39qXH7Rc3BqvpJvKjPQ0CdED/kv1hsFxz+A+KYTb+8X7KL6SjN4nyjlqfnfUNv
         HHPwqXEE/rXWfAXImB/sAxBovSZmJRzQr5CSmseV6EkLC+lyUxwOcAKrcbckxVAVLJU9
         2A53K9m9qG2iAhBBci8C9O+VN4Jh/mVVrpZdQkDEDZ1il1zB/v6iSpp2F0V1gLo+3ars
         anc+Ja52Qi3NuCMa4PeE4mA31bsAPm5hVQNsTDd4kiJDRyMRezYdBhNZEBbmEtrgQ4Bs
         XILQ==
X-Forwarded-Encrypted: i=1; AJvYcCWntADku6DMG32Et3ENdnkKxwFgC8TwF/DC+df7hLvuIpKa06CHxhFDZtSIZIbjNXMuYIgG718hJn9E73R+rhiSG5DdhfH07lCgwC5BzuX/WLcCnryXGs/xu+sGfz2afESnLlQ8ScwFBg==
X-Gm-Message-State: AOJu0YxpXTy874g5YqrAIA+pXl+JOodSGlWDkDrzYZyn9aLYYCzhDbsJ
	EbvPfmpg+40U2N+Oys9x6LOduvnn4TIOD7atP7xk1478GGjViHirOU8uF4M4
X-Google-Smtp-Source: AGHT+IERNyh/vJ2i6z5ympNc2/09CjMuj0tqDRHJsuQ6Fp6QsNcqMZ+cloHdCX85JuKsuNIH5KnSew==
X-Received: by 2002:a17:90a:eb09:b0:2c9:9eb3:8477 with SMTP id 98e67ed59e1d1-2cf7e1c81a4mr11728261a91.16.1722411960229;
        Wed, 31 Jul 2024 00:46:00 -0700 (PDT)
Received: from localhost.localdomain ([115.240.194.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4064cesm668185a91.12.2024.07.31.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:45:59 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: nxp,lpc3220-timer: Convert to dtschema
Date: Wed, 31 Jul 2024 13:15:40 +0530
Message-ID: <20240731074544.208411-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the NXP LPC3220 timer bindings to yaml format.
Add missing resets property as it is already being used in dts.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../bindings/timer/nxp,lpc3220-timer.txt      | 26 ---------
 .../bindings/timer/nxp,lpc3220-timer.yaml     | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
deleted file mode 100644
index 51b05a0e70d1..000000000000
--- a/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* NXP LPC3220 timer
-
-The NXP LPC3220 timer is used on a wide range of NXP SoCs. This
-includes LPC32xx, LPC178x, LPC18xx and LPC43xx parts.
-
-Required properties:
-- compatible:
-	Should be "nxp,lpc3220-timer".
-- reg:
-	Address and length of the register set.
-- interrupts:
-	Reference to the timer interrupt
-- clocks:
-	Should contain a reference to timer clock.
-- clock-names:
-	Should contain "timerclk".
-
-Example:
-
-timer1: timer@40085000 {
-	compatible = "nxp,lpc3220-timer";
-	reg = <0x40085000 0x1000>;
-	interrupts = <13>;
-	clocks = <&ccu1 CLK_CPU_TIMER1>;
-	clock-names = "timerclk";
-};
diff --git a/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
new file mode 100644
index 000000000000..3ae2eb0625da
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/nxp,lpc3220-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC3220 timer
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+description: |
+  The NXP LPC3220 timer is used on a wide range of NXP SoCs. This includes
+  LPC32xx, LPC178x, LPC18xx and LPC43xx parts.
+
+properties:
+  compatible:
+    const: nxp,lpc3220-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: timerclk
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc32xx-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@4004c000 {
+        compatible = "nxp,lpc3220-timer";
+        reg = <0x4004c000 0x1000>;
+        interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&clk LPC32XX_CLK_TIMER1>;
+        clock-names = "timerclk";
+    };
-- 
2.45.2


