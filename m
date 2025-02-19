Return-Path: <linux-kernel+bounces-522582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C541A3CC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C1C1898CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AFD25A2CB;
	Wed, 19 Feb 2025 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HqeY1Asg"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE125A2AB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002927; cv=none; b=AW5vnZsJJgRAe0yyudb3GjI8avbt9cZ2m/ho6HM5Oi2gLq4hCZeNBH8M8qTp6OCRV4z/SjTKDTWhbvgOUS/3Kv8m95BeuzGYjuhjME22zJ/fm1DH7uYQVBovYoYQGRxnkCGfCUx9aJxS0yK/b3O5J8JfuMCcVU+C1C6Y+0VtHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002927; c=relaxed/simple;
	bh=eRr1Dmq8O02AXPN/fkzwMA0sWBd5Pt33yaY5NPBM6tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qReA1mOmkcH1XH+8YWo1k/p/kwgNiSzz99UG2ZJi+ahYIwEIu4DrKAdzfsk+XXMC4K4+Gl8hTYP2mm0JfmYxhgZ0CyQAD6jr8Hb6Nq81WuTHQiSS3MBVUQucixSIcrXjZUa1aOWsDGDQFe2d9S57162+1ljoA4iKGqQQG6x0m5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HqeY1Asg; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740002923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+v/2kXpvCQAou9vsL9jw3ye8Vh42VkQiI85C+TXQhX0=;
	b=HqeY1AsgDlJKsCzqVfrixzaYMyYcmClcdW8nRk6x1ZhGnG52EbY6YwLWBSrYYQN9ZSjEAW
	1gJW0tC37t4A3VPn/RWRiQUsrXY2YI/oxS/CxH2SJLtUg2POGvE3cG/lHIj3KWDuytXSCD
	h49EQAfKV2DiLlVWBZigVjLYqmkFERE=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] x86/mm: Remove X86_FEATURE_USE_IBPB checks in cond_mitigation()
Date: Wed, 19 Feb 2025 22:08:22 +0000
Message-ID: <20250219220826.2453186-3-yosry.ahmed@linux.dev>
In-Reply-To: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The check is performed when either switch_mm_cond_ibpb or
switch_mm_always_ibpb is set. In both cases, X86_FEATURE_USE_IBPB is
always set. Remove the redundant check.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/mm/tlb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index be0c1a509869c..e860fc8edfae4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -437,8 +437,7 @@ static void cond_mitigation(struct task_struct *next)
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
-		    (next_mm | prev_mm) & LAST_USER_MM_IBPB &&
-		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
 	}
 
@@ -448,8 +447,7 @@ static void cond_mitigation(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) != (unsigned long)next->mm &&
-		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) != (unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
 	}
 
-- 
2.48.1.601.g30ceb7b040-goog


