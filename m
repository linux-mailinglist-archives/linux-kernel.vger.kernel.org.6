Return-Path: <linux-kernel+bounces-300429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257095E394
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AEE1F213BA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFBD14E2E2;
	Sun, 25 Aug 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GExvJF4K"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E722837B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724591996; cv=none; b=nATSGET1/QlmYiZm6LoNU7gfbzBvVd1/9FFLOmlXs3MqjmRYhu4xUVIqAciQg8tUAlRSvSY2Hmc5BuvUImomldtin+srPXAREkPoN7oxT43n93+uUAAGSZcDlX0+6RQvUSr3fWn/mVzZKnTDr/ElOUP6HuSvBzYttHzQ2pnIXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724591996; c=relaxed/simple;
	bh=xFrJ8f2AgDg8Flf+mGJJ3kUYdoE2vS4mM0zUgZdJTN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CtqdLffYEdSaA1/W4rsCg+T0KO/6KIdldZn/YdLTW0ry5BsI2K/L6TX6+i7BXPH143cpZWzIO3iOpFADZH0Exr5se1JxFNmTC0YcICdwkqyXviZYuOul9tpq86uumt3W72bnMvGYNRK+q2oi3KN9HhhGnAJZ1hSRe7KP86CNDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GExvJF4K; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724591992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eo7LJ2mrKNYIwpjSOrM1O0gpj6MgZAZTZUBa9pFYK6I=;
	b=GExvJF4KLi3GOUsCy0nGkm7VPWc5gvl9O/fbJzZHty/+j7IJQo2FY9Xig44/5XFA2CJrzV
	PqNIww/MwXhsuKKpkFoPLBYPQXEVm4dJd1WmloULukeFxbb7JBVKOZ9b94vHLw4e+pL2VX
	U7RpcRKC0USaS2eph0Mda9jgK6O5dGA=
From: Jeff Xie <jeff.xie@linux.dev>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [PATCH v2] genirq: procfs: Make smp_affinity read-only for interrupts that userspace can't set
Date: Sun, 25 Aug 2024 21:19:11 +0800
Message-Id: <20240825131911.107119-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kernel already knows at the time of interrupt allocation that the
affinity cannot be controlled by userspace and therefore creating the
file with write permissions is wrong.

Therefore set the file permissions to read-only for such interrupts.

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
v2:
- Updated the description suggested by tglx
- Corrected the return value from -EIO to -EPERM when the userspace can't set the affinity

 kernel/irq/proc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 8cccdf40725a..7b3a4c92d148 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -142,7 +142,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	int err;
 
 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
-		return -EIO;
+		return -EPERM;
 
 	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
@@ -340,6 +340,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	static DEFINE_MUTEX(register_lock);
 	void __maybe_unused *irqp = (void *)(unsigned long) irq;
 	char name [MAX_NAMELEN];
+	umode_t umode = S_IRUGO;
 
 	if (!root_irq_dir || (desc->irq_data.chip == &no_irq_chip))
 		return;
@@ -362,8 +363,11 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 		goto out_unlock;
 
 #ifdef CONFIG_SMP
+	if (irq_can_set_affinity_usr(desc->irq_data.irq))
+		umode |= S_IWUSR;
+
 	/* create /proc/irq/<irq>/smp_affinity */
-	proc_create_data("smp_affinity", 0644, desc->dir,
+	proc_create_data("smp_affinity", umode, desc->dir,
 			 &irq_affinity_proc_ops, irqp);
 
 	/* create /proc/irq/<irq>/affinity_hint */
@@ -371,7 +375,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 			irq_affinity_hint_proc_show, irqp);
 
 	/* create /proc/irq/<irq>/smp_affinity_list */
-	proc_create_data("smp_affinity_list", 0644, desc->dir,
+	proc_create_data("smp_affinity_list", umode, desc->dir,
 			 &irq_affinity_list_proc_ops, irqp);
 
 	proc_create_single_data("node", 0444, desc->dir, irq_node_proc_show,
-- 
2.34.1


