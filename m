Return-Path: <linux-kernel+bounces-219510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3690D39B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB72286F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AED15A84B;
	Tue, 18 Jun 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NlAa+i0N"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2F159205
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718626; cv=none; b=H/WR3vsgXJ2OIzhrIruF8S4d+UcAXQDdj7MCemRGmbZoGwgtpgUi7XsGIjKgdS1+sXhoaE/JudsSdzO3IyelSvO+wPZg0iQvL8GndYUVAuFJoPzSt89qheHSy3TeWzO01+3zZgfJcrR1ez7eqTTZ3Ubap3WSuK4kf3FUK6WxuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718626; c=relaxed/simple;
	bh=nrBmjK8M5zZeJbvW+8cBc3LIW/LgvDNZGeFiGq5gHN8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=J9Ihu+dg09hfQ39rlI4jHMPWIp/oklJyZeZ0aq4LR05cP0FTtUBNK0WurT+msWSp9uAYMLdBCNWZ5I/kpjcFEB16/jMdeoZH2pEiyLD1fGWHgoEa/xnuOr8Jdfsb9fxrN3hVtKp3HwX3knmEnhxyTf44GXQar0TZrJ38hxllUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NlAa+i0N; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718718616; bh=Lxrejzu9HcoEiC94ohAF91dLGvwrFbXuo1Ys6ZOYhDI=;
	h=From:To:Cc:Subject:Date;
	b=NlAa+i0NWW07m1ey+SzPWyZvBdHyABCFvxgu6GaRnATkZK2f/92wAbcld/JTtuLMj
	 EZJ+PfISgX1+n4nz72e2avWgGdiJegM+p5q5Qhjvj0dDVQbhxBnEUWpSc6AQ2TzZK4
	 AMiWDUpRnLu9zfUZXQrMp97nN7XxwzlMKK7sog4Q=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id C7136EDF; Tue, 18 Jun 2024 21:49:49 +0800
X-QQ-mid: xmsmtpt1718718589t2fasfcg9
Message-ID: <tencent_D6474BDCDD18AA90A0C656BE704136ED2807@qq.com>
X-QQ-XMAILINFO: OJV4F5WcWfWapJLwDAzQnPoQUH2tgrJG1aryxyq2RJFAqtcfKfk4glkco/h4CC
	 FnmAgOc4dVOK+C6n3wNdtgwR1epHZkOMssLI+FFpOIiLirlaLmep8uupks8BtVvp/gMK6fvAauJu
	 K1OGN0DCJ5CiRjVn9MdbV3z76uCb0qmXQJfDNzuFJx5h7BxXf737jLxu5F/j+sQvEOGgOWccnyYU
	 gXXkfatzT2E6reJAfd/W1o8s7e1fICtTealz73jeppEocrNWDDTw3hI92sJ3KODGJN9nU76dSTNt
	 BoPAs/IhYpjwKMJeDbN4mFUhDvT06VUpTL6JiWmn2skIgcwO4A5XdsUlZDUJIhBPXnAsqljohFKy
	 oWKNuHLLLeTfcXWXNhE0xIauIKN7atNOK/iCQdzL8IpDkfQL6SpqscSNsXHKK/S9dDWXPduDosZr
	 fOpKeMn3TcyMdlv+bdsp+korQRiMgHriZzIFzbwKkXQrSP+ljFyECgHrE9Qfyy224A60DLi2Ehzx
	 nvqUYURJIo0znC1x+aMDfZ+QQKkepsd+ufUIxF2aah5dT6HJknSZcFdS6I6QJ1/VgpZRjbkhT5w9
	 rkP3HlkLG/Z/u5QYrjJOp3QBENCCzwEqJbOKdZOct16kAFeMJnPU7snFoT5K+EH0RxzH2hSuu1Eb
	 s3+dBbP3JUaupbIAKyc98prZCNBHHFz8r+y4vx/qT6AjRTdWoTR9I1zkNcy3ZS5IuQqmGtYjGRuQ
	 kl43wPN5IZJsvkJJa0FEjY6r2JBcWAaKRI9uogEEQrFrirNKd2uykTokR89l9whct5L/BzLoXrct
	 gdvFRM/1KOlrjK40mIWfQ4UxxvbJZlStK4ShEvQFo3T5IQYfsiBdE9BefLQTMrr0QITt4w0vbL0e
	 denD9fJAg4eDpWFshpTbHncRz0KN6633lRjbHja1TovhuO5rz3WskfheO6nX2xlHX5K8SMGQvaMa
	 9qveEdj1+S7sUahOIT2me9nLQeFETTt8ZoL9Ki83CoUbKci3PkBaL5qEJBO3C1Z9rACibuOsemz8
	 EZGvHgY9bVwS8tpSTY
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Asahi Lina <lina@asahilina.net>,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1] drivers/perf: apple_m1: add known PMU events
Date: Tue, 18 Jun 2024 21:49:48 +0800
X-OQ-MSGID: <20240618134948.3260304-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds known PMU events that can be found on /usr/share/kpep in
macOS. The m1_pmu_events and m1_pmu_event_affinity are generated from
the script [1], which consumes the plist file from Apple. And then added
these events to m1_pmu_perf_map and m1_pmu_event_attrs with Apple's
documentation [2].

Link: https://github.com/cyyself/m1-pmu-gen [1]
Link: https://developer.apple.com/download/apple-silicon-cpu-optimization-guide/ [2]
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/perf/apple_m1_cpu_pmu.c | 204 +++++++++++++++++++++-----------
 1 file changed, 132 insertions(+), 72 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f322e5ca1114..e6045314ae97 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -47,46 +47,79 @@
  * implementations, we'll have to introduce per cpu-type tables.
  */
 enum m1_pmu_events {
-	M1_PMU_PERFCTR_UNKNOWN_01	= 0x01,
-	M1_PMU_PERFCTR_CPU_CYCLES	= 0x02,
-	M1_PMU_PERFCTR_INSTRUCTIONS	= 0x8c,
-	M1_PMU_PERFCTR_UNKNOWN_8d	= 0x8d,
-	M1_PMU_PERFCTR_UNKNOWN_8e	= 0x8e,
-	M1_PMU_PERFCTR_UNKNOWN_8f	= 0x8f,
-	M1_PMU_PERFCTR_UNKNOWN_90	= 0x90,
-	M1_PMU_PERFCTR_UNKNOWN_93	= 0x93,
-	M1_PMU_PERFCTR_UNKNOWN_94	= 0x94,
-	M1_PMU_PERFCTR_UNKNOWN_95	= 0x95,
-	M1_PMU_PERFCTR_UNKNOWN_96	= 0x96,
-	M1_PMU_PERFCTR_UNKNOWN_97	= 0x97,
-	M1_PMU_PERFCTR_UNKNOWN_98	= 0x98,
-	M1_PMU_PERFCTR_UNKNOWN_99	= 0x99,
-	M1_PMU_PERFCTR_UNKNOWN_9a	= 0x9a,
-	M1_PMU_PERFCTR_UNKNOWN_9b	= 0x9b,
-	M1_PMU_PERFCTR_UNKNOWN_9c	= 0x9c,
-	M1_PMU_PERFCTR_UNKNOWN_9f	= 0x9f,
-	M1_PMU_PERFCTR_UNKNOWN_bf	= 0xbf,
-	M1_PMU_PERFCTR_UNKNOWN_c0	= 0xc0,
-	M1_PMU_PERFCTR_UNKNOWN_c1	= 0xc1,
-	M1_PMU_PERFCTR_UNKNOWN_c4	= 0xc4,
-	M1_PMU_PERFCTR_UNKNOWN_c5	= 0xc5,
-	M1_PMU_PERFCTR_UNKNOWN_c6	= 0xc6,
-	M1_PMU_PERFCTR_UNKNOWN_c8	= 0xc8,
-	M1_PMU_PERFCTR_UNKNOWN_ca	= 0xca,
-	M1_PMU_PERFCTR_UNKNOWN_cb	= 0xcb,
-	M1_PMU_PERFCTR_UNKNOWN_f5	= 0xf5,
-	M1_PMU_PERFCTR_UNKNOWN_f6	= 0xf6,
-	M1_PMU_PERFCTR_UNKNOWN_f7	= 0xf7,
-	M1_PMU_PERFCTR_UNKNOWN_f8	= 0xf8,
-	M1_PMU_PERFCTR_UNKNOWN_fd	= 0xfd,
-	M1_PMU_PERFCTR_LAST		= M1_PMU_CFG_EVENT,
+	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
+	M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
+	M1_PMU_PERFCTR_L1I_TLB_FILL				= 0x4,
+	M1_PMU_PERFCTR_L1D_TLB_FILL				= 0x5,
+	M1_PMU_PERFCTR_MMU_TABLE_WALK_INSTRUCTION		= 0x7,
+	M1_PMU_PERFCTR_MMU_TABLE_WALK_DATA			= 0x8,
+	M1_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION			= 0xa,
+	M1_PMU_PERFCTR_L2_TLB_MISS_DATA				= 0xb,
+	M1_PMU_PERFCTR_MMU_VIRTUAL_MEMORY_FAULT_NONSPEC		= 0xd,
+	M1_PMU_PERFCTR_SCHEDULE_UOP				= 0x52,
+	M1_PMU_PERFCTR_INTERRUPT_PENDING			= 0x6c,
+	M1_PMU_PERFCTR_MAP_STALL_DISPATCH			= 0x70,
+	M1_PMU_PERFCTR_MAP_REWIND				= 0x75,
+	M1_PMU_PERFCTR_MAP_STALL				= 0x76,
+	M1_PMU_PERFCTR_MAP_INT_UOP				= 0x7c,
+	M1_PMU_PERFCTR_MAP_LDST_UOP				= 0x7d,
+	M1_PMU_PERFCTR_MAP_SIMD_UOP				= 0x7e,
+	M1_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC		= 0x84,
+	M1_PMU_PERFCTR_INST_ALL					= 0x8c,
+	M1_PMU_PERFCTR_INST_BRANCH				= 0x8d,
+	M1_PMU_PERFCTR_INST_BRANCH_CALL				= 0x8e,
+	M1_PMU_PERFCTR_INST_BRANCH_RET				= 0x8f,
+	M1_PMU_PERFCTR_INST_BRANCH_TAKEN			= 0x90,
+	M1_PMU_PERFCTR_INST_BRANCH_INDIR			= 0x93,
+	M1_PMU_PERFCTR_INST_BRANCH_COND				= 0x94,
+	M1_PMU_PERFCTR_INST_INT_LD				= 0x95,
+	M1_PMU_PERFCTR_INST_INT_ST				= 0x96,
+	M1_PMU_PERFCTR_INST_INT_ALU				= 0x97,
+	M1_PMU_PERFCTR_INST_SIMD_LD				= 0x98,
+	M1_PMU_PERFCTR_INST_SIMD_ST				= 0x99,
+	M1_PMU_PERFCTR_INST_SIMD_ALU				= 0x9a,
+	M1_PMU_PERFCTR_INST_LDST				= 0x9b,
+	M1_PMU_PERFCTR_INST_BARRIER				= 0x9c,
+	M1_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	M1_PMU_PERFCTR_L1D_TLB_ACCESS				= 0xa0,
+	M1_PMU_PERFCTR_L1D_TLB_MISS				= 0xa1,
+	M1_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0xa2,
+	M1_PMU_PERFCTR_L1D_CACHE_MISS_LD			= 0xa3,
+	M1_PMU_PERFCTR_LD_UNIT_UOP				= 0xa6,
+	M1_PMU_PERFCTR_ST_UNIT_UOP				= 0xa7,
+	M1_PMU_PERFCTR_L1D_CACHE_WRITEBACK			= 0xa8,
+	M1_PMU_PERFCTR_LDST_X64_UOP				= 0xb1,
+	M1_PMU_PERFCTR_LDST_XPG_UOP				= 0xb2,
+	M1_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_SUCC			= 0xb3,
+	M1_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_FAIL			= 0xb4,
+	M1_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC		= 0xbf,
+	M1_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC		= 0xc0,
+	M1_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC			= 0xc1,
+	M1_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC	= 0xc4,
+	M1_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC		= 0xc5,
+	M1_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC		= 0xc6,
+	M1_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC		= 0xc8,
+	M1_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC	= 0xca,
+	M1_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC			= 0xcb,
+	M1_PMU_PERFCTR_L1I_TLB_MISS_DEMAND			= 0xd4,
+	M1_PMU_PERFCTR_MAP_DISPATCH_BUBBLE			= 0xd6,
+	M1_PMU_PERFCTR_L1I_CACHE_MISS_DEMAND			= 0xdb,
+	M1_PMU_PERFCTR_FETCH_RESTART				= 0xde,
+	M1_PMU_PERFCTR_ST_NT_UOP				= 0xe5,
+	M1_PMU_PERFCTR_LD_NT_UOP				= 0xe6,
+	M1_PMU_PERFCTR_UNKNOWN_f5				= 0xf5,
+	M1_PMU_PERFCTR_UNKNOWN_f6				= 0xf6,
+	M1_PMU_PERFCTR_UNKNOWN_f7				= 0xf7,
+	M1_PMU_PERFCTR_UNKNOWN_f8				= 0xf8,
+	M1_PMU_PERFCTR_UNKNOWN_fd				= 0xfd,
+	M1_PMU_PERFCTR_LAST					= M1_PMU_CFG_EVENT,
 
 	/*
 	 * From this point onwards, these are not actual HW events,
 	 * but attributes that get stored in hw->config_base.
 	 */
-	M1_PMU_CFG_COUNT_USER		= BIT(8),
-	M1_PMU_CFG_COUNT_KERNEL		= BIT(9),
+	M1_PMU_CFG_COUNT_USER					= BIT(8),
+	M1_PMU_CFG_COUNT_KERNEL					= BIT(9),
 };
 
 /*
@@ -96,45 +129,48 @@ enum m1_pmu_events {
  * counters had strange affinities.
  */
 static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
-	[0 ... M1_PMU_PERFCTR_LAST]	= ANY_BUT_0_1,
-	[M1_PMU_PERFCTR_UNKNOWN_01]	= BIT(7),
-	[M1_PMU_PERFCTR_CPU_CYCLES]	= ANY_BUT_0_1 | BIT(0),
-	[M1_PMU_PERFCTR_INSTRUCTIONS]	= BIT(7) | BIT(1),
-	[M1_PMU_PERFCTR_UNKNOWN_8d]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_8e]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_8f]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_90]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_93]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_94]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_95]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_96]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_97]	= BIT(7),
-	[M1_PMU_PERFCTR_UNKNOWN_98]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_99]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_9a]	= BIT(7),
-	[M1_PMU_PERFCTR_UNKNOWN_9b]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_9c]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_9f]	= BIT(7),
-	[M1_PMU_PERFCTR_UNKNOWN_bf]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_c0]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_c1]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_c4]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_c5]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_c6]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_c8]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_ca]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_cb]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_f5]	= ONLY_2_4_6,
-	[M1_PMU_PERFCTR_UNKNOWN_f6]	= ONLY_2_4_6,
-	[M1_PMU_PERFCTR_UNKNOWN_f7]	= ONLY_2_4_6,
-	[M1_PMU_PERFCTR_UNKNOWN_f8]	= ONLY_2_TO_7,
-	[M1_PMU_PERFCTR_UNKNOWN_fd]	= ONLY_2_4_6,
+	[0 ... M1_PMU_PERFCTR_LAST]				= ANY_BUT_0_1,
+	[M1_PMU_PERFCTR_RETIRE_UOP]				= BIT(7),
+	[M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE]			= ANY_BUT_0_1 | BIT(0),
+	[M1_PMU_PERFCTR_INST_ALL]				= BIT(7) | BIT(1),
+	[M1_PMU_PERFCTR_INST_BRANCH]				= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_BRANCH_CALL]			= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_BRANCH_RET]			= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_BRANCH_TAKEN]			= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_BRANCH_INDIR]			= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_BRANCH_COND]			= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_INT_LD]				= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_INT_ST]				= BIT(7),
+	[M1_PMU_PERFCTR_INST_INT_ALU]				= BIT(7),
+	[M1_PMU_PERFCTR_INST_SIMD_LD]				= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_SIMD_ST]				= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_INST_SIMD_ALU]				= BIT(7),
+	[M1_PMU_PERFCTR_INST_LDST]				= BIT(7),
+	[M1_PMU_PERFCTR_INST_BARRIER]				= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_9f]				= BIT(7),
+	[M1_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC]			= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_f5]				= ONLY_2_4_6,
+	[M1_PMU_PERFCTR_UNKNOWN_f6]				= ONLY_2_4_6,
+	[M1_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_2_4_6,
+	[M1_PMU_PERFCTR_UNKNOWN_f8]				= ONLY_2_TO_7,
+	[M1_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
 };
 
 static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
-	[PERF_COUNT_HW_CPU_CYCLES]	= M1_PMU_PERFCTR_CPU_CYCLES,
-	[PERF_COUNT_HW_INSTRUCTIONS]	= M1_PMU_PERFCTR_INSTRUCTIONS,
+	[PERF_COUNT_HW_CPU_CYCLES]		= M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= M1_PMU_PERFCTR_INST_ALL,
+	[PERF_COUNT_HW_CACHE_MISSES]		= M1_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= M1_PMU_PERFCTR_INST_BRANCH,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= M1_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC,
 	/* No idea about the rest yet */
 };
 
@@ -154,8 +190,32 @@ static ssize_t m1_pmu_events_sysfs_show(struct device *dev,
 	PMU_EVENT_ATTR_ID(name, m1_pmu_events_sysfs_show, config)
 
 static struct attribute *m1_pmu_event_attrs[] = {
-	M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CPU_CYCLES),
-	M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INSTRUCTIONS),
+	M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE),
+	M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INST_ALL),
+	M1_PMU_EVENT_ATTR(retire-uops, M1_PMU_PERFCTR_RETIRE_UOP),
+	M1_PMU_EVENT_ATTR(inst-branch, M1_PMU_PERFCTR_INST_BRANCH),
+	M1_PMU_EVENT_ATTR(inst-branch-call, M1_PMU_PERFCTR_INST_BRANCH_CALL),
+	M1_PMU_EVENT_ATTR(inst-branch-ret, M1_PMU_PERFCTR_INST_BRANCH_RET),
+	M1_PMU_EVENT_ATTR(inst-branch-taken, M1_PMU_PERFCTR_INST_BRANCH_TAKEN),
+	M1_PMU_EVENT_ATTR(inst-branch-indir, M1_PMU_PERFCTR_INST_BRANCH_INDIR),
+	M1_PMU_EVENT_ATTR(inst-branch-cond, M1_PMU_PERFCTR_INST_BRANCH_COND),
+	M1_PMU_EVENT_ATTR(inst-int-ld, M1_PMU_PERFCTR_INST_INT_LD),
+	M1_PMU_EVENT_ATTR(inst-int-st, M1_PMU_PERFCTR_INST_INT_ST),
+	M1_PMU_EVENT_ATTR(inst-int-alu, M1_PMU_PERFCTR_INST_INT_ALU),
+	M1_PMU_EVENT_ATTR(inst-simd-ld, M1_PMU_PERFCTR_INST_SIMD_LD),
+	M1_PMU_EVENT_ATTR(inst-simd-st, M1_PMU_PERFCTR_INST_SIMD_ST),
+	M1_PMU_EVENT_ATTR(inst-simd-alu, M1_PMU_PERFCTR_INST_SIMD_ALU),
+	M1_PMU_EVENT_ATTR(inst-ldst, M1_PMU_PERFCTR_INST_LDST),
+	M1_PMU_EVENT_ATTR(inst-barrier, M1_PMU_PERFCTR_INST_BARRIER),
+	M1_PMU_EVENT_ATTR(l1d-miss-ld, M1_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC),
+	M1_PMU_EVENT_ATTR(l1d-miss-st, M1_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC),
+	M1_PMU_EVENT_ATTR(l1d-tlb-miss, M1_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC),
+	M1_PMU_EVENT_ATTR(st-mem-order-violation, M1_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC),
+	M1_PMU_EVENT_ATTR(branch-cond-mispred, M1_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC),
+	M1_PMU_EVENT_ATTR(branch-indir-mispred, M1_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC),
+	M1_PMU_EVENT_ATTR(branch-ret-indir-mispred, M1_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC),
+	M1_PMU_EVENT_ATTR(branch-call-indir-mispred, M1_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC),
+	M1_PMU_EVENT_ATTR(branch-mispred, M1_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC),
 	NULL,
 };
 
-- 
2.45.1


