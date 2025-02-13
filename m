Return-Path: <linux-kernel+bounces-512576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E312A33AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422C33A6D59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0999620DD42;
	Thu, 13 Feb 2025 09:16:29 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656C20D4FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438188; cv=none; b=qd9i9QeBEI0am1ujZ0/BS/W5/ihZITCjwezMOEjxrLMZdU8LDOqQPBBqNfKwoXE2G34DECeDjJ+8h37zpj3u7PsXf90l+FpY+7ixyayrWLk9Zz4fReqcPpN8EJLHnVqj+dX4nhICNqgYus9Pbu2BYYYzPdhjyZ14Ubh3lGFjpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438188; c=relaxed/simple;
	bh=cMHDtDnatGx8NsJ+MRpY90M7aAPc2RuqrfU1Ql40cw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPvYwroQdSUrR+xE8Hgqh6/tnsD4Wd3umXBWdfXflAVupIFqHfv0rTF1lsJkM943/H4Q0tnQArxB3bS22xrt+u7g6i0Z/YWRwBsKcgrlEvrzFIXCb/HxfzJE0cZxIUQtUFPdGHb9niqwzc9oYtUZASgQdiRnxn2AhsD4HFk5yhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51D9G28O078123;
	Thu, 13 Feb 2025 17:16:02 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YtqF44zF3z2PFSxC;
	Thu, 13 Feb 2025 17:11:52 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 13 Feb 2025 17:15:59 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>, <qyousef@layalina.io>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] sched/uclamp: Add uclamp_is_used() check before enable it
Date: Thu, 13 Feb 2025 17:15:54 +0800
Message-ID: <20250213091554.2593-2-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213091554.2593-1-xuewen.yan@unisoc.com>
References: <20250213091554.2593-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 51D9G28O078123

Because the static_branch_enable() would get the cpus_read_lock(),
and sometimes users may frequently set the uclamp value of tasks,
and the uclamp_validate() would call the static_branch_enable()
frequently, so add the uclamp_is_used() check to prevent calling
the cpus_read_lock() frequently.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/syscalls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 456d339be98f..d718fddadb03 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -368,7 +368,8 @@ static int uclamp_validate(struct task_struct *p,
 	 * blocking operation which obviously cannot be done while holding
 	 * scheduler locks.
 	 */
-	static_branch_enable(&sched_uclamp_used);
+	if (!uclamp_is_used())
+		static_branch_enable(&sched_uclamp_used);
 
 	return 0;
 }
-- 
2.25.1


