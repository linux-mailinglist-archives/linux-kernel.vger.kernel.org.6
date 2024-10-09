Return-Path: <linux-kernel+bounces-357427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C999711F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B201F27431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF21E2840;
	Wed,  9 Oct 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqxlR1Ad"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973921E2827
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490149; cv=none; b=X5PyJpFmvTW4Rcajk50pZUqEWDsij9EdSG6GAF2ign87nXbZ2z0BADVlVlqEtzWCIq+4od/c9Y0rnHeOdbqz3I0o08rHO3gYj8knvbW6WPdzvwOEFlQXmyDLlrlbPGRYLRp44p704ax3GwyvGkuG42kV7SA0yZjYESld0CCF55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490149; c=relaxed/simple;
	bh=n8f+eWsGmScuFwG5dDubDwigdZfb6CilE2zs5pzESkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYoBcAXPIAAs5PuKXfDugO2AdjsYP/QkUoqgx8+tdMPhu9FcleL3lhVtv3HPFhQJcAiCMBS+wxLeHSyChY69Bgmaw4Q5bB8Mny8B9om2RFvPjNWhPVTjSe6CHLssvUJGAc2hFLY0Ajv7YWEHCw1QDDCjy2dMZVTpWuABWylOYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqxlR1Ad; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso8085729276.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728490146; x=1729094946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4os8DmpWomyhdXT3uIE5sI0/fikMzrPBJolJZzSSPQ=;
        b=bqxlR1Adq1QmrIGrbhG/hIoWMB6bVQt03zRRiEYQRfiV/SkYjzltkBUw0eoCJ2JHQS
         zLf95Z2G3uiGsIQz34XEJX2jalMlOsy4njxoplguna7HHGoZbokOjxD90g3/b4Ioy3yS
         4ZrqmetmaYOR+eLlcWPC8wtyl9vizXr8gyEcZbquJPZ79a8acrFYWFyglP2/b+DZNKhe
         2cjykuQHE+P3ToS1rTX3SYleJIdwPzpnW+JLBQibH7g2YdmU/FyKY999S1GfcC/3kHDw
         3AIqkUEcOMEUbzpNlE3L1LvkzuREKw+uDTn+Ef91Uc5Ox3HduJ32Qe24MOMYwGWpgA6V
         Zrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490146; x=1729094946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4os8DmpWomyhdXT3uIE5sI0/fikMzrPBJolJZzSSPQ=;
        b=Zn1rhkS8/HmdfmR8C1dEIFwdpQVM0V4LirzGsuFemwRLgWUbjL6nJV64fxOjHZkF9R
         gArwceDpJBJGLv6+ZHE6NpDNgt33+AagxJDmBpqvJLLD8uxz0ztg1Jg0WkZtWq3wRiGC
         uaqwZGOGzSuTWOcQWCchSwG+K+QgAUDlVOrnCNH66UzqDS98CRQDZx+GQ5sakPojG7cY
         3kpDh9aR/Xk44nTpxJrxh381JSyqMUUOnH0hW6tsJS8GeQxGVMv7bHHIwXskz0pUvbin
         IkTZlShAI1H2nhHVgSYkVkSu69DJy+5ZsB7vzJFl2KHhE+nXvpz2f3CXL+qRAu8VlmkT
         2mzw==
X-Gm-Message-State: AOJu0Ywcnpwvmswz06UR1KnTTqYTA7w4EXbu+MuS7DZiX/cJi0/kBdTr
	lmUIBtJNxR7asWw4+lWasSIzolr/HJW/tNSgCHChzKgzOiJIP89eXSDJzxklFiiz4izpSFLM4wo
	JgJoupxFYDAnuSRWTAMC1RB4le/nk/4ywkjxrsZm6pLQ6W8rjIvGgY2IBpy98PTuHK6NN+y1hfk
	6KNHI0v79v3J4/XDD+ryaq838k+RyEIQ==
X-Google-Smtp-Source: AGHT+IFT6IBvqDFvd1nh9Nvp19An6mvh9GEkIy5aq6tG0DxKt0GfrpuME+IFqFwS7fy8QSz4NyDyDfDy
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:850d:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e28fe4edeb1mr2566276.6.1728490146127; Wed, 09 Oct 2024 09:09:06
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:04:40 +0200
In-Reply-To: <20241009160438.3884381-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009160438.3884381-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=ardb@kernel.org;
 h=from:subject; bh=iWMVWWds+djQXEXyMG9PXtB+asvAc5L9HBTrJQ9xUI0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t5Qzb+5vWNIRfeP0j+K0038QHKYoJW6Ocbk1xPSMu9
 /ZLNUtyRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIlByGPzxHlDuFHVdUrt/r
 MSct7e16de7eyB6v8DvPj7HsC2gs3MrwT9XpV2I1e25o/5H0axwpbNmz58ruzF5mZerQszMwWMW EFwA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009160438.3884381-8-ardb+git@google.com>
Subject: [PATCH v3 1/5] x86/pvh: Call C code via the kernel virtual mapping
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Calling C code via a different mapping than it was linked at is
problematic, because the compiler assumes that RIP-relative and absolute
symbol references are interchangeable. GCC in particular may use
RIP-relative per-CPU variable references even when not using -fpic.

So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
that those RIP-relative references produce the correct values. This
matches the pre-existing behavior for i386, which also invokes
xen_prepare_pvh() via the kernel virtual mapping before invoking
startup_32 with paging disabled again.

Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 64fca49cd88f..ce4fd8d33da4 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -172,7 +172,14 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	movq %rbp, %rbx
 	subq $_pa(pvh_start_xen), %rbx
 	movq %rbx, phys_base(%rip)
-	call xen_prepare_pvh
+
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	subq phys_base(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
+
 	/*
 	 * Clear phys_base.  __startup_64 will *add* to its value,
 	 * so reset to 0.
-- 
2.47.0.rc0.187.ge670bccf7e-goog


