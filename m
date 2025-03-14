Return-Path: <linux-kernel+bounces-561798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FAA6165F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E3D4620E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1DC204681;
	Fri, 14 Mar 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpbCqaR+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A442040B9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970187; cv=none; b=O72Tak1cyEzWFdY5CMN88PaQP2QtmeHWD0LaNvCwI9Hec2QDxQ6a5g0cdq1glBocK6juw9Ajfvg8+5Q8b/4MRv3PeDNkDucjmRI1PAinNBSN1ajTgaBRhjaYc5v/oN/Uz6S8qoZ3h7z1jbl+pSnmzNU+KzJfHC7sHr2duQSGyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970187; c=relaxed/simple;
	bh=V9tDjb3FRXiUNX1G6EF3G2WC8Di0nWlqSJnRURIssMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzJnuL1H9DrDHDjn3IT41AZFa+M53WOwWPlqATHhB2vifVGK9KNnx8OU710LnEc+FYKCIKnry5NvbBV+HmVht/wgKWJh0raMtrPAMHks9FZwIqDQVZNgxm52dD7BgpS4wdKSz9BynhBlbzoU2nA5MwLdXGZcljL+fD/Qxb88qAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jpbCqaR+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394036c0efso15619185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970183; x=1742574983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77SPkZNldmHxco8GhowPmzvPBBBG99U0AlIpE+I1iiY=;
        b=jpbCqaR+2n9NR5UloQpSwRAigTmaIzFx92Er6ZF7ITkjCN1AU/u9APUn34TZs/L6KW
         adWydoYSYOpjPG+zBuIcqzrjVnE35FiGz7DkBq8yb+jwK5zx1qJrOeai29Vxl/SqaTAA
         /hXjZEtF0g5hK5Fd7IkFs56tzBTff0mDfLrrYm9KMa9kz8L3RH6xa2gpedhd+j3NhjCv
         N+pw7yIukA6METRSciqguPftEnKSisRv1YH7E5TjnO9i8piFdoW8EifnzRMGXZpoxWdQ
         D2dLKPShYwDhcF8c3Xzhs+DPVvzsBoz+jx0k7SDvUe50uwA/FXsJWhFgk1aJhUyThZML
         2HMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970183; x=1742574983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77SPkZNldmHxco8GhowPmzvPBBBG99U0AlIpE+I1iiY=;
        b=YjtmrayzOmrFw+GXkMozYArZ5xwbq7AeD7JYC3Cst42z0/fGSb1IpSpgt46dCBTZqI
         cl0/b0EOX1VnP8syeYFBQ7++Zh7rAEKUT0yr8QQ3LfNEW9rj1RVs+WGzVqVa2cEPJr82
         Zt1dG2Ha5w02Jc/V4z2Hr7lu2n7CBI5+PYUtuqRH/jNPTRqCCq1SJGrP/Hr6LAD6hG1g
         6LXHU5UvAjvUB0LAvSwXAMh4Z+b9eO1RbezJisW5i1PzE2+DZb7ESaZJHD+by9TOIULD
         sPLESPDes+tngkv8g6so9GwXlN2GpMTZ2pNfm0f1M7IiSyYtLVQV3snV9ySlDqtYvORA
         RU+g==
X-Forwarded-Encrypted: i=1; AJvYcCXuMsBeO7x4t5Fqrf3kTzU1qOoIN+BEJFUZc/SJFa0eUV7cNycYJp+LLlqd8mRPsZLBckIgXXzgAC5MxF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxty56Yhkt3UrsiF3eA/5kzEDSxMXk1YijztEHxZRu/9sh9n2vJ
	n4wcZyknWXglKBkCPlWM55eOsEHDCNB5966f9Wmqnav3Ka24VH5AI8ltsqJvyYQ=
X-Gm-Gg: ASbGncsbHMdRlhl4M1JqQpu9TAIHtvqGSOljS5RjTFWqzRzOyj3qU8PplbdBoeJnj6T
	ccLmxlAVqgBTyhUYe5q1LOmUbi78/0KTVa3q3otYxRK6jaQGQoeHGX3HXf2tHMMiwIugjZqtE/5
	I/0ysL0MRD6UaLWgg5mDZ76lq+LL1FHHtFicJ+UCOQoqk3+vUhZLolkGgqCCyjW7RvooQ60mvqR
	VC9GXbjvyr1M7V8Nvc2sRnZwzw3nBDUipmbQtv542lMivkdvMIDA+krl6B/nOowMrvMOiKPa+3p
	YmblZW+itYWpQG0o6YMAFIvIZVgkDJpb3uY0JX4PKEepf+O1Py86
X-Google-Smtp-Source: AGHT+IGLcB66jFty7SmLoFDrxbGmK12tydtLPNrviGBCwl5ICgT0Zi1i8ozVSW+qz4Fk9UhL6bGBgg==
X-Received: by 2002:a05:600c:150a:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-43d23137bd4mr21196815e9.3.1741970182967;
        Fri, 14 Mar 2025 09:36:22 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:329b:9a6:20f4:3754])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm6072925f8f.78.2025.03.14.09.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:21 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	christian.loehle@arm.com,
	luis.machado@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/7 v6] energy model: Remove unused em_cpu_energy()
Date: Fri, 14 Mar 2025 17:36:11 +0100
Message-ID: <20250314163614.1356125-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314163614.1356125-1-vincent.guittot@linaro.org>
References: <20250314163614.1356125-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unused function em_cpu_energy()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 99 ------------------------------------
 1 file changed, 99 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 551e243b9c43..d0adabba2c56 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -236,99 +236,6 @@ em_pd_get_previous_state(struct em_perf_state *table,
 	return -1;
 }
 
-/**
- * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
- *		performance domain
- * @pd		: performance domain for which energy has to be estimated
- * @max_util	: highest utilization among CPUs of the domain
- * @sum_util	: sum of the utilization of all CPUs in the domain
- * @allowed_cpu_cap	: maximum allowed CPU capacity for the @pd, which
- *			  might reflect reduced frequency (due to thermal)
- *
- * This function must be used only for CPU devices. There is no validation,
- * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
- * the scheduler code quite frequently and that is why there is not checks.
- *
- * Return: the sum of the energy consumed by the CPUs of the domain assuming
- * a capacity state satisfying the max utilization of the domain.
- */
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-				unsigned long max_util, unsigned long sum_util,
-				unsigned long allowed_cpu_cap)
-{
-	struct em_perf_table *em_table;
-	struct em_perf_state *ps;
-	int i;
-
-#ifdef CONFIG_SCHED_DEBUG
-	WARN_ONCE(!rcu_read_lock_held(), "EM: rcu read lock needed\n");
-#endif
-
-	if (!sum_util)
-		return 0;
-
-	/*
-	 * In order to predict the performance state, map the utilization of
-	 * the most utilized CPU of the performance domain to a requested
-	 * performance, like schedutil. Take also into account that the real
-	 * performance might be set lower (due to thermal capping). Thus, clamp
-	 * max utilization to the allowed CPU capacity before calculating
-	 * effective performance.
-	 */
-	max_util = min(max_util, allowed_cpu_cap);
-
-	/*
-	 * Find the lowest performance state of the Energy Model above the
-	 * requested performance.
-	 */
-	em_table = rcu_dereference(pd->em_table);
-	i = em_pd_get_efficient_state(em_table->state, pd, max_util);
-	ps = &em_table->state[i];
-
-	/*
-	 * The performance (capacity) of a CPU in the domain at the performance
-	 * state (ps) can be computed as:
-	 *
-	 *                     ps->freq * scale_cpu
-	 *   ps->performance = --------------------                  (1)
-	 *                         cpu_max_freq
-	 *
-	 * So, ignoring the costs of idle states (which are not available in
-	 * the EM), the energy consumed by this CPU at that performance state
-	 * is estimated as:
-	 *
-	 *             ps->power * cpu_util
-	 *   cpu_nrg = --------------------                          (2)
-	 *               ps->performance
-	 *
-	 * since 'cpu_util / ps->performance' represents its percentage of busy
-	 * time.
-	 *
-	 *   NOTE: Although the result of this computation actually is in
-	 *         units of power, it can be manipulated as an energy value
-	 *         over a scheduling period, since it is assumed to be
-	 *         constant during that interval.
-	 *
-	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
-	 * of two terms:
-	 *
-	 *             ps->power * cpu_max_freq
-	 *   cpu_nrg = ------------------------ * cpu_util           (3)
-	 *               ps->freq * scale_cpu
-	 *
-	 * The first term is static, and is stored in the em_perf_state struct
-	 * as 'ps->cost'.
-	 *
-	 * Since all CPUs of the domain have the same micro-architecture, they
-	 * share the same 'ps->cost', and the same CPU capacity. Hence, the
-	 * total energy of the domain (which is the simple sum of the energy of
-	 * all of its CPUs) can be factorized as:
-	 *
-	 *   pd_nrg = ps->cost * \Sum cpu_util                       (4)
-	 */
-	return ps->cost * sum_util;
-}
-
 /**
  * em_pd_nr_perf_states() - Get the number of performance states of a perf.
  *				domain
@@ -394,12 +301,6 @@ em_pd_get_previous_state(struct em_perf_state *table,
 {
 	return -1;
 }
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-			unsigned long max_util, unsigned long sum_util,
-			unsigned long allowed_cpu_cap)
-{
-	return 0;
-}
 static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 {
 	return 0;
-- 
2.43.0


