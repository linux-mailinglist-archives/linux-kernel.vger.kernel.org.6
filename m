Return-Path: <linux-kernel+bounces-560068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACEA5FD31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E963BC377
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333D26A086;
	Thu, 13 Mar 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDmC00yv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3E26A0B9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886018; cv=none; b=l6wTuNy+In/raowaD6EQIWTYVlqBIqT5llfKAhyjz/NULNkRCCX7f5ud7J3Byid/CvaLWDKQOBoHb4qLhW9d3RdiOS28Zj/HMK1bbUHn7bBiWZMjw3It/Gtp6BZWarRZz5ojtq3JXmrG9jkcMrgUYRPi8tJlsZxZF1yqV4Tezl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886018; c=relaxed/simple;
	bh=WqHYUTx+eFUkw2RW2AHRWFLhORx7kUJq9HKMYWBIj8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/Ff+ynD/+PAScLZFOSGfLYUCUbc8W6WKRrRQLz21zJx5HtuUFSJlHpwa+ydkVyONyaDrs5xWFe51oZB59lR+Okx/8kEaZKQu49ZufPeoNMG2gB7ROlEjsP0E7ChNwAZPyJL2qCLTXcvk8QkPee8aRZd7t0ZOdYwHFQLYNBt5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDmC00yv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741886015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bupEj0syAwoPVUhQa42XfJiVX6UxcC7+LozYYJO5dvc=;
	b=fDmC00yvJpzWfH2b7kWRpwd/4Ml0RTjEEPjfqaTLhAPhsqj5ileVqxCBAPZCtu+X52Bk1T
	3/kaAe71yF+kFFcOVViobWaG8bzTGKj92v1+rURe92PXZ1O+1uyrNnZy1n3DwgjakOI6pf
	IXVzQ0f0ZHV9tDaCpX+7dK2ovoRjndw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ozECKWT3PkK2LVhoUlp2fg-1; Thu, 13 Mar 2025 13:13:34 -0400
X-MC-Unique: ozECKWT3PkK2LVhoUlp2fg-1
X-Mimecast-MFC-AGG-ID: ozECKWT3PkK2LVhoUlp2fg_1741886013
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39135d31ca4so650765f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886012; x=1742490812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bupEj0syAwoPVUhQa42XfJiVX6UxcC7+LozYYJO5dvc=;
        b=X2vZT3K5nS9zd0b/lFdj+9Z/LmnTtm/h15ZftVBriY1+nHX3n2MTvu8oaXpHzGkb24
         kF8+qiC4i83W/QO6LSsbteb5n2WaGSrfXZxiEyFzUZFOCiRbETFGOOJJQPSVFh6Cf2vR
         cLyCVjG8KhlC0QzVVOnyx5ansXX+AjtrXRWKctTR0J7Mdk4kbb3aqZBS7a0r8iXTFmOK
         2C2L54YhpK3x3JyrTmuqI2CEnuFJiszomBmn/LpFBGLjgtHh2YfDjzQtIoS+6oGmbLDz
         P1kzGSX1Nmqrx0UJtmHagyBz2s5LCdPr2JIpOTGblIdJr+duYPzAKoyaJK/gY5CQdVXn
         gFfw==
X-Gm-Message-State: AOJu0YwlYo/URGXiNmK8zSuYjVf8lZtEVyUr1RXxzQP9DQSY8NRN6wfN
	bBEwyyFmVv6o4sSzB9fUDFT2UWotA1TuaZERdXHrRRprh/dKRWzIjAfqJH1pgy40ABRx5os1hlE
	pZx2UB+JhtCcNkMOLBd6o2RucqfENUQAgFGzMCbgIsIfg8Iod1HuK8JAeYSQlfDpBK0XbduWYrv
	1mABoU63xN5eoN7GGGiuxGhtMzU8/G7RlJvf41YVsZI9A9lNL9
X-Gm-Gg: ASbGncsKod0hOLP0/Cl1N2nbweYPbZbc11yWXySD5sYN7vZElSgY9baI2q5Tdr4gGB0
	BC8HNkPsnSvQ65FxF9aCCHNDD228HiWP4c4eR7t30S67ETL3hBah1AF51tRhXdKSEvioozBRKnJ
	lTj1zL6CYScmNQRWdvQ2LJRguhvnSiWT+xLW1uSHwNDh5X7Uk6NTCRff6HpAvK1CFHHFyQOm1AO
	SsRu1NR9QjPbdr9RP3ODvKsv5ccN7CjVPy14U9SGOEXe9f3PBRIGd6JFEeoejLzUAmL99pOHbOm
	tB7AZIHTfafhe91sr7yX0FwXPxHcR1chNYtlq0DFz0g=
X-Received: by 2002:a05:6000:2c1:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-395b954eb19mr3355841f8f.19.1741886011980;
        Thu, 13 Mar 2025 10:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEEnc4cttulcmus+Fv0WW0T5aRNhlzgKWFpdFHOzzTN1NDvd2Ek9XGkn5vqNfWrw9ReDOVzw==
X-Received: by 2002:a05:6000:2c1:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-395b954eb19mr3355799f8f.19.1741886011521;
        Thu, 13 Mar 2025 10:13:31 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b70sm2787906f8f.30.2025.03.13.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:13:30 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:13:29 +0100
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
Subject: [PATCH v4 8/8] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
Message-ID: <Z9MSOVMpU7jpVrMU@jlelli-thinkpadt14gen4.remote.csb>
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

dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
sense to move related declarations to cpuset.h.

Implement the move.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h         | 5 +++++
 include/linux/sched/topology.h | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 17cc90d900f9..5466c96a33db 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -125,6 +125,7 @@ static inline int cpuset_do_page_mem_spread(void)
 
 extern bool current_cpuset_is_being_rebound(void);
 
+extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
@@ -260,6 +261,10 @@ static inline bool current_cpuset_is_being_rebound(void)
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


