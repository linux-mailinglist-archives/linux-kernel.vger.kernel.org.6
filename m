Return-Path: <linux-kernel+bounces-373621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD49A5979
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204051C20C66
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA801D0DF4;
	Mon, 21 Oct 2024 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dP2gV3Zn"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED81CFEB0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484553; cv=none; b=ld92Nhv4CqcciJ+R7K791+ZiCuAlVWR9+uynffUUwxTrB7e9iCAa8wCdm5MyTEAdZhnrYmY/tZLiF4qWsPrpNi14Qthnf5hf3+YtTTPTV7+3+t9mwa3tCDjNX+Sb0EWzlbq6V+P5A4NGPemwlj+NPVqClsmKps1kzNNRWlCAj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484553; c=relaxed/simple;
	bh=yxPuj92Fmmn3KaM12Xuj4lY8zDFa3ylivFiGQ6oeGpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Umx2JupjrdFe2QIvTfKEV6awuUnqKS5GcmVDn0l6RWDIH5lhOhnA0xu9OBVWcyJM3D1wKiwRVdET+pEiAolJ7ZqW3jLpuNPUHcvRNcBu/jR7Bh+SmMAYN5FmxQ2W/bbYIQjag8n6uLfvJ6tyEEcbp4UZGhxrtWYTb1Xt+nFhjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dP2gV3Zn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2bd9b1441aso1483676276.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729484550; x=1730089350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rF+TQYGEDP6+t2V2Dte+w8ImgbG43FZ1I4yOJyMV9jY=;
        b=dP2gV3ZnkZrNO/8ipXjP6I2QFG/yzaZiiAHQCXCfqFLorIfNQR7aNZLwCliGdNUqzR
         z0VpR9fCU/Q10NmLbBwpmrXrRD0NL6TUW4CzhAnniutlID6iMO9aPXQqe5kgdl6DbIv0
         Ybgnf5ush5ks8DTMItbFc9LJz/sszMX46YDkziW78qO4/vyIacbLcaJmjhBwUkpjOeix
         ccxFEAQkJqF1gOEwzjVP30yNGGfVCS5jt5w/zVCXGDcH9uSKHKeVLRXLirykj/rZz6Rk
         oKHUz9a/OV9Y1jbovnTmNoLMplqamO4817glHB7/BikU3UOaCv+6sXOu5ckuCudDgzdm
         6UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729484550; x=1730089350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rF+TQYGEDP6+t2V2Dte+w8ImgbG43FZ1I4yOJyMV9jY=;
        b=W+5AbBVbKc2m053wtKV8wHJ6AbPzwpXL7+76MAqHwogZH7LDl/DyoiMEyyMT1QqVRJ
         kCH3XlzjJ91hBKiHQfWp/vJUGuV0yX/HO9U69WZ65EZ2Edok3CJcIZafGC61Dy8Ie7Gw
         WVYswsbR694Y+5nxvDBeKgGRYU6usZXYCqJXIQoLpq68JrMkU5hENEYbk/AFPI10BImd
         S8WbLIXe6KLRMb26Llf7b4Zh/Lc98b48aGQtgy6eRP41U0LKZQXZwsewDMJGT6fmG/gf
         yBNiTsqE3NqzMmyj7RCCGH0o+vQ3KEIaVc7DddqvFquI793Rm2l/VqONv8de6YHrLtHd
         rNjg==
X-Forwarded-Encrypted: i=1; AJvYcCW9H7b2zbKkfB9epaEVOADKXIMKaxl1EsiahC2mK5kA4YIMPCoocA0mPoPHX43r6zEURTq3gT5RwxW6aJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0shx4qJDKub132dNPivZhmfPX9/DPH8T6hvKykPTXfcQ2CiH
	C5ONLH3e7CvQx5vTwY5bIMxfZEKeQAwMW5o9WkKFNojUrxb8bgogqpnmlcb+h74MiMHMchpoagx
	k/g==
X-Google-Smtp-Source: AGHT+IEeIIe5Xg98lfzs9VJWYOJ07F6ek87y8El+d0cpjxlVvqWrNUTXfkoh0Qdzc1+S/vFogSJ2meafeF0=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:1569:9ef4:20ab:abf9])
 (user=yuzhao job=sendgmr) by 2002:a25:800f:0:b0:e05:6532:166 with SMTP id
 3f1490d57ef6-e2bb11cccaemr14439276.1.1729484550141; Sun, 20 Oct 2024 21:22:30
 -0700 (PDT)
Date: Sun, 20 Oct 2024 22:22:15 -0600
In-Reply-To: <20241021042218.746659-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021042218.746659-4-yuzhao@google.com>
Subject: [PATCH v1 3/6] irqchip/gic-v3: support SGI broadcast
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
  perf record -g -- bash -c "echo 600 >hugepages-1048576kB/demote"

         gic_ipi_send_mask()  bash sys time
Before:  38.14%               0m10.513s
After:    0.20%               0m5.132s

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/irqchip/irq-gic-v3.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ce87205e3e82..42c39385e1b9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1394,9 +1394,20 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	gic_write_sgi1r(val);
 }
 
+static void gic_broadcast_sgi(unsigned int irq)
+{
+	u64 val;
+
+	val = BIT(ICC_SGI1R_IRQ_ROUTING_MODE_BIT) | (irq << ICC_SGI1R_SGI_ID_SHIFT);
+
+	pr_devel("CPU %d: broadcasting SGI %u\n", smp_processor_id(), irq);
+	gic_write_sgi1r(val);
+}
+
 static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
+	cpumask_t broadcast;
 
 	if (WARN_ON(d->hwirq >= 16))
 		return;
@@ -1407,6 +1418,13 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 */
 	dsb(ishst);
 
+	cpumask_copy(&broadcast, cpu_present_mask);
+	cpumask_clear_cpu(smp_processor_id(), &broadcast);
+	if (cpumask_equal(&broadcast, mask)) {
+		gic_broadcast_sgi(d->hwirq);
+		goto done;
+	}
+
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(gic_cpu_to_affinity(cpu));
 		u16 tlist;
@@ -1414,7 +1432,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
 		gic_send_sgi(cluster_id, tlist, d->hwirq);
 	}
-
+done:
 	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
 	isb();
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


