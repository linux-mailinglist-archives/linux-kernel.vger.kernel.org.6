Return-Path: <linux-kernel+bounces-378096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A59ACB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D941F2116F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41F1BD01D;
	Wed, 23 Oct 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BbTwq6/v"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31EC1C57B2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690183; cv=none; b=PC5pz3m61W9+E9FKmM8kqovKGo9SnhGNrtUS4KMUW8ZM/DJIlMQdOKnHbtCmIy2ju7Usd9pBSsgNoxF0QlNEvAiM8m/adQRNsIlXgl0CjzIBbfiXNLWyY/fpMHzSPMx9+w0ODcpjM7BY9VRQkEnkgLTf/0BDTgF/I8eSU1heosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690183; c=relaxed/simple;
	bh=ATrdbIDUhnH86m7W+OtdWP4CVjzxrd9JvgnnpcBxdnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnPeFT90QA+X3x1L7pEO3z/GDzFhje425aaUbaq4B+l48W/6jxcrMSsQROf1yB3yzTEVCk5UPPYpOPdNYfYzogAeGm52Jcg41kWmWyE5x/iawCrcVriWrTkwsWZx91+nO81svPjWyHFPKPCd4gc2aweiwDRrP9TyqkLC7gocQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=BbTwq6/v; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d447de11dso5366813f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690179; x=1730294979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=BbTwq6/v9hHP5lNKC+gY4nf2KBgY18D1eEWaTLmwY8ZPfDdr/6LXgktcRiM7wNmV67
         kCb+kbQAG8LMeMYV07fapXnXzzrY52Uv8v7edKMEmENAuaokd0K6DVMYCnEIlCCSZKCN
         GHed/sZsEytNd5iAHkQ9EAQjKRs1cYTqxh0uJq2ZrBHXPeSpZfl3Rsht38TYckrQHD8n
         keqlm9T29ioc9vA4KK0xFATTEgKgMGeEXUi/J518VoOVcj9weEIdCh5oussHu2w5QDpU
         8MXH37H8ECoGNq+HkSFp7RP2B51BOaShLMdegij7rmOL+iIyJSZScMapBgVTWUatiCIk
         wF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690179; x=1730294979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=GnkY8UZxRiyIYl2s8QpP9HYEILACl5yB5Giade3Erc7sPIVmCR/XReziX1fxJZEpwJ
         vJG2R7u9d9L7jjcttfcyq9kNggDV74ne+c6Dk1N/S1dOrkg2NpbtSUSilX5WlcwM4ePG
         90lfef+B5ONjC9PelcDUXvwdZRS9APk78diSCNS4WVYWPgqPdB4JG3x9TQ42YC8IuECn
         cCP6BrRBqMcuMwgu+RaBJGca98Sltpl5cR/zKBlzjaZq0KadGmKQZHTuczx9MjkFGx5M
         PE6VJZgDed9sDu40Zz6zsEpBgJKJtIZXlAPUTddIDmuUD9MwjWQDVyRNemHTm3G+z4Ij
         vChQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVnZmkykZ7TbiN3lhA6r4RiPXz6MgONNt1mKQy6qkU5I5mrRFq+1wTDdkqSYZCEnlrMEVEJzYlaiu8dIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3VdxZ6bZXIydNPZxBA4r3wQR2EAhD0B0ILQED47eHsxenP5d
	jHdlUyiD/RDLJNWTHoyWmCCmJh+1krK47jSfSSHxm8Hlkb/Cr3CM/oX+Ot/4X7c=
X-Google-Smtp-Source: AGHT+IFUqU/EvSrylcLUMy85TyHY6P+SYtEyI99ANylHUxztqJY+8JJeUGCIdnHZ3eWk6gwTjrEX3w==
X-Received: by 2002:a05:6000:18a9:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37efcf1fc01mr1687911f8f.25.1729690179249;
        Wed, 23 Oct 2024 06:29:39 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 37/37] CI: Enable qemu_sbsa
Date: Wed, 23 Oct 2024 15:20:20 +0200
Message-ID: <20241023132116.970117-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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


