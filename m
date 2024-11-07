Return-Path: <linux-kernel+bounces-400588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FEF9C0F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B01B1C22A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673F2185AC;
	Thu,  7 Nov 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxFQYvX6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A31218584
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010847; cv=none; b=aQOd7vREqZ8+1VDrCFKh8irF1e2j+PVXo/Cup++BR1IIeG0WMHfBfhj0j+3ZQfpje0RyFZqjX/5Bkj+dZJQdXhOTbjdCIWEOdQgL7zjGVufxqIFwMZSkayFn1T34K3yYM+wWZHNHlfiTdQJHZGHi5vEgxzeBIPWm/sETSpUvc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010847; c=relaxed/simple;
	bh=U5hWtQ7GpNtk7DTjtDQFFiL8/QWpDr8Gl41jRC3L+Jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FzoxTV7hwmeSP01ZyiFQYhaT0P39CUWM49kxoXhS0iOloUpyJnuobSqAPsTY2m2WaO1nfLc1iCk6R0f+Czv7HPGB4m4enKSmw8joEncw2BKeDeGhJqIQUB4cn1zdq6NmT/uUbEAJnZmRZhRPa/M7UTKKqwcS6N/qoqyAKdSblBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxFQYvX6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e33152c8225so2940973276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731010845; x=1731615645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v35HyYfzjB2bG4AOilBZdKULCbIxbvNUBJLvIql+6B0=;
        b=HxFQYvX6i5Bs+tCBM0JDGtVLLdNzBS5W1SkyCPyRm/1EOVVJLm3HWj4eRxXXzlCz5Y
         CFlVGy2RcZgRYQ6cDGJ39BvNpwfDrR3jgoPpU532QgALbE0WCzwfoMY9opC8jv2iSwDF
         8LMDmJ4LOZipfSfJyeKltlXg29OwI/MLqylWJE0GptCUNlO12UNJp2REkd8popdkuwMQ
         poAWFYeQcSyCk028sdWkgxpZ39Sj23FEvgcm0qQ8zLsFw8cy7Ee0E0BfFYA1i3602/Yh
         c8gfUsQfHPXK3dmvNXrdfvT9yKDyGUZ7VwO1J3ZAaQ4jc9TLDyaBFblX8Wg/dAfWcjpH
         vPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010845; x=1731615645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v35HyYfzjB2bG4AOilBZdKULCbIxbvNUBJLvIql+6B0=;
        b=KoRIPnox1qxt3H1jhsG0p9aR8AE0PCclvioY2IVhKZHnxRvXSrGGL03xlX0EXwoztG
         1eqfzxV9E7XFgjRW3bxFkIRSUKTomp8d4IFNpewe9FBFGswhIzm0DbzckecP/hJCXNVv
         CcMM/nXi0jsbD9DwgD8xRwLbO1Q2qxfQ7/1Ap6Vs1HxWZoIbbnMnVFrYuKwDSF72Qdr9
         j/qvGBrG4mD92yo6lHlTEAOtDptYIXxlKsxlKxhEWHFRgJ+k582Vam0mPsatcEIZfpEF
         0vTw9w+C+wMqJJjURu7J9/zOvejrbExfPn8X5+ioUciuW4EsZ70wTuGhP31vAJjlb0MC
         3tYg==
X-Forwarded-Encrypted: i=1; AJvYcCUs91FT4Ix9+xkX7WXzoBU/HfJ09RYTKQMKDpKeMdwaOYkoMtxYpjo+ec3Mo+SI+QX8Uq6Ewd/8zgyh4pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJVFFjb5mZuuAV5rBW2xtYDjD5KCCaMLZz32HyRFnd3iFzbVe
	s3aE4NxHb7nZj66Rr8SzX30DluV/oQmrV2zVA42z/PZjJ3LSmKUV5kl1sZ1hQBD48dN9xqQu9yh
	IJQ==
X-Google-Smtp-Source: AGHT+IH5+g5PrNVgp5Pr5OTYOBdUbFjFulnS4uSn6ZxFeBhddvMAobpkpn0NbUnR+mioP6ARIrKUFKFKqUg=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:a4c0:c64f:6cdd:91f8])
 (user=yuzhao job=sendgmr) by 2002:a25:a249:0:b0:e28:e510:6ab1 with SMTP id
 3f1490d57ef6-e337f8faff5mr210276.8.1731010845128; Thu, 07 Nov 2024 12:20:45
 -0800 (PST)
Date: Thu,  7 Nov 2024 13:20:30 -0700
In-Reply-To: <20241107202033.2721681-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107202033.2721681-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107202033.2721681-4-yuzhao@google.com>
Subject: [PATCH v2 3/6] irqchip/gic-v3: support SGI broadcast
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

GIC v3 and later support SGI broadcast, i.e., the mode that routes
interrupts to all PEs in the system excluding the local CPU.

Supporting this mode can avoid looping through all the remote CPUs
when broadcasting SGIs, especially for systems with 200+ CPUs. The
performance improvement can be measured with the rest of this series
booted with "hugetlb_free_vmemmap=on irqchip.gicv3_pseudo_nmi=1":

  cd /sys/kernel/mm/hugepages/
  echo 600 >hugepages-1048576kB/nr_hugepages
  echo 2048kB >hugepages-1048576kB/demote_size
  perf record -g time echo 600 >hugepages-1048576kB/demote"

With 80 CPUs:
           gic_ipi_send_mask()  bash sys time
  Before:  38.14%               0m10.513s
  After:    0.20%               0m5.132s

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/irqchip/irq-gic-v3.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ce87205e3e82..7ebe870e4608 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1322,6 +1322,7 @@ static void gic_cpu_init(void)
 
 #define MPIDR_TO_SGI_RS(mpidr)	(MPIDR_RS(mpidr) << ICC_SGI1R_RS_SHIFT)
 #define MPIDR_TO_SGI_CLUSTER_ID(mpidr)	((mpidr) & ~0xFUL)
+#define MPIDR_TO_SGI_TARGET_LIST(mpidr)	(1 << ((mpidr) & 0xf))
 
 /*
  * gic_starting_cpu() is called after the last point where cpuhp is allowed
@@ -1356,7 +1357,7 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 	mpidr = gic_cpu_to_affinity(cpu);
 
 	while (cpu < nr_cpu_ids) {
-		tlist |= 1 << (mpidr & 0xf);
+		tlist |= MPIDR_TO_SGI_TARGET_LIST(mpidr);
 
 		next_cpu = cpumask_next(cpu, mask);
 		if (next_cpu >= nr_cpu_ids)
@@ -1394,9 +1395,20 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	gic_write_sgi1r(val);
 }
 
+static void gic_broadcast_sgi(unsigned int irq)
+{
+	u64 val;
+
+	val = BIT_ULL(ICC_SGI1R_IRQ_ROUTING_MODE_BIT) | (irq << ICC_SGI1R_SGI_ID_SHIFT);
+
+	pr_devel("CPU %d: broadcasting SGI %u\n", smp_processor_id(), irq);
+	gic_write_sgi1r(val);
+}
+
 static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
-	int cpu;
+	int cpu = smp_processor_id();
+	bool self = cpumask_test_cpu(cpu, mask);
 
 	if (WARN_ON(d->hwirq >= 16))
 		return;
@@ -1407,6 +1419,19 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 */
 	dsb(ishst);
 
+	if (cpumask_weight(mask) + !self == num_online_cpus()) {
+		/* Broadcast to all but self */
+		gic_broadcast_sgi(d->hwirq);
+		if (self) {
+			unsigned long mpidr = gic_cpu_to_affinity(cpu);
+
+			/* Send to self */
+			gic_send_sgi(MPIDR_TO_SGI_CLUSTER_ID(mpidr),
+				     MPIDR_TO_SGI_TARGET_LIST(mpidr), d->hwirq);
+		}
+		goto done;
+	}
+
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(gic_cpu_to_affinity(cpu));
 		u16 tlist;
@@ -1414,7 +1439,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
 		gic_send_sgi(cluster_id, tlist, d->hwirq);
 	}
-
+done:
 	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
 	isb();
 }
-- 
2.47.0.277.g8800431eea-goog


