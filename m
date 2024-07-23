Return-Path: <linux-kernel+bounces-259973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17E93A0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE6A2837C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0AD152527;
	Tue, 23 Jul 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QK3ks9qY"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B326AD3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739507; cv=none; b=MLGsqC619wpZz4hwAQkxqTZYenJb0QpMw7kc+enw5A8FkoCRNy4mj51mE79QKr+ouddmoqwVRiTPQJXAP+8CQ2q1v6B1zTDI+SlPtSgZmlVEGQQDnBNqa5304qHlZG92/vKcqzohmp5A8J20nz8POfh0nLEaoeFP818M/BWMqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739507; c=relaxed/simple;
	bh=GkgzyLap7vbKK/2M61n5+NUkEkSTVPiSEk6iQHTmri8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rdt5HeIwTlb2Zz8Avcohv72AhUY0P4dWy7cMNXQ6cBJL4eVp07LyRD308CJQLJwdzMgs9zqceBT2AcNjKntKFi6TNteIQTCqp5PaylRuau16Ar3p0VgiPoNOBJtfbgBOcM8XzHCiz+oL1WWm9cGXjAxfdwmRUlTngDWJ2zaMp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QK3ks9qY; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9Jeb5
	e74J4dPt7FF4MpjSKrhHRkLkwzpjDHXDqU1Wdw=; b=QK3ks9qY2lBZGvCby/J5p
	CirDq0q4Kqjl9Z5TNTOs7QZoep+sJ1mYcXqMKzgy8LTuncoZn+RMp5/BLiq6uWhs
	HKonhPYagQzxwVKjac+5NYvnf/djVLFpTD/0hV/MQsiYYz3rTeRK43eE1c6OQa3X
	Rn6rk/uPTrE9NSzf2irdlI=
Received: from localhost.localdomain (unknown [113.247.46.246])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wC3bnzBo59mpGXsAA--.27660S2;
	Tue, 23 Jul 2024 20:36:18 +0800 (CST)
From: Bing Huang <huangbing775@126.com>
To: peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH] sched/fair: Remove sg_lb_stats forward declaration
Date: Tue, 23 Jul 2024 20:36:17 +0800
Message-Id: <20240723123617.3493-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3bnzBo59mpGXsAA--.27660S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxtr18urW8Zw1Uur47XFb_yoWxArg_Cw
	4kCws3Kayjyr1Y9a93C3yIqryrta48Ka40kwnFvrW8A34qvr93Jr95CF1fCr9xWrn7Gan8
	JrnxWF1vvr10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU9NVPUUUUU==
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbi6AQlr2VLcn0UkAAAsD

From: Bing Huang <huangbing@kylinos.cn>

struct sg_lb_stats has already been declared previously,
so there is no need for a forward declaration

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..5a94769f1f2d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10203,9 +10203,6 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-
-struct sg_lb_stats;
-
 /*
  * task_running_on_cpu - return 1 if @p is running on @cpu.
  */
-- 
2.25.1


