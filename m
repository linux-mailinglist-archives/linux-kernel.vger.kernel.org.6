Return-Path: <linux-kernel+bounces-400489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1449C0E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2541281609
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180C217F57;
	Thu,  7 Nov 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lb/QGDWn"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D32178F5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006269; cv=none; b=pypdKWB7XhIpYUdLdEYC35ofzZ4UwFXovwVypMzF10QibPz2v1szDZN9z75vneIGuCZ6lVaYUBwOQfbZ5hmoCN3QZAAUGdAwA9ukC9JP3VToYTjAMRlZddL0rXST2YvYWRGkNQ1W/cW895jXVa5PuJ21wBX8Hc4XeECSevxy8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006269; c=relaxed/simple;
	bh=KDOpYvQvaexnS4ROlfUY/AOVb+PMrJotsVbv9tdnmmk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JnKzfQMLzibxTyOTsV3qa0Pk16GeBV0OvYhMhCjdxTLdkxDDOfmYPd/ITBG7hmHTT1UElDu9rkQZohYQMarZHQvnCSiCOWf65Is3u0iIwG6IGS3lVTwXeEbD/SO1daUvWj7vDuZRUlx4NfCgGUg0lS6TcemLXCxi14iWrAfGivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lb/QGDWn; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-83aed4f24a9so146983939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731006267; x=1731611067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8sUtURqCyFCOn8JOOFBrrh4KEoVslcfr90vq+LFgUg=;
        b=Lb/QGDWnLPqNIYp5cyBBAcApr667uZhyLg2fTzDMJsDrrs1HWoIdKtXf6ltPzIKOtQ
         0bq8NWVYL1ehknHtwM2sRvdIsZpbxpWfTyzSCn6GyFYyJlPK6US3IEr+m999I7EUAe2+
         WbTJ5h/ERzD+NnbeR3RgIIASHkiIiZcLotDfQlj/pS5wlhDHLfeowpTi5UguVmez9Qg6
         k1N//SkjZUGPSXNa7Jrcx5Dg/NB5ZZc+gQPtJAN8JO6B0Pxx6Ftf/5dIBi5gAemStEu6
         CJwlj2zQk5YJjPxwguiEvwZMqLvuSssyqEhnoV/cpF4wmcvbbxnGgicXdoKvB/WzoFjf
         ONsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731006267; x=1731611067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8sUtURqCyFCOn8JOOFBrrh4KEoVslcfr90vq+LFgUg=;
        b=Y/g7NNASmRDQJ8sdeyFTdsdHR+P+6485e++Y1fKnwkyX46J1QRsAvHvtAZCVfD4T/j
         FPWS3pKwhLQzfmuK9AJ3/auFuOIsmH/XOvkKYv21CaQYm8jl8Tqns9oB5i7mLYMTmC8w
         Lq97b5bqw+xl3TfFyA76X4VllJ3Q5REgrcTXnB2GD/oLvuIfV5MDw8cXJdzHNwX7B6Y4
         v6YIuNa3eGANM9t2E9s7kd4QjEo6FLI2UfD2D3ksoM7OEoBN8QyuaoZgxDVbiCW5zOVW
         MO51I+V+xg4VCzmkhi5aVeLimzdZEfZ1Y2KkpRLS6W6lwL2v7nReYGoS8qSv6bg5oaNf
         DQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCUXbtmSKboh/oSLecpHnBcOBADr649tY3ktDlFWGHpar6nPtx/nZZHXTtEnec/cyCqByoPCSQ8ZnP9F8yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSj0t6LNSQYV5rZSqPX7G1u+APtQik7kT+dRHDMbOOh+O66fry
	WQUVJ2wofi3h4OELwvLErbMRBl2JTrqN6DJfMFEJ9yr8olOW35zbWq4MlC3YgdZ4Gvu7icKi7U4
	9FoXsl/4tRrIMplw1QvEpFQ==
X-Google-Smtp-Source: AGHT+IEPRr/IQdodyqcpTfvB5PFu6DqvhssHdY7ZGS0GFH2h0T2KiHTqbilJA81LBD/MlyV7/G5K+PfGhK0HNCVbEQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:890d:b0:4db:e85c:f17 with
 SMTP id 8926c6da1cb9f-4de6a5fdc31mr24173.4.1731006266688; Thu, 07 Nov 2024
 11:04:26 -0800 (PST)
Date: Thu,  7 Nov 2024 19:03:34 +0000
In-Reply-To: <20241107190336.2963882-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107190336.2963882-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107190336.2963882-4-coltonlewis@google.com>
Subject: [PATCH v7 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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
index 6b4434dd0ff3..26aa26482c9a 100644
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
index ea8cfe3806dc..ddcc2d8aa64a 100644
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
index 488e8a21a11e..115d1c105e8a 100644
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
2.47.0.277.g8800431eea-goog


