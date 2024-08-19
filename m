Return-Path: <linux-kernel+bounces-292410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C9956F17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B01284EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B913BAC6;
	Mon, 19 Aug 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N5fO/SQU"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BA82D94
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082190; cv=none; b=d49W/JdtyaxVMWOPKgp+xietF7wsmfEIKo8eFMMznAfGVIy5jPFHjm5trXY7tAlJjNHcl004/ZEl5iMdq4XfbA9YsO4BR+h6UJKOPsryjS4Pir1TTFqgcedM6NNuUQE7U9+fRiEMAsY29awnzyMR3KRnrDdTS0jtddG9HV5WEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082190; c=relaxed/simple;
	bh=UTfeDrPv1P7VGVLIn2EsldU3QCEyihFMAXquA3OWvIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACxwVLB3rkznsK21VTNC+vZ9gDum3Hg6MKuzfm0r1eZs3AJJzGJam6l1NS6jWQl0ARYc4rQw1OhG2sQ6Lz/6U5e7nwqEsinlVcyxBJnIYclLhB5wNRkJIer2G5ifWRZKrkNsLwjeXiXZWOsW0VI85dX7urBZBmDnY5GBvjohzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N5fO/SQU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3ba4e6ad9so849256a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724082186; x=1724686986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QZ5nGY8yRhaSovqTVP5eDgWCjwMJ5zw2jKCQIUNZGI=;
        b=N5fO/SQUnWffdEuGy0NOnkOfEePCeB+eJF9GEg0tYBaNkto2PnZUu7Us0+YZdYE7mP
         5GHeU1g9wLAlVL1+VhFES4dc6Lcl0Yvuag8462xBchOrbgJcoKpn6BelYcrCCJe5MEdl
         pa5R8ONemniaQzdz/2vjo+p6bKu/SxUZqiew55OH2g+GcTeu/TdzJU02Yr0ZQ9DWJYcV
         Hg/dqgW05OKMCRTXDjhyctp+zDNqQmgzWSpusI/JQ0bm7878zHJ6YzkPwJ5X9nbDlMKg
         Xgqlgm8Ow+zPjImW9mSK5/uDZizcm91zwZPojrTukvgdTzDTKTEHL5lg6JbeAYyubU6t
         Uu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082186; x=1724686986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QZ5nGY8yRhaSovqTVP5eDgWCjwMJ5zw2jKCQIUNZGI=;
        b=Qy454xVImn8GxLL3oyUi9k60Aee1NhlL/WgLq8AX6bBmYDiaGyBAPjS2hJdOnO7pkU
         +gqOojgpHeK4hrqr0SPrkUYnWWd8efSAjwYfDsD2k4+YKJ5GoT+bZycU3w7nIDHZhaG8
         4feWZ4RDRsBv9JsUSIspFO7nks11JeKuhxzkA13mS+wS1eBZpsA0WY+W13Qvf5KJktdI
         lCibJHMfmce86+QqPPXV5o2TsbeyfAfILv59qtf87RlhnJKpMg1Lnu2CGIAHe1A8lQDv
         a7gUJKi+jFKZU9SdBQVYnlXI6MwUNONEYJXMYbzYk6GXJqsbMbtHOOQLKZchjhzf4tQA
         JhQw==
X-Gm-Message-State: AOJu0YyGCKc7s2UtGjb8O5rUaiy87UK0HBgOuQ0Ki1zjM+dgGjarQJfh
	EkJLfHjZHs89eOwq2bq1Oq6t4nn6y1NvPabG88IcYnbg2pAsl/h+1anyvtFysne+NjS0Xirte5s
	2
X-Google-Smtp-Source: AGHT+IGgQiHQ09ncrftjT78NhUCy+9R5076zqxCfZlDz/0Wkj1fDTUeRrbdX3LqF2lpcK0t+nWMiBQ==
X-Received: by 2002:a17:90a:fa8c:b0:2d3:cab7:f1dd with SMTP id 98e67ed59e1d1-2d3dfc396d7mr7214984a91.1.1724082186329;
        Mon, 19 Aug 2024 08:43:06 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c751f1sm7356041a91.38.2024.08.19.08.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:43:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] sched/core: change rq->nr_iowait type to atomic_long_t
Date: Mon, 19 Aug 2024 09:39:47 -0600
Message-ID: <20240819154259.215504-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819154259.215504-1-axboe@kernel.dk>
References: <20240819154259.215504-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for storing two separate iowait states in there, bump the
size from a 32-bit to a 64-bit size, for 64-bit kernels. On 32-bit
archs, the type remains a 32-bit size.

Note that on 32-bit, the number of tasks are limited to 0x8000, which
fits just fine in even half of the existing 32-bit atomic_t. For 64-bit,
no such limit exists, hence play it safe and make it a 64-bit atomic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/sched/core.c  | 8 ++++----
 kernel/sched/sched.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9bf1b67818d0..7e04b84dcc55 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3543,17 +3543,17 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 
 static void task_iowait_inc(struct task_struct *p)
 {
-	atomic_inc(&task_rq(p)->nr_iowait);
+	atomic_long_inc(&task_rq(p)->nr_iowait);
 }
 
 static void task_iowait_dec(struct task_struct *p)
 {
-	atomic_dec(&task_rq(p)->nr_iowait);
+	atomic_long_dec(&task_rq(p)->nr_iowait);
 }
 
 int rq_iowait(struct rq *rq)
 {
-	return atomic_read(&rq->nr_iowait);
+	return atomic_long_read(&rq->nr_iowait);
 }
 
 static void
@@ -8372,7 +8372,7 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
-		atomic_set(&rq->nr_iowait, 0);
+		atomic_long_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b6b3b565bcb1..da2e67621f39 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1082,7 +1082,7 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 
-	atomic_t		nr_iowait;
+	atomic_long_t		nr_iowait;
 
 #ifdef CONFIG_SCHED_DEBUG
 	u64 last_seen_need_resched_ns;
-- 
2.43.0


