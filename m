Return-Path: <linux-kernel+bounces-538600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54821A49ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583431742F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46126E142;
	Fri, 28 Feb 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNztYLKH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD326FD8A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750020; cv=none; b=g50wurlbWuPpRwRwp81oa2tsdqBUDJJi5vwsKnHfWSLZiANm11Toi5051UmBJTxyd2lxBlfqmHfEaf0z5JbaizIWR5jku/VN9Ur4AmzEWyh9FMdU5xiD/C/81NNKlYpc3VnLqhEU4nbXIkjZ8Z6R/PX+OMqpPk2kKjjwBv5dRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750020; c=relaxed/simple;
	bh=nCeGF9ItVUNdwPlWOzTVsny3+ZdTra5J1FFq4P2sUNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbvfizU/ptOxPrl6QSdW9c43i9GdvZIwWzZVWTlKkhQPCjnzr990BCsfxmMsK12osxSTYtHhkaIYd0Gn9laTCvlfg53d4ID/ZUiDdq0ji1DodB79Pyx4+sWgVdwG6Nmh/++9CH02+knBq5mPsYyBiAd5cwT8RKsj4DjGpy8uR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nNztYLKH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so20331375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740750015; x=1741354815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw934CEn6tbK6lv9WMG+8m0C783kJwL1DMa/2ldwyiA=;
        b=nNztYLKHoSy7aWE6pJoWJdpg0JdZLaFWnMaEC8ls89xjcTS6ZTyRbWoq6SP27SEI4E
         pIfyLdEFSN1hQVtrMYTeSyQkdzax3FKM4NNDwL8s0xnmqevLcbQRjMCmZRg//3VAy8Ur
         iepR+BBpcB5rgIgAVhNI7yO66q8dvRodUhQWvsekoHlPTweNEv2xrbF6ysqwwnJACT2M
         a4in8N1+YWVYb1fESN4KOkTJ0ybIjstlCgpAuDa38NIK7C8UxvBFoE+HzGYpAGNxZNYM
         PRUQu8tPaPEYshWq9gZFjNKohyBMUjQZja3D5zTZyMGEFNEke7Vm6bW0zzWGiUhGE+xT
         N5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750015; x=1741354815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw934CEn6tbK6lv9WMG+8m0C783kJwL1DMa/2ldwyiA=;
        b=aL3cJSqnIhKaxLf3KmmMugGtm+WHdhpGdtYnGaS8nGedeHCf4/ZSVkGIByqeG8XGTt
         sp59U2Lu4LvCafKVIDo1Zxv1qOf8V9UW+21vNBFlNvQ2h28kQdnUlsetNEozswLk14P7
         mqat/dYc5cok3zSeoEpDsTmykJf0zjUiY3SZ6670q3bxo8Yl8wR2tMu4z4q1G4jtxvV0
         mYunajtggzpGdzzCMMSDtLTR4yT+e60fVTlbaB/l2W84XXH+H2bNip4yGd6XOw1GD4td
         2eoymwjh06D3EmMhohD67mywUfQCF6kysFUVK/BqgyubXUTjBc716tMtevNfBaWn53Xq
         brzw==
X-Forwarded-Encrypted: i=1; AJvYcCV8jmjrmh1EnuMpvr5G4hEiPvEFV+pWVCQI/eslJJjVl4ni3S6Pkppt99oFnxE1GZHk78zd78EmW9FcZFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/DRqPLRzX4BO+XTz47cpO9pdId0e4T+Xd25uRLb0eYzNy414
	ynyGa5dFIp5HFxVb9bqfGWsFTLbdkoLR9LeFtZgKpeZXsIsdLR5wm5s0yl0rcAo=
X-Gm-Gg: ASbGncv4QIUbw0HzSopN9Z/5oj49jkyZ9zPojjpMHrhZIJIS+EYPF6TVtqxGhPOAmAC
	bReidWVzuJLxOjBGf63erB8+lQnIPzYuNYB5eZXvLJeijSO2dSkHwcfdugc1+omRwz0dtUQhgV9
	TGM6x7XtBgjYXNu0gOVZU0wQQvlVBY8wjdYo0owxLG9sJrRAPH71tHLjRVwxgPbAgw7uPfdD3GG
	cUwoMVGijM0gpZYctTExfD7H8u6l5FG74EPq3lmhVrHu9P5U4ttj7iL5kuTNyEr+MZ8OnkWvcWv
	wOEV1glwZl6C8SaKZtjD3CubxmFuXORwHg==
X-Google-Smtp-Source: AGHT+IGkdNXJ4tFpT+fJ2vIB2cK3pcIEZUV15iurW0BGYuP7ZBxOP27p3nyFC4feakr1HKn80ekYCg==
X-Received: by 2002:a05:600c:4fc2:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43ba624af40mr27194085e9.6.1740750014610;
        Fri, 28 Feb 2025 05:40:14 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d4b:473f:a962:e9e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm55984405e9.18.2025.02.28.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:40:13 -0800 (PST)
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
Subject: [PATCH 7/7 v3] sched/fair: Update overutilized detection
Date: Fri, 28 Feb 2025 14:40:00 +0100
Message-ID: <20250228134000.1226665-8-vincent.guittot@linaro.org>
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

Checking uclamp_min is useless and counterproductive for overutilized state
as misfit can now happen without being in overutilized state

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87bf054cf36b..2219db9636c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6831,16 +6831,15 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long  rq_util_min, rq_util_max;
+	unsigned long rq_util_max;
 
 	if (!sched_energy_enabled())
 		return false;
 
-	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
 	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	return !util_fits_cpu(cpu_util_cfs(cpu), 0, rq_util_max, cpu);
 }
 
 /*
-- 
2.43.0


