Return-Path: <linux-kernel+bounces-433584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F529E5A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9336118871E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B521D580;
	Thu,  5 Dec 2024 15:46:56 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB603A268;
	Thu,  5 Dec 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413615; cv=none; b=sAgUcm/+Ca5QMDTl4UVjl7dvVtsaWuJmokb2EVAyi3XXeshU+pnFvQnc8qweU9mxEMvIHQc8lve4FCZYsE3s3SibQ/TtWCM6h9RSDZUQ0kiZGuQ5w90ftzuUjuifoh7PRg8KNKvxLqViWGUeJr3nM+MBvg4CKv9LBlsPcG/HcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413615; c=relaxed/simple;
	bh=X6pO+Ka8p7H6bVWXC8vkg8EK/JnomVxSFPLLMBpH1Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKtGUXwtdUcJzzaOMtriwblbooPgGcXFx2F8Kk9ctt5tjzmuGzZyZXLs8d3uvfSC0dkqPwF5tq3Z8ZA/2jbTTjnwYiUGbZSQCUVIYukIj3LCYLM/L92ln3f1xaLECHRIUGV71M11ZDCNwl5oQ7v7rNKAWKnX94xontFWOwg8AZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tJE3j-000000005r5-0rfd;
	Thu, 05 Dec 2024 10:46:31 -0500
Date: Thu, 5 Dec 2024 10:46:30 -0500
From: Rik van Riel <riel@surriel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Mel
 Gorman <mgorman@suse.de>
Subject: [PATCH] x86,mm: also remove local CPU from mm_cpumask if stale
Message-ID: <20241205104630.755706ca@fangorn>
In-Reply-To: <202412051551.690e9656-lkp@intel.com>
References: <202412051551.690e9656-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: riel@surriel.com

On Thu, 5 Dec 2024 16:43:24 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> besides the performance report
> "[tip:x86/mm] [x86/mm/tlb]  209954cbc7:  will-it-scale.per_thread_ops 13.=
2% regression"
> in
> https://lore.kernel.org/all/202411282207.6bd28eae-lkp@intel.com/
>
Anxiously awaiting the bot to get around to v3 or v4 of that patch,
on the extra-large 2 socket system ;)
=20
> we now also observed a WARNING from another test. the issue doesn't always
> happen, so we run it more to make sure the parent keep clean.

Thank you for spotting this corner case, too!

The warning appears to be fairly harmless, and luckily also easy
to fix.

---8<---

=46rom 5b5d1d548fbe07b415ba9e80a2f60deed5aead62 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Thu, 5 Dec 2024 10:20:28 -0500
Subject: [PATCH 2/2] x86,mm: also remove local CPU from mm_cpumask if stale

The code in flush_tlb_func that removes a remote CPU from the
cpumask if it is no longer running the target mm is also needed
on the originating CPU of a TLB flush, now that CPUs are no
longer cleared from the mm_cpumask at context switch time.

Flushing the TLB when we are not running the target mm is
harmless, because the CPU's tlb_gen only gets updated to
match the mm_tlb_gen, but it does hit this warning:

        WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);

[ 210.343902][ T4668] WARNING: CPU: 38 PID: 4668 at arch/x86/mm/tlb.c:815 f=
lush_tlb_func (arch/x86/mm/tlb.c:815)

Removing both local and remote CPUs from the mm_cpumask
when doing a flush for a not currently loaded mm avoids
that warning.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412051551.690e9656-lkp@intel.com
---
 arch/x86/mm/tlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0507a6773a37..458a5d5be594 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -756,13 +756,13 @@ static void flush_tlb_func(void *info)
 	if (!local) {
 		inc_irq_stat(irq_tlb_count);
 		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+	}
=20
-		/* Can only happen on remote CPUs */
-		if (f->mm && f->mm !=3D loaded_mm) {
-			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
-			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
-			return;
-		}
+	/* The CPU was left in the mm_cpumask of the target mm. Clear it. */
+	if (f->mm && f->mm !=3D loaded_mm) {
+		cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
+		trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
+		return;
 	}
=20
 	if (unlikely(loaded_mm =3D=3D &init_mm))
--=20
2.47.0


