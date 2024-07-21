Return-Path: <linux-kernel+bounces-258166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF29384A2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 14:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D741F214FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51943161935;
	Sun, 21 Jul 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CP1/Cp87"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA553BE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721566351; cv=none; b=jf9ktlHghShNXB9KWRu0b6lda3pnUC9ane1aBVxtOAZ48G1ZjEogEs4jWQfPQAIZNYFNWI62CSabrQcj63rvzxcHlNJgPi7pT8QzgEC4ttgYencSkUaU2UUiD80w96yLRLxMn9xEHgfS+iiQLVY2Pk3hRhyu1qZzSudRnC0L34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721566351; c=relaxed/simple;
	bh=gzRYSeel4EgQhls0JgRSNs/ESZQm9syKAiLAxunmX2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtPocIwJRpitU5nbdN3wPLQR7hBMz5da/facy6ejTRmznITXL7kOYo09CTZSTefiE4T4wFGNNLRCeXUM2jFpFcm8cB57GuM9YzNTHc2O67+HmzAxlV4XKm7THLkkJQr2aHxIEuHJwnXJ5gEFSgzK6dqOQDDLc4dP1mm9oMvPIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CP1/Cp87; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc5296e214so27066805ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721566349; x=1722171149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B22IviPvWu7J2ChPL0whByR8fihGBAS7a0j2bozEE5s=;
        b=CP1/Cp87zUDuI/pLr7AzsMaggfOV8un3uVwe6yROVsA1tDHYBuvxOTgB+x0dsKQGFN
         h/RWOy//4zeqADYWkIOnswdG0kUyTN/XmJglF0r3E23KjJnOmlXFFmgxhNbsuytva7li
         +qJnfCTE6y9jFVoNGSh3Idgnqmtzw6CkE7h/5d3V3I7KH+fyR9o/mfp2417vjsW/BA5R
         IZFXdoUG0K4JLPiHEe7kKMS1SbeIaVkyXYn8uvILdL2DEMRrePuSTrkqed/weD8Kbg9n
         OnIh41dq7Y5BzWcAXgYQ4yVU73+1eH9eAFkCoCsCy2+IaNapsm/6UkYCBIeCv9snhIB7
         gf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721566349; x=1722171149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B22IviPvWu7J2ChPL0whByR8fihGBAS7a0j2bozEE5s=;
        b=IKicQohEFG2LJHx+Y4eOxEp72/2Nv2MSySRtJezx8+0pK1e2RN6NWwOkjdY8q0y62u
         zfn0hrOqBXD0M0S8rYfkomRp8duZfVFuUmUYzNOvhV2zBNeMnGrG8xDErEgNBI6BwZrD
         qwO+SbGDA+4oLRmtnrRM0BxouqerX884wCas/bkiPOVEud+xMb+eL4H7kOIEUh/8no3O
         7zol1Ti/3QqyKaywA9PtxEhQnGhepYAakuyG2sT3U/IvIRb2HvKLX7UoMZpJwXlnS5jE
         RPzQtc/FQy0UWDf5GEl/aoid0eGksZxeaobQaCsmPmWeqpakmkTaUC7qo+ahLE9wgEVG
         nWxA==
X-Forwarded-Encrypted: i=1; AJvYcCViIgUeuykLT1jyINf5X49XjDFyo10cbm8jejhzJZkS8un4Nkbn4GzblQw4cBgqdA93ffKOz3g975G/USig66wAFIo3vFRGQl9Go/1g
X-Gm-Message-State: AOJu0Yynil8trXgWt4f5oB3BZNaGbg+FqwxEE7bF/pJAuIdc6jPd+xb5
	h471HJfVSf99HFw1R/v+7e//8PwePVIlSRBq0WqPV84cVX8SQacMV7j8OrppLVA=
X-Google-Smtp-Source: AGHT+IFM5R0O7O1J8rP+6fMBuhIH4xHgNivDmKp3nKwR0SDc8Av8EYPsELvcNQ1UjIin3wPu5seB3Q==
X-Received: by 2002:a17:902:d489:b0:1fd:7c8a:be3e with SMTP id d9443c01a7336-1fd7c8ad873mr37802555ad.36.1721566349126;
        Sun, 21 Jul 2024 05:52:29 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f472366sm35871525ad.260.2024.07.21.05.52.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jul 2024 05:52:28 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	joshdon@google.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 1/2] sched/fair: Decrease cfs bandwidth usage in task_group destruction
Date: Sun, 21 Jul 2024 20:52:07 +0800
Message-Id: <20240721125208.5348-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20240721125208.5348-1-zhouchuyi@bytedance.com>
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static key __cfs_bandwidth_used is used to indicate whether bandwidth
control is enabled in the system. Currently, it is only decreased when a
task group disables bandwidth control. This is incorrect because if there
was a task group in the past that enabled bandwidth control, the
__cfs_bandwidth_used will never go to zero, even if there are no task_group
using bandwidth control now.

This patch tries to fix this issue by decrsasing bandwidth usage in
destroy_cfs_bandwidth().

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b1e07ce90284..7ad50dc31a93 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6447,6 +6447,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	hrtimer_cancel(&cfs_b->period_timer);
 	hrtimer_cancel(&cfs_b->slack_timer);
 
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_bandwidth_usage_dec();
+
 	/*
 	 * It is possible that we still have some cfs_rq's pending on a CSD
 	 * list, though this race is very rare. In order for this to occur, we
-- 
2.20.1


