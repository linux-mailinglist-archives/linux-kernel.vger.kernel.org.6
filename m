Return-Path: <linux-kernel+bounces-272923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE74946285
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B531F21C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE66160FC2;
	Fri,  2 Aug 2024 17:31:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD988160FAB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619882; cv=none; b=CW2DzKKY1BXR0JUN4/76cfjL03d/JHowlCFLciRFztTUdqOF9e1HrhpWIxqRJVdAiN1SWNG108HCzyYSjRfbeBQ/fIaRIoLNm7DSfbzHxQcJXROjtVPdLmHXMEHqNXYuPvhBSU/MvOdDi/dnOHzwX3ARO92IvIamgYj12D7SOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619882; c=relaxed/simple;
	bh=MJCLzOBNPwgs7vFzyHZW+Jl5HxYfvtJ31b1Nj6jrsnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AP9AnkQOhJFvzDSfULoEj8PDgNzHBT0xlG3u8MZvMVrWfRhWHaWzu7VCqN9/7gOlDfF4+z60lhzX6zR6EUc4wk7FR0jpPZyZu0HL38kgSaY5ZgLcq+/qp+3rqQppjBxnJCxkc4BLs1kr92a3Imbz3Yx710EaZbjA57ypzsVtdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FFEF1007;
	Fri,  2 Aug 2024 10:31:46 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65BD93F64C;
	Fri,  2 Aug 2024 10:31:17 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v4 24/39] x86/resctrl: Make prefetch_disable_bits belong to the arch code
Date: Fri,  2 Aug 2024 17:28:38 +0000
Message-Id: <20240802172853.22529-25-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240802172853.22529-1-james.morse@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prefetch_disable_bits is set by rdtgroup_locksetup_enter() from a
value provided by the architecture, but is largely read by other
architecture helpers.

Instead of exporting this value, make
resctrl_arch_get_prefetch_disable_bits() set it so that the other
arch-code helpers can use the cached-value.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 459fabd054a0..cd0fdb7408d4 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -84,6 +84,8 @@ static const struct class pseudo_lock_class = {
  */
 u64 resctrl_arch_get_prefetch_disable_bits(void)
 {
+	prefetch_disable_bits = 0;
+
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86 != 6)
 		return 0;
@@ -99,7 +101,8 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
 		 * 3    DCU IP Prefetcher Disable (R/W)
 		 * 63:4 Reserved
 		 */
-		return 0xF;
+		prefetch_disable_bits = 0xF;
+		break;
 	case INTEL_ATOM_GOLDMONT:
 	case INTEL_ATOM_GOLDMONT_PLUS:
 		/*
@@ -110,10 +113,11 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
 		 * 2     DCU Hardware Prefetcher Disable (R/W)
 		 * 63:3  Reserved
 		 */
-		return 0x5;
+		prefetch_disable_bits = 0x5;
+		break;
 	}
 
-	return 0;
+	return prefetch_disable_bits;
 }
 
 /**
@@ -713,8 +717,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * Not knowing the bits to disable prefetching implies that this
 	 * platform does not support Cache Pseudo-Locking.
 	 */
-	prefetch_disable_bits = resctrl_arch_get_prefetch_disable_bits();
-	if (prefetch_disable_bits == 0) {
+	if (resctrl_arch_get_prefetch_disable_bits() == 0) {
 		rdt_last_cmd_puts("Pseudo-locking not supported\n");
 		return -EINVAL;
 	}
-- 
2.39.2


