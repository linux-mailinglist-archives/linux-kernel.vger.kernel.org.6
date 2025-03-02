Return-Path: <linux-kernel+bounces-540620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71AA4B2F8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9816AED9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ADC1EA7FE;
	Sun,  2 Mar 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2r7L1FL"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9811E9B2E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932011; cv=none; b=uRCrj6DBasB5FTZAFXcEnUbWl6Azd9rt67klLNo8WizuEcJNvQKZb1WYmNbNGFDnGsc3Z6dVI8fpCqjOR31ezOcXjx5xlPzlT5FI7M40NcxL0u3OoVjvNUSZaeq8mdAyMtFiL+l3Hoi074cgkwOPmmMnXl6BR4fZtZ/8i1xIrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932011; c=relaxed/simple;
	bh=egzu3f8lxE3MWip7YazBJRQ/Ydi5ZEOEpxWi6oXJGI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E078zgw0Aoht0c02acQfi5MdXVuz4BkQ6Eo/d5LjSTgucfDabcYDqF6jiT6cwM3ALQWTMydDQ0cvxZ4x2cYBddbeSGqPe4DrdbBE5LTmTod3R1UM4IFg/qQHv21jCf6fyroCV5xVsjFoy++e7yZsym7Nn+kSObZKfwXkBvfe6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2r7L1FL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43995b907cfso22897905e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 08:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740932008; x=1741536808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/6kLY6RaSrrdr4jkNO3fwWS6bRx5SKAp4IQp7qj4jQ=;
        b=p2r7L1FLpMHa441232n2j7JvCWtAX0MSRajVoodRMqA4fNCZ2dwjHaaaC5IG5KZnMK
         DC8uE2hZ/uhAzBCqH7MgHcZ9hMR8fjHsQ18QA4jewmNzJIrH2X5MJOBPkhuHkJtT055L
         g8YgOyo+9rPu80ZeAd+7sGkldKzUY+E6CRWWvsWs+d6Q4l2OYFZiELVCFWuzlFCVd06v
         UnIfSu8iY9KYEk/Ag41i1Cv8xFa0Zcgdg84AMbM6Es1OqtSh6ZJYq6jZb8Jw0V8kxuSG
         ELTLzM/JNJbpomfFm0dSNGYh64ezfEtCrSa6BeaDYngMA28uCG4V+6qISbO2UySI+uJl
         UNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932008; x=1741536808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/6kLY6RaSrrdr4jkNO3fwWS6bRx5SKAp4IQp7qj4jQ=;
        b=YPmHfXMtqNPdsJHg4/K+msYswE+rjAbMgcGHtFNO3ClUTG4Xl1g41heEkoop449GhS
         Q1Cju0EhoLyVnypCc9KBBcCFvFVxci/e/NxZqjwgDJh8KZdxdqiwD/hIbv4/eIdbjVZf
         KcD0qZXunzMlK8UWyUV4UTEuIwZRUUo7S8Vp2XatrPNEg52h8R9Fvbr+CSTpWuNesZXh
         PYWZR8+PShgt82Fl1+ylppvCdF0Rlitd9A6X/bciilsMLfMG0JNVOHYLwdLnde0Pp6Rt
         lpUBBR6jQbXF/82wQiCeXC66XcrHssVae9YhFKg7X2xx3YHmQ8MgeE2BECMxI8+eBlX8
         G0NA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Um4RC3OUbgfdO2dHjtRHJsZXb4R81X02Bo2mqcsHuznwCoa5diPd/jbIKFpzzNvHu+GPaWNXZLGCbZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6xUz7kOVjdDLZAy+/hcU63guWQf4Rfc4q4OITX/u49gKXbM1
	0P3xOKqsjLRo4BzkH7crTG+TCsgznc/LLg9qAuKo39nU6tGBzAlf4/P1dQHWySs=
X-Gm-Gg: ASbGncu38PtbNmrlcDrTJHdS2jY+ntzEAd5V21MQYwIotYL1ohgHiVX+X3C8w+/aWiz
	jCunMQtWUGwZMFbnbKNze7T14zF1p/f9c5TULw4R8s/N8i65wWkyIwYghJjESj98gEAYQzziuMl
	uJBuYy3MG3ab7hP10/kLKPaWBfHsnPGqZFyPbMrNIDhNDJ3Cpem28qz7R9zrXz4loy8pR8fJgza
	cyEEHVOUFTABuoZVlsTUAkxKTR6h7Yx+6NeIJrvnXxdTL9LcSjlOPBYFC2sEcLPwswXJshm9eZF
	v7RiqSDq0svCkZrIyOn/wisodcfJQh+aC170Wne0P10wHtvagMz3
X-Google-Smtp-Source: AGHT+IHocYVnoPTuzXvVlpS0Ekd9gqrxt2gB/DYqhXFZoCPRF3XfYa147n8ZBJLqnYSROcy8kUM78Q==
X-Received: by 2002:a05:600c:1d20:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-43baec9c2c1mr50187315e9.31.1740932008348;
        Sun, 02 Mar 2025 08:13:28 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm25530245e9.18.2025.03.02.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:13:26 -0800 (PST)
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
Subject: [PATCH 2/7 v4] energy model: Add a get previous state function
Date: Sun,  2 Mar 2025 17:13:16 +0100
Message-ID: <20250302161321.1476139-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302161321.1476139-1-vincent.guittot@linaro.org>
References: <20250302161321.1476139-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of parsing the entire EM table everytime, add a function to get the
previous state.

Will be used in the scheduler feec() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 78318d49276d..551e243b9c43 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -216,6 +216,26 @@ em_pd_get_efficient_state(struct em_perf_state *table,
 	return max_ps;
 }
 
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	unsigned long pd_flags = pd->flags;
+	int min_ps = pd->min_perf_state;
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = idx - 1; i >= min_ps; i--) {
+		ps = &table[i];
+		if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+		    ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+		return i;
+	}
+
+	return -1;
+}
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
@@ -362,6 +382,18 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 {
 	return NULL;
 }
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table,
+			  struct em_perf_domain *pd, unsigned long max_util)
+{
+	return 0;
+}
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	return -1;
+}
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util,
 			unsigned long allowed_cpu_cap)
-- 
2.43.0


