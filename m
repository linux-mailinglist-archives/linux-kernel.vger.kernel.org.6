Return-Path: <linux-kernel+bounces-549094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E4A54D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB718189737B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF917799F;
	Thu,  6 Mar 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR9d0zvo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF416F0E8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270275; cv=none; b=DoUiKdGN0atzi7WRx+ArdSIMiklyJ9ivRd8B8kZsG/1JX2XgcoSkWlH5iJ3+5VARkTrsV3Tov9cS5GAyfzATwXrUSnkWtlIeCMWPkQTimo47r4c7TceuJnr2tHT3cmtXExy5V5DdxOS7zwUdWq3aUYAfoAQ05NzK7BnBY1OFJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270275; c=relaxed/simple;
	bh=NJa7eHT7qOxfHmHXZjuOxjXW46aERM5gQU39+V2N3K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cu5conpcLGRcptxd097X0jcogSracoyD8mZzzt6mA4ub88KyKE1iaE9mUQ7GjFSqfZPSHJ90kZStTKj1bAfO0Lq1d1cPVo6juAz7VgQbg3g3NGIS9DrrcaunuYzbhekEOqS8+cf6jW9yp/TAbtBz80tcN1hRH66O8l4/C0UjcOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XR9d0zvo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4ZIFOGxzinJuVdUFfsoDQG+XLi9wvCEmtCRKGKKMyw=;
	b=XR9d0zvoauLVYJpJXTIlTMpRYAbUaFDAjO1RhJfw5ejzixNBUWNXVcfgfXKa9AZt5xk0t/
	cuEtN+cqOO7sjF6hdQ5Vyyhy7xcALJPlVX2+vC+ZhmVSQtCmqKInlPUW95K8Fboq3FtKpe
	nVca3SQxHgxAsnLdUxRvhICMGivVqgY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-tHegkQNcNkWElUAdByRULA-1; Thu, 06 Mar 2025 09:11:11 -0500
X-MC-Unique: tHegkQNcNkWElUAdByRULA-1
X-Mimecast-MFC-AGG-ID: tHegkQNcNkWElUAdByRULA_1741270271
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7bb849aa5fbso167106785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270270; x=1741875070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4ZIFOGxzinJuVdUFfsoDQG+XLi9wvCEmtCRKGKKMyw=;
        b=Hqq0oeG6wxEPFwd1WLR7lIBz/aHq8f5Q2uUvo29+nFDfo9uKADD4iCBmumrCB63lOj
         LUrqDOxVDRNAOR8g0O6fFc0fdb29jNIu2P4ll096a58i8K1nn/tqyCYZo9+wv9dcViUI
         kgkfZXlmc78/hv6MXOLsSyMqn/re3VmmZA5oiCd8k6CSPTPUxWMxDPC5MOFESLvSXZ+I
         6u4QRNz22oGPJB7G2KdpJQLroC6E6ktu0ZSLATWXlnGywUFfYsrUhyuQ/LOTvySmYEW3
         MgZWUR0gt8BcNVrWz5QzguVgHkprmPzCzHaMK2h1r4W1lydTU6DHzln+BZ8Ydel98ObG
         n7TA==
X-Gm-Message-State: AOJu0YzlClzCDRxIw04rRdDSw8kwP6hfnj/nDg9T/YNEEEWRqlcAdHXr
	6pB6ifCTfLv0AHn05C9yFWgqzXjj7cPwGRcRONLoDEcXXWswki8dY3LYzWJp4hGImrHsqa5Xsxn
	Yg7ud9pKF6+F4Ck+3vT+ufRrOdk907tl0Gqwk+xZNKfXZxbQS3LjLOspVzd8qTnCwjyBBfBmQ2B
	uFHM2Lv9omc5LSheFLLChiRKvFjGF48hKt6z9sPjoSBNhxWGYidhQ=
X-Gm-Gg: ASbGnctaALV4CoI0V4cCIyTbARLWnCuvNWWkFFMCrSgqimx+dD1aWvpxtz65FUV+Gc3
	O7mEekflYxQlO7FnoofLGPerXKNofQzD5dWLNA5s+2Paz6CxzJsxvo1ferVn0kYMQdqMhJNhPy8
	I9IHHkEprgWecHaC5T7sALlQbCzkIwLdvjsNrUfl4xjBlK5KVd6RxxMklaja0kET3cnSmd5n6Yl
	RzRiROXG82wzA9eWxxNoTQJPQXzJxum0XDfO/jXIw6vjvgH/NHzQfH17zhOLy9XsDXCP5La87gM
	bM5vrTGW2qUwnXff5uIGLdiqA1G7RdOCp6a/GrO9ovVjC9yM3WWMjhVDS8Q41JKl0jR/CuXy9dg
	Vsn73
X-Received: by 2002:a05:620a:2609:b0:7c0:7ff8:231a with SMTP id af79cd13be357-7c3d8e680dcmr998091385a.29.1741270269945;
        Thu, 06 Mar 2025 06:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGNuuK35swKKToS86/qmvAp2EsJ5mnlJsJBrB3uSoXbOl1vHKoKvdXC/bxVXHHhC8AQP5Gqw==
X-Received: by 2002:a05:620a:2609:b0:7c0:7ff8:231a with SMTP id af79cd13be357-7c3d8e680dcmr998084685a.29.1741270269556;
        Thu, 06 Mar 2025 06:11:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:07 -0800 (PST)
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
	Jon Hunter <jonathanh@nvidia.com>,
	Waiman Long <llong@redhat.com>
Subject: [PATCH v2 6/8] cgroup/cpuset: Remove partition_and_rebuild_sched_domains
Date: Thu,  6 Mar 2025 14:10:14 +0000
Message-ID: <20250306141016.268313-7-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

partition_and_rebuild_sched_domains() and partition_sched_domains() are
now equivalent.

Remove the former as a nice clean up.

Suggested-by: Waiman Long <llong@redhat.com>
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


