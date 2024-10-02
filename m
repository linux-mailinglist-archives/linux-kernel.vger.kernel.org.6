Return-Path: <linux-kernel+bounces-347290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4D98D083
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FC11F213B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A2B1E630C;
	Wed,  2 Oct 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="KBBfTOQ2"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F71E2023
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862792; cv=none; b=YvFYAxjo5KyLVBzDq5iNyydIk1yVUUTx/9dCICfToxRCDhMoWlt9sm9rXbwIW8+n2o6gi4ccMa0xnplQu3Ibhp+lqKhSWsXpONkRvmLskLD2HctHJwaYnygbRWtT6cV7r8V/igu47sNtiaWdCDXhdiR92VLBqpUcoxKAjINlKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862792; c=relaxed/simple;
	bh=Cr4Igrt9udA/eo2NzoMJhLfXD1BDbgiEOaMwBMHPyVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grAxfnFgHTCSVJkjXnTz4p7+FVKYProG76na78evieksI4oPud+Fwzeg0wcKgzwxgBhrjq6NZNTrVAnVirNUP9e3ZERlzxQqb8PlEjFRBLuwkiWQur3LGCLfuu04WueaEvuZuK5d9SfwwBpW+EILGnkBgUluudu6uC238roCuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=KBBfTOQ2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cdac05af9so4101703f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862789; x=1728467589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6SuZgJQToOkX1MPx11/dn8nD3cD4nxG78oM3rH6YIg=;
        b=KBBfTOQ2tI/pvefdZJwh9vwP2KC4WTE9JVfS2WQlhmqTHPtGx2oEby7PWmQMBAxJ3g
         oBrWKcGmnglnsQ3/qwC9xysTTYums5azca9Bs6tiuo3rANUuMRp3+fUUjQbB3PbstSdN
         jvBzW6Lhk5KrCIhQFgdJrOYDTdZWodRrJVVTTb4+mMdktfIqZoa02LoLoJUQOQi1N+tQ
         6kqkisgfbfc5Xh/8bJJUNmeYN6HLUszegNTxTyDFYl04UjFszyRYo0aH27tRsgbhTsQS
         ghpnJ3m/Mkqh3Jen6GCaOXsm/VqO+fA42QvLueYlKAksFgrTHVh2eY0ij8ug00LOblra
         E9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862789; x=1728467589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6SuZgJQToOkX1MPx11/dn8nD3cD4nxG78oM3rH6YIg=;
        b=Sm7InJLwQsUmUI7bzp+PKC1X7cmntd7/09qNiOPXvScI6zte7MUQLctLBNu8aCGLWX
         rxw/4qvBcAMDbUBwIEFLbgWjqeQ/7+KzfGudg6srOnQ159gSs/6n7+huV6gt6i2H7RKa
         iO/e8R92pW5N6Plt9YinwdaETcvFEJcv+J/yw74MlLtf28xCMruYMytHDRRT5OLQJZ4k
         w+aw7KB+njbL5OQG6nh/76XaZ8yykh7uPF/i2jkpvEMIGP3pz4GF7h8x6U7ss2N4XCk2
         WLGek9QuGrb7kr0Pk23gXsYAPMEeNMkqqEn31VwofrlGMHj0iwwInU8OP9XucC+epyuL
         oKaA==
X-Forwarded-Encrypted: i=1; AJvYcCVoYEw8tC7ftQhiLUXJwkqSgyHNmiI7DjAvwk3reJvVhJ2hOI3X7iX1liijZ5sz0Jxkndc6WaLqEaKtjUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4nXFU//aDpQNTiiaegNdEoOPEcBFQaFQ9Z2xPz1BUPxafh5n
	JVk/lw4Ylmkvl0Y3akGdEnqF11g9g1nXMoi5CR2raluFMllif4GYevqVI2OyTTc=
X-Google-Smtp-Source: AGHT+IET+0vELyEm7KsW9oEmuDW7zPdDf6jf3TBlkF/kr9cPCUkc+CwdRGdOhWWEp64VoteqqcYzgQ==
X-Received: by 2002:a05:6000:156b:b0:368:3f6a:1dea with SMTP id ffacd0b85a97d-37cfb8b5451mr2894809f8f.6.1727862789251;
        Wed, 02 Oct 2024 02:53:09 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:53:08 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 37/37] CI: Enable qemu_sbsa
Date: Wed,  2 Oct 2024 11:47:28 +0200
Message-ID: <20241002094832.24933-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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


