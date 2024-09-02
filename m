Return-Path: <linux-kernel+bounces-311780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B52968D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274DE1C21E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925A1C62D2;
	Mon,  2 Sep 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ25Ez/o"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD381AB6F0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302177; cv=none; b=GFWwwvaESeUUH2OvwzPA41jO8LYuWploJkskqStqc3qkg4QQZtlmAffsgOpurAFSNcOS3fhlbWLOQMHemYfiqya1K1Rxt5IXtySXKIhqgMcfsvHqD3XrV0rSf/rPldOrT9y5NCL5iFm0tdlOFx0CFDk9A1useLfQk+/r6LWrjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302177; c=relaxed/simple;
	bh=cXI0aLpbkNFzG2I2XJ4KaFkC1Vk7m5so2zzeOp2ZpTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfP65PZm58zizq50IGL7jxDpVC3NFSo2XSsdwVqR9Rx5awBM5IzznLDMHm6JRH5ztMuwO+TBnalu5ZX9NKGa8vho5l/7ai1XYHKbnAeZ7ZpXCX9KyfYAA+NsuEMhogS/zVZBI6KEQDu07+BNnkbkoW3U5Q6mrmV8DbA1Qt2XI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ25Ez/o; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e04196b7603so4890468276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302175; x=1725906975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LiUbyQ8pr+2ihhv3bomzpX3ODdNk5TniI0rAo29ma8=;
        b=nJ25Ez/ofa2V9yTCNAh8Ms7Q33voyItNJLR4rskK2oAx0OECrMHCGD9zR0VTe8xcSr
         0yHcMy5rOC731q8PhajvK3zvX9SCWoQKktLD5VkjDSfGmlirM/E4ZaQ/US1IlbadNYpY
         iIZvQWktlaDY0D/ZCy3z0abOEdFzga5YibyZ7NPy8oejtk5Yg4TfJP2GwEnpMadgjlvK
         rI/9m++vO5EYRNUsHIUgcOYfUQcmP36QVndTREUP15+fx/aCNUlUc9ebwIKr6FGzwuxH
         vc1S3ZQ8/m+aOMwqEnxEybNhIan7pglUA2wAJdZf4LrGr0KK1iuUGSBu6YNgTrFgm4f5
         k5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302175; x=1725906975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LiUbyQ8pr+2ihhv3bomzpX3ODdNk5TniI0rAo29ma8=;
        b=Kpv9xGFnjT3ZEKzngA48zHnBgU7gB834H2VopdtHuuttX/em57QCubdg4fbG/rbnuw
         cGIYUG6TUV8k8Lcz/L80QawL4yweCupsEg/Ewfo2OaFGk7Gev+E3NZMfaq+0CDhLZRz5
         Nmk1STXpFiuq+G532lVj4OwNG52xN+JmJSvlhXXt1M5f79lXf+fCsWcAfMd1f4YQgLnX
         ZBAhw9TY2t2qFqJ1Q+v1pmzolDkIM2OMnV4E4+CcV/fCc6L87PBMlGlf0zFShRsgcR4E
         9ZYNv8RTUi9o7C3kiKF0ifQEa4vPYyRk3yFS7D9dXkASzQFSuWskFQGzYFPWpKPmjOS9
         Ersg==
X-Gm-Message-State: AOJu0Yw8NC1g8rd5xk2S1hUQNWEQ/yJ9oXqgV3GOMcG8crBWHo35rwhI
	IHUrYrqT/NC5YVDZSgFSh26hsO5PWqy332Fo24v0O3qPliZ9ai8h3OQ18p+O
X-Google-Smtp-Source: AGHT+IE4bvB21w/EI92y9RBVrxNLU4TDs0iCR7/PEs+mcyoTCEUNG5+qtuOpOZe7COXL33tqhFJTQg==
X-Received: by 2002:a05:6902:2708:b0:e13:d8e9:4a35 with SMTP id 3f1490d57ef6-e1a7a02611emr8964922276.25.1725302174633;
        Mon, 02 Sep 2024 11:36:14 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a62681583sm1776143276.33.2024.09.02.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:36:14 -0700 (PDT)
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
Subject: [PATCH v3 2/3] sched/topology: optimize topology_span_sane()
Date: Mon,  2 Sep 2024 11:36:06 -0700
Message-ID: <20240902183609.1683756-3-yury.norov@gmail.com>
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

The function may call cpumask_equal with mi == mc, even though the CPUs are
different. In such case, cpumask_equal() would always return true, and we
can proceed to the next iteration immediately.

This happens when topologies re-use the same mask for many CPUs.
The detailed comment is provided by Valentin Schneider.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ffbe3a28d2d4..04a3b3d7b6f4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2370,6 +2370,19 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	for_each_cpu_from(cpu, cpu_map) {
 		mi = tl->mask(cpu);
 
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
+
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
 		 * match the topology we're about to build, but that can only
-- 
2.43.0


