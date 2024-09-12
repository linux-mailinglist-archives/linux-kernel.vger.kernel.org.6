Return-Path: <linux-kernel+bounces-327262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1D977306
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103561F2315D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4431C1AAA;
	Thu, 12 Sep 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCXewt1C"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127771C232D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174304; cv=none; b=p+ne5gsu0GSms88rXpzK/2dYQWPzjWOZQWI3Yl0fP5ehC7Ou3JTH1f4eeMXwmve0odDZVlE251ZooaaksVAWlplBjdleQ2TweaNvWNsoCHl9GPLg8pWNR5gBMCc/V7WBmcJU+6VTAGtXI+UxN3QfSrUPr29+X0h+X8l6CjEeTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174304; c=relaxed/simple;
	bh=i95QDLsU5GaO2Xej2TBOmg9Wex/kOoppvJv8vIvwjAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2aWWaB5m4+dlF0HjZSpKFPESWzHPoMhslT49wMk1avkwCjMcgco01Kxe3laKUS8J/mR86ngdGOxKHpYcvR09Zy+IMatfOYh+k4tWvyyj0fOhMrfP5alpj+7Z9iZ6187DMFoWHksc8NiIrmCbw7XmAD9+URtQLV0SCdzd3BFcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCXewt1C; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-82aad3fa5edso170087439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174300; x=1726779100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HOlQ/b1Vqnby1HRrJAa+4JPh1tcBF4UxpW0vveqy4M=;
        b=VCXewt1CC9UaN5dOanDSbbVO3yQwrg2Vn2SGqCNZ27+DR4GNcap4uwBDbtyGUNeQBv
         kIcP3Wb0nJ8AoeNWHVUl/eJ6q4c4n4FXg68SnFACIfCy7hLvMAWmeIwx9Tb4Eeft4wF/
         5OC8/YjI+xdGf/4hTE986GVf6criVXw3YYZPB/wVSVODdODfj0C8hwHLSlWROcneRjnm
         Ch/wImqL67EQefOyfc4f7tuajtv7KPacrzdLl2t8XEQc4uFBIw2ePHzXwUavjF1MIz08
         A8Q3hVk/Zuiigmk2xqmwhOev9pB7slONM/vWcpdp+2LJxoem/gU4WCqPGdoJbmliYTsW
         bg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174300; x=1726779100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HOlQ/b1Vqnby1HRrJAa+4JPh1tcBF4UxpW0vveqy4M=;
        b=Ff1yJmjbLSExn169Xtpwz0AxfpKdbTJKBUoKnzfqxIdIFQeNz2CNLlcMdcVgMq0C2t
         kecnR6OqskBtlHAj/NObdcLIkWcij4tOfN7bBkMemsYHTeunto74FFBMK/V3NLU8aEnH
         FsVTTlRRiIn80Q4YajJ3Rwe0iy0UjCj0h/CWvQYigHAT6Sq23DRtzYGQ7cFmh6tzmlt9
         vRIlTlhf1UbsSYG8TYKmd9LeUdAIUK19QdcnRz4U+u5t2AuSpbWPEjCdyS7sJKjAvl6+
         1tSrgqMv9opf3Eucu5hYHeKHXMBxWq8ZfXunnQgGgzs3J9oxofBCjWrOOHMrahIDkbz9
         eYDw==
X-Forwarded-Encrypted: i=1; AJvYcCXiVlcyF2vTa4e/BMjiDxPFemDuFpg4pl77z6XS8YHyf5HvFJF6e1t+FcW0ZOUzvQCuAhOECQWYsI9G3FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcfpwfG8A6YPBPRztrvYOcLfTXEKjhlbbuc3AdJgWyicSYs4G
	o9+btQyt7qNZeYR+yryKvWYqyNvsfsKZbVg7W1NRCtORJ5m0w51XNgwGEs7827XqTEJ7jkyezQw
	qSmTMLei2JV3gq28PGOsq4Q==
X-Google-Smtp-Source: AGHT+IH+tyLe1qQliN4X6ik9ZMj1aIgWQ7X0DXUSN8bntx8eM08UGo31hDfdaqtl4MXbxod/0+xFT0h7PePUGuXbpA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6602:2d86:b0:82c:eb15:1aae with
 SMTP id ca18e2360f4ac-82d1f8b0c0amr3300039f.1.1726174300197; Thu, 12 Sep 2024
 13:51:40 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:51:32 +0000
In-Reply-To: <20240912205133.4171576-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912205133.4171576-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912205133.4171576-5-coltonlewis@google.com>
Subject: [PATCH v3 4/5] x86: perf: Refactor misc flag assignments
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

Break the assignment logic for misc flags into their own respective
functions to reduce the complexity of the nested logic.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/x86/events/core.c            | 31 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 760ad067527c..d51e5d24802b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2948,16 +2948,34 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
+static unsigned long common_misc_flags(struct pt_regs *regs)
+{
+	if (regs->flags & PERF_EFLAGS_EXACT)
+		return PERF_RECORD_MISC_EXACT_IP;
+
+	return 0;
+}
+
+unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+	unsigned long flags = common_misc_flags(regs);
+
+	if (guest_state & PERF_GUEST_USER)
+		flags |= PERF_RECORD_MISC_GUEST_USER;
+	else if (guest_state & PERF_GUEST_ACTIVE)
+		flags |= PERF_RECORD_MISC_GUEST_KERNEL;
+
+	return flags;
+}
+
 unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
+	unsigned long misc = common_misc_flags(regs);
 
 	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+		misc |= perf_arch_guest_misc_flags(regs);
 	} else {
 		if (user_mode(regs))
 			misc |= PERF_RECORD_MISC_USER;
@@ -2965,9 +2983,6 @@ unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 			misc |= PERF_RECORD_MISC_KERNEL;
 	}
 
-	if (regs->flags & PERF_EFLAGS_EXACT)
-		misc |= PERF_RECORD_MISC_EXACT_IP;
-
 	return misc;
 }
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index feb87bf3d2e9..d95f902acc52 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -538,7 +538,9 @@ struct x86_perf_regs {
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+extern unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs);
 #define perf_arch_misc_flags(regs)	perf_arch_misc_flags(regs)
+#define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
 
 #include <asm/stacktrace.h>
 
-- 
2.46.0.662.g92d0881bb0-goog


