Return-Path: <linux-kernel+bounces-545637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236AA4EF7A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467AF7A85C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF92777F4;
	Tue,  4 Mar 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvC2870b"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE551FCFCE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124435; cv=none; b=Z/PflaFq4hnbR1R73xRaPYceiSgKuDZpJTv0x41140Ooca0gjOfkEC4Ed0dsL5nfoXlR512oFgVpl/w5Hu+Q33F5Rwlg4ThMcNKFIGWvsskNClmo5eGMBMJX69dSQZ4r0hdK9BZbmkXu/QRj4mjdp4fWZnK6z5tR1aRSOo0AiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124435; c=relaxed/simple;
	bh=yMVc03CiFIe63aIIGzoNIlRXnzJld9erR9/9N+KScOc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LFW5bDjEd7G2oqShU0a6nMCZ/y4Ai8Sn3ggCaVvaB8wYr74UJq6I+e+wZVKM41r4ZCTfan2KIaw2BK9xuj8r3VF8E94I0lHjGY6gHhMeGaP7MaCq8Qx7tqXxIWmZNZLNdt8s6JF0pTGYq7nJIK11FveUBM53GagozTMknNabX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvC2870b; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c0a3568f4eso689941285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 13:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741124433; x=1741729233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y3Km4ffsrY7Diu2crSx1d4N0oe7gpAjwafmNybMUZgc=;
        b=VvC2870bgBeMnuyt/xuFfaQoKz+QWKzc+44I3k7HkyYiPxKtSsUl4j+BiH5n7BJ9GC
         n/ycJaTGHSrsmM8kicu812T+n4m+Eh+lvc/ArzqZRfMC7lbjpURfTpYE+F3RrO8NkPuF
         2Zu9aUdNs+UqUj9JmtyI+Ac31R5byxkrlbA1bH+MWtKgOWwnXopeEg58YxK0yTVTHt96
         o0x68HSsa0rBLOURctrgFMnFuqMMk+geTPugqca2HeDgtz15pibyaTF5zVL+2X1Dftdk
         tn3feg3A46tPYP7CJwWFsfgJzCqopEOgA+PpHlYSJqVBjBa+zG/000HARNBWyZ9vpXhV
         cxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124433; x=1741729233;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3Km4ffsrY7Diu2crSx1d4N0oe7gpAjwafmNybMUZgc=;
        b=CS4gsSZjQI1ZCm8n++QyNrPd/Igm1a/e3XFC+RtSQq1aqkQoGILpz3H448nGwcpYdb
         72h/tk7xifEdWePsCE5zjIALBDmB6feXl7+ZWr6xIRfoYYd1mBtNdWaJx4ZBo9RkSKH0
         ZTSmmQre7UDa2f7qtZT+VffKtqDOwqZruFLEWRgmRJ87Z0rltVsM0ybXVAHNaxnjUbVH
         jvPgR3k/ox1wt723vRM+ouZKZiMGHlnGWTFj6ZQYGorc2RHU115q8CQ8goBFjyh6QTGY
         INYfAITvHeFY2VdYOnyPqil/jp/aDsT55GIAtjxJfdVb0oB7nifww59mT+jj+Q2zQnuw
         hPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoZ4wTQmgcRgHaBMwHi86ySU0CSqtytr2bK9vaSJ3TKNJ+XEOUCY51/RV922XifW2xZP4F71MIGvPnPZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGjZTCb0EO4g4TFcKJUvTM0uMTLM9MSbAjYSXI3pKfnFWOV1q
	zJzxCtkJLCEfq3V6vhIg8DkQgOqd9q6ChiLRpIWLkkU30+VyF75+UXOF2KpgcWZVBjx2uISDXZp
	kC4JHag==
X-Google-Smtp-Source: AGHT+IHg+rNumrTbBj3/RSldd2K7p42fYL3Ul9QwVcltGLIJdffnwHo3ZEudeodZ5gouoH9ETTlNVHehpo/6
X-Received: from qknpb23.prod.google.com ([2002:a05:620a:8397:b0:7c3:d9b1:8227])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2625:b0:7c3:d63d:7bcd
 with SMTP id af79cd13be357-7c3d8e46660mr136259585a.41.1741124433219; Tue, 04
 Mar 2025 13:40:33 -0800 (PST)
Date: Tue,  4 Mar 2025 21:40:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304214031.2882646-1-zecheng@google.com>
Subject: [PATCH] sched/fair: Fix potential memory corruption in child_cfs_rq_on_list
From: Zecheng Li <zecheng@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

child_cfs_rq_on_list attempts to convert a 'prev' pointer to a cfs_rq.
This 'prev' pointer can originate from struct rq's leaf_cfs_rq_list,
making the conversion invalid and potentially leading to memory
corruption. Depending on the relative positions of leaf_cfs_rq_list and
the task group (tg) pointer within the struct, this can cause a memory
fault or access garbage data.

The issue arises in list_add_leaf_cfs_rq, where both
cfs_rq->leaf_cfs_rq_list and rq->leaf_cfs_rq_list are added to the same
leaf list. Also, rq->tmp_alone_branch can be set to rq->leaf_cfs_rq_list.

This adds a check `if (prev == &rq->leaf_cfs_rq_list)` after the main
conditional in child_cfs_rq_on_list. This ensures that the container_of
operation will convert a correct cfs_rq struct.

This check is sufficient because only cfs_rqs on the same CPU are added
to the list, so verifying the 'prev' pointer against the current rq's list
head is enough.

Fixes a potential memory corruption issue that due to current struct
layout might not be manifesting as a crash but could lead to unpredictable
behavior when the layout changes.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 857808da23d8..9dafb374d76d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4061,15 +4061,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
+	if (prev == &rq->leaf_cfs_rq_list)
+		return false;
+
 	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);

base-commit: 7ab02bd36eb444654183ad6c5b15211ddfa32a8f
-- 
2.48.1


