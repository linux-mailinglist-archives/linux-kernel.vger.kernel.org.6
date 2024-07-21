Return-Path: <linux-kernel+bounces-258167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15469384A3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1420B21215
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C815FA7C;
	Sun, 21 Jul 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CYk7ll/v"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9153BE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721566386; cv=none; b=hTC7lYEkTta6UP0apub/h866vn1UfF89PtscELaW0rx2thHebZaxZMwNeElL59b0BYzhg9NSDXcp6fnHN9kvwSeVrKxHt0HH/wBVTjGb9M9IyieuaNJeJoklxFzctiSSy8SM0YJBMm8g42ReWMUbIztfZWgLMV82No0VKKDzuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721566386; c=relaxed/simple;
	bh=rd9yyAOuaPjKVTKfd1c64lmlFO84QaWok+uMlwK7TOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTj8Ywg4+hUoP22aDNh8vg3nAM533+Jy7PaGAE1UlzRjVw5a3jFmOUaWXCLhscAimNpTybeGa1ADlVUMdINjEV6vvabZoXB0MyZSS6RykKphTGajicObV8OfKaGqpUVhMii03kZxoV5LnQNMkO1rl01AtIxVYcuJo8rJOv38m7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CYk7ll/v; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9bcb47182so2060932b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721566384; x=1722171184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i90tat1on8IktACrStM2Flu+kAGDHgBdM6VXZCQtR7U=;
        b=CYk7ll/vQr8IR+F+K4ffAVQzVFQPB8X14qgI3Gw9KWSwi9NL2meG8gEJRKhwvsEUGx
         69Sb8+SqdFmOAFebvQSTm1F/HEfK3ez0YFmzdtVBB8980HqjQfc1jdXd2tvc8N3NVxhR
         hxPpMAgrwHxIqRNOXtvE88lC2yyIEIi3vlzHozs/me433akIV7A+bZ8cty/yy/owdsek
         rO1WvQu4QFR4P9M8DDVrTCOF09BnozKeIe354XFHps/5e/S9+j0o8D9ZVM7ZC7VYoJdO
         oAaMK9vU+UgR7CF00aerBtBXSxZAycb0d/wsLtGHieqAB8XrDBpoeyg7LK0+1qgBTS9r
         BDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721566384; x=1722171184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i90tat1on8IktACrStM2Flu+kAGDHgBdM6VXZCQtR7U=;
        b=RFiDkKhEs6LxJQ4wcvhS9+6RBVmA5LC0aXR2Ckm9mdX5XHGrPnJuL6m5pKvlUdIcfW
         6mDFhzCkGBkdKXMeFpoGmLiLkKsr6kAxTXJGO+dGrYkIK0OAqAQYGL4TyDZXzEKYow9J
         Pqv/4eI1p40fiAiDYUPCOI/rjFEnTKVkYWR9rMR7ozoc25X1kgxE/9y3P5wLn+40luHr
         BUXJbT2KCPImXDOEfF/HWzz7JST7yEYQLAoDXzXD6f6b1zcSPRFwEj2BGAhoInuRani6
         JESN2y87ae8iL1gVxni+9+7cvWQvy3D0iFlIe6zs6V6k31ghu4nsaJz0SNw08YrSuNay
         2Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCWgjPWpoOjLvDowhK/6+qZiNUJVy9msy/PIt6CeE0bAh6ccAlLGoE7vV/oZPB9gu0zUCTkeGDEh95ecAs1uwpGO99/SisgWbml59DRY
X-Gm-Message-State: AOJu0Yy4fhjLjze16La1kfwS3aIhFWFa+K84Ndek9gURL94peInNyg7+
	AiLlUj4W39xRf3c4orPd6yIKdVVRdRz9kDcqCxOoBvbCGQ5lF67j7Fhq1HstBkY=
X-Google-Smtp-Source: AGHT+IHHPPB5MeTECgKUm/IaTWBdefeqtodW7G8DnMTUGOtt21y6JS6+uY7jp9S0ihTlBFRw1c+OqA==
X-Received: by 2002:a05:6808:14c7:b0:3da:c428:1c51 with SMTP id 5614622812f47-3dae9723bc7mr4142862b6e.8.1721566354402;
        Sun, 21 Jul 2024 05:52:34 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f472366sm35871525ad.260.2024.07.21.05.52.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jul 2024 05:52:34 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	joshdon@google.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 2/2] sched/core: Avoid unnecessary update in tg_set_cfs_bandwidth
Date: Sun, 21 Jul 2024 20:52:08 +0800
Message-Id: <20240721125208.5348-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20240721125208.5348-1-zhouchuyi@bytedance.com>
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kubernetes production environment, we have observed a high
frequency of writes to cpu.max, approximately every 2~4 seconds for each
cgroup, with the same value being written each time. This can result in
unnecessary overhead, especially on machines with a large number of CPUs
and cgroups.

This is because kubelet and runc attempt to persist resource
configurations through frequent updates with same value in this manner.
While optimizations can be made to kubelet and runc to avoid such
overhead(e.g. check the current value of cpu request/limit before writing
to cpu.max), it is still worth to bail out from tg_set_cfs_bandwidth() if
we attempt to update with the same value.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6d35c48239be..4db3ef2a703b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9081,6 +9081,8 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				     burst + quota > max_cfs_runtime))
 		return -EINVAL;
 
+	if (cfs_b->period == ns_to_ktime(period) && cfs_b->quota == quota && cfs_b->burst == burst)
+		return 0;
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
-- 
2.20.1


