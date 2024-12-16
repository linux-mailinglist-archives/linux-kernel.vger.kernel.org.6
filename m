Return-Path: <linux-kernel+bounces-448070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1749F3A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207EB1695EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12791D9A63;
	Mon, 16 Dec 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UvmFOb72"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2721D63F2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380004; cv=none; b=hAq1f4DfZeIpU08PthZwl883tBSjgtX40PT6Mh0LhYsI8nLgAJeOs27GUgXhDQXBUUQfrPKQ4tNIs/skPVVd7BuaQJ9Ptl9twvmFlrNUC8MH2v6397WzHTRJb2joeOJ+hYTmkwWFxc5v3bAeLT4qhyL2OnvP0xGhprXrmyDC6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380004; c=relaxed/simple;
	bh=G4qyJ4T2+Mw8CB2FJ++y7NvEzFOTYgilqb9SFDaYviw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCjgOWq8xzU2bCzmEb2FQ0Zu79jM301TgtzEvLaKhN7TtGv09LSZ0wZBwgTeh7xBmPx8MP484DXJqQbBmLHA001KOv5FU5QeLr9JBHA2U+M8dw5oSXfsiNBsDrmKecaYWtjFdDZh+Zj0ib4zj5sxrPfPe8iuQ+mc6iY9LMgwMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UvmFOb72; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso31620355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734380001; x=1734984801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjXZeEiyAKD8VfYmqGcOYaYcyWg1RcYgwrkfT5jxudY=;
        b=UvmFOb72vREdFk7z9DPKw7wtz55tJfkehHH964hlK+BkEk2J9pg2svopDs4yvXrMB+
         S1TrEkHlQJUoqXbCyNjXGzWzygYaOnMqK5Y3O4zEPq54MgYiq72d/g+U/A/I24jLuHKB
         pIkF6krC1sBhSa78cfpWs5tJWT6wNlB7S8KmQKUJeiZis7li+veS9pPCWkBCyyxAUWCv
         /kONfAXduFSmEnZKuqrPrDNTE/SkXsh0qnnBv4EmgdtynVxOrPxH+iye05uunKxBup0J
         E20hanFlnUiU0ZSejs3v5OFJtwW5USvA0FEK6M3n7ZZYh3O3ZlHtyIRs3E8vgitP0ePT
         GDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734380001; x=1734984801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjXZeEiyAKD8VfYmqGcOYaYcyWg1RcYgwrkfT5jxudY=;
        b=JcHOJAN2t87O075tlVOoF22Ov5WQhCHBA9KOgLkZ/P3DzFTvBfKNWYYDfnbIFl4B7A
         RZEq7FG3J0CHs04P22YVre5eM+BsqKfu8f8tzXwE7UyKua1aGaL9cs4hpXwSlcfoB2Ds
         bkyTNlqEmseUQLsrgYOU+zuk0JFFcA1qxnPBfMHrNfX0ACHdlyc24stDRYuU2cvnnNEH
         aTxngscNJduRJlbmdHtPL01lDW9v7fFJJhGRKv26AGfQe2yJ9WMjLxy7PL+O2tV/1aDl
         lgmISGclZsTvZxc2ooJpwIByFk25uTdvvkv+uzxgENLkWZ/tTRtZ1RrAjpOLXJHsgpvJ
         ToRw==
X-Forwarded-Encrypted: i=1; AJvYcCUq5MNQPMq4uq402YFRBNeRVnFr9cjQmBlkr8QDm+dTeYA/b7k+hKz+6gBbctXS7DQyfn6nNOT3isXAd7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46fiSlzSsg+gHEj0fo5JVjSwW/2ZA9oA+Io4icD4YTB+EF4vN
	PSD4cejWhK0MXQrmVuxmTjsyekIovnzCrgHz/PbDeqRblw9TBQJ34P/NjcdALFo=
X-Gm-Gg: ASbGncsg0q1pxhxmgUfNIXnrjvCEPG6NOsk/28rzg76X27SgyNv4gorIQt9qLtlos60
	kjZjwUU5gWV8ddxs9cKpYrycPL0MmshlTHb7XLlwLvQaRXi/Oq8hnCi+i4JB1+OFgWY0hDYx06N
	AysaOKDfNmSLAjpJTprhE9yfWeZ3KLTzcbYrjBAuNw6X5kGMp//L/tvdRb/qqaPJZCF0wlczpKU
	kZYvCkBkMtQbqnmCF1fPhF8XMYdlZHaQAcO8nXEkytprWbpQAWVMggKNg==
X-Google-Smtp-Source: AGHT+IHvg2JySc6luFarg1m27oTMM9k7iAcd2BNt3xfcXvFaFYd51oqzF0i7hhs76tRKRCR7w1DFoA==
X-Received: by 2002:a05:600c:3109:b0:434:f953:efb with SMTP id 5b1f17b1804b1-4362aaa208dmr110458345e9.32.1734380000716;
        Mon, 16 Dec 2024 12:13:20 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:20 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 9/9] sched: Add annotations to RT_GROUP_SCHED fields
Date: Mon, 16 Dec 2024 21:13:05 +0100
Message-ID: <20241216201305.19761-10-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
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
index d8d28c3d1ac5f..5c32c23915810 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -812,17 +812,17 @@ struct rt_rq {
 
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
2.47.1


