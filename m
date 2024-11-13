Return-Path: <linux-kernel+bounces-408200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A9C9C7BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261D828313D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858C20697E;
	Wed, 13 Nov 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3ek19d5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACA20515A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524526; cv=none; b=tQ97tNDTYGVumw2SZHdvMlcBBgaT0cFANL3439vsPygOgonQPB7rhbgGzNr+JT762z1lr4fmtVmiyAIn1cAhQNskDQzl2OHp6P2OnaL74TbyCqfXXyquy812RxrBNGuu+FO/6EdoXTPYOu5UXkuIDIRHVBAaCz3dggUxIoCN94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524526; c=relaxed/simple;
	bh=zfHGGul4boURCIlF9sZ0v7jHEGbHHtIvQPtjpwKmZjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i7EViSOubz/lUrAJkuFStjAZK5qR9xSDMJTQMIxo67fFrn5Qz7FrYd93PFzP8ATL2+eUf38eoMooRmEqwQvtf42C97m7OrA/2BH4gOnMZdXdq/MBl2P7AkZ3t3G0lMTtaLAYrFPGYioxgwjY1Dbx9In0ateqTCkPeeSTyzAR6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3ek19d5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8901dff1so139437077b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731524524; x=1732129324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgqFKvoVHXye/CyIJghap8jc4W684iliK9zLYmCZ1Zc=;
        b=J3ek19d5SzafdyqjgJsw4UrEG6aw3LRaSJM1tbuEUPFryd5x39/u8EijyF+sGNPmKl
         T3XOzhBNeq6AIknh2HQDQO8RNdoPBlmeTcrJXtI14Z/cAxt7+z0ViTpYQ3RbFvxVlHIy
         gm0GC/27X5NwsIYsR1s5b0SaaoG653C+6L91sHUaPSbxaxr3KoY5ij1NIhUjnseI2YlR
         wo7HTwWI8U+ZFcO8NJ7lZ+IShIa9u1F40fukwfGJuE+qKA/OZTiyqldj7wiPnbcTr63J
         K8AtUR+ABYBT+fvfK53nZSP/KtcmvezGoV5XAGJU8Ku0Sy5FKPIcU6XKm53LX0UAlE03
         JdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524524; x=1732129324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgqFKvoVHXye/CyIJghap8jc4W684iliK9zLYmCZ1Zc=;
        b=VDKiX3xlZ7DVnvyz04o7gbwcPGfk/SHPajofjh5/G9QR2qGvaBAeK4xjZR3sGvdxuM
         Fo5NYY2ldDm7iT9WrZmvO7OeABa63vUh7Gm/jOxGqvMp+s1tdMMXP9gziWV+rhaUlHYR
         rFDeU9q2NjPa1sfSnXIKqDWmwMTK49joUznBlvQXO81gkbg0bHzGl5kAOJhVfoXF7rkg
         i9eHBakl8ZXB8V/xReObiGtvqTcXYpTGhxPxNWALCE68uj8x313C4bMtxxemHteAeld4
         E6N/hTzXefh8Vf+D07h/XA3o93xk1B19e9kbKu+9fb38I0Gn9JwvXGiFmEYOT+z5gcZB
         YXiw==
X-Forwarded-Encrypted: i=1; AJvYcCVl8mM4ruK70BKLTrBXd/MdQ2+kgJUbGsYHQCTFNZH8opqUcNIrhnikYF23QOFkiaO0+dO3JEk42F04Oj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBs5ReF9ZmdAPdmZUOsVvhvK3w9XnwhSiUWMnIccHKq0bLBKd/
	snHxyxvSvDw6pYspqFUnJ3QCzrXFAMIXs6yjBBDN30o6Zu1zUvi1SNmIBO6LKcRuI1dOI/wLmwb
	4FyeCGqoW2CyKu9kQ9syT7A==
X-Google-Smtp-Source: AGHT+IFNr9w/0dGnK6PRtslGYFp20zZooyO9LSsLAArex0mr+uzyM7no72zQ+L4NJiH7IrVQOwJt58oXd0jflNUvgA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:2411:b0:e38:c40:380f with
 SMTP id 3f1490d57ef6-e380c4039bfmr33947276.3.1731524524115; Wed, 13 Nov 2024
 11:02:04 -0800 (PST)
Date: Wed, 13 Nov 2024 19:01:53 +0000
In-Reply-To: <20241113190156.2145593-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113190156.2145593-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241113190156.2145593-4-coltonlewis@google.com>
Subject: [PATCH v8 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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
	Colton Lewis <coltonlewis@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Make sure powerpc uses the arch-specific function now that those have
been reorganized.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/powerpc/perf/callchain.c    | 2 +-
 arch/powerpc/perf/callchain_32.c | 2 +-
 arch/powerpc/perf/callchain_64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 6b4434dd0ff30..26aa26482c9ac 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -51,7 +51,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 
 	lr = regs->link;
 	sp = regs->gpr[1];
-	perf_callchain_store(entry, perf_instruction_pointer(regs));
+	perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
 
 	if (!validate_sp(sp, current))
 		return;
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index ea8cfe3806dce..ddcc2d8aa64a5 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -139,7 +139,7 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 	long level = 0;
 	unsigned int __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 488e8a21a11ea..115d1c105e8a8 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -74,7 +74,7 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 	struct signal_frame_64 __user *sigframe;
 	unsigned long __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
-- 
2.47.0.338.g60cca15819-goog


