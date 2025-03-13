Return-Path: <linux-kernel+bounces-560062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002BA5FD26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042D51896C67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E4269D1B;
	Thu, 13 Mar 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaNbA1+N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A3269CF8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885932; cv=none; b=Ixcey3+/virrJYlqASUlIBOa098S42SGZpm/1+38lZvzOyejL6dCnsMaDjA3Tw2lkuOZafbTdslLXbtHlNMda5OJ6a4IlsaT4m01kzXK2fsv26VnnMUAZXuDqLie0mdZgXCQLXvQ5LHb/Ux2aXHQhyWV6POQDfZLCTBjljL1lG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885932; c=relaxed/simple;
	bh=+eE9WT0Gb1oQ7l+5iK4YZ/BXWxyzhii5ao/7GfKePmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdVedb8ixKYIc8B1DGueoRXw+dEX6coil0oTmP8LyxcyaVJiMsoNTfLb6h33L5dmYxgqeEz2hTUd6aeaGHzyai8BucfezgfrdTdwgUL4Trk2ZnbiFS7mFKuKyGFSLD7hrM+eQtQ0nWVWoJLo2byRF4tT4Y+2rp3KdqFcBal25TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaNbA1+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGrmHbgAII+9uPhNMvyhCYNvKc1gV86tMiTemisyc0o=;
	b=QaNbA1+NAuA+wbzmhT1/6VZk0H5w7q3NvC+LpXSXrkjy7/HvRy5YID5COUNSPH6CgCUfcI
	I8tlw72eu7L5Hluw9dcuyLJ5SggF0Pwl4dzf+nzEa6bvJa/56ph7sF3e2mEXex+tt3CCYy
	bM+NNj3zxxzWkHJ6dHQCwzFlnO6XLqg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-n5uJ0epTM6mc8sBHsyJ2oA-1; Thu, 13 Mar 2025 13:12:08 -0400
X-MC-Unique: n5uJ0epTM6mc8sBHsyJ2oA-1
X-Mimecast-MFC-AGG-ID: n5uJ0epTM6mc8sBHsyJ2oA_1741885927
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso6477885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885925; x=1742490725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGrmHbgAII+9uPhNMvyhCYNvKc1gV86tMiTemisyc0o=;
        b=sc07QJl0gNDQgGUyVHnRbYfVVND251sGg65wW7hbdMhhOkTwzQrsslkcW27cITeNT+
         gVBVhOfUDJFy9k+04Iad9QeA2KZfbHb3d7CFXSYt+xiod3rgDKVcBW7UjZGQzQMLALlr
         JeASA1xXplRAy2pzM4ibEQkRTTbB06S/+ZUWKNPweZnlWK9OfKOTUXcm/fOfzStcO4a7
         qpWfFL93lIBG7T6qEQJzNyYQ88pJni5MPPJPGq8M77lWQ/E4UfShcJO/MDSqlyFsZQ/D
         r/t+8LQOtj651LkSS/DrkATiQeyNzJ3gu6RdS7PHWLOjTMs9Gg31TZ26Qi3weOVwo+9m
         HZ+Q==
X-Gm-Message-State: AOJu0Yxj2PMShFEj3vg8wX95DdKX/o+lZuo/2UuPATj/GKC9yLUz43T/
	nIsJQbynY8aRtaIEY/rl7zXWh8BvP/lqgDqro5ZNAyQi4pd09eMk+1Iq5NoUDAO6zo0JjN5CVK3
	nPP2EPGrfSAm+/GX57dW0p/kXjY66nLifzxpvCjzFRvZ1DvxhoHPdEWelB0Nt7thIR75p1ns8bE
	qjvQVd4Nv6lL6gA83vPOCWoxoWoF7kAPfRZFzMmLFz1iK64fzX
X-Gm-Gg: ASbGnct9/KVx63tt5l5+a+J5izQnPPw3+CvcVPZFMbRJ69UDNy/HsOkeln1e5kYJU4L
	ijlKnKeIv2YJa4fosNis7wt4x0XHxEpEIxr15CywKJhrVnm/aZlOxRZzO4Weca68hgVQsd1xT3t
	CFjKfjZrUYeiZNpWm44qtyEPtPFrR2OvOzrnb9eIGOZ61YAeWxYnDxlFxbvA9N5shDgCCoWJAM2
	pj1WqIgEs/mJzuY/LCMvd4PXEEp3JEeXCkz3tGBXvSDb7WeCLyEXSrwCDN1aiTtnTY4gZyyVSME
	+Eve2GXYxQ/Cg0cYoRVx85eW7qqcYiREdV6+0jmzU1k=
X-Received: by 2002:a05:600c:3b1a:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d1d8c6d50mr4689145e9.18.1741885925455;
        Thu, 13 Mar 2025 10:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyjRHKruacR3ykIkv2Ici+Gurb8exc5FYumQgohkNFhqNL6UYwE5HWX2mxAmRslvWd1m7+Tg==
X-Received: by 2002:a05:600c:3b1a:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d1d8c6d50mr4688815e9.18.1741885925020;
        Thu, 13 Mar 2025 10:12:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5d04sm62439625e9.27.2025.03.13.10.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:12:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:12:02 +0100
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
Subject: [PATCH v4 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
Message-ID: <Z9MR4ryNDJZDzsSG@jlelli-thinkpadt14gen4.remote.csb>
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

partition_and_rebuild_sched_domains() and partition_sched_domains() are
now equivalent.

Remove the former as a nice clean up.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1892dc8cd211..a51099e5d587 100644
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


