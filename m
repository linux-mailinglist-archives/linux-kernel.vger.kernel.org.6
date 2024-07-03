Return-Path: <linux-kernel+bounces-239197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BE09257E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B24284E77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F615B570;
	Wed,  3 Jul 2024 10:07:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DA143C51
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001276; cv=none; b=bF/TsT0x2qaWmP2iPwj/u5kLBDl+X+mCEVSU3F2kFJEAKbnENj1VyFv+/OH/JtLh1T3Q2I3qCSLGuTY3HD+bsaq2tx7Q31J5fD24bCwRj8yromLoV/4kRAx116HIq7s6FTQC8W8iMmpE+dom6R1IsNFkHrKwzzqnF8LCptIDb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001276; c=relaxed/simple;
	bh=SgHDnlKUpFZa1mecD7sSwc8oq/o6fVz9O73YRXtmBVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4vM+lhT5vt9LELEAAkJHO9I001P6/TUEziwhb0gWC/mQOXmybgfzDzQJ8afchT0xTDXdBF9mPlUX5I5FoVLkCyHRLSu4UKrZZrSoDXtk/o+ZuNzRa5VRS/vbdjVZhrIZCUTi916B1daH5dE2vcwUv9fIxT2QPLq3VyxEga/Mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D311688;
	Wed,  3 Jul 2024 03:08:18 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E9BB3F766;
	Wed,  3 Jul 2024 03:07:53 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched/ext: Add BPF functions for uclamp inc and dec
Date: Wed,  3 Jul 2024 11:07:48 +0100
Message-Id: <34f3e33aa236445d677ea2b48d2d556178c1ac34.1719999165.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719999165.git.hongyan.xia2@arm.com>
References: <cover.1719999165.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sched_ext scheduler may have different choices for uclamp:

1. Re-use the current uclamp implementation
2. Ignore uclamp completely
3. Have its own custom uclamp implemenation

We expose uclamp BPF functions and let the scheduler itself decide what
to do.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/ext.c                       | 12 ++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0b120104a7ce..48c553b6f0c3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6108,6 +6108,16 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
 	return task_cpu(p);
 }
 
+__bpf_kfunc void scx_bpf_uclamp_rq_inc(s32 cpu, struct task_struct *p)
+{
+	uclamp_rq_inc(cpu_rq(cpu), p);
+}
+
+__bpf_kfunc void scx_bpf_uclamp_rq_dec(s32 cpu, struct task_struct *p)
+{
+	uclamp_rq_dec(cpu_rq(cpu), p);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -6132,6 +6142,8 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_uclamp_rq_inc)
+BTF_ID_FLAGS(func, scx_bpf_uclamp_rq_dec)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index dbbda0e35c5d..85ddc94fb4c1 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -57,6 +57,8 @@ s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+void scx_bpf_uclamp_rq_inc(s32 cpu, struct task_struct *p) __ksym;
+void scx_bpf_uclamp_rq_dec(s32 cpu, struct task_struct *p) __ksym;
 
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
-- 
2.34.1


