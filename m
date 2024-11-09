Return-Path: <linux-kernel+bounces-402552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7E9C28F4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8197E2839C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76063DDC5;
	Sat,  9 Nov 2024 00:39:24 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35D13AD0
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112764; cv=none; b=BuBMMRWXyMxSB2wLiWR3bIpy9n5++7vayq4sG11Y/va6aUBjCpLrGhddtSbOyxn+Vbx0SkyzJOqcr4ydEr+4FVg34CF/LqQyclYOJhWBo8k5DBXnTC0MZ5y6+GsmBLwbrzx5TpS28wepBQ0QGyvif2X5/mb6cBKVjKDxbwx4VfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112764; c=relaxed/simple;
	bh=kz7ZYtII6eTynbdUJEjkyMvp/ahHZ8PADv07sr+izxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/wxRVc+ZyPZDyLWzB9Yt2mKTpRfmBKGJ4iEcPSwpLq5myvubwFmPpmAqQNHROm8mq/ZmOn1vHZSAGMBa5eQiSLc61Fgqse/Ikw2ZnIO7Pe8DhJA8KRg83tR3S0t1myG5p6dLadb8XxRCb4bdKSFOrZh1n9BBFwLfhbidf11V3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1t9ZTn-000000004fJ-3dMS;
	Fri, 08 Nov 2024 19:37:31 -0500
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	kernel-team@meta.com,
	hpa@zytor.com,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 2/3] x86,tlb: add tracepoint for TLB flush IPI to stale CPU
Date: Fri,  8 Nov 2024 19:27:49 -0500
Message-ID: <20241109003727.3958374-3-riel@surriel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109003727.3958374-1-riel@surriel.com>
References: <20241109003727.3958374-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Add a tracepoint when we send a TLB flush IPI to a CPU that used
to be in the mm_cpumask, but isn't any more.

This can be used to evaluate whether there any workloads where
we end up in this path problematically often. Hopefully they
don't exist.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c        | 1 +
 include/linux/mm_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f19f6378cabf..9d0d34576928 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -760,6 +760,7 @@ static void flush_tlb_func(void *info)
 		/* Can only happen on remote CPUs */
 		if (f->mm && f->mm != loaded_mm) {
 			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
+			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
 			return;
 		}
 	}
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..6b6f05404304 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1335,6 +1335,7 @@ enum tlb_flush_reason {
 	TLB_LOCAL_SHOOTDOWN,
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
+	TLB_REMOTE_WRONG_CPU,
 	NR_TLB_FLUSH_REASONS,
 };
 
-- 
2.45.2


