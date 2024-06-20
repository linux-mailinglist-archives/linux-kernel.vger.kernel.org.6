Return-Path: <linux-kernel+bounces-223582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC9911518
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159BFB22630
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237106BB39;
	Thu, 20 Jun 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVrOSlAn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2B757E3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919906; cv=none; b=X8UG4Y0wO5aJEqwf12mpMbIfMuXZC89nJ+xXQ5GKZjdRhhgJEiiD44Oveau/+ubTe0WzDAp5BgU5JZU69iQZfa14dfMZevYjIT6BkcL7GR24aK3ZGjAWQIDxzIePPz4BR0PDdMWVeiJcsjne8KDoSuqY63XQT4gSxPAtsj4Dl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919906; c=relaxed/simple;
	bh=GmvUuqKbb7n43OslbzGKvvAa1mkypfI2dR+ymYYwPmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YdsiK5ZblK1zhhG7pZ6hf/thIM/e5488Ifc4Qvyki963iiZ+0wReD/FvwfM83itcg8c06HsV13HKkq47FFaAmuMiqj853wLc+uPJK7wDXrf5XWUleyAYfyJ8lRLCcGzflKcvIPQUSPbKt9FAL91ptY4krwk61i7OKd4gW/Ksx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVrOSlAn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02bb41247dso2223902276.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718919904; x=1719524704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vxhudjPJnYDE4Edy4y7qeVeY3wlFSWRlFOEzVjiQdnM=;
        b=mVrOSlAn64CNT4o0a5lop8xJu3mjp85F+h47dEppWETckwUSjIcOUOCnTobKj31E0c
         ZB6kq9Gdw4eI0VrKvYDRLdI05Bo4MSwl6e5KmrMaDXM2RqMefQi8r1JmPm5S9x6ThuXk
         c6wjL8XAQ7DGjb32U5F2ZNe+SufB3fKibFU+goMpf+i4a85fQhBNNiP3rawJDa6lSJI7
         j33AwjasO9fC8xQnDv/u4uDr0X1TKn/5EpJ4He62VFyN8Q3v0Vwq7Iay5y9T+FHj1o3K
         E193DNzb5AxzbmKgq0dfuPaqv4sM6MNRAou+VuY4jB6YIkzI1Zrjoj7nwnyaLIo/5dXt
         yAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919904; x=1719524704;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxhudjPJnYDE4Edy4y7qeVeY3wlFSWRlFOEzVjiQdnM=;
        b=hmVfAMQl/5WWn8OubihefraTPHbYctMz2Dh7InnxJ6vVwOrZeC63dIBXNk4QYWHx04
         +VQZ3agEBMFbxBTKInkJLCilzwo57uc8moz4inoxgVvOa2xCx/hjHxS9xX9low2wMavj
         kwDWe7IFZ3Gyzq0Q7ZPcWGR9IdO0ZTJ3bVceFeZ1la6N+PlNJWDyipc5oUmAPg8Ja9HD
         2wN1u1xi4L3haYYxvkssL4qGyee8ASl/uBRLvsa0eY2lVLO+aO/9XVr6PnzBdbR1wXXH
         XqAYM+YsILGkO81ktBuJTlDyb1+W7igkVzE+7KLyI2VCxd7OyPmdozlhbZMOye14Y6LQ
         X5rA==
X-Forwarded-Encrypted: i=1; AJvYcCVDhotYmxK+MODTY/ToF/qV00Zl+sxxTt+X0Ir+4UaiVFrJPC5zHcH8yBNRMl4ZmrlaILivPEWUmL7q2a41YNtWq112CRTnrygD++xY
X-Gm-Message-State: AOJu0YxmdwFDyd5SU++E9PcBogrbeUlUnIw70p044AgNAY5SqKNDjTsr
	Zp/meGg2n3Y36YfTnLTCWHkW5qCHkZfUmKVkuiWOvc5PnstIcTt/7MTnd24/J4YWfJouvhJiUl0
	xbynCbQ==
X-Google-Smtp-Source: AGHT+IF23ImrQXZpJej2WBWcjkqPvgV/dCDTXUK8W5Z/Hgn+QBhA5rR2sN+Oswny2hRKQgcoO2DsV0l1p1wi
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:602a:9113:ce4e:4683])
 (user=joshdon job=sendgmr) by 2002:a05:6902:154b:b0:dda:d7cf:5c2c with SMTP
 id 3f1490d57ef6-e02be23cf86mr554207276.13.1718919903874; Thu, 20 Jun 2024
 14:45:03 -0700 (PDT)
Date: Thu, 20 Jun 2024 14:44:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620214450.316280-1-joshdon@google.com>
Subject: [PATCH] Revert "sched/fair: Make sure to try to detach at least one
 movable task"
From: Josh Don <joshdon@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit b0defa7ae03ecf91b8bfd10ede430cff12fcbd06.

b0defa7ae03ec changed the load balancing logic to ignore env.max_loop if
all tasks examined to that point were pinned. The goal of the patch was
to make it more likely to be able to detach a task buried in a long list
of pinned tasks. However, this has the unfortunate side effect of
creating an O(n) iteration in detach_tasks(), as we now must fully
iterate every task on a cpu if all or most are pinned. Since this load
balance code is done with rq lock held, and often in softirq context, it
is very easy to trigger hard lockups. We observed such hard lockups with
a user who affined O(10k) threads to a single cpu.

When I discussed this with Vincent he initially suggested that we keep
the limit on the number of tasks to detach, but increase the number of
tasks we can search. However, after some back and forth on the mailing
list, he recommended we instead revert the original patch, as it seems
likely no one was actually getting hit by the original issue.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 34fe6e9490c2..a5416798702b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9043,12 +9043,8 @@ static int detach_tasks(struct lb_env *env)
 			break;
 
 		env->loop++;
-		/*
-		 * We've more or less seen every task there is, call it quits
-		 * unless we haven't found any movable task yet.
-		 */
-		if (env->loop > env->loop_max &&
-		    !(env->flags & LBF_ALL_PINNED))
+		/* We've more or less seen every task there is, call it quits */
+		if (env->loop > env->loop_max)
 			break;
 
 		/* take a breather every nr_migrate tasks */
@@ -11328,9 +11324,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &= ~LBF_NEED_BREAK;
-			/* Stop if we tried all running tasks */
-			if (env.loop < busiest->nr_running)
-				goto more_balance;
+			goto more_balance;
 		}
 
 		/*
-- 
2.45.2.741.gdbec12cfda-goog


