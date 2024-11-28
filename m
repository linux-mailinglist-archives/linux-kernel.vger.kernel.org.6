Return-Path: <linux-kernel+bounces-424469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69BF9DB4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C5A282625
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234F198A35;
	Thu, 28 Nov 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXzpmHtP"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BA195385
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786089; cv=none; b=b4r2OEAXcnoiZ515OXX8hVKyHcYg6KS2Cvf1jhHYfp9xUKTH1RhtDNwM1Scc3Qr3J34E7YpdpFiUEVJnsVxhV5pna0cFfJSgZyjwTlsu7X9/8b6DDkrrKthPEt+tL4ADIgwyvidFT+y5hKd6aFRPbTAIccAmWxDdFJfESGzGwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786089; c=relaxed/simple;
	bh=UIIYEoRfwucrwBbEJhBfjYYwlb/jiHJwud+KZyqDXrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddTh+8Q8kOH+V0Y1Cu3d3YwGtHbQNiMfG9tCTUyuHco/cyOfIpRK9f4RpgqM0/lrQFHyp1Y0/xvrDm5/mZWqjPn0qMzBHTvxAKjsmUiyKFmsk1H8sN4S57w4KRXjdySm97933Y96NN5oPJl3l6Gw7FupMl0IcyjDDXtee4nc/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXzpmHtP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349cc45219so5180155e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786085; x=1733390885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuroh5C1klk4kN6wv0hOcaU0Pn0SYvlMsqJMKuXS2gQ=;
        b=UXzpmHtPs0X53xyLqldp9ts2adJiwfZJHnQt2+upxQJ8XN5M3hIKfk4iXJl46539v8
         BVlvGWjGi0jGQxsTztUXB4UqIvtMjSR0PvLmAStGclS/58zMbn0yIMmGjC6asR6sAitY
         F+vUIiGTurFRYm2fPs08DBLjheUGiyF/1nPcr1iFlluSnVSUvif62rQAT7c2EEO0x5hd
         kqYl80quMFcPYKJ/45FB/UP4/jQjRKn1ZzejONUY9H4q+TBs04qjekWSIgoJWUVoJyAc
         jOGoCeyqnRdpqNd18OTic3ot5Lc3+hrBh7N+qqfCKAqd/P2speyfB8C2JfKF3shgZLHB
         56sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786085; x=1733390885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vuroh5C1klk4kN6wv0hOcaU0Pn0SYvlMsqJMKuXS2gQ=;
        b=P/Yl2DwdBod8Zwq/Rof6CeeNPN9OfCBKVcvudrG1FkvQDhyRqEhC0uL3sFvE5xamOu
         YnqCEVx1Is2sh2zraP7C81FkQWzdFwnW4QN5tHhurn43Km5X6NPIZjaT+A9xra+WevVu
         5aXNnXftUeBeJI7cMZ+pqive0YNTIzk2bC7+h33vOrZvujrL3x+MAqzYiFtbDgVfxo1E
         +epVQI5RXVmuuKGWTn+ijUIMBPs23FF8n/pevEYSjXAkd3EiZKw8bI/6AQRmSapUxfYB
         uFlK+dfyPbcNB9W+WfRWGiuYKxNzBZsnQVIVe0Xu5G6l/m90enwJUAVbXp1lLk8NhzGE
         NAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4TmkrHzT4n2YHYBun89/i/JyTU49DB09G/ghDVhlx8KGgifK+PL1jD4gaiBuOiUS1NZBnR32Jm7YF3Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPojitZMh0+g/FlDfpPcBCqlCoOai22cFc1W8atrtl++9qcirZ
	H/ihQjzbIErVDkDsxFsHO+znR7KwdulmimnmT+eoUm/r8nU9dO9cHsGOrb7jt/E=
X-Gm-Gg: ASbGncvrFe9sy06HSKmb6FJ0Hf/OJPe2XCOAPqxRtQaenH6dkRyk/oB2x3liSwJFLjh
	ediyvNjmPxw+S6IeYFMVZsEyfa3t/APXmrH1G5OxEgcazMYDdCgU4UOtlh1j15JZZqtozcjUlWC
	/+RqHmcgMLUkOpfwVfaeDJjOJC7CDSZNfHnZCCsrbCbQRSBXSXTvBJT06smuyKevDFKuHyEDQYT
	BsnFVh/gdNQTqq2kcUt5e2XI+67Jlp+52tLatS8Qp4MrcDWmMPG2ttPeT8=
X-Google-Smtp-Source: AGHT+IHGBkA2zl/ikPXG6pg1WTISmV5deom2arD9egv2feljQDS9HeFt8d4tgIMXYUBkYsfkiLuPKw==
X-Received: by 2002:a05:600c:83c5:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-434a9dc14c7mr58208195e9.13.1732786085657;
        Thu, 28 Nov 2024 01:28:05 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:28:04 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 7/9] sched/fair: Do not try to migrate delayed dequeue task
Date: Thu, 28 Nov 2024 10:27:48 +0100
Message-ID: <20241128092750.2541735-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128092750.2541735-1-vincent.guittot@linaro.org>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrating a delayed dequeued task doesn't help in balancing the number
of runnable tasks in the system.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1b4f1b610543..9d80f3a61082 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9405,11 +9405,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * We do not migrate tasks that are:
-	 * 1) throttled_lb_pair, or
-	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 1) delayed dequeued, or
+	 * 2) throttled_lb_pair, or
+	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
+	if (p->se.sched_delayed)
+		return 0;
+
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
-- 
2.43.0


