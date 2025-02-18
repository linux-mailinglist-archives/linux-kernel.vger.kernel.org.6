Return-Path: <linux-kernel+bounces-520182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C3A3A6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B168176687
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FB41EB5C2;
	Tue, 18 Feb 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHNLrt9Z"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588B1E521E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905196; cv=none; b=O+CPUg/RE9cKOb65yx5T/FpSXZa+xSCCKYbL61lx77Ee81cdnK4JjnPReKjJfuvhVatnKQzD2FZrCmJvysNdVDK1B0o8o5HJm7OZoeHySXLYmjC0R3zHUnsmg7OyYNFGB6/9lrCKE2/hzzT/erAHbuGvyNzPlPLK0fJHAEOrz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905196; c=relaxed/simple;
	bh=MUX8NCacaOOOA4OaGPglasYy9E+dcC18HNOKsMX/PsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H3S+XVwGVMHK+7P8aVGQWlf+hWVlTpCfdXg1UD13YfuyNtAr5HOebLic3goZgRUc3XaS7V4idPWJssxkwIRoPRox2mRLr3PhMlnmEdPxcvd88Xxl/DaM0vPYKkqqFd/iyHd3cWn/Zu8ImqLhohS2e8EYiuVu6mliXfArYSJ2CEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHNLrt9Z; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso35857f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739905193; x=1740509993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0kpBhbfXxtZzDMHLag5RRsggHKY1KhBdZYwLBVe1gQ=;
        b=kHNLrt9ZK1f+vfEYV+m5R9qiMOXid3Bi9yQ0CtJkkaK8aWkFIzS9+JAfRYbXvhM1aO
         Yr8t1eyB8ZAGiNYWM5lKiiOd7E2mTXmzCxzzSLpqf6TiMvLpaIFskPldj2S77VL1BYpD
         UehPfgHBRrLKdNW2dBqXtqeNiQk+L5dYx1tj6Usc4ddQjRMkev6/bCBdEPzx2Se/57G7
         yFI5akvoWxcvwqqZDFV1+TM5zscF0ewBLMP0DwpIxOFf847mepATJbniaKOD0rj9SCgx
         humFX9cqoLWbmdTUR1nr9n+gnY8sJm2N/vab08q2of8mQMt63HHO4+m9ivNuKr94WzdV
         T8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905193; x=1740509993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0kpBhbfXxtZzDMHLag5RRsggHKY1KhBdZYwLBVe1gQ=;
        b=SgnG9JYLxyw9QZP87ILecKgEvKKKKGfANfC2V6n7mi4flRNCRsXPzOevJtZMkp8VcH
         LU42DSd/0YsOfJxiWUIsg6veNwm7kXbw5F21bbKLOvW84IvMgUrCP3xS7w55DaymtxfQ
         59n1RHMJnBOjqTVhSXyuxClgYP9ROoOE/dYKVLG/tK619jbhcaVlV/bDACzRDXkYWOG7
         CWYKwcRmirOSQH0ms01BllHciMms3IeByWH4edry3Oo5eAg/Wvp0WqM35GAjB7r9R0aH
         C3CYQwvGzld9tSx940K82OowfaOSEYo6Sr7ENiAH4SUeMAxw4UTXav3CLy8plLz0kiD/
         cjJg==
X-Forwarded-Encrypted: i=1; AJvYcCUC9DyTHYEewv3Hwgw9ZF5LDSFmc3Abp4zn+dTavHFqpsEIlxD9H5OqKYKS0fI0QpIGT0e3ycNwhKhMOKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8L/Uf7nfYFVAUizufW8bL/M1JOtdr3mBIkn/cqjPySSGpHqxj
	KHyw8hHMzUYitNAWXd2aDxBSdsqx9ZM9R81Prwerr7eRshSQisLyn0uWxiVyBmhgjH2mCOXaGFm
	mPX5Wt7W6EQ==
X-Google-Smtp-Source: AGHT+IH8NmujlT/kHbLcbrDIh4TdqTEkbJHgI3ziVHNlXWsjC5xp2dgiGsl9Qlu/Bsx5dLWERlz6Up6uxakhtg==
X-Received: from wmbfp16.prod.google.com ([2002:a05:600c:6990:b0:439:8ee3:e17b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:47a1:0:b0:38d:d274:4537 with SMTP id ffacd0b85a97d-38f57bf8a25mr729075f8f.7.1739905193562;
 Tue, 18 Feb 2025 10:59:53 -0800 (PST)
Date: Tue, 18 Feb 2025 18:59:41 +0000
In-Reply-To: <20250218-force-cpu-bug-v3-0-da3df43d1936@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218-force-cpu-bug-v3-0-da3df43d1936@google.com>
X-Mailer: b4 0.15-dev-42535
Message-ID: <20250218-force-cpu-bug-v3-3-da3df43d1936@google.com>
Subject: [PATCH v3 3/4] x86/cpu: Add setcpuid cmdline param
From: Brendan Jackman <jackmanb@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

In preparation for adding support to fake out CPU bugs, add a general
facility to force-enable CPU flags.

The flag taints the kernel and the documentation attempts to be clear
that this is highly unsuitable for uses outside of kernel development
and platform experimentation.

The new arg is parsed just like clearcpuid, but instead of leading to
setup_clear_cpu_cap() it leads to setup_force_cpu_cap().

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Notes:
    I've tested this by booting a nested QEMU
    guest on an Intel host, which with setcpuid=svm
    will claim that it supports AMD virtualization.

 arch/x86/kernel/cpu/common.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1241c205b9d0..245807f9351d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1479,12 +1479,12 @@ static void detect_nopl(void)
 #endif
 }
 
-static inline void parse_clearcpuid(char *arg)
+static inline void parse_set_clear_cpuid(char *arg, bool set)
 {
 	char *opt;
 	int taint = 0;
 
-	pr_info("Clearing CPUID bits:");
+	pr_info("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
 
 	while (arg) {
 		bool found __maybe_unused = false;
@@ -1505,7 +1505,10 @@ static inline void parse_clearcpuid(char *arg)
 				else
 					pr_cont(" %s", x86_cap_flags[bit]);
 
-				setup_clear_cpu_cap(bit);
+				if (set)
+					setup_force_cpu_cap(bit);
+				else
+					setup_clear_cpu_cap(bit);
 				taint++;
 			}
 			/*
@@ -1523,7 +1526,10 @@ static inline void parse_clearcpuid(char *arg)
 				continue;
 
 			pr_cont(" %s", opt);
-			setup_clear_cpu_cap(bit);
+			if (set)
+				setup_force_cpu_cap(bit);
+			else
+				setup_clear_cpu_cap(bit);
 			taint++;
 			found = true;
 			break;
@@ -1579,10 +1585,12 @@ static void __init cpu_parse_early_param(void)
 		setup_clear_cpu_cap(X86_FEATURE_FRED);
 
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
-	if (arglen <= 0)
-		return;
+	if (arglen > 0)
+		parse_set_clear_cpuid(arg, false);
 
-	parse_clearcpuid(arg);
+	arglen = cmdline_find_option(boot_command_line, "setcpuid", arg, sizeof(arg));
+	if (arglen > 0)
+		parse_set_clear_cpuid(arg, true);
 }
 
 /*
@@ -2014,15 +2022,23 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 }
 
 /*
- * clearcpuid= was already parsed in cpu_parse_early_param().  This dummy
- * function prevents it from becoming an environment variable for init.
+ * clearcpuid= and setcpuid= were already parsed in cpu_parse_early_param().
+ * These dummy functions prevent them from becoming an environment variable for
+ * init.
  */
+
 static __init int setup_clearcpuid(char *arg)
 {
 	return 1;
 }
 __setup("clearcpuid=", setup_clearcpuid);
 
+static __init int setup_setcpuid(char *arg)
+{
+	return 1;
+}
+__setup("setcpuid=", setup_setcpuid);
+
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,

-- 
2.48.1.601.g30ceb7b040-goog


