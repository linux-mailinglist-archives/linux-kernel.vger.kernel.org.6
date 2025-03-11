Return-Path: <linux-kernel+bounces-556755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE23A5CE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB1F17EC79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8826656D;
	Tue, 11 Mar 2025 18:41:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76572264639
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718507; cv=none; b=cklJY860P+EQi3av3EVKz/2gumBwuXcNTNVwm8npAQW/tV5BE0hMp4FYvKXFF1cKuAW3r5I8CdtLEIa9+T7hGIlYMEtT6POgzlfih2pJFCox73YqvUHCbdL+NZDISi6SwokwJL47y461gbp67hqecOmwG1bW3AqrI+gFB5b5jHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718507; c=relaxed/simple;
	bh=3+J6oDEu1X6g5Auuhbmfyh+8zqtaX8I7/EFan5gk9Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrSL8a0Fue1KRSMn+2MBQvfLok65T56oAnkjSwXlYFie2xQYF8qqmAwYI3pu1qozqNj1jezcRQcVkDFzVFJSbEAO6p6clMRps4Om2ALYM+NVb/uELVz3wSD2FOPfTl7l7iQ5+GT/Bi2gdsZfqbZAcYrqXjbQEP9JJgdhlwSW7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31B11762;
	Tue, 11 Mar 2025 11:41:52 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A4553F694;
	Tue, 11 Mar 2025 11:41:38 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
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
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8:for-boris 25/30] x86/resctrl: Make prefetch_disable_bits belong to the arch code
Date: Tue, 11 Mar 2025 18:37:10 +0000
Message-Id: <20250311183715.16445-26-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>
References: <20250311183715.16445-1-james.morse@arm.com>
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

Make resctrl_arch_get_prefetch_disable_bits() set prefetch_disable_bits
so that it can be isolated to arch-code from where the other arch-code
helpers can use its cached-value.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v5:
 * Tweaked the word 'export'.
 * Swapped the second paragraph for Reinette's version.
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 1f42c1190d26..90044a01d000 100644
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
2.39.5


