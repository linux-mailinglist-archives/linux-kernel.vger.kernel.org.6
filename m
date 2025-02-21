Return-Path: <linux-kernel+bounces-525650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31785A3F2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E5B3A6AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1D2080E4;
	Fri, 21 Feb 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C4B/Ob8T"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E32AE89
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136368; cv=none; b=RgMyLW/7ei1JIi2kvUzMsEGP56C6zI4K/HW3TVUk7FcAXlM4mIvCSzHG0Y2YvjoxKAgu0UCT8G2fQc080i+me6NXiSzGsComDjvA9kP+vWbn0jki8i15t2PzB5ZpCIJDEwLFlbO1LaKBQF1m0WcJ0kjVtiIrv7vc6oS8+isJ/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136368; c=relaxed/simple;
	bh=P5gdjvQGiF/cc6UIBWYs4SL9r0GTbZhKImCeOT528kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VUFHgF+7WTu5Do2Fc09nWKNg1McXkEQ3UxUDUexxsnan6IC9zrPZO9bYRb/mXqKo8kGrRSw81AVH5ThS1XquCNmEMhUfSsAd4vSQgqyu4FxnfUk4DRyvtan1y/2ZuEqbFHyZi2KDEfjeB6hFrCJJhPFy+mJeUdO5BVtBEdNYSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C4B/Ob8T; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so483192a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740136364; x=1740741164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vh2A09kqHfCBThBjc7NLqZV9vtxoGWcvVKGUpFi+JPU=;
        b=C4B/Ob8Tnr0WKuwkzy192oPZ4L32X/Mpc6Ttik8AP97TAvVx7nFP4UByzsYCdzI0Lm
         JwumXkYFgAgP1cxrHOkWycEuzZLrVN8RQo1ebflFRo9sux7jrNRhl86nVA+KuVv4jvry
         ttEhRmipiSkhkAh+RtgYSWYPtD3ySDNzkrn6TejmupV+VDtBb0eFPatDlEpVW7kUXiZY
         GKhj4l85D8B4EdHe+ETvELcpuGOY3uZOY4/xRkZP4hN9mUCO2IqhsEKdSTlgepD5pCOV
         IVVq/UDNNN9XHjeQ37CGfcH7sl0UTZvpFXcrAB7x3iPBlqsPKGvBCw4rPJri+ssaAtL5
         A/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136364; x=1740741164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh2A09kqHfCBThBjc7NLqZV9vtxoGWcvVKGUpFi+JPU=;
        b=ud/Yi5PxJ8bn+Pip+WM92MZgRf+smTLiUREnaI8VlCknk7o0HckkEpDGgPGGezRF4b
         b2wYcXHbkuzVS/4ARJfr6SYv0qO/btSGgkwwU3uG2KTz/y4BZ4aJl9pPS/5HAob3CTlv
         TvlskTTEaV6gJfMPj2JFdNhQbGj8HBxTMeQMATXOHAOCeVD8cYlcDWHwTppDcAb4m8tC
         mPts08/mNS2sTzezyCtbKObZAi7Bm4x6weMSh0+/5+B0pSD9mLjT/U/ie6ny7YHT1pQD
         U1ObDosj7H+Xylu4TJIRZZvPNnB3RuRE6WLlcbsYC8CjBbvJcAHk9REUrrqOzn1VAiQp
         koLw==
X-Forwarded-Encrypted: i=1; AJvYcCV7O9OhdSRChxITGOUFzkDEe+xf0BKhOqckNhFKh48Qj/WqycBsVlpp3oDdZxLEF364NRQBhfNLW80oTIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTiQAzAj9s0IBGDQ7JGxhi2/HA7tqvkruRYkLNrfceqLeajlnH
	DBV6oIH14yX1xZmTRZ2+0mtYxfuy6/UK8ulceVD8rhYB6rCzkbPhkCF9f9USyGg=
X-Gm-Gg: ASbGncute7wThLw8UuihjLBdjY5Mmolh2wSWTKN1dJFT1L+mgr46Uti7PVVqKaUk2wX
	guHD4L0CT/kSEKVGFEi+30OfmwZD2bmiitAfW1aT+lNlzZikvJQNF5N/luYgBKNvUivnVNOmw4d
	4U4E+thjVEvq49aIgZ+UJfG7E6sIxcMlo7Pah+5+AUhBZmXZjKzLWzfTIeaL30ijosUldHDjG4f
	NMGxJWTlLlkgu/8amH+tsrkgaK0boInykcSRajxKo/PhAOeiKT0SsKFWscdq6n5VUlMUitTWhtC
	uUUF+6YUQzjmeoWSZpTZh++1CYD86dPxuH76mBFH8rwuZ3mlPJt4PbF2C+4C/z06
X-Google-Smtp-Source: AGHT+IGCg/3nPE7zeSEYGXZNcCBbQyvGpgF1eQQkvGyYsw5zi5AzrR/cD6GECmTAj6PYRrOgMcxHXQ==
X-Received: by 2002:a05:6a00:987:b0:730:8526:5dbc with SMTP id d2e1a72fcca58-73426d77d7bmr1692605b3a.3.1740136364292;
        Fri, 21 Feb 2025 03:12:44 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327237a5efsm10205145b3a.127.2025.02.21.03.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 03:12:43 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH 0/2] Fix SCHED_IDLE behavior on wakeup preemption
Date: Fri, 21 Feb 2025 19:12:22 +0800
Message-Id: <20250221111226.64455-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1: Fixes unintended gap between SCHED_IDLE tasks and entities.
Patch 2: Fixes scope of WAKEUP_PREEMPTION to meet SCHED_IDLE semantics.

Abel Wu (2):
  sched/fair: Do not let idle entities preempt others
  sched/fair: Fix premature check of WAKEUP_PREEMPTION

 kernel/sched/fair.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.37.3


