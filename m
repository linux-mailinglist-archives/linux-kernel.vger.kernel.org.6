Return-Path: <linux-kernel+bounces-255297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2506933E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE5D2840CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5B1802DC;
	Wed, 17 Jul 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="criF5qg0"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BAE18131A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226832; cv=none; b=lc5sW1hDz3wPZ9ADHiSeb2fGDi6dcNf1UKGkIxW2OhoWnKgl7FJVpF1D3TAvgby3kIIisToRR8eXOkMw+AZ5ikbdvOX/f9fXJRy0bAfnoyEPcRHPHxQ/eP4lXBjAPqmW0B39ple22sVRLTMti8pHyufQGgykHf1HeWSgKYRxBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226832; c=relaxed/simple;
	bh=Ln2UdArtplwb8j5eZRrn9TN7TIoM7xKqxxHu4e3Ondw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=edSOX+MNAxaq5Apk8WWtrmsYeHePa8cHn4xxbR34hDYYN0/Ippa4KKefFvFkeA5D/g1ROfet86zLSUahrKHHMkwjuWJ50YZnO6+ttyFjMEVM4bAmecaZzS8gebLh6hx2V1Ji+6626nf+vGtbzFy0mBR9p2O7fmOWaaGumlwKn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=criF5qg0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so369944a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721226830; x=1721831630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPtFZSBGhE8BugOnpvHQmsUlOYpafVQi3ip6sMTLjT0=;
        b=criF5qg0Ceo6Xi3qAEp7xaatx/dApMBzVoIH5t4XsO4j6BgRSVx8TSC7T42peOQ1fB
         iCJAaiW240e7eIeKC2vTV/mlzCC3Zg7oJGyg/PHRLoe2TjxezPz9DHfbnu72ZaCjqkPB
         5/TADTj7NqCR69Sdji7stnnitgUvQ3scCo06TTlkCume+I2m4AQ1YVMFvbFKo5U/+yKh
         ErhLTAkMMHUwdKAACjG/AdA4KBbOWdksy0yjbqxQ2Phum2usEApbbaZgJeAhv381kyq5
         OX6STw9IoDw8pJKuL5T9DlnuAIzSVlc3Jwmgn3Zvrqk5dbFEHua8T+f1lecEs1MdQujR
         YliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721226830; x=1721831630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPtFZSBGhE8BugOnpvHQmsUlOYpafVQi3ip6sMTLjT0=;
        b=spmK9a9RnVusfc/eX6IcAUBkvcwKYj+4r1KS60L+2Pe1UYAvMFCfFADpGnctwiY4G6
         WMp47uiSCl8d0JZWi7Kkg4u6BeATmoPRMXzJWc0D945BkuiNENI3zGk8EVaghfogPiWJ
         xfRo0cpijZWsG7+EUUcQWxjGfLAmqsPsvSHUpew6h+g/y9Eit2Im3qsvXUhP6h5gmi09
         reUpiTeadhYibHOs+n2YQ1ZGIpp1+arUD52uKKVlLh9bWtMy2m8jj8XzTMP5+C8Q/Edp
         D3te21Ah1wf/BWlP/jwQeXdF8O94nsJZAuRWshpA1yyx2GrnYsu5EA42icXav1mRa1AN
         56aw==
X-Forwarded-Encrypted: i=1; AJvYcCU7VyiMzWoVGVfC0n1uzBgcRH4uqwKkhqd6XsT67CEBJxaS5L41R0HFMR4kPgRG4XXtkVGScZiWGEGrqP1WXlBjUF0lFS0zN5ANGNK/
X-Gm-Message-State: AOJu0Yw9yhbslSnLD2mTyZOajJfbFGf0MAugkXMxyqGn/eT7PHjMNcOs
	Rb8T+hTa9uyrEahxUfBuoBmZfq1YX4EI1cpywuEGtM7vczK52cbenimtWKDJC2Y=
X-Google-Smtp-Source: AGHT+IFUJ8D1K84VOqbmu3xJoy892OVcEaAXLsxYtadLYouTK7FFF5L1tPZMiUAXNE3VCoXVKB1I9g==
X-Received: by 2002:a17:90b:38e:b0:2c9:635b:7271 with SMTP id 98e67ed59e1d1-2cb52662161mr1360569a91.21.1721226829923;
        Wed, 17 Jul 2024 07:33:49 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb600eab8esm794a91.18.2024.07.17.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:33:49 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v2] sched/fair: Remove cfs_rq::nr_spread_over and cfs_rq::exec_clock
Date: Wed, 17 Jul 2024 22:33:42 +0800
Message-Id: <20240717143342.593262-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_spread_over tracks the number of instances where the difference
between a scheduling entity's virtual runtime and the minimum virtual
runtime in the runqueue exceeds three times the scheduler latency,
indicating significant disparity in task scheduling.
Commit that removed its usage: 5e963f2bd: sched/fair: Commit to EEVDF

cfs_rq->exec_clock was used to account for time spent executing tasks.
Commit that removed its usage: 5d69eca542ee1 sched: Unify runtime
accounting across classes

cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
eevdf. Remove them from struct cfs_rq.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 kernel/sched/debug.c | 4 ----
 kernel/sched/sched.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1afd13..90c4a9998377 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -641,8 +641,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
 #endif
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
-			SPLIT_NS(cfs_rq->exec_clock));
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 	root = __pick_root_entity(cfs_rq);
@@ -669,8 +667,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
-	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
-			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..8a071022bdec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,7 +599,6 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
 
-	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
@@ -619,10 +618,6 @@ struct cfs_rq {
 	struct sched_entity	*curr;
 	struct sched_entity	*next;
 
-#ifdef	CONFIG_SCHED_DEBUG
-	unsigned int		nr_spread_over;
-#endif
-
 #ifdef CONFIG_SMP
 	/*
 	 * CFS load tracking
@@ -1158,7 +1153,6 @@ struct rq {
 	/* latency stats */
 	struct sched_info	rq_sched_info;
 	unsigned long long	rq_cpu_time;
-	/* could above be rq->cfs_rq.exec_clock + rq->rt_rq.rt_runtime ? */
 
 	/* sys_sched_yield() stats */
 	unsigned int		yld_count;
-- 
2.20.1


