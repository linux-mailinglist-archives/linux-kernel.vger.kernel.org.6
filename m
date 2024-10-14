Return-Path: <linux-kernel+bounces-364121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4ED99CB58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8008A1C22D62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37971C3306;
	Mon, 14 Oct 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dananTnM"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7181C304F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911598; cv=none; b=oAxCML8ul1SWsB4zT9T7KNFlSrqZyVFiiwBdL2Kus4HaKIpmzi19zhaV9bNwVR5EoSk9Zh0+AyMaiAjJtCuk8T16sod5PG2wC61YiNez5SxI2+kqpnFFCKN7l4i5lo5oDDCotiMi2S45VW4TizRso0gH6iM6dv/rinpdsB9OfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911598; c=relaxed/simple;
	bh=ATrdbIDUhnH86m7W+OtdWP4CVjzxrd9JvgnnpcBxdnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCHBgO5Ubs6OR+inqSguh6O8Yi622hY3Q5F/fVTaUGQiAnjMiJbaUdIzAnyjHu6IQccCYUkPoTnS+2jhdtWt6D9nQ1svi0P02n/kudwGc/jEz9xQYClikVHmzcS1GhcUxZJ3wNSaQHpyGPPMeNuUCD5vbY4QbCKcfwKj8PUOXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dananTnM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4311e470fdaso28040095e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911595; x=1729516395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=dananTnMUvxEI6v01JXkJQccI3YiU+DWTXimjHs0p9dCBa+UfHw3ync11EXvk1BqYI
         SZqyqXP4jSQW9aVzOwSgZXUtCCX1a2BO1lA+FUBp+AcgmwKt19Ag3oNjV/6uBBi7E4GF
         u1wcwZMadVIeTx7ea1JyXRZ/Eng8gmOkA95Lu6/E74GVwqRsqYNsKtUeRzB6vYB4wlkt
         17rF7CqbdtPPJ1sQespZS66XY7etI2XNFayA07pU3VP2o1e4pJ541VtRG4B59rm5sWIH
         ZGWbgbWiUDhZbFtTLeGm/LF5enzVgox3Rqfstxf3eKS3OnAOknFG3OtmOc0Oppwd26/x
         ITTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911595; x=1729516395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
        b=r/Jjy+/maUCMpL8Ytm3cy/1IJjj52sC/7IXzYnzw7VZfoyASr1/31uZjfwg0X0U+HY
         3CPLBmRaFoTx69up0f/kFQ/VIcMuYvF5/it/RZmJCQMuUs8lyEeCYH4LEPPkyrJWkUEc
         FksgZPCWTptrETboUffhhktCG1bfFpu4YWWc/ICwadj0slaM/UerctZCmlkd9o8T/XdD
         OdbApdaEdmpwWVJ8NrzU7QgmdMJAp8NYzz3wgP0EGoz/Jv1vTyeHN71MieMdcc6F38xE
         krPHBXQwEtM8Xi+o9xHFYXRCiVfo9cXKguI+1nCnDQVJTOsCztW/rDt6XZY8v9semJ3r
         f0dw==
X-Forwarded-Encrypted: i=1; AJvYcCWFVII16kJTrXbp9XscZxcpfJErpiQP/fIRNOR21ZFfOTlxIjWDG28eEifYlgpB6okLfxTptR7b3zZhRPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7nPaSMba6gN3VOar+G/iFibP3uzDn8vu18qey/seSUPjwbJt
	QU3K2pmdkTFOIvTMcyQATPRxsigJ+hWt1n3GvszbGCs8Q4AlukVVRZ0AEuo2Urk=
X-Google-Smtp-Source: AGHT+IF2Y2rFEn5ZoVa/3sFo6MutMkA4wHV1jSoZ7iwTSGUMweLnyo1S1O2flRuHE1JqFemtTtxEKQ==
X-Received: by 2002:a5d:53d0:0:b0:37c:d2f3:b3b0 with SMTP id ffacd0b85a97d-37d551d5113mr7063731f8f.23.1728911594727;
        Mon, 14 Oct 2024 06:13:14 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:13:14 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 37/37] CI: Enable qemu_sbsa
Date: Mon, 14 Oct 2024 15:10:53 +0200
Message-ID: <20241014131152.267405-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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


