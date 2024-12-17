Return-Path: <linux-kernel+bounces-449559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4B9F50BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2D01890D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6E1F9AAD;
	Tue, 17 Dec 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvzS/Oym"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FE1F9428
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451664; cv=none; b=svG/b0XVaAXtsQtFzKRG4/iN+srAAJJullF8gAzSF1jCha8drDndqP8NERiwcFeD6EjaaU+COwfk10HeoDmZNcQIZyYi0DvsRjlq10pQsQn9oC4+wuHkVfuLlusOY208eeEVRkiwNUWKdnECN9w0yy1gJTSP8a1uFkjeQspdG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451664; c=relaxed/simple;
	bh=ahlxghrgd0S6AbzHWBxPPhV3sFgWCGSBYKhL5Ip9ApA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddzGsB0+1kkNS2tthAoGE9Ls5XvN5qHgQr/h+PFgAHa3UA8FpEAOQUcnyCpMoHjDgGoD+lBsKPc1AJUxN3gzT1Kb4OWZ8bBhOJYw6M/fc+w8InriGV/BWrIdUcOaPUnbJ34wDgFhV6FWWuf6M2fELTg1IJbJTtq5DKzuHDJNOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TvzS/Oym; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436341f575fso42514365e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451661; x=1735056461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25XBrM0NJ6pePI9T2sJJh5JraqVj1fYsT/JFIPhqnSU=;
        b=TvzS/Oymv9LgVjmZmSp/INsrmwIy4JjMDy7fukwVLDuajFlvDy6O1KDEHYLUJ6TmMV
         McVt+BLmJTNb6cq+lFPVSwXDt5oJVkmAyXYR3Cvp5ZT0QIXPq77K8GG7e1WGJAIe+drq
         /8fp7vGhzQFgujLBQp+Amh7OXJoNVmnhlA/OOZBqUHP6+Y3bK/ZvE5PIgO9Tnknjqo2S
         oZHT4MbyUjf1T2QC9EupmGvKjvIRbBbppRkDlSpsLkVpX9AtPvNQeipAqHky9EPZ5Q8d
         w7SPynzPDp9NOmLx48BaUiIBh9t4UVnlWEYNjOVIx67iWnP2IJ0+m8zNLp1REFTLFi+Q
         S0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451661; x=1735056461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25XBrM0NJ6pePI9T2sJJh5JraqVj1fYsT/JFIPhqnSU=;
        b=NNTrJYZ8XUieOARCLawzp/B9jzUWluGPLHvLPiWAZa4y5G3/wsWVgHp5uGGnWcZBr9
         bAcGK+Pwpt9R2jyiwNfiRph1GUIWF+Owvr5C2J/BOnrjXXqu6YmD2jpfVKQx+bDzuQ5F
         vUk4bDZFRfPCXWEmevccFEa8gGh8A8rFrgQW/Oja8xM4F+PuINyQwuOOKQIac58Qd43M
         YUj5W86MYcE4HS3soiai0o93P0vttUiQjQP59vEBiBJx15gCWWLKbZYUK9kNmbxpFqO7
         Nkk6WEZQK9TpuPlJUl3/dCSqdYwEKtHqDAv5GXHLMimFXWZ/xV+GyO13Pye052GqS8Vl
         YlKA==
X-Forwarded-Encrypted: i=1; AJvYcCXpBPXhCyYTnnLi0ROQQoazCCCh76gN0r5/VVNXJ8Y/H2uL1KdRN+KT65rbG8nZBx2U8cb0O/YvwFXt2Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzH+itfF/GbAuZia1XA+/HAhCm+xOqGy5eKfYRM9obkb+Q/ogx
	OOmDUN1/FwhsmnzY57r4Mta/4wYmPMe9RcfNtZ5yi8PDpxIZHeC9iT9IYmJ0Yeg=
X-Gm-Gg: ASbGncuAZ5xBGHujmvs/L7lXf/btcJgboaSqPkkEQ8Z2ybjPwg3zIhkdX2DSXlYf6cu
	q9UeBwsE0wGc0T8Nkr5en4pgF7NoQVjyhB1rfX0x7T3Cua3ac0oY+f64LeXQlEKMuZnlpDBZRiN
	CiAQBbL+quG3Ev47pha9SU9jj0xeP+ns9+Vs/OYG/PwWNivEwIOhR6kPN8dhxmZP00Fd8Ia2eYR
	/MjP9AFEV7iHFlWKZhOKo/mzckbM6QXw2REsKcOwSF6oDBZc1yO0fo52R6bo5FYIw==
X-Google-Smtp-Source: AGHT+IGUdRAlaDf5RiyF6d3FjeSmlk/HeVhnRFJ2Zl4R4rz0gubeAGYhivS1TKe43q5VHpNM6Rcm5A==
X-Received: by 2002:a05:600c:1e19:b0:434:a734:d279 with SMTP id 5b1f17b1804b1-4362aa5005fmr191362625e9.16.1734451661133;
        Tue, 17 Dec 2024 08:07:41 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:4e5f:e8c8:aade:2d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257176a4sm176739435e9.38.2024.12.17.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:07:40 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	pierre.gondois@arm.com,
	christian.loehle@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 7/7 v2] sched/fair: Update overutilized detection
Date: Tue, 17 Dec 2024 17:07:20 +0100
Message-ID: <20241217160720.2397239-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217160720.2397239-1-vincent.guittot@linaro.org>
References: <20241217160720.2397239-1-vincent.guittot@linaro.org>
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
index 9bddb094ee21..9eb4c4946ddc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6870,16 +6870,15 @@ static inline void hrtick_update(struct rq *rq)
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


