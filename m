Return-Path: <linux-kernel+bounces-248484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C792DDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45E5281F55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3A7441E;
	Thu, 11 Jul 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhjAmBCm"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5B49633
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660488; cv=none; b=jjFSW+CPyqQvMu7lPChhRmz5MmUGU8TAaF17J3vUXs57Y8tDQdxqDoFN5rJhnSDg8OrzzEvfOYCt8hGn8GiOTRC8VatHIOBe0M0amKLro1mFWiOJqdYc502LGnIk+RcHHwPq096TGpcRp+88FAegCizb7ldl1wH9GIcoK5xvPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660488; c=relaxed/simple;
	bh=jpK9gpx4mwz9Ip7ArgzSvrWb+97L8VJXBeoavCEVQrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnbFBz6Ym+HCUz7tnhXaLoUXczv2zhocZOI/FpCaRUVJtbxTkgX/YHUvge0x9FN1xvHBqxcb/jPgZQRlaXIHoZDUmB5NkLEkRLG4vZdLDPt1fS6hmbYuMjXUSo0EzDrF8GrHXBwSaqGAw/F/UEzgjesBGU1RAoHZL/mME3v2VQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhjAmBCm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so327747a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720660486; x=1721265286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCLtE9a98yQ84pIGLsB45LsNolPZVaAkGM1lTRl0TOY=;
        b=dhjAmBCmdJuibOG69MPbEk/6eDu1GZ/JnOj2qmmUrQsQyT+nk0POi7zPv1/r3aC1c+
         /XCM6i5UHqfXFn6yAaRrqrbiAyppQ1f/rHtPd2LpcOeAXAsn4anhTz3oJnHyg2MJFnBW
         7SoEkKIj21KgijT0vxxWgvlIZ4KJ6wI2Jt27AYnWf9/XdJcahKvYA/u5VFSWI+VMNFxE
         y2F5UVM4YFmAG7FJm9+CutOCVKLJLpk9UyZ3zmbOaqfKlNKKigoKMv76Dh3hSn2ABe/j
         e/u26zfC+xRdstYOa8DL5DeHAQKxAzSCBjMIBU8gnFgmbuRPq7LhbNgSAqvAfQrhLHVS
         9GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660486; x=1721265286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCLtE9a98yQ84pIGLsB45LsNolPZVaAkGM1lTRl0TOY=;
        b=NVq1KqOZ5b6ktqyWuigIDFTU1L9hGhtorw6CYo+6O1amzTotYB6wvzwQeslvBtVh9Y
         +rhLNKEQGN8LwHm98QaK6+MCUM6NLsm8GRGdOiJ0hwx0exlAfVXoFnjl/V6MAQjRFnG9
         VHJ8GgzydY/tkWCRhL9f49dcViQRjGFDzfQ/ai+6XBPPPJyQ6vP8LkBUUPA8mtNFiHn7
         KSorsofkDWhHhzGTUKt+14yaDT7w6G/8QJDWiRY8VOm1pmvzQW6GpVeerMFDrWriLnBy
         oeEtNePNglfO7ypjvi/NO+p831ed6nvOH4UiUq8QcT32iBGApba8wbzdgxiYpTvLoNtr
         dZ1g==
X-Gm-Message-State: AOJu0YzTJkpclmxr7qDaweSfidCNAVDAqQ8UE7wZIA5ahKm2nmjqx07x
	Vw5fS2V6HEK1B3cDLHdRaTCvssa3tcGx6R/Hna9EHHS2AqrjPDDX
X-Google-Smtp-Source: AGHT+IE/H+H8AunmyNnY74CAjdrBOR1nA1/jAU5LbLJuI07fL4H4o8CopxuzuBhGCZO/Zv9K63h0zQ==
X-Received: by 2002:a17:90a:b10d:b0:2c7:e24d:f695 with SMTP id 98e67ed59e1d1-2ca35c2765fmr5494466a91.12.1720660486142;
        Wed, 10 Jul 2024 18:14:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a951741sm12664630a91.15.2024.07.10.18.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:14:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext/scx_qmap: Pick idle CPU for direct dispatch on !wakeup enqueues
Date: Wed, 10 Jul 2024 15:14:03 -1000
Message-ID: <20240711011434.1421572-7-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711011434.1421572-1-tj@kernel.org>
References: <20240711011434.1421572-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because there was no way to directly dispatch to the local DSQ of a remote
CPU from ops.enqueue(), scx_qmap skipped looking for an idle CPU on !wakeup
enqueues. This restriction was removed and sched_ext now allows
SCX_DSQ_LOCAL_ON verdicts for direct dispatches.

Factor out pick_direct_dispatch_cpu() from ops.select_cpu() and use it to
direct dispatch from ops.enqueue() on !wakeup enqueues.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 39 ++++++++++++++++++++++++++--------
 tools/sched_ext/scx_qmap.c     |  5 +++--
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 27e35066a602..892278f12dce 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -120,11 +120,26 @@ struct {
 } cpu_ctx_stor SEC(".maps");
 
 /* Statistics */
-u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
+u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued, nr_ddsp_from_enq;
 u64 nr_core_sched_execed;
 u32 cpuperf_min, cpuperf_avg, cpuperf_max;
 u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
 
+static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
+{
+	s32 cpu;
+
+	if (p->nr_cpus_allowed == 1 ||
+	    scx_bpf_test_and_clear_cpu_idle(prev_cpu))
+		return prev_cpu;
+
+	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu >= 0)
+		return cpu;
+
+	return -1;
+}
+
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -137,17 +152,14 @@ s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		return -ESRCH;
 	}
 
-	if (p->nr_cpus_allowed == 1 ||
-	    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+	cpu = pick_direct_dispatch_cpu(p, prev_cpu);
+
+	if (cpu >= 0) {
 		tctx->force_local = true;
+		return cpu;
+	} else {
 		return prev_cpu;
 	}
-
-	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
-	if (cpu >= 0)
-		return cpu;
-
-	return prev_cpu;
 }
 
 static int weight_to_idx(u32 weight)
@@ -172,6 +184,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
 	void *ring;
+	s32 cpu;
 
 	if (p->flags & PF_KTHREAD) {
 		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
@@ -207,6 +220,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
+	/* if !WAKEUP, select_cpu() wasn't called, try direct dispatch */
+	if (!(enq_flags & SCX_ENQ_WAKEUP) &&
+	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
+		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
+		return;
+	}
+
 	/*
 	 * If the task was re-enqueued due to the CPU being preempted by a
 	 * higher priority scheduling class, just re-enqueue the task directly
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 304f0488a386..c9ca30d62b2b 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -116,10 +116,11 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64"\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64" enq_ddsp=%"PRIu64"\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
 		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
-		       skel->bss->nr_core_sched_execed);
+		       skel->bss->nr_core_sched_execed,
+		       skel->bss->nr_ddsp_from_enq);
 		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
 			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
 			       skel->bss->cpuperf_min,
-- 
2.45.2


