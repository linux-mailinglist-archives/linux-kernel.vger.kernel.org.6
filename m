Return-Path: <linux-kernel+bounces-284876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC768950655
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B43B26D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF719CD02;
	Tue, 13 Aug 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="i9URXlIr"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02819B3C4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555185; cv=none; b=fx3M4/RP7VkR8VJPfn3qdQqF022UfbcE9DI+HxDAroh2qXYWhAz5xmLbpdpu3AtaHhluIY2IMyAMM4xT0qiugX5QI2CJKygG8my3ddESpmLyxnWlR7DyJOhTGRJ0YxqfDtoF4JMbFVelCIRck4fK0J5fbzRABqH4i4hLhGfnvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555185; c=relaxed/simple;
	bh=GkgzyLap7vbKK/2M61n5+NUkEkSTVPiSEk6iQHTmri8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BkrBNBDqDeq+Td2ONJfYCzxj3ftoQ+knlsqlbTniMIMJ+Mma3COqMLJt8BrRLTR6MoIjWepl6NFUVxLfypOA14ZtmxlyWanq59qutELE9ix6jeDCiWwO7L8hMX5cD8eA+NFsNBB/NCCK1PdRPIGA9ZhLKjyA+qIFMAng/ZIV/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=i9URXlIr; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9Jeb5
	e74J4dPt7FF4MpjSKrhHRkLkwzpjDHXDqU1Wdw=; b=i9URXlIrEIINggtx8oRmf
	l0mPkPo/ke7uB1DEGHjvNK2nA00d4mvc6vliRhuIeAnuEDVO3/GmKmAtazKAeoaB
	b3UzR9ekUHMxbxN5S37ns6OOanTbvCB9DEH8YHTmnTgS3PYWLSdUo/pcpCbzjNlt
	3G/U63eTy+XvVGnv8XuS5Q=
Received: from localhost.localdomain (unknown [113.246.65.153])
	by gzsmtp5 (Coremail) with SMTP id qSkvCgC3TgMgXbtmXgThAA--.17606S2;
	Tue, 13 Aug 2024 21:18:25 +0800 (CST)
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
Subject: [PATCH RESEND] sched/fair: Remove sg_lb_stats forward declaration
Date: Tue, 13 Aug 2024 21:18:24 +0800
Message-Id: <20240813131824.2680-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qSkvCgC3TgMgXbtmXgThAA--.17606S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxtr18urW8Zw1Uur47XFb_yoWxArg_Cw
	4kCws3Kayjyr1Y9a93C3yIqryrta48Ka40kwnFvrW8A34qvr93Jr95CF1fCr9xWrn7Gan8
	JrnxWF1vvr10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUULSdPUUUUU==
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbiEBg5r2VLdCXq6QABsj

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


