Return-Path: <linux-kernel+bounces-350885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B80990AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EED91F24EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF221C170;
	Fri,  4 Oct 2024 18:06:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F34321C16A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065186; cv=none; b=cHCrUbU9qCwvEjZ4b8aoLJaJm96ZNrhA9NBQZLVYxFLNRoMrM5QQ72myQt7UKRM4i7PDPwV+ET4fCrjVYMal8/UM7IwtP/+93GW6C3pLiPL9BiU5aQ+pOxuwb7Q7vl4f5rawwM+O6wdJZI7+IbcK0+egtT/nf4iS/alMG+tTwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065186; c=relaxed/simple;
	bh=HyNkeKTGycGu1LP0MmW2o7BjwPgGkg4gk/+9iyvXs14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rxHATELXhdW5tXjTtAanuf4n5hcJzjisg2Vwz1WER6rBogqgXxspNrRJprboYxU7Dhfc3nwBWneU4LsReSRm4QmvnHPOmfTVpDSJmPPJabBAXMt7UAgQBtxo9YkpvK6xNwh7kdwm7iEDErwNEf4/s+lEz3i1DPSp3jOmBfdlKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8A0339;
	Fri,  4 Oct 2024 11:06:54 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716D23F58B;
	Fri,  4 Oct 2024 11:06:21 -0700 (PDT)
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
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 25/40] x86/resctrl: Make prefetch_disable_bits belong to the arch code
Date: Fri,  4 Oct 2024 18:03:32 +0000
Message-Id: <20241004180347.19985-26-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
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
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 56e59441d6ae..0fee49fc153a 100644
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


