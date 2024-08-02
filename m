Return-Path: <linux-kernel+bounces-272958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B29462C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205CC1F2235C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F14165EEE;
	Fri,  2 Aug 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6o0xiiv"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00E165EE3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621480; cv=none; b=Eai9w40ILiSPQdRZUXInqZkk4kAiaf1lVY5xK32I7D0b9bkpDH9e7DUocwGujteJBPx+oYcXCHLW1qTUtOtkD3mPY2p64cNmuwpqcPZzLPTUkklgM2JWReY+8nrqGtYcSQ4b6VjBpXJHrZW/pELjLhtXnLnXrx6C2yHBFotIbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621480; c=relaxed/simple;
	bh=A25sOSf9Ut7mez9xnn+T+0+X5nv/K8nyWcx9x+Ff6DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0e+PKyqmHLGaTQaX0R3wuhsXvgbxTlNd1Vw8FjtUyXXaGkTVQmNyDL28IzpQWQjLQejAYMvo+4Db0M2yEs0fHIWeiFxuUzHBeLD9HDRHzx2Oks53xeLaCESTeAlvnRC8PIB68hmiBewi+/5qtB/g3FxqhQhHNKgxIEbC5gTowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6o0xiiv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd78c165eeso73545235ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722621478; x=1723226278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rjf+dmfza711nUeLAJtttS0CyCy0EfsvdXDNrYog4E0=;
        b=N6o0xiivXHezWmy98QEdDLbm0EIent06ILJ6qKb8fwlPWvIQ5bV54SwLjborsBFs9l
         PH5DP4Y371xQ32lF9dX+jcJU6rQze343+DD3lFDbe85CnzWn50SBguAKN0fTZqcgOY9B
         BzKBZlFz8IaJC2Xh0DatH3RcMGT3rEl16+ZDgmW5FZWjPRUyVpwYprrAdXlEIw0EYD0/
         o0cmWPs0VtTH2lT51b/UooVwukJ2KgjtsTktMCPsaxl9vmy/BaYFH3KblhAYZa8Eo6/C
         MntSPujw0ZGsnpOXX4UmzdurslMwO7S5D0WZk8xCTvU4L3yprraiCvu+08/eGJaTrMVh
         hkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621478; x=1723226278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjf+dmfza711nUeLAJtttS0CyCy0EfsvdXDNrYog4E0=;
        b=SwHTDD78NQ1Jd+U90sAF1Xd8zTEMgTS9a1nImRUkxdx+exBizuXccK46eqL69hDKhV
         xGD4C5gxKh624gdt27fcByYZlnfrnpI1Kl3jxRJEj7BTY9JNTn6LBu83WaojmXf91Hnb
         cnl9+5Z1byvSzsiPppHxg7LENsJFlK+frGphnn1mbf3D2D2tlM607bqFzRV5MWsLJPyP
         lyPv8LcHxOox0NrxVnPAEd1KMFbf2qbO1i4D1S2keGsvagC3xA463EeAuYy5P65JAJhm
         tgI60tyFp5hzvvCpopZJckh1vrw6F7AvCvgbMUNoTjv/9spVGp1tvKzRXTr8T4+c/JXz
         D+Xw==
X-Gm-Message-State: AOJu0Yxp8iFCthfS3R4qUYiPQaR2yRw/A5PAlr4FpsIDScY4xDdp5DOg
	Yv4+wrSk0a7ENBvgtydR3w3nG7iDCyPTGaxEWLyo+Bv7ixgC8OQxTbC0o2uE
X-Google-Smtp-Source: AGHT+IFxuUlBjulA+PWW7UeuVnL3etLCTmTioP9phNM2OM0WIXqGTPKS/u7d1/+Kvsk2Dp+5ySRjfA==
X-Received: by 2002:a17:902:bb96:b0:1fd:a5a2:5838 with SMTP id d9443c01a7336-1ff5725228fmr44718475ad.6.1722621478382;
        Fri, 02 Aug 2024 10:57:58 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19efdsm20072605ad.31.2024.08.02.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 10:57:58 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
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
Date: Fri,  2 Aug 2024 10:57:42 -0700
Message-ID: <20240802175750.1152788-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802175750.1152788-1-yury.norov@gmail.com>
References: <20240802175750.1152788-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl->mask(cpu) is used unchanged in the loop, and tl->mask(i) in worst
case may be calculated twice as parameters for cpumask_equal() and
cpumask_intersects(). So, precalculate both.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 76504b776d03..754ad5fa3c99 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2353,6 +2353,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(struct sched_domain_topology_level *tl,
 			      const struct cpumask *cpu_map, int cpu)
 {
+	const struct cpumask *mi, *mc = tl->mask(cpu);
 	int i = cpu + 1;
 
 	/* NUMA levels are allowed to overlap */
@@ -2366,14 +2367,15 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
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


