Return-Path: <linux-kernel+bounces-206503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDA3900AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B9A284941
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24F19AA7D;
	Fri,  7 Jun 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WYE1Y+a9"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355343ACC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778784; cv=none; b=nCPXabhA83Sey8kU2NP9tIcD8Snr7g813AOMFBNtKkw9FoLh45o78akqoD4R9hMua52ZoGTxnoNt1Ij+leu7k1//oytWBb5d6LvgRpKDhdijhBezPX+LD61kRmyC52cTZtGJkB/jPuwiBXoL5OUlUC27WgRhqr+1ZDwfPOB+weo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778784; c=relaxed/simple;
	bh=9MbnM3fVlAk+fcUA/Vtc84nNWKYk7sEobTPiOwK0F9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsT85ewPSud3t5oC2rU5ysYysch/CeOHZievQfAKw6KmJlEM6R/9MgGbrra2AWpUob4ek9IRZPq2dHSrFZjQC47wjFrailJumIOJV9OETH9tOOm45sXtiWbGDMwMOfgrn81K45DDiC8stHHbFeZzMR8BQAjCbJPFM8eK34EXx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WYE1Y+a9; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eb12b2bf78so99876839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717778782; x=1718383582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNmY6jHBKJ7etyJaxizFh2YSvXl1eDIGgCUXVjnXwMc=;
        b=WYE1Y+a9k1UBKIBb+EwtwHbxtn5sGTVF3jp/VGg9VOP/2g7BYMHptIgNSnrHD1rpM1
         MH5O+4n94RApnVtVsjRKb1ArvtoCHTipt5tsdz6I9UEVq+oqCrS68/J7H2Qr5xZkCjgg
         rsLLMXGiz2KQBdirqDoeGA7V4iUyaHRNKoeQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717778782; x=1718383582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNmY6jHBKJ7etyJaxizFh2YSvXl1eDIGgCUXVjnXwMc=;
        b=gb6FY4j5H/f3naPfqRrBSOBm3wpQsGDMKCNDoYLE4Td/SPdfrAtTNpaBZ8Cz6VrC1N
         XgPrPxXMt4+IxtjGGziX/VRMmcZHXz3Sz4nExC/QYQfuXVWgc1IPbZ6IhuWmfGNogVo+
         0fON1I6OG4BsSLvY6+ZZSq4eoek7/EZeWXsfu+2Qki9Fh8+5YsEB6MulDHkNkjmA/Ocs
         WuVLJnJtCAuBFOGZUU8q+BEWs7I1s1l42Xgz7aUkjwTRutOtbMT6wzhuXTLl+fe1Zyhq
         gpkLGJi2z1JpJwlKiQ3Et9z9B3i8MCFsqncHe47z3La3EZ3rmVZz8hTlCBVorcE+ablz
         9M1A==
X-Gm-Message-State: AOJu0YwG6JwdNvYXRD6qCkNfkyDE+h5r6stfFZndJEtCF7hR48jHu6tl
	xfN9Iz7+yg6rUYg6EEGyM+SPYlBYmsyxbbBb45l3SBUUgmBVb9dl7xI30nVsHfYHEuBsWdvwOB4
	=
X-Google-Smtp-Source: AGHT+IH/SKi+9fM2Uf69Jf8q6FQ3GQtOXugENfNyRQ6rvdkte4TkP7CL7rkEvXS6Q7835WfoxMzWOA==
X-Received: by 2002:a05:6602:14ca:b0:7ea:ff17:d3a5 with SMTP id ca18e2360f4ac-7eb572164a3mr418400139f.10.1717778782143;
        Fri, 07 Jun 2024 09:46:22 -0700 (PDT)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:7804:4c5e:f046:e9ec])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a225cd0dsm903815173.58.2024.06.07.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:46:21 -0700 (PDT)
From: Tim Van Patten <timvp@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: druth@chromium.org,
	Tim Van Patten <timvp@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] workqueue: Prevent delayed work UAF kernel panic
Date: Fri,  7 Jun 2024 10:46:11 -0600
Message-ID: <20240607104610.1.I6c23f4fdb786f7200f6f1255af57b4e9621bcc66@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Van Patten <timvp@google.com>

A kernel panic can be triggered by delayed work being queued to a
workqueue that has been destroyed (wq->cpu_pwq nullified).

Commit 33e3f0a3358b ("workqueue: Add a new flag to spot the potential
UAF error")added the flag __WQ_DESTROYING to help avoid this. However,
this solution still allows work to be queued if it's from the same
workqueue, even if the workqueue has been fully destroyed, which is
possible with queue_delayed_work().

1. queue_delayed_work()
2. destroy_workqueue()
3. [delayed work timer expires]: delayed_work_timer_fn()

To prevent kernel panics, check if the pwq and pwq->pool pointers are
valid before derefencing them, and discard the work if they're not.

Discarding all work once __WQ_DESTROYING has been set (including from
the same workqueue) causes breakage, so we must check the pointers
directly.

Signed-off-by: Tim Van Patten <timvp@google.com>
---

 kernel/workqueue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c9a77d0..6bcd5605dbc8b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2291,6 +2291,18 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	}
 
 	pwq = rcu_dereference(*per_cpu_ptr(wq->cpu_pwq, cpu));
+
+	/*
+	 * Discard work queued to a destroyed wq.
+	 * This must be checked while the rcu_read_lock() is
+	 * held, so destroy_workqueue() cannot nullify wq->cpu_pwq while it's
+	 * being accessed here.
+	 */
+	if (WARN_ON_ONCE(!pwq || !pwq->pool)) {
+		pr_warn("workqueue %s: discarding work for destroyed wq\n", wq->name);
+		goto out_rcu_read_unlock;
+	}
+
 	pool = pwq->pool;
 
 	/*
@@ -2365,6 +2377,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 
 out:
 	raw_spin_unlock(&pool->lock);
+out_rcu_read_unlock:
 	rcu_read_unlock();
 }
 
-- 
2.45.2.505.gda0bf45e8d-goog


