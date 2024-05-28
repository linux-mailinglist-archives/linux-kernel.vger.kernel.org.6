Return-Path: <linux-kernel+bounces-192231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152978D1A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A931C21BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298BD16C870;
	Tue, 28 May 2024 11:54:57 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 88EDB4C97
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897296; cv=none; b=RS3Ypr4b8TZj2CP96HolLDc7kw14+AKQPZQBfwZA9OUJIqXyTjvte7otPoFAyjq95HRasSRJiH3RR0joyED1YniZEAZB6y8AkjaL73wAxnzu7sbuvH19HiZFP98v5mn2HKjNfgXeRYpbFeAJF8Skv6BqKumG7XbmzQ7sdRAbEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897296; c=relaxed/simple;
	bh=LAMUPsKyPx2PdNYmlXTdAZ78b607CXWP43w8PfKewtI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sokWy+g/rCsFX2zMa0AqoPjwySn0L1Uam3FkfTWNU090lAoMuggS/ZvGhQhPTOe3Fcbfve7h+AE6BDZ59s6b3lVjGta3pQHPty+BlLuQ4qJzJajx/7n3mJ1lE8jZpddCS95qPN4AdKJpVepPh7E0JSe43hy0qnMXH9DhCeKvQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 73DD8604FEB94;
	Tue, 28 May 2024 19:54:42 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] sched: core: quota and parent_quota can be uninitialized and assigned values
Date: Tue, 28 May 2024 19:53:50 +0800
Message-Id: <20240528115350.1927-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

quota and parent_quota are first assigned values, so their use is not
affected.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 140e6373fce2..faa5dcffd2b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11039,7 +11039,7 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
 {
 	struct cfs_schedulable_data *d = data;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-	s64 quota = 0, parent_quota = -1;
+	s64 quota, parent_quota;
 
 	if (!tg->parent) {
 		quota = RUNTIME_INF;
-- 
2.18.2


