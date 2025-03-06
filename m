Return-Path: <linux-kernel+bounces-549096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4096A54D20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB3B188A3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE721FF7C4;
	Thu,  6 Mar 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwIbjDSh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30B1632F3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270280; cv=none; b=Op/aRLiN5CxsMbqzeOQCnNSlnPob8sOi845L2NcabybztE1KV9PqFz2/hZHvHJoJ0j/klcQ2raCbY96qEI8q0PDraue5O9nCEO2AvbDkOQ+W+0PB+69QVdy3X/YpTKncdScqBrnnnWOWfGn/rAqHPhexyQ6tufa9lFMqkYqbaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270280; c=relaxed/simple;
	bh=4bDzmWrpSp48TdjMHbBbRLXbqjOIhNsg93No87cP2Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFNtFr49QNa1gEaaQC86rPRxOCI7XtVPWZc5uYc+1PtEYJol6iDwscffk7Kxfk3R4K8Io5Tb4R3h1+bKTp75kvvP8LeyZFdYMrvyjsU1haiwHDeJyDUC1SvmjEiS+jm5unGkFXuseIjz2znWMrCDEEbSajBqgsBwzse0odbiBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwIbjDSh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7Wvt9bCpxa9m5FhJrFhPuBa/FfAz6U7Ug8gygH663s=;
	b=WwIbjDSh5KKNJBZAl3tou/t70pSlFkKx9wxip1l/Na+V8MZrlX7UsBaJSDRSksKuVbuR9w
	8bga1NzrWS4lriw86ZLml15XH8HPicgUl27vMDmfV0dUBbUmki8RHm8/u7RRX9vmUz2Lka
	iBg8KwP0hBvdOk19CNGix+bUqP+XT0Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-EH6XF9fjPAysG1QMsQOeow-1; Thu, 06 Mar 2025 09:11:17 -0500
X-MC-Unique: EH6XF9fjPAysG1QMsQOeow-1
X-Mimecast-MFC-AGG-ID: EH6XF9fjPAysG1QMsQOeow_1741270276
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3b78c7c4aso108863985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270274; x=1741875074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7Wvt9bCpxa9m5FhJrFhPuBa/FfAz6U7Ug8gygH663s=;
        b=ibkeCA9UQyq34pnfBb7HAZY6QjyzONOp+ZRV/oL0IYNMi7RTUPEfnnfbvz94HI5kAm
         Lr8gs7Fot6/d8B2oYTFrs7Zvq6rKLgK3B99fUPu1+T0mZgZoqVG/CFbS1nVuhIgOMnZu
         LQJG29Yh8L6K1kGmaoXb6NoMUu4GpO2CaUOVLj/0LzrUEX9v9xquGuntT7ud+sGY7KOo
         XXFWsBZkd1v+gbYm8yJA0QOgQozk/eZOl9HjWG6V8Cg1DPRyzvkjn6WTBWKObXFFK6Jv
         P45ULw4AN33JcF+TeXKZiogIqfl+XA+FXfSyNPPeLid/tAmHPFhTc08gbMPYTz99Iqmo
         CYvw==
X-Gm-Message-State: AOJu0YyUtSvR/Xzik83EzOWCNwFevZvkbER999/R5fW9djq9pvExJCh1
	ovfG3AxfnvBxrDsUriTrYrO4YMmbqYDGjZ077p0VBnAbUPqJV9hFL2lTlrkFGTzH1K7UIEoxCDn
	52DoCLe9xrBR6qKO21DeA41MI10tBmjK2EeqwnzyG/lD8IxjNOXSByIWk9ggtNczF/GQjBplv14
	tjJWKm0mG5e+JDEUT02hgkNnF3P04CPkhSpjp+VsKx/5zeBKEVw6E=
X-Gm-Gg: ASbGncv2Uszy3D6HUH9P/XbnSxc5O7CIR2DsWsHO8059pf1TbCmNiukgAWwXAU4btoC
	zfGaCDMbZt3IpVR94R6AW4qC3SzOYvZvjZN8q6ts8o8Ru7kQnnLmARqeSggS68W7svJD06BIMyU
	Kt7S9fUGzCfeYtc+0qTrqT5ELwUuRagC5WBF2NHatBDB00mpjZIXex96zlHQ/BK1zoRNAhYOBIa
	VQJg17Qgz+uSdku6Kw5WF+JISUwJSFPWQdI3BMCcwcG5hSsclk+V6qAqKdY8B0/5p2dFfeinzkp
	z7mgLNmswcwWpreUCqj+PU56bMMvvY1rGCPsE0tJyHNytzYFa60IJx9P0XK8ML10dzSYfmrxaNH
	4chXc
X-Received: by 2002:a05:620a:270e:b0:7c3:d282:d2e6 with SMTP id af79cd13be357-7c3d8e6f751mr1067267085a.29.1741270274209;
        Thu, 06 Mar 2025 06:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGavNGLBZnGI8W2c5FsjQ9kPKpnQpHBXP0YguyX+7DGXw75Fqnh1vbSyiUv74NnxEk0kp8WQ==
X-Received: by 2002:a05:620a:270e:b0:7c3:d282:d2e6 with SMTP id af79cd13be357-7c3d8e6f751mr1067260585a.29.1741270273836;
        Thu, 06 Mar 2025 06:11:13 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:12 -0800 (PST)
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
Subject: [PATCH v2 7/8] sched/topology: Stop exposing partition_sched_domains_locked
Date: Thu,  6 Mar 2025 14:10:15 +0000
Message-ID: <20250306141016.268313-8-juri.lelli@redhat.com>
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

The are no callers of partition_sched_domains_locked() outside
topology.c.

Stop exposing such function.

Suggested-by: Waiman Long <llong@redhat.com>
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


