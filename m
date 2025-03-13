Return-Path: <linux-kernel+bounces-558902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3F5A5ECDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E441697AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6448A1FC108;
	Thu, 13 Mar 2025 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dll3boE4"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F251FC7D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850505; cv=none; b=Y92GjDMaQq3dvyTJF686lHfhp8bCo9Y88Hv263gbXAzY9wPZdeIwbW6EomyYsCbA1G5LgeG/3TcZf6icj7sd7o/8/muBXw0ecmgiQYG7llPF2uQNHHaRdk5tjxTWKI2pWuv7yGET2QljFHq517zl9y4TzHdg/5546jLFykwFRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850505; c=relaxed/simple;
	bh=L9rWjtWbTUj8kJFF/EqrEqk9SOXiY+xaWNJyOwq1GC4=;
	h=From:References:Mime-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE1IllvgWSycFAu1sWaR13sPR7Ys6EknPuiM/bztOa0tyPmXhaGlxYB/GB10+ACTNqYTTQTPJcT5RAOuZrQ9fOooH8bnHqFkryx8ZJ15ewlg1BwmOczDnvUauGrs6WbfG1pJgSnn2cb7b207lftMr6DamRZkF8D3kzqpagRDmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dll3boE4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac29fd22163so107249366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850502; x=1742455302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6ACoLFMhR5QCe3o6r/A2S+wrUu/mwDBM2MCBM/Dhkg=;
        b=Dll3boE4OkdMSShcuKRghZrzIsTZDhFcKzxPhwBpBInrgZ7VHe+aOfLkk0UM0A5CFW
         PzcW7e16SJJLtDahqDI2Yzf8f8isE2kapjBsHHBfa1xtORgBbbhLZXWmbbg5+AWAlg40
         htixx3oYeTpo3F2942LinGEMAlplgfLObvn7HWpP1dyMu7RSOY8/llBu3GkE/x1CeIQu
         xTGP5VlTZXFIRXvBt8I7d/OqfeQ5sWqqcDOVSnIEmn6TBBXLh0J6vL/r1M1zIqtAYuSB
         hK0a1AsbunY/yB4W3S0hEgT55kIXwzabAC8q43vfsu+8j9fJqkumqJmjfV0bW6Q0kOlZ
         ZplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850502; x=1742455302;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6ACoLFMhR5QCe3o6r/A2S+wrUu/mwDBM2MCBM/Dhkg=;
        b=mCdkfYVzn6kvVNBIupUnEydAdlBS7Xw+4C6J+0Erh1kqGhABtTJ80vXQ4CMq6K67mA
         4TtYauANfAtOmPqEaGvJ4gAMdg3+m77BYYdWO/eiGY453yn0oPjREYVI1ss7GJGyfIBC
         AHyFaAz4juc2C4gKU+WMfzx+uKs2ncFdd1SPxqXSsa2ICr0T7roN26l0/s+oUDsOOYI3
         4YEpf8LAZMd3BLFUYoLWEqpBeSP8Gfp07QN1+XhxDRo7LfZA1pB4cSer5xlUiJPNlTJf
         g0f8/y22mytNx8hDXQXlAIvUnO+boXMpmSk/SAGa3IT6+vbNqfwc0MwG/au7agdY6E+1
         JkZw==
X-Gm-Message-State: AOJu0Yy1q/cS4JZ80UVhcND+Lyy+lqneYyU5P7wWkAcoEJ+g7f6EiFEg
	1U92TLfvNmH9vMRFfjDrN7hD3LEInbuahp9ocXj64G8PfHdNC7tvtH4HjKbDat4XrY26zQQN8KJ
	qdUSYxxPJeFZMRdHGOmKTzWYqKA7D3gc6tm7z
X-Gm-Gg: ASbGncvljzZp6oWq4nm++W5n2xEO4O4wKr0jtXtZtbyZ/I05Iygjxmp5HVkq/e806Sd
	5x341I87DAzMRNtjOQkGxYwu4dYGMr/lqJAsndg/+sET9KLtjN7UKGVSy0xH2irLKemi8EoRxJd
	NQOUnZCPGoEi0GQnNMCGYQccB/Y5Y=
X-Google-Smtp-Source: AGHT+IHZlkarGeABNz4Te832wQORdZEZDUsFX8baQz3ibjsRP5NxGbLCL2EsI4JyTBDnuEd9vj+aCazq//6SIWkBOMM=
X-Received: by 2002:a17:907:1b05:b0:abf:5c3e:e5ac with SMTP id
 a640c23a62f3a-ac25274a016mr3260906466b.11.1741850502239; Thu, 13 Mar 2025
 00:21:42 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 02:21:41 -0500
From: Aaron Lu <ziqianlu@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250313072030.1032893-1-ziqianlu@bytedance.com>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Date: Thu, 13 Mar 2025 02:21:41 -0500
X-Gm-Features: AQ5f1JrMYgKlv4h5qut83Hf_IVCXLSzFvmIokw7J7C3zknPboY4KARnKxo14f2A
Message-ID: <CANCG0Gc2vAMO_5x8wYhA-=34n0vChrSdUvnd+Cf56MXfq2YFfQ@mail.gmail.com>
Subject: [RFC PATCH 4/7] sched/fair: Take care of migrated task for task based throttle
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

If a task is migrated to a new cpu, it is possible this task is not
throttled but the new cfs_rq is throttled or vice vesa. Take care of
these situations in enqueue path.

Note that we can't handle this in migrate_task_rq_fair() because there,
the dst cpu's rq lock is not held and things like checking if the new
cfs_rq needs throttle can be racy.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4a95fe3785e43..9e036f18d73e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7051,6 +7051,23 @@ enqueue_task_fair(struct rq *rq, struct
task_struct *p, int flags)
 	assert_list_leaf_cfs_rq(rq);

 	hrtick_update(rq);
+
+	if (!cfs_bandwidth_used())
+		return;
+
+	/*
+	 * This is for migrate_task_rq_fair(): the new_cpu's rq lock is not held
+	 * in migrate_task_rq_fair() so we have to do these things in enqueue
+	 * time when the dst cpu's rq lock is held. Doing this check in enqueue
+	 * time also takes care of newly woken up tasks, e.g. a task wakes up
+	 * into a throttled cfs_rq.
+	 *
+	 * It's possible the task has a throttle work added but this new cfs_rq
+	 * is not in throttled hierarchy but that's OK, throttle_cfs_rq_work()
+	 * will take care of it.
+	 */
+	if (throttled_hierarchy(cfs_rq_of(&p->se)))
+		task_throttle_setup_work(p);
 }

 static void set_next_buddy(struct sched_entity *se);
-- 
2.39.5

