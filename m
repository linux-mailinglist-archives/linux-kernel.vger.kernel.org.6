Return-Path: <linux-kernel+bounces-354551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B0B993FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1DA1F25613
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D21DF24C;
	Tue,  8 Oct 2024 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cvKhxu3f"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33401DEFD4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368877; cv=none; b=ZH/gH0bxL43qIWH9dRFqj/It2nI2RnihE5DCQdNVr42XH4fROOvigxWDsa7GCufim8A67haoUixZlQI8YSY4NLxrWV7XxYkFAUjwht/4t5fHkl2+Zfh5jkwVef19LE59uAVWrrlvH3gRhLm5M/+E5sQLP1rxIxi+Xd0wnrAh3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368877; c=relaxed/simple;
	bh=QKgyiJIqewQic5HiInbRFgc8h2PvmkN3iSVvXw+RaAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaTAEO48bfxnOuVB3Ewv+DNvUWV3RYOSBYh7Y7HGeMBgQwJhyLbPNfqW9UpdFry0eksuDBvKnJQ4dujCb/CbAM0lr5NE9/EG17MxDY4ak9hWU6gQVgEj+YuMqrWzAlmPbd5sQaX3HKxcMgSQmqEGHojL0rnq/G3C2z0ZWescuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cvKhxu3f; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cnM9d
	dcUZFZ+Luy5237hCVz5GR0zgN46TwtoqrzWf90=; b=cvKhxu3f8DyszcTr0oCyt
	1IN9VCRzuHBulV8EwS8HZM1GAwEJIDiuH8tVq1T8m+s1lslfeWyTvJukHEkB4kwu
	+57JxS3t6yjF9D0kah4p9IEOEKqJ5sYjZKThaJnHgXl2bP060+T93aDCpLCxFPCy
	U2C6AGigK2QpYaiRIDC3fk=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBXT7+g0ARno_BXBg--.55594S4;
	Tue, 08 Oct 2024 14:26:41 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: elver@google.com
Cc: dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	tglx@linutronix.de
Subject: Re: [PATCH 3/4] kcsan, debugfs: fix atomic sleep by converting spinlock_t to rcu lock
Date: Tue,  8 Oct 2024 06:26:39 +0000
Message-Id: <20241008062639.2632455-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZvwDevIahZ5352mO@elver.google.com>
References: <ZvwDevIahZ5352mO@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXT7+g0ARno_BXBg--.55594S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1fWw13GFWkJF17JFWxCrg_yoWfJr1fpa
	43Ww1DtFyqvFy7Cr1DAry5Wr1rK34DXr17Za42kry7CFs0qrs5uw4S9r90g398ur1xAr4k
	XF4vqrn7Aws8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbjjDUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqR1yTGcEzZ9LIAAAsQ

>> -	spin_lock_irqsave(&report_filterlist_lock, flags);
>> -	if (report_filterlist.used == 0)
>> +	rcu_read_lock();
>> +	list = rcu_dereference(rp_flist);
>> +
>> +	if (!list)
>> +		goto out;
>> +
>> +	if (list->used == 0)
>>  		goto out;
>>  
>>  	/* Sort array if it is unsorted, and then do a binary search. */
>> -	if (!report_filterlist.sorted) {
>> -		sort(report_filterlist.addrs, report_filterlist.used,
>> +	if (!list->sorted) {
>> +		sort(list->addrs, list->used,
>>  		     sizeof(unsigned long), cmp_filterlist_addrs, NULL);
>> -		report_filterlist.sorted = true;
>> +		list->sorted = true;
>>  	}
>
>This used to be under the report_filterlist_lock, but now there's no
>protection against this happening concurrently.
>
>Sure, at the moment, this is not a problem, because this function is
>only called under the report_lock which serializes it. Is that intended?
>
>> -	ret = !!bsearch(&func_addr, report_filterlist.addrs,
>> -			report_filterlist.used, sizeof(unsigned long),
>> +	ret = !!bsearch(&func_addr, list->addrs,
>> +			list->used, sizeof(unsigned long),
>>  			cmp_filterlist_addrs);
>> -	if (report_filterlist.whitelist)
>> +	if (list->whitelist)
>>  		ret = !ret;
>[...]
>> +
>> +	memcpy(new_list, old_list, sizeof(struct report_filterlist));
>> +	new_list->whitelist = whitelist;
>> +
>> +	rcu_assign_pointer(rp_flist, new_list);
>> +	synchronize_rcu();
>> +	kfree(old_list);
>
>Why not kfree_rcu()?
>
>> +out:
>> +	mutex_unlock(&rp_flist_mutex);
>> +	return ret;
>>  }
>[...]
>> +	} else {
>> +		new_addrs = kmalloc_array(new_list->size,
>> +					  sizeof(unsigned long), GFP_KERNEL);
>> +		if (new_addrs == NULL)
>> +			goto out_free;
>> +
>> +		memcpy(new_addrs, old_list->addrs,
>> +				old_list->size * sizeof(unsigned long));
>> +		new_list->addrs = new_addrs;
>>  	}
>
>Wait, for every insertion it ends up copying the list now? That's very
>wasteful.
>
>In general, this solution seems overly complex, esp. the part where it
>ends up copying the whole list on _every_ insertion.
>
>If the whole point is to avoid kmalloc() under the lock, we can do
>something much simpler.
>
>Please test the patch below - it's much simpler, and in the common case
>I expect it to rarely throw away the preemptive allocation done outside
>the critical section because concurrent insertions by the user should be
>rarely done.

I have tested this, it works.
Yes, this patch is much simpler. 
Another consideration for me to convert the spinlock to a RCU lock was that
this would reduce the irq-latency when kcsan_skip_report_debugfs() called from
hard-irq context, but as you said, insertions by the user should not be a frequent 
operation, this should not be a problem. 

>Thanks,
>-- Marco
>
>------ >8 ------
>
>From: Marco Elver <elver@google.com>
>Date: Tue, 1 Oct 2024 16:00:45 +0200
>Subject: [PATCH] kcsan: turn report_filterlist_lock into a raw_spinlock
>
><tbd... please test>
>
>Reported-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>Signed-off-by: Marco Elver <elver@google.com>
>---
> kernel/kcsan/debugfs.c | 76 +++++++++++++++++++++---------------------
> 1 file changed, 38 insertions(+), 38 deletions(-)
>
>diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
>index 1d1d1b0e4248..5ffb6cc5298b 100644
>--- a/kernel/kcsan/debugfs.c
>+++ b/kernel/kcsan/debugfs.c
>@@ -46,14 +46,8 @@ static struct {
> 	int		used;		/* number of elements used */
> 	bool		sorted;		/* if elements are sorted */
> 	bool		whitelist;	/* if list is a blacklist or whitelist */
>-} report_filterlist = {
>-	.addrs		= NULL,
>-	.size		= 8,		/* small initial size */
>-	.used		= 0,
>-	.sorted		= false,
>-	.whitelist	= false,	/* default is blacklist */
>-};
>-static DEFINE_SPINLOCK(report_filterlist_lock);
>+} report_filterlist;
>+static DEFINE_RAW_SPINLOCK(report_filterlist_lock);
> 
> /*
>  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
>@@ -110,7 +104,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
> 		return false;
> 	func_addr -= offset; /* Get function start */
> 
>-	spin_lock_irqsave(&report_filterlist_lock, flags);
>+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
> 	if (report_filterlist.used == 0)
> 		goto out;
> 
>@@ -127,7 +121,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
> 		ret = !ret;
> 
> out:
>-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
>+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
> 	return ret;
> }
> 
>@@ -135,9 +129,9 @@ static void set_report_filterlist_whitelist(bool whitelist)
> {
> 	unsigned long flags;
> 
>-	spin_lock_irqsave(&report_filterlist_lock, flags);
>+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
> 	report_filterlist.whitelist = whitelist;
>-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
>+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
> }
> 
> /* Returns 0 on success, error-code otherwise. */
>@@ -145,6 +139,9 @@ static ssize_t insert_report_filterlist(const char *func)
> {
> 	unsigned long flags;
> 	unsigned long addr = kallsyms_lookup_name(func);
>+	unsigned long *delay_free = NULL;
>+	unsigned long *new_addrs = NULL;
>+	size_t new_size = 0;
> 	ssize_t ret = 0;
> 
> 	if (!addr) {
>@@ -152,32 +149,33 @@ static ssize_t insert_report_filterlist(const char *func)
> 		return -ENOENT;
> 	}
> 
>-	spin_lock_irqsave(&report_filterlist_lock, flags);
>+retry_alloc:
>+	/*
>+	 * Check if we need an allocation, and re-validate under the lock. Since
>+	 * the report_filterlist_lock is a raw, cannot allocate under the lock.
>+	 */
>+	if (data_race(report_filterlist.used == report_filterlist.size)) {
>+		new_size = (report_filterlist.size ?: 4) * 2;
>+		delay_free = new_addrs = kmalloc_array(new_size, sizeof(unsigned long), GFP_KERNEL);
>+		if (!new_addrs)
>+			return -ENOMEM;
>+	}
> 
>-	if (report_filterlist.addrs == NULL) {
>-		/* initial allocation */
>-		report_filterlist.addrs =
>-			kmalloc_array(report_filterlist.size,
>-				      sizeof(unsigned long), GFP_ATOMIC);
>-		if (report_filterlist.addrs == NULL) {
>-			ret = -ENOMEM;
>-			goto out;
>-		}
>-	} else if (report_filterlist.used == report_filterlist.size) {
>-		/* resize filterlist */
>-		size_t new_size = report_filterlist.size * 2;
>-		unsigned long *new_addrs =
>-			krealloc(report_filterlist.addrs,
>-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
>-
>-		if (new_addrs == NULL) {
>-			/* leave filterlist itself untouched */
>-			ret = -ENOMEM;
>-			goto out;
>+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
>+	if (report_filterlist.used == report_filterlist.size) {
>+		/* Check we pre-allocated enough, and retry if not. */
>+		if (report_filterlist.used >= new_size) {
>+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
>+			kfree(new_addrs); /* kfree(NULL) is safe */
>+			delay_free = new_addrs = NULL;
>+			goto retry_alloc;
> 		}
> 
>+		if (report_filterlist.used)
>+			memcpy(new_addrs, report_filterlist.addrs, report_filterlist.used * sizeof(unsigned long));
>+		delay_free = report_filterlist.addrs; /* free the old list */
>+		report_filterlist.addrs = new_addrs;  /* switch to the new list */
> 		report_filterlist.size = new_size;
>-		report_filterlist.addrs = new_addrs;
> 	}
> 
> 	/* Note: deduplicating should be done in userspace. */
>@@ -185,8 +183,10 @@ static ssize_t insert_report_filterlist(const char *func)
> 		kallsyms_lookup_name(func);
> 	report_filterlist.sorted = false;
> 
>-out:
>-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
>+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
>+
>+	if (delay_free)
>+		kfree(delay_free);
> 
> 	return ret;
> }
>@@ -204,13 +204,13 @@ static int show_info(struct seq_file *file, void *v)
> 	}
> 
> 	/* show filter functions, and filter type */
>-	spin_lock_irqsave(&report_filterlist_lock, flags);
>+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
> 	seq_printf(file, "\n%s functions: %s\n",
> 		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
> 		   report_filterlist.used == 0 ? "none" : "");
> 	for (i = 0; i < report_filterlist.used; ++i)
> 		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
>-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
>+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
> 
> 	return 0;
> }
>-- 
>2.46.1.824.gd892dcdcdd-goog
>


