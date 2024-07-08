Return-Path: <linux-kernel+bounces-244436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0A92A43B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181BDB20AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364875381B;
	Mon,  8 Jul 2024 14:01:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD6365
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447285; cv=none; b=Dr+tILIDQqkM3mxKE8XaNUFWRAEzpDdjaOBkU289XfX/6iNVZOIrZjhvMYPBfozIMJDpZwST9XPFNZkb0dVc/Vg6TDLtyzSaXjdl8ou3o/+SHSO0WpREnWtDb1vo2kBME72+s+zgrnmu0LqX1Zt3RBVOZWUNbXYTiPsOpVUSeyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447285; c=relaxed/simple;
	bh=PXardNc60xsYYWJifJW7jxhVduCt3UICeqFl9PrrFow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C+1cMOPFE1F9f8y7E+8ImEHUAgcKna/7216ahSbdwSoD/P1WL5pl0/06yXEjvSHRsuKSAsfqiaYnOd4SjNK9PP9qQm7y5wyuAVPvu0cmAjiwWYNxkSu/m6NaZ6VqIDsgZRazWzGm4G6TZ2VEgEWWFrXEyMtE8iuFmtEuxuRl7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF341042;
	Mon,  8 Jul 2024 07:01:47 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B8BC3F766;
	Mon,  8 Jul 2024 07:01:22 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/ext: Add BPF function to fetch rq
Date: Mon,  8 Jul 2024 15:01:18 +0100
Message-Id: <7359b5cd17d56837bc15f4883b21837163c51d37.1720441953.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rq contains many useful fields to implement a custom scheduler. For
example, various clock signals like clock_task and clock_pelt can be
used to track load. It also contains stats in other sched_classes, which
are useful to drive scheduling decisions in ext.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/ext.c                       | 13 +++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 48c553b6f0c3..46438ece2fde 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5642,6 +5642,18 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	local_irq_restore(irq_flags);
 }
 
+/**
+ * scx_bpf_cpu_rq - Fetch the rq of a CPU
+ * @cpu: CPU of the rq
+ */
+__bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
+{
+	if (!ops_cpu_valid(cpu, NULL))
+		return NULL;
+
+	return cpu_rq(cpu);
+}
+
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the DSQ
@@ -6122,6 +6134,7 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 85ddc94fb4c1..fecc12aed1b0 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -37,6 +37,7 @@ void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
 u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
+struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
-- 
2.34.1


