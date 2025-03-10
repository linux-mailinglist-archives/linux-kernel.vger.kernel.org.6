Return-Path: <linux-kernel+bounces-553859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87160A58FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD7B3A79FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ECD22576A;
	Mon, 10 Mar 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmY71huw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B02253E4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599614; cv=none; b=RPbAuGbYlWnErvI+ut1bilWuRaihiQoFxGNkiuFW/lX64jKleKrwrDhTXqZIM4s8oCkwSi3y0nVE8I6h4fbJu5+An4TLhmWL7KeYJfMqPpp98dGPWzCL5zq3vSQqnSnV2yYUJvPItAtUmmjA5nsjHw2UHGeXK/77hqmIY+RTKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599614; c=relaxed/simple;
	bh=cYVuCi9smgjEBwcOQ3WPdNQXmKvk2MX83ZjOV1VFGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRTV12xQaz+g+/oFKOOVrP86HyFI06MXQVWvmZBVLirjFGWhlEWc8B+ogxMOFLD6YOo0bk3SbpU1hRzegU85P0OpaTBQkVWrpAgJhKGsV5aBRXlqAZ4JAf7pMnwyG/bwbwY7yh2BY+USDvUNgX/XkcdlnfUTJR16k8BwJ7HcRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmY71huw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUhCbqWkoIL0WYlXStoL+S8I9eid4bkKJk7tnyoFRWY=;
	b=UmY71huwFT7ztidUH8/t9mSJV2abLJLoXeRDF0nHcn2OzBAoRi0HvxP6ANenJ1pcEuj0iA
	Ynxg/AT8hjcfx0JXELHGp6d40GruSLn8Kcfghgiw9WYLNP3y/Pvt6KRoEE1ngEKy6K4GGJ
	QBAcRvkRFigtY5zibR+8OhzFcb6HRfo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-QdUTjT9OOGW8KAEf3lShdw-1; Mon, 10 Mar 2025 05:40:09 -0400
X-MC-Unique: QdUTjT9OOGW8KAEf3lShdw-1
X-Mimecast-MFC-AGG-ID: QdUTjT9OOGW8KAEf3lShdw_1741599608
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39126c3469fso1625922f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599607; x=1742204407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUhCbqWkoIL0WYlXStoL+S8I9eid4bkKJk7tnyoFRWY=;
        b=g7GFQM1M3ZHftddydfpxOuJeOM0EXhI1T7ivWVhO9fMyM3gM8HZtuHiLF0pr1AQ6Db
         ZTxcLMChkonqcftco/Y3LwArObkZqyCoxs2/X+fTuRQhWY2do61Efz/evBIaRS2rrZ7d
         qCcJDheKryr6QCWG93zXzqqhoBHXaPoiKWecr6I7n+3zmbomtS3MHC6Rg5In0DEq8h58
         wEYhfZQ99wHktj5DO8L2p9hhv/Yo0P3ZlTgq+RH/6m6tm6amCe+ezu3rtdlD98k7Rhvw
         S1tSI8LRj5TGfnjjxSTR7gHgXcnDR9iqSLAkB1eb75/FAGXcPaA2sO1lVHi86/he2n0C
         wU+w==
X-Gm-Message-State: AOJu0YyCD8piDtSOPN4QWByI9sn0ZsyHKVHXfWAhA/UQ70tuAx4UxKiM
	CHLIzcIGHPOMMeTExDdHVy8oCi1wcKHzLwhcUYPgxKY4ysFo3TLCIElL+kcR2TJRrzRjO9h1Bv0
	/BPMIo4f2bQZvFWwdum1fcIQMSHCmP1PjPZjU6kXJPzpo41lVgu63QfsfZVLDYlXoe3Poo1GBuB
	JeO0bQP17xbjh6/4BpQWtvsbGFHmjrHHJUwHnlJtBqqQ1VB99r10A=
X-Gm-Gg: ASbGncssW+nX7qr1blxCnANPwkEuq1YEGDc2Pglpy7awJiPEjai8eRv/rihatXz6u4f
	cnhajIVN1MPJh6pDXnM2RA1aavsyHcM7QzUrN+V/EYYyl1zE0jW0bKznL+Q1+8cbBP6qG76xSP1
	dS7no5EYATw88jns66GbXrDjqCxH2ZYKmOakpQTzv/a1iC+dAY6ckRtoCxNhDjGvxvTbC+NLpl+
	VSJvFFb2KWWJcRwqwALf23sfSzEmG88lWz0hkVv9GNPSXCfppubl+b9H4hAZ2oBQxB04sl7lgPn
	vK8oDhuKW6bUDinNU0jZ3PmYN8DCkKkZ0BYnsspLens=
X-Received: by 2002:a05:6000:1849:b0:391:3fd2:610f with SMTP id ffacd0b85a97d-3913fd26306mr4340087f8f.13.1741599607033;
        Mon, 10 Mar 2025 02:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcsHZY7qjs8N1eVHZwzlGoyokzF396DbRgaw/pRBbS6FjqadMwZdpf2flPxcgdEDc9YGKV5g==
X-Received: by 2002:a05:6000:1849:b0:391:3fd2:610f with SMTP id ffacd0b85a97d-3913fd26306mr4340055f8f.13.1741599606572;
        Mon, 10 Mar 2025 02:40:06 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfcbdd0a7sm11669675e9.11.2025.03.10.02.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:40:05 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:40:02 +0100
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
Subject: [PATCH v3 7/8] sched/topology: Stop exposing
 partition_sched_domains_locked
Message-ID: <Z86zci-kj6kNBl8I@jlelli-thinkpadt14gen4.remote.csb>
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

The are no callers of partition_sched_domains_locked() outside
topology.c.

Stop exposing such function.

Suggested-by: Waiman Long <llong@redhat.com>
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


