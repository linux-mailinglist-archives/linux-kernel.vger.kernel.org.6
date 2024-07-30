Return-Path: <linux-kernel+bounces-267208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04EF940E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900F8B258D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FE197A90;
	Tue, 30 Jul 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiSj6o7y"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB99197A83
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333379; cv=none; b=U/H32mqFLDNwRTNt4IXl/T5S3wkzsHrZ2npeqnngCco/DnePGCy9dR10DO/F87/ubM36/E7TEwktt8d7iBwD+ViVkxrJnAqNXeEmG2igDLs6ZZmesjCPz/pVzYE4ETRNP04wr0MbEz9/CjB49X6WOYp2jT8141a88wFC8+KkzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333379; c=relaxed/simple;
	bh=vpWFmdMi1rTEd8dRgWsGaNMK7DPKF1g4mk5pxgxhAPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dzVUSmNdPHBVnjF/pwubIyw/9WMIyfQKIgP/mNTuzIEGpglOnk5BogHd6vuL7n763LMf2rMt5H9xR+FeOifuH+Ho4SxQNsCCSH2UfqZkmtNj9PhxMk00JFGH0JHi2fOx/zTcqOdGA9s4NTH30MEA1Kc/5R9PQn+mJsXIob/+/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiSj6o7y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-79b530ba612so2656948a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722333377; x=1722938177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKiAizELl0ICWCMoQVGz7EzMrJ1ih8tZCdVCsAkXERc=;
        b=YiSj6o7yO/wATkYgFhfkZ4PGDGLNq9lkOaSWjkCa4Lmt4zjl7JKm9LKNpr1Notv1il
         fUW9nuu0Xnotcp+DYA9Fas1iFrBFsFYtG7mOeAcbbQPGWt1ISsPf1BCk8ydE59uvjUcE
         rKTIdZoIHBk/SyXXucztZgy+n7et7yos96GzBkNx1vWNvSWHiNdigpZwN+V62uWRvpC4
         ZNIunvz3Atl4TRqCRqhFhcXbjxEuT7EAp6JVqu3JlXiuslyYul+xQCK4e41MK3WFiya1
         cuOF4aApTnMwiOEVQBlYV8J+BL+wWzW/FAxCAXirl6qSBmyXDEmq+JzPIM1LzeykMMn+
         BvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333377; x=1722938177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKiAizELl0ICWCMoQVGz7EzMrJ1ih8tZCdVCsAkXERc=;
        b=vUVDLppyE0Uutv7NArSvAQZedBfkjBuJSmb1bhrTrTU+KrJdQ6795aXJHoRqb8QkPx
         JseTz3oXYA2IPllvu4pI4ou/ddwT4N9k4MP8JgnIJRX28+haVit+ru35QN7EE3v9ck2E
         SeK3hnEgCYeZJapW5W8GR+SjcVTbynSG0+JBBvO+0SioN45Md3UsyDdkHE8Dc7WaE4Dp
         bRBo1cP1BUNMekeSloFCnpobN1VU5O77bOHFV94MDJoPxXBwr+jS8XwKzPGptyaiC2y1
         NMquZQje608j5cwBggWnrGelP5n1tPJZTycKIbwKP3rT+SnumIh0oNQRD5uSRas1ZOb4
         XPiA==
X-Gm-Message-State: AOJu0YyB1mJOwF77FmNWv9ZhM/Ko04+I96q6LQQpsFULuPqP8SL844n0
	WdE/44vf7Th48FzSaEGKQwlWY1Bro9YmsOCLmpBsSGzG9WxYhhdt
X-Google-Smtp-Source: AGHT+IFS9UzfPzzV+AOiKqLRCQijYFtGRkC1yC2Ak/y8WU2q7BwQZUMoXLOrmV7prR3d/pJc6Gs9hg==
X-Received: by 2002:a05:6a20:8417:b0:1c3:b2da:7e27 with SMTP id adf61e73a8af0-1c4a129fe67mr7837330637.14.1722333377562;
        Tue, 30 Jul 2024 02:56:17 -0700 (PDT)
Received: from localhost.localdomain ([61.16.102.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81272esm8336346b3a.97.2024.07.30.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:56:16 -0700 (PDT)
From: Zou Cao <zoucaox@gmail.com>
X-Google-Original-From: Zou Cao <zoucao@kuaishou.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org
Cc: linux-kernel@vger.kernel.org,
	zoucaox@gmail.com,
	Zou Cao <zoucao@kuaishou.com>,
	fuwenxin <fuwenxin@kuaishou.com>
Subject: [PATCH] locking/rwsem: optimistic spin failed when handoff bit set
Date: Tue, 30 Jul 2024 17:56:06 +0800
Message-Id: <20240730095606.54621-1-zoucao@kuaishou.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should not optimistic spin when handoff bit set, it will never
get the rwsem lock until first waiter be wake up. otherwise it
exacerbate the latency of osq_lock, this patch improve performance
about 5% when runing UnixBench.

it is easy to reproduce when run unixbech shell8 in xfs filesystem
with AMD EPYC 9654 96-Core Processor
    ./Run shell8 -C 56 -i 1

the totale machine load reach the 92% with 90% sys and 1.7% user.
all the cpu is busy in osq_lock with running perf top:

  90.07%  [kernel]                      [k] osq_lock
   0.66%  [kernel]                      [k] unmap_page_range
   0.52%  [kernel]                      [k] page_add_file_rmap
   0.51%  [kernel]                      [k] release_pages
   0.30%  [kernel]                      [k] rwsem_spin_on_owner
   0.23%  [kernel]                      [k] native_queued_spin_lock_slowpat

after this patch:

perf top:
  25.59%  [kernel]                      [k] osq_lock
   4.69%  [kernel]                      [k] unmap_page_range
   3.61%  [kernel]                      [k] native_queued_spin_lock_slowpath
   3.05%  [kernel]                      [k] release_pages
   2.55%  [kernel]                      [k] filemap_map_pages

the totale mache load reduce to 10% with 9.4% sys and 1.4 user

Signed-off-by: Zou Cao <zoucao@kuaishou.com>
Signed-off-by: fuwenxin <fuwenxin@kuaishou.com>
---
 kernel/locking/rwsem.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 33cac79..7f345bb 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -684,10 +684,23 @@ enum owner_state {
 };

 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+
+/*
+ * OPTIMISTIC_FAILED  : optimistic spin lock failed
+ * OPTIMISTIC_SUCCESS : optimistic spin lock success
+ * OPTIMISTIC_HANDOFF : optimistic spin lock failed by HANDOFF bit set
+ */
+
+enum optimistic_stat {
+	OPTIMISTIC_FAILED,
+	OPTIMISTIC_SUCCESS,
+	OPTIMISTIC_HANDOFF,
+};
+
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
-static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
+static inline int rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);

@@ -696,10 +709,14 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 					count | RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_lock);
-			return true;
+			return OPTIMISTIC_SUCCESS;
 		}
 	}
-	return false;
+
+	if (count & RWSEM_FLAG_HANDOFF)
+		return OPTIMISTIC_HANDOFF;
+
+	return OPTIMISTIC_FAILED;
 }

 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
@@ -818,7 +835,7 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)

 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
-	bool taken = false;
+	enum optimistic_stat taken = OPTIMISTIC_FAILED;
 	int prev_owner_state = OWNER_NULL;
 	int loop = 0;
 	u64 rspin_threshold = 0;
@@ -845,7 +862,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 */
 		taken = rwsem_try_write_lock_unqueued(sem);

-		if (taken)
+		if (taken == OPTIMISTIC_SUCCESS || taken == OPTIMISTIC_HANDOFF)
 			break;

 		/*
@@ -930,8 +947,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	}
 	osq_unlock(&sem->osq);
 done:
-	lockevent_cond_inc(rwsem_opt_fail, !taken);
-	return taken;
+	lockevent_cond_inc(rwsem_opt_fail, !(taken == OPTIMISTIC_SUCCESS));
+	return taken == OPTIMISTIC_SUCCESS ? true : false;
 }

 /*
--
1.8.3.1


