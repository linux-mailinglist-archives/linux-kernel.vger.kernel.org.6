Return-Path: <linux-kernel+bounces-267749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3E941510
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A95D1C20C87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3C1A2C21;
	Tue, 30 Jul 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="notl7E3Z"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6451A2553
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351755; cv=none; b=ip6jW7YWSHaVLPvZ6/iZgKAHhcxnXpb0uBcLTq09YBJHQGUhoPHy15d2fAS+rXuYUVLEp7Iogft5PP7BuC+SSaQ+D63M9ESQI2EQeqU6ytVpSa0UqsKP0XDGaMjlJRUPUb1qirOYJswkc9ciHj83owzorLSfJ0rJ9asjuCtzpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351755; c=relaxed/simple;
	bh=1Ta+71ia1QNJpUQgeIqSkdMoJ9Fa4QUq8xj5TWpqvss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9/ylJC6ndH/87CE9tnXGKPB6TJNXZ+jPoagc9EPVg3IDSZ85oooNoL+uDf48i2wOL/jBf2eYtP6SAVBLluoKB20VYJ5jelkKxG37zSvZ9SrRauo+ZSqMMc5HGQIXjty4ZIz3aHRDg9hwNuVg9aIiUUcP1ZIk6op04e6iVAvJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=notl7E3Z; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1da7cafccso228478185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722351753; x=1722956553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8PfWoyQ/BZ4vL4BkdBJYX/P6ybvfxcH/D6ib7uXKjM=;
        b=notl7E3ZMgW6zgk3VAIf4jfei1g9Ra+cCleooQtusBpjRY8ilVaX73t+UjR3tdVWq4
         oYB3rd36ObO6C8xNBAqY7CRIwou33PlGvMVgqgrxK4xLZHuMYBHU17EETWr0eiwvx1bp
         VCT1FM+qUlA05spyDOQ+Trkf0zm0NYjjGvI+Km3wTcbwo8+PO335qkJ/qPIsijZc8srN
         v9cNQsjUYhVdMjnlPTCkhS7F6A4yrtgHxkQZUzZ7gCxHEZapksS1NORio34cuZNWUb4a
         hEupC9LbtdRS/aCSntijjgpWyJ52A8dzhkFcWnGmMzUwmXUwrwgtWL1KxNh9gDqpX6or
         s9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351753; x=1722956553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8PfWoyQ/BZ4vL4BkdBJYX/P6ybvfxcH/D6ib7uXKjM=;
        b=WT+wOkIpJsPy/FWvauBbd9jiYO/Vsowz1kE/SbfAu0qrWqT0zdi0WOfOTHzoyyn4mP
         LujC2En3njdi5DAbGAOWOriF8XeS2mGrfJpCpT4Bbx0hijAmvV9trXqGOAHBb0u4yJVC
         YwNQInMf2jabaUMD1jSYmIrVA5UWv0Dw9LVG0lYMYEuQhqiwEQUmcS3DNw8jNB5ivaYQ
         rr35EzNusZkCRDcQL3UhJHVhk4Zom7SytC4ZQiob/Uai/1A+64DGhJBOZZmf6/JRYfd0
         M7Q/PkLU/iZKeQU/C2jHHJZuEgQWBlIiRX8SxBvVcAnCYUWafmU7BkLuRWHuwjo6UGJ6
         mbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY3zMApuDGyZabQlFK2XlCfu/1/pxzgN0d/EdLUIr+PEguyA2ohpoHqqBRBhIeyfZ5YLv9QfstN14QiIQk7cuGcHBRSZS/lLEpMheM
X-Gm-Message-State: AOJu0Yz34m6ue2NSHg3iKLqhAKOAxHP3++2ROm2QZgHPbo4UhxAkZoC2
	vGiPEn8uo2hxlPUZuKr89AfpDb7z04R9/Y3tM9inidk7oTRPetGvxnDoUdFWIZs=
X-Google-Smtp-Source: AGHT+IE62T9UYgoFVIkcGb7YcoXTufdF8VzWoHsKdhWNi0ZH/AY4EA/1XwSY1gXhI3Nz4aPyj1TOGA==
X-Received: by 2002:a05:620a:1981:b0:7a1:dbf6:f762 with SMTP id af79cd13be357-7a1e524c6d3mr1039593585a.20.1722351752925;
        Tue, 30 Jul 2024 08:02:32 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73efffdsm645934285a.69.2024.07.30.08.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:02:32 -0700 (PDT)
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
	linux-mm@kvack.org,
	yosryahmed@google.com
Subject: [PATCH v6 2/3] vmstat: Kernel stack usage histogram
Date: Tue, 30 Jul 2024 15:01:57 +0000
Message-ID: <20240730150158.832783-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240730150158.832783-1-pasha.tatashin@soleen.com>
References: <20240730150158.832783-1-pasha.tatashin@soleen.com>
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
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
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
index 04a1cb6cc636..c7d52a9660c3 100644
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
2.46.0.rc1.232.g9752f9e123-goog


