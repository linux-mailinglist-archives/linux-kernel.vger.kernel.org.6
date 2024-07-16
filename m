Return-Path: <linux-kernel+bounces-254008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741C932A17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA18DB22ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774219DF8C;
	Tue, 16 Jul 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kuCPAYbD"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F519AD42
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142529; cv=none; b=UdMf03MbvHNt4CDoGTAjHr0WcH4hTB/mlfGUIg8AE1FtR+p0u8Qj67i/WNXSt/MEyMtbHD63ngC11thnsTUcIThN+x0BvEAjGkeVKJxK+4WCL7rx5fHjFGMDeNlVegWrAwyJ1hmk3jynDH+c+by0f2JDGEvrqrErG/l5L1nn2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142529; c=relaxed/simple;
	bh=8Q4oCgLQ21WO2XK/l0u/nttyqPSocknCJ1kMHMZeBVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNZgcuZM9jsF30rjSP5PntRIO9FZz3k2a1JDYTCtCb3E4jCJuLug5/6Gszw2q9j6ePN8zrZeCAE5hrmnpFW1tm5TVf0E8cqSs/WIBx/V4oFGTqCzAAChNPlgFxLqcaj+g13W0myXugDlfZLdhBd77CpXYVd9o37odOIwdGA5ZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kuCPAYbD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b09cb7776so3960718b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721142527; x=1721747327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WsXnPsLLtsLIcKG1uh0IO6zgfJEzcruUB4mcehmXHDQ=;
        b=kuCPAYbDdq9i7PraYnwUt10/dYNHPr0TXoNjWsswxu5JuC1qyPN5BvZN1K1MbKIKX4
         ScnStWKa8AodCvmdxOjsY7V/O+6Jce4gwJa75Rq6aaptAsu7z8aXFbcc9wm5Ase1HW4+
         IGxHo+etOQCWurECO65dWQOCDgO5MEaAM83GVB1EZzAG1f/AKZb8lR+oQwtBI0MaWv8O
         E1rFj4jfion97p1fPCD8mNyopuBYTPdkrhh9uZVw2xppoR8niZIJ6KJybWx9oicLyALd
         AnSb1nfRAfVfbQ6o2ADk0cwbk4xc7rr6fybYtzpr+L/sontEgx9kZKrq3ZdiH/4bBHTk
         wRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142527; x=1721747327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsXnPsLLtsLIcKG1uh0IO6zgfJEzcruUB4mcehmXHDQ=;
        b=QwV5tEa8a9Gke7XVZyFNLDrSgAiijOtALVunskZBlEF3JbwERCtNgv9H5Osb6jGBjA
         t0oC7NTtjf8PiihGlnnFBpZ4iaOPcYH4Frj5E1P4E4FRUzyW0p7q9eGJ8OVN6C4AiAV4
         x9GQmCq9J9cM5oKpvULH35MKq3Fb8MspD952fXxKGO2YnlA+0jemIGL3jQ5J+WmA1Xkj
         tIFDjZkA/tRcj/ovTLdHQKNbR7Ysxa/67wscIxGzSmHXi86TDRGEWdRCFPCcMacE6iN+
         0O4pHUUFF0E3Xwnsq0eKWXkDB2Wqlg8w8V9oUnv1wgoPUj1XNsVEK56J5hwYvY9vMJwP
         ymQA==
X-Forwarded-Encrypted: i=1; AJvYcCXnEYAA8TEW9dHQKgdPtIk3e3Eb3JVJ6Lr2XR6vYweEkuCYbVkceprXyD3Ii//ZfSjUd/wtudx7ftIX6pZocBUqVuKRYcR0/z//kC4M
X-Gm-Message-State: AOJu0YwEjU9ddbnngc+Tfgjxqb0xDcQrghC4eBCC1gN/qsEpXeYd3KDD
	EWgWp4sqNTYT2hv6XMfi49vgWE/IqTH+7wevpSIBFRS8m5yJVuOuFB8/Bh7qeVA=
X-Google-Smtp-Source: AGHT+IEGlIz86RY46W8Xzx0y31KFME7zlz9iORRR3ry/LMiW3gPWiW0v1v4UTylaAn+zky+yZB98ew==
X-Received: by 2002:a05:6a21:2d04:b0:1c2:8f07:579e with SMTP id adf61e73a8af0-1c3f12a056fmr2301657637.52.1721142527415;
        Tue, 16 Jul 2024 08:08:47 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb65bbsm6461113b3a.47.2024.07.16.08.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:08:47 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH] sched/fair: Sync se's load_avg with cfs_rq in reweight_entity
Date: Tue, 16 Jul 2024 23:08:40 +0800
Message-Id: <20240716150840.23061-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reweight_entity(), if !se->on_rq (e.g. when we are reweighting a
sleeping task), we should sync the load_avg of se to cfs_rq before calling
dequeue_load_avg(). Otherwise, the load_avg of this se can be inaccurate.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..2807f6e72ad1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3782,6 +3782,8 @@ static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
 	se->deadline = avruntime + vslice;
 }
 
+static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
+
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
@@ -3795,7 +3797,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
+	} else {
+		/* Sync with the cfs_rq before removing our load_avg */
+		update_load_avg(cfs_rq, se, 0);
 	}
+
 	dequeue_load_avg(cfs_rq, se);
 
 	if (se->on_rq) {
-- 
2.20.1


