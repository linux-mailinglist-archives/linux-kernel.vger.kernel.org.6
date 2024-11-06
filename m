Return-Path: <linux-kernel+bounces-398499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265349BF1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE461F22112
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6C9205143;
	Wed,  6 Nov 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crqO/c/0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C020401B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907808; cv=none; b=t5AJ1rKAkXgqGsjrv0rMu0UsmCi52+/+VptS1qibl9e08SAi2vhKeMbWpJDRmZV3m0Md71LTeX36NdnIn51QFIA1MZ97lhyGMFTo3PJU+jpJJd1pXCAmj+0HvxWG3SEF7BTv9E6x7UZZOlx5TMjpE8Jug4W6I9wB4EUr2urGz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907808; c=relaxed/simple;
	bh=rbu1b3dE6mLKMGu8yQda59cGQ4LAmXQAql6IhNHoujo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2WZPWF5eZBOa+So8mYWrXYR00x2KROSSo707uYwaDUV7ZMHIUFGGwywTD2JMaHc7K6ZAXgiJe1c4vnof+H7HDliDyTYevm0nyxbaQXo9AGlLiKR57fcALsStaS/RuZZbbdpzfZvSlf+Dik3qmif31rJDnSzfFS/CbyzP7t8+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crqO/c/0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eaae8b12bfso39948307b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730907805; x=1731512605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=usNj0Res+P4bCyLqWVGxxvAYTWZLXO7GeWJPQrylVz0=;
        b=crqO/c/0scWAHrTagfVJADEHzkwLZxHNBILtDmEyEdYxFNbhxMkKm7YMUt/w6gh5sT
         ZokaPDad6IV1f0g4BMhLwCaQgUOx+dn/rRg48duglTkmXK1jD1kxrNuw6a9wmIt5ciKF
         n/w7qb8YfsHpPNaKKyl/UoCGrpipuRGRQ4fOBTuKcNvA6NzrYClb25bSPptqUh5/XkG2
         qPylOyQDTzXC113ZyUgQAW3sJhF8H85h++XlN5t6oH1ahxuGP7VEH/e/JZBa3XRPlqTK
         wKSeyza5YtOY2ASKKCvjh/Kw77rj+TK89AqGiX/F8F3LJHrDElQjNOrj1qiCB893vj4H
         WBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907805; x=1731512605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usNj0Res+P4bCyLqWVGxxvAYTWZLXO7GeWJPQrylVz0=;
        b=jbtVWLEpMcy3t4cdSChviSJXHyKvAP1uJZMq9uQ1IuPdBVm1c01WqDC+2BE8v6LAQq
         NyXVhtN/VvQ0dl16KyOvHDB40AMfJlMd3iCWmGm1xyOZi9PhlUbDIOFvZAlpum0UvnOh
         i+ipdT8KBZ2YC3tMYjZR2QDLf+CMXIlr2pIbxdde6VX61SInRt7L35tUbfok1arkQm2h
         hJjaYQG4cPSH5TpnLnykX6JswBODVSF9g+2EtQfOkXBCS3lg2+JmRXLZ6URWhLMOZHN9
         5qA1OZlvdwFMLhjUtBsaqqSNy5AllI3PQOX/Jy0oRmFRunj5MDMwOQCfDTkvJrUw/UQJ
         EiTw==
X-Forwarded-Encrypted: i=1; AJvYcCWhp+LxUGYtyX1D7N2xfnV6Vq1y9FwxEZDWJb4ZZQv5MPhTsGANsKg1vqasac1woRdeUEPHTQ5UvB3SyXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qFSh0kcyt730CiVdVIE0LZEdqEHip+jcCDsA5Acc/NuI8MJZ
	jrJ97j8cR0rqNWw/DwpSKQtY4IKv1twfgIm1TKkPfpfIK7il6YMQIB2Ca1WxWh3vN/SQytRzQfp
	kLIUyfeQgGeCK/x1oVVjJDg==
X-Google-Smtp-Source: AGHT+IFhv18Nu4g0EfSKu1p/pyyakaykYVj6NuoNZ/BdHs/bxxa7dQLzTs/SA7cZN0nAiVRZX3JcTtqNpyg+5qXaCQ==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:ce0])
 (user=peternewman job=sendgmr) by 2002:a05:690c:2e08:b0:6e2:1713:bdb5 with
 SMTP id 00721157ae682-6ea52532e9fmr336127b3.5.1730907804789; Wed, 06 Nov 2024
 07:43:24 -0800 (PST)
Date: Wed,  6 Nov 2024 16:43:06 +0100
In-Reply-To: <20241106154306.2721688-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106154306.2721688-1-peternewman@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106154306.2721688-2-peternewman@google.com>
Subject: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter reads
From: Peter Newman <peternewman@google.com>
To: reinette.chatre@intel.com, fenghua.yu@intel.com
Cc: babu.moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	eranian@google.com, hpa@zytor.com, james.morse@arm.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nert.pinx@gmail.com, 
	tan.shaopeng@fujitsu.com, tglx@linutronix.de, tony.luck@intel.com, 
	x86@kernel.org, Peter Newman <peternewman@google.com>
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

Introduce resctrl_arch_event_read_blocks() to allow the implementation
to indicate whether reading a particular event counter blocks. Use this
to limit the usage of smp_call_on_cpu() to only the counters where it is
actually needed. This reverts to the previous behavior of always using
smp_call_function_any() for all x86 implementations.

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
perf tool. The average over 100 iterations is given, with a 1-second
sleep between iterations to better represent the intended use case. The
test was run bound to the CPUs of a single MBM domain, once targeting
counters in the local domain and again for counters in a remote domain.

AMD EPYC 7B12 64-Core Processor (250 mon groups)

Local Domain:   5.72M -> 1.22M (-78.7%)
Remote Domain:  5.89M -> 5.20M (-11.8%)

Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz (220 mon groups)

Local Domain:   3.37M -> 2.52M (-25.4%)
Remote Domain:  5.16M -> 5.79M (+12.0%)

The slowdown for remote domain reads on Intel is worrying, but since
this change is effectively a revert to old behavior on x86, this
shouldn't be anything new.

Also note that the Remote Domain results and the baseline Local Domain
results only measure cycles in the test program. Because all counter
reading work was carried out in kernel worker threads or IPI handlers,
the total system cost of the operation is greater.

Fixes: 09909e098113 ("x86/resctrl: Queue mon_event_read() instead of sending an IPI")

Signed-off-by: Peter Newman <peternewman@google.com>
---
v1: https://lore.kernel.org/lkml/20241031142553.3963058-2-peternewman@google.com/

---
 arch/x86/include/asm/resctrl.h            | 7 +++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 8b1b6ce1e51b2..8696c0c0e1df4 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -178,6 +178,13 @@ static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid
 static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
 					     void *ctx) { };
 
+static inline bool resctrl_arch_event_read_blocks(struct rdt_resource *r,
+						  int evtid)
+{
+	/* all events can be read without blocking */
+	return false;
+}
+
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 200d89a640270..395bcc5362f4e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -548,8 +548,14 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
 	 * MPAM's resctrl_arch_rmid_read() is unable to read the
 	 * counters on some platforms if its called in IRQ context.
+	 *
+	 * smp_call_on_cpu() dispatches to a kernel worker
+	 * unconditionally, even when the event can be read much more
+	 * efficiently on the current CPU, so only use it when
+	 * blocking is required.
 	 */
-	if (tick_nohz_full_cpu(cpu))
+	if (tick_nohz_full_cpu(cpu) ||
+	    !resctrl_arch_event_read_blocks(r, evtid))
 		smp_call_function_any(cpumask, mon_event_count, rr, 1);
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
-- 
2.47.0.199.ga7371fff76-goog


