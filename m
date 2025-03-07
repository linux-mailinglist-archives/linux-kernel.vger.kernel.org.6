Return-Path: <linux-kernel+bounces-550350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643DA55E40
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EB73B468E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DACC18DB3B;
	Fri,  7 Mar 2025 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FmKbf4vX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1416C854
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317708; cv=none; b=WCMfvbMG+LddBaVpnRSevrvs+Nqp5SsadRIeMpppiuol76OBoN/nSPVuhQEfPxnxUbZtW6TyK2yFrn4x16qgfE2j1Nqv28YiT49kB27NKGaobQ0p6qYIi0XBSu93k5hvMqFewIA2mmFxziKmLZ85ey67FTucZ2+44zIhmSt3mSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317708; c=relaxed/simple;
	bh=sb/tY6RnUTd5sjFAwJ6gR8OEHHbvu4xlt/t3CIV2vCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MYCjneHFuxfwjNjaAHALxSI7jLAzDOqTbR/q6r9O/eIV4KstTiKzMVm26i0hJKtTTQOraKRV1ck+romwqX34OcYmGpgdVTKqhXdIvS+tnR9ge9dx3n4sfSqUNYg+zwVvWjNQk07A0BXQNV+c1adu0Yl1XusATppyFsQNnt8iiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FmKbf4vX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224172f32b3so2608805ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 19:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741317706; x=1741922506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JkFqFbD15/e+bhfTcg0dS1K84Mbp7wNo+7XsIkEauI=;
        b=FmKbf4vXy+SyN5ZtEHXYQYoeL6MhYeavsRjg4m79rn+FfAfgod/EugZotU1RZJcKn6
         p+2W5+CV7Sy9RIkZNF4us3Ng/sXuMOjuyYUpOCCoH1+5noA7iLHgyzlII923ng0Yvhns
         ocqK+sbJ3XcHxfQC0klewD8TF8+B6YogFOgMlCRuaR7/Zo6mPmmlPc1cuGkQ5tcB54Wd
         rocgvcRRagIYd/Pu/qVa2sxZKxUCPlsGzwNfr2/72LPofOGaUpkf7kQUGrcQmJyBiK6l
         CXYtZGBMFz6mkpJ1ZPWMyV9GR1O53qOxCkNVtwj+w+hMWrTJmDLDFMLa46EEQc6aFSBM
         Dxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317706; x=1741922506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JkFqFbD15/e+bhfTcg0dS1K84Mbp7wNo+7XsIkEauI=;
        b=kfZm8I6L4Y1M3GFXnYier283ybeDOzCS4UsLqC+q5VABgblIDvC7WtVzto8UbjEgTs
         4e3AuDjejkQrB4WsI9GJBAEbckvrepX6Etl0CJN/VoBs78KuNCjnhi68kg4XVddjQ46x
         tcdMtKsxs6UGMHmoYgGvqxsqdLQGxgmGPMhqspEpo3LHBEtEqjR0OGVZbgCQAeBMdHH8
         NNmZXaZYfUcrLSp20GvpDF0RtrgPcgm/S4p4ym9QBY2PmQtlqGv7zbNrRxR8e7q4kr7F
         JSh+ad5/1ePA6/TRaPI90G0QyX/YzDK4xSoOBeUhFce5dBXDWgai2cSAz5iG+syVcxq7
         NhIw==
X-Forwarded-Encrypted: i=1; AJvYcCXrn+yJVJ/PMsZK08qCompcsyLc5+rohfsmiaumTVDW8A/GyKVW/D/HeeSNE/KspoNzevCi7ovPqIWugRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy370UQ6LrLNaBzpJFNi1rvs+FaE35JvPXOCgsjk+dq7U710Ep
	CS61SDLgyIzrxLh6sik6uBFVpBCVC/gk5hP99aDTdKyMH0opUo72ftPYq9gMpx8=
X-Gm-Gg: ASbGncvxCgPDgwyrZfGFXftWtw0aJ16SyQqArcfQuEMDx3hNuHO0aHP0MqAVaMQxE6Q
	JDCUEEWlpVqDV5z04L+WMEhyadt/uR9QMlUUwRvLOJ2SYNk/FR6fOzdadNA5q6WT5rcFo481Lej
	vSEvIgMGX+tVsDdQfD6VerzRJWCD/8tCTpbxWQtZDKpKpqwovRwm+115ZcPFCYeY6WF0xpilVmT
	tHqCiLMHqHAIdlriuEC06NP4I6XKkHfz/UA0Gw+Aqk+FInmCPmRuBdhnK3WH+o9VpsEnvy88v7L
	no8MfRvCZUGAaozZwtpvMaX+5Hb+7b+slWj6DvxAuyDZRSLyAFnqBIHAU7sR4iyrdFmwiE+e/Dl
	RWqR+dZ0=
X-Google-Smtp-Source: AGHT+IE5AQjB1i4m5sho8oCNTw5FUe7hY3dzjkvZB9ZAXLdP2T6st2x9xbWSRmX0zhdE4HZb3wrSYA==
X-Received: by 2002:a17:902:d492:b0:212:48f0:5b6f with SMTP id d9443c01a7336-2242b3eb238mr3734955ad.9.1741317705811;
        Thu, 06 Mar 2025 19:21:45 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8a86sm19847605ad.240.2025.03.06.19.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:21:44 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH v3 0/2] Fix SCHED_IDLE behavior on wakeup preemption
Date: Fri,  7 Mar 2025 11:21:14 +0800
Message-Id: <20250307032118.30364-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
defines the behavior of SCHED_IDLE as following:

 - no SCHED_IDLE buddies
 - never let SCHED_IDLE preempt on wakeup
 - always preempt SCHED_IDLE on wakeup
 - limit SLEEPER fairness for SCHED_IDLE

and the middle two of them are broken now.

v3:
 - Collect Tested-by and Acked-by from K Nayak and Vincent, thanks!

v2:
 - Collect Reviewed-by tags from Vincent, Josh and Madadi, thanks!
 - Rebased to up-to-date tip. (Madadi)
 - Folded some discussion with Vincent into commit log.

Abel Wu (2):
  sched/fair: Do not let idle entities preempt others
  sched/fair: Fix premature check of WAKEUP_PREEMPTION

 kernel/sched/fair.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.37.3


