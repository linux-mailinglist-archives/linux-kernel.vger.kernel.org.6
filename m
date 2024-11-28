Return-Path: <linux-kernel+bounces-424466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24909DB4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E192823DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD81925A2;
	Thu, 28 Nov 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRLxACs6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066F1885BF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786085; cv=none; b=dQUFtS1/hcMA8fK43VF5HQoT1V/z9fX6w4FPFQCY+4xgtCR/RyXOtZpwKJ/c2r8wa3QzCujfoZh9n4vE5TcIkJwN0vXCXgx/qQkMqCKs/tla2UbJJxtoGRw9gFtGHvIKak48nmHOup/QltB/4OXGKG3JyCEZoiviPruLbbv6WDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786085; c=relaxed/simple;
	bh=/0nArOpcytNqd1DAa59R62G/XX/W4P65Vf8Wh1yPYgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEZGooQcQlAPD2WVYpM0hONZmkvMu4nKEi1DAZKrioZvUA0g0EBCIgFjiEGBSmIsls1LJV5LhORpbWib4Aq1n+xmja7PkjyECpu+8o5rDdBrSt3SrNoFmT4JR9HzVM2CN6BpaJzQq4rmDyTCsrOuQ6rSakxdJnBczwJoSKmk/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PRLxACs6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso512904e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786081; x=1733390881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhHbLSbi+1lky1o+Pz8IqrlWhoDlD5xGRmhjzmPSnWQ=;
        b=PRLxACs6GNXTRNVNrIfJ2IY4tl9jj+7C2b3zokJmg9X/NKJCTtReyCF7FaY4zD74xJ
         jPtBJ/JjX5yujZsh9UUO46wBOeGch4uufOiFqvyq1LBsEyFmHpd1OPewzalZzhxiSSGh
         B21QVXdjMOdjN22o2mfC1oqSQyoW4j4cEvWFsdhf81lWCH2FMBAw+0fOKNk2le5sl7eD
         EnMxDgNLmshsXOII2IovJdcnSwlA2qa5F5LaOUsh+D4VJ9S+2VASvoyUcc7uIq4RFHUx
         a7GR1EMykJqHR15qFtbEKEOZa/k3jeR98eMb6ZgQ+tpRAdb6AztJzfiCCUpGPAeKmn9A
         Jz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786081; x=1733390881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhHbLSbi+1lky1o+Pz8IqrlWhoDlD5xGRmhjzmPSnWQ=;
        b=p1xmPejrKPJUEbuz0qU9QY2kF3lOK6wcPPbz+qxsOWDo1PRLdJ4ENf81DNPgDQACJu
         k13YeFnFC76Th9SRau6hb9megOwK5rcAJ0Svd6t6qZ3JXSHA9Z66P2TiUgmeV7l7TXiV
         84fb208ie2a/AtTA9/5ho0LjjpC7Iw0UReFhXpr+q7FSExwiKlJL3DGqsGR2MhRgygna
         DGENN9rgPMz5QTMYgBJRpomzpreSdSLwnnrbVfFB7Mbe5c1B7g0HRm6ilANnYQ9YlcJu
         eaTm0SXq/Xqbz82udEeRJMLlhpaDMrpZCwSw089CPkNXo1HKUXWYiQ89gtQXEySK3osA
         YnNA==
X-Forwarded-Encrypted: i=1; AJvYcCVR0aP6ku9n/PxZ/mEBI10jL33cLjW6pK5LHaUBETqIk7NiKwCqacJB33pZuzDybOTjfrEcgH88tE1gD+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYPRUO8my44Hb8R77qMENQAiQyVmQwvuC9tXJg2SVaR4YXB6/
	pJbA/rii+yaOheNrj92XGzjjIKuw2jHpkz1/iCC5/AtVsd10o+Kl0QE3yOJJ2UQ=
X-Gm-Gg: ASbGncuoyQ3LozS9+6UwwFZX4rV92Yho0J6ZvZCDEDKak1QvIvdu2Hwyx/vrDmT/yhp
	QEHMivajIFzqK87xnfSCtckAaeohrL59QgR3uyd3tBLTz1yImZHE5ORqTQPvhMBL03nthu1HuKs
	kI7hAnKG3Ck4y3mjsX6fOUdee6NCIaUg/ZaMuKffIZRKxQtNx+8mTf/VScBVcESZEspOREKQMMQ
	19NHUQG+LhEs55UKgSTWAXM5IiFl5MePN7tB3FAnOpMWzeVuaPO2559eN8=
X-Google-Smtp-Source: AGHT+IGBUhsP3a2SkQaqiE7IVzKlt9UpWFR1dd6jSL9aJlBBkeTjc+GoFRAA0Pl7qUeeEcDMbwvYhQ==
X-Received: by 2002:a05:6512:3c99:b0:53d:ed8d:9a14 with SMTP id 2adb3069b0e04-53df00c7448mr3722933e87.2.1732786081175;
        Thu, 28 Nov 2024 01:28:01 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:28:00 -0800 (PST)
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
Subject: [PATCH 4/9] sched/fair: Remove unused cfs_rq.idle_nr_running
Date: Thu, 28 Nov 2024 10:27:45 +0100
Message-ID: <20241128092750.2541735-5-vincent.guittot@linaro.org>
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

cfs_rq.idle_nr_running field is not used anywhere so we can remove the
useless associated computation

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  2 --
 kernel/sched/fair.c  | 14 +-------------
 kernel/sched/sched.h |  1 -
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 63ec08c8ccf1..0c8e21f9039c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -847,8 +847,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_enqueued", cfs_rq->h_nr_enqueued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
-	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
-			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle",
 			cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2cd2651305ae..65492399f200 100644
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
@@ -13547,7 +13543,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg->se[i];
-		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -13558,14 +13554,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
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
 		idle_task_delta = grp_cfs_rq->h_nr_enqueued -
 				  grp_cfs_rq->h_nr_idle;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8727bfb0e080..d795202a7174 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -648,7 +648,6 @@ struct cfs_rq {
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_enqueued;
-	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
 
-- 
2.43.0


