Return-Path: <linux-kernel+bounces-540788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9BA4B4DE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009873B1748
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040BD1EFFA3;
	Sun,  2 Mar 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feGxIr6e"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437B1EE02E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949559; cv=none; b=tVV+ZDv+zDKEDUL4zoujOOOiZUzbhNbinN2Y3Zb5O7+7U47gvO+C79FKcKkOVbfmjGlUx/mEhTkKqYPuRFvvl8bgWPNBw+FM/hU6vejrqCQ3BWrq798d+44nt29/aHG/Pz9aUhZgjuHqmRDaJr36QsdeEm8rK5M50ZdomauVx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949559; c=relaxed/simple;
	bh=csJHFJUyCsftMCmpGFQeCYBIfeJ5ABaV3LQxV4Rm3ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr/B/Js3aJDQAxKPzkAgilvlMFIdmcDHNlV9xeki4JSRBPW2TWnVPKEC8yBheKp844Mw5Z4irBjN+aC0LjcxoKlAp5r3Dsvln/WrPl6VxqFk7cuNBLuB986yWftqzsxTsnY89XcNTRR1KEpIoTBFAEkMYjVE5/CWSUvG2ha9kko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=feGxIr6e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439946a49e1so23563895e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740949555; x=1741554355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjzhsMMWFb7O14Znxkn5qAGqxHoEDm7OLKD4SmZn2Eg=;
        b=feGxIr6e1I3ps2jibHkPvY7UpsvIMsS9s0ilddPqug06xFBHtkF4Jew1DerAkO2/eh
         ykDe6LQAp2SDrgHHvfs+rj1+FkwLw6tl6sFiuLyoLpq8muOCLCQTLuDre8l04jvo/bEZ
         XG8c6I0G6+wgG+CXYpTndxjpmXfL7yOCXvjCO+ga5hj3nLss1QzAV/g15WO4DU+JEOt9
         sAvoUNdpfL8si+yhUZkCRIb6qVtZPYKYgPd4lJQPGrZL5xhASftY8FATtYSILaOxUCXC
         c8ybW6luTg3io38sktRWGMZNqNrv+IiGi255IlONzqlJh7NHAdxB4Ll2orqjzsAPfQir
         wxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949555; x=1741554355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjzhsMMWFb7O14Znxkn5qAGqxHoEDm7OLKD4SmZn2Eg=;
        b=wSzl7rrg6ujUCzg1hztWwXtkD0uikAtLy4p96lCgqFjCv+TNGzv1IF4knns6mdxCDt
         fUwCuTrttYmNwyYW6Bxjlr7qkfS66xJZPP7JrhOb4r/cmc9d1C1zGGgfC6Fu7Od2Rmrn
         xrFLPTgK8BpXzWfhfDMmu7O+Kea2Nmelpp5nrFO2CWsGs3KB8FptrIP6q3RUDwECd5Az
         bsS1y+0Uk4fUQuottMUSU8J9e6ciJ3fR8XDjQs0JIE8m6pY1e0xntga77mB/A87weCqV
         F1rrpaD+ED0Y4wzoZW5kuwd0a+0UgR0J3jAXpkGU644oHMHfgdqiIli0zZ6dAeIFBV89
         ifVw==
X-Forwarded-Encrypted: i=1; AJvYcCUpZ9JQXrgnYhuFWkRgAGHMZyv2zVRY2rTRb2RwLvMfLGTwKOS8d8MVoKWcJv8xGf0D0GUq6FVREJA1ZYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTfk1pwOCVEXXtIup9KNX0Z9xKFIld6cwu6wwM2FFKyr6F5sj
	IBhLTS3O2ODxD4zKhh1cVo+xkc+Gj89qjpG0CGmMQp/z2ulD5Xh8Pt7QoHBDw64=
X-Gm-Gg: ASbGnctZkfzKbZFyKOQIa3lCu8OjLaa28c9p1aF4f7IvypRsMaJqGXWTQXL1iHNhhf+
	IwZXDgcVGYNbbTsAX5esqhaRN+pQS0kAFMJmn78lhM18fcxs96Hzkl7uUCz0OzJRfjfM9VG0Mmx
	ylafajHERJh89gVgp5gpfeCNxNaE4kXZRKyrJp631L0hwRgAyIQjG8pK//XovkRaW1EijXuwhbZ
	WS0d4gSJ55dMmN/8ZAiDGMIzK1V7AZ7W0qQq0TgNL9mYVT53UurwP61MISrvOh1Zr68SWD5JNAx
	BRrW6lp4vNCXvlH0Gl9SMLMGBw2dYw44+gVC36L7UiyLo7p9GM3G
X-Google-Smtp-Source: AGHT+IH6WW/pR4ORqXlwWAdvHlQynFbHAHxZ0vcbhGBXAgkz8brrkiohxCfeHRC8Muq2hQiyBaw+ng==
X-Received: by 2002:a05:600c:4f16:b0:439:88bb:d024 with SMTP id 5b1f17b1804b1-43ba675a8a9mr75614145e9.25.1740949554865;
        Sun, 02 Mar 2025 13:05:54 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e045sm12480923f8f.99.2025.03.02.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 13:05:53 -0800 (PST)
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
Subject: [PATCH 7/7 v5] sched/fair: Update overutilized detection
Date: Sun,  2 Mar 2025 22:05:39 +0100
Message-ID: <20250302210539.1563190-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302210539.1563190-1-vincent.guittot@linaro.org>
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
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
index d21fe0a26633..79f505492215 100644
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


