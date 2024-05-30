Return-Path: <linux-kernel+bounces-195356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6B8D4B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E077B1F23250
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E361C9EB3;
	Thu, 30 May 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx6IKDNp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A916F0C1
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071874; cv=none; b=loaa+voYP5Ywq9zb31pfFv/ukqnjRHKjGq/nDNUO/HfcPxvDtTIgGroHMyElSnEU3iStja4ZmLK727EQv9xUrNBZ94W8zx5ie1lUaVy5b6ymHefd1s/wEyVdy4n01t77tJxYVkMtL7/YMNMX/5wJRto0cLGoVA4uCpdhrJUA04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071874; c=relaxed/simple;
	bh=s7Tp/gW4dylEz7+Qb9iL+PdGH5zIgATcrxvD9nLEWoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk9Biu5USrspm89Y3mStjQohJT1x+YX/3T3sA8jYb6hWE7J8QBvauXEH8aScM7mrvvpd28dPdNt95wiZNNt7/IlBwYCO9r/9WGhcdEdxs4+G74AQ1bPhzR7n0MwxjZgSDuJ6h7wm/M6pH0OwoUxd3fNw6kWVcw50uzDMynejRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx6IKDNp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4a0050b9aso6799285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717071873; x=1717676673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVavlMvyMd64Xp7pg69LkDUlV3ao7rCW+YbfGdGmSAU=;
        b=Hx6IKDNpflohnhp8qs64jFKdqcxtCgn3EjZgta/c70awbQzxA7cPxneArMWR2zmDLi
         TuV16DuJ8rCKfOKOM0J6POfuljFiZWXOoBNFA7eSOZh5Qo/WNi1RWfbA950New+xihyw
         dCOjJFYBo6eQ8WGuaAgwl1Jsztzskskfzbtu8leIc3m6QJ8sbvyUh964ero5k9kOvJgC
         HfI282F4IBlrynHvpSCr7EBEVpoo6xbnyLe3Qjs6QM6w/vdPwENSBufcSgC+L0tXRBow
         OAyijnNfU0L9HkUY8aLOu6KjV6l8SfT2OxPE6JYpECy8XTIwJ5rtqDTgsyagQygL/sqd
         q4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071873; x=1717676673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVavlMvyMd64Xp7pg69LkDUlV3ao7rCW+YbfGdGmSAU=;
        b=kv+5JHKABTQX53gR98JmB7SeDOE9bBg84xP9VKqHUflMu11Yn1iDI3DWlQTd6ZFrQR
         doA2m/Vy2imGeX1s77KQ5kXt6S6lC1ajnDfpYSs/WLJ2S9HClVctNeZOrYh7ZI3zvrTn
         QraBjwep/2JBJ8YATUQRf1hTJAchIt0MpgpSuAIey4v/hIHflH9MyD+3ZCXjnRA9Wuei
         hBvEFw/bmMKeO5lfGSAUYz+4aeDOfboL+CzOqmYQDBvgJ5CxEfXBOiyZsni10MsbkkYa
         Di0AmPmb83+SvbmLeC8VkqhUybYuoX4Jn5qimXcGUcDFkgfDAFonaPk7k5IDSoXXcmJD
         eveA==
X-Forwarded-Encrypted: i=1; AJvYcCVzSNC0f9ttqdAC1aYpk97tOKb5zBNAN73Wi1tjqMc9Rxvya6/5h4YNcumF3FfGtOh8GKZUBCNKWwvkMyPTuiVD85Dm3cl3+v2TzGG7
X-Gm-Message-State: AOJu0YwXdCxi45xIxOkNPQoM1hQq0cWGYvSY0fFWYVuKNnHtA95HO4Ml
	v+9jSWgiMvJ57/4ei3VWPn2l+RvQ1QKto66ycJZAIHkOjqYnrsci
X-Google-Smtp-Source: AGHT+IHfi5Yps3BwUmTiWlf6FCxS0A7pOZbcvRpj6RTg9QMe+gzPGrRzk9JVepx/IK4QLaUD9ombRA==
X-Received: by 2002:a17:902:d2cc:b0:1f4:722b:9b9 with SMTP id d9443c01a7336-1f619b23bcemr25490075ad.62.1717071872757;
        Thu, 30 May 2024 05:24:32 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f44c558ccdsm120548185ad.0.2024.05.30.05.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:24:32 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>
Cc: Cruz Zhao <CruzZhao@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH 1/2] timer: Use is_idle_task() check instead of idle_cpu() on irq exit
Date: Thu, 30 May 2024 08:24:00 -0400
Message-ID: <20240530122401.3826022-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530122401.3826022-1-zegao@tencent.com>
References: <20240530122401.3826022-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idle_cpu() was initially introduced in irq_enter()/exit() to check
whether an irq interrupts an idle cpu or not since commit
79bf2bb335b8 ("[PATCH] tick-management: dyntick / highres functionality")
and at that time, it's implemented via a simple check if the curr
of task of that rq is idle or not. And then commit 6378ddb59215 ("time:
track accurate idle time with tick_sched.idle_sleeptime") uses the same
check to do accurate idle time accounting.

But since commit 908a3283728d ("sched: Fix idle_cpu()"), idle_cpu()
takes scheduler stats into consideration and becomes more constrained,
and therefore it tells more than if we have interrupted an idle
process but also whether a cpu is going to be idle or not since it
takes queued tasks and queued to be woken tasks into account.

However for tick user, it is too much as now we only rely on this check
to do nohz idle time accounting in tick_nohz_start_idle() just in case
that tick_nohz_stop_idle() is called upon irq_enter() if we actually
rupture an idle cpu(process). The use of idle_cpu() simply complicates
things here, and the introduction of sched_core_idle_cpu() in
commit 548796e2e70b ("sched/core: introduce sched_core_idle_cpu()")
proves this.

The use of is_idle_task() just like in commit 0a8a2e78b7ee ("timer: Fix
bad idle check on irq entry") helps to save one unnecessary fix for idle
time accounting for the newly force idle state. Note this also preps for
the remove of sched_core_idle_cpu() in the following patch.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 02582017759a..24c7bf3c3f6c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -617,7 +617,7 @@ static inline void tick_irq_exit(void)
 	int cpu = smp_processor_id();
 
 	/* Make sure that timer wheel updates are propagated */
-	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
+	if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
 		if (!in_hardirq())
 			tick_nohz_irq_exit();
 	}
-- 
2.41.0


