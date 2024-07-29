Return-Path: <linux-kernel+bounces-265590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807FE93F350
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7971C21D53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539BE144D2D;
	Mon, 29 Jul 2024 10:55:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36D144D23
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250515; cv=none; b=BcQSOpCghdWdBCC8wCYjUIxbPXYZr7Gf3QMGGWapIp4BXd5+n9UNQWXfSFlFEeFwlq6bosOsZIGao4fMCXjcQOJ/gvcVkzepJEeMChLbdxu6TiSgYpz67c7I785gtqvRiUWP9uBOsly3+yOiSVtbPdt+WyUYY7vAPHmIqLGARXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250515; c=relaxed/simple;
	bh=qlPoAEQDaoq9poVD+6XpYTePjZiKeShQ2Dhs+Z8Yrkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QdfLJijsPfr3+9p4zycaQidZDtYVUEWStKfFc7ZZ3hXsx910EqNWXTWeQhOfe/5xMuLnxCdAxrKmULmFz3fZKDdtXnCuJ0wfmI2INWxu1FAEQR7rZH/KepWMWrBQqGneOYIHKh6xIzsPFS0vcVEhD3KzMvPD8RYIA6rG6PGqCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WXZvs0y0Cz6K99S;
	Mon, 29 Jul 2024 18:53:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D8FB140B30;
	Mon, 29 Jul 2024 18:55:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 11:55:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	<rafael.j.wysocki@intel.com>, <catalin.marinas@arm.com>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, <Terry.bowman@amd.com>
CC: <linuxarm@huawei.com>, <guohanjun@huawei.com>, <gshan@redhat.com>,
	<miguel.luis@oracle.com>, Linux List Kernel Mailing
	<linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH] x86/aperfmperf: Fix deadlock on cpu_hotplug_lock
Date: Mon, 29 Jul 2024 11:55:04 +0100
Message-ID: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

The broken patch results in a call to init_freq_invariance_cppc() in a CPU
hotplug handler in both the path for initially present CPUs and those
hotplugged later.  That function includes a one time call to
amd_set_max_freq_ratio() which in turn calls freq_invariance_enable() that
has a static_branch_enable() which takes the cpu_hotlug_lock which is
already held.

Avoid the deadlock by using static_branch_enable_cpuslocked() as the lock
will always be already held.  The equivalent path on Intel does not
already hold this lock, so take it around the call to
freq_invariance_enable(), which results in it being held over the call to
register_syscall_ops, which looks to be safe to do.

Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/all/CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com/
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index b3fa61d45352..0b69bfbf345d 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -306,7 +306,7 @@ static void freq_invariance_enable(void)
 		WARN_ON_ONCE(1);
 		return;
 	}
-	static_branch_enable(&arch_scale_freq_key);
+	static_branch_enable_cpuslocked(&arch_scale_freq_key);
 	register_freq_invariance_syscore_ops();
 	pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 }
@@ -323,8 +323,10 @@ static void __init bp_init_freq_invariance(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (intel_set_max_freq_ratio())
+	if (intel_set_max_freq_ratio()) {
+		guard(cpus_read_lock)();
 		freq_invariance_enable();
+	}
 }
 
 static void disable_freq_invariance_workfn(struct work_struct *work)
-- 
2.43.0


