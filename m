Return-Path: <linux-kernel+bounces-560064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A2EA5FD29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E993BB929
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33DF26A083;
	Thu, 13 Mar 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5u1L9uI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814F63B9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885973; cv=none; b=KYWvBNGyZFD/n+cYlu8eIS6r4BRaqIlqPRm2e6V5XCTsYaKRxfZ38yq8cx1DbgMrGgeGul1ttI+TaUI1/U+1ey75spBny5eJuDMUdZ0xzMf3pzmB59tnXTTGMNKFeS1wSLwVF2slvuZcl8VZo7DFO2RyilKa8CNnBziInOnw92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885973; c=relaxed/simple;
	bh=aCNjCxT53589ZRllE+PYiqIoKKavHpFP+HFKZebl/To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX6lOWVMuRIB9v5VbLmfgGizPXK9lZNivNs/ip4kzRC8SVvyM9ZhwoBuXA61/BrbdgQs25lBYUGUYNL25SnDfsojLKOLV+LQa+5SC1ZtexjG7VvjxCydQ52sWHXDv1pnpRQu/S0mWQkAoNyWxL4SmW7gDQHMd4KX+gHUhM74tRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5u1L9uI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTDVC0g+v7pz/pmpIDTMJxbXsOJE3z6M/wBloVGLsT8=;
	b=L5u1L9uIALTOJMVX/ASEt0oD+hd+2ecKeb3+HF4fhZon3ZnNRQjnTH/colMPxcxhsv05Iz
	5nSOfvhCQijhiY+vsfc4QdlqNVjqonlesOOqtkRwh7itZZWD7HhV84z5HaDzNMDrvYVOK7
	LqVsK9/9uDa05NnQoZH4SNBEHFyFIZY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-mMi6yAO4Mm-lDqyDKu1AVQ-1; Thu, 13 Mar 2025 13:12:49 -0400
X-MC-Unique: mMi6yAO4Mm-lDqyDKu1AVQ-1
X-Mimecast-MFC-AGG-ID: mMi6yAO4Mm-lDqyDKu1AVQ_1741885968
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4388eee7073so10756575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885966; x=1742490766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTDVC0g+v7pz/pmpIDTMJxbXsOJE3z6M/wBloVGLsT8=;
        b=KUsVNqg905V5430wo4MJi8JteVTypsH1Zwf3TtaRqLa/GrHBKlNm6dr8yzGqp7WY9G
         akC4FDuxerkOCa25GhWzh+IUfZbMiuMwzuFq5SsDSWnMDqgeAdlEcG1DQc/NKJXXKeI6
         AL2WOWUf59opu/dxBS1jSpRJSKEuX0sFjtQNC+dC7TH/vDxHpOv7EzurSiQcbDDkozK9
         vSoj456nYc4Ia8Am6N5JRHj9LGjJrP2Ucgc2aqoHTV38uC0X+bF7B4ggW+2vieB00+Mr
         RQVEglGojkBpZwjKreniDq3jITqdwgb5TSqHKxbq567WAQAQ8my2w63zsrFkrA0A4Dvv
         VXHw==
X-Gm-Message-State: AOJu0YyiANrFUuROkaCbNAzl9caSHGbsSFbZ/PxXO5XBGC2CSttBJsSd
	o9+0DFTOOCyib8mrCJcUz3a0ixQ59+VbKYYMV0cr0NhX4zUqTbHYvxg27r+BMatXlVRpA+5gzO+
	X5czvz9zknHCrhf+XB2YkGbfqfd46KTTf0Q749DbaEC1npGl8jIfSRZ+xes+VYIhG51nuIaYqQr
	YJimcQvZJj0MnxvwOALtYnToXKI9KQWwIsppjhKAblrwM1C3nL
X-Gm-Gg: ASbGncvWGJ6fXSTAqMOLHooU042FQPzLeJnQ8akbBW2lB2JIfLU0hwBxLrwUC37FzzG
	1+AD4N+LJPnsV6Hdi2zZQpqXgUndyUxjgaMmGSG9YX5KR6WCrT8V7HYXQCXpqbUdKsB1BawiJg/
	yZ4dU4pXFlS/qr1o2RZwnjw2Ee3Oq9LWimFHA7gNA/E5u6z7ScUGzize7YjCdxSgVwqFf8rPUeS
	YxzlDeZkxXdkrIlxHhrUnYGqXtzAbSewH74tzYf8bs4VnVtl+4Nrv+UlyuFnUodzTR3xBf5kvhe
	vrdqwwTzXX4/vlaSnsqzqMA+hOpW9ecren7MgJF1MNs=
X-Received: by 2002:a05:600c:17d1:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d180acf99mr26397395e9.10.1741885966656;
        Thu, 13 Mar 2025 10:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELRcMkCppH2SBJWCkSJarh6UnGy8xwMw2xvh+1UjQuiyGcl7kDXCMMZUpRXeCFwUhi56T58Q==
X-Received: by 2002:a05:600c:17d1:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d180acf99mr26397005e9.10.1741885966203;
        Thu, 13 Mar 2025 10:12:46 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm2647185f8f.85.2025.03.13.10.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:12:45 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:12:43 +0100
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
Subject: [PATCH v4 7/8] sched/topology: Stop exposing
 partition_sched_domains_locked
Message-ID: <Z9MSC96a8FcqWV3G@jlelli-thinkpadt14gen4.remote.csb>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>

The are no callers of partition_sched_domains_locked() outside
topology.c.

Stop exposing such function.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/topology.h | 10 ----------
 kernel/sched/topology.c        |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 1622232bd08b..96e69bfc3c8a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -168,10 +168,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 
 extern void dl_rebuild_rd_accounting(void);
 
-extern void partition_sched_domains_locked(int ndoms_new,
-					   cpumask_var_t doms_new[],
-					   struct sched_domain_attr *dattr_new);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -212,12 +208,6 @@ extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 
 struct sched_domain_attr;
 
-static inline void
-partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
-			       struct sched_domain_attr *dattr_new)
-{
-}
-
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2d94a57e84..95bde793651c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2688,7 +2688,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  *
  * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
-- 
2.48.1


