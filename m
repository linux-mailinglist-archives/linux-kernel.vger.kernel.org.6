Return-Path: <linux-kernel+bounces-560061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6BFA5FD24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D435F1721AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD275269D17;
	Thu, 13 Mar 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5+SdwBN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D96201025
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885890; cv=none; b=JLUaXxtXcC6k1TneWErbVi7kosBIufqzVfxK4pXBXszLqAoG7rupEg5OzPtj1gMVuGYSAjrbKo4Qa4OWOHNEb6cwMsLDFclCMw9KNuSxFbparZkGeRULAC+BQPDJ0TX5ollEOyKQag7/B5Gc/Tc+Iub6ioaFCKpAyYtba0J81c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885890; c=relaxed/simple;
	bh=lb+ZbAQnclNwseWR5txyK6ca+JbKI+Yza7gQXBm7aCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFmwFZ5s0KQ/3+gXYc/8/jYHlnaiMMP82XzdpVSQa+MXXO/5v+WeZL7gdA7R8PpoMZMYdWJL41vLTlC9J5LkVCLP22krXKeTe+hBqQ3DSvAn9qJd5EJMR4LPVjsVwKuy3MkoqzswvCJ1AD+FGUh9EOTYm8uH8VUcG9jroqWKhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5+SdwBN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=toM7pu0/nKvqJbZZIzL7Jc4TbRaykE4Ah5TJhKkkzP8=;
	b=h5+SdwBNrYbFoJhfZV/aI6mSFK72LjOhJnn4clOZ/RwXMAnAq82RlPAFxPO5cbGEHDy2e8
	ad8A3T9HED/rq/h7SibJ8pxxMIT4hPOcUDZLS0VMvAJkGZ7AD/nu7HQKL7n8SBuAX/YkiV
	oTxejdCWHycFu32hsHqk+kTaWISpUeU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-V43gB0QzNDOKLIe-FY6J3w-1; Thu, 13 Mar 2025 13:11:25 -0400
X-MC-Unique: V43gB0QzNDOKLIe-FY6J3w-1
X-Mimecast-MFC-AGG-ID: V43gB0QzNDOKLIe-FY6J3w_1741885884
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39135d31ca4so650007f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885883; x=1742490683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toM7pu0/nKvqJbZZIzL7Jc4TbRaykE4Ah5TJhKkkzP8=;
        b=qPUVCLDJEm8160q0tRpR1MiZyk6IgyotAS38khFXYeNZJsvXM5TCLzk+udfZD8j/NU
         Vbgy410MVM5WO1kgXZUPanj7s/Ozu0Vzu5xZzJrvgRLnBeLg8rvizrSzD3tktAuWF3kf
         JvpdlXoi73cZs5U+QH5k+D8qPfE9N8RBXkajfxoAd5qMdQ/xIkFJ6kj/HfnofgI/XSTf
         wpj/yupDrNS5xnRDwNq8dVsLUZ7E3bnB/xArh1W63e4YZHMOYYg5PKeAPG6uzgJ7bQXb
         GMmB+5AFV/9fd0l7UqnYRcMdjD4tXhgR+scRxyqwLqqz18LTstPdjn9uD640v+R2fMIX
         3d/A==
X-Gm-Message-State: AOJu0YxWoFrkwtwA3RUvJHpn3/OZLxF17kPXzYZd6wm4WKjYFrc4eM7h
	QbdJ4xw2n+HS48mgw/4YwMH0k7JBXQ7mbdL3RF18zFgCkAsCO84tcGndvRqSvyiJubBk26t+36O
	0pgKqGXY3KxI5xIcFgLB301MW/ngII9pLrFCGpN+BP2/oXuM0jCoTfZtmN5XvV4dHCbHM4Nvn7D
	zaiMep7C/778cgHa5Wgz3AoTbL5Y4fHihnUqNMBCs8xqof7CBc
X-Gm-Gg: ASbGncsSiNKA3l4nGwlAzIL3YDnwBEgK0ew4CPAtANes7ywSXyb0NxeTtrMBEy+n/Z3
	lbW1LXAUYNZFab5pR+peNEU9wj7pNn1iW3CLe4HfXZ/oPCnzMqwsTr3OfY0gFHC92hp6og7vZrX
	QS609/Gk0NiTqJsqj6nZnWgElovUkZ9wEi37qtJmQ4ZDyqAKhL7zkdqebjGnjR7murmg9VvJJo3
	GD+nvLPr5k2JQ5F7UeegkTJrKErWVzOGfKwVrYtu6hnG+2ZaBixNDj1+ESRM9ljtdPQXnTBK9u/
	hW9X0Okqo7xuqlha6nPHiBYnlMT3YOfjxDXuJuroCGM=
X-Received: by 2002:a05:6000:4026:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-395b9b10d93mr3353487f8f.26.1741885882642;
        Thu, 13 Mar 2025 10:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrw1KHuvAQ5Oit6WEwU940Ut+Qi7Yu7A4vk0V+1jznfYA+D03YAhRUY0Z/WYBn49xltnyVOQ==
X-Received: by 2002:a05:6000:4026:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-395b9b10d93mr3353290f8f.26.1741885880667;
        Thu, 13 Mar 2025 10:11:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a75b0f6sm59705935e9.22.2025.03.13.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:11:20 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:17 +0100
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
Subject: [PATCH v4 5/8] sched/topology: Remove redundant dl_clear_root_domain
 call
Message-ID: <Z9MRtcX4tz4tcLRR@jlelli-thinkpadt14gen4.remote.csb>
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

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/topology.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 363ad268a25b..df2d94a57e84 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2720,21 +2720,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
-			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
-				struct root_domain *rd;
-
-				/*
-				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.
-				 * Tasks contribution will be then recomputed
-				 * in function dl_update_tasks_root_domain(),
-				 * dl_servers contribution in function
-				 * dl_restore_server_root_domain().
-				 */
-				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
-				dl_clear_root_domain(rd);
+			    dattrs_equal(dattr_cur, i, dattr_new, j))
 				goto match1;
-			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
-- 
2.48.1


