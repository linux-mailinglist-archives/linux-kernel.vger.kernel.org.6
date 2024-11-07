Return-Path: <linux-kernel+bounces-400490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6EA9C0E51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28861C228E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088C218334;
	Thu,  7 Nov 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwFhzOVq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D621791E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006270; cv=none; b=HvnD1I+ce3vCasODHsQndH+HulvXjbluFiSBdrdp7nWCcIUfhtZT1rSBgesBdOuVWcxnhyJLRnQS51XY9o8b4Sw5f9dNJG4Eph4Oiq7r7xYVAvTTAYgUosjXHCyJ+azyw30M6iz6IWWEYGrru0bZjcWW2vcXelCsVo0384ccj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006270; c=relaxed/simple;
	bh=7U9jlZ4qr/SgQtzb8uGojyX0Uf3RH5gEOm3dddm5pyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aq4iwi8I0Ff6uWTvI2f3lZJKlYAgQTEkLwhinDMLSM2X4f8snLLAQOcW7B9PT5OZFC+IcJY0MNnXMLUcWf9CYkUcqDCQgAIKV/PcbcA/mf6n7wbg6jzGAmYGcoHQynvSnIZZ/Bo+PyY2nNAu0HBc9ygWfLk7l3T9ZPp52S/0VdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwFhzOVq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so21847797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731006268; x=1731611068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmIA3zzAwF29Of1RGzzoKivdDO9cfxtkZLWZ4k8wrj4=;
        b=LwFhzOVqlfxglbWqky7YM7mkDqIS9rp2X0Iu2W55AA7gYf3acZw4kR0WF4g6+8NF6H
         w0FJ6dOYlwndJH7iiiUEP9qgMeYYLjFFP09x0etNRdHrsQtVs3OCjEkkhoCE0+aQiApq
         yko5Muzqh+IYL/LPBHq3ErCKlbPPtsxdiwC7daw1zWJ/7HFhg+oMv0gm0GyTtRXcl+o5
         rxohn27YYJIL0KZ7F4aWvmZ9AniZhdJsF68jqoZuHH4BU0dxDtqi+Djvad/7cm9flEpB
         7/4WgzrZROFOIsU+ORQQ/S37qYXizrN/aaeiaYuQOKxmAE8hdh19IuEHCRZ3ZOV3g/WC
         v3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731006268; x=1731611068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmIA3zzAwF29Of1RGzzoKivdDO9cfxtkZLWZ4k8wrj4=;
        b=eFasemWOIpu0lky8yUFDT/nc1ck7B8FNfj9czqHjrx+aYAFkyLGtWi+3HbuejHbYKq
         QyYixS7XmckdfFb8ppszZMD2nZcmbDVenjyY8Vaw/l0BEPWpP3m7L4fjE7mF4ndu7k7x
         g+TBqYtxYu4BIaZyh7JRSRCSS+3Wk5Q9l02+u6kzA5tmSDzzfehSOGvPG55SHUmacHt8
         zaFfurGZ/ie7KSY9g1BfxUgfdWTYVKzrYjpFm4dBGRGsOWbtX/RCBm2QXLVuwFaPxV5A
         /BG4D0sD1n02nqSHgDJVAKbabuj6XvT32F4D6CweOWWUwVcIrkHo2tbb715CVhJsHrZD
         6TZw==
X-Forwarded-Encrypted: i=1; AJvYcCUB87KaQ8wI7JoOu2S2SLUMMvY+7OAx4wFNnpXuV3TCSN2Z8mf9oKeZckrfUAUW/OroXt+Khbq30iAOrK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBykGPY8cE7aIucu9luQju656nrdEymtAOWsYOgLJ2HuOIrTQ
	HlaTg9nKe2iUTpPU3hEDzKgjFf30l2FaCgOuoQnDwHychdQmBDzc3fizO43u/ydgp8YIw5Tc6W/
	pTUfq7KCDwzASGBYvQx0rwg==
X-Google-Smtp-Source: AGHT+IEPatL83aR4PMUsob9OXifW5dvDcVQBE6blGQgqqGrE/g3o0tifuLtLw5ypjY27t+StHZULk6h1q6SQXWXUfw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:968e:b0:6ea:34c5:1634 with
 SMTP id 00721157ae682-6eadb3f8a54mr13007b3.8.1731006267878; Thu, 07 Nov 2024
 11:04:27 -0800 (PST)
Date: Thu,  7 Nov 2024 19:03:35 +0000
In-Reply-To: <20241107190336.2963882-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107190336.2963882-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107190336.2963882-5-coltonlewis@google.com>
Subject: [PATCH v7 4/5] x86: perf: Refactor misc flag assignments
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
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/x86/events/core.c            | 32 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d19e939f3998..9fdc5fa22c66 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3011,16 +3011,35 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
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
+	if (!(guest_state & PERF_GUEST_ACTIVE))
+		return flags;
+
+	if (guest_state & PERF_GUEST_USER)
+		return flags & PERF_RECORD_MISC_GUEST_USER;
+	else
+		return flags & PERF_RECORD_MISC_GUEST_KERNEL;
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
@@ -3028,9 +3047,6 @@ unsigned long perf_arch_misc_flags(struct pt_regs *regs)
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
2.47.0.277.g8800431eea-goog


