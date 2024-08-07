Return-Path: <linux-kernel+bounces-278438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B025294B043
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720F8282987
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2814431B;
	Wed,  7 Aug 2024 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q64LQVSD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73989143C45
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057535; cv=none; b=dtiUB748k5JwNinXpu4S4k8OoldDhNIA7idsUSJu2JttCDeRfX/+RaDurGCG+P8Q7CRsybT05nWMerPjpwtANNkbLLP3MciVqJHPaaxurhI8n3ya5g8PM2vn8iPym9Mb4hnXBBFdS1rSf2yj2WbQ72PSTirvW9JLs86nc+gdLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057535; c=relaxed/simple;
	bh=eA1AI6V87YPxIg7o9zfBiyAPonmNWgXhOCclHObnY4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBRHb93PHPSnN9wiwEtYvNy8V9/se5a3ccGXo9SADDZ5Txj0GBCAz/vMf2LuVGAv6V5GgNByHqlIRCJpTFxgfUPoSyZ7QrB2DuGfQvfRa98gUxgGJgYtJfRTas+TUHrVEuVESAEVPaQOXOzDJv2bxkPFxbgXaJPhRfUhyMzN+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q64LQVSD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd90c2fc68so2499995ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723057534; x=1723662334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36H26RD5uR3ue5WSyAgLPKZiveEwsWRYqoMnPtQYeHs=;
        b=Q64LQVSDm+iZR0rywaggHALjQgXDDfHh5RwFR0QWeRph7CrhXASuZUx/DplUOnsMD1
         dYG5k8NCWRLFFQS40zLHL1jIFLNBrJyKqzwfv6Af6jy3pGWBR/KUaNYfanYXboizuxew
         eGGAQ1hzAbc5Hb8VSz4oPk8X4VEqROOgiOs07Yy55GDB/IjXWTHXmM0zzcBuHzv1apgq
         OFiG3RuZ/iGVdZRKHXLfiYeAQnO1bc9+I95VBacfLjaPg0nrrzbrMZfco3+Vv77Ffg4C
         4aTptJJFY9E4EcyFqMNRls/OfwJcktaRmS2fiaGm7ElSBd8urKKWMCDKqQAkpLwFejaB
         +Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057534; x=1723662334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36H26RD5uR3ue5WSyAgLPKZiveEwsWRYqoMnPtQYeHs=;
        b=GTpuugNKzXPJn5HDgGcp3QTXPzvpXtTICOMp9e77mt3dJWYKaZTfN07xp9Z4+Xm0/x
         7CDaUt7zM7T/MWM3CLXDRxKpMqzgRBretH8t5urhB5sMI6Uy0/v+1VCMkaeTZ5CaHTkW
         hkPlsAMCbqyuQq6fSizq4IocODJgPmKAqL2LHu3Y499UKV3yWKwdXetFt49vilfIrX7V
         A3OF3GB97SSqm575NtFnvje1qmSdbGu1N7IHlsPEeYfVYWjD55xQwqj75FTIel8Nf+FP
         GKMp3o9g5SzouyDz+vfhrZvTerdxuG38fNhgpd87HtO+bRS4CRewnUqT9/6eVifxN1mr
         rNGg==
X-Gm-Message-State: AOJu0Yy7UrLE90SALwGwkZ4UWdVWCmnyO7iHBxE/Z7y1eiapuZM5SNr9
	9KecxuCD2Z/SXzVJZ5thhSNfdQYpXf6iH/8q0iKoOG+R4z6evj95W42UM5SF
X-Google-Smtp-Source: AGHT+IEkroaE82bVicHuBDOO2gbeleqKhRZWNfaT0squj8kHhv2ABdAL3dDmJD+gewBpF1kMQXg7Ag==
X-Received: by 2002:a17:902:ce87:b0:1fd:7293:3d70 with SMTP id d9443c01a7336-1ff5723e5f5mr216745615ad.8.1723057533569;
        Wed, 07 Aug 2024 12:05:33 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f6ad65sm110024525ad.116.2024.08.07.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:05:33 -0700 (PDT)
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
Subject: [PATCH 2/2] sched/topology: optimize topology_span_sane()
Date: Wed,  7 Aug 2024 12:05:21 -0700
Message-ID: <20240807190522.432388-3-yury.norov@gmail.com>
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

The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
even though cpu != i. In such case, cpumask_equal() would always return
true, and we can proceed to the next iteration immediately.

Comment is provided by Valentin Schneider.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8af3b48da458..3661d4173d1f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2370,6 +2370,18 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	 */
 	for_each_cpu_from(i, cpu_map) {
 		mi = tl->mask(i);
+		/*
+		 * Some topology levels (e.g. PKG in default_topology[])
+		 * have a sched_domain_mask_f implementation that reuses
+		 * the same mask for several CPUs (in PKG's case, one mask
+		 * for all CPUs in the same NUMA node).
+		 *
+		 * For such topology levels, repeating cpumask_equal()
+		 * checks is wasteful. Instead, we first check that the
+		 * tl->mask(i) pointers aren't the same.
+		 */
+		if (mi == mc)
+			continue;
 
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
-- 
2.43.0


