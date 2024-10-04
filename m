Return-Path: <linux-kernel+bounces-350303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C5990325
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACB71C218DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0483B1D4619;
	Fri,  4 Oct 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEHV+6j6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA11D415F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045464; cv=none; b=o59JFLcvA49JB/HmesWCQaG+Ur0gBw3VufmCYyw80TlynnQJzchx8XM+dCp3ePRA92FTi2Q0h42OlBnD/fuIr9XV09MWJ7y3pp591unxkOIdDUybye+hx92MhufYJZ6Xa4QXhVfbofpRYaYa9gkcl8kJj9X53LYeqS6uZWR3HBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045464; c=relaxed/simple;
	bh=y8AcVoWVD+54sJ+A2toFMeSvjuzIiqgPSmXvzXW7oyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=SlnOkrZiGd4MXunfRG2ijgtokpNvWHm5f8/L3wBoRfGbTZy8fp8yc1QNtz3nnvtaO/m0hY14tA7oXjwHKHWY6kCe6U5LK92JQSJK6F4AdZzQIJfIGQReArK0N57C37qVFlDWIPSZiqsltrdmJ6nEGRFuk491XNGFvSPtmwHoDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEHV+6j6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728045461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PVHODFCJStcGgS4z5ceFWY8UmrVfGMzO62w7g60kd7E=;
	b=hEHV+6j6WcH8sHLBeL9PaoHt48MS3cCOet8CfytKDDPN+gvk3MswXC8O8v+JgxeK+zV8FC
	HXOE2ZYEcy8OQLNgHLLEB3kq0nhP08Ni/Lo2AODYDFCJ7fIdd4hqakz4Z3n8Gg2Vk1isx3
	RJAZ/8QqRktDtmx8VPolmiUNNz9D/R0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-bjs2kgU6OoO4C1CIw5oIKQ-1; Fri,
 04 Oct 2024 08:37:35 -0400
X-MC-Unique: bjs2kgU6OoO4C1CIw5oIKQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07CFA194510E;
	Fri,  4 Oct 2024 12:37:33 +0000 (UTC)
Received: from pauld.com (unknown [10.22.32.131])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A147E195605F;
	Fri,  4 Oct 2024 12:37:30 +0000 (UTC)
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] sched/deadline: Use hrtick_enabled_dl() before start_hrtick_dl()
Date: Fri,  4 Oct 2024 08:37:29 -0400
Message-ID: <20241004123729.460668-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The deadline server code moved one of the start_hrtick_dl() calls
but dropped the dl specific hrtick_enabled check. This causes hrticks
to get armed even when sched_feat(HRTICK_DL) is false. Fix it.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ce93d0bf452..be1b917dc8ce 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2385,7 +2385,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 
 	deadline_queue_push_tasks(rq);
 
-	if (hrtick_enabled(rq))
+	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, &p->dl);
 }
 
-- 
2.46.1


