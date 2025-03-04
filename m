Return-Path: <linux-kernel+bounces-543523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13DAA4D6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD99C3AB3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB171FC0ED;
	Tue,  4 Mar 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbRDXJY3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AE1FC105
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077685; cv=none; b=DDYgODO7zn01cZREROIzh0DUvq44klZVM/cotFlwmfrjRm6vtrtW6ERD39A1dtZa3i9MAvrnZw196J33Mf51ZVjzbTiTJATSwTbN7CzxmD1h+SEpXJu+2fFidz9MJ4/8oryT0FhT1h9HPCEcgSywU7rntSTY+uRMmeOG7Hr2nUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077685; c=relaxed/simple;
	bh=xcnCm892YVWrZWbMShd7y4D6hSOZDUxmmffjBmaQwmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkTdOi223rvgXRudjbU5cMhA3Pb1LU1hGL3ZmZqr846/S9ljginBY19a7krw0VC4Hw0VnWcPvnvKtRxbzw5OgS0nCOr5dzReALbqVqGWDj61mYYmALby+zybqAHrJa6Yd9rHle2R3R+02iSA7GVYqWVbtlfWLbMxWWFuOhFgJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbRDXJY3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
	b=HbRDXJY3dEkYocenNO3jS2Am40bHDPlvHI651ul1CLgLwOW/K0sn3Q0TlQuw9+WepOrGQu
	HFN/XiHNdYhXQVAl8raiaodb8s8vIFv/ABSYrnGsiykvWEvjD71tcO9tQA+WBHcXtbRwp4
	xLHx7z7KZAoy70woPa5Sg3S9pGdWMkM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-0vABoAXiMqmVQkTmAYGwpg-1; Tue, 04 Mar 2025 03:41:16 -0500
X-MC-Unique: 0vABoAXiMqmVQkTmAYGwpg-1
X-Mimecast-MFC-AGG-ID: 0vABoAXiMqmVQkTmAYGwpg_1741077676
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b3cd4cbcso623392285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077672; x=1741682472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
        b=s5Jl8C2ZjXhJuKpN+UVRA5CSGiDtuC9F5UexaKLs00hGWHpNfH+Z90kdHx2BrxanoK
         ZkYbSEdwmrLIm6J9M5ffLsk3BrGMMCvQX7TYuDrKbWNysWaRmhvpB9lU4Pxsydqxgtih
         W+UMw0OrTGpAmIu5z1WvIsyIlEcSDMb+Twqg8sDHuXrRJWdMGUL+aJqzEhAL6MgseA5s
         gpp3m+tGrnOAXSDIpHSNZ9cEh1MWcOkD8sw9dLGABjpZOPIQBG2YdsWZ8UdOImXhr/kD
         sPTWPu86vb5HWv7Y41ZbgLnxEIGU0ImIuX59YXCF80wfYRObW0oT6j2qP6ImgkOC6GOY
         RSRg==
X-Gm-Message-State: AOJu0Yzbsp516ZFhh0WVG/MlMvBPgBw1c/nRoiD3Wl/V2TgQ9f6MVi/K
	fl9StJbJW7hWaT0ytGjvpy8kGxMCMWcBZZ8ITXkkogHLEP9i1Qn2MULJmL/wFnLL8u3EiOsBCWE
	+skpbxLORRsyYgZD+n5wLU4eJsfCCStt6wQCFOlqcM1fJmI0SYLah3dQX9rnbzFl4sUjESxv12M
	6ZOnAwYT1SpwNy00mCBFqbyOoxSrd//lXDIg6oCapwxpi2odTGlluYlQ==
X-Gm-Gg: ASbGnctZuupBnE1LzylIs9awLK1GBHxRev3I/ExwQPt2DlfLTedU/9nqO4nq7rhktNE
	vk8FiN/IpQUoGyY9DdiirmRiv1SzaCEH4TZYIBEbYBpG/+CXl2pXfkiDDrfO8fw2qtfJlzf0M9d
	9hmeXKJZOFSqtxoH1unTDYycTMJpib6tpW58d+NZed0My2NC6MuhxsXWT2A+JJeu99XdJdqNgdy
	WfpG0jPm7VBlFV3gnWIM7o8xbZ5ypm5aDTwlSQfZ0eTgZshBpRC1ezmwEvibL2+DfcRIfHIhqWC
	uIWe4HCHFpJ5fBpm4spfdIrJmlYw1brX1/TAWBW/q6nbnARsRMUf+I+yrfx7/9MGy4oSqpF4Xyf
	zA8eX
X-Received: by 2002:a05:620a:46a3:b0:7c2:49ef:1f77 with SMTP id af79cd13be357-7c39c4a0181mr2593148885a.1.1741077672085;
        Tue, 04 Mar 2025 00:41:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG79q9XffEJNpdX763jIx+W9EQRrB41TjQwa3qn+cmvJTNbdOuOPZAWMQ1iApXQL2A4RS0MQ==
X-Received: by 2002:a05:620a:46a3:b0:7c2:49ef:1f77 with SMTP id af79cd13be357-7c39c4a0181mr2593144285a.1.1741077671659;
        Tue, 04 Mar 2025 00:41:11 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:08 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/5] sched/deadline: Ignore special tasks when rebuilding domains
Date: Tue,  4 Mar 2025 08:40:41 +0000
Message-ID: <20250304084045.62554-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
make sure sleeping and priority inheritance 'work', but it is ignored
for runtime enforcement and admission control.

Be consistent with it also when rebuilding root domains.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..ab565a151355 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2956,7 +2956,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct dl_bw *dl_b;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (!dl_task(p)) {
+	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		return;
 	}
-- 
2.48.1


