Return-Path: <linux-kernel+bounces-257794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A35937EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F4B282221
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 05:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F94D51C;
	Sat, 20 Jul 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cLXLlEOm"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5100C133
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721452380; cv=none; b=NWSwnL7Qi/KXCY+GIETNEFoBi8+LhLmFamOliebWmFGQeh6FQnk6PB+mXVhWsDO2ZwqCl42zttmYYMIeHOokcPxK9JINS7BP1m/s5YmysW0e4sw58nrTdllSXmOjlQ+zFkCMKq4EGcYAS4egIIv54CgbD0F4KBVIsiLb8MW9Scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721452380; c=relaxed/simple;
	bh=BcpCgPgDTGzwxMzLDD/Uq6UrofQQQMlB6ckWQrsLcCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXY6uCcW43Y8U4j/vTvcdGfpXehbhyHSW6BJE+ebLRvtn2Jz1HykytjW31T1VW3cDMr5FHrQRPdY1bLKOxisZrMQE3nKlqFaluAfuXLrmbv9I7Ik/HTyhu1mG8SExuxe3B1TaK9tV8nX5NN9DdjVm5YPH47FSB+DuAf/mTAs76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cLXLlEOm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d138e06e3so19198b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 22:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721452378; x=1722057178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQcmet6Zvq2ElvCY9TE00CST6ri9ogoQlzos7cz+E3E=;
        b=cLXLlEOm/ly/GFPXUF1JNsPOY+wlE8KHxkvbzKgK/s8Vn1KVxMFKfVfW847ru8b/ug
         XzZjAOntx+t07gHt2JIWEQbFP0Ht43qZpL+iUc5ui9yP+eBHRpSO45ZDcAAcX6M0bWSH
         kRClofNRJwDRAD4lxKhxFbTs29Ze/Z/fOAGuf0SxvHhuR59gnaxX2Npc8lLfFezcFZsf
         3IsdhtIXGna1g9YKIPzhdMQlD0HtskztipURmi5NpLy8s1mNw75VwPdlTyCMCLtNb/cG
         lnA1Z2Qqik2hQA4BZ/BO9qfnQpXlmaNRZkjfJmH6cr84uyH+geaZ9uI/Xqpezi/Uaoti
         iv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721452378; x=1722057178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQcmet6Zvq2ElvCY9TE00CST6ri9ogoQlzos7cz+E3E=;
        b=S0ymYUKI7nsaEwDSn9hO0g1a0Ufc8gt4KX0h97QV6Q7UNgl63eA589OAjALHVH7PrE
         3reFP0gmkbcORWhWfAIrr3UuoAcECEa9X8AWQc153dj4P3GkrvuhEq8/M0mjHvIwHTN5
         1zY4UhoSov5slM4OhpfbR1OSV6dHns+BQsdq1VUgG10tPiGwQP/23agknAcHIl1ErhQX
         S2drx1adTeRxod04v3SDSDWmfBBmzHUh3fmaC+2R3OI8B+2rqp/u+TAS0nyRNHIDBBpa
         7nTm4ve/VVlyPGXvekjCpwjnRfxgzb/JSHKY19nxKm68yzncE9RNiDMpQPjzIpaOyy7a
         +GXg==
X-Forwarded-Encrypted: i=1; AJvYcCVVndcRweKmint0jf2TbE+BVGBE+iuA43Jg+AoIJLrmlgxZzRxK1HGSmbYdagS8Ly7Su0rISpi/odgX7m66X/aolKkn50n0hzSf6Mqp
X-Gm-Message-State: AOJu0YyiP/JNZbRECY1soZDwrtzZXF1vDwTF09w9jugb3k0PJp9nJLDP
	k2nS/euZ0sp4lWqx4zNFXZSrVVMRelzrDRD1moNhsR/IBW4V3GesSRn68VxBDXg=
X-Google-Smtp-Source: AGHT+IFlqrZW+TMwqiWlSqHLwRnv7PK63sUTVn1u1BUsimoT+xLCOS+ogHTvIXJKT30IEZij3aIOKQ==
X-Received: by 2002:a05:6a21:3390:b0:1c1:e75a:5504 with SMTP id adf61e73a8af0-1c42287f402mr2780830637.15.1721452377890;
        Fri, 19 Jul 2024 22:12:57 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77540a6esm3744207a91.54.2024.07.19.22.12.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 22:12:57 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in reweight_task
Date: Sat, 20 Jul 2024 13:12:48 +0800
Message-Id: <20240720051248.59608-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reweight_task(), there are two situations:

1. The task was on_rq, then the task's load_avg is accurate because we
synchronized it with cfs_rq through update_load_avg() in dequeue_task().

2. The task is sleeping, its load_avg might not have been updated for some
time, which can result in inaccurate dequeue_load_avg() in
reweight_entity().

This patch solves this by using update_load_avg() to synchronize the
load_avg of se with cfs_rq. For tasks were on_rq, since we already update
load_avg to accurate values in dequeue_task(), this change will not have
other effects due to the short time interval between the two updates.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
Changes in v2:
- change the description in commit log.
- use update_load_avg() in reweight_task() rather than in reweight_entity
suggested by chengming.
- Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..b1e07ce90284 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
+static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
+
 void reweight_task(struct task_struct *p, const struct load_weight *lw)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct load_weight *load = &se->load;
 
+	update_load_avg(cfs_rq, se, 0);
 	reweight_entity(cfs_rq, se, lw->weight);
 	load->inv_weight = lw->inv_weight;
 }
-- 
2.20.1


