Return-Path: <linux-kernel+bounces-293149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95420957B54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E89CB22FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46E22EF2;
	Tue, 20 Aug 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ShD10Ec+"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641E18EA8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119785; cv=none; b=UGtR3q0+HPMqVUGPVyZqS6GobMwtYAYJWi8DhbR+RaZlfWRGMSnjnSSVd4cKdCDA5uQDz+OjbaMHHNK4ToiPl/sF+vDjE9ofNFZlHZtBqhrUUtjPyGIfs9z805MYkD3TeegTZI7w56YVsVeNyXRP+IslWZugDuQx0hiIP2z3i5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119785; c=relaxed/simple;
	bh=/EjAw6SIVbjoOM3Noy5NGS9+qSm2/geVxGsqc0klNT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n//E8wEGnFpCYPhcOLB3buUD4HNbHkgLOGeE6CP+oEkDPIDUpZBC0U+ya3NqOcVdOCHhfGyDycsig6jaPZ3nEnu1AitaeG+7/V0bUf6ug6Zzaq5FsUZ+85pndCoQriAzO3Oh2MHjpn+uJLayQqT8Mjr+FEKJP11925t5Eq9Cjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ShD10Ec+; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724119779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lvCHbg1JhDMdtUgSS3TvV3oBKMTLNMrmVInLTh4dCkg=;
	b=ShD10Ec+yUTBClaSyIVHIBERwSk2xQPy+ud7CticAcRNylf2MaVsDtp0sRN8+vVMIU3nN7
	gHJ5Keqr8KCGDAbHqpz+iZEUnTmQKMrL/1KJJ4zJQqU5vzFUvNO7RbilCIzeNKnMaV1qAk
	LoxZsDojeUr4Cy8RN4jsdYNOMaSQm6g=
From: Jeff Xie <jeff.xie@linux.dev>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [PATCH] genirq: procfs: Make smp_affinity read-only for interrupts marked with IRQD_AFFINITY_MANAGED flag
Date: Tue, 20 Aug 2024 10:09:04 +0800
Message-Id: <20240820020904.2514189-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, due to the interrupt subsystem introduced this commit 9c2555835bb3
("genirq: Introduce IRQD_AFFINITY_MANAGED flag"), an error is reported when a
system administrator modifies the smp_affinity for the virtio_blk driver.
For example:

jeff-labs:/proc/irq/26 # echo 2 > ./smp_affinity
-bash: echo: write error: Input/output error

However, checking the permissions of smp_affinity/smp_affinity_list shows that
they are set to rw. System administrators are strongly complaining about this issue.

jeff-labs:/proc/irq/26 # ls -l
total 0
-r--r--r-- 1 root root 0 Aug 20 01:32 affinity_hint
-r--r--r-- 1 root root 0 Aug 20 01:32 effective_affinity
-r--r--r-- 1 root root 0 Aug 20 01:32 effective_affinity_list
-r--r--r-- 1 root root 0 Aug 20 01:32 node
-rw-r--r-- 1 root root 0 Aug 20 01:32 smp_affinity
-rw-r--r-- 1 root root 0 Aug 20 01:32 smp_affinity_list
-r--r--r-- 1 root root 0 Aug 20 01:32 spurious
dr-xr-xr-x 2 root root 0 Aug 20 01:32 virtio3-req.0

Therefore, the permissions of smp_affinity/smp_affinity_list should be changed to read-only.

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
 kernel/irq/proc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 8cccdf40725a..4a7d572b7a8c 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -363,7 +363,11 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 
 #ifdef CONFIG_SMP
 	/* create /proc/irq/<irq>/smp_affinity */
-	proc_create_data("smp_affinity", 0644, desc->dir,
+	if (unlikely(irqd_affinity_is_managed(&desc->irq_data)))
+		proc_create_data("smp_affinity", 0444, desc->dir,
+			 &irq_affinity_proc_ops, irqp);
+	else
+		proc_create_data("smp_affinity", 0644, desc->dir,
 			 &irq_affinity_proc_ops, irqp);
 
 	/* create /proc/irq/<irq>/affinity_hint */
@@ -371,7 +375,11 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 			irq_affinity_hint_proc_show, irqp);
 
 	/* create /proc/irq/<irq>/smp_affinity_list */
-	proc_create_data("smp_affinity_list", 0644, desc->dir,
+	if (unlikely(irqd_affinity_is_managed(&desc->irq_data)))
+		proc_create_data("smp_affinity_list", 0444, desc->dir,
+			 &irq_affinity_list_proc_ops, irqp);
+	else
+		proc_create_data("smp_affinity_list", 0644, desc->dir,
 			 &irq_affinity_list_proc_ops, irqp);
 
 	proc_create_single_data("node", 0444, desc->dir, irq_node_proc_show,
--
2.34.1


