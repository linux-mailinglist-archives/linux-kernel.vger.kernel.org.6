Return-Path: <linux-kernel+bounces-261507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE093B810
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D04282C72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0BA13A265;
	Wed, 24 Jul 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="PvUI3Ya7"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DB7D401
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853210; cv=none; b=Fo2xqjbErvxyGRGvaT3E1MR3xisA+70zZkaUIH9/7w/2TWOd4i3KePwGa1oEOd1dv9gLUZKxjXZ+V53jPUvFXt57hRVRTKXx/2+THyAXzacW+CRg41pg4mnaUrnl3yYXJC2AlafgdW1ybk4wrBJ4g50eI9HZ5+qpO13cLeMQ0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853210; c=relaxed/simple;
	bh=n3yvgvNE6yvo6wDLOEACBdtVxQ3AbV5MCnMlom1ingI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyYUxJ2BZuTC5x1Q2+TSfB+wSY3lOUzO3NYKIXXcM9wHDuKQ5M4UKL4lqD++pqOAL/YspZndKw7UBYWgC+rfppQpgVfL5IIEIYuH95sMyvIVkZAp4dLlMQgzkeDAijRSNdVsB0N6D6SDy/7hwE9IvJOh0QvoiiZgCPkill39bUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=PvUI3Ya7; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d569902626so147821eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721853208; x=1722458008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJxm/byA41k6HHb6hL73ZdxkTNW3paktP68/wTRBIYU=;
        b=PvUI3Ya7aI//sZVPNRxOR2h5OdwKSkmP9BFnIeoYOPma7Oq4mtbKG3aaGPcf937b+h
         ZrYiuyuyfnumwAd+A+DF4suOXjTAnuJwaRs85uUrQ6KoYjqqN8Y+0gE39/o5Z6Es1x41
         yuWOSkSRm6i9CQmzD2yWTyXejNBnFUAXEUB2I1orbvi5hLAMW5vanPFbgAhHdNDsqZ62
         RlwRhvQe8GO6d/vtg7/CvT6anap/89yURjDPqi01EZt2BCdX2d92ksiTKQl65cAED9Fv
         r1GN1fe/8sgV45AYvztHQIMw2kysEFLESrM//j0f9SGEOhvMEJup9WJ94T68SOpPkzuF
         44eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853208; x=1722458008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJxm/byA41k6HHb6hL73ZdxkTNW3paktP68/wTRBIYU=;
        b=jAlaQywTFeDfi+cSKQ0Z73hVfu2pri8K2oH7LZz7QJl0h+W+jxInZhhE8XafhxKtZZ
         T/TOeQvjF34y8M+NgoKQxIEby55TRf47lZKzjcDB8peZLD6iVJHNcCdmys1E0sNCWeni
         Jqp9IMqZ24OftHg43o7Ar4+ZvZ4iB82erWX7Vd0LMMQAY2+V4j+/XmVAZyjC+dKBM7de
         IoZA7GgeNshm2VUfjLnXk7dSzFEsnxM9+DxR97rU2gkr6sOcvTwoSwxSxmCrDxgpMYbN
         JBHAtvdd7ttNkatF1swX17KL2DNCDEHpSt3F9ZihETIz4ifJlLp8Jk1psY6tZYuIFz1H
         f/jA==
X-Forwarded-Encrypted: i=1; AJvYcCUs7CJNTAHxjd+k7DPpd6YVlTb5C6asWAgRvK2Ntt8JjtCLHR6mmW7oZh4oxjMWuVJCK3EjjC+K1806QLaZaPVv5QfkqrdVhQWOTPRr
X-Gm-Message-State: AOJu0YzvvgUj7Iikn2Dp+oijbzQtVlivQZ0vTEVdVvdkgFnx/w5JwN8y
	kRg197np65Tklm8neQJkx9heVp/fATAJIaDKQ56losCgmxB22vxs0O0IzGpRyqE=
X-Google-Smtp-Source: AGHT+IHE52f2bOrGfZsPUD1tpSaklQrRe5ujqaQavwqiUXjGH9LGmhslRRkcpkvz99rconqiOHZ7Tg==
X-Received: by 2002:a05:6358:2484:b0:1aa:bde7:5725 with SMTP id e5c5f4694b2df-1acf8ae554fmr128120855d.28.1721853207710;
        Wed, 24 Jul 2024 13:33:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b1786sm466485a.33.2024.07.24.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 13:33:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	peterz@infradead.org,
	nphamcs@gmail.com,
	cerasuolodomenico@gmail.com,
	surenb@google.com,
	lizhijian@fujitsu.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 2/3] vmstat: Kernel stack usage histogram
Date: Wed, 24 Jul 2024 20:33:21 +0000
Message-ID: <20240724203322.2765486-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the dynamic kernel stack project, we need to know the amount
of data that can be saved by reducing the default kernel stack size [1].

Provide a kernel stack usage histogram to aid in optimizing kernel stack
sizes and minimizing memory waste in large-scale environments. The
histogram divides stack usage into power-of-two buckets and reports the
results in /proc/vmstat. This information is especially valuable in
environments with millions of machines, where even small optimizations
can have a significant impact.

The histogram data is presented in /proc/vmstat with entries like
"kstack_1k", "kstack_2k", and so on, indicating the number of threads
that exited with stack usage falling within each respective bucket.

Example outputs:
Intel:
$ grep kstack /proc/vmstat
kstack_1k 3
kstack_2k 188
kstack_4k 11391
kstack_8k 243
kstack_16k 0

ARM with 64K page_size:
$ grep kstack /proc/vmstat
kstack_1k 1
kstack_2k 340
kstack_4k 25212
kstack_8k 1659
kstack_16k 0
kstack_32k 0
kstack_64k 0

Note: once the dynamic kernel stack is implemented it will depend on the
implementation the usability of this feature: On hardware that supports
faults on kernel stacks, we will have other metrics that show the total
number of pages allocated for stacks. On hardware where faults are not
supported, we will most likely have some optimization where only some
threads are extended, and for those, these metrics will still be very
useful.

[1] https://lwn.net/Articles/974367

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/vm_event_item.h | 24 ++++++++++++++++++++++
 kernel/exit.c                 | 38 +++++++++++++++++++++++++++++++++++
 mm/vmstat.c                   | 24 ++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..37ad1c16367a 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -154,6 +154,30 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		VMA_LOCK_RETRY,
 		VMA_LOCK_MISS,
 #endif
+#ifdef CONFIG_DEBUG_STACK_USAGE
+		KSTACK_1K,
+#if THREAD_SIZE > 1024
+		KSTACK_2K,
+#endif
+#if THREAD_SIZE > 2048
+		KSTACK_4K,
+#endif
+#if THREAD_SIZE > 4096
+		KSTACK_8K,
+#endif
+#if THREAD_SIZE > 8192
+		KSTACK_16K,
+#endif
+#if THREAD_SIZE > 16384
+		KSTACK_32K,
+#endif
+#if THREAD_SIZE > 32768
+		KSTACK_64K,
+#endif
+#if THREAD_SIZE > 65536
+		KSTACK_REST,
+#endif
+#endif /* CONFIG_DEBUG_STACK_USAGE */
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 7430852a8571..64bfc2bae55b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -778,6 +778,43 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 }
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
+/* Count the maximum pages reached in kernel stacks */
+static inline void kstack_histogram(unsigned long used_stack)
+{
+#ifdef CONFIG_VM_EVENT_COUNTERS
+	if (used_stack <= 1024)
+		count_vm_event(KSTACK_1K);
+#if THREAD_SIZE > 1024
+	else if (used_stack <= 2048)
+		count_vm_event(KSTACK_2K);
+#endif
+#if THREAD_SIZE > 2048
+	else if (used_stack <= 4096)
+		count_vm_event(KSTACK_4K);
+#endif
+#if THREAD_SIZE > 4096
+	else if (used_stack <= 8192)
+		count_vm_event(KSTACK_8K);
+#endif
+#if THREAD_SIZE > 8192
+	else if (used_stack <= 16384)
+		count_vm_event(KSTACK_16K);
+#endif
+#if THREAD_SIZE > 16384
+	else if (used_stack <= 32768)
+		count_vm_event(KSTACK_32K);
+#endif
+#if THREAD_SIZE > 32768
+	else if (used_stack <= 65536)
+		count_vm_event(KSTACK_64K);
+#endif
+#if THREAD_SIZE > 65536
+	else
+		count_vm_event(KSTACK_REST);
+#endif
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+}
+
 static void check_stack_usage(void)
 {
 	static DEFINE_SPINLOCK(low_water_lock);
@@ -785,6 +822,7 @@ static void check_stack_usage(void)
 	unsigned long free;
 
 	free = stack_not_used(current);
+	kstack_histogram(THREAD_SIZE - free);
 
 	if (free >= lowest_to_date)
 		return;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 73d791d1caad..6e3347789eb2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1417,6 +1417,30 @@ const char * const vmstat_text[] = {
 	"vma_lock_retry",
 	"vma_lock_miss",
 #endif
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	"kstack_1k",
+#if THREAD_SIZE > 1024
+	"kstack_2k",
+#endif
+#if THREAD_SIZE > 2048
+	"kstack_4k",
+#endif
+#if THREAD_SIZE > 4096
+	"kstack_8k",
+#endif
+#if THREAD_SIZE > 8192
+	"kstack_16k",
+#endif
+#if THREAD_SIZE > 16384
+	"kstack_32k",
+#endif
+#if THREAD_SIZE > 32768
+	"kstack_64k",
+#endif
+#if THREAD_SIZE > 65536
+	"kstack_rest",
+#endif
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.45.2.1089.g2a221341d9-goog


