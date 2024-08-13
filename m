Return-Path: <linux-kernel+bounces-285598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E544951023
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07FC1C216BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE41ABECF;
	Tue, 13 Aug 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G5gn162j"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE31A7058
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590147; cv=none; b=DoZfjQDOdoRu4Xhkc7ELH4phFULpdvwRbfHb2srrGiTxchcMkdLdDm8+KItngBDwTO3+O6OMmr36+vVx0LoM22BQ4+BUyNVHInGlxQkhKLLXgkRW5xylH0kf/Gx7nCeRcMxzZWVfyG0aau0A0J38vp0HoK0VdFfmyrgkBnNymPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590147; c=relaxed/simple;
	bh=/t/KRCtxUOjdtqgOTwia+D8mTRhtgwlB/ao8pdbfRk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U091LXAwTij55ASEakxm2eSZonJ1dT89CpWNnNPXG0PRUmEqBTD3JgAa2rAzyXoJaFx2TLo8DfcTsIUIECfXUYhs0ygdKP88CYwa/ZCMHIAHj3BHjCo0SgYQyCT2hU5+Hb7TR9EHJSwAqIgonhC95z1bMSCAtlUs6fn2aPa43jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G5gn162j; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc566ac769so53919715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723590143; x=1724194943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IUndmlmZzl2tlMh3Yo+jIlV35FPKi2+kCo1jVfCObY=;
        b=G5gn162jUNUJClK+CHJS/UBXVCTTMd9gDv1Qk29B54QF9I5DfHIg5sHTiOZKgqnJAc
         DSmjPoG62DsVQjzsi1Mf3KWh7S6bkyNpoK96eJQOuAJ/LMZvA1sQn5P6tUUXYev43dDl
         pGpL3DGYTOBhlomgC1THe+iw6mK/bF14NnsywQ17yy1xtB72XtR8VmlCNT4t++oaL+aI
         EuM9zxG2vMYi3x+PVlu2pV/rvgJXJhrSdsh1eTJZsDNAWlx+htpJu7BmApuw5qE/3e8O
         z1/uER6Q69Q/B/ROO5bhrzkPRzS6qv8uwLXzmOdTyw/stebRfwCs0GmWNTzdOS1Ft/wq
         8i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723590143; x=1724194943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IUndmlmZzl2tlMh3Yo+jIlV35FPKi2+kCo1jVfCObY=;
        b=pf6nwuR1enbJQMJhRfr6zdxUYLkcUziPs1C5jN4VpaxiuyJYHaUPSi+03NKKAfvm4U
         4bNJax/pLmz2g84VtfJOAJFkxAPeln3ifN9DvCgRvBQ6Xk7sxh0+n0Q8V360d6vHDdZg
         S/Mid6higEczfuXGbs+bqHyUN7ncERF592uVDcKnIiqoqOjWE7Qiz/94Ov5ciWrwJ5jU
         M5ieGxG7ISlvEukFiIU/gsDlzKcYGVlAM/DxVVVBNhnYvNonZmYyhwKqFv5AluvIBed4
         fzNX4zrgFNq68id6DC8rxl+DHcKs14Ft1RsSykyZPqWKXDswvA0Jr8LtS765kiYSWL76
         mjMw==
X-Forwarded-Encrypted: i=1; AJvYcCWETRZ0fGsKflV8kbZjztIqRhQ/jZyXcdx2m0Fd9UCuKBaqLvyXD7GjZm4t9a4KEnpGuq4egvEtgdKuh6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/okQEcK3re8r8b0upEII6HzWFuIggAgYG0sTOyOQdTNRjeupb
	4dVWwxvQyngUPPVFkqAezTqowH4mrMcCiYmTLDAeOTffaG6o5TEZmwMqM+Hbqpc=
X-Google-Smtp-Source: AGHT+IHZrKsit5w7xSudUQbEUYReqqQn1YgN1QevFMTqRHuzKJC7tS9IAzN65JZbLXqBdbKYsF5m/Q==
X-Received: by 2002:a17:902:c409:b0:1fd:a1d2:c035 with SMTP id d9443c01a7336-201d642a46fmr9888915ad.31.1723590143287;
        Tue, 13 Aug 2024 16:02:23 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e0659sm18522475ad.297.2024.08.13.16.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:02:22 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 13 Aug 2024 16:02:17 -0700
Subject: [PATCH 1/2] riscv: Disable preemption while handling
 PR_RISCV_CTX_SW_FENCEI_OFF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-fix_fencei_optimization-v1-1-2aadc2cdde95@rivosinc.com>
References: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
In-Reply-To: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=/t/KRCtxUOjdtqgOTwia+D8mTRhtgwlB/ao8pdbfRk4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9rup7/rWhQYedOna+rk5cVYabIzHPq1PYq1ouLvNeF79
 T+3vDPtKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCIrFjMydCtumP13P4/a0UfS
 /lsnpKm6PNogaPD0/2RZJhu9+rvqlowMeyPeNHiZbwyV+VN6b/0CuYCoaUmlOQKFl3JKNlncL/N
 kAwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The icache will be flushed in switch_to() if force_icache_flush is true,
or in flush_icache_deferred() if icache_stale_mask is set. Between
setting force_icache_flush to false and calculating the new
icache_stale_mask, preemption needs to be disabled. There are two
reasons for this:

1. If CPU migration happens between force_icache_flush = false, and the
   icache_stale_mask is set, an icache flush will not be emitted.
2. smp_processor_id() is used in set_icache_stale_mask() to mark the
   current CPU as not needing another flush since a flush will have
   happened either by userspace or by the kernel when performing the
   migration. smp_processor_id() is currently called twice with preemption
   enabled which causes a race condition. It allows
   icache_stale_mask to be populated with inconsistent CPU ids.

Resolve these two issues by setting the icache_stale_mask before setting
force_icache_flush to false, and using get_cpu()/put_cpu() to obtain the
smp_processor_id().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6b9391b581fd ("riscv: Include riscv_set_icache_flush_ctx prctl")
---
 arch/riscv/mm/cacheflush.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index a03c994eed3b..b81672729887 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -158,6 +158,7 @@ void __init riscv_init_cbo_blocksizes(void)
 #ifdef CONFIG_SMP
 static void set_icache_stale_mask(void)
 {
+	int cpu = get_cpu();
 	cpumask_t *mask;
 	bool stale_cpu;
 
@@ -168,10 +169,11 @@ static void set_icache_stale_mask(void)
 	 * concurrently on different harts.
 	 */
 	mask = &current->mm->context.icache_stale_mask;
-	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
+	stale_cpu = cpumask_test_cpu(cpu, mask);
 
 	cpumask_setall(mask);
-	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
+	cpumask_assign_cpu(cpu, mask, stale_cpu);
+	put_cpu();
 }
 #endif
 
@@ -239,14 +241,12 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 	case PR_RISCV_CTX_SW_FENCEI_OFF:
 		switch (scope) {
 		case PR_RISCV_SCOPE_PER_PROCESS:
-			current->mm->context.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->mm->context.force_icache_flush = false;
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
-			current->thread.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->thread.force_icache_flush = false;
 			break;
 		default:
 			return -EINVAL;

-- 
2.45.0


