Return-Path: <linux-kernel+bounces-428121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62319E0A63
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C037281FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6C1DE8A5;
	Mon,  2 Dec 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmM+QgYH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02F1DE4FD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161591; cv=none; b=UWZH6Im1jGp4QoJzPG3hOTEEpItmnc7TJrGp5Uyvp6arW//91hKE3XknX1DYo671qzzd+Z1+0TAg8wxqUHByp3mAMTkwZvCWQVfnve/psg1bU7tm1rauHCsxi/qyy5THFs/1dw6wZoL6ycf+2WEL1DMeD+vf8hJvLJExLrS9t1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161591; c=relaxed/simple;
	bh=m/hgL1xLhV8k+CAYnNCYojygX/yF8uKSzeNw5fq0AzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V33RNxi66VUw52Umazmphp51cRIoWL2NH/SEWEYdXC71wAS4hqmL94NH8MkwMM/nWuuQVonrwhVZugcGps8tZruwRkHv/Fh2rsq9QuYLH9d0rCB3Fitpah7S6VdvgohSiKQ2lsSGSKJSn+tjYSeOX/k2lZ7uuRlvyH9ngQ3W/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EmM+QgYH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso39803745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161587; x=1733766387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py6vIgzd70aBYUcFacLlH6wRilMj5qKT5n2w86MfaBw=;
        b=EmM+QgYHZDcyFOtskxuIJTrCWn+I+5EkxeEw2c8fy3mhsEXUmKDCgmGwJTDjzZT6nL
         fBhZkrjndj9ePS5hNyWpmSDTlYU54CnvWsgPGIOSadzN9f1WaztnV8G/PZMyw/G/S4Ll
         2Pyy6Ka5Wf7DWy9syq6OoWX1gHNKRiUncVzmGCAe90Du5yuB4FX+7Q5hsDjBchJeiftZ
         /0lqEvMIc4Zj+qWRSwGvGZ2lfR5OSlQZQfhJv81YmnD0XrzGXX71z7QpHndCO0HLEjjM
         mIuwkwAs6D/8MRODrGIUYW5wDw60qjDNh3aq9eA+4CO5fpOSFmS3zbvf3kPZF53NOAeI
         I3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161587; x=1733766387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py6vIgzd70aBYUcFacLlH6wRilMj5qKT5n2w86MfaBw=;
        b=ePoKNu+AZcYvObTXu1fP13wukHCYmBxvLhTNEngEbDMyjhfImZ64FQ20kPgt+Ienfj
         IPWNGu3P1LcT0Pvdyu0XFKs+Fpd+ZIfKk3AMDFtDXV6TKltDXmcWOy0Rl3ZBdPzUSkay
         /90Q8fqici0YCPXao0Qru4ltwl0aF0Hf8rAFD26xupWuRg8VCggGWo/6PDSYyIoX26VL
         6IL1k8CBYp4upXNnt/pb/R2Y2iC3JaU64sujgbCZ8yIXQty3JkKE5h7gW5IVVTcHdkbD
         aVwDpTlGHoAVDGBdDXNSPmycg5LJF2oA/+V0MzWwr+FHXRpzuNV8vlc8KfadJzOSykje
         qA/w==
X-Forwarded-Encrypted: i=1; AJvYcCVPUvkhxx8EpgdZAb808u4cSO7XxwIk8HAu1G4ilXRY3xVxRBBNoNphSR7sLSIg+6serHPFnRCzWAg9AZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmirBGIX1VjKghnLP+juidpZ2GBIT19BveUqPRX+Roo0zJrvXW
	WT0BKR3bwkr9tqHFhnI7GYwWDkbknVI3bbSeFlcV9mVrWM6rxQ+II7Y6Scs10MM=
X-Gm-Gg: ASbGncum/1VKkixzTCm4+fzjdLUGbLLJ6MENJfeIuU8I8LZhv0cwegwgio9zOHiKlTm
	dU2i5MG35VQ3Skzvi/ODjbuPfROEWWeDoI3VN2p4xkmTBIoYq2MgurBcRuQz+3a1iXcv83vfWVr
	dsQRn1sJNIrA6ChF9QEJ356qBBTXk3Be/KInxzb9n6hrK4luCU8ez1LsfIHi8hBwojDBNUweOmn
	utCOQgKUZZXzMsNyKvGeSnDG8t1Tr2b5V7l3+OH8Mdqxjc0zrUIhibkoiM=
X-Google-Smtp-Source: AGHT+IE5zSBvndweGRLr+x4vyGXPTmVDchC6STqPsDBA/UfhaJVJSRz+acbYML83vOw08pcsUR22Hg==
X-Received: by 2002:a05:600c:444e:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-434a9dc8297mr206023425e9.19.1733161587127;
        Mon, 02 Dec 2024 09:46:27 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:26 -0800 (PST)
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
Subject: [PATCH 10/11 v3] sched/fair: Do not try to migrate delayed dequeue task
Date: Mon,  2 Dec 2024 18:46:05 +0100
Message-ID: <20241202174606.4074512-11-vincent.guittot@linaro.org>
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

Migrating a delayed dequeued task doesn't help in balancing the number
of runnable tasks in the system.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 95c51604e1ba..555a9eba5486 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9394,11 +9394,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * We do not migrate tasks that are:
-	 * 1) throttled_lb_pair, or
-	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 1) delayed dequeued unless we migrate load, or
+	 * 2) throttled_lb_pair, or
+	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
+	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
+		return 0;
+
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
-- 
2.43.0


