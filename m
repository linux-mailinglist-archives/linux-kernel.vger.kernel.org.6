Return-Path: <linux-kernel+bounces-554756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495ACA59BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AE13A6624
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497B235C1B;
	Mon, 10 Mar 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aRbJX/r3"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA122D786
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626309; cv=none; b=ouK8BjyXX2O/r4ABSX9LSwfkKf3F5micuv0VHdeF2ADgS3P14IXaOQLiLnTh+bgG4ZL4k47zUH8OZneE7Xe+FycECLcCI8eywHeGXt03c+PrU1JglXeqnDOGoJu5dwJFLOlIbWpuW/lHhW3LGE7sRoEY7dODbZoZutLfw1d46yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626309; c=relaxed/simple;
	bh=iqeMyg2aM7rOxUpDWS/hr/9N/tXvFYSx8aHXmJaW8IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVICKo15FoqI345nlvYdhXC1IJ40VqbMCnnrgveN/CTe3CPRymvK2PzvloZXW0NIMxYsGm1xYjlc/oR4myAXQoYPHPlTdsUSuYd8K28o3lVv+MMjSaJln3OF4OflKNslrM751NHoWcWmIycVRhKmcSnGvQEdmAf9CUad0RX6K2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aRbJX/r3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso2227023f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626306; x=1742231106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7MdvLo2eJNuv+SAzqGScNlKUwpiF8b6hAU2gKf+PuM=;
        b=aRbJX/r3XOO1OzN3jzq/d2tuyALKLrKQvaRmNJlxjxbjRvHWmSFDdpA24uWk/3b/ht
         ioUV9Wau58bu6U9vO1tLU7YEyKpzU+GahrwA5eiUfiKtOxAzVboAzUr3uhHVKJ/Qn4hT
         m04nRGQ18c60H/VUvluipxgYrlcWOW38N1sQVJjEc3EktUbDnK8WhZ84t0vm8Se5zrKc
         8XFKcPR+6+bgA9SBSGOInrSwAnuwgrhDF5p3s+9vYmz3yaFriOH8/KizVDaLG+ZA6hWf
         47ZVWmE5H/X8IqMv82S2LGe0d6/bZT6m6FoWvQczGXMNHSA/DfTAV3gwdi+Wf6tJkoS8
         I3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626306; x=1742231106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7MdvLo2eJNuv+SAzqGScNlKUwpiF8b6hAU2gKf+PuM=;
        b=vhiA9yx4rp39Nd0fDA4DzwCNeURKNzSK+2ZYd607EBN0WGIRM2Xm9p5CAcdTkdV1vg
         N2KwcX5JlSbr1/eVmCcb6gEwVU1Bvb1+p/Y9F5wyEMMxdEHAzOjRuDphTu5oY11NaQJp
         JgVp5XcLER4dzj7nIGC9g6fGvJqD/0rfgtlpKzdJNByckvu0iB5E20aEtafwhr5PrB7A
         8ComgW6ZhBbjrZHMECPBnvUczjZ9qPh+zC6Q6Lwhsj6G/TbznsQ1sgcrVXY4mTCfAsGj
         syNvauFfX/+sLcnJFYLOPhKgcQkPZJ49VDyQdOPzRwRz09LSmTKZCUYdVWVU7zsiIOTw
         nlVA==
X-Forwarded-Encrypted: i=1; AJvYcCWjl2cEjaQEGsioA0gKnQmKaY1qQXkVRmjhR9/9wmb+hfyCmbmxrVUp0o6s8O7kB17zmM1Ieny5vYp0gaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzdU3aOQiEMXyfPcNluqtKNDETBpQkY/R5hGkko1WlBJIIrqZ
	5inMB7OcTLx2aKQLeuuGo/z0g3tNyUJqPjFCy7gjcZNQdzPPzpQLNcM0PWvJm9Y=
X-Gm-Gg: ASbGncsiE3/aktbZN5/yONtYTaJF47iPwVS2T9h3i9GFlgGyYvMht7+iYs9DbtAEV2R
	H3PLFAsh9hBx1Phaev8oLOKHgbVwoizWquPPjDaywcBIvqbVxWgCb8muyDOmspgc3+ZRCM8fbAm
	q3Zdlsr47UWxGSFtSdb0A7O6z0fa4iazS57he4R2UQRMF+yAYpHBmHt31lhoLpk/ncTm2CLxQY1
	RNWgJV3gIbRwHYlPd6Y6kHqNbI4xCcVjcRduun0h3C5f7ds/OtBhESVKf/MDSML1mzT8Gc6t2Of
	Dt6BJuGlzkAaaxyFmNsxo86BE6gE07dDKlpC6OSMDm5VsdU=
X-Google-Smtp-Source: AGHT+IF8Q0eeYBcGsH8TFyKREJ1wXJF1HOKeW5omYo1W6rFm92dzdYDmHxBpIrc2QiJ+Ywl/IGah7Q==
X-Received: by 2002:a05:6000:178b:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-39262c99b06mr506624f8f.0.1741626305983;
        Mon, 10 Mar 2025 10:05:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:05 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 09/10] sched: Add annotations to RT_GROUP_SCHED fields
Date: Mon, 10 Mar 2025 18:04:41 +0100
Message-ID: <20250310170442.504716-10-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update comments to ease RT throttling understanding.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4548048dbcb8f..51feefef65c66 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -819,17 +819,17 @@ struct rt_rq {
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	int			rt_throttled;
-	u64			rt_time;
-	u64			rt_runtime;
+	u64			rt_time; /* consumed RT time, goes up in update_curr_rt */
+	u64			rt_runtime; /* allotted RT time, "slice" from rt_bandwidth, RT sharing/balancing */
 	/* Nests inside the rq lock: */
 	raw_spinlock_t		rt_runtime_lock;
 
 	unsigned int		rt_nr_boosted;
 
-	struct rq		*rq;
+	struct rq		*rq; /* this is always top-level rq, cache? */
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	struct task_group	*tg;
+	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
 #endif
 };
 
-- 
2.48.1


