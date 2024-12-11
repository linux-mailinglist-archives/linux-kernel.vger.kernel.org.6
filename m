Return-Path: <linux-kernel+bounces-441936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC939ED5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A34416AD73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E0255527;
	Wed, 11 Dec 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRjwyDSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA5254E9C;
	Wed, 11 Dec 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943250; cv=none; b=egFYLEvNSFAO4vTInziheaaAOdUwlXq5UmpDRAwLI25a/l+1DBW4RTobKnvO3udwKNhj4AyndXWNH3nUSfCYYRi9E/38MrUmh+o9tIsz6h81yXKetNO6KqZfnjilHqzbLg+fUg7XoNF6WXkuYhAXM/ixktpng49vml4BrcaKQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943250; c=relaxed/simple;
	bh=DVq9/0UC8vOHkJXORLyGEhtGTjAtJDQ/nabgP13wMvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8K9FhRzn4LEGA6PitAhpT+Q74RmqHQJrL6BZtJc8JQVKgi3zQODGWUCTOP8GDrwm4PaFiPmvtuA29SSTNpLypwH8+4fr2+ZcROGLGT6OgUTPdKgnoEtYqek5NpaI6fmLZh8zaPl+//EhcchwiPjgLu+faKQgZxji+PTeT+T2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRjwyDSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F09C4CED4;
	Wed, 11 Dec 2024 18:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943249;
	bh=DVq9/0UC8vOHkJXORLyGEhtGTjAtJDQ/nabgP13wMvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRjwyDSxbuynJqvPCqb3OFkH9/1dWiSeYxFflnfVIPw6gsAEbXDh4YkrExKXKsAQw
	 2KtUVHnxb75R7S8zlPmX21Z6GuAn/Ih2lNtBV86rE+55LeqdQ8oh/q/6E+qZ9yzrWT
	 K2JrdIzbA02LQwnCuvdq78G5uZxllDew/nG4foyXIcDr+h4KYWnWa0INLe1DeOW1lv
	 gleT7jAqmGc7qvOnxZP5QNEEfpffBOpryAvT/SvmTqPQ1cOYsyToyfIzHLHu5jxH1b
	 hzbdckdi/L3/ibL/fF7OCeRvGdAtUxeZ2pEDl85rBjLuWx/mZnX9U6fdvvLka7UNC+
	 pSKXfa9i4KFKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lion Ackermann <nnamrec@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/10] net: sched: fix ordering of qlen adjustment
Date: Wed, 11 Dec 2024 13:53:48 -0500
Message-ID: <20241211185355.3842902-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185355.3842902-1-sashal@kernel.org>
References: <20241211185355.3842902-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Lion Ackermann <nnamrec@gmail.com>

[ Upstream commit 5eb7de8cd58e73851cd37ff8d0666517d9926948 ]

Changes to sch->q.qlen around qdisc_tree_reduce_backlog() need to happen
_before_ a call to said function because otherwise it may fail to notify
parent qdiscs when the child is about to become empty.

Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cake.c  | 2 +-
 net/sched/sch_choke.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index c952e50d3f4f8..eeb418165755e 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1541,7 +1541,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1552,6 +1551,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 25d2daaa81227..f3805bee995bb 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -124,10 +124,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
 	if (idx == q->tail)
 		choke_zap_tail_holes(q);
 
+	--sch->q.qlen;
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 	qdisc_drop(skb, sch, to_free);
-	--sch->q.qlen;
 }
 
 struct choke_skb_cb {
-- 
2.43.0


