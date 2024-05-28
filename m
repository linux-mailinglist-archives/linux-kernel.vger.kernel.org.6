Return-Path: <linux-kernel+bounces-191823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DE8D14A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C881C21DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C856F08A;
	Tue, 28 May 2024 06:46:39 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9C9555027F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878799; cv=none; b=uhPCHNodm1gjLZ+Mkwx0dpaWOpShheYJU3XPbEOdvCJd/P24uTtxmZ126TOyoK5IxkX79qcEb5pfoJUJeJB50zCYj+4v6f/2gdmbM1+fsT6NPSQ9Z2fmy4GEsJ8hx/Y0LS7c3qB18GFRgklrMZbk3bHuSBERpom65AR9PD58Fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878799; c=relaxed/simple;
	bh=nMWPmJZVqC4aT0whXmkWZmkHWM8YxD+zyIjlp7n+mwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fEY0DSIigIoN6QD1efeFrGLMR89yGqpN9W0D891Gf2gXrZ6QtrXBb5WOAL5f5kzPhaBZCiYCc3HB6SLyn0YIH9TZ/0LLBm2jtJtQazZf3dqgz6guNTt8sNG+u/KulYpxrLs3ha8uUS9oPOG/UCzXKbwPGDgmuz1k5KysR8CxRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id D9564621BCF3F;
	Tue, 28 May 2024 14:46:09 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: kunyu <kunyu@nfschina.com>
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
	kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?sched:=20core:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20pending?=
Date: Tue, 28 May 2024 14:45:32 +0800
Message-Id: <20240528064532.42532-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pending is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: kunyu <kunyu@nfschina.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..e32fea8f5830 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2969,7 +2969,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	__releases(rq->lock)
 	__releases(p->pi_lock)
 {
-	struct set_affinity_pending my_pending = { }, *pending = NULL;
+	struct set_affinity_pending my_pending = { }, *pending;
 	bool stop_pending, complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
-- 
2.18.2


