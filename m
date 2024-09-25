Return-Path: <linux-kernel+bounces-339254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9D89861B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0988E1F2BA10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD118C35F;
	Wed, 25 Sep 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xvg06XpT"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4E18C03A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274772; cv=none; b=VGBdAD790RPh+T1rGyErkJl8ouCWrQiiKeVlbnHji04p0cY48zrY0WGGCdTtab7NQOGKiGrsLPJ2hs9RNUcCmILXZEV40m9loFwmhIh4MyA2udjdhFBQIiCdoAXeI70Q6+TwmQp2v8TsLoHUMsFXxbF4/IXzQ7Ot5+Be2rP9Q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274772; c=relaxed/simple;
	bh=n8G6T9wvgcsl8VEFxdJH18/2+XQ+qv5+GtnoNTndtzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXlv0oyTwAGTZrg7PuQbZCkjUAjyVWZaXMYQPj2F2dusPRP9dCKL4/QefHuOXYB0LoHcrbsRqdlj19Au8YmW9ei1kW8gOXMiLLsey9wPm++2xP2m7DpKFoqCynMuUsgW5NitC0pfRyI/12ol3UZ4VdHldMqmknYMW2z6BiuwKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xvg06XpT; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mYkOl
	I9eBCHTW7gwRCNpI3K7Zu6p8Om5DdoWMDU+W/c=; b=Xvg06XpT1iOLWn86vFQmE
	qOaYBXStglOh50p7IcaSoINAmidKzUAVTklO4EyDnvbMPJwA12+hPGLC2odK0kb9
	RG+U6AOz+SOtzawJw9A+ZOS+5NS0vbQ3Ots7gnl1chMNfqug3BhXtCtjPAqOvIQc
	gkIwfqFk+dNQeYfslPKvVQ=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn9EXeHvRmGMqpJA--.33673S7;
	Wed, 25 Sep 2024 22:32:11 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: elver@google.com,
	tglx@linutronix.de,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH 3/4] kcsan, debugfs: fix atomic sleep by converting spinlock_t to rcu lock
Date: Wed, 25 Sep 2024 14:31:53 +0000
Message-Id: <20240925143154.2322926-4-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925143154.2322926-1-ranxiaokai627@163.com>
References: <20240925143154.2322926-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9EXeHvRmGMqpJA--.33673S7
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cry5Cry3AFW5XrykJFW8WFg_yoWDCw1kpF
	W3K3s8tryktF17Cr47ArZ8Wr1rKwn8XF17uasxCr9ruF4qqr4S9a1SvryYg395urWxAF9r
	WF4vqr1DAr4DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlCJQUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRhlTGb0HXEZ0QABsv

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

In a preempt-RT kernel, most of the irq handlers have been
converted to the threaded mode except those which have the
IRQF_NO_THREAD flag set. The hrtimer IRQ is such an example.
So kcsan report could be triggered from a HARD-irq context, this will
trigger the "sleeping function called from invalid context" bug.

[    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[    C1] preempt_count: 10002, expected: 0
[    C1] RCU nest depth: 0, expected: 0
[    C1] no locks held by swapper/1/0.
[    C1] irq event stamp: 156674
[    C1] hardirqs last  enabled at (156673): [<ffffffff81130bd9>] do_idle+0x1f9/0x240
[    C1] hardirqs last disabled at (156674): [<ffffffff82254f84>] sysvec_apic_timer_interrupt+0x14/0xc0
[    C1] softirqs last  enabled at (0): [<ffffffff81099f47>] copy_process+0xfc7/0x4b60
[    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    C1] Preemption disabled at:
[    C1] [<ffffffff814a3e2a>] paint_ptr+0x2a/0x90
[    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0+ #3
[    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[    C1] Call Trace:
[    C1]  <IRQ>
[    C1]  dump_stack_lvl+0x7e/0xc0
[    C1]  dump_stack+0x1d/0x30
[    C1]  __might_resched+0x1a2/0x270
[    C1]  rt_spin_lock+0x68/0x170
[    C1]  ? kcsan_skip_report_debugfs+0x43/0xe0
[    C1]  kcsan_skip_report_debugfs+0x43/0xe0
[    C1]  ? hrtimer_next_event_without+0x110/0x110
[    C1]  print_report+0xb5/0x590
[    C1]  kcsan_report_known_origin+0x1b1/0x1d0
[    C1]  kcsan_setup_watchpoint+0x348/0x650
[    C1]  __tsan_unaligned_write1+0x16d/0x1d0
[    C1]  hrtimer_interrupt+0x3d6/0x430
[    C1]  __sysvec_apic_timer_interrupt+0xe8/0x3a0
[    C1]  sysvec_apic_timer_interrupt+0x97/0xc0
[    C1]  </IRQ>

To fix this, we can not simply convert the report_filterlist_lock
to a raw_spinlock_t. In the insert_report_filterlist() path:

raw_spin_lock_irqsave(&report_filterlist_lock, flags);
  krealloc
    __do_kmalloc_node
      slab_alloc_node
        __slab_alloc
          local_lock_irqsave(&s->cpu_slab->lock, flags)

local_lock_t is now a spinlock_t which is sleepable in preempt-RT
kernel, so kmalloc() and similar functions can not be called with
a raw_spinlock_t lock held.

Instead, we can convert it to rcu lock to fix this.
Aso introduce a mutex to serialize user-space write operations.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/kcsan/debugfs.c | 172 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 113 insertions(+), 59 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 30547507f497..d5e624c37125 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -40,20 +40,17 @@ static_assert(ARRAY_SIZE(counter_names) == KCSAN_COUNTER_COUNT);
  * Addresses for filtering functions from reporting. This list can be used as a
  * whitelist or blacklist.
  */
-static struct {
+struct report_filterlist {
 	unsigned long	*addrs;		/* array of addresses */
 	size_t		size;		/* current size */
 	int		used;		/* number of elements used */
 	bool		sorted;		/* if elements are sorted */
 	bool		whitelist;	/* if list is a blacklist or whitelist */
-} report_filterlist = {
-	.addrs		= NULL,
-	.size		= 8,		/* small initial size */
-	.used		= 0,
-	.sorted		= false,
-	.whitelist	= false,	/* default is blacklist */
+	struct rcu_head rcu;
 };
-static DEFINE_SPINLOCK(report_filterlist_lock);
+
+static DEFINE_MUTEX(rp_flist_mutex);
+static struct report_filterlist __rcu *rp_flist;
 
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
@@ -103,98 +100,141 @@ static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
 bool kcsan_skip_report_debugfs(unsigned long func_addr)
 {
 	unsigned long symbolsize, offset;
-	unsigned long flags;
 	bool ret = false;
+	struct report_filterlist *list;
 
 	if (!kallsyms_lookup_size_offset(func_addr, &symbolsize, &offset))
 		return false;
 	func_addr -= offset; /* Get function start */
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
-	if (report_filterlist.used == 0)
+	rcu_read_lock();
+	list = rcu_dereference(rp_flist);
+
+	if (!list)
+		goto out;
+
+	if (list->used == 0)
 		goto out;
 
 	/* Sort array if it is unsorted, and then do a binary search. */
-	if (!report_filterlist.sorted) {
-		sort(report_filterlist.addrs, report_filterlist.used,
+	if (!list->sorted) {
+		sort(list->addrs, list->used,
 		     sizeof(unsigned long), cmp_filterlist_addrs, NULL);
-		report_filterlist.sorted = true;
+		list->sorted = true;
 	}
-	ret = !!bsearch(&func_addr, report_filterlist.addrs,
-			report_filterlist.used, sizeof(unsigned long),
+	ret = !!bsearch(&func_addr, list->addrs,
+			list->used, sizeof(unsigned long),
 			cmp_filterlist_addrs);
-	if (report_filterlist.whitelist)
+	if (list->whitelist)
 		ret = !ret;
 
 out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	rcu_read_unlock();
 	return ret;
 }
 
 static ssize_t set_report_filterlist_whitelist(bool whitelist)
 {
-	unsigned long flags;
+	struct report_filterlist *new_list, *old_list;
+	ssize_t ret = 0;
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
-	report_filterlist.whitelist = whitelist;
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
-	return 0;
+	mutex_lock(&rp_flist_mutex);
+	old_list = rcu_dereference_protected(rp_flist,
+					   lockdep_is_held(&rp_flist_mutex));
+
+	new_list = kzalloc(sizeof(*new_list), GFP_KERNEL);
+	if (!new_list) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(new_list, old_list, sizeof(struct report_filterlist));
+	new_list->whitelist = whitelist;
+
+	rcu_assign_pointer(rp_flist, new_list);
+	synchronize_rcu();
+	kfree(old_list);
+
+out:
+	mutex_unlock(&rp_flist_mutex);
+	return ret;
 }
 
 /* Returns 0 on success, error-code otherwise. */
 static ssize_t insert_report_filterlist(const char *func)
 {
-	unsigned long flags;
 	unsigned long addr = kallsyms_lookup_name(func);
 	ssize_t ret = 0;
+	struct report_filterlist *new_list, *old_list;
+	unsigned long *new_addrs;
 
 	if (!addr) {
 		pr_err("could not find function: '%s'\n", func);
 		return -ENOENT;
 	}
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	new_list = kzalloc(sizeof(*new_list), GFP_KERNEL);
+	if (!new_list)
+		return -ENOMEM;
+
+	mutex_lock(&rp_flist_mutex);
+	old_list = rcu_dereference_protected(rp_flist,
+					   lockdep_is_held(&rp_flist_mutex));
+	memcpy(new_list, old_list, sizeof(struct report_filterlist));
 
-	if (report_filterlist.addrs == NULL) {
+	if (new_list->addrs == NULL) {
 		/* initial allocation */
-		report_filterlist.addrs =
-			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_ATOMIC);
-		if (report_filterlist.addrs == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-	} else if (report_filterlist.used == report_filterlist.size) {
+		new_list->addrs =
+			kmalloc_array(new_list->size,
+					  sizeof(unsigned long), GFP_KERNEL);
+		if (new_list->addrs == NULL)
+			goto out_free;
+	} else if (new_list->used == new_list->size) {
 		/* resize filterlist */
-		size_t new_size = report_filterlist.size * 2;
-		unsigned long *new_addrs =
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
-
-		if (new_addrs == NULL) {
-			/* leave filterlist itself untouched */
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		report_filterlist.size = new_size;
-		report_filterlist.addrs = new_addrs;
+		size_t new_size = new_list->size * 2;
+
+		new_addrs = kmalloc_array(new_size,
+					  sizeof(unsigned long), GFP_KERNEL);
+		if (new_addrs == NULL)
+			goto out_free;
+
+		memcpy(new_addrs, old_list->addrs,
+				old_list->size * sizeof(unsigned long));
+		new_list->size = new_size;
+		new_list->addrs = new_addrs;
+	} else {
+		new_addrs = kmalloc_array(new_list->size,
+					  sizeof(unsigned long), GFP_KERNEL);
+		if (new_addrs == NULL)
+			goto out_free;
+
+		memcpy(new_addrs, old_list->addrs,
+				old_list->size * sizeof(unsigned long));
+		new_list->addrs = new_addrs;
 	}
 
 	/* Note: deduplicating should be done in userspace. */
-	report_filterlist.addrs[report_filterlist.used++] = addr;
-	report_filterlist.sorted = false;
-
+	new_list->addrs[new_list->used++] = addr;
+	new_list->sorted = false;
+
+	rcu_assign_pointer(rp_flist, new_list);
+	synchronize_rcu();
+	kfree(old_list->addrs);
+	kfree(old_list);
+	goto out;
+
+out_free:
+	ret = -ENOMEM;
+	kfree(new_list);
 out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
-
+	mutex_unlock(&rp_flist_mutex);
 	return ret;
 }
 
 static int show_info(struct seq_file *file, void *v)
 {
 	int i;
-	unsigned long flags;
+	struct report_filterlist *list;
 
 	/* show stats */
 	seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
@@ -203,14 +243,15 @@ static int show_info(struct seq_file *file, void *v)
 			   atomic_long_read(&kcsan_counters[i]));
 	}
 
+	rcu_read_lock();
+	list = rcu_dereference(rp_flist);
 	/* show filter functions, and filter type */
-	spin_lock_irqsave(&report_filterlist_lock, flags);
 	seq_printf(file, "\n%s functions: %s\n",
-		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
-		   report_filterlist.used == 0 ? "none" : "");
-	for (i = 0; i < report_filterlist.used; ++i)
-		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+		   list->whitelist ? "whitelisted" : "blacklisted",
+		   list->used == 0 ? "none" : "");
+	for (i = 0; i < list->used; ++i)
+		seq_printf(file, " %ps\n", (void *)list->addrs[i]);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -269,6 +310,19 @@ static const struct file_operations debugfs_ops =
 
 static int __init kcsan_debugfs_init(void)
 {
+	struct report_filterlist *list;
+
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	if (!list)
+		return -ENOMEM;
+
+	list->addrs		= NULL;
+	list->size		= 8;		/* small initial size */
+	list->used		= 0;
+	list->sorted	= false;
+	list->whitelist	= false;	/* default is blacklist */
+	rcu_assign_pointer(rp_flist, list);
+
 	debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
 	return 0;
 }
-- 
2.15.2



