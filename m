Return-Path: <linux-kernel+bounces-334592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D997D962
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90041C20DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE73B18593F;
	Fri, 20 Sep 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOes+V7b"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22218593C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854468; cv=none; b=cVsj9sC5cDziPt+ClUk4eu3VaUWgVPP9Zzt0CQ9p5gqjOH3BaiFGs9tk+idQCGMP2fm8laTWGwxuJv2n+7R/ZfmsU9NLdO1PFOiu6CxqrHlxBDDiAN+km1Ct8pAskx46UQTOFK2vf5mf3B9fIPOSDyiumiWAUHWFCA+IOajIjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854468; c=relaxed/simple;
	bh=5Y45c2QmHSpUy9kSzxpEB6TrwN4M0m5LC0e0soV2VJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDoYqq9FnjmaRfaUtWKgSwI8sxgXNBZif/K4Y3OKpML5da6O8ZNw62of01AEMK/pfHGNrZvW0GqCW/wEW/AfFqXI+qkVJLIk7KoVL30EZfOy6Q+t5qkBqfPjrA1RFsrEHYGYCiQ//GjuwReP/drBstsbumTC06CgIHejoN/cVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOes+V7b; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6db7a8c6910so35469907b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726854465; x=1727459265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1u8+tIRQu1/+Yzznd3YfSwPNzKiT5HV8vjSuz+hJEoI=;
        b=XOes+V7b4gcvPGJspGP/yH66Z4ldoO9nIrNChrXsLrhCuEtyeliuUNM3uo1n0Nkfec
         fZd914OwYo/S2uChohP9eBbReV7AJGywg3H9WZGDshYYwiC2Ko3X9S2CIv9GMZtfTwJT
         tJfKFuKg7jWDcpUFHnXZuqzmRrnJV4sSxfn02GhwgsytbVqwYtTMuuF7LJN1ZbFTd+sB
         MfD+/eQwCL9H+YbLx/409agznXm0j6rH62balzvCzPoS3ftzBZZM40+MQVTDnSyMd9K5
         y16wMbpxQ9IaEULEDZ8/RV87CIiEeEQByb7Dz5mmUIgDlm7owP3b2cssGpfNJlNb1G0M
         UOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726854465; x=1727459265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1u8+tIRQu1/+Yzznd3YfSwPNzKiT5HV8vjSuz+hJEoI=;
        b=YPyVYNWjjZQIwfLP6OpzOI2d9o0so1DwYrtbfSqrwJu3AaK68QidqnisWluqbn36Qy
         FR2pTg8SgrgxqQmUf5tkiPWj8IoI5OIquq1Kv8DqvGlqvpuJDzb1NTbwbxEIE9Z+VplC
         th2HzCmpWVuq5xeIhjCjZmChnpjdAgTHutd3e2nV5kd+3t+qyG953OtXS3k4xPIZv0Ye
         iCseWxKxG6ChCC6Vqf9yRLEJhS0vdPiuN8Xf5yyRyIkfkM8fPdSHQLC6ctgPgLLzFl75
         FYCBL4vIauvFf4iFAPY1ASH2Jzo9V9Mx109pgtvE3pwdnnkSPQIvMWlm2jWtGmfdEjxE
         OeGw==
X-Forwarded-Encrypted: i=1; AJvYcCX5iGxJEtWVawN8B1nnkRgeydWnJ6fqud/dCrU3O2Tu5QcyIO7RWF/C2njAu4jantVHzl2RBN47kzLlgug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbbhNKKZGYMr9RoO4yjM6kGf3qIEUFnkjZ/zgi9NiqbDIeeoZ
	GLq4hMYe+iCghTVbZES957gZbiG9SbLzKCZPoZh6NrSHd2ZaAWIcrEsrfKruez3WdZ6TMHRzrT+
	K/3Nf+nqZo7rmAScEhk28Lg==
X-Google-Smtp-Source: AGHT+IEMZpgFL+UVav7e6/78nxxqsZh8RtB34P8KhO4E9lrAtqCCPkLcHN7A2NJ63pZVH3cqvvVs3DKnxU1JZod0ig==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:c503:0:b0:e17:8e4f:981a with SMTP
 id 3f1490d57ef6-e2250cd6079mr6801276.11.1726854465133; Fri, 20 Sep 2024
 10:47:45 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:47:36 +0000
In-Reply-To: <20240920174740.781614-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240920174740.781614-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240920174740.781614-2-coltonlewis@google.com>
Subject: [PATCH v5 1/5] arm: perf: Drop unused functions
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

For arm's implementation, perf_instruction_pointer() and
perf_misc_flags() are equivalent to the generic versions in
include/linux/perf_event.h so arch/arm doesn't need to provide its
own versions. Drop them here.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/perf_event.h |  7 -------
 arch/arm/kernel/perf_callchain.c  | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index bdbc1e590891..c08f16f2e243 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -8,13 +8,6 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-#ifdef CONFIG_PERF_EVENTS
-struct pt_regs;
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
-#endif
-
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->ARM_pc = (__ip); \
 	frame_pointer((regs)) = (unsigned long) __builtin_frame_address(0); \
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 1d230ac9d0eb..a2601b1ef318 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -96,20 +96,3 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	arm_get_current_stackframe(regs, &fr);
 	walk_stackframe(&fr, callchain_trace, entry);
 }
-
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	int misc = 0;
-
-	if (user_mode(regs))
-		misc |= PERF_RECORD_MISC_USER;
-	else
-		misc |= PERF_RECORD_MISC_KERNEL;
-
-	return misc;
-}
-- 
2.46.0.792.g87dc391469-goog


