Return-Path: <linux-kernel+bounces-408201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6449C7BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E23283784
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F911FDF92;
	Wed, 13 Nov 2024 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vimj57Zg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB820721E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524528; cv=none; b=s3BQPVGFzMQ2Jd/e/icMl5KWoyp3fMBM2CUOE0Q+NTgzGDDMaKcvUGhDEKsCPubnY/fRJamRR/1g81PS4TaJIiWf/XUuIvqYNfpeOILOvD8QRu2cCKOJzUJqKYdZB9HL8hdPTlkTfKtgb5t/ZbrEGW432FOCthvCQuCSz5gemTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524528; c=relaxed/simple;
	bh=OMb3jG971jmx2YJYYmtMd1jdhDZJTQd5uT/KvMEr7uE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gais3XCeyv+qmcKSDkw2fU3IBR7WHJ7bQuecwvw8NdJHgGmaKfr6TnOGDnRMLcAPdfrG7dcHS6hYnQowIYacMWg5EJM7mPyx6zt1ooCAN62/8i7HIORY6H0si7WsJvvbXh3ZIotxcfUE7mdtQmDUz5VyBs78Dznq6KVCdLzmjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vimj57Zg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea82a5480fso130130507b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731524525; x=1732129325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQFdXgHR/yBinKM9akC7F2JFw2+gnKw6F8HpNI5yy4Y=;
        b=vimj57Zg+4IsIh5ujxBbiF0Lv8ztyCCCO4dxWbLMKAqutI49nS4pMM3mvKHdNSuJTc
         1YwFavZj9xr6uWR6yGrraiMRaTJ8F6poPfBO2O0gXykTlGoIZ2j/WaC8amva+zaHzWQz
         hF8Go48gvYHMZKkIEeOBKbb4wXXs75PUz/WWAzogYjeyVKt69a4JwyOdsq+Y52ZxKDju
         cRh3Y/TElUbLgtA1maSZPlKl+zPp9USHCsdewiycps+QBgZBxJZdxRTOGIKy/UEbwYcK
         VffPv3ponYDxPgHR6cdWbjnOW7SpYe8vRGxI8pZOsEuHe0IWvrOXqrnoCsUeYDSG6hwu
         puAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524525; x=1732129325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQFdXgHR/yBinKM9akC7F2JFw2+gnKw6F8HpNI5yy4Y=;
        b=AipuhLyymdTga+MqShcbss4J5MUhGBzlL7kAWQajFv8KZKOz0guTID9Z4A/hnNKC9a
         rSQV9PpzmpWrmQ0YjjJemnvBxCfaLA6oB1+ThlC3f7VLHr2Qfc4pSgILDENLElL3WCFA
         NHsg69BESXE1Z/vfzYhMpXjNJNXR92dzOX4Cn2uvedMI1WUDcbYSiFsnhBcIcEJKz76r
         +lYev9n+f8Tj2zp+Ovsrz0q8SrLXUEaKAVeaL8yEUO1H2XEa7VNiW5EJ4xWL1KfhbSaA
         zIYzWqmTo4ZEDifJbDpLNEuV+ksld0w+sXbG4JivIAK9cd+Fb2egeSeQwnePp47GoS99
         JvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPGmc3You96qw/c5Yim6Fu2SfW1YmNX7cY9h3JGNrVOeYcjqb6gO9J87pZrq6tWbyf0mdE1YmiQ/iHTAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwC5ugYxKj0zPoe22lhN80zK7mC3fJHk/nkmEOyFmSurnd2ktV
	Fu2tpMtmQByc3r8p84UJRRvGIzD5g0N+8Z9NhaKVVMrNP9jAfrp4+CXXf6wgEypfVkQEwJhNPOj
	j+2LGnKaH80XHyh5xsMdVjA==
X-Google-Smtp-Source: AGHT+IFhulDvoY0sGq7EYnbunXmF/EqPCQ3tEG2uX7XcBCI6dgYlk8NlhbbJtWap3voWbgrqyi9w6iV13kRImFawvA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a81:8a44:0:b0:6ea:e011:f122 with SMTP
 id 00721157ae682-6eae011fd7cmr1805147b3.5.1731524525438; Wed, 13 Nov 2024
 11:02:05 -0800 (PST)
Date: Wed, 13 Nov 2024 19:01:54 +0000
In-Reply-To: <20241113190156.2145593-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113190156.2145593-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241113190156.2145593-5-coltonlewis@google.com>
Subject: [PATCH v8 4/5] x86: perf: Refactor misc flag assignments
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
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/x86/events/core.c            | 59 ++++++++++++++++++++++---------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d19e939f39983..bfc0a35fe3993 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3011,27 +3011,52 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
-unsigned long perf_arch_misc_flags(struct pt_regs *regs)
+static unsigned long common_misc_flags(struct pt_regs *regs)
 {
-	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
+	if (regs->flags & PERF_EFLAGS_EXACT)
+		return PERF_RECORD_MISC_EXACT_IP;
 
-	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
+	return 0;
+}
 
-	if (regs->flags & PERF_EFLAGS_EXACT)
-		misc |= PERF_RECORD_MISC_EXACT_IP;
+static unsigned long guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+
+	if (!(guest_state & PERF_GUEST_ACTIVE))
+		return 0;
+
+	if (guest_state & PERF_GUEST_USER)
+		return PERF_RECORD_MISC_GUEST_USER;
+	else
+		return PERF_RECORD_MISC_GUEST_KERNEL;
+
+}
+
+static unsigned long host_misc_flags(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return PERF_RECORD_MISC_USER;
+	else
+		return PERF_RECORD_MISC_KERNEL;
+}
+
+unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long flags = common_misc_flags(regs);
+
+	flags |= guest_misc_flags(regs);
+
+	return flags;
+}
+
+unsigned long perf_arch_misc_flags(struct pt_regs *regs)
+{
+	unsigned long flags = common_misc_flags(regs);
+
+	flags |= host_misc_flags(regs);
 
-	return misc;
+	return flags;
 }
 
 void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index feb87bf3d2e9c..d95f902acc521 100644
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
2.47.0.338.g60cca15819-goog


