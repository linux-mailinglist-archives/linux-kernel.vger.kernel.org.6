Return-Path: <linux-kernel+bounces-562378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08834A624F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D001519C4D74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A818DB1D;
	Sat, 15 Mar 2025 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFa12g8I"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686E18C92F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007104; cv=none; b=ug4HcGrGbE0ti3xsUNCtvSlyIdijMfqEhVrSyPN5/cYcIJ/u7QUvcAC2pw4Gr7LrISIGl49f7HJMLSPwUDb0h16xPjEOGxvOZVZYARxoZnD5rDlon8FvKWi/IH9c+qazLqlMeCLyE3FOw0MeQfHxlJ2GJ2PggXE/fvm564nm/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007104; c=relaxed/simple;
	bh=cklmUwPs0BxA9rEG9UWa48PfZeDOKMwX41YSmqVc8mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubP4yi1DpvqnWBqtCEPuvG+WUI9yILnCVqH3/MF5VJbAIzy2F1zibjRhEZUWHPxElN8wIcLNz+sBGGYRFUcnfrwQpeHXW6PHOCijFFsx0Ja7RrkyFhV/UaRNha/BGFE8d7nL2ENPkrJLscSOIGUrgzeMNWOr/IcbsCqzpNHSTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFa12g8I; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240c997059so59369455ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007101; x=1742611901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hsZoVmhQefEgpTWMkq2HswkVofLF7WHPskHUUQL39pM=;
        b=IFa12g8IFYEeL4W10sYVZLSPqt0/h8xVKxPuZBWQj0VAPbdq1I9G82YAclfPlkEG6B
         p4IE+OLlAPr2NM1H21vXQ9ecSjtBE2ktFRSlu2rBapueeAxjJLp9bSLZUOBuNN6XBMGq
         wizGjkNKQhJPoG/TrQDxi1A+7CjGrYPGSYL08zHhXx5Ag/nXe5LA+RvCqqmldf8F4SLI
         YilBLUGxeXNymD4VvvJa+5mNWKa2HohbrVCuWMZs75/j2HtOV9SBEZ7eYM9Q0t8yIWr+
         p3PsVWtq+Cu8qOpc6YLFWrRWJ/EKnYWyrzqCBhhM06w5lHgTD73nzIwGzotgMyWxDq6a
         NG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007101; x=1742611901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsZoVmhQefEgpTWMkq2HswkVofLF7WHPskHUUQL39pM=;
        b=rs626QcA25OzLlTQd9w7Nuxr1E7n/Yxk1RhiSDj1fshrU2Q4373gs1Cd/ep8eFdSbo
         5kmFVYkbbGDAO3EGfPbx2xMABVXRscJneeETLvjAgoBebuchl8RGxZjFwDqTgpzqkop7
         +PQ9MJp3aIJzJ3H2BpwTHKvw5xBCa+rfSdDy+FCeoS20+TGI36F097y6U1DTntulbxXd
         MMjHoIHxIysoXiUQMqCnYuDu47KSgyg8BhQr2aNcynURtwMTQ5LIss/De8B1LLiYt73C
         yEr6S9csMUNNj8gUc6zsEsf6t2FUpZwzTAPfHBl/OvPYz0Tv2kAWh/eM6dB0gW/Aklfp
         TGww==
X-Forwarded-Encrypted: i=1; AJvYcCVIRc1XI7GakNHKBac9UW6XaZXh0hM7BOyEeqhjiqR3Unldzh23BdlFteRYHd595xKScu3B+mGHkCBmv5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYXMsE7eqbDqiBkWXUKvcP12ZaaIyb4nDclX3Tq6PdAI93Slx
	8sFHDOawNkp7jc4rghK505B2WMOZMIX52pltl4/j/thcBai/iyn+wG92C8BINiBpCCGBYRYlQW+
	Dcw==
X-Google-Smtp-Source: AGHT+IF3FyGhKX75Hq9YTFpkiJaxD/Kh+N2dlF6+aF64zugIVthmZiSeHYdR4w+YvG5hNjn+DctyXCgsp2g=
X-Received: from pfbna3.prod.google.com ([2002:a05:6a00:3e03:b0:736:4ad6:181b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c3:b0:736:4830:68a6
 with SMTP id d2e1a72fcca58-73722311d89mr5664120b3a.4.1742007101170; Fri, 14
 Mar 2025 19:51:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:51:35 -0700
In-Reply-To: <20250315025135.2365846-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315025135.2365846-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315025135.2365846-3-seanjc@google.com>
Subject: [PATCH 2/2] iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ
 affinity changes
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't overwrite an IRTE that is posting IRQs to a vCPU with a posted MSI
entry if the host IRQ affinity happens to change.  If/when the IRTE is
reverted back to "host mode", it will be reconfigured as a posted MSI or
remapped entry as appropriate.

Drop the "mode" field, which doesn't differentiate between posted MSIs and
posted vCPUs, in favor of a dedicated posted_vcpu flag.  Note!  The two
posted_{msi,vcpu} flags are intentionally not mutually exclusive; an IRTE
can transition between posted MSI and posted vCPU.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/intel/irq_remapping.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index c495b533103f..ea3ca5203919 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -25,11 +25,6 @@
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
-enum irq_mode {
-	IRQ_REMAPPING,
-	IRQ_POSTING,
-};
-
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -49,8 +44,8 @@ struct irq_2_iommu {
 	u16 irte_index;
 	u16 sub_handle;
 	u8  irte_mask;
-	enum irq_mode mode;
 	bool posted_msi;
+	bool posted_vcpu;
 };
 
 struct intel_ir_data {
@@ -138,7 +133,6 @@ static int alloc_irte(struct intel_iommu *iommu,
 		irq_iommu->irte_index =  index;
 		irq_iommu->sub_handle = 0;
 		irq_iommu->irte_mask = mask;
-		irq_iommu->mode = IRQ_REMAPPING;
 	}
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
@@ -193,8 +187,6 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 
 	rc = qi_flush_iec(iommu, index, 0);
 
-	/* Update iommu mode according to the IRTE mode */
-	irq_iommu->mode = irte->pst ? IRQ_POSTING : IRQ_REMAPPING;
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
 	return rc;
@@ -1173,9 +1165,18 @@ static void __intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
 
+	/*
+	 * Don't modify IRTEs for IRQs that are being posted to vCPUs if the
+	 * host CPU affinity changes.
+	 */
+	if (ir_data->irq_2_iommu.posted_vcpu && !force_host)
+		return;
+
+	ir_data->irq_2_iommu.posted_vcpu = false;
+
 	if (ir_data->irq_2_iommu.posted_msi)
 		intel_ir_reconfigure_irte_posted(irqd);
-	else if (force_host || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+	else
 		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
 }
 
@@ -1270,6 +1271,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		irte_pi.pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
 				~(-1UL << PDA_HIGH_BIT);
 
+		ir_data->irq_2_iommu.posted_vcpu = true;
 		modify_irte(&ir_data->irq_2_iommu, &irte_pi);
 	}
 
@@ -1496,6 +1498,9 @@ static void intel_irq_remapping_deactivate(struct irq_domain *domain,
 	struct intel_ir_data *data = irq_data->chip_data;
 	struct irte entry;
 
+	WARN_ON_ONCE(data->irq_2_iommu.posted_vcpu);
+	data->irq_2_iommu.posted_vcpu = false;
+
 	memset(&entry, 0, sizeof(entry));
 	modify_irte(&data->irq_2_iommu, &entry);
 }
-- 
2.49.0.rc1.451.g8f38331e32-goog


