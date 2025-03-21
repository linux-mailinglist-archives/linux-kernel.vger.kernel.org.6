Return-Path: <linux-kernel+bounces-571877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AECA6C37B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08309177D58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EA122FDE8;
	Fri, 21 Mar 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aprp1uGp"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5522E3E1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586242; cv=none; b=f/HmtcCUeZFcil+0Vi501ART1a82gPflU/JuzJoh2wHCeDNnG0KKOoyo27HeoGAczCiFO48EWrg8c67+nUBJiIGnJ+IDdF5sC6gQxnqTXBEOS4JvDKMvyDy/ixtTzWDaP2hQ8AE5LIvQpXpCInmNirgrDBNprA/tDM8ekNpYS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586242; c=relaxed/simple;
	bh=KX74UepkMpw5bz1iVQ6k42eEFwgzte8CZclZOBGzCgk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jOp5lUkMEnZtqrvuvJ8nUWQTTUnTzwJZYbVMxkSX/yiwt4Kwch6NVWvbqIsRMQF5YtiL3kH0/oMpLLkkQtOw7MX0vFyfpGHYjf/KeNVqlQBCOqmwiqW5qVryooadOIAQ4mGsXiK+bG0jqflpYW2W2LugCbfZi2BhKX3zATp5V3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aprp1uGp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso6459098a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742586239; x=1743191039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P+LJHYJ4i1KwKCPQagp0c3nRK0DwbrZQ6UBlearO8Y=;
        b=aprp1uGpl4vSH38yvRfv1K5HX8zM8xoXpvLK38p9wiYo/5HnXOMYFRT5XkiSMmfHDp
         Nzq39QU/MA6PTPpy0m0+gtY0II8ZskrOeoFY4SFwk8V8jMYi+EpLTRwdtsdynHU21P5i
         xjxJoogHj01wyuwSfAXVreBIZ9kFfkfbB0QVQ8721qE+M+W/jQrkDrdfzb8pQVDkoisf
         vTdQ7E/PvXjSDs9lBoMSb403VQqmzE11PreoQGITk21I6svUpHKTx/0lv/NpguDcuOkg
         HW4bM5AeI3/gUb2zmpoamOZYyRvvdF6sml7sJNGZHmP6YddRt2rOEq6f1qyi+RIUodJz
         IdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586239; x=1743191039;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P+LJHYJ4i1KwKCPQagp0c3nRK0DwbrZQ6UBlearO8Y=;
        b=WYjswV0w3aHWn+TGQH6rJpq1uwEdwQnTx7jp0d3uuPjLhtFNqP1jDoSKBrVfQ0YYgY
         6MlHVWGV3rxy/TKQkYO0pu1QZ1cl0oOiVSfN1hoNPdNGq5AH2vo3er0QkZDg5s1XIKru
         gvfAKUBwAicLHAGbUiEHD6D6QwvME1wVklMpaJIxXQOtPvE4nGLSLEpBzvakOiRF+ux7
         +G5HzWPk3+XWAAAP7q9wrWYlvoo4z8CKn9iL7KxeJ+2dejam5+AHemLVu8uoiKoNV+Dx
         fZpg2tsBomAeUO7bdYhPSnFDU7hm0+MF7Ay9fgMvmGWQ/GD39JSisb1X5KkvXVu+Gd+n
         lBnw==
X-Forwarded-Encrypted: i=1; AJvYcCUIJtc+MozBNHk9lKYM5XCDqplSbTZV/cSkB0ecjxmN81U08xf33DFQzTsEoDfVxvtY1OP1klRveJfqMog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFIju0GiKSD2kZl64LF6irDc1veXAG70RHMjM0D9qjPKgv6zQ
	nQvPEe1fhKD8nhJ1rKMeDTR7aD/8YRxiNkyWEzhaWG8x917J5mFr+whhykzdhThMXTHj+71nJc1
	60w==
X-Google-Smtp-Source: AGHT+IF+j9rAdwMR5gemRh3P8wCOJuHO2S0smUMdVgrhe0fVugIbWc6qmCLLbRAvSSSjDdbxMGhZl2Ywltg=
X-Received: from pjtd13.prod.google.com ([2002:a17:90b:4d:b0:301:b354:8d63])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d07:b0:2ff:69d4:6fe2
 with SMTP id 98e67ed59e1d1-3030fe9c932mr7741412a91.16.1742586238967; Fri, 21
 Mar 2025 12:43:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 21 Mar 2025 12:42:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321194249.1217961-1-seanjc@google.com>
Subject: [PATCH] iommu/vt-d: Wire up irq_ack() to irq_move_irq() for posted MSIs
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Robert Lippert <rlippert@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wentao Yang <wentaoyang@google.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Set the posted MSI irq_chip's irq_ack() hook to irq_move_irq() instead of
a dummy/empty callback so that posted MSIs process pending changes to the
IRQ's SMP affinity.  Failure to honor a pending set-affinity results in
userspace being unable to change the effective affinity of the IRQ, as
IRQD_SETAFFINITY_PENDING is never cleared and so irq_set_affinity_locked()
always defers moving the IRQ.

The issue is most easily reproducible by setting /proc/irq/xx/smp_affinity
multiple times in quick succession, as only the first update is likely to
be handled in process context.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Cc: Robert Lippert <rlippert@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Wentao Yang <wentaoyang@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/intel/irq_remapping.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index ad795c772f21..333536c5259c 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1278,43 +1278,44 @@ static struct irq_chip intel_ir_chip = {
 };
 
 /*
- * With posted MSIs, all vectors are multiplexed into a single notification
- * vector. Devices MSIs are then dispatched in a demux loop where
- * EOIs can be coalesced as well.
+ * With posted MSIs, the MSI vectors are multiplexed into a single notification
+ * vector, and only the notification vector is sent to the APIC IRR.  Device
+ * MSIs are then dispatched in a demux loop that harvests the MSIs from the
+ * CPU's Posted Interrupt Request bitmap.  I.e. Posted MSIs never get sent to
+ * the APIC IRR, and thus do not need an EOI.  The notification handler instead
+ * performs a single EOI after processing the PIR.
  *
- * "INTEL-IR-POST" IRQ chip does not do EOI on ACK, thus the dummy irq_ack()
- * function. Instead EOI is performed by the posted interrupt notification
- * handler.
+ * Note!  Pending SMP/CPU affinity changes, which are per MSI, must still be
+ * honored, only the APIC EOI is omitted.
  *
  * For the example below, 3 MSIs are coalesced into one CPU notification. Only
- * one apic_eoi() is needed.
+ * one apic_eoi() is needed, but each MSI needs to process pending changes to
+ * its CPU affinity.
  *
  * __sysvec_posted_msi_notification()
  *	irq_enter();
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				dummy(); // No EOI
+ *				irq_move_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *	apic_eoi()
  *	irq_exit()
+ *
  */
-
-static void dummy_ack(struct irq_data *d) { }
-
 static struct irq_chip intel_ir_chip_post_msi = {
 	.name			= "INTEL-IR-POST",
-	.irq_ack		= dummy_ack,
+	.irq_ack		= irq_move_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,

base-commit: d07de43e3f05576fd275c8c82e413d91932119a5
-- 
2.49.0.395.g12beb8f557-goog


