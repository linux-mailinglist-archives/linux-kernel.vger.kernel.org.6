Return-Path: <linux-kernel+bounces-237840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0895923ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26D61C226F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE01B583F;
	Tue,  2 Jul 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="li8YvJfJ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E411B5821
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926511; cv=none; b=Q1WJ6ZSYxr3uZfwQm1K2KCNxl2pcBDM1IMQVJT4mkD8ew7y7bbg2OebLPzdFcQpuoAKb4GN0hXapGIVqdKSdmZwvZNP1Er/4YBJKFx0VLI4QNzvYt0cAV3vogTlVT9qSHADeRvUk3eKRVMBK7L5WvFHqCOWwsxNcLYAGk7tUWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926511; c=relaxed/simple;
	bh=j7Qmfb+KncipAfXGjnaDNp38zFjC4buoyZEXrJwxEP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uq2NA8btDI2jbDB/6I8Z2fc6nG0X07M4tZpEB1e86c7R2zV701WyKSa3cGMb14Ko1jj6K9ye7QBRp9/8vec5cqW8Bshp0bBgqA1zhRnxKr793gx1h5vKLaRubeKvQvU1u5LNe8qu5f5R8UTnCgwl/tyjKBRZ2YkrX15dS5nEdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=li8YvJfJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so6746138276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719926508; x=1720531308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE+7BbB3PE5kkYQMGtkK8hHnOxQPaKRTiUn2+3lo1Q4=;
        b=li8YvJfJ+2JPxUwfPpoPw05WQ39BJ+Obm5BMRuMJfLL3ICsJonM6/liwzVWirv+vQp
         MHGOZICYFZK+4vs6M0v17IKm/5OTjSrRHwyEgn5jwp16mxVdDQbUfVeirKtZ/ZYs5wWc
         gms9qhWDQjVMN3+IaE18hpR/6v9yq2ozQDdIq38h42mRBOlXGwxYpkc7FpOfWntVbIeP
         hfXbXWt04V4buK3TpqeIlvDmPKdecZN/Z9soC7/XzjVb58711g9OMCAq5waDz6wyBh/G
         GELijuLXMfguhkmachhVdjjs2FOZC8cnD9rVRnmxG+Y+fY3ZeJNIAKnKU0GI9e3HYt4h
         g9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926508; x=1720531308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE+7BbB3PE5kkYQMGtkK8hHnOxQPaKRTiUn2+3lo1Q4=;
        b=iPrnSYpzV4R7lHpYjpLgG5uQuNeC408PLNjHmSBInkM5KFnZFa2Vyu6ow1txfvuize
         hzlhkzgshnz7ttf/M4h+0WoUs2R/7ytuk4NQbUd5vJsNqVv/u/O+spfPMZD5c6wxeHMt
         4lGnL+oC3Mmb0gt6ZXVW6uxdkRm2P3j92KiRI8DGuU2rZFiX0SXAvAcKy2ScjHUMcxjf
         iTLrvIQHTOyQ3406y6bvzBSQw96Tyt2Wdbd6pBYsp8jKzzZMdhQM4QuaZQADEfsV4qaQ
         WsDhESgiLAHuc1/mmIgyi6wrH8+TiPTqYsXOus0oz/G2MSpJaYBGuDBY8o1Cy4TJmbdf
         nMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVMHhWLMU0B9izpPrCIdD6Nw0giQwk+pPGeO8ADqA3fpOS+o5xsb1WLJKVRDD9sB8/EVFb6QOqnssiBdYNPfXY5YuLnVJYvjqEU9bH
X-Gm-Message-State: AOJu0YxKMmFZ26b+64osmX42UQBXsg+PtZJ2ym39nCg45M6fcEbH63b1
	OuzfDtAVnOakMYDj/loRx61B5UdDxOBtn9W3yENgCDLOG8WeIf7d8rMbXBdaaE7rVuCDjJs1JdG
	GH1mPzCL3Wrfjo1breA==
X-Google-Smtp-Source: AGHT+IEqYo+qKpL7nHdD6wl5aRfdtl10keDX5LkNKDvlJA032DzVMnyh1cjIdyzuauJzkL055yfoCx7EJnhJcG3G
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:10c2:b0:e03:a5a5:3204 with
 SMTP id 3f1490d57ef6-e03a5a534e7mr542276.6.1719926508503; Tue, 02 Jul 2024
 06:21:48 -0700 (PDT)
Date: Tue,  2 Jul 2024 13:21:39 +0000
In-Reply-To: <20240702132139.3332013-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702132139.3332013-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702132139.3332013-4-yosryahmed@google.com>
Subject: [RESEND PATCH v3 3/3] x86/mm: Cleanup prctl_enable_tagged_addr()
 nr_bits error checking
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

There are two separate checks in prctl_enable_tagged_addr() that nr_bits
is in the correct range. The checks are arranged such the correct case
is sandwiched between both error cases, which do exactly the same thing.

Simplify the if condition and pull the correct case outside with the
rest of the success code path.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Change-Id: Ia4f78de99d02f8ce28787346404d59ef13ca3d92
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/kernel/process_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 26a853328f2d4..c62098332f05c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -831,17 +831,13 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EBUSY;
 	}
 
-	if (!nr_bits) {
-		mmap_write_unlock(mm);
-		return -EINVAL;
-	} else if (nr_bits <= LAM_U57_BITS) {
-		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
-		mm->context.untag_mask =  ~GENMASK(62, 57);
-	} else {
+	if (!nr_bits || nr_bits > LAM_U57_BITS) {
 		mmap_write_unlock(mm);
 		return -EINVAL;
 	}
 
+	mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+	mm->context.untag_mask =  ~GENMASK(62, 57);
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
-- 
2.45.2.803.g4e1b14247a-goog


