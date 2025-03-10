Return-Path: <linux-kernel+bounces-553855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE359A58FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3866916B41D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDDD2253EC;
	Mon, 10 Mar 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InFua6Lj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF722425E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599558; cv=none; b=px0KNfG6BSrZsLnA+pw7usC0G9NGImOXV6ktwPkOf7asBsya+ktlYbx5bOmijOw/TdVJx5v7VmM/XCNGHuRFhCQBFkrGURYeVJ0hBm5vHPEAqmFarzLXaMmOqT5ueKiYUkBpRLOYb+DnI4jB5rag23WpBCJbJWcAp0oe5n3dAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599558; c=relaxed/simple;
	bh=bSLpIN8jUdE9hjPba80yyQ52wEXooa6uwUai3Cd9z98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPGcj30B+Ec2wjdVtduVzfB1z7zHQI8ARhStlTt/zuQG+XgfL6YxMvRlUB82eqmxbTOfg10kuh1E+k/6u2TbiyrsJA0YxXsCGWV1pTSFFOcdx24+ElNCVGZP/C6nQp6p4kt1uQt+ykLtY1Vb44cVdgemxJzP322xv/N30JqqEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InFua6Lj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVuaA2xIyG++dtxNPCuZKJBhnBA8DE84LuwYVWooLXw=;
	b=InFua6LjYlbKGDY0dEj2yDuGUP2WDcoweBguCE9RQ5GAHmnvht7HKBriOJENBr4peWHDBK
	AP5od1hVtDQF+V9U74oman4Jp/y4HZYo/nbZK1r/2Lp2F9Bwlz5feJCd3hNfVVmIzrgpVH
	V1hOnX5f3UYMmS4/K1xIrSrydm1gpOQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-59wLjk4XMCCtXQ8KbyruRA-1; Mon, 10 Mar 2025 05:39:14 -0400
X-MC-Unique: 59wLjk4XMCCtXQ8KbyruRA-1
X-Mimecast-MFC-AGG-ID: 59wLjk4XMCCtXQ8KbyruRA_1741599553
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39141ffa913so742088f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599551; x=1742204351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVuaA2xIyG++dtxNPCuZKJBhnBA8DE84LuwYVWooLXw=;
        b=hYMyqto7J7Eo+FN1ivWpVGKhV0OrWKTcSo/RtWJH+muvhzPgqVxYNCELlKjQoKSdQ6
         cOpoGIAdlvDTGUzhcnQNSCS8K27fOpW72YUVK26gPUE6doXFmdcCR68Fjc9mvubGFL73
         02ZXgWRX+lWWKTO85dT39r0ZrHk+Ffwgl9QsW0pGTeBnJlAEl2dwsDzzly0y2X/1mRD9
         hI+1Hk42FyWNZs8WX7/9yhNNUpnflHy104WwebESkLnW1lThVf8dbYqKjRZCg2spd/mx
         0bYyy/+9xGyXUx34Xg7I2xJWE9CtPgH1OrDxAqDTFEwfMJoLEP7tHP1EY0GEkk1X8zp3
         1mZg==
X-Gm-Message-State: AOJu0YyAqwPKYk6TzmNAWMTMVtHEjl/bFaRh+D45ishqgArdzhKSIcrx
	ulJ3zZSfbGwHHt+idbR3m6TdJR0q5kb+nCO0cwGRoJi+IBeF7M+j0j7jFvm1QXS4c/Ghh3td9La
	rC1vDCYMSW2HoETyH1qq7ZVRWwEIz/JtmqlsoTvgLHhqjJEn+wrqzig0jq5ed2HOjDe0nKqTfap
	q85MOBd28qvI2Xu8Tyh6jvIK1czjlOc+sO55jUP59u/GBeRVw8xsg=
X-Gm-Gg: ASbGnctN/asWvHSBYCFrBee2Wo+KCaRNEdVYTzfji3hHQ1hr2RiUUYXMkrCMitO5X1a
	MXo/WtjxvW/aTv7JY78/cC10zH/SfFtH75YDy40CVBA0M3A2kRZMoKVkFdAlFeaukIIAoeMiHEf
	29vX8/dbXwkYm5vujRhk11v1MdGQiqhb4TBAR0FN4R7HrS24KJaUWs7nPptxFWG9mdQN+iy0Ur0
	D1t45m2f2si550yKv/jS83kboczF1Y+Kx+Z1653yqolI9EDX2gPAy8WaCVb23DT/fWVvy7lbFXB
	1Oi+q00V5oynIOkUNj3LP3sqkv1zz6RpA6kPgJqkZk8=
X-Received: by 2002:a5d:6d8c:0:b0:391:2a9a:47a3 with SMTP id ffacd0b85a97d-39132b5b802mr7939604f8f.0.1741599551618;
        Mon, 10 Mar 2025 02:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtDGjwhZCXPUTTbyre3WWNNE0mRndLmnRoT0m5vbhow+i+lvg8pi3nxLQvh3LPFdggIS2WXg==
X-Received: by 2002:a5d:6d8c:0:b0:391:2a9a:47a3 with SMTP id ffacd0b85a97d-39132b5b802mr7939557f8f.0.1741599551159;
        Mon, 10 Mar 2025 02:39:11 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01ebddsm14627111f8f.60.2025.03.10.02.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:39:09 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:39:07 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v3 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
Message-ID: <Z86zO_uCamVRRUqe@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>

partition_and_rebuild_sched_domains() and partition_sched_domains() are
now equivalent.

Remove the former as a nice clean up.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f66b2aefdc04..7995cd58a01b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -993,15 +993,6 @@ void dl_rebuild_rd_accounting(void)
 	rcu_read_unlock();
 }
 
-static void
-partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-				    struct sched_domain_attr *dattr_new)
-{
-	sched_domains_mutex_lock();
-	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	sched_domains_mutex_unlock();
-}
-
 /*
  * Rebuild scheduler domains.
  *
@@ -1063,7 +1054,7 @@ void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_and_rebuild_sched_domains(ndoms, doms, attr);
+	partition_sched_domains(ndoms, doms, attr);
 }
 #else /* !CONFIG_SMP */
 void rebuild_sched_domains_locked(void)
-- 
2.48.1


