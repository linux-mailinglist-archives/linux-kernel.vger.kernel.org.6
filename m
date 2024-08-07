Return-Path: <linux-kernel+bounces-278437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950BF94B042
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020FDB258B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEFC143C57;
	Wed,  7 Aug 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXbLbjLA"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB78163
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057534; cv=none; b=nHYnzDNtQ/VCKCNAAiZypqFkHJdb6Rw6WYqeMdJrfks6y78Q+Y7bVBOm+4Kk5S21WaqJziuweLBWxcCTwfyT4+Gq0QZf+Nqpx8ZdDEySifJFM+O4wDfiZX6mQdn2y4xYXs0eLPgnjKmmH2BpPGMIjqSgRefR1QN9KW/MXOjc/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057534; c=relaxed/simple;
	bh=kGlgsQLMgDQ9FvUpMspEvNg1mFjz4e1RWbCwZIxjSWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZg+OhIVajSjyX7wmOEThKXs/dqpDyFU/bwIuNOLhOjipGhLHjS5VemVcRTnKdeE7RDEhlBkNvkPBtz5s4S5oVJQIa2GDiX0+52KS4rLS/0UPHpTFTirZhA62uFrbMsnmIsnop/e9HJWr9TLQwZleCtxc5PTFWnauFMB6C73ph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXbLbjLA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-656d8b346d2so121719a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723057530; x=1723662330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO/uXHwTaQnApHHXM2dwVTEOkF4Fz3bQoqmBiOkUQD4=;
        b=dXbLbjLA4jGvbptzRtJsXNgJf+lYhsTjw678LyYXjZybSbuc5ARtneovkxIXAhdmZx
         hRTOy8/EF+cHbroGjmEWwcGIFyjl5N0aWaKh0WHo+Egk1a+vf/9CgD6DY812qSNMc7qX
         Mqo1mvz4AwAZo44jHNMmr3Z0j6+vEsV0h/Ei3Ke1ZXu2WGnJ147TBjBOQoqrMVKJPlKs
         aZbuy+GINKE411BMwqi3z4obPmi57LtsiJ7bn71jpd3/gNREoqIOeJP+Xtdzh22YlTtn
         3CnE2vwUMDG30IzYgbOU7dZ8zaKG/BO2ZGT4bETxKyBWiJV18slHWyzUH3GaOmmKBfZA
         54qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057530; x=1723662330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pO/uXHwTaQnApHHXM2dwVTEOkF4Fz3bQoqmBiOkUQD4=;
        b=sBGBKAdAjYKQ1P/4deksQXSqTtD5G2S7tsKt1LhJjwJ5m8o70gTM6XPJGxVMcEWGyY
         mTpWRiG5GSx3vvyhn8u8jUJAQj5YS4SvgoryundX/s0zIEc5CYIbO/BjQC0GcryTwSod
         40Ms9wAKNJKmB/SBHWEOfsMPSi/ax94qDM5FJc51BklT6lwm+W20GpMjBrNhMJT+zBcR
         nY7rOR8OzqNqoZFa9/RMFOzq6xo/2gRHz1W8Tcl/CrjLYiyAH7Te7tGmUAA5akphF5vT
         jiXi8JcDXs5lIbHIVoMPxA7Bn38TII1zLzoI00EbOm0TUXaUEOBrATF+vE1ZnKzBtKuO
         JUhw==
X-Gm-Message-State: AOJu0YxG3KkY8fCaqg+fp3MGCSaoUU3gKX4aovNzIfdjvDy0En7/7bAs
	i8vsrmntJsWh91MPQ73ssVwIFXUa4/k3cwZnNzKZw4Xd3UNTEWxl2P+xJaxq
X-Google-Smtp-Source: AGHT+IF1JocH9w109P6FFoz3xJeeU71EDXOYvkkIRlFHm0qDNYis3Y8iRTbjy3lVIsSEBhBdDDjs+w==
X-Received: by 2002:a05:6a20:6a07:b0:1c2:8d33:af69 with SMTP id adf61e73a8af0-1c69961443amr22164571637.41.1723057530381;
        Wed, 07 Aug 2024 12:05:30 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece0e02sm8727152b3a.116.2024.08.07.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:05:30 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 1/2] sched/topology: pre-compute topology_span_sane() loop params
Date: Wed,  7 Aug 2024 12:05:20 -0700
Message-ID: <20240807190522.432388-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807190522.432388-1-yury.norov@gmail.com>
References: <20240807190522.432388-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl->mask() is called inside the loop with the same parameters more than
once. We can pre-calculate it.

Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 76504b776d03..8af3b48da458 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2353,12 +2353,15 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(struct sched_domain_topology_level *tl,
 			      const struct cpumask *cpu_map, int cpu)
 {
+	const struct cpumask *mi, *mc;
 	int i = cpu + 1;
 
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
 		return true;
 
+	mc = tl->mask(cpu);
+
 	/*
 	 * Non-NUMA levels cannot partially overlap - they must be either
 	 * completely equal or completely disjoint. Otherwise we can end up
@@ -2366,14 +2369,15 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	 * breaks the linking done for an earlier span.
 	 */
 	for_each_cpu_from(i, cpu_map) {
+		mi = tl->mask(i);
+
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
 		 * match the topology we're about to build, but that can only
 		 * remove CPUs, which only lessens our ability to detect
 		 * overlaps
 		 */
-		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
-		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
+		if (!cpumask_equal(mc, mi) && cpumask_intersects(mc, mi))
 			return false;
 	}
 
-- 
2.43.0


