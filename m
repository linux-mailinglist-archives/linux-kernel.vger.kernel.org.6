Return-Path: <linux-kernel+bounces-390651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F04C9B7CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6197B1C20A27
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC11A255C;
	Thu, 31 Oct 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lz9Xrwm2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9219F121
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384768; cv=none; b=nNvFfPU02WIOHZBgYBifeSx6kPXOj5MzZPrw8ID9d2vJyD72Ve3rlY/w70xFFYgd0u8Qe6SqCqfCfUKRolx0fmCG563/Rf4g9gzq89sfrT6Xx6aeXc7t7Mm1hZzxTTsz/jQk6zsDEFXjTSbcLXLlr+Z4DQzo/lnn1+QSMHjG0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384768; c=relaxed/simple;
	bh=Yamt+HkC0wSHT98EcLYE2jEMY1B61rImNeZ9vQXQT2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pj5xne6NjGZvscCwsIjHvznwXs1wAjpn5QZsMycfBGQaCaYKUGyvA5WTDEH2yHDOZ31qf3hi3tyAW7y/vZM8v7atZyjYP2bw45aF1ttIzJUBNXWiVtnIaLEZAvgbeMWrPGmDAner408Wj7vBqIVpX74QwCNBSb+e0yp2GVqkduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lz9Xrwm2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30cf121024so1869372276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730384762; x=1730989562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytyviXaZdFvTdRO+iqVvRMlQ7Z8pa1odguudKExnw/8=;
        b=Lz9Xrwm2yxFrSZBX1FeNHhBqFiceRZCGH6EyDa0yjigfuHyO7lTIMBPZoPTmZ+9d9s
         7fkODvd2j6H8YDq1QSf+UpP/NYF+8fZOQj9oh9vjOeKYe0GrsahSn1GP7H69NkooUi5r
         /ZeTkzm6dXV3SxubRi9DKMIo2Z8Yl4R+qU1Zl4++y38oaUQBbUZZzRJLZb174QV6Hl7/
         FHMu/YNcmdhmSPtfdd2MAhwYrHnUJ1VlbKAZ5om96g10xW6zxZjHyBp4uODHrd/Ut6nZ
         B8w0PaDKnQO3zRW3Js8BriA6HJc/RPLUSzLXMQefgAmjs/fL89qnafMu/1PLp6oOVoqY
         91Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384762; x=1730989562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytyviXaZdFvTdRO+iqVvRMlQ7Z8pa1odguudKExnw/8=;
        b=PVjrU9v624mOFHdzigTrUNWCIUsXu78uwhJu1acfSofk+St0Lq2Wr2Wa1ARl9GKOuV
         Pn/WHxjYR58gvHXo1C7NLYStTqxGdFyW3L99nNWELgLORneanMGQedUJJIqkMH+2nSrO
         bJpOJq3NaM+lfUQBpVjL55uKobqWMa679j8xR9D4cqmy6rRnIBQYnhsQ6rrkaruevgst
         HZ14Nx9quY9J7p+bvjdlUKtrD9ByX9GQ5i6OI45NEw5liFDVcMxUcZ4Br8cv/r57jwmy
         eZsqtEBXA/AhBbYYMbkhzEdgWyVGZehfGXW41mq99bKgSSPAAZHXPmsk390dyRvTYgxu
         6EAw==
X-Forwarded-Encrypted: i=1; AJvYcCVF05uEJfsV5pEKG3EU1NV8joKJnKOOslH1uDvHNNVqSaCvmot13HS8VSx8CR/Tk0LO4wP+Sorres3eDpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2d6sEuMKJvFo7x+25FEkTtvVPLYiEAfiK7W4eyE9T4nBX/lHd
	72n8ceCW6f9h2Lzj7zf6bSK0hG4aSx8VhwA3Pi6F67kZpjsCsY6suztv728EiDS1e29YEkYx241
	l6NXcCx/ZoPxStd/pzCbYaQ==
X-Google-Smtp-Source: AGHT+IHn5HrxtMCZj+i87Ygr9/3J7/lkdJC2cqsHjWg/GNN050KLmJbpjOGjQt86mtCMfrQvteDMeD8plaSAUqYj6g==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:ce0])
 (user=peternewman job=sendgmr) by 2002:a25:824b:0:b0:e24:9f58:dd17 with SMTP
 id 3f1490d57ef6-e30878471b4mr40077276.1.1730384762551; Thu, 31 Oct 2024
 07:26:02 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:25:53 +0100
In-Reply-To: <20241031142553.3963058-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031142553.3963058-1-peternewman@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241031142553.3963058-2-peternewman@google.com>
Subject: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter reads
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
	James Morse <james.morse@arm.com>, Martin Kletzander <nert.pinx@gmail.com>, 
	Shaopeng Tan <tan.shaopeng@fujitsu.com>, linux-kernel@vger.kernel.org, eranian@google.com, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

Performance-conscious users may use threads bound to CPUs within a
specific monitoring domain to ensure that all bandwidth counters can be
read efficiently. The hardware counters are only accessible to CPUs
within the domain, so requests from CPUs outside the domain are
forwarded to a kernel worker or IPI handler, incurring a substantial
performance penalty on each read.  Recently, this penalty was observed
to be paid by local reads as well.

To support blocking implementations of resctrl_arch_rmid_read(),
mon_event_read() switched to smp_call_on_cpu() in most cases to read
event counters using a kernel worker thread. Unlike
smp_call_function_any(), which optimizes to a local function call when
the calling CPU is in the target cpumask, smp_call_on_cpu() queues the
work unconditionally.

Add a fast-path to ensure that requests bound to within the monitoring
domain are read using a simple function call into mon_event_count()
regardless of whether all CPUs in the target domain are using nohz_full.

This is significant when supporting configurations such as a dual-socket
AMD Zen2, with 32 L3 monitoring domains and 256 RMIDs. To read both MBM
counters for all groups on all domains requires 32768 (32*256*2) counter
reads. The resolution of global, per-group MBM data which can be
provided is therefore sensitive to the cost of each counter read.
Furthermore, redirecting this much work to IPI handlers or worker
threads at a regular interval is disruptive to the present workload.

The test program fastcat, which was introduced in an earlier path, was
used to simulate the impact of this change on an optimized event
counter-reading procedure. The goal is to maximize the frequency at
which MBM counters can be dumped, so the benchmark determines the cost
of an additional global MBM counter sample.

The total number of cycles needed to read all local and total MBM
counters for a large number of monitoring groups was collected using the
perf tool. The test was run bound to a single CPU: once targeting
counters in the local domain and again for counters in a remote domain.
The cost of a dry-run reading no counters was substracted from the total
of each run to remove one-time setup costs.

AMD EPYC 7B12 64-Core Processor (250 mon groups)

Local Domain:   3.25M -> 1.22M (-62.5%)
Remote Domain:  7.91M -> 8.05M (+2.9%)

Intel(R) Xeon(R) Gold 6268CL CPU @ 2.80GHz (190 mon groups)

Local Domain:   2.98M -> 2.21M (-25.8%)
Remote Domain:  4.49M -> 4.62M (+3.1%)

Note that there is a small increase in overhead for remote domains,
which results from the introduction of a put_cpu() call to reenable
preemption after determining whether the fast path can be used. Users
sensitive to this cost should consider avoiding the remote counter read
penalty completely.

Also note that the Remote Domain results and the baseline Local Domain
results only measure cycles in the test program. Because all counter
reading work was carried out in kernel worker threads, the total system
cost of the operation is greater.

Fixes: 09909e098113 ("x86/resctrl: Queue mon_event_read() instead of sending an IPI")

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 200d89a640270..daaff1cfd3f24 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -541,6 +541,31 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
+	/*
+	 * If a performance-conscious caller has gone to the trouble of binding
+	 * their thread to the monitoring domain of the event counter, ensure
+	 * that the counters are read directly. smp_call_on_cpu()
+	 * unconditionally uses a work queue to read the counter, substantially
+	 * increasing the cost of the read.
+	 *
+	 * Preemption must be disabled to prevent a migration out of the domain
+	 * after the CPU is checked, which would result in reading the wrong
+	 * counters. Note that this makes the (slow) remote path a little slower
+	 * by requiring preemption to be reenabled when redirecting the request
+	 * to another domain was in fact necessary.
+	 *
+	 * In the case where all eligible target CPUs are nohz_full and
+	 * smp_call_function_any() is used, keep preemption disabled to avoid
+	 * the cost of reenabling it twice in the same read.
+	 */
+	cpu = get_cpu();
+	if (cpumask_test_cpu(cpu, cpumask)) {
+		mon_event_count(rr);
+		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
+		put_cpu();
+		return;
+	}
+
 	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
 
 	/*
@@ -554,6 +579,9 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
+	/* If smp_call_function_any() was used, preemption is reenabled here. */
+	put_cpu();
+
 	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
 }
 
-- 
2.47.0.199.ga7371fff76-goog


