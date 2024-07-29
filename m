Return-Path: <linux-kernel+bounces-266132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537493FB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3351F1F2308B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA5C17F4FF;
	Mon, 29 Jul 2024 16:41:21 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582615A4B5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271280; cv=none; b=uVWxb8XQy5z6hAOHiq2HQXq/Ts+6Ea1561jCSg+XIcfEXyQ1GifCJg1N301T6Ew/ENvvJTPxTJlJEuYBTJoCIf505rBDk5YZU3w/XWwIGBrtMgZJ3PirCJxs/ArksRd1bZ6cBlNOGi7BCnc4uUOAxrvYU9MpOklq8atxiokBprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271280; c=relaxed/simple;
	bh=6rcMagJ7mWbCEq35zb7pMeRMD5LXdRD0AysXQUEy7Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOsCw5S3dyqlfWF2REUGUDMfoOGzG9M1eCvzgTtbR9bYSYvxZnx1LkIkYdx4+CtOmxcFYHDKLmyLZYqO4KDSogBfGepsScHlzvg9IT1JidouGB+qRDSzsn+5diPwk7LSfnXj4BnPu+hNVJMym7D2sHABzFSYyOFFW00wXItwwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so426406666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271277; x=1722876077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2j5jkjNn2B0/XVzt+Dt9KYJOFlfA2VHs6r7IWJt9nQ=;
        b=DY2bw7wXIihnLyN8vnfnaV6C0Kpx/WmH0OQMrZpQGm6teYpRRPFxYmLgbN303U8zSZ
         9eNYXD4K3QL9giaHw7YJACMib5bfAsP2s0p3qt0DdWDtCxwLPGytdP4eYaskDaP+lQS5
         2fHxGkkTLL6iCF2+nZ9O+xOgvjohZX+A88UB+3WeNEbc/98pBwMCRQH+o5OqLzVnTzbW
         NGg8HqgsJIHw33g6lqDxRK0+qN42o6dcVaR5rpCiKES+j/tj7eHUSJnJYy5jaJwAZEoN
         8EPcnfjT8hGGF3VOKqAtt/5a32nmDprKimJI3+p1UWMZ357gABTQUdzw+niRECvl+ke1
         IHsQ==
X-Gm-Message-State: AOJu0Yxp11/01Yu4BSmOmHut8lOmJQV3wzsxT3niaRLycj3zU9ECnD7k
	4XxJaMlo7dCRaxm8MzPcS+quEs1DhYyGPO6YQmxf7qXwsXzA7g5M
X-Google-Smtp-Source: AGHT+IF+MZIu/xl68Na6XzN3+Qbkw27J7pAi6f3W23QeGMj/hVOZB7S9FCINqfXtuEAcE/t3I45O1w==
X-Received: by 2002:a17:907:7202:b0:a77:e48d:bc3 with SMTP id a640c23a62f3a-a7d3ffa1f5cmr699463066b.19.1722271277239;
        Mon, 29 Jul 2024 09:41:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de47sm531016266b.67.2024.07.29.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:41:16 -0700 (PDT)
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
Subject: [PATCH v4 01/11] x86/bugs: Add a separate config for MDS
Date: Mon, 29 Jul 2024 09:40:49 -0700
Message-ID: <20240729164105.554296-2-leitao@debian.org>
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

Create an entry for the MDS CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 9 +++++++++
 arch/x86/kernel/cpu/bugs.c | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..36e871ab1ef9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2650,6 +2650,15 @@ config MITIGATION_SPECTRE_BHI
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
+config MITIGATION_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffers.
+	  See also <file:Documentation/admin-guide/hw-vuln/mds.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45675da354f3..dbfc7d5c5f48 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -233,7 +233,8 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
-static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+static enum mds_mitigations mds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
-- 
2.43.0


