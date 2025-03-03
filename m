Return-Path: <linux-kernel+bounces-542095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A268FA4C592
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386F13A6E34
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E5215041;
	Mon,  3 Mar 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GY3aUJVR"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE7214A89
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016778; cv=none; b=soxEF2JfO2ds2acrgSAO7mgdrI43Sg2+LOjdk07TFgaH0voU47HoxeLTpxn7JPVgAcDR7F0nqZ3jOE5FaMtXN0fByh8pFxkN5BWfB2rwukP8H64Ge3m2Y5g2MZfej2H4eQTV0NugesWVvb3qH8eXRpMx7lLlJnJm11Zcutj24pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016778; c=relaxed/simple;
	bh=S70MGT7WeSA7tjkqhDaEgU+jdWjSqastK3E10iIj4g0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b68e9SKRwys0+Wzx+Zd503XsXhikiVPdP6aLphO9ndAxKEG/J3TeKl+qsAA8E+yP37Q5n1xUdVlMDewpVuyxF9sasHU8MZ3sHOj2RX261FyAvRj5VWRWMfCCQZ/eaeei0Vdh5Um+LGd9CQxNFtn2p0wLP0lSxcB/lCJyNGT8uEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GY3aUJVR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390e27150dbso4341217f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741016775; x=1741621575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P49Y5v+BDqKqasSAEFoZNR9dcrLWq08OXY3NI7AD0ak=;
        b=GY3aUJVRU9/BrlLGxK1Ow+NIsSQ1Le/eaUAriGDtJHSEVHCFN0AKKD0oJIVRLJ+1jZ
         WU7T6wtl2HM4lRWcB+lzueaXdUsc2QOPv1hCqkl9auS+bwbWhQBRqSnp1/dMWK4U5rlF
         qQFZl/32h7kigrS/MF06G85kMd0QDUPqQemldtToQc8KTiiZNHwNgdPvx6rBu7UinJC7
         LmRpv2t/F5gmlLn42+nRSj7KGCP29qTWf7u4onMMrrZ26hrb9m78afvABWtK3jUS2roP
         fS+/dvGxRZknR4USARP//BIazk+wSp3h1/DaMuPTQeQYerr3chpEKSBaac7iIxAGYsar
         Awpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016775; x=1741621575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P49Y5v+BDqKqasSAEFoZNR9dcrLWq08OXY3NI7AD0ak=;
        b=VNvP003JBx8DE1eS8LCmyHoWh0I61eHEItdEfX8zsK+UzJ5fKUMHFpBnIQFUVT9ciF
         dQTePnqwnpsrLl8/E1rmyvKrJSjq6qEnQzqI498zc0N1/Tn5HFAwZ++L5GhZ7U9b8o5P
         +TSUV4FDMF9geaLdUMWA59IPnUrqQs2bP8xuVcmxR1qZx3F177oGlxDv1OBB/3cNh7qV
         Q93zDfFI4OHVN5Jd+LrjmqqvDddvETqeSPyU2gkG0UkK6gKAt0xbaHhH9bglm4nBfX73
         oh+T2bYN/QPjF6yMNAzfbmW5UahQLapvTZDv/0vx9VqSCtHYqOYxfUin6FYcicKDM0Xl
         nEww==
X-Gm-Message-State: AOJu0YyFl7azphQBsGhkqXqlTUNcWjrGIUIMcRYlWj6IagYgJW/pXknA
	MqrtbOrJPkHhEowEjeuqoC2Cat+GZ0T9/MwetpcjKLmXIwm327CcvyDEnHtBHa8cOrsM6KpkBv2
	IkalnamJjPA==
X-Google-Smtp-Source: AGHT+IEecm+RqoKWOA5gCS6PAN2M5jdRufGHjF3Gxbp8Fea8R1wBqK7KvCYM9/yX62yXN6ISEMmvG/wOOPLd+A==
X-Received: from wmbjh12.prod.google.com ([2002:a05:600c:a08c:b0:43b:b2de:9bf4])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:598f:0:b0:390:f902:f961 with SMTP id ffacd0b85a97d-390f902fa79mr6803977f8f.45.1741016775619;
 Mon, 03 Mar 2025 07:46:15 -0800 (PST)
Date: Mon, 03 Mar 2025 15:45:38 +0000
In-Reply-To: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250303-setcpuid-taint-louder-v1-2-8d255032cb4c@google.com>
Subject: [PATCH 2/3] x86/cpu: Warn louder about {set,clear}cpuid
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Commit 814165e9fd1f6 ("x86/cpu: Add the 'setcpuid=' boot parameter")
recently expanded the user's ability to break their system horribly by
overriding effective CPU flags. This was reflected with updates to the
documentation to try and make people aware that this is dangerous.

To further reduce the risk of users mistaking this for a "real feature",
and try to help them figure out why their kernel is tainted if they do
use it:

- Upgrade the existing printk to pr_warn, to help ensure kernel logs
  reflect what changes are in effect.

- Print an extra warning that tries to be as dramatic as possible, while
  also highlighting the fact that it tainted the kernel.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kernel/cpu/common.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b5fdaa6fd4c4ff7701009a0443ff57332503bc77..c1ced31f976d970efd24d6c9e4ac77cbff3371b9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1479,12 +1479,12 @@ static void detect_nopl(void)
 #endif
 }
 
-static inline void parse_set_clear_cpuid(char *arg, bool set)
+static inline bool parse_set_clear_cpuid(char *arg, bool set)
 {
 	char *opt;
 	int taint = 0;
 
-	pr_info("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
+	pr_warn("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
 
 	while (arg) {
 		bool found __maybe_unused = false;
@@ -1547,10 +1547,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 			pr_cont(" (unknown: %s)", opt);
 	}
 
-	if (taint)
-		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-
 	pr_cont("\n");
+
+	return taint;
 }
 
 
@@ -1560,6 +1559,7 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
  */
 static void __init cpu_parse_early_param(void)
 {
+	bool cpuid_taint = false;
 	char arg[128];
 	int arglen;
 
@@ -1594,11 +1594,16 @@ static void __init cpu_parse_early_param(void)
 
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen > 0)
-		parse_set_clear_cpuid(arg, false);
+		cpuid_taint |= parse_set_clear_cpuid(arg, false);
 
 	arglen = cmdline_find_option(boot_command_line, "setcpuid", arg, sizeof(arg));
 	if (arglen > 0)
-		parse_set_clear_cpuid(arg, true);
+		cpuid_taint |= parse_set_clear_cpuid(arg, true);
+
+	if (cpuid_taint) {
+		pr_warn("!!! setcpuid=/clearcpuid= in use, this is for TESTING ONLY, may break things horribly. Tainting kernel.\n");
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
 }
 
 /*

-- 
2.48.1.711.g2feabab25a-goog


