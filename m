Return-Path: <linux-kernel+bounces-360939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B81D99A184
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C635E1C210D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39CC217902;
	Fri, 11 Oct 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="WADCajdV"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761592178F1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642940; cv=none; b=O9yrLnm4G59eZoqWxL5+5jz3wG8wP3SyaXqtgNbKg7syvpqMsOce+446E2SvKSGwsOaj4TDRIxzaOrdjLRpL5SAmThiXKZGYiZiQcmdIw9623cmKDbDYAZ+5J19+iGFyscPbzwx+cwyFtUnXENsVfm6bSky8f/+8cSJ+lAh3b7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642940; c=relaxed/simple;
	bh=ATrdbIDUhnH86m7W+OtdWP4CVjzxrd9JvgnnpcBxdnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvErQk3OXYwTzmrDvCv3EQBac8YKQzz13VarkpX0ivE9NZKFD2WU+876DQ9y9BDH0rEOppSuuxuEFAR7Rg+T7+KQVdgpy0pPQcr0NAOJUrxDs1qKN9ztNReVygdw86ADIxLDTdLsCVUs6YsdopYgt+yjrhQPxhHFpbJQhjaaUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=WADCajdV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99650da839so320293166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642937; x=1729247737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=WADCajdVU/pIcRdWCzuYIe1p3Q1WB0MGwXWOaYPRY9Bgmt5n+hUS+9velTc0V1+VVl
         FBIxm2+IojyeNtp4/mWD7yo10pQJC6kIA6h4W5V6gm9STW058DnkA1ctrHrhZcIXGp6x
         NBbl3hZFnzj2JI+fa/a5J+AtAH9jzcHCd8fM81HxdwZHj55MVnv+egpHacGiDhXbH28l
         WF2Qgl6uD+PWDRLkCQB07tocmlqIE25ALvr7jG8KrnhcTTOi2q86/lpWwX9cdFM9cUW+
         XahXJAe2hCl77Da9oJZGjkfPpdKNnpJnf9o+bYlJ5t05r+6txJ+lz7lIdK6RyDTELRjT
         hK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642937; x=1729247737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=KczpjW2uWQY0HTAN530wS7KDJVu7+W4WVllismrtxRSgn674j5rAHwv39LO/aXLfbl
         sFCjxhwt9oHC8Q+l8frUOIQwbEugmuCx4tVv3aLI8tAUWLvckGw74s5LNCcSgf8Nd0f8
         r5XMF8V4UJI99BzQbhjRdjwIYt5fJVQlpfC5kYef9DXqp1Dn+50N7xzagp7XMT3P7U19
         SyN1a5v6UBdtV7FgE1bu3xhc0ur+mOwooNcfC3JRnUIo/UTxuKita/c+GINM/b31+JOe
         bdzMWWf4fJSg0klb/E8CQRiWO1XGP1phOesUYn9Gs9POTeRnyAP4KOSuJ/TH0p8etg+Z
         sdIw==
X-Forwarded-Encrypted: i=1; AJvYcCWsILYDKIpqxt6AptfoORo9e5qKc82foZtR7jy+tsv0fqK2FL7A/gZu5A53dx0a0RtWJalr7P8HOMjxPO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+haFHUgb81YzkgvXh/7+YmHydLgeyh42B8BMHwWGIdlnmFgU
	thsM0AYhekw755mTm5e/Ku006DHpLA7GcY4v6DLMMetTDMZsp4IRgNoyd5Juegs=
X-Google-Smtp-Source: AGHT+IGp06NgVf8kmbXyIV8NBAGlAA0zx/sQXJCyZh8XQCsV3y2ixooIKSl7GepxBpWarO5Ro6ldLA==
X-Received: by 2002:a17:907:e247:b0:a8d:2b7a:ff44 with SMTP id a640c23a62f3a-a99b93ca2c9mr177312366b.32.1728642936729;
        Fri, 11 Oct 2024 03:35:36 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:35:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 37/37] CI: Enable qemu_sbsa
Date: Fri, 11 Oct 2024 12:23:18 +0200
Message-ID: <20241011102419.12523-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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


