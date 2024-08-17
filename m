Return-Path: <linux-kernel+bounces-290861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD09559AA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 22:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDA42829B0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7715699E;
	Sat, 17 Aug 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kyjbiwa1"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CD15623B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927610; cv=none; b=RkNin+PDIerCqVgv0aNKhSUl4oIUxtE/EPEjYdz/wC/34fDN1X13r+ddE3jcKo4BzW6ClGCAkOYSxPFfSK794UvXc5YR8k5dkMaTuMg4r07GFEMdcm0XNqC4XSYRZYOkdQqwvb5u7qQL97OsQZdVQhEa9ZpUrIe/f55Jbi/LeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927610; c=relaxed/simple;
	bh=7Vp7No9whTj/vA4D1O3CqTZTNcenrkvZwi9JHFy5Tm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lva8ToINsf44yRFb/KUGgSLVH4iK8DTeyyxwbz9mBLkCMtCxSiTq2x31pLGxejSzx+1VPiQFt7Qz9KH+94iR422hA4V+mho3opgB6zRO+hJ5ZDO40MkZ97vNuZErjpDStVFRm5AJswFheaJtHZ1D0derIOoHPmG2phjlGaeBVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kyjbiwa1; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70c7c5cb313so48589a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723927606; x=1724532406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02y/Wd8d3ZrLXS7qBzEKtx51SdWa+9oNHCqY9s5SPZE=;
        b=kyjbiwa1Y0r0vy7Jqzp9b3DNujVInGrqgtIPLPYMs0lJSEf1Bum4in7Mwk7xYO4oA7
         PTX6dOynrg+Nd4c9CvWHzjrxNtH8zU5CFxwVDATRXFC0X22W5xLUAkbAOYEsDeh+Jf8h
         O+0uFZNXmAc30iqRE31snyCj+Ut07YF0A3KTN5U+cJzELey2WGtmyFw3AfVvBx5a3aGo
         R6pOtLnML//iji/4p7dLWqdYYEGNbaHK9WCJ1mWyRB8Jh49CVCEfuXTUFZF4fwoMerKM
         TmIadzgCLvmlHf1uKyURjyiGIdDm99rvDztyNXd76FGfTaXX/dMGrRLDYwAwfNH4hhJe
         x7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723927606; x=1724532406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02y/Wd8d3ZrLXS7qBzEKtx51SdWa+9oNHCqY9s5SPZE=;
        b=A5vGeVdhLOY9Yb4aDnsmppiFXtWQ5XKWUBPtrladSo/I1L1aql/cnXM7FXbqCopcGL
         6iE9M2coSFX0tKtZXnX+8ZmXDIQuOWZBtOD/fn749n/nNDiZVjqMuDG2qNGxx31bLeuB
         Ve9H+kYolqGc2J4xn3EXikSNLL3Byy0pjKyb5N5v149vFirEbqGzGhnQfEed/ftsXFAZ
         dqCXNHRkJ3tyauKI7aEv/dyN1SF/aTqbz0JYUp9jYlzf6Z4ucTqg2qNBMEwCKOBnMEb8
         8ebuCgTbCLNUOZDyTNNxosjPbB2SjaQEKdhX/csTM/LtI9BqG1BszsEcCc148ulVt95j
         mBIA==
X-Gm-Message-State: AOJu0YymL8X4x3KHkf88Gtu2+zXElKuR+4uDzbXiVqPwJG8cGbYAfFjA
	XY9fohYFVMIluTLrJJV1lvFy/3n4vu3xmBfmVgOijOFP7iXF8r+hMbVS2ijwwb/Vhi08PvZlJF6
	O
X-Google-Smtp-Source: AGHT+IFqjfiTlMbyBgbOXSrDzwrVTU0Iq7cMM59EJVaPUwdJqLY9FKlS5uF3LRTNIbPXN3Rw+6xIRw==
X-Received: by 2002:a05:6830:4486:b0:703:78ff:1e1 with SMTP id 46e09a7af769-70cac7d4d86mr3074352a34.0.1723927606580;
        Sat, 17 Aug 2024 13:46:46 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm4411039b3a.65.2024.08.17.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 13:46:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] sched/core: change rq->nr_iowait type to atomic_long_t on 64-bit
Date: Sat, 17 Aug 2024 14:45:11 -0600
Message-ID: <20240817204639.132794-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817204639.132794-1-axboe@kernel.dk>
References: <20240817204639.132794-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for storing two separate iowait states in there, bump the
size from a 32-bit to a 64-bit size, for 64-bit kernels.

Note that on 32-bit, the number of tasks are limited to 0x8000, which
fits just fine in even half of the existiing 32-bit atomic_t. For 64-bit,
no such limit exists, hence play it safe and make it a 64-bit atomic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/sched/core.c  | 14 +++++++++++++-
 kernel/sched/sched.h |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9bf1b67818d0..ddabf20cd9e0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3543,17 +3543,29 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 
 static void task_iowait_inc(struct task_struct *p)
 {
+#ifdef CONFIG_64BIT
+	atomic_long_inc(&task_rq(p)->nr_iowait);
+#else
 	atomic_inc(&task_rq(p)->nr_iowait);
+#endif
 }
 
 static void task_iowait_dec(struct task_struct *p)
 {
+#ifdef CONFIG_64BIT
+	atomic_long_dec(&task_rq(p)->nr_iowait);
+#else
 	atomic_dec(&task_rq(p)->nr_iowait);
+#endif
 }
 
 int rq_iowait(struct rq *rq)
 {
+#ifdef CONFIG_64BIT
+	return atomic_long_read(&rq->nr_iowait);
+#else
 	return atomic_read(&rq->nr_iowait);
+#endif
 }
 
 static void
@@ -8372,7 +8384,7 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
-		atomic_set(&rq->nr_iowait, 0);
+		atomic_long_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b6b3b565bcb1..6a90c2da1eb3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1082,7 +1082,11 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 
+#ifdef CONFIG_64BIT
+	atomic_long_t		nr_iowait;
+#else
 	atomic_t		nr_iowait;
+#endif
 
 #ifdef CONFIG_SCHED_DEBUG
 	u64 last_seen_need_resched_ns;
-- 
2.43.0


