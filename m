Return-Path: <linux-kernel+bounces-553863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CE6A58FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A675B188E842
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22200225419;
	Mon, 10 Mar 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWw04myE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1B2253FF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599667; cv=none; b=PuGYdjZIosmspJD7+TDVp+VHzjPb2qJoxIQw34CDnO691urCXHzTCV5t1In+uzWvqV9NZbTsswPRhSfm1LtTopfKP2PMQTMhRbQhEym25Sh/3npciojohOXqYygQadOVIJPiAu22oX6oiiCPhZXhvD0CmN/liePKGty+knHDu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599667; c=relaxed/simple;
	bh=D0qnJuVKmT1hoAQ/CBLa54Ot/pfZ5sOIHU5WXg+WzfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVbyLR/rdFDdMIfeYNId636XAPKibeVQLOx5qsYqGb9QGKQTgw38jv1vr9IoHV9LdIwD6UnzRtZZkRGY7ZlFi7cYbyGO8OBDwr3vAZwTCpEazu8flJWietv5pVvQwPoTtPz5W31Ow82n83CZ/sky0CRiEyDH+D2BPX74OP4hcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWw04myE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmC4eg+RZE37SxbmWLTbwWm2ZOdazyFKRLy1uOVpLe0=;
	b=XWw04myE6XrFvRc18xPftt9rcsHyscX4JMtK/3VFh+GrzDK+5zykwsGvg6/wMFNPs2QdE0
	b3Fq4NCV912seTCrKCf2tIL553ViN5i8EZOBw41eR7VYZQ5YL+wGJpPL7VMq6I+K4G/Q/5
	0YJnZjRe5rUgnQvKAig8y0Qmld4p0DE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-2qQyJSP0MvmRYNwqRHZsNA-1; Mon, 10 Mar 2025 05:41:03 -0400
X-MC-Unique: 2qQyJSP0MvmRYNwqRHZsNA-1
X-Mimecast-MFC-AGG-ID: 2qQyJSP0MvmRYNwqRHZsNA_1741599662
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fe32a30so1404977f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599660; x=1742204460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmC4eg+RZE37SxbmWLTbwWm2ZOdazyFKRLy1uOVpLe0=;
        b=l+JErkgCJN+LX8H37TX53Lfpa/YBx2vnVoWL6TkVPVp+BH6Unj8wo+HouK0WfXvoOm
         6GCFwb8o2eFaf9toPtbsn4lewxPMl7fYQqYl5zn0CPc6IC8EitWjzxiCYMg1jtcxroM6
         +CH6JyVFYPO33UaWeitsH+3CveJSzyyCBJgJ7R1+vx4r0mBJkeJnaQZQaVL8xFXPl8/z
         D8q6ntE88IJhZwvY5pB58+NC6DrTqkxUT3PE8gAdCd2EIv+PKB7dumacjxuVHiDvCF3U
         QCgUnQyqfRutg78RMJ2bcverZQDtwLzvH1OXPgwO680rqYHytyY+FZYGKkG3z0s4N8ZL
         N48A==
X-Gm-Message-State: AOJu0YznDeLhanE7SlwKGBcaytbT/XdHBXaDdARDV7Q83NBwRfjvYQh8
	8Dn8HgLhY6Kc1KiQlW3c0Enj60JD7suvUSZIQzlZvlvPBT3mor8/Wb8A84a4zI94Xa8vpGOgaa0
	RhBcKVwRm6fIjIMlp8aV22u0MKYp4BSiBaSnlkMJJJUrGh30P1jTbyYZkjKk0YZXAIvM0HHgzMT
	hVGCJlzGkgNwvrWqcG0kMceFUXlVoRFyFztOjN9lqam6eICSrNN6Y=
X-Gm-Gg: ASbGncsei7tDh8JGlmEZgwNquo922fMOiBBqvppKOg3+nowvDMDiwGa8PjMXvDUq367
	RO0zdqflL6o8D+NNEzs8MkVeNTIrP8lZ3FgCh4OHlTtodjiB9j7vufF3lZ0Rn4pvBiDffcTpMpe
	/lz1pdCGSoXgEph5iVWBB4hAuY8UPJD9EUWjT4Ggu3tk0NVAOxOcDUEuUn3iMTRi6yC97TeSQ46
	4aLPU+ef4j/8rPotEsEslyxVacBxwBuN1OmkDPyrP+DvPKZdBNYgrm3rDbazuvPrOQqS2HMf4Fu
	lAWdzZQAvL/spplI04BTNUDDZYAz2rvcfq+7tqIureU=
X-Received: by 2002:a05:6000:402a:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39132d67e24mr8087694f8f.9.1741599659846;
        Mon, 10 Mar 2025 02:40:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3sT3VxqRqGbVJqED2DrKV+dHBvPin9Rx9+sU0PGy8vpk5mvBzNmpBa8T06MTqckjUtnwpBg==
X-Received: by 2002:a05:6000:402a:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39132d67e24mr8087654f8f.9.1741599659379;
        Mon, 10 Mar 2025 02:40:59 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7934sm14529582f8f.12.2025.03.10.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:40:58 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:40:55 +0100
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
Subject: [PATCH v3 8/8] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
Message-ID: <Z86zp5ej0shjk-rT@jlelli-thinkpadt14gen4.remote.csb>
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

dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
sense to move related declarations to cpuset.h.

Implement the move.

Suggested-by: Waiman Long <llong@redhat.com>
Reviewed-by: Waiman Long <llong@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
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


