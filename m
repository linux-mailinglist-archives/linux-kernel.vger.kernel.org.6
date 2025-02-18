Return-Path: <linux-kernel+bounces-520181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A49A3A6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B92A3B80EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB39B1E5209;
	Tue, 18 Feb 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjX01HdD"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231351EB5C1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905195; cv=none; b=L/LkgPNw63vdwAmbzzpq5baEx+sAPgMm5IkHoA8rcdfy2vwOf0vMC0yquD3Dbr+ppl67aHk6R4DOZcaJlgtC6OOtHVD1byAxUpNguJL0G2ZhDaBM8ayKiNUrTJZexN3dFxHq+9eKxcz6567AmNYQX3H9hv4cq1g9erEPxB2iwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905195; c=relaxed/simple;
	bh=NFINkBrN2m68Dtkx3Nfr3I9LAK5YDzkBgvburJpx9/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVzpfxDTwev9iOMufuLi709aVC1I5IXPZbe07EK0VJZ9KQT/WAXP8Wzrwsib9FvnDtc0SdQyFEkgSWIRedBSi3DkYZ3ASbZk0OfR+1q35nAGjTXW9qL7XWN5rMj4Yr5UHtNouu/cS8LtRfTWZZ5mFBEoVT9GNi+mPpXsJ7b458I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjX01HdD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-439868806bbso297355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739905191; x=1740509991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkbFzOJ58R3pRGkmrijokUluuUu8ft2s70MHpEt0/Gw=;
        b=TjX01HdD3DsToVuHJDa4WLAhY73RMYo7V8aQgK1lq7ZHIp8JxjsRT7ElA4b+kkLCzI
         SRQ4+eEmjY1lHFOCswCRBWpUOo1FcT6VDLNmAd6nPAnwKR09wQNMwkutzJp52iEoKRDH
         MBVlrBgk6psOF9Omecb+xcvEfPerzXsV/BIpHQMwOFoGU4DznZxtaffuDTDpgJetR2X3
         VI0em5hq/JMl7MjUYQk1FKqSo/nqmfUreDgYYPEvgqxUOrto7Ww1OjgUQbwY0BBffPn1
         OCXtx0VVNUnY9M3TYrGflNERTK8rgN80Qu+DMwsFoUUbvlkg/CinKi3CaYYkOlD4HJOd
         Ul5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905191; x=1740509991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkbFzOJ58R3pRGkmrijokUluuUu8ft2s70MHpEt0/Gw=;
        b=bjsITUe387lvAs5rYEVOhFG8Qxq+n4jye4Trz6GNTL0y9Yo66YyZmXVYbqDEXTFsJ2
         LTW9pX/VPxdZxy0rNlspAolVhwE/STW1C2sFbVVGmqbmIWcPBwt1Zt0/lkK8rM8xKh6p
         76QtJ0xGrfllh8Ulxz/OonkL726N6ero/ZFOZCq6o1pSRfjapwmc2d1aYKeJkUd1Mu+Y
         JrPltg7HKHf9G7wbGdxTMQ6xAEfPf0evwAOLTHzcSbhbDhR042QIMzQlZLNaL2rJb0G1
         BvC8FLA7LeJbV6SbixOmmy77VPj45cNPXgYDJT+0UQ+D2jvrTY9sDlNM3WnS5XlR5ND+
         QbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8+HGXX0n+HedtltMkemkPQkQavq9cs5GYEVrDkeI1nPS9wfmCGybHvIt/ACQD6e8hjBOBK0yFgZ3+hBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86OpQlR6HYxMXjHC2Qtmd+Ar9lDDbhOTL4uvTFK2mnyda95+s
	wDS1ppQ0xCiHOrvA6iWqrZR7vGvFAviy4NWfS57L0zPKncDPPzVTYX5GZjb8I+uoSVOtaLwHjQt
	qte+rO067lA==
X-Google-Smtp-Source: AGHT+IFf4tjcTsmeHv6vxo8C5qfpFSz+rGcmnB97J0xvK8kvFs8Ha8/XW4av6zciXZGnqt+HKgZKQBfIVctZ/g==
X-Received: from wmbg23.prod.google.com ([2002:a05:600c:a417:b0:439:95b9:9200])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4449:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43999ae18f9mr8268715e9.6.1739905191596;
 Tue, 18 Feb 2025 10:59:51 -0800 (PST)
Date: Tue, 18 Feb 2025 18:59:40 +0000
In-Reply-To: <20250218-force-cpu-bug-v3-0-da3df43d1936@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218-force-cpu-bug-v3-0-da3df43d1936@google.com>
X-Mailer: b4 0.15-dev-42535
Message-ID: <20250218-force-cpu-bug-v3-2-da3df43d1936@google.com>
Subject: [PATCH v3 2/4] x86/cpu: Create helper to parse clearcpuid param
From: Brendan Jackman <jackmanb@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This is in preparation for a later commit that will reuse this code, to
make review convenient.

Factor out a helper function which does the full handling for this arg
including printing info to the console.

No functional change intended.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kernel/cpu/common.c | 97 ++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f96a3a4829bd..1241c205b9d0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1479,56 +1479,18 @@ static void detect_nopl(void)
 #endif
 }
 
-/*
- * We parse cpu parameters early because fpu__init_system() is executed
- * before parse_early_param().
- */
-static void __init cpu_parse_early_param(void)
+static inline void parse_clearcpuid(char *arg)
 {
-	char arg[128];
-	char *argptr = arg, *opt;
-	int arglen, taint = 0;
-
-#ifdef CONFIG_X86_32
-	if (cmdline_find_option_bool(boot_command_line, "no387"))
-#ifdef CONFIG_MATH_EMULATION
-		setup_clear_cpu_cap(X86_FEATURE_FPU);
-#else
-		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
-		setup_clear_cpu_cap(X86_FEATURE_FXSR);
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
-
-	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
-		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
-
-	/* Minimize the gap between FRED is available and available but disabled. */
-	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
-	if (arglen != 2 || strncmp(arg, "on", 2))
-		setup_clear_cpu_cap(X86_FEATURE_FRED);
-
-	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
-	if (arglen <= 0)
-		return;
+	char *opt;
+	int taint = 0;
 
 	pr_info("Clearing CPUID bits:");
 
-	while (argptr) {
+	while (arg) {
 		bool found __maybe_unused = false;
 		unsigned int bit;
 
-		opt = strsep(&argptr, ",");
+		opt = strsep(&arg, ",");
 
 		/*
 		 * Handle naked numbers first for feature flags which don't
@@ -1570,10 +1532,57 @@ static void __init cpu_parse_early_param(void)
 		if (!found)
 			pr_cont(" (unknown: %s)", opt);
 	}
-	pr_cont("\n");
 
 	if (taint)
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
+	pr_cont("\n");
+}
+
+
+/*
+ * Parse cpu parameters early because fpu__init_system() is executed
+ * before parse_early_param().
+ */
+static void __init cpu_parse_early_param(void)
+{
+	char arg[128];
+	int arglen;
+
+#ifdef CONFIG_X86_32
+	if (cmdline_find_option_bool(boot_command_line, "no387"))
+#ifdef CONFIG_MATH_EMULATION
+		setup_clear_cpu_cap(X86_FEATURE_FPU);
+#else
+		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
+		setup_clear_cpu_cap(X86_FEATURE_FXSR);
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
+
+	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
+		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
+
+	/* Minimize the gap between FRED is available and available but disabled. */
+	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
+	if (arglen != 2 || strncmp(arg, "on", 2))
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
+	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
+	if (arglen <= 0)
+		return;
+
+	parse_clearcpuid(arg);
 }
 
 /*

-- 
2.48.1.601.g30ceb7b040-goog


