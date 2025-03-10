Return-Path: <linux-kernel+bounces-553854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF3BA58FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD83168F82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F102253E6;
	Mon, 10 Mar 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzujpqwH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91722259E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599496; cv=none; b=SkLbkgDB2FHMrFkO4XNlsEIbOzlaUXs4zrYNThzKGGiD1qcizIyyk6hBxTZG/YWM/0h5+oK3NSIfMvbuQWJrBPLkXlx2o0rp+e7tTWblZ6jlSKY0AtMktovWvVvNOcAyzLNrFLIQy0efii49me7LuCRZ7L+56jOqGflhBcRWkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599496; c=relaxed/simple;
	bh=BHue35hwwG3uT7E8+0hMoxP2lkZ4XCqRtFoZXci5eS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luuxMYgVeYtivbVzP0Jxse1t1L9/jn/K/bxcpzdHmfsaaA5EgtH5jocIJUBCSJknZ+r1PGcKPS5ZWtZu6VbMgL+iAJvEybHgQqD7iiKSWT+rjIJSfuEDXoM4yKCGE/i/yNNW3QYx9k3cbafySc5mPQnYkSSAzb3Iqfw8wfogT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzujpqwH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzT3QSYSjmZ8G9yIANDr+xNeKe7EEcc7gC4o7NwYdRc=;
	b=LzujpqwHKE812U1FD3si1j0QN8El+SiY/M2c5Q8nFnuIrrVHyMMunLrB+MP6kep+TrhvgH
	acVUAJPKvuWJrtDFnfN7bjyTBsVMklA+WYCNmf5V07uAD4gb5sANpAWCCWecR1ImcKyvIt
	IVzGzqOSowFHeY0GEuqfxwXKn8tg23w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-koRBuuwuPoymuTWXKF2krA-1; Mon, 10 Mar 2025 05:38:13 -0400
X-MC-Unique: koRBuuwuPoymuTWXKF2krA-1
X-Mimecast-MFC-AGG-ID: koRBuuwuPoymuTWXKF2krA_1741599492
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso1570965e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599490; x=1742204290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzT3QSYSjmZ8G9yIANDr+xNeKe7EEcc7gC4o7NwYdRc=;
        b=gtZkOoLRrVNzsySUN96//AD7bGIlPbsdmd1qQUUoDfUmrrbdIc+VWI1iQ77ruI7/kE
         tD6eRdoabxJlYd1N7AxikIjOIDD8h84vakBuEvKKnCF7wW5nkI1tWOw2BzmIPZU9OrN1
         98uGYkqsCSxgExLjFSHCcTkUy4c3un6tK4YjMrLxr6muDG0r2bTIOhJ8EsaMouCBU6yC
         lSaPx/NahsE8qdSeROm++Czmg9fHAWc8T6JenOInbZfi3iDCVhvVFJy2LLyQT2MdV9As
         H+QyGJ1GP/Xt6ih1MAaAtPD4Etq4uPHtJrqdwlHfVTxUiohCqNvYgUjshcn9u1IEyfU+
         Z4rw==
X-Gm-Message-State: AOJu0YzJbUbpu9YhT5c0MUdmr26NteJUkUbjMImF2hI2YvurTJiF1AYQ
	A2ZON8ZdRI+tXo2l2+2QnAKfUU/jO3qJxzFqts5Ak2YjrPwjQr+CtUPtEuQQh+LxT/f5dJukYIl
	PdHnCMfgtmfMr4L68s8tTogxmaTEnyEOq8bOVNTEpywmk+SR1/vgQ2FG5gebYT9SS/TnkI/NxBh
	g/+7jG8/RDr/pBtNlc1rzVtRk1uFtPU9MmEpzOg52N0y5TRl6rd5o=
X-Gm-Gg: ASbGncs7zvixtiGk4DyltwlzkgV8YzXxZJ8ATJ3oHK4mMsTpKsl824YCXSBDqsO5OYr
	80wAupjpx5MgI4czVcuNOiQFATZkWXYoW0ShmAe3OVhBMB3nYgi9nmzZoQmOR7Xz9pqprvvBqMh
	Ey4/1aU99nRbXUtup1vofKpqtHXK5NyRaCsiHyQcYh95TYCT/cRST/5O8PJiAiuPnG/4ve5ez8m
	i4cm1cLcb7T8fUkJLIoRmhqwpNr5IYVafkTfLaAR5/PRAdVHcbYcSfGEplbR7no5JMsV78taxMH
	BpzkdaD6TUwrVc78QAdAPbt9Y7TS+3iU3eA50L+fOHw=
X-Received: by 2002:a5d:64e3:0:b0:391:4889:503e with SMTP id ffacd0b85a97d-3914889519cmr2493714f8f.33.1741599489779;
        Mon, 10 Mar 2025 02:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn7gYGzhHmPcL3pfBYzEcWegmbHHUv/hFVbJA3S4wb9NqXKERnd8N+fs7CM4yauTmldCM7Kg==
X-Received: by 2002:a5d:64e3:0:b0:391:4889:503e with SMTP id ffacd0b85a97d-3914889519cmr2493656f8f.33.1741599489271;
        Mon, 10 Mar 2025 02:38:09 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7aefsm14111154f8f.20.2025.03.10.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:38:07 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:38:05 +0100
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
Subject: [PATCH v3 5/8] sched/topology: Remove redundant dl_clear_root_domain
 call
Message-ID: <Z86y_ebAmhSaND09@jlelli-thinkpadt14gen4.remote.csb>
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

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
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


