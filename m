Return-Path: <linux-kernel+bounces-264093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F051093DEF4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB5C1F222D5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC16A8BE;
	Sat, 27 Jul 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CP6M7lko"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA44D8BE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078146; cv=none; b=PrxXFCk/QN627oYJ9pep5TQZI+jXU1FB1WA/tyODzR2n5m3dEHdmyzRwVd+Ipq7Ebgg7Y8t6bulFIUFw7InMsqfKWYZdPrxmFu4pA7GXYkbkXa9ZbRyWf6xVusYthvTEIyEEcrDUxt1zo6PWoZYF1/Y6y362DWEZTO3yMJk21zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078146; c=relaxed/simple;
	bh=CWC6phhl27QKUKHcX+u+q0hZxqkvNID08qRp3b7ns/I=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mKOstguacygqr/2urakHEzlHOYy1XY6kIqr4HctcCH2DCIF/Y+7YGkWENG5hAgg23owtExMwkuYERXm/VHuC9f94xxhTCN6sXe8VOQVel1WMUU5/mPiI8QJzxsbkrzj2IeLWPs8px57XlEX+L9renMo+R56IcZzBYsvUeYlz7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CP6M7lko; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=sIXjnXscTLqsdcYQkDS8hUjtkuTzHJom0pcE5upcMWY=; b=CP6M7lko/4bQZG+rbAPTFJ1wUV
	ksqa5/GAZc8EWISmn0JD5FPrVntKcf/kXxmirLDaF4ZalGtxL5K6stGJiEo7GhQSIaQLP8uV52bWu
	JDVkukfbTVu0AcjHL2vqFPfa3ZaFyXXC7jE2uYjDB+uijf0MQTAF6VA9ZI6FhWVZfw1c0EySUT9hq
	xuVGWYYIds3qhWxWKv6YLsZW5YsNfVFrVnUIstqEYZPmRChyFCTT5y15O4SnIcsj/SJnqLXluAL4E
	32gjXVbonsu0ooRJUaEM5rs3ZOnWA2v9EM1uhWgqMbsPmncBYhbdjTr1XTmPnVupyCU6ymsDUPzz2
	/Dy6teNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBf-00000004QMa-2QTA;
	Sat, 27 Jul 2024 11:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 96FD330088D; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105028.501679876@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 03/24] sched/fair: Cleanup pick_task_fair() vs throttle
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Per 54d27365cae8 ("sched/fair: Prevent throttling in early
pick_next_task_fair()") the reason check_cfs_rq_runtime() is under the
'if (curr)' check is to ensure the (downward) traversal does not
result in an empty cfs_rq.

But then the pick_task_fair() 'copy' of all this made it restart the
traversal anyway, so that seems to solve the issue too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
---
 kernel/sched/fair.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8435,11 +8435,11 @@ static struct task_struct *pick_task_fai
 				update_curr(cfs_rq);
 			else
 				curr = NULL;
-
-			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
-				goto again;
 		}
 
+		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+			goto again;
+
 		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);



