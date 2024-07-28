Return-Path: <linux-kernel+bounces-264840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B8993E90D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028351C21022
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3537174F;
	Sun, 28 Jul 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="rGk9qwRM"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2599374FF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722194830; cv=none; b=EzCoLj2lxVoeOP3ewhgeBwr39JUOZa0U1kismu+i8FefFsyQi8sKbZ/Tb4uGyBvxhkW5/wsM0jsjfaj9B8CMfJzWDo4J29ZHZQJ6TIwk43H2eG128exXPbQ23hXwx0PqniyDX+gQWYwCuqIz/KNqTuu0Eg+eIZTOBNNL+DOVCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722194830; c=relaxed/simple;
	bh=EpUGQvFRZ4KiyAlMWfA/JHcNYvghKMjDTfqWuMI8C6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HaZAWPX3EG5p7CnuC9EtupZKraO2OFziGBjrlT006KqBSH/FxpPKmu7V1G63mLld6WLGBRe8gJRz3gZZniwygojZXTaxsQfNXsLxwonYFCFyokSV7Hk2RmSXEAUwL7kGwQlCuVdlETNoelUas8aLfnOw2qX8QiKkVEaa0jXbujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=rGk9qwRM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42808071810so11055865e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722194827; x=1722799627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUdl1sB28tZR2PP2RLddpsep/HItrb7ZCpaP+KMjeeg=;
        b=rGk9qwRM3GPSqgLJKdmk/+jdGeEH1iGrUur+K7tTmGJj3Z/hKBDc9Aa3aqGBtZQ7Of
         KsN61AKTZl7RxMrX3S8eulosVanlWyKWjC3KKgPpZkisdsaW5FGRJ30OgHe3rKwTxE6O
         9jihE9BL5Qznl5ILQLOUuoqndODavZfwt2LC0YrT0BCuLLTHIBWaVgv9fFKtY8PDCLUS
         MXG6wX7PEmRyrVx2Tgv1E3njIuujbtb8G57U+zpKLpkAnOSx2zn9XR8wTBX6tzBJdcq/
         66YIcjfhRRoQpZG8HFbd7shG6mrKJr2SSCBv1nLt90PPtsIm2hcVzIsNVAOctLhUtqEl
         +3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722194827; x=1722799627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUdl1sB28tZR2PP2RLddpsep/HItrb7ZCpaP+KMjeeg=;
        b=SAOIbNxKAZl8SnQoLzRRlgYf4hnhTb0Jw00MoyNzNvbaSXhnR5ArJJ/1ZzqfJ6+jEP
         nR5U5dWscFLby0cHTyUnFyzO5evwuZmmV/z/cp+/5zGP/WtP0riDFdZyB2pLQwAeygtB
         X7OnpbDQG0l34+6Q3kqXC51dQ0p+qZbImymJd48RzNYRAiMpZkLlWlUQBx3gMzPkOqS5
         YNVypaBSdRJUXp6/d1gjrQJwglc6KEdTROHZHu/ypA7kMNDQXhx54PzW+qJoo/QKCXNU
         KETgCyN2xOajwfp3DiCU6yrms9cZcXd7OxeHm1n7TIiCBk/D+d29mqG6/tqctEaWVlRc
         jlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdlboOfi3zv7QPjSruMXVi1FX0TpZ0Hr3n2q94a7FgEFts5yL71YyWI3Kuuq+90pKnRj6XBMXJwCkzJ+biZQot+zdCOIXGKH+QFN8f
X-Gm-Message-State: AOJu0Yx0R/9nfWEtssp08Pn733up21V/KgWAHI+C44K9QJ6FhumyjGLi
	IEHoE4K2/L573IaazKkMn8MthCmrTyUL77CI2HcFoXUWOe6C7e7sJu9vkF0SJtI=
X-Google-Smtp-Source: AGHT+IH5NzyTCXho52sC1iHeGvC2jr8euOKpCO+6PSMiHHSrYrW7Q4+o4KM35YGaayw/n2rqTKcO7A==
X-Received: by 2002:a05:600c:1908:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-42811da9fc3mr42071015e9.21.1722194827269;
        Sun, 28 Jul 2024 12:27:07 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574003bsm150167005e9.17.2024.07.28.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 12:27:06 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] cpufreq: sched/schedutil: Remove LATENCY_MULTIPLIER
Date: Sun, 28 Jul 2024 20:26:59 +0100
Message-Id: <20240728192659.58115-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current LATENCY_MULTIPLIER which has been around for nearly 20 years
causes rate_limit_us to be always in ms range.

On M1 mac mini I get 50 and 56us transition latency, but due to the 1000
multiplier we end up setting rate_limit_us to 50 and 56ms, which gets
capped into 2ms and was 10ms before e13aa799c2a6 ("cpufreq: Change
default transition delay to 2ms")

On Intel I5 system transition latency is 20us but due to the multiplier
we end up with 20ms that again is capped to 2ms.

Given how good modern hardware and how modern workloads require systems
to be more responsive to cater for sudden changes in workload (tasks
sleeping/wakeup/migrating, uclamp causing a sudden boost or cap) and
that 2ms is quarter of the time of 120Hz refresh rate system, drop the
old logic in favour of providing 50% headroom.

	rate_limit_us = 1.5 * latency.

I considered not adding any headroom which could mean that we can end up
with infinite back-to-back requests.

I also considered providing a constant headroom (e.g: 100us) assuming
that any h/w or f/w dealing with the request shouldn't require a large
headroom when transition_latency is actually high.

But for both cases I wasn't sure if h/w or f/w can end up being
overwhelmed dealing with the freq requests in a potentially busy system.
So I opted for providing 50% breathing room.

This is expected to impact schedutil only as the other user,
dbs_governor, takes the max(2*tick, transition_delay_us) and the former
was at least 2ms on 1ms TICK, which is equivalent to the max_delay_us
before applying this patch. For systems with TICK of 4ms, this value
would have almost always ended up with 8ms sampling rate.

For systems that report 0 transition latency, we still default to
returning 1ms as transition delay.

This helps in eliminating a source of latency for applying requests as
mentioned in [1]. For example if we have a 1ms tick, most systems will
miss sending an update at tick when updating the util_avg for a task/CPU
(rate_limit_us will be 2ms for most systems).

[1] https://lore.kernel.org/lkml/20240724212255.mfr2ybiv2j2uqek7@airbuntu/

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 27 ++++-----------------------
 include/linux/cpufreq.h   |  6 ------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04fc786dd2c0..f98c9438760c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -575,30 +575,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		return policy->transition_delay_us;
 
 	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
-	if (latency) {
-		unsigned int max_delay_us = 2 * MSEC_PER_SEC;
+	if (latency)
+		/* Give a 50% breathing room between updates */
+		return latency + (latency >> 1);
 
-		/*
-		 * If the platform already has high transition_latency, use it
-		 * as-is.
-		 */
-		if (latency > max_delay_us)
-			return latency;
-
-		/*
-		 * For platforms that can change the frequency very fast (< 2
-		 * us), the above formula gives a decent transition delay. But
-		 * for platforms where transition_latency is in milliseconds, it
-		 * ends up giving unrealistic values.
-		 *
-		 * Cap the default transition delay to 2 ms, which seems to be
-		 * a reasonable amount of time after which we should reevaluate
-		 * the frequency.
-		 */
-		return min(latency * LATENCY_MULTIPLIER, max_delay_us);
-	}
-
-	return LATENCY_MULTIPLIER;
+	return USEC_PER_MSEC;
 }
 EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d4d2f4d1d7cb..e0e19d9c1323 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -577,12 +577,6 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
 #define CPUFREQ_POLICY_POWERSAVE	(1)
 #define CPUFREQ_POLICY_PERFORMANCE	(2)
 
-/*
- * The polling frequency depends on the capability of the processor. Default
- * polling frequency is 1000 times the transition latency of the processor.
- */
-#define LATENCY_MULTIPLIER		(1000)
-
 struct cpufreq_governor {
 	char	name[CPUFREQ_NAME_LEN];
 	int	(*init)(struct cpufreq_policy *policy);
-- 
2.34.1


