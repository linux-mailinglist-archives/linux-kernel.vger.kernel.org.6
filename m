Return-Path: <linux-kernel+bounces-254007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2F932A15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C181F247F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13719DF97;
	Tue, 16 Jul 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kmq6K7xI"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949C19DF5B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142403; cv=none; b=IpIDkUnAXAvcFhyh1lRLu4+Ul8SKzwPA99Wh5nfpSz1kZM+EB7l7D+96bsSFsEpBCbbXCXY3nNewVK0HfzPKyZOeJ5S/c8qYdzWWhKQ/awedvgRiqbxPGBNDKMuYpwi0W9kCFjm1h62wmA0+msQ0KF0Cl3fyaBXT4ZXCpw2qR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142403; c=relaxed/simple;
	bh=+BGYl+sdySwOSWJtFRDOhdjOTNoj+oygwIGJHHV6QCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUyiJ3H7DSSktarjfh25UIUOC5f6vfE27+K44Tts804Ogxzf6B4JGB6GyvemHCNsEWXds/7sC8EdbkTnWALRW0eRcYX+AB7SsgZo5SP2ZGRE6g0SyXx5iWI0XdWTOIGGvd8WMUgg/BjBktM/iTRrRpIe88l/ycsn3bg9Y63sGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kmq6K7xI; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7662181d487so3055168a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721142401; x=1721747201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOPNodhmEDx/9ntEQLpFCLonFQQCQoq9melw4nw0YfI=;
        b=Kmq6K7xI2brSrTlvxP1+MkP66eEfIp0QBmJWHc/L4BMuG8K7yo8WuIftYbOvanOLz3
         Y22TEK1bZzgeOhIK1OVgrg6XokEWnJTE6yuRrABf6EYMLEgwf5yJb0kn3+L4za84pOmy
         P0LzVuQSvyeICrHo1cm0t5oM6gQZZfaP6ojwOY8oVq2kDcOX+OWzhjyatk+eZpAJMEqj
         XqC7C7SR7NdqFlwE5j96yCK8wqJNPB+3AopeJNp/SsMwLkD4MMGjYm/PwLw5YN+CH8eL
         CLzQhOEEc1cyRbzYKWUDzNijiYOfqfynR2FjgFi595ApRgK/4AhiYwQVyfWz08Qw/sm6
         /Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142401; x=1721747201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOPNodhmEDx/9ntEQLpFCLonFQQCQoq9melw4nw0YfI=;
        b=CPmuBUjOXSYJ3UoZkBeISSmFPB2ad6dK0t9K0j3d0VMxFnJIkoEY3olIQCPuXYHr3r
         KBSwaNOjMVMO5N7QztdKexPS0um7qJwHw4342RXugFLoGXwBznJiJ/P4eFQXf708miBd
         mwmYDk85EpPb/s0aG/NYBfBfIfCmu/S+9TGAMHx7df3sgAmyJlx+/kvMxPoEwtYqUL4U
         1rbKR1DPD/Z2GZHZ1BCWvtkK26Ae3pwMZz9bbjHt6Fazfxux0iEpx0ce0XvfGJoC38Sm
         bjnOThJrLCxh3hPKkl1nsxOaqMcKx01MAhbwuZk1CR7+Guj89l0WHXeP1P+4L8yKyKqJ
         +lkg==
X-Forwarded-Encrypted: i=1; AJvYcCUTsaYB78VA3sx/zwvKDux4BTfeF9Tekdm3qsWT6ipLJwvsCa2W32BfhQfh68mAd03Y9KBDcCRZ99Gb5TAYgZRV1Sa75nAdQNbXcSjJ
X-Gm-Message-State: AOJu0Yw4nu7yI+OJriFFEnBrP2TGMalC8E0dZy4b3Xc270PBH9ci93Xk
	LkJzA3O5N6sANNSKug9HcLCaG1eukS2EVuSVwe+/ilSVzBui4qlB1AxpgQFV/Zk=
X-Google-Smtp-Source: AGHT+IHBWSdchGhjxX3rT8W0KAzi3CHwcEhahx5HeddVhmxys/LYNXL8MHJQFdwxBJbf5cKa7DUWmQ==
X-Received: by 2002:a05:6a20:918e:b0:1c2:94ad:1c68 with SMTP id adf61e73a8af0-1c3f123df96mr2978926637.31.1721142400897;
        Tue, 16 Jul 2024 08:06:40 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedbf746dsm6455266a91.23.2024.07.16.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:06:40 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH] sched/fair: Remove cfs_rq::nr_spread_over and cfs_rq::exec_clock
Date: Tue, 16 Jul 2024 23:06:34 +0800
Message-Id: <20240716150634.21247-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
eevdf. Remove them from struct cfs_rq.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
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


