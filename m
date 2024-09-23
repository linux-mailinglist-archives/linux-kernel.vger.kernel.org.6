Return-Path: <linux-kernel+bounces-336021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42497EE1B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3041C21692
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4DB19D898;
	Mon, 23 Sep 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry7iS+CI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49C19415E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105281; cv=none; b=JK8pGNK7jT6uQ/sKXfMoqo4+ZX6LHbVjc2XwpTYduKIOx2AczQUkPKqDuNv6OV2rpJhId78jJeiwHkiYteOUT6dDfeDejm1v4UZgWqFSYkfshidjvMCBznEL+09m2a7N4XSFXjU8WmTWbW6kpn7SNMcLa/FdmJmwg1wM5wBON1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105281; c=relaxed/simple;
	bh=aj18dTgLEiuMoH/5TK7xy91vjIRsXIF5Ja0C5hRzCvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBGqjn9ux/hzqRtCktzS3ZDvtabv5z5faWeFOZzLLZL1BbMya5qYo1DYCyGDKVFnb/6ifIK3v2LggwbwOC7GKm4VguIneZ+UDZMOyUYGdMPr5HYeSREBWbygJbCSv9P/IEy7lWTd3Fk/740W2sZgiEFIpGDZIBCbVhXRe1mgzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry7iS+CI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37A0C4CEC4;
	Mon, 23 Sep 2024 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727105281;
	bh=aj18dTgLEiuMoH/5TK7xy91vjIRsXIF5Ja0C5hRzCvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ry7iS+CIpWZgKvSQx0hA4O4oEj+a2q5hDRhv/t/0Dj98/GPdm5HGe0871ZyfF+cFf
	 jx1WkYNYRG8GIhTYYhyYOI5TAQgSTFAIQ5+RqsmIZbW3xqT6+7SzzI7GR2nZQpirg2
	 jU0JnJy+VB2AYX9mJbYQ0UhU+8+Cypn/1pWKVZ9A0k/zWQT6tZMiqXePQWQnsHWz7q
	 0aR6E+4EdQCySp7Xs5jt1ccprxz/g+s6lQHVrTR7B8quaReexMNU/joui/qdquBaqR
	 4v7z39uvYexKj9wJpcNjjEEgAeDubURmzSeJ52Exs7K+UpSYfTpSpzPDboGuYljwyS
	 C7AgN+kbw0E5w==
Date: Mon, 23 Sep 2024 05:28:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: xiexiuqi@huawei.com, peterz@infradead.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 2/2] sched: Put task_group::idle under
 CONFIG_GROUP_SCHED_WEIGHT
Message-ID: <ZvGJAD0eJJ67OO6R@slm.duckdns.org>
References: <20240923135431.2440320-1-liaoyu15@huawei.com>
 <20240923135431.2440320-3-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923135431.2440320-3-liaoyu15@huawei.com>

Hello,

I applied the patch to sched_ext/for-6.12-fixes with some edits. There's no
strong reason to keep idle in that particular location and it's easier to
move it upward out of CONFIG_FAIR_GROUP_SCHED block.

Thanks.

------ 8< ------
From 7ebd84d627e40cb9fb12b338588e81b6cca371e3 Mon Sep 17 00:00:00 2001
From: Yu Liao <liaoyu15@huawei.com>
Date: Mon, 23 Sep 2024 21:54:31 +0800
Subject: [PATCH] sched: Put task_group::idle under CONFIG_GROUP_SCHED_WEIGHT

When build with CONFIG_GROUP_SCHED_WEIGHT && !CONFIG_FAIR_GROUP_SCHED,
the idle member is not defined:

kernel/sched/ext.c:3701:16: error: 'struct task_group' has no member named 'idle'
  3701 |         if (!tg->idle)
       |                ^~

Fix this by putting 'idle' under new CONFIG_GROUP_SCHED_WEIGHT.

tj: Move idle field upward to avoid breaking up CONFIG_FAIR_GROUP_SCHED block.

Fixes: e179e80c5d4f ("sched: Introduce CONFIG_GROUP_SCHED_WEIGHT")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409220859.UiCAoFOW-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/sched.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 91d14061fdca..b1c3588a8f00 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -432,16 +432,17 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
+	/* A positive value indicates that this is a SCHED_IDLE group. */
+	int			idle;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
-
-	/* A positive value indicates that this is a SCHED_IDLE group. */
-	int			idle;
-
 #ifdef	CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
-- 
2.46.0


