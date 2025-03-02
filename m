Return-Path: <linux-kernel+bounces-540785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D3A4B4DB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC716BB9F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC011EB9FF;
	Sun,  2 Mar 2025 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ign2MD9a"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07011EEA51
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949553; cv=none; b=uEJnHTjLfoQwl2OwajBAxf+TzP2vnDU8FSCYAnydIm+5ydjMZHhnEFQPdKjNjk4B/VhoUQ5fE2gd5luHygQCQq8YgEY0PZzSdV/oh0xLlpKb7SlhkcX+LfWDkWlZ2n7jLdT3cWRKhca/yt6visb08DnssSLtJH2exi/mKEexsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949553; c=relaxed/simple;
	bh=V9tDjb3FRXiUNX1G6EF3G2WC8Di0nWlqSJnRURIssMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnl4YlYjjOQOcLhwTVwKYXym9ca1zXygYypTPzcKfe2kj9NMb4pM9G/hl3Jbui06dYM7vypWS4h/e/u37st9g2FiPLb8leZnCwA5Erd4Gj4+RMeKdeS/KunMGcYEUjonio5Tt8xHSwjY7utc78JrlWosP3PcTeEOMzWVw1EC+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ign2MD9a; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390edaee0cfso1717822f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 13:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740949550; x=1741554350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77SPkZNldmHxco8GhowPmzvPBBBG99U0AlIpE+I1iiY=;
        b=Ign2MD9aiDPH8BWifXH8j7cRr8OV89o3f82hkVKEXBxMdXyAWDLUPLNTxzviotxGCQ
         G4Z0luYd036xwmD+D8b0py9vUabUcc4M02jTwfJPv8098EgTeJ/l7LvLiTZVPG6uTDJu
         PQbImb94NEA5/+6wccV/tUWTqy/yzMOlVmOwSpc3jXYK+NxfHLLDfsrbzzBIE4qoRDN3
         tqzhfAGTAhfGh4ZfTrIcb0GzFSRZYt9g7kxYORWjgDY+jp2yxzW9JABzdMl/4aNgyLCQ
         km+iY6ndrY40x6npOV0j0TSqw+cKtEuXgQJxcNPqhPZS0DhIkB7xXAWntW6mfSV0Elna
         qL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949550; x=1741554350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77SPkZNldmHxco8GhowPmzvPBBBG99U0AlIpE+I1iiY=;
        b=biPDOcsK7MUpKRFP+kfrPcxkHAnnpo1V/uJ9JmBnIlAtRxUwFtc7/L98smv3GsHcsY
         aqJlffH9pEbJ/Di2I/Ca0fWaN08VpYcrdVtSrT16gawi+ex3heC9CD/Y2MJEux4aevjV
         1CrOdGJNT1NAlIcKVGmBwymuPl1qprmkMS5rNm5Pk4/6WD/Zg+4pG9KeyjXDbfC0hx+M
         BQFPj/N/eixQ9aP2SycPkIm+2KM14S+/bM+PCZJcg3FOoJ5faAOQdYcHDGihP3RExUtC
         J/hIIjW7yapr8a+JYPhhoUMOIuozEaRDQALTOIWpE0fBUTJznMWf0tQMhki4U+XUYDo1
         qrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXenUBNIdvZseKZDjTWQgWiiWJbBLQO/1owapvNh9+z8VwM+9sS63zXDi6u6vLQeuGJJRNpnhg7aVSdA4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/CxGL2zI3TpfUtGRpTtE0yIBLRM4VvomQFiaLhLhsq6FdujT
	StVTBhDG1HuVlMW2tCLAkX+DRC1eJ0t+tRHdXyioOUdLm15Di6/gV5LxteuZt2U=
X-Gm-Gg: ASbGncur8g1R3ydfeHo1pRhFdhalRIE/z7SeUB7cgHbqyTG4CtrCNF+Lg0LtneHfeDe
	CiIcnmIxl9lz42c1nr82bXlKAwhN2HfjwU5N4QUcyBx5F1bCTpZA9yMkfSEUrIAvYQoJepy/6K6
	l5E7d793DGceFWNjfwuyxAcTLPd8ru8rgcyXz6SHHeERW0hcT8Pvhfv7YTjaAwMFWNuhRwwr3c9
	k2YKAsp85o+Tl85+DGSYWCVI/VAEPBK17uuD3iJVp0c1Z440YWhdyts0epDDb5drReD+bK32Atg
	LUusGIIlhpvUkgjO049239aroKqo6uViwur/5UYEj3l8MKKVUJuQ
X-Google-Smtp-Source: AGHT+IGK5wekiNqAoJE1NYQX8gdazZGXPjjRXEstlsyt8yut0bKqVOabEsssGAUTvvcSf1utDCYUvw==
X-Received: by 2002:a5d:5f89:0:b0:390:f6be:af1d with SMTP id ffacd0b85a97d-390f6beb35bmr7061041f8f.41.1740949549895;
        Sun, 02 Mar 2025 13:05:49 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e045sm12480923f8f.99.2025.03.02.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 13:05:48 -0800 (PST)
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
Subject: [PATCH 4/7 v5] energy model: Remove unused em_cpu_energy()
Date: Sun,  2 Mar 2025 22:05:36 +0100
Message-ID: <20250302210539.1563190-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302210539.1563190-1-vincent.guittot@linaro.org>
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
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


