Return-Path: <linux-kernel+bounces-447319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECC9F307D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416E37A15DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9832054E6;
	Mon, 16 Dec 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IlMQoNd0"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B018204F98
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351872; cv=none; b=nD083/BYcBNBgNU3JOUk3t7/byxw+XEe6azwknSbGhJz/M2XZfNIlEolAHUUWXq50kwcLXawjfWJ6d7CL+9x8h/AWEFEW35NE1KDZ2Hh1M9Wlh43brRoX2QcPJoZGieu37q2V1D7aSgdLCRG+UToHQhNnYLOfSxYs2uon6xGjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351872; c=relaxed/simple;
	bh=SuISuTxchex9RJodo04tat69zEAGe+ko1/0ZQdMXDUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eR8IR0npGkHx3EQzTMFOldZtmbvAFnm46fZio1xfE4mbzfvOkmuXoEJ/RP0TrGP7keIx5hZmXt+obUGX0TuDgCX9PC2WKmc9iH0mZf5bCgq+IKn5AriJOG+yhG0a/V0qyh1FyLi3/dUCel+o+do8eQ6/ZVigVkx2SRjwWmBhD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IlMQoNd0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166022c5caso30240795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734351870; x=1734956670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKG7eYUurdAiRXTeQw3+Dl2PfUcHaffYGwgJSL+ktjo=;
        b=IlMQoNd0oIViCA0Uy0CSdSnPhHYpuXD5lAlF+w19R+7Hg7tsVxE3yBrgLM0/TdkQUV
         jOPnuIjNntEDpypEgaGwR2f2srR+Bss8HD9/UPg05IF2OFmb5mqlgECyGiboRwXWuEIx
         t6tW5For/cJiVtrKfSvOXn+klCnym+yUQw9i7m3mSOgiSpDjTNEe/DV6motoStyVAA/k
         WfjhDUVo3xzSF4U5hz+5E5Ui0/+43xUi1fBoYbo6puHrJzUr8+3R/gtQU8BAZIgmuJIY
         jrh/Gw4jzcKtWBFbzYpwzjOnYeqjekKxcdvCwfXVlSIVPqPT+dLBmSFE0IlRD3GDtxg2
         2BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351870; x=1734956670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKG7eYUurdAiRXTeQw3+Dl2PfUcHaffYGwgJSL+ktjo=;
        b=ixFaEz3F4uNkrwR1cP1NInxyg8eV3SGa9JNPSOnRT4wYCrnN7BSzEy9fwTYZ5UE38/
         fW8H5lmeVkOGJBw9rQZUztSzeCYZl3EthwuYmMR5/YLRzlQzx+kk91xqE2GXK/4tjwCn
         O/MZG9cLhcR3AgHAs2oOGaNVt2NbQXerAuErWABsx96sdzMTQPMvM8go2zxddVtIpAai
         dJ02D7C3yZt5EPVBPd2T96QuLaJ2IwtAxEn9FStwqZx0QP+Kk11uIGdRd+MbeZSfdIME
         t6jhqgQp0Rcy4fJjaeb6ykunlazCaQLQvpV0GfTmXOAFTLkhbmL2mtUoQtJnRQqiHnUk
         3MmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpFll6J1SjR4oqamB07XhZW71jQ5d4HJxSKrAQrl1ax0mIWb6gKB3Xy7NupL/8yryV2/cDtLYjdZzdJSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wMmKnmxEEVmFHRs5rgZD3G+ciQ2ePwbSraJqJ2/m1cJHCxif
	tgFp7A1mdOGDnpJK0vbrJUSO1iOQ0FfY32ZaDCnF+fQJQFqxZ+/cwOn/B/HmfR4=
X-Gm-Gg: ASbGncspYHy9VWxjvKVjcZkzeYSDiWohmcJMRYilVEe1xao1VdwVBlxhEzu+A3gZaim
	Uzwn3nRAW4NDv3p4oTEU1vV3I7qPyV/HPHNul+RnQJR4YIXiURZO1gZ0cws+ZZmWcJGAx23IhR/
	4SZAyQrfzoPKTa1dsTqSpYYY3Cpi5T4Abz9RcyTSC9/qUe+S+AI+xnWovFwok7/Y/nS0SQWOQWG
	31Hmacrb4LEUlvd33vCxh4S4OhquAjDyLi0wqjfd/IUQW/Fqjf5/bCl6ALgUnckHKN0AI6TMQwm
X-Google-Smtp-Source: AGHT+IFdWgO4OoX0eAlDH9oyL7ndVAkbnEiwV8QelViM2oYlc/vfXIYkgOFTErhlEGsbODdVMKjcjg==
X-Received: by 2002:a17:902:d550:b0:215:b5c6:9ed3 with SMTP id d9443c01a7336-21892997b2fmr200021365ad.12.1734351870354;
        Mon, 16 Dec 2024 04:24:30 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d0e4sm41501555ad.261.2024.12.16.04.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:24:30 -0800 (PST)
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
Subject: [PATCH 2/3] sched/fair: Ignore isolated cpus in update_numa_stat
Date: Mon, 16 Dec 2024 20:23:56 +0800
Message-Id: <20241216122357.1276382-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241216122357.1276382-1-zhouchuyi@bytedance.com>
References: <20241216122357.1276382-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now update_numa_stats() iterates each cpu in a node to gather load
information for the node and attempts to find the idle cpu as a candidate
best_cpu within the node.

In update_numa_stats() we should take into account the scheduling domain.
This is because the "isolcpus" kernel command line option and cpuset iso-
late partitions can remove CPUs from load balance. Similar to task wakeup
and periodic load balancing, we should not involve isolated CPUs in NUMA
balancing. When gathering load information for nodes, we need to ignore the
load of isolated CPUs. This change also avoids selecting an isolated CPU
as the idle_cpu.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f544012b9320..a0139659fe7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2125,6 +2125,11 @@ static void update_numa_stats(struct task_numa_env *env,
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
+		/* skip isolated cpus' load */
+		if (!rcu_dereference(rq->sd))
+			continue;
+
+		ns->weight++;
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util_cfs(cpu);
@@ -2144,8 +2149,6 @@ static void update_numa_stats(struct task_numa_env *env,
 	}
 	rcu_read_unlock();
 
-	ns->weight = cpumask_weight(cpumask_of_node(nid));
-
 	ns->node_type = numa_classify(env->imbalance_pct, ns);
 
 	if (idle_core >= 0)
-- 
2.20.1


