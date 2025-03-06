Return-Path: <linux-kernel+bounces-549097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232CA54D23
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C55718969B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5B165F16;
	Thu,  6 Mar 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvNLdiCY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EE1519A5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270292; cv=none; b=MSgubZrYoK0ZSQ/+Hwcxr1sd/8nZEMugjUniAV4ySDPVXNdJzXsVMv9Y4Ilih8y9mp4tTz93L1gczgEl1QrOgqeRWGOkHa+iQvYOovWVGxAyoLTM55Et81eMlMxzuzws2mKXLLJ4DAYS+54KC9QVkBt1xGMLjx1GZoehCpbwOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270292; c=relaxed/simple;
	bh=C/Cc8iMh5RhuOM/HCUsSqAmjstO6BDzi53uIK0zWZm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi4L7mxqOb3E2V/JzBxq3xCvUWdfEaX4o6WvDT9jVQDvPFXCURgJ85+BV7ggS6YaxvoamRshJG0NC1KFApH45tS/IqKdolMYXRraxGs2XIUj6yDUqz0ja3zXGqw37l/+wFn9kdtpbyF0FiOqagfrZx06IW+NQimluY9uwqxfHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvNLdiCY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3M6FX8T2xhunhC57UXeJA8V9v8swCagmqmFMiwHiP0=;
	b=fvNLdiCYjWS4wF/8FLvaE+rya27Z6cKjQOFhw+FH9Jb2WyFHBJYpd9eO23b7J0eultbkJi
	Gzwl76xchIKZ5IJxv1V791ynDxT1MD0k7kRIaH+Uho5ap71bKX0Ut3ayobdRCJn859nuB6
	xuI69BTHdQkyBiWVLiuSZ4aQspOWbX0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-GOWGrsV6Nay7NRqpVKHikw-1; Thu, 06 Mar 2025 09:11:23 -0500
X-MC-Unique: GOWGrsV6Nay7NRqpVKHikw-1
X-Mimecast-MFC-AGG-ID: GOWGrsV6Nay7NRqpVKHikw_1741270283
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0c1025adbso192026285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270279; x=1741875079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3M6FX8T2xhunhC57UXeJA8V9v8swCagmqmFMiwHiP0=;
        b=f+3j41ShFsmpi60g4vNxF4do/UKHxJ0hjUetdX6hjImZgu9C/NYR7dyxqEOCV871+G
         yg8UMTTsyI7FwGnpFStaqPYL7v5plnpBb3EzDmbz4kIAJ/h7WuNTtJdX2zR3eIz8plys
         xpDKgJ8V01Qq7FxSkr6bOggr55+ObE16WWQaJewRISYjRDEfAq0DosVKgz6S5cpT+MxU
         /5Ym/k7GUc7Z59XB/pBTJoB90I8t5pGuXIy1Yy2aZrss5E8oM6B5hEPgORbDIQCHpsvE
         Z2DkSSHM/gRa8Dd4hDMC/d2iciIOLO8yoBbBBOrgdIMBdJ1WjStQrs9SZUEtXvikG1w6
         6Q+Q==
X-Gm-Message-State: AOJu0Ywv2B01W1qD5YtKSJKszMYgmM7B/0S6VkdkpZ4GAmntEc5JorBC
	c8ME9Dcoh4IBvSIJ6HX4zJLAn0y+Klg9svu5CgtqibC6Q4pVq/miSjJ013Cj6wNCSjLC4M6sMv4
	PJFPlJVHlvmNhBfcRPraxylAJlVbCrj0Hxf5prDNLQB+5eIXEd1uzSEitnGY97emjHDHC1vAkC+
	eP7alH+cVTDHl5SS92G+NWK2UBb430zj0KBMjiiqHlXIVKkl/kWOk=
X-Gm-Gg: ASbGncvZ/PUzBNO3pf+mTuDj+7WNp7GemHUId4vQpE4+KLThFM067mhQm0roJ9OQlAB
	qH29HSpdc7L/8odw0tUBsALrqiVfuZi19yzMMYTZRYunw+lmhcnP/fOw6u7YoUZ1JtsGyaz9N8U
	Nbfpsn97IH3Pvhir00hQjqwqHItqgKvjRM3pb1XVuwXXNZfw7aBIuiJjmLcBDmqGYIa4OIvC2Zv
	f4ieZZVAPIXUuDXNmgldhA79Rfk4aZF3zb63bEE6kdl4jLZeHu7IS7nnxndfuQxOoEZnPykvjgS
	QgCM/hMq7rxtQA1BEiKdmMw0XVHTGQg5HLZp1B67E1Y75D49FIQOI88Q/pVYLXXSF/VuzSJj/8Z
	NqDoC
X-Received: by 2002:a05:620a:8706:b0:7c3:c1df:149a with SMTP id af79cd13be357-7c3d8ec7c89mr1017804085a.46.1741270279380;
        Thu, 06 Mar 2025 06:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/+GQVLhu46C/Nyd3wxyeBeqf/hT0BoGgJcoGKjcpXDkjFLsMk+xW8l/y0hrRplEO9PyuSkg==
X-Received: by 2002:a05:620a:8706:b0:7c3:c1df:149a with SMTP id af79cd13be357-7c3d8ec7c89mr1017797085a.46.1741270278850;
        Thu, 06 Mar 2025 06:11:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:16 -0800 (PST)
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
Subject: [PATCH v2 8/8] include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h
Date: Thu,  6 Mar 2025 14:10:16 +0000
Message-ID: <20250306141016.268313-9-juri.lelli@redhat.com>
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

dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
sense to move related declarations to cpuset.h.

Implement the move.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h         | 5 +++++
 include/linux/sched/topology.h | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 835e7b793f6a..c414daa7d503 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -125,6 +125,7 @@ static inline int cpuset_do_page_mem_spread(void)
 
 extern bool current_cpuset_is_being_rebound(void);
 
+extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
@@ -259,6 +260,10 @@ static inline bool current_cpuset_is_being_rebound(void)
 	return false;
 }
 
+static inline void dl_rebuild_rd_accounting(void)
+{
+}
+
 static inline void rebuild_sched_domains(void)
 {
 	partition_sched_domains(1, NULL, NULL);
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 96e69bfc3c8a..51f7b8169515 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -166,8 +166,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
-extern void dl_rebuild_rd_accounting(void);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
-- 
2.48.1


