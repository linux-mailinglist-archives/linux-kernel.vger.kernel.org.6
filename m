Return-Path: <linux-kernel+bounces-428122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F39E0A65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB6162B24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9531DE8B4;
	Mon,  2 Dec 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTilyLOw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B271DE3DB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161592; cv=none; b=BxaR2nX2ccMwAmU6sD4f3TuI1FEkFiMLaV5hSl5dd68aTfeMqA7ntIbW+7rD2RNNzzj8ClpuNlaunG6FgVdtCV0yAHFxAi+oAC4bwejQBEmU2U880fsBpolLgjZtvqgtaZHbPymZgyntEegInwLHqSMR2eWVBxTQtQg8HFmmUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161592; c=relaxed/simple;
	bh=Vojp+S10FMlBTIZkWSaI2ey2ZEYUoLBUhVC33mWSmAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtEpRebpiu9ttsfeOnB4OeWd8x4NJBaolxPkDPobO9umqPtbFxioS3JZfjubaQMGlx3SelLlsXPvT/TETgVeW0h20KLi2fTAaOM1x92c0wOyo1ZfUi+28w8dk2M3mouyh016ccZJ1AUGTIqoEIySpE2jpRw3BgUV2HKt2mY5onY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rTilyLOw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso5199257e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161588; x=1733766388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbVLdkKPCRYszk92Q0dE+wF18uSJwLunkcEs6Kf5hck=;
        b=rTilyLOwLMASGlpGVv7XC3z0S2QSVayqRMVT5B2aWc6wfw30qiwmM7IxepIuimk+D8
         4bysaDzB6WnPPrNBx21JJlEOOjT/LIbEMB65BhE8hYa03s6uv5nZ1wX/68wce5re5WHc
         WffEhK3EMrMF1Bsb+jRoIB6KdkUpErtmvqCWexAWSa6PXYPv2Arimm+hSfCJS99tAh2V
         o7y6XeeqnbVYi2cefH/cqM6lt82ncEct8Nq4ip6umr2nb/p4tdnTQcjIE3w9bsoAouJg
         4udASn6nIHIt9OsmvjGoX0ZOO4A8hFe2zQSXKT7SOkhuACzzXsWDuo5dZsqnZ9FtdBPm
         MG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161588; x=1733766388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbVLdkKPCRYszk92Q0dE+wF18uSJwLunkcEs6Kf5hck=;
        b=dmuLbPydZU3XEsoV/qfHelotVcLTckfMjiFlzELwMqGzMw1AA9DZj/dur70dm7SOCT
         9W5oxybt/9GnGysip+uluFbwI2RHlPfDT+Wo7pK06WibcvzmJ6teqsoecxqyPvouRB27
         MbVtoWkGNqkiMABP2IkWj0hgrdC7z5WqP/N46zO85jqmfDCabISc+YF9s5B6HqaF6M5V
         gvDeYadM9DMUEE1unUysC8m7hjvgrZeCAIwF8aou4r6nSMozoomKX/8q9TouijSuidJq
         S1DfuEBPtoIVYRU+yTP72misuPP0EFfPbe9sxZ/k+C0IGX8u1Hrc31RBEK3PRKj0gMf/
         IKEw==
X-Forwarded-Encrypted: i=1; AJvYcCU8X39sRcjZahH4HV622cme5ZTdbdn1SSP9CQj7jV2/CYQ93SShds0APMi7kQUO9lKt2hpC2uXXU9/tAS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfFnQ3zeCPRwROJre4isnP4BHYbDRjbQ276kJatMkc9wHAwrW
	ta17PqaS7C/qsXace0L2Xd199OROvzkA1lrcA5CcXjoxTLwvHeBAIpBfaAZncUw=
X-Gm-Gg: ASbGnctBI6GY1BuUsTGS+iRaTK3t1VBX36zdS83gaIGeQh1BBTsgVMpaVkGQzALUcrA
	pqiX0AtslszhMQR2SWze+rNe4p+r18C5/bYU+4IURIwFhU41BLzja/xzrzD7vLe79WuJwkVng93
	r5qB+8PBaxjl7+64Y8y/ryRsxtHuTpG3JR6NxUxUp4++r+FpqK9LgNYpr4L23ONWaA4BDUVGCL1
	N8xDpDAXMUQqBOh3EyxJ0YoXZMKzj7GKulTS7qFqOjhCNquHkAVbNSk0MU=
X-Google-Smtp-Source: AGHT+IGcDydITViSGX3ztqU2cL6GJWNKAM50r7tVAldIXwZqz3nTPBvOdtZFCrS8rRVhwikgYcPCDA==
X-Received: by 2002:a19:2d0a:0:b0:53d:f4af:6fea with SMTP id 2adb3069b0e04-53df4af70dcmr9575869e87.4.1733161588449;
        Mon, 02 Dec 2024 09:46:28 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:27 -0800 (PST)
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
	tj@kernel.org,
	void@manifault.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 11/11 v3] sched/fair: Fix variable declaration position
Date: Mon,  2 Dec 2024 18:46:06 +0100
Message-ID: <20241202174606.4074512-12-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202174606.4074512-1-vincent.guittot@linaro.org>
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move variable declaration at the beginning of the function

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 555a9eba5486..fa2edb59d009 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5494,6 +5494,7 @@ static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool sleep = flags & DEQUEUE_SLEEP;
+	int action = UPDATE_TG;
 
 	update_curr(cfs_rq);
 
@@ -5520,7 +5521,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		}
 	}
 
-	int action = UPDATE_TG;
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
 		action |= DO_DETACH;
 
@@ -5630,6 +5630,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se;
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
@@ -5640,7 +5641,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 		return cfs_rq->next;
 	}
 
-	struct sched_entity *se = pick_eevdf(cfs_rq);
+	se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
-- 
2.43.0


