Return-Path: <linux-kernel+bounces-276393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D80C9492EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04271C20864
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4418D657;
	Tue,  6 Aug 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz+kIJ6l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8418D64B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954435; cv=none; b=JhnQyuViL9Wc1blD/WRl6+IOnOuQGGs1wCl8PU9tW7TGOgmaBIHwgi7tNvsE5g2tTQtBvxuaurbZ6EXMsmFB2uqVfbh7G6pfHP45y+nWnbgIppJUGZhMYM9GJ5jw8xTZ0nbyTtudoyjlSoJZqkTPU7U5m6LwjwmfiJNLxnxPjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954435; c=relaxed/simple;
	bh=LzqDLxjUaammJqNbpSby8VmEGGC9p09wSXLpGOuQ93U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kq1nd33ulZzcvIDa0AOQiahBsCQPqi1KtqgpctQzCvbsXw2Sopt8H/HB+rLOwrqnAWbK97XPLCg53H7blUbpXphw7WMGrwIZmFq3hoSHTLJnd6T1lHGSF9Zfm+fnIMrNLkRLcOoM8Fx/nTkK6jT+G9N0utVrEx4kkkDFj0E4BPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fz+kIJ6l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722954433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sxdMlZiVCpeBnxBeJX0VnaiMFDVq/jpkKoST9+suM0w=;
	b=Fz+kIJ6lspKzVEU4lY58re3C5ZyyJXCGVysOtwAQWZFWCa7d9YcxvMr5iHw7Nad8mKrJGl
	Nu1yYCLTRP9Bui0Mq4mrxRgGNQtbDSr8gxiezhb/ICWRLCr9GVI57XO1p2ww7+VeADL312
	xKgACoG1EockJL+QA53IiIp72i+dKIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-Pk9Zjrk5Oo-QKSrVolVvew-1; Tue,
 06 Aug 2024 10:27:06 -0400
X-MC-Unique: Pk9Zjrk5Oo-QKSrVolVvew-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 329BF191E7F6;
	Tue,  6 Aug 2024 14:27:04 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.146])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41C0B195605A;
	Tue,  6 Aug 2024 14:26:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Len Brown <len.brown@intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/memory-failure: Use raw_spinlock_t in struct memory_failure_cpu
Date: Tue,  6 Aug 2024 10:25:35 -0400
Message-ID: <20240806142535.1033323-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The memory_failure_cpu structure is a per-cpu structure. Access to its
content requires the use of get_cpu_var() to lock in the current CPU
and disable preemption. The use of a regular spinlock_t for locking
purpose is fine for a non-RT kernel.

Since the integration of RT spinlock support into the v5.15 kernel,
a spinlock_t in a RT kernel becomes a sleeping lock and taking a
sleeping lock in a preemption disabled context is illegal resulting in
the following kind of warning.

  [12135.732244] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  [12135.732248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 270076, name: kworker/0:0
  [12135.732252] preempt_count: 1, expected: 0
  [12135.732255] RCU nest depth: 2, expected: 2
    :
  [12135.732420] Hardware name: Dell Inc. PowerEdge R640/0HG0J8, BIOS 2.10.2 02/24/2021
  [12135.732423] Workqueue: kacpi_notify acpi_os_execute_deferred
  [12135.732433] Call Trace:
  [12135.732436]  <TASK>
  [12135.732450]  dump_stack_lvl+0x57/0x81
  [12135.732461]  __might_resched.cold+0xf4/0x12f
  [12135.732479]  rt_spin_lock+0x4c/0x100
  [12135.732491]  memory_failure_queue+0x40/0xe0
  [12135.732503]  ghes_do_memory_failure+0x53/0x390
  [12135.732516]  ghes_do_proc.constprop.0+0x229/0x3e0
  [12135.732575]  ghes_proc+0xf9/0x1a0
  [12135.732591]  ghes_notify_hed+0x6a/0x150
  [12135.732602]  notifier_call_chain+0x43/0xb0
  [12135.732626]  blocking_notifier_call_chain+0x43/0x60
  [12135.732637]  acpi_ev_notify_dispatch+0x47/0x70
  [12135.732648]  acpi_os_execute_deferred+0x13/0x20
  [12135.732654]  process_one_work+0x41f/0x500
  [12135.732695]  worker_thread+0x192/0x360
  [12135.732715]  kthread+0x111/0x140
  [12135.732733]  ret_from_fork+0x29/0x50
  [12135.732779]  </TASK>

Fix it by using a raw_spinlock_t for locking instead.

Fixes: ea8f5fb8a71f ("HWPoison: add memory_failure_queue()")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memory-failure.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 581d3e5c9117..d40377b3edc8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2417,7 +2417,7 @@ struct memory_failure_entry {
 struct memory_failure_cpu {
 	DECLARE_KFIFO(fifo, struct memory_failure_entry,
 		      MEMORY_FAILURE_FIFO_SIZE);
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct work_struct work;
 };
 
@@ -2449,13 +2449,13 @@ void memory_failure_queue(unsigned long pfn, int flags)
 	};
 
 	mf_cpu = &get_cpu_var(memory_failure_cpu);
-	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
+	raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 	if (kfifo_put(&mf_cpu->fifo, entry))
 		schedule_work_on(smp_processor_id(), &mf_cpu->work);
 	else
 		pr_err("buffer overflow when queuing memory failure at %#lx\n",
 		       pfn);
-	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
+	raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
 	put_cpu_var(memory_failure_cpu);
 }
 EXPORT_SYMBOL_GPL(memory_failure_queue);
@@ -2469,9 +2469,9 @@ static void memory_failure_work_func(struct work_struct *work)
 
 	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
-		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
+		raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 		gotten = kfifo_get(&mf_cpu->fifo, &entry);
-		spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
+		raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
@@ -2501,7 +2501,7 @@ static int __init memory_failure_init(void)
 
 	for_each_possible_cpu(cpu) {
 		mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-		spin_lock_init(&mf_cpu->lock);
+		raw_spin_lock_init(&mf_cpu->lock);
 		INIT_KFIFO(mf_cpu->fifo);
 		INIT_WORK(&mf_cpu->work, memory_failure_work_func);
 	}
-- 
2.43.5


