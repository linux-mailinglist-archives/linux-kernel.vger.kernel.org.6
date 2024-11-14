Return-Path: <linux-kernel+bounces-409532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B169C8E25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB4286424
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9213CFA8;
	Thu, 14 Nov 2024 15:28:15 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39518CC00
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598094; cv=none; b=eby4dLG/SrlOi1OuqK2OtLfAI9OijVrjRNs061AGX6KIbkexi7SNaLmGBp2u84HwlS+o9F1y/Jq4NX7osazkFdGB/by8fGM8qbKn769fOVCnVT3UoGh6hs5XMHvU/htOeJ4EaPILPvhgneOusQK+Ts5Lj3oKxLu6qM/XJ3Bxy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598094; c=relaxed/simple;
	bh=YrWLsmiA2Vcjb4xRQDtplzTczIAp+pjAu2Wsj235wHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iASErfEJ1U7i+74NlM9W1K7PSao2Qj32pHqNPopQTRkChGrabKBdQDypCWKjMTR77BneCm2VgVrHnajo2lyRxBAQhSiTTo26CJrNWHqklrr7a9Ej9VEMzY0ZNGYBJ1UhHGPgrc9HxDr27bpO2SE13pqZj+Zo4ceX7OiVnF9t1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tBbkp-000000008IN-1vYC;
	Thu, 14 Nov 2024 10:27:31 -0500
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
Subject: [PATCH 2/2] x86,tlb: add tracepoint for TLB flush IPI to stale CPU
Date: Thu, 14 Nov 2024 10:26:17 -0500
Message-ID: <20241114152723.1294686-3-riel@surriel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152723.1294686-1-riel@surriel.com>
References: <20241114152723.1294686-1-riel@surriel.com>
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

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c        | 1 +
 include/linux/mm_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cc4e57ae690f..1aac4fa90d3d 100644
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


