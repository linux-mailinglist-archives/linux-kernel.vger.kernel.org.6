Return-Path: <linux-kernel+bounces-538597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A6A49AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A436F3BAF88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916226E959;
	Fri, 28 Feb 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqgO/7A0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30C26E65D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750014; cv=none; b=bikBARZ0jHHM31r21sR8uEYdiLr8H20UsscfMTR02whG0t9ly+a5rfJSGeoEeUqogDPKAl1MjD36qXPIKbDPDxDY3BqKieRJ4zOv0elYERDAVoUzheHRi3mAl0gNKCmrtS434s+/QYdo6xXEiA/MxwzCM4kqPKUsdIxtcvc9eEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750014; c=relaxed/simple;
	bh=Xmva/6LU+q5ofCXOu82pO85MaWOQLN+nYYMzbRGjP+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZumqdE8CEnZB2vN6DL1AHEsh9XcBlCa5R1/FCLmIg3jZpIJcFUo8b0Y2CaPXeEHwMCY8ua9UXqWCbY/Vk1Kol4r7IVlCqGWMukknhFqhvgq/eK4DcMSQm1DS2DvHdLBKDx2Byt8UBKwjIwiArgzlRf2Wlk5pEWOY3Az49QWn7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PqgO/7A0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so22609015e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740750009; x=1741354809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK+rrGR2quDL9JjMcxK/liubM/wUresKs/lEfFGsSzU=;
        b=PqgO/7A0OHEdRMc5V56lggM8zCs7+HTzKfGQG6bUInUN1SESpyxVWbWtwG+QgXdHGi
         8ByfCJuxbiDJm4r/1AIUHwfnTnRyG/upOwss2z43jYy61bXM5Xj03cNa0t1+xIDTVsIu
         HZ1sr2GSrF0ZzkHn/1dPB0g0FT2r7m90s5zECYgnWcObCjNRwTmi0B440L8+SBtsVfSP
         PZpQAhUv+ladDUU0cp2ojN16cO3CNDN3kFY1xUMRb2GbLe7Vz5647mz1/w5PloV2hw/w
         kzGi/jNFKF7mYNb9jajorL5k119yl11z2qG7fPqL01LLVKe9fBsy9dhtLlD4aS7M5ZDm
         45kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750009; x=1741354809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LK+rrGR2quDL9JjMcxK/liubM/wUresKs/lEfFGsSzU=;
        b=vdmXwXuD9+OTdVy9WTr/UUEZijqiGfw/NHfej97p2la+MxnJI4O1jZ+bYfa3YHCBeS
         hHFw0DO4RJFe/vQBI2nmwVQF/H4K01nFV/oFWX1Qf8vGtO13VTRU7lwoQr+84M+YDfnl
         0RfyD2qhsK39Oevx9dcXEF69gZuCxOOGs2nR25IZur0No7rv3p55w//2dAab/xlPNubK
         +ouK3rjTyNZkq5/1qsOogKCDpdnB1IswLS2dRc0CKFFkG0WdL0azlKBMGabhLEPVV3Nz
         YzNfQW4sjFrpn2JJaXH2lfXpA44lSAwdeSz4OrhQgXXeUFaB8eBDnRNxTW9C+BleTfmE
         nEnA==
X-Forwarded-Encrypted: i=1; AJvYcCXN8td67VJhwXAp275+4Sk1sOJfCOcs2A8C+XdSYPv5ZWioTVxDIwiq+zxdhkOA4DOZrMCTGRxiDIyRb/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lLNxDiVGN6hmY+ZzrNUYF7d89LXXeiBdbcCbFYtYfTSg7i2F
	rOCsigC4qA7ao6tWUJQAWrOJ7eCzOaLWQ5EdXM4JT2DMeCU//dkNcOeaR9Hogic=
X-Gm-Gg: ASbGncslzkUa8gtoZVKokWU7m1ppU/5vUn798upVcA5JQjjJsSgkN9oC7v2IfaZt7p1
	aZG/G4WgzBcJ98kImCydR6DJkj4TlcQEp9cW4LJi5uD29+BDruR6TQwtp/W9LXWmbWz6LLhISAt
	iw73N+fHdcrq5KdNO4UfR0IJYvUEZkLXtNesjpFXzoDKbaQ4daMsaVSCh8ijtUB9ulGLroANARK
	b1fCPPD9ZQOYoMjE/DEPc5H10J1Vq1FNRnhlrE2MbKMUaB6PdAPCPfA8rUzIDh/n4MkHtDi5q3o
	br8aZ/FOkECH3RLJUqKwfiU4atbG0oAq2A==
X-Google-Smtp-Source: AGHT+IEnyzbCtUoYq8vfwx1B7Ej0lohDGCadUrYOnbl2iji40RWMxmCmoEcu4DiYubtSr7yGOHsTCg==
X-Received: by 2002:a05:600c:46d1:b0:439:8544:1903 with SMTP id 5b1f17b1804b1-43ba674c80fmr32058565e9.20.1740750009474;
        Fri, 28 Feb 2025 05:40:09 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d4b:473f:a962:e9e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm55984405e9.18.2025.02.28.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:40:08 -0800 (PST)
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
Subject: [PATCH 4/7 v3] energy model: Remove unused em_cpu_energy()
Date: Fri, 28 Feb 2025 14:39:57 +0100
Message-ID: <20250228134000.1226665-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228134000.1226665-1-vincent.guittot@linaro.org>
References: <20250228134000.1226665-1-vincent.guittot@linaro.org>
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
index 967650726619..441100686f1b 100644
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
@@ -395,12 +302,6 @@ em_pd_get_previous_state(struct em_perf_state *table, int nr_perf_states,
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


