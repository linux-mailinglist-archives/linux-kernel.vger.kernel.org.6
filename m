Return-Path: <linux-kernel+bounces-449556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBEE9F50B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44A11881439
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7901F9402;
	Tue, 17 Dec 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqCWSeKa"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61E1F8EFE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451659; cv=none; b=puIvZioI8DRlkZtWwPQDM7AuHtKhJDVVzlkaRGoeizsvHXvvE3+wZ+mqF3m8fdJnjtFwmOm0M1M68jjXTC6rgPgTAgsBLI3nK4jtTnxRSsZJGoU34VZCiCrbgOwAN5hpaf/ZdcecHfJAMQtKFxeIMfLNizGK4BhkbZHWxGmMgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451659; c=relaxed/simple;
	bh=Rlvf16Hma2TQfu1eUyAJ0hT7CfYXyh1XRt33PLkicU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cP9wYJThvH9+mzGQkAiWguQCgvsxwO9Y6TNnipNC1Kgec1TOpm5VZFDhRn99cvjsA7350gF0iXrcdkuUnrrkJNxcDAEmRiPV2eLzwVxtt9r4sBTvbsj0ECqkgsYC91bv//OOpBbqilvKViiJs5bJAH5HljtP5iI97Ke9YkqG0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BqCWSeKa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361f664af5so59898185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451656; x=1735056456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EinNXaAsRN0AC7AgEijgQ+kS2aGRY7CXUHE390ZjvwY=;
        b=BqCWSeKauhlWEsGnw8KvkdT/hsBuD/N5CpgzNU+zG7lj1pLSfqpCSarOEy6xN8CCyF
         jIScMgY0NJbh2xDu4OOkBEtjdtcLX4H1UsiV/stq8GCvxTknQgVv46Uum8hgZqBDEkhq
         5cJsmDlJ1lXCGkacvMyyBmG0iphfpjg5ktdObIxE+64QhYaQ4QnggPtjMMoY+9kYSNR5
         CKrCb7iVIbIX6bZr41EbBYRjB5NMjMOcBezO6jH62Z2CbVWuW56DIGTG0sM4YzbAPy+m
         SU5GZCrmezMwANtKyskddWtocXeExHZifTYUb9RxhLD/K1twudQsSWovQujeZzvlm8UZ
         AdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451656; x=1735056456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EinNXaAsRN0AC7AgEijgQ+kS2aGRY7CXUHE390ZjvwY=;
        b=qK25KrEbMfOfs3P87zPiZpt5HBd5Icef8ct9bbw98QNUo69BAg4L91ydyUvpo0WjHC
         eOvVoT6LZmSRn/myhzi73FqzQPc8CGM15042ol+s0243V6VOeePX5b+NyHxZNf+04anx
         jxqG3HV+3iQZ4WUkpBA7M2aI1lgDwcNqNOnJdas+ISGK1kbdyzhE0XseXI9k3C2TPkW3
         Xuu4LHht08f6B9Vurky5uuLUZ2zqD6fnHzxdY3VUhWjYk9zvSNaxzixd3intEGwJK/14
         x2IluJRz9UeIBzWW8b4mDvmmdD/42jeeKgE0U2IO8OSifvrflmSJoXC3zn6PM4rPvc/s
         QQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLsAdL8+BCVaDLqB/ZngylixJEOIhtGoD1wTY2FWFvZh6Ae86z0eLJEWFnGjeyURMXvzYP1L7pOopOkCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtTZjwkPEEjU/YKM+gTKX6LyDWEbbrYAkeR5PfizfSYvhyaZR
	kNbQvoOkpsVO2H05QA/4wV1Qt+PMtNdDOgdGLYL4Jt1+8IYNPoxyG4brMesyIrY=
X-Gm-Gg: ASbGnctiaNogzVATRCN3VSGryoynudOSSl/wx2aCCel1hvu1YS75o8ixIPXHrTIWXN/
	ygmfD7xkrrcPMNtBk7sTYIS+SWfIbHW9lArnC/0/+QhxcHRF+W0L1x9glKS2Qu+dyVbzVyGeNXH
	eD/Mvh6KzOG7JPk8tLCsDqD0JmexUeGGtqzoVAEPd8XOgbalBIWd3jei68kH/OjiSVwXnJq6JOS
	WZOADZB4DNAo5SXSeGaBpILPg/9gV2abD5cVAXKsj5g7sjrvtTegJzKU3sHebcCeQ==
X-Google-Smtp-Source: AGHT+IHbBs1v/efZy24EpNT5C45sG8Ubu+JFT93jHjoobDnm7J6fypTBvwozXSPu8ccgXzcREUn4NA==
X-Received: by 2002:a05:600c:a014:b0:436:1971:2a4 with SMTP id 5b1f17b1804b1-4362aa3d7e5mr159051665e9.17.1734451656095;
        Tue, 17 Dec 2024 08:07:36 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:4e5f:e8c8:aade:2d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257176a4sm176739435e9.38.2024.12.17.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:07:35 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	pierre.gondois@arm.com,
	christian.loehle@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/7 v2] energy model: Remove unused em_cpu_energy()
Date: Tue, 17 Dec 2024 17:07:17 +0100
Message-ID: <20241217160720.2397239-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217160720.2397239-1-vincent.guittot@linaro.org>
References: <20241217160720.2397239-1-vincent.guittot@linaro.org>
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
index 26d0ff72feac..c766642dc541 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -235,99 +235,6 @@ em_pd_get_previous_state(struct em_perf_state *table,
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
@@ -394,12 +301,6 @@ em_pd_get_previous_state(struct em_perf_state *table, int nr_perf_states,
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


