Return-Path: <linux-kernel+bounces-243114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02BD9291F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A1E2830E9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594FF41A94;
	Sat,  6 Jul 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LrSKh/cd"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2185918B1A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720255003; cv=none; b=Isc4ySIm5hGILVDwIZSYwxjq8YwoRAUv0QFz8yKyOGdkjK4cT2BS9oPOAudyT736qiiQxvaHYUDsRDc7vd4t933BwiZ/qRp1153UxIQLrcpeW5f8luexzkcN1aG7xDmP9ZF6OvdzAO5x9iBchnWFBCwtnsiBtJJKrfEfasLtt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720255003; c=relaxed/simple;
	bh=GkgzyLap7vbKK/2M61n5+NUkEkSTVPiSEk6iQHTmri8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfVL5RCOSM2pWDiTuyRktRV9DMfmSgDMEoEkF4DsaB8k9zbFQjyyo1PbfVQR3nukoOjNyLxV/Fwx8JSQmxIg8+h6gsjgub21TFhHBIIDw8Z60YGuQQFBmt4wzIZeEnIHbYkSclW3wOyp+SCu5onS24kU0Kxj0gYbz0bZRaCNhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LrSKh/cd; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9Jeb5
	e74J4dPt7FF4MpjSKrhHRkLkwzpjDHXDqU1Wdw=; b=LrSKh/cdtMTrDXV6IDB84
	g+HOEmBlM2cqWAeFdKG7f11owI7Wz3tocnPvjgksSDWO1EpI0GmOQiI+2hLqxHGK
	JLH3np13oNX4oCUaqo7Ib2N3Ee/NyQkah2FuVdC5Ds7OLRn1gr2fwslWRzhgGGWY
	XAt1NcIcfJpSJay/a9O6vw=
Received: from localhost.localdomain (unknown [113.247.47.60])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDHbVncAYlmssblAQ--.24631S2;
	Sat, 06 Jul 2024 16:35:41 +0800 (CST)
From: Bing Huang <huangbing775@126.com>
To: vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCH] sched/fair: Remove sg_lb_stats forward declaration
Date: Sat,  6 Jul 2024 16:35:40 +0800
Message-Id: <20240706083540.47420-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHbVncAYlmssblAQ--.24631S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxtr18urW8Zw1Uur47XFb_yoWxArg_Cw
	4kCws3Kayjyr1Y9a93C3yIqryrta48Ka40kwnFvrW8A34qvr93Jr95CF1fCr9xWrn7Gan8
	JrnxWF1vvr10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU9mR5UUUUU==
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbi6B8Ur2VLcPyB-wAAsQ

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


