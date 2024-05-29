Return-Path: <linux-kernel+bounces-194588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1F8D3E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D92B1F24F31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DC71C8FA2;
	Wed, 29 May 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VOnnQHql"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A51C2305
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008878; cv=none; b=rgvEMW/XSNmbUCN0bQVSLR+Um3ZzT9Vg65f0xN7c52kYfuca4TBZG1/pv7G/cxLs/pM6TkOU4NULqvka7j37K6iPK4v9iBZxyaHzGipQDMcs5fA567JZ7k47sB/qLdUIa9f8fWolW77vARB1RJVibaqMMBf0tW86J79bzFzFhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008878; c=relaxed/simple;
	bh=ey72yrLeOq5dkzbSyIayVN5J/Pk9SHcSRo8jLUBOHDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYyA8n7lxeqyKSlaOw2qJF/uTaNkCTnEj1TGDNTDT6VIFz7d7SY3cf6CHbRAqnLpD9Rflj9FPy18dFI2qy5Qa3mcX9jaFCp9c3x3epQXWRmKEhuFpwpy8YFgCs35+8JqtHYY0Ygpr4JHPdGSGHQ+gYNwjwVdnLJi+3lKz6w5WNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VOnnQHql; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4211249fbafso304495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717008874; x=1717613674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7vDEMF2Cse3GKKKWWJPFMdZWN9OHL0jv0BqXqFqZx0=;
        b=VOnnQHqlyXC01EgFqQW41VhI05t3lG2PiUCMjGVc8aVqjzYocGzklvTrJy+/mCbbTD
         eqBkqYvWWMC2433HPbOpMK3+T6MJK9rkerAgXgwx1JvKuCJmEHrDohcq8/jmTC8sM5J6
         IZffwupmHFYqjjiG4Aldyud6xCggSX3dDtd26Kg83qHmwlY0//de4rUjawAtUFjYNRBG
         dAt6WQlqR64kT1v8oqW/rxobRiHX49MTvMWytaLtv0Kj8nneZ4hEl8vAkw67O3oC2KPv
         OHgbGLX14legP2cZkTE+PyrL3zo8mgzBajh4yPcARxttQcnOBvC2kdwGXE/ceMy3+lDq
         ZkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717008874; x=1717613674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7vDEMF2Cse3GKKKWWJPFMdZWN9OHL0jv0BqXqFqZx0=;
        b=cqWNP1iSca+zOtrlQe61oT7T/NyvSRI8+yoZ1E1jpjXwOO/UP9VlzoQycK9iBa/M/d
         wteTJ4Jac5eO6zWMNbXElglLaxYgyt8+nSPoWy645oPeiPO77Pji//Q8AYDXjkqx0MpV
         sXfMAnnaBcgLZ1/XIm3XAnMh9gndxB5XD7MFeW+uEEc6KTrYfrSRbwIr0j9AGw5hwOL/
         11H13bJvtcB0x7b2+RkCqI1BG0w5I9vCcxzUZsrvn9BRqN8W9va4oMWid/q+fPkX7PaR
         TkQItzaJNuky7h0zvemuKkTms7+4gmxmY5SIcGqhE/b60k/7EMDXM+O+AgeTFezOo754
         FATQ==
X-Gm-Message-State: AOJu0Yzys3YQk9zLyMzNdZ5zLztWtb+DoJbUG/gKZhpDjs6Eu7ebZu2u
	5UgWMdxbrMqvlhAtjJMHw31k9CaCofKTfYDt4f++Stzi7CMzMcpM5Hv9kyWKRl2lHJjZ8cDiqX8
	z
X-Google-Smtp-Source: AGHT+IG0aFRXbEPemdv8ro3r0XN3H/rTAxOwWSQmMr3iD1+X74b6QY7y655sl+IdhOd5xfv/zlwFfw==
X-Received: by 2002:a05:600c:1d9a:b0:421:2065:3799 with SMTP id 5b1f17b1804b1-42127929560mr208155e9.29.1717008873888;
        Wed, 29 May 2024 11:54:33 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706a23csm2787885e9.27.2024.05.29.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:54:33 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	tech-control-transfer-records@lists.riscv.org,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH RFC 4/6] riscv: perf: Add infrastructure for Control Transfer Record
Date: Wed, 29 May 2024 19:53:35 +0100
Message-Id: <20240529185337.182722-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529185337.182722-1-rkanwal@rivosinc.com>
References: <20240529185337.182722-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support Control Transfer Records (CTR) extension, we need to extend the
riscv_pmu framework with some basic infrastructure for branch stack sampling.
Subsequent patches will use this to add support for CTR in the riscv_pmu_dev
driver.

With CTR, the branches are stored into a hardware FIFO, which will be sampled
by software when perf events overflow. A task may be context- switched between
overflows, and to avoid leaking samples we need to clear the last task's
records when a task is context-switched In. To do this we will be using the
pmu::sched_task() callback added in this patch.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 drivers/perf/riscv_pmu_common.c | 15 +++++++++++++++
 drivers/perf/riscv_pmu_dev.c    |  9 +++++++++
 include/linux/perf/riscv_pmu.h  | 16 ++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/perf/riscv_pmu_common.c b/drivers/perf/riscv_pmu_common.c
index b4efdddb2ad9..e794675e4944 100644
--- a/drivers/perf/riscv_pmu_common.c
+++ b/drivers/perf/riscv_pmu_common.c
@@ -159,6 +159,19 @@ u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
 	return GENMASK_ULL(cwidth, 0);
 }
 
+static void riscv_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 bool sched_in)
+{
+	struct riscv_pmu *pmu;
+
+	if (!pmu_ctx)
+		return;
+
+	pmu = to_riscv_pmu(pmu_ctx->pmu);
+	if (pmu->sched_task)
+		pmu->sched_task(pmu_ctx, sched_in);
+}
+
 u64 riscv_pmu_event_update(struct perf_event *event)
 {
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
@@ -406,6 +419,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 	for_each_possible_cpu(cpuid) {
 		cpuc = per_cpu_ptr(pmu->hw_events, cpuid);
 		cpuc->n_events = 0;
+		cpuc->ctr_users = 0;
 		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
 			cpuc->events[i] = NULL;
 	}
@@ -419,6 +433,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 		.start		= riscv_pmu_start,
 		.stop		= riscv_pmu_stop,
 		.read		= riscv_pmu_read,
+		.sched_task	= riscv_pmu_sched_task,
 	};
 
 	return pmu;
diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 5ca8a909f3ab..40ae5fc897a3 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -670,6 +670,14 @@ static void rvpmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 			hwc->idx, sbi_err_map_linux_errno(ret.error));
 }
 
+static void pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			   bool sched_in)
+{
+	struct riscv_pmu *pmu = to_riscv_pmu(pmu_ctx->pmu);
+
+	/* Call CTR specific Sched hook. */
+}
+
 static int rvpmu_sbi_find_num_ctrs(void)
 {
 	struct sbiret ret;
@@ -1494,6 +1502,7 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 	pmu->event_mapped = rvpmu_event_mapped;
 	pmu->event_unmapped = rvpmu_event_unmapped;
 	pmu->csr_index = rvpmu_csr_index;
+	pmu->sched_task = pmu_sched_task;
 
 	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 	if (ret)
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 425edd6685a9..5a6b840018bd 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -33,6 +33,13 @@
 #define RISCV_PMU_CYCLE_FIXED_CTR_MASK 0x01
 #define RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK 0x04
 
+#define MAX_BRANCH_RECORDS 256
+
+struct branch_records {
+	struct perf_branch_stack branch_stack;
+	struct perf_branch_entry branch_entries[MAX_BRANCH_RECORDS];
+};
+
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;
@@ -44,6 +51,12 @@ struct cpu_hw_events {
 	DECLARE_BITMAP(used_hw_ctrs, RISCV_MAX_COUNTERS);
 	/* currently enabled firmware counters */
 	DECLARE_BITMAP(used_fw_ctrs, RISCV_MAX_COUNTERS);
+
+	/* Saved branch records. */
+	struct branch_records *branches;
+
+	/* Active events requesting branch records */
+	int ctr_users;
 };
 
 struct riscv_pmu {
@@ -64,10 +77,13 @@ struct riscv_pmu {
 	void		(*event_mapped)(struct perf_event *event, struct mm_struct *mm);
 	void		(*event_unmapped)(struct perf_event *event, struct mm_struct *mm);
 	uint8_t		(*csr_index)(struct perf_event *event);
+	void		(*sched_task)(struct perf_event_pmu_context *ctx, bool sched_in);
 
 	struct cpu_hw_events	__percpu *hw_events;
 	struct hlist_node	node;
 	struct notifier_block   riscv_pm_nb;
+
+	unsigned int ctr_depth;
 };
 
 #define to_riscv_pmu(p) (container_of(p, struct riscv_pmu, pmu))
-- 
2.34.1


