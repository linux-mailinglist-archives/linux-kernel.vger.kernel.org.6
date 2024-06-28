Return-Path: <linux-kernel+bounces-233350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C291B5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8147B1C2272A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C528DBC;
	Fri, 28 Jun 2024 05:06:03 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE48182
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719551162; cv=none; b=L/Vw6bTUbb7UHMOalSauCDwgKQ6AgqPZD+z0bbpb4m3c4Sfkkv7K+f+lk10qVDHwYdF6s+V1cfU+3hEDLDeXCpbFEO6w7RrDj4Rd6mYJfmeyzRZZC7+soNASHM1U15/oRRpfd8tnd0rEYYCqD/BiVuI7MEXXn2WRs+omRr69lN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719551162; c=relaxed/simple;
	bh=O6odAaLU4M0s/Y2oJk3d4HUD5kB9CphNXGI7MtaBKD8=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=K3cbGOA2h0L8PgqhSaeNfn7K7PtjwwuJ9tZFX5Bj/VU2Uq4FR0gjtG8Gzvi78itVYJXeZMtO77DjfZTIzZzQJS1uInhF0EXCHR1R3Un53HGrjOgz4jyN5XbQbxw2iJiqsjb6znNTeDmvzivgEoa/Fzzn21zjsDu8A1xEJ4BvvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4W9NWp3kvhzKjS
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:59:18 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4W9NWg4zzQzBRHKQ
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:59:11 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4W9NWV0HDnz4xtgw;
	Fri, 28 Jun 2024 12:59:02 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 45S4s3g3026024;
	Fri, 28 Jun 2024 12:54:03 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 28 Jun 2024 12:54:04 +0800 (CST)
Date: Fri, 28 Jun 2024 12:54:04 +0800 (CST)
X-Zmail-TransId: 2afb667e41ec0c5-229d6
X-Mailer: Zmail v1.0
Message-ID: <20240628125404912pr89b8ev3h97gu5cn280C@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <ietmar.eggemann@arm.com>,
        <ostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>
Cc: <he.peilin@zte.com.cn>, <yang.yang29@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <liu.chun2@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjaGVkL2NvcmU6IEFkZCBXQVJOKCkgdG8gY2hlY2tzIGluIG1pZ3JhdGVfZGlzYWJsZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 45S4s3g3026024
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 667E4325.000/4W9NWp3kvhzKjS

From: Peilin He <he.peilin@zte.com.cn>

Background
==========
When repeated migrate_disable() calls are made with missing 
the corresponding migrate_enable() calls, there is a risk of 
'migration_disabled' going upper overflow because 
'migration_disabled' is a type of unsigned short whose max
value is 65535.

In PREEMPT_RT kernel, if 'migration_disabled' goes upper
overflow, it may make the migrate_disable() ineffective 
within local_lock_irqsave(). This is because, during the 
scheduling procedure, the value of 'migration_disabled' will be 
checked, which can trigger CPU migration. Consequently, 
the count of 'rcu_read_lock_nesting' may leak due to 
local_lock_irqsave() and local_unlock_irqrestore() occurring on 
different CPUs.

Usecase
========
For example, When I developed a driver, I encountered 
a "WARNING: CPU: 4 PID: 260 at kernel/rcu/tree_plugin.h:315 
rcu_note_context_switch+0xa8/0x4e8" warning. It took me 
half a month to locate this issue. Ultimately, I discovered 
that the lack of upper overflow detection mechanism in 
migrate_disable() was the root cause, leading to a significant 
amount of time spent on problem localization.

If the upper overflow detection mechanism was added to 
migrate_disable(), the root cause could be very quickly and 
easily identified.

Effect
======
Using WARN() to check if 'migration_disabled' is upper overflow 
can help developers quickly identify the issue.

Signed-off-by: Peilin He<he.peilin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
Reviewed-by: Kun Jiang <jiang.kun2@zte.com.cn>
Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cc4975d6b2b..14671291564c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2259,6 +2259,8 @@ void migrate_disable(void)
 	struct task_struct *p = current;

 	if (p->migration_disabled) {
+		if (p->migration_disabled == USHRT_MAX)
+			WARN(1, "migration_disabled has encountered an overflow.\n");
 		p->migration_disabled++;
 		return;
 	}
-- 
2.17.1

