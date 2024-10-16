Return-Path: <linux-kernel+bounces-367347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083969A012C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0E6B247EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470F1B21A7;
	Wed, 16 Oct 2024 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Ht6FSJwW"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71F1B21B0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059229; cv=none; b=IXkj735qBg2O9OYYMXUl7byxwFMyvN3zUKtMPqqBW6ZHP3zZc5b7crF9TZDsXh9buqUUQETP2hXZnz7Lu2IjXJVSn/IaT5c/iRNuqfftKfvOnTxEtHbd4b6Q8uLO8BEit4Jv7KjUirYLzSsOxU9zdX4k/AtySyhLLSMGVV2g4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059229; c=relaxed/simple;
	bh=ATrdbIDUhnH86m7W+OtdWP4CVjzxrd9JvgnnpcBxdnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+wQJAw0D9qIaHctZR0NDMuNGIvYm+iYOmOIWwos+RVEZ8G4pahQdcjOJm+Scq4erVSz7lH835dHh82KBDvMATZBk0uQu69WdVptoDIXA10jVq852S0Mi55SyAxg7f9UUX3JX3jwo4rrXxcdHdpRelAjrI3mZxfgVSJYvYfUzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Ht6FSJwW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so3672673e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059226; x=1729664026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=Ht6FSJwWXFQWJJvV1jagsxzYaUf8QL7AsytHxWlXPl7xn/H74x/2N0rqgf10+Otjhf
         j8OruDuLq94FyJ3XYVV/eXnvlIA9tmohmiTJsFYA9kYUV+3G8Udphfi51uTYnO1OT7XK
         jOrgg8KY2tRE7xY1LLR34tRI/XDVGbQNnlO6a8esF8IRtH4PwH3q/n8TajmvuD+/TOGz
         RAtsyk7d7N6PjUPd7sH5Ay1Ku80IXZwV82t3BeqeoTN80Ge1T9pq9F/6f54SvqidRanJ
         tCFVsFa6zgMXyp3k7DeZ/grZ/uikaCSLu5WvGebtqhAklBUgd698ZfFL2V14uJho7/9v
         FPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059226; x=1729664026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=n+JTh/EcCbwH/4eeFvIo5s/tJfDY9Cz92+oqvSntEi/g8K5plZh6cpqReLUjkOax5B
         wH9wW32fXDgZ/w85NM3Kyh/NgUHGkQ1SbJmvMEJRwotgLinGPZD5YSbFzQJ3Iim3dLFD
         46VM8Z/LRnx9cI/VLP6cRCt/rs6CxrJh8b2lbw53cJAAb6Fu37jKIi3yLSAIMYRH7KCR
         Qaft1jC5fpzmHZr6YwV9matBHgWYD96PUuh+FQc/pZaXPMxCZJBzri4puGole0AQNkvB
         CJIFlCrcV0uYSt9lqzplOoQm5wfNSKM5vuEyPmzbfW+WvQg5vflZhtdat54L9pXxgOxn
         KuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+3XRVC5cpdNRxHE1sIGbARFB1NVmTkhC8XMMXa2JVHqQe6CqulSkHHjetkInNdKJs8iLSaNI1JgaF950=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnJz0EmU6fV3INmRHsM72cyM9Y6T5Pa9fzk4seEwMWoFzFyff
	DVPT4cVxzeicO2fES+9B4V22shhsPcW+0jf/lh81HJrD4qN1dEUfnoAtXgpXixY=
X-Google-Smtp-Source: AGHT+IG5g5UDW5Yoyp//orz1P16SZTujxiLgwSoYbPC0qZH5PygE4wzKt9VFBXJTS3UOQcJOev/6gw==
X-Received: by 2002:a05:6512:1383:b0:536:581c:9d9f with SMTP id 2adb3069b0e04-53a03f2d5b5mr1679641e87.24.1729059226053;
        Tue, 15 Oct 2024 23:13:46 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:45 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 37/37] CI: Enable qemu_sbsa
Date: Wed, 16 Oct 2024 08:04:23 +0200
Message-ID: <20241016060523.888804-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add QEMU's SBSA ref board to azure pipelines and gitlab CI to run tests on it.
TEST: Run on Azure pipelines and confirmed that tests succeed.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changelog v6:
- Add gitlab CI support
---
 .azure-pipelines.yml |  8 ++++++++
 .gitlab-ci.yml       | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb612..2881851ecf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -250,6 +250,11 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
+          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+              export BINMAN_INDIRS=/tmp
+          fi
           # the below corresponds to .gitlab-ci.yml "script"
           cd \${WORK_DIR}
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
@@ -415,6 +420,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_sbsa_ref:
+          TEST_PY_BD: "qemu-arm-sbsa"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d621031b8..3f02a492d5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,6 +39,11 @@ stages:
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
+    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+        wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+        wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+        export BINMAN_INDIRS=/tmp
+      fi
 
   after_script:
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
@@ -344,6 +349,12 @@ qemu_arm64 test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm_sbsa test.py:
+  variables:
+    TEST_PY_BD: "qemu-arm-sbsa"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.46.2


