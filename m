Return-Path: <linux-kernel+bounces-428119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9209E0A60
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3570B1636F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692AC1DE4ED;
	Mon,  2 Dec 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciFJ5mFO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB21DE3D5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161588; cv=none; b=POMTUPyaJ3FrEZ4RKT84STRPvA+VcrRoz+YU0HvcN01kBRl0JAtWkTxsTxuNDQ+bptQJUzDJswftRellmGOAm8YckgEsHjmpR0oWKHRi6eklGP1dFIh7XNk3dTLCV/UYWJEW+VNerP9aRqlGbQPJOS2RlJFZXNQdbZILFj+SGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161588; c=relaxed/simple;
	bh=T65mAueW4jYy6mZM1Pq158iZdfII223WhEIXJbMYhgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al93OzuJW44qR6UvqX6tfzKff/Ugn3Lef9V92ZIWB49k63Uns/Kitupa0xSg4xZzm9gLN1qk3q7srZY+WcE5qF9WG4b5CTm52e6AIq9TuTbESfpjDEFS4f6DtVtm8t9CnRde3EE58bVn7wIrVIVallAOKT2/xFmMAmYpAiXWdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ciFJ5mFO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so37173765e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161584; x=1733766384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaiK4vvXS+8NUDhX4vOVsSr5dTIQjigRktyW3HjBCiQ=;
        b=ciFJ5mFOXYyquHjfW5Xz+aSADr3/83lUkw+d/ubyCuP+SuDTJ3JUymI1Myw9Pwqp6W
         owxMM9ZmpXZzzF6HAirjClLeBAZQUclwtyqZHzrTlry+BlzuCeYO0vyQu68oxqW2F8AV
         5Ru+ptpsPVOLbadnsZT+2BEdUOlkZ4n6GG21aSoZpP9soS283f9fKhW7CFjhWEI+VzTy
         EXmZoP8GqjXMQnCaGRg5EfUIAkM+ZlJGhQQNfQT9BfdVq8hTXpSPq1wwwfVO10aTcZnN
         d/bxxcTerVJ8vT1/xnphu2+YmUdfFAskH983LWc3uSsmigvDC0Bk2YFfxOS4MkPnn1qQ
         /yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161584; x=1733766384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaiK4vvXS+8NUDhX4vOVsSr5dTIQjigRktyW3HjBCiQ=;
        b=Z07NrPfrvoOppv9Yct4OAXayYNTGdDHpV8xXEBmZj2b7Z5gNVFg0a/wC5924T1bC55
         RKq7SNWjUaCovBVwIOMIjr4hdgEro80fA2bZURKPIurlJtOvFsbC3o9UEgynPfBGCDZ/
         isUtZUO4lsYVx/5dPt+MY5GO5DEZT6IWPfdYyikNxWDePX3uL+bAzNojqkbF5/Zum0Mj
         WLgpaa9SJjTJW2IePl+sDOcIt+lYazs0xrNuLg8EiGOpdXA034bqd4NufyidxnnB3NRY
         xdEEVyvU2tJOmBZ7GGxtg36hi94a/JCEmh0CAv6o76v5L7zoPShpTMIT3LHJ0nqeDwn6
         GdaA==
X-Forwarded-Encrypted: i=1; AJvYcCWngmGZlfSS1c2yyUomgsVFqPYtXX7Z8GNxlvtaqF1cBWt2+b97OWt8f7OEWCiE8U2SMkA1B2wlN3BvVQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlr0yd0F5L2Z5WhPmlUbdN49i10kliUb/9bTZAmqz2QOuQNrW
	DHdhTrB0/OJCkBd1rN8PIms4/b4t+fKoE47HmaZm/NEfCC8uGFINBARyJ5ejrepQpTpAScXVDUp
	RSxs=
X-Gm-Gg: ASbGncuJFPgs+i9HqNLxj35Jrdm+RVtKEjmJzOqSzS11OWyilbt4qoXJRFxfEtaryW+
	K7mU/Vjp6Bredcwmkt1+gp9mCRfUyKBQPMZaRxVcnbIzkCY1UtsP2TtC19ImNZhQAGGEHJ0BcxM
	qWQU9ILGjG6ZKjsZOK2vR6HUyOrIdCPAFS8KtN9PDlIeVMNtMIkidJogijRGDZhC0RsNCKg0RKQ
	g9DGEoLPIyQ8JcQ8FPCEu4jm+4OGZaJxainUztFenAXnWI8Aue4e0wUHsE=
X-Google-Smtp-Source: AGHT+IFv8IcsXwQyaLgDvqVMB4ewo5qieNcN8vtjUSQEsJ1+a0alMo8+yJBMnqQutbuKSWku9bPz8Q==
X-Received: by 2002:a05:600c:5022:b0:434:a6af:d322 with SMTP id 5b1f17b1804b1-434a9e10ff0mr195226915e9.33.1733161584126;
        Mon, 02 Dec 2024 09:46:24 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:23 -0800 (PST)
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
Subject: [PATCH 08/11 v3] sched/fair: Remove unused cfs_rq.idle_nr_running
Date: Mon,  2 Dec 2024 18:46:03 +0100
Message-ID: <20241202174606.4074512-9-vincent.guittot@linaro.org>
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

cfs_rq.idle_nr_running field is not used anywhere so we can remove the
useless associated computation

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  2 --
 kernel/sched/fair.c  | 14 +-------------
 kernel/sched/sched.h |  1 -
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e21b66b6ee10..e300ee4d7956 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -846,8 +846,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
-	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
-			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7234206b9981..46a6e49b4f1c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3674,8 +3674,6 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running++;
-	if (se_is_idle(se))
-		cfs_rq->idle_nr_running++;
 }
 
 static void
@@ -3689,8 +3687,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running--;
-	if (se_is_idle(se))
-		cfs_rq->idle_nr_running--;
 }
 
 /*
@@ -13523,7 +13519,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg->se[i];
-		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -13534,14 +13530,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
 
-		if (se->on_rq) {
-			parent_cfs_rq = cfs_rq_of(se);
-			if (cfs_rq_is_idle(grp_cfs_rq))
-				parent_cfs_rq->idle_nr_running++;
-			else
-				parent_cfs_rq->idle_nr_running--;
-		}
-
 		idle_task_delta = grp_cfs_rq->h_nr_queued -
 				  grp_cfs_rq->h_nr_idle;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index afe5cb93db89..9a9220aad9fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -648,7 +648,6 @@ struct cfs_rq {
 	unsigned int		nr_running;
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
-	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
 
 	s64			avg_vruntime;
-- 
2.43.0


