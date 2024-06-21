Return-Path: <linux-kernel+bounces-224128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C99911D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D018EB22562
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FC16DEB2;
	Fri, 21 Jun 2024 07:53:43 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568917164D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956423; cv=none; b=sJAfwWwH9cy1G5mwUuQDDqFyUCRZqARG05Xykfvm3NZeCPc/3JKdU/miQhnNQaa0IsToSuXmiMHol7G3D++J+kx8sGR8UUrllmnaCKQBL3UxC8rTvMqidzou4aamQzPcmw7qM7DbSK7oVhrTXxuQ6qoyEbQVcJ/6WmxS6quNs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956423; c=relaxed/simple;
	bh=yOtdE28v36LZJIJwy0A4ttQSFa2gB+PbTLoJFgRiu+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YcH0idGWTdSLTifPZF2qFBpMh9D6nnP1VxhTBn4CEiPHIh++jsDnwmKFW+qD87nOzpVJ2vLyYXnMmusvXmG7w8x+xfsynVfoNJIHt2SsKOd5g5VBHWNudDjmfzyYjxYPqKMALnPdSKrW9b5C8tu7UmbWS0Q9k8VIiLQvHYmrMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 6jajDp3AQfqKBqJRO5HZFg==
X-CSE-MsgGUID: x2L0l/TUTMiiXCGOgMj94g==
X-IronPort-AV: E=Sophos;i="6.08,254,1712592000"; 
   d="scan'208";a="114532156"
From: Lingyue <lingyue@xiaomi.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<dianders@chromium.org>, <swboyd@chromium.org>, <frederic@kernel.org>,
	<james.morse@arm.com>, <scott@os.amperecomputing.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <huangshaobo3@xiaomi.com>, <huangjun7@xiaomi.com>, Lingyue
	<lingyue@xiaomi.com>
Subject: [PATCH] arm64: smp: do not allocate CPU IDs to invalid CPU nodes
Date: Fri, 21 Jun 2024 15:50:45 +0800
Message-ID: <20240621075045.249798-1-lingyue@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bj-mbx09.mioffice.cn (10.237.8.129) To BJ-MBX13.mioffice.cn
 (10.237.8.133)

Many modules, such as arch topology, rely on num_possible_cpus() to
allocate memory and then access the allocated space using CPU IDs.
These modules assume that there are no gaps in cpu_possible_mask.
However, in of_parse_and_init_cpus(), CPU IDs are still allocated
for invalid CPU nodes, leading to gaps in cpu_possible_mask and
resulting in out-of-bounds memory access. So it is crucial to avoid
allocating CPU IDs to invalid CPU nodes.

This issue can be reproduced easily on QEMU with KASAN enabled, by
modifing reg property of a CPU node to 0xFFFFFFFF

[    0.197756] BUG: KASAN: slab-out-of-bounds in topology_normalize_cpu_scale.part.0+0x2cc/0x34c
[    0.199518] Read of size 4 at addr ffff000007ebe924 by task swapper/0/1
[    0.200087]
[    0.200739] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc4 #3
[    0.201647] Hardware name: linux,dummy-virt (DT)
[    0.203067] Call trace:
[    0.203404]  dump_backtrace+0x90/0xe8
[    0.203974]  show_stack+0x18/0x24
[    0.204424]  dump_stack_lvl+0x78/0x90
[    0.205090]  print_report+0x114/0x5cc
[    0.205908]  kasan_report+0xa4/0xf0
[    0.206488]  __asan_report_load4_noabort+0x20/0x2c
[    0.207427]  topology_normalize_cpu_scale.part.0+0x2cc/0x34c
[    0.208275]  init_cpu_topology+0x254/0x430
[    0.209518]  smp_prepare_cpus+0x20/0x25c
[    0.210824]  kernel_init_freeable+0x1dc/0x4fc
[    0.212047]  kernel_init+0x24/0x1ec
[    0.213143]  ret_from_fork+0x10/0x20

Signed-off-by: Lingyue <lingyue@xiaomi.com>
---
 arch/arm64/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 31c8b3094dd7..5b4178145920 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -638,12 +638,12 @@ static void __init of_parse_and_init_cpus(void)
 		u64 hwid = of_get_cpu_hwid(dn, 0);
 
 		if (hwid & ~MPIDR_HWID_BITMASK)
-			goto next;
+			continue;
 
 		if (is_mpidr_duplicate(cpu_count, hwid)) {
 			pr_err("%pOF: duplicate cpu reg properties in the DT\n",
 				dn);
-			goto next;
+			continue;
 		}
 
 		/*
@@ -656,7 +656,7 @@ static void __init of_parse_and_init_cpus(void)
 			if (bootcpu_valid) {
 				pr_err("%pOF: duplicate boot cpu reg property in DT\n",
 					dn);
-				goto next;
+				continue;
 			}
 
 			bootcpu_valid = true;
-- 
2.34.1


