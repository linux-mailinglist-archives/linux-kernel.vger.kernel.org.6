Return-Path: <linux-kernel+bounces-394818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DF49BB46B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455A31C21C90
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612FC1B652C;
	Mon,  4 Nov 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oqBMt3eE"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4A1B3939
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722491; cv=none; b=bVJCJoE2XXCA8G0/uIx5oY/R7ejR35rYekLZm0CCh0gRC5q2t8icwkZ9s1l9Z87uS9kL5xWRNN7oQPZDkQxtNfPxq6YtmU1u33+kWOjZA5XhAX7HjBkCmH0Ca/yUh3XQMEt9PWMdmG5jEZfHLi5G456ux3IU2TCJTn2oYVGztlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722491; c=relaxed/simple;
	bh=zXobr+wLjITccdiMJwRpLysNcXSms37c/CwXW2IswxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtzwQqPRDvi5ruFwsOHk9wVpd2MIcrM30DLxry74jjaK1jztL0LEQh5YzL/BRsl77m/Hdjy0QE9b7DKf96ENVWIzuVoL5RAjQAWYejvF5rSqtpUez96cIRCAM1apOxwaNr5AWdDJrkLj+lCXli8k+za4N5Hp0cMB5Wty1YsJzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oqBMt3eE; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730722487; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VkKNIW90OY3KSksPsL1rZn4kF/ZEyKigIUPGYiOqaZM=;
	b=oqBMt3eE+dAJZQX4lpBcCvVB3OILC83NP8+R+3fA9qoUXMy59imwrPSlR+fUsifB8ML9WOUQwI6KCnyvOawkTbhUsLg+7RNgA+VFEV+xdP5ZzmzePoYd2CWgL5mVjNUma7y1tlzlhHcCTRqAXL6zm6X2p1+wmLguzQ2mrDzh/74=
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0WIgnIWp_1730722485 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 20:14:46 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCH] sched: Remove unnecessary initialization in init_cfs_bandwidth() function
Date: Mon,  4 Nov 2024 20:14:43 +0800
Message-ID: <20241104121443.86468-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root task group is statically defined, and non-root task groups
are allocated memory using kmem_cache_alloc() with the __GFP_ZERO
flag. In both cases, the corresponding 'struct cfs_bandwidth' is a
block of all-zero memory. Therefore, it is unnecessary to explicitly
set zeros in the init_cfs_bandwidth() function.

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 kernel/sched/fair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d16c8545c71..2fd96641164f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6573,10 +6573,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
 {
 	raw_spin_lock_init(&cfs_b->lock);
-	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
-	cfs_b->burst = 0;
 	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-- 
2.46.0


