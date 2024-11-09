Return-Path: <linux-kernel+bounces-402555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B149C28F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E451F22A38
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C458C0B;
	Sat,  9 Nov 2024 00:41:16 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E023D2FB
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112875; cv=none; b=sdBZSOg8rFkx91Mn+Y40PeYDvPYTjmGm8DH4Xi7UL6VfIF+C7XY4yl6yCvnqxRa1sLQbFHn/KASvaDAtMSvTMMPHSRR2ZiCh5rXAAoVyKDaXtpq9ZEcwtu4vPN4g31is0x8ofHQVmvJv8ozzDzruj4s8rxkssvGnfdhv3OvB000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112875; c=relaxed/simple;
	bh=JtIHa05H+TvMS6BNLUEQp1cr0sM/AOO7OMAcZ2ebl20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irHiQPFX+QekCiHeY+ViCra/eotQyIv5jx4XYUiKFvcrtjldJDioncpuDleVK+uvUN3SVlAf/D75Nn4Lf8C8U+awce20ZcexE7U+/gTCITrJ+FGOp5tikjp9rosE6/gcFerJQ4tNmc+v0yKk5JDZmAWEnEdJkRoUslmZvIFGph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1t9ZTn-000000004fJ-3hQW;
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
	Rik van Riel <riel@surriel.com>
Subject: [PATCH 3/3] x86,tlb: put cpumask_test_cpu in prev == next under CONFIG_DEBUG_VM
Date: Fri,  8 Nov 2024 19:27:50 -0500
Message-ID: <20241109003727.3958374-4-riel@surriel.com>
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

On a web server workload, the cpumask_test_cpu inside the
WARN_ON_ONCE in the prev == next branch takes about 17% of
all the CPU time of switch_mm_irqs_off.

On a large fleet, this WARN_ON_ONCE has not fired in at least
a month, possibly never.

Move this test under CONFIG_DEBUG_VM so it does not get compiled
in production kernels.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9d0d34576928..1aac4fa90d3d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -568,7 +568,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * mm_cpumask. The TLB shootdown code can figure out from
 		 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
 		 */
-		if (WARN_ON_ONCE(prev != &init_mm &&
+		if (IS_ENABLED(CONFIG_DEBUG_VM) && WARN_ON_ONCE(prev != &init_mm &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
-- 
2.45.2


