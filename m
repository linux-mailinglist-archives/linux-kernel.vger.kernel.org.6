Return-Path: <linux-kernel+bounces-291274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBDE95602A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22601C20DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB00156C65;
	Sun, 18 Aug 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pa/u5Dmz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AC155A24
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724024746; cv=none; b=ixykUHdHghanPOo7W1ab1D0cwiXwHj/+oxIPJym/lCeQVGY+c9u27WKW8/AvCOJV2SB/RivM2BIMY2wa4OH8Dpo7YAdBcK5uCf8mCs5qJ4aW/RAMfd+tZt7/2BugZ67A0WSZWwfFgUgCThFDXbnrAaBeyr/oSqYQ1XOY0IKUae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724024746; c=relaxed/simple;
	bh=5GLJcx23yiK6O5h0SYqrBFpzEywtPryZurqS5veZTjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6u1PK9MSDIWv3NzDIKzugcuD1aT8PdXXi8uDzsNW4A/7aiyR2F5nLOsdMilfXEmLzEXeeYSQAfExU7hOqqhOj0CYrkV7X3uQEM/nbA5OoxcMXcWd3ABk89tVkJDM+q6oCCfpLGUvvKYgBkuQXcdwD6jlnVfRwbNiwUffp63UQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pa/u5Dmz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724024743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsNWp9LzBud4wrCMbUUSaGfMdSBqayoquJewiX+GBJw=;
	b=Pa/u5Dmz6BDXC6ydhXescE0tCAMijuOAzjHgwmKY99NdaAUIPOv1YeUjJ2/HKUfMX2Uth8
	ScK2M9X7sQKazzdMQbxIb6F5jbbBaDvlOiqCzwUsKM0I2jrzEntxBh+P3E+AGEiKCQ2IfF
	8lpUzw+pQl5qDiZR3an8SQaBErGTo8U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-7xNAUBQZNE6Vd42dqqL3_Q-1; Sun,
 18 Aug 2024 19:45:39 -0400
X-MC-Unique: 7xNAUBQZNE6Vd42dqqL3_Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD72219560B0;
	Sun, 18 Aug 2024 23:45:37 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C449E30001A4;
	Sun, 18 Aug 2024 23:45:34 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Date: Sun, 18 Aug 2024 19:45:18 -0400
Message-ID: <20240818234520.90186-2-longman@redhat.com>
In-Reply-To: <20240818234520.90186-1-longman@redhat.com>
References: <20240818234520.90186-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The HK_FLAG_SCHED/HK_TYPE_SCHED flag is defined and is also used
in kernel/sched/fair.c since commit de201559df87 ("sched/isolation:
Introduce housekeeping flags"). However, the corresponding cpumask isn't
currently updated anywhere. So the mask is always cpu_possible_mask.

Add it in nohz_full setup so that nohz_full CPUs will now be removed
from HK_TYPE_SCHED cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..a514994af319 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -196,7 +196,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 	unsigned long flags;
 
 	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_KTHREAD;
+		HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED;
 
 	return housekeeping_setup(str, flags);
 }
-- 
2.43.5


