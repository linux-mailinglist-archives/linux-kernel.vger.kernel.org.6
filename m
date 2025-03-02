Return-Path: <linux-kernel+bounces-540622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B4EA4B2FA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF5C16EDB4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F208B1EB19E;
	Sun,  2 Mar 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmMnDNGq"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C51E5B9F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932015; cv=none; b=QpQryz54hLkATjSYZmqfdkOgS1kMF+Bp0/paruzaXMZ2G9FXQWXi/Fz3+598pTOmDGN28W6DxkBfl0nPIU2vQrTR05hXwe/wA/fnh1sZIeli5TCaF06nnlIubf0jbW80uD+C+w+/eFbEm0VF5uCH8/GKt9OolS2myFcWSLgFsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932015; c=relaxed/simple;
	bh=V9tDjb3FRXiUNX1G6EF3G2WC8Di0nWlqSJnRURIssMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEoMaoq9zLwLq/T3uQHGzF+Aay6wrman3mlue9JTC0Mx4pfmUZbgkKoFrnpMz98+Iw8KeYoID2o2FNtGC4Ov2bxDQG/OwJWQZAlLrD2TpPynKUIFiy/TBby55ARht30qtF9CywayTUkhL4I4NdCRHmKx37+kw1DHvTgeYXg16WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hmMnDNGq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so32828965e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740932012; x=1741536812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77SPkZNldmHxco8GhowPmzvPBBBG99U0AlIpE+I1iiY=;
        b=hmMnDNGq5pWtviKBloyJNPVtoPC+gDnwmt1qumM3lxLC8NDl0oWWhUJbfb79zJ8i/R
         EtrgzooNiFjeb1qZKUFUsgFBi+A7c2j1TtyMs9T5LrJPlq6LA7BY4TieNYTgERJq9Ei9
         3v0yMMoxxtWzWQNCCUpLD1fYUtPbf8i6cNsSI75s95Xzs4pl9lp0bfeHON3IcvaAsrwS
         DIzpYlwoiwIszMkvdKlYNs2EdPmXIfP2CMoGJcn4Icyf5VREqiXK+EfnQx2UL0VkAltT
         nfoTLjr80X/HgvDUh0Qc7zRPKsYW6g0SDzh77CdgJwH2wC7rvqa4DZQ/ffITiQkxFFMT
         gnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932012; x=1741536812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77SPkZNldmHxco8GhowPmzvPBBBG99U0AlIpE+I1iiY=;
        b=wm/t9ZKnKXrm2ZaUp03lvYeUtg8XZRwq72Aiw5FQI6ZDG5B05OnIXyx+RAtUQbKIHY
         dwOp1r2hb4NgrWV6XJrFO9RJhDfAwAKmWtCaHwccHfWOuagmGG1fOC2YBgrk1ABESLd+
         U9gyNsNUGbPEFCx3xjesnKFkqBJf3/E9U82s1y013Kq59CP4xEZF12stzm4Jw8+p3qVf
         KLJa7qPlNxzrsRDxR9qLS2BO6BeF6GzUixX4EAE4gIehH+L1woyQQZupcLdV7p8jNYZ0
         GnClzeNlj55EQ1BboJMuhwgQzzslRgHEnuB+O38GwYqJDqhoZm9kXWQx32zWHqDmHPyR
         ynIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJJ88NZYVbwn4sZvk019//4GiPB6BucCaPHIAaUaKQAP3NUNKPn8EdMHRUW0TfHaKIrQth9jHBIHwSgAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQnxm9O3+hM5u6mYAmeKMludYeT0Ce18VMIjxpNNswMOL/BrvD
	D5gXy7UHemNFf6E+dSs+ubsLS7mJWF/a2VZjthgnEZYkY1st27fHSBmXCZVX5XQ=
X-Gm-Gg: ASbGncu2042KFvkiKlnVK+5a+ayDLvdb9tPOd5dn5kcxP5UGr4CNWsNBOHaewLOMhAS
	LbhuVcDScXg1UzeJ2Jjtho7D3VRRs1lQvgsr8U51xUkpUlhjrlX8bdvedAXe/5BYvoljle0qXQ0
	m8s6SYuWiKoi1XCOYym93K+07UPOXBIWrH67WyMSTlrFCX+O6jHwsZQ7WLu88RG4mBk8NWahAne
	MBtHDjgpCUbfmvPZJXgL6uCa3Cv0rIE7H4z1iCvGLX8nNBB26iruWJ+k7wxGIB8mE78Z24WgPg+
	3wsincDqMUnXcgpkLC+h8THr7jz07Bc0IJcsGRjKJrsQ2HjGQkQI
X-Google-Smtp-Source: AGHT+IER/CQiZhocFwMLy+qnuNJd9Bery9fW/SF2VNMD3kkenFDF1jQlapgLJ9M6YbtDy4pF8OGsPw==
X-Received: by 2002:a05:600c:1907:b0:439:9274:81dd with SMTP id 5b1f17b1804b1-43ba66cfe47mr72666135e9.1.1740932011667;
        Sun, 02 Mar 2025 08:13:31 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm25530245e9.18.2025.03.02.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:13:30 -0800 (PST)
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
Subject: [PATCH 4/7 v4] energy model: Remove unused em_cpu_energy()
Date: Sun,  2 Mar 2025 17:13:18 +0100
Message-ID: <20250302161321.1476139-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302161321.1476139-1-vincent.guittot@linaro.org>
References: <20250302161321.1476139-1-vincent.guittot@linaro.org>
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


