Return-Path: <linux-kernel+bounces-524974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D98A3E96A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBAE3AF79E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD52AE99;
	Fri, 21 Feb 2025 00:54:11 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2CF288B1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099251; cv=none; b=rElLJVE552q/b2vdwRbo/s8jlIKH+fp5lt2qg3+J7v43rfGixEOdFF7hDHCYnHFHd2pNr7iJg/gfZyyLmN6xI9xoNv42WQypNhm3lSy+nUWeEvdovr2LS0tXn+LxsAd8GVfMnnF+4mHUKQnNsZNULgmAas/kTbOvCFBbT66oSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099251; c=relaxed/simple;
	bh=MKXaiSpY6whKSBDqqTDfo4eYpoYgRSR72UCgryJsyyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUXxL3GLUr308kf6kH1l9C+6r8k87C+PV1XsSObi1cuFMoH8hccwqv+SVqH4n3fdFnBe9BE6l9xvDOFP+GTR6+Cag5bjUS88BGs4hr2ZEISEnSV8FqelQ88pwl9tc4+qji7vc2HsvIo7xO10LCvRANrxgZcdoQeFfOPHsqDiZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-0Ury;
	Thu, 20 Feb 2025 19:53:47 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com
Subject: [PATCH v12 00/16] AMD broadcast TLB invalidation
Date: Thu, 20 Feb 2025 19:52:59 -0500
Message-ID: <20250221005345.2156760-1-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.

This allows the kernel to invalidate TLB entries on remote CPUs without
needing to send IPIs, without having to wait for remote CPUs to handle
those interrupts, and with less interruption to what was running on
those CPUs.

Because x86 PCID space is limited, and there are some very large
systems out there, broadcast TLB invalidation is only used for
processes that are active on 3 or more CPUs, with the threshold
being gradually increased the more the PCID space gets exhausted.

Combined with the removal of unnecessary lru_add_drain calls
(see https://lkml.org/lkml/2024/12/19/1388) this results in a
nice performance boost for the will-it-scale tlb_flush2_threads
test on an AMD Milan system with 36 cores:

- vanilla kernel:           527k loops/second
- lru_add_drain removal:    731k loops/second
- only INVLPGB:             527k loops/second
- lru_add_drain + INVLPGB: 1157k loops/second

Profiling with only the INVLPGB changes showed while
TLB invalidation went down from 40% of the total CPU
time to only around 4% of CPU time, the contention
simply moved to the LRU lock.

Fixing both at the same time about doubles the
number of iterations per second from this case.

Some numbers closer to real world performance
can be found at Phoronix, thanks to Michael:

https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits

My current plan is to implement support for Intel's RAR
(Remote Action Request) TLB flushing in a follow-up series,
after this thing has been merged into -tip. Making things
any larger would just be unwieldy for reviewers.

v12:
 - make sure "nopcid" command line option turns off invlpgb (Brendan)
 - add "noinvlpgb" kernel command line option
 - split out kernel TLB flushing differently (Dave & Yosry)
 - split up the patch that does invlpgb flushing for user processes (Dave)
 - clean up get_flush_tlb_info (Boris)
 - move invlpgb_count_max initialization to get_cpu_cap (Boris)
 - bunch more comments as requested
v11:
 - resolve conflict with CONFIG_PT_RECLAIM code
 - a few more cleanups (Peter, Brendan, Nadav)
v10:
 - simplify partial pages with min(nr, 1) in the invlpgb loop (Peter)
 - document x86 paravirt, AMD invlpgb, and ARM64 flush without IPI (Brendan)
 - remove IS_ENABLED(CONFIG_X86_BROADCAST_TLB_FLUSH) (Brendan)
 - various cleanups (Brendan)
v9:
 - print warning when start or end address was rounded (Peter)
 - in the reclaim code, tlbsync at context switch time (Peter)
 - fix !CONFIG_CPU_SUP_AMD compile error in arch_tlbbatch_add_pending (Jan)
v8:
 - round start & end to handle non-page-aligned callers (Steven & Jan)
 - fix up changelog & add tested-by tags (Manali)
v7:
 - a few small code cleanups (Nadav)
 - fix spurious VM_WARN_ON_ONCE in mm_global_asid
 - code simplifications & better barriers (Peter & Dave)
v6:
 - fix info->end check in flush_tlb_kernel_range (Michael)
 - disable broadcast TLB flushing on 32 bit x86
v5:
 - use byte assembly for compatibility with older toolchains (Borislav, Michael)
 - ensure a panic on an invalid number of extra pages (Dave, Tom)
 - add cant_migrate() assertion to tlbsync (Jann)
 - a bunch more cleanups (Nadav)
 - key TCE enabling off X86_FEATURE_TCE (Andrew)
 - fix a race between reclaim and ASID transition (Jann)
v4:
 - Use only bitmaps to track free global ASIDs (Nadav)
 - Improved AMD initialization (Borislav & Tom)
 - Various naming and documentation improvements (Peter, Nadav, Tom, Dave)
 - Fixes for subtle race conditions (Jann)
v3:
 - Remove paravirt tlb_remove_table call (thank you Qi Zheng)
 - More suggested cleanups and changelog fixes by Peter and Nadav
v2:
 - Apply suggestions by Peter and Borislav (thank you!)
 - Fix bug in arch_tlbbatch_flush, where we need to do both
   the TLBSYNC, and flush the CPUs that are in the cpumask.
 - Some updates to comments and changelogs based on questions.


