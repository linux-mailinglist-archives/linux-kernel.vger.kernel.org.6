Return-Path: <linux-kernel+bounces-266139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7793FB94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9291F238A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E691891A5;
	Mon, 29 Jul 2024 16:41:36 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA43187560
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271296; cv=none; b=DvSdQxAr7J3s0T6q7zHlyHAi8MWKRe4cr/dOnHeCJ97u1lEEPQNxbhJJWZDmXSOXEwYstMmvcXLQGjttleFJ8cYcT2Sx6Zl7IF1IRRqmLAQfdyE/Zh+jYg01f6fDTtEm1rMdnrRdXRtiBJCrVtU4kMHaY4apVHKlK8hnQWQCCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271296; c=relaxed/simple;
	bh=FTre/e3fn3hyD3jRCA2ZvzDYgi4xwsifr7Qe5cJtE2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2Aoxswj2x7IQ3RcrDYn0tOi+qe72eTgkVHdP5l2IRQrBUZgzwCtkpVf/wwgYUGMAqtxq8AuT4i5aKuxkNgK8JpqVr0CzbQLov2j0mzdVYeOuhEjlG1ZjNkwdE9XC2ZkIAe+J/k7/LY9gxqvNSZP1X+asO2kxrUuGcyQW7mObn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so7618527a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271293; x=1722876093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evLP27LRDak9xTMM+NeoFegFwyLuyGvYckpr0RLlsRk=;
        b=d4cM7bwjtonMJUyPWdu04Oddmbb7QQ/XnHC49sArlaXw2gI1NV8zI1UbimTL23eNDV
         EOswGrOlITERNCDx7ZJjkfgvHddGrc572zf/MHbSNTRtKgMMGdqsUBexv/iUq5KfXkbW
         6E1VETf1CWaM478qlDyANvl33xGLs+Ns8DH2tIUtA7sf4vYDFX64ZXcMWS5dCKD2zwvn
         QRmBw5ap/fZ7bfj4NVs9VztyXUTB/WiUDlLQRPEp1iLhLMzkNJvtZqLTIgl2cDD82/VJ
         57ESkMvHx+3R9Pn+OLtswJlChYfQ4qlTr9UIBtPOBjkKPta99mfIZmWjpqVDJzQx0xWz
         /1Cw==
X-Gm-Message-State: AOJu0YxaW7ESR3Q4fme8draGqvRvI2Vzek1tK7fj42qu/3D3zpJx4uVW
	c8Dv/k/3DbsdfPiY0i6Be70nNM0s9DL/6FkZB7qE/+UXGrBRUvZY
X-Google-Smtp-Source: AGHT+IFYK4x+eYK9ZsqY4/muHpp3sLZrMf8qTMCB4YbfQkmMmdlT0zjIxmimKq4HzKbxd04hffxXWg==
X-Received: by 2002:a50:8755:0:b0:582:7394:a83d with SMTP id 4fb4d7f45d1cf-5b018be38a5mr7643434a12.12.1722271292655;
        Mon, 29 Jul 2024 09:41:32 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af507c6e9bsm4687457a12.54.2024.07.29.09.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: bp@alien8.de,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] x86/bugs: Add a separate config for Spectre V2
Date: Mon, 29 Jul 2024 09:40:56 -0700
Message-ID: <20240729164105.554296-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729164105.554296-1-leitao@debian.org>
References: <20240729164105.554296-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the Spectre V2 CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 12 ++++++++++++
 arch/x86/kernel/cpu/bugs.c |  9 +++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 22d324581a60..33e125a28f79 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2716,6 +2716,18 @@ config MITIGATION_SPECTRE_V1
 	  memory access bounds check.
 	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
+config MITIGATION_SPECTRE_V2
+	bool "Mitigate SPECTRE V2 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V2 (Branch Target Injection). Spectre
+	  V2 is a class of side channel attacks that takes advantage of
+	  indirect branch predictors inside the processor. In Spectre variant 2
+	  attacks, the attacker can steer speculative indirect branches in the
+	  victim to gadget code by poisoning the branch target buffer of a CPU
+	  used for predicting indirect branch addresses.
+	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
 config MITIGATION_SRBDS
 	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8292a96d376c..45cbc6f994ca 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1452,17 +1452,18 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
-	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+	enum spectre_v2_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
 	    cpu_mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_CMD_AUTO;
+		return cmd;
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -1472,8 +1473,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-		return SPECTRE_V2_CMD_AUTO;
+		pr_err("unknown option (%s). Switching to default mode\n", arg);
+		return cmd;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-- 
2.43.0


