Return-Path: <linux-kernel+bounces-270614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D694421B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A92283BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5D13D63A;
	Thu,  1 Aug 2024 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hoYWaL5e"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD0136E3E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484759; cv=none; b=lRt4HG1h/ezg/M1xlS7uThYhps49GYKnfRvAxBP29hGZ56kzUyWbUU00YDqJoTpi0OSBoYyTQrUfiSH6FtfZhYtUn7iunCRHmQ8jLKplOkrWok+czDUsY7aGuaS3XU9ox2MYVqMafwlO87Zo6Qj7uuEstJfpN+GvAU0lTWaObJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484759; c=relaxed/simple;
	bh=hTW7/qaGaSx8Jr6wZx1L/SQr2TqooH2RhG2KstErLdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OveMTdivYMf843iidg3yfdKfuYbUF2rCj1zMukzwK/SbHRCVsgfPe7KdA63LZVUnlm5IXEzgZVCumyTxAQ0LvDR+LLjSmeoNILhZQWObh3InP1aPpmenIb9hYcYN+L17UnvPPrVCq/kFGNFK/k2eD2Xx3YObCY5nG3OmhftscYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hoYWaL5e; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a1d48e0a5fso3835685a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722484756; x=1723089556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlFsn6l+3Fw1Z+6xexOiYMZvAqIxw3ZeiJB/ncw02d8=;
        b=hoYWaL5es81WLP7XG9GcARfukmriNnSKO4NHku+IG65tb7Q3NDab1A/oJ3hQp56wEd
         d7X+3YgAMtrDWH24Cs0bgC7w3gbvMSwocZmygXLcYwhKREsIOapGeVxBycadqXnqlu0C
         tq6pKH/BIVJZcM03TvX8OhaGpnu+FRhfGWSB4VVgQ0pQr4VjZC0r1QIAf8OPIvGJO1XF
         DWQQguhbB7k8R6pGCTozWBB6ARA8wYd6Eum5Sqvm70Y8/XAnV/2KpDpCOWWfW7THGdee
         x6Gcc+sQfb4bJh+Vsdj+4jTBrWqUljhgBsVPJT1RjjZ7WoP9xWlCxSY7e4wPre83vPgA
         FBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722484756; x=1723089556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlFsn6l+3Fw1Z+6xexOiYMZvAqIxw3ZeiJB/ncw02d8=;
        b=OH1BOQHHLXBfaPNXuEjAn1Trz5T/ePULviJoCadIWrcgpZav+LF6A2hIDbtn/bnHkg
         JrmGzmLeDcI+ue3sUvROQ+o/fA46yr1weWWLhIRejGg2rooF9EJUvQxusTngTzdL3cdu
         JC1PcpTegO8RjeYFLtO2GTbQrrrV11KiHkEr1HXD1ArPDrbxH5kweMmAc+oAedju8T2f
         eqzTBl/6Mzp5VfGyMJT3eySQvNsh+0eAUObz9FM+beDPyejNwC3jnrnvWlqsZYPMF6MD
         rbTYYUUVi5caI9Roml15fwqtgi54RM43pa4hkehELJwJIq0G56UQNQwckb6J0ToSj+89
         DIBg==
X-Gm-Message-State: AOJu0Yy0NGmc2Hkm95/0HUWNH7so+UY9vi+oJHVRndyx2pst4MWWbjGa
	xMjs5JACZ2D/KpRXsGmUEa43339spymKrsJdKUT2Y4MkZXrBUsMXwI+QZwDSVTo=
X-Google-Smtp-Source: AGHT+IFVwI4lrdMlXNtQoIhzQyIzVNXkP9XqiMecRTWO6wxITB54/wCZujw8XUU2e3ywar1nkq8Rbw==
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:19d0:4a0e with SMTP id adf61e73a8af0-1c68cec8fbbmr1537314637.14.1722484756346;
        Wed, 31 Jul 2024 20:59:16 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf7d0sm2162273a91.45.2024.07.31.20.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 20:59:16 -0700 (PDT)
From: Hao Jia <jiahao.os@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] sched/eevdf: Fixed se->deadline possibly being refilled twice in yield_task_fair()
Date: Thu,  1 Aug 2024 11:59:06 +0800
Message-Id: <20240801035906.72603-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We call update_deadline() in yield_task_fair(), if se->deadline has been
refilled in update_deadline(). We should avoid filling se->deadline again
in yield_task_fair().

Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 795ceef5e7e1..b0949e670bc4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8695,6 +8695,7 @@ static void yield_task_fair(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
+	u64 deadline_snap = se->deadline;
 
 	/*
 	 * Are we the only task in the tree?
@@ -8716,6 +8717,14 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);
 
+	/*
+	 * If se->deadline has been refilled in
+	 * update_curr()->update_deadline(),
+	 * skip updating again.
+	 */
+	if (READ_ONCE(se->deadline) != deadline_snap)
+		return;
+
 	se->deadline += calc_delta_fair(se->slice, se);
 }
 
-- 
2.20.1


