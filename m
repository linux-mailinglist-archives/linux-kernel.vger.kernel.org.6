Return-Path: <linux-kernel+bounces-525018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498DA3E9DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2053BA032
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B03A8CB;
	Fri, 21 Feb 2025 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LF105ZXb"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334438F80
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101020; cv=none; b=YHF3OeQwSFkvOQK6gWax/BsaJVkGXJHz6bCBqg/5onQmDgngfkyeKF8sgV6Rz6WsEkeftcYVXv2BY3nnADVtAHGF21t5AYnMm7tTJPdnkEHm+J5NnlB+rj/ehP/ISyYnSJs1iI3418rs8smMkXX8AEw4I6PkENcYDyi3vaDRTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101020; c=relaxed/simple;
	bh=+/jL1sKjxeHLtWo39rgoJcwRWHPJLm9CyMRjFTSQPKQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kqOOIqP3hLuwS3CH1UfIuA3D+H5n0Xnaz7yvXnLJBAHY2HUHntutAXQKsJSZQkJ6W4uOstnhEyeTfUPIgwm3HYT302n6+9Gd5H7qaHc0YgPAMNFF0Lj9+B77oairHsopdrz3YoRDJXwoFT1UXwjELxZtqeivo2GxD1ouSMKBuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LF105ZXb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22126a488d7so35083605ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740101018; x=1740705818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jsBMZEnf4s9t1bYeOLz4VcLKTvIZtrhOEcgEkKEyanQ=;
        b=LF105ZXbo1vi5OmS9ixCQF59U/2ZwrxpUEJI0rBHrhxEC21gmQ8ejR8VJapvRRdo30
         1ppjZDlxmMpVEM/+p0NZla4UUXuEmxR5TMuAHY05O/oOd9mEuw/iY41xi/+dPsrb0eKy
         EUaw1cB16awz34AIIJC7LZWeuL+X8zVTO+/uJUiBnH0w4rSh3f2bpxpsntTaaxY0JL33
         Vffcs54tWQenCVLawRnWjsn+F2t7MU81cM0uZ2XLRK8xVXFNV/m4zyiSK4Afu+J+d1QU
         VcagKZTjychYq587Zj3t/EkQ3N7tLzzIpO4ZQb7wKdhpJAuiEknqgo26oeDGcCU118gP
         A7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101018; x=1740705818;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsBMZEnf4s9t1bYeOLz4VcLKTvIZtrhOEcgEkKEyanQ=;
        b=MuOC86Kz4Cj1pulqk6G5mrsmnFifUW7uUOw85MWoOPScwGXe6zYMNGVrgHzeSboEZf
         3TpQrQb+LZd0zwmz4So/XsQYOTjQUqEXKX+PvL1D3Ru2lzo2B8q/cTZ193+lNHgNOds1
         4BcuczV7GTyuQDHvyaZFizgZW9EtrMDBuXMr39LCMRLAWTPJ+dNCW2J4hO9B5zHylXr1
         HkqfiDHdNCqesV60Wov+nKAUKlfKGCVPkXbg4H+MRI60uB3MTLrfHBdMFXoREvc5+e71
         vtTBB8MSSG7h7lPmidsI0SE4K3oqrjUiURQUz023HHW+Kqrevqw6w2sZt486VocxKLKF
         PerA==
X-Forwarded-Encrypted: i=1; AJvYcCXpjD0iQ1WUVesxmE8rxM3YDaJiVrA4x6oQ52acgwNSXt0AQUm2LB8lwIKri7QA10d+FI9oIzRAtCf+tYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4RjdPZY28Qw6o6R4G6315esCSj8aiNCCwp4V47f/3RQJULt1
	QfNphMggoUKJ7nrR0INKAKDHEKGPCSfsDaDUjCaAbOP/E45Mgk9XnHD8jqC6zY+fPEqr1gDv3gy
	y993jBQ==
X-Google-Smtp-Source: AGHT+IHs9vaSPHZpKo+lbHUKcwsd1xAf3YkXze635/rHioRLOiRBCQk6aYYiYZepHURJsKaE+oHiD0PMqKhZ
X-Received: from pfgs4.prod.google.com ([2002:a05:6a00:1784:b0:728:e945:d2c2])
 (user=joshdon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a103:b0:1ee:e641:cac
 with SMTP id adf61e73a8af0-1eef3cb8fb3mr2702900637.20.1740101018567; Thu, 20
 Feb 2025 17:23:38 -0800 (PST)
Date: Thu, 20 Feb 2025 17:23:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250221012335.233404-1-joshdon@google.com>
Subject: [PATCH v2] sched: fix potential use-after-free with cfs bandwidth
From: Josh Don <joshdon@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Markus Elfring <Markus.Elfring@web.de>, Valentin Schneider <vschneid@redhat.com>, 
	linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

We remove the cfs_rq throttled_csd_list entry *before* doing the
unthrottle. The problem with that is that destroy_cfs_bandwidth() does a
lockless scan of the system for any non-empty CSD lists. As a result,
it is possible that destroy_cfs_bandwidth() returns while we still have
a cfs_rq from the task group about to be unthrottled.

For full correctness, we should avoid removal from the list until after
we're done unthrottling in __cfsb_csd_unthrottle().

For consistency, we make the same change to distribute_cfs_runtime(),
even though this should already be safe due to destroy_cfs_bandwidth()
cancelling the bandwidth hrtimers.

Fixes: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")
Signed-off-by: Josh Don <joshdon@google.com>
Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
v2: updated commit message with additional metadata
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 34fe6e9490c2..78f542ab03cf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5917,10 +5917,10 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	list_for_each_entry_safe(cursor, tmp, &rq->cfsb_csd_list,
 				 throttled_csd_list) {
-		list_del_init(&cursor->throttled_csd_list);
-
 		if (cfs_rq_throttled(cursor))
 			unthrottle_cfs_rq(cursor);
+
+		list_del_init(&cursor->throttled_csd_list);
 	}
 
 	rcu_read_unlock();
@@ -6034,11 +6034,11 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		rq_lock_irqsave(rq, &rf);
 
-		list_del_init(&cfs_rq->throttled_csd_list);
-
 		if (cfs_rq_throttled(cfs_rq))
 			unthrottle_cfs_rq(cfs_rq);
 
+		list_del_init(&cfs_rq->throttled_csd_list);
+
 		rq_unlock_irqrestore(rq, &rf);
 	}
 	SCHED_WARN_ON(!list_empty(&local_unthrottle));
-- 
2.48.1.658.g4767266eb4-goog


