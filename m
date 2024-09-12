Return-Path: <linux-kernel+bounces-327258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE999772F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8E01C24015
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ACD1C1ADC;
	Thu, 12 Sep 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1G8kQddr"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289051C0DEB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174299; cv=none; b=NnPtXR756KnkLWLSid7bBsUANYo9XpAGKrZPlqe488iU31VF1GopvWmZMnO8trli3RgSH7FpHyukS7k3TScwt0SFQJZB4sApypq+hwAR+u16xLBANjQVVtJNFHo+zGJWgEXS3+T5e7JpFTAEkxIRcWuyHMJ0ViD3nCB/F3I+01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174299; c=relaxed/simple;
	bh=kaODB7epwl9nHxQDNWBzHwOw47KDaa/Ux/Yg5uk1CV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iF1fBtGdG1rtaDRBJQPi2ijE1CFMk9J76PMD/DnXJXXqTxexih+6V80fu98XAlRDy3Y/r2wrHJRUmSLMbWa1v9ryoD4gK/PGYEV4GTr1sJZjX6gB6C8GrQukKNH/gWOaVG81mZv/JlIokpk7fNxQVjqHOGUVw9iFZjHNHsZ/ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1G8kQddr; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-82cda24c462so32657839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174297; x=1726779097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgNa1Xt6FnUSigDEF0LKTlfU3qkapsIsHTMTckjKajA=;
        b=1G8kQddr7iVoMgnXxRXB0y0npd2iM02NnCPHPKVnsljahSGSc2cO+aJIUmruvtO44X
         T17qacGJkebdvfKCqyDy4kTsslh4k1YFejivboBEL3v0oiYZ6qqcaJoO9IobQhjsByTz
         eDmYWEJfJ0GTv7QTVmUofNgSiTdjnutz+25vrF8ux3V4qvysOurnvyqdPdgTvC03G+gb
         hQxDVTFzV/V6SFe3eHzfUC43MwGGL4DJKdQLQ3ajPSWr66ERaylD9Wl+82T0Kfpt0VAM
         4pagemF7Ls5FhF6CxV+Spjoun9bAWPRXIg3V0hUBSTXy2VW6ofQ/lgFUNf5G/9QS4KiD
         vrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174297; x=1726779097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgNa1Xt6FnUSigDEF0LKTlfU3qkapsIsHTMTckjKajA=;
        b=UebBuKC/YH9iyyBo2IMITAA9nUAgyv7WwDzeQDnpYR10Y1k6KvzGrrmqOQiNeRAAP0
         JPlSflx7mfrTk8fpWw0gY4jlrGeFmCF5p7Cq//tHSf7WV1RDglIW/vNARr7w3xbaGgQC
         PqolkxHItNpWziziIG6K0ASRBqcX/ivorOCBnY3ZacbYjpmuFGMI8yo9KsM/HgULYQYa
         8mS1RT6Fpu7Le013zscZE3p8JHWR2lSxQ67C8qaaO5n063ps159tbWwf7IcmTLed2Wot
         4ZS4IkOZ+YFb2PjVtrPYozVXWWYSdfitahOFFkn6eJxRyTE9hdQ2DEd+B3lvD0y/OzMf
         1TuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6xASmHk/8Bwcse6/xyPMrxbqXrglaEW5BSXXA1hqo6DmLTbowjVJ12jjUqkC8eQKMoE+BBoNwdIMNtpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcoXdlaMrClscMpa1NWkgR2sneSxCA1TuCYvgmpzKoDhj1UGv
	3EyqzD6cfJEpkIzeJ0j5XqGWlX4jtjarzxUNrT775NDl6SDkwbFi4J4Trrpnl3zsQF1arf9xK2v
	5t/Ox+NZLGemsj+sfXeHPDQ==
X-Google-Smtp-Source: AGHT+IHFcuQ/5a/hhlw1GFJJYrc3if7U/QuDvmMiMeVXDMjRO3Gjmvd8L1tjO+zUGwBFmEAgEN40MjfIHW+YAT2pgQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:860c:b0:4d2:27c:18f8 with
 SMTP id 8926c6da1cb9f-4d36e33a768mr13751173.1.1726174297086; Thu, 12 Sep 2024
 13:51:37 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:51:29 +0000
In-Reply-To: <20240912205133.4171576-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912205133.4171576-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912205133.4171576-2-coltonlewis@google.com>
Subject: [PATCH v3 1/5] arm: perf: Drop unused functions
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
2.46.0.662.g92d0881bb0-goog

