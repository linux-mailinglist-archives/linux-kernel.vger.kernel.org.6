Return-Path: <linux-kernel+bounces-311781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA1968D90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7A8281BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A91DAC47;
	Mon,  2 Sep 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/+Yswah"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250741C62C6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302178; cv=none; b=IOsNFDdhrvcBfaeUYQHfHtG44j18WeaYHFXLJhU3sLN7nJXETiu3y4S9ReqxiQXqpcMamRbWJqLNgr0KiWbOLcIy7k9t3kyi0HS5jaWHStnGmywNyprQXY1KNblGsU1SvG18FwFz1Ibo/Aih+WlULIYbMo343FRkKnqiKOzYKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302178; c=relaxed/simple;
	bh=n4DY9fWvNNP+vPnev4QnAxb6kTHbVIPvGqngyfcYTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmFq355xVJTOo9q0xiFKSBH5btUoCefqVTi1syB8SGVJgFELrhozeTB92FPLR67FwOX6EPoeZ06nyLxo21QL5MBSa0Zk7E3ucvuz7pqtlWCuc2wbc5I+wkwSAM/BeozvFpTpMDozYQudGwZhohYJVcL2R/uVEZEogI1IoGHr9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/+Yswah; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so2958127276.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302176; x=1725906976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81Pwg90lkrxuPa74EcD9qWBo9vF1Zvhp5af4I0TH1fk=;
        b=S/+Yswah46fJmnK9YpIHFww3mCh8zFTXlf8Q7VXF7v+kk+rMnqoItQcjh0scSuB7Bg
         u0LUXZSdq3ICthfl3NOSOEhF434XLH4N4td0iBL45KQ/RUWInbGg5g9xQDTHHmJkAjJ/
         839F1lzctXNKuXVNSkX0rN4T5XAR53m26J7IA4abiKkTmr21/0I45+agBjIzabR1RZ0T
         5TScYMNED2cm0uty5mwouiasKgNii/DMvdN2gYa+yahIBBmmqtDBHtUFzFOBc38XDOs1
         hf/as0Re4kGq5zHpVSH80PjY2P9bKB1v+IZ7qoPJ8lwIL8oKXhzlgvYHjO07jC6//Fj7
         axiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302176; x=1725906976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81Pwg90lkrxuPa74EcD9qWBo9vF1Zvhp5af4I0TH1fk=;
        b=Gvxn0v/KIsIl34HYTuiFJbf+bOyN69DhuyegZ0N9qjZe79r9hnrZg6PdeqC8GnGRmE
         SHcD28Ml3Ez6Bopk5Lcb9u6mJrb97RcoaDXk2CEV0lQGPibzcIrEkopu6pZLsARLFhIN
         vAInN4vfo7snMakM+RfI9NKUPUSrBQ1+zfa4cAcP0276/EDX+eVpMUA7RU2ncZZp+RfI
         jrAea7TI2ariktzbIa9hACWeKRWCmUS392ogCZ7kD+lo9L3gkgmBQEABnU86dI4Un/CF
         8FBkXLXlxjfqGJVOiXSAt5hZUlmJifZdHAGnGqrLMNk090C3KsE9LerZEbGqmlnfcnfm
         BOug==
X-Gm-Message-State: AOJu0YwYFL8MScdfn9xd7PRetkR3uf/gJ5mlUmBKLxm8yQZJQA4dmbE+
	9Fa1/RhM1qaCay+3JqN6saAofVt30AEFjETyYTqLjVHqM94Nk5Yai1pC/DjP
X-Google-Smtp-Source: AGHT+IGo+Ur1m2xegyqr/Z8b1jMaHVXT+p5bk0e9C4xNp6mTRFu67zOVctFekJE8dEMvZb0KnHxclg==
X-Received: by 2002:a05:690c:c89:b0:646:7b75:5c2c with SMTP id 00721157ae682-6d40f34125amr127977357b3.16.1725302175953;
        Mon, 02 Sep 2024 11:36:15 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d57de3fbsm16890097b3.78.2024.09.02.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:36:15 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
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
Subject: [PATCH v3 3/3] sched/topology: reorganize topology_span_sane() checking order
Date: Mon,  2 Sep 2024 11:36:07 -0700
Message-ID: <20240902183609.1683756-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902183609.1683756-1-yury.norov@gmail.com>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function currently makes 3 checks:

1. mc == mi;
2. cpumask_equal(mc, mi);
3. cpumask_intersects(mc, mi).

Historically, 2 last checks build a single condition for if() statement.

Logically, #1 and #2 should be tested together, because for the topology
sanity checking purposes, they do the same thing. In contrast, #3 tests
for intersection, which is a different logical unit.

This patch creates a helper for #1 and #2 and puts the corresponding
comment on top of the helper; unloading the main topology_span_sane().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 04a3b3d7b6f4..bbbe7955d37c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2346,6 +2346,22 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 	return sd;
 }
 
+/*
+ * Some topology levels (e.g. PKG in default_topology[]) have a
+ * sched_domain_mask_f implementation that reuses the same mask for
+ * several CPUs (in PKG's case, one mask * for all CPUs in the same
+ * NUMA node).
+ *
+ * For such topology levels, repeating cpumask_equal() checks is
+ * wasteful. Instead, we first check that the tl->mask(i) pointers
+ * aren't the same.
+ */
+static inline bool topology_cpumask_equal(const struct cpumask *m1,
+					  const struct cpumask *m2)
+{
+	return m1 == m2 || cpumask_equal(m1, m2);
+}
+
 /*
  * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
  * any two given CPUs at this (non-NUMA) topology level.
@@ -2369,18 +2385,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	 */
 	for_each_cpu_from(cpu, cpu_map) {
 		mi = tl->mask(cpu);
-
-		/*
-		 * Some topology levels (e.g. PKG in default_topology[])
-		 * have a sched_domain_mask_f implementation that reuses
-		 * the same mask for several CPUs (in PKG's case, one mask
-		 * for all CPUs in the same NUMA node).
-		 *
-		 * For such topology levels, repeating cpumask_equal()
-		 * checks is wasteful. Instead, we first check that the
-		 * tl->mask(i) pointers aren't the same.
-		 */
-		if (mi == mc)
+		if (topology_cpumask_equal(mc, mi))
 			continue;
 
 		/*
@@ -2389,7 +2394,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 		 * remove CPUs, which only lessens our ability to detect
 		 * overlaps
 		 */
-		if (!cpumask_equal(mc, mi) && cpumask_intersects(mc, mi))
+		if (cpumask_intersects(mc, mi))
 			return false;
 	}
 
-- 
2.43.0


