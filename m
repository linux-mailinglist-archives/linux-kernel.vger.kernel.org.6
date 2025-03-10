Return-Path: <linux-kernel+bounces-553824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31900A58F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0F23AB294
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0925224B0F;
	Mon, 10 Mar 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9yvYEcg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD194224B04
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598393; cv=none; b=ZIO5s032YTO6j93iS0MrRZwHj4j4FZac7xjpPDutRNZABJYgTqYMEQwQl2HysG6n9k9hj2Dj9M8eMLGg05VHzwqvK5a6BSu4HiiKUoChicTneSu8dRKGJz69rXvyvsS3m1Fpn6zaBkT9HGVBjmFcWsDcRFe2tIKCi2sit5k4iAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598393; c=relaxed/simple;
	bh=ofu/XDmnupv4JAviLY8SaWPygIQTjFUfrxSbjVFGdzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb5zEmf3A/guh38qJ43JDzLxI36kMOOCHsOhGluyUX/URZZphjVRNZlLAkN1vmCDj/y/87qmu6uycRqD1A4syAWRaiO9++MnL27DO5Yk1vyfGCdOCAKOfn9kMgfn+g54gkfvX1qX14CnlUDGAsiOJzh35l2259IyTg9WgUPZcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9yvYEcg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5e8XPVQftzsj9VqneTTVVLeBZoXHhJpQKjzVqdDaw4=;
	b=X9yvYEcgLnss63Eu323Nhimykss5Mef2THYW9dDUUPrKMrjEfaYcUsq4sKbCVhErHjQuWe
	CzGvdVqCWtNixz/L3VEN9WuWphbx3FIvtkMIX+0oml5Q85CmXR+bst74i+LJxVMFqiTm48
	aogOldoYmNKm402QMztuF9mpbKCgvMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-BkeH7Kd8OvqZGd_uQQDDpQ-1; Mon, 10 Mar 2025 05:19:45 -0400
X-MC-Unique: BkeH7Kd8OvqZGd_uQQDDpQ-1
X-Mimecast-MFC-AGG-ID: BkeH7Kd8OvqZGd_uQQDDpQ_1741598384
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd92233acso32348865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598381; x=1742203181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5e8XPVQftzsj9VqneTTVVLeBZoXHhJpQKjzVqdDaw4=;
        b=pTIMcnmTxsf5WTVrHJV7xcSp9mvpxBHESvRgv2sKkQkEEguMWK2f5dlq1aitBEc1gZ
         DmMOxqCXIAd4PLzSXRU59HU/T7tmLEuYesvXgF3BTJKLOTQulwHwGNA5rA1FewICsDhF
         ARGJNNR8sSMwKXr+yJg//TAXPtXj9ewcOXZsqbhsxffBhzMcmoxsVLRT6yEKXt597zpZ
         +t/VilU2BJgjbfEn6RSFn1hclDZ9i22mmz9D5qy4iIC+lUv5Wze9gjNFaQWMJVjmwgV4
         LFNhGKhVj3iSpHSaXjhTS8nEqHy4THUqSdBK9cOYvT0GYco5d6XpCyJxBtvUfWdBtOJm
         B8tw==
X-Gm-Message-State: AOJu0Yx/h8qV0qQa7uvDdpVgRYlFv5AiESj4hzSH2P66F5PpWWRLfAlP
	gpjG7VoKBSiYPTFIgryiptXm0zSfiaRnOGpKTKjX+TB56asJGYj1C9U/dStFx/8gMd5+9RuABUW
	9xIFddG/CEs5MsVqBPgn4ajs6vqDVd1hAHFu+3x1amGoGUfrvA+RBO8YBPkWxMbBDxfpkKeTXA/
	A0yWWw57BvjXaNUAa5ZBt7ZoQnk3Gm1Nxp//YPhpTZTSYW6lQJTNw=
X-Gm-Gg: ASbGncv7q4YBMxGykn2+MhOHGSIjOtFwpFkLjNibiR9sqa+PqYlknxwEFwt8M7YQV/g
	+YkxtNETR5ZzHlqvT5aSknO9iFIq1JWBuqMXJR+JaSoslpyYoBQEaZXwZqEGJNnNOXYKJLTNvZQ
	wgq8Su1foMhlqo3GYtb+tfwwvCyaSzt9U3zRusn+oKL5PjyYwn5e5KDWB3j0jMS6V25QM+iGNwk
	7SLu6jGay8Jewll45q1nSqhu+nzSJavMzJvZ93EehANzFM9gUtop5meTa0n83bcuPPIjQJK5GJy
	9CaCVz8JbFbtbdAd6sjWoLZk2cD0EUwluxbbktic4p4=
X-Received: by 2002:a05:600c:4fc5:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43cf9691636mr14252115e9.29.1741598380877;
        Mon, 10 Mar 2025 02:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYwaPQhNcEyHI4jeS2gXnFMH/We5pnIXg1uaGo0WIN/FUnIPC+tMOh6jU3BTonbxCUdQr4Rw==
X-Received: by 2002:a05:600c:4fc5:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43cf9691636mr14251705e9.29.1741598380400;
        Mon, 10 Mar 2025 02:19:40 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm77462735e9.1.2025.03.10.02.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:19:40 -0700 (PDT)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v3 1/8] sched/deadline: Ignore special tasks when rebuilding domains
Date: Mon, 10 Mar 2025 10:19:28 +0100
Message-ID: <20250310091935.22923-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
make sure sleeping and priority inheritance 'work', but it is ignored
for runtime enforcement and admission control.

Be consistent with it also when rebuilding root domains.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff4df16b5186..1a041c1fc0d1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2956,7 +2956,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct dl_bw *dl_b;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (!dl_task(p)) {
+	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		return;
 	}
-- 
2.48.1


