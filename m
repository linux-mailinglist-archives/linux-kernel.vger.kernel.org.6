Return-Path: <linux-kernel+bounces-188743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541138CE641
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A1B2100C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C17786AD6;
	Fri, 24 May 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BibtKiKF"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6A48CCC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558086; cv=none; b=NIXtk9MSxqk7xqhTVGAg944yDIt9HY43+sUvG53ufIbpDLahACfSxHtlzC7SFCcHqqunthDzUrLPKAPK76nyiNxcdFyZBjqvXhAwgidHuX77GXnYuVViZUZpCiQNFdnx9Tbe1VAlmmruk3W2CTcXpR+7vgvV/DssfPiDtddtuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558086; c=relaxed/simple;
	bh=pXmgjP8kQqhZKTvZCbXx51GgOKIOYJ0kK34P7Nvg0ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FBVn+1Unmx8eQGgh/B/kihxZTVhdEXOMrpUlavwiU51UXbQjjXp6QaAxiRFfPJJ2IIkHRlRugLKQziRBNre0z1VycW93/G7+XofLzFKtObRulZUxtwNDyTFQ7XPftE0ItjDOHTX+Tno9oxf0h88bGN2AA1oqAiFrDd5Ar4XlyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BibtKiKF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f3406f225bso13601915ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716558084; x=1717162884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gB+Z6iISz7dIslM1QhewgRyF/lRbbJhi6qwW8Tf0+m0=;
        b=BibtKiKFuWOWv7PxixB1R63RrRvlQphuV96x5q9PnZe5D38S73Y2ORGpFvJv5qqnj5
         +qLsdrB4mm4gguZzDqRVrK+FAakfHXPaopHeVQ9khkY0+o3CoQOwNGsbve5/R1qEP968
         AFSsAO/jtjLCj/v+evbLH73GqbPcngofpslNTnmAoZH/I9v9EPgORuCqNiS2MlILsCD5
         NJEyviT4R0ZqYwf93z9mbli4pBc0WbTOYKQR3fSymUBpHMR/5amkWqjN1721SrUGHu8W
         VPQBHe9cLfASPlvvu2gLFaXptY2kuUNWLdWL7R2xlmsdK4u97vwhsc2TAH+FC7FDZPsg
         rcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558084; x=1717162884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gB+Z6iISz7dIslM1QhewgRyF/lRbbJhi6qwW8Tf0+m0=;
        b=o4oEw8yQzMS1zuzu+0P1CuXNsLSgW1+axwMEpkbQ8V4sgfnK9fd5OX3l/x9HWEw5vA
         kzV0QyS/rdCkXL5FfeewEot8pSpb7Li8YNMWgxWOXfRgXNVesLDZA0CZHxdgRkPPq5zR
         LP0Lnj7eJHyFCO8/PkA/ipwWDbGhVsK8+1WDT7UCCnjLVZy95MKyoNWPkgtssotBzCvq
         jGiOVHyOMF9r+eB2wX6M1rmuT5szOh0WIVOKWKOeuSqjfY3cvf/q6Ne1TPpsHpphMvVc
         JG9yOIGrRmidEqIbZw8jZD0S6J5CPl/oP9UF5L7ggI6YWL8yFaikwDbY0PqXcj/sqWXe
         O+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXmLQ3qG0ZZNe77CukrJvqi9bZ6IBONUJvaTLr6wshk4yE0jE0yXgrvBVd8RA5vD9vHXp2b3rDQ5AVom4/yneyaX+6U/esWwGjuKBQO
X-Gm-Message-State: AOJu0YwS5aV60oYDW2bayICHX30E6aYqsNlAe7zx7Mm90MtrfwMb5tyv
	4Tb8ml9GHIzPWPZ49ZxGek4wsP1j//7D5ZWrE3zVh4Bkccw3sb/a
X-Google-Smtp-Source: AGHT+IEdwZENfXHIedWRgCTX2HmRayT2IRetf5qjW52gmljF9o4LIwOTKfZypqCrVl5pHfCFnEK9cw==
X-Received: by 2002:a17:902:eccb:b0:1f0:99fc:6402 with SMTP id d9443c01a7336-1f4486fd403mr23778155ad.10.1716558084060;
        Fri, 24 May 2024 06:41:24 -0700 (PDT)
Received: from PC-YLX4GJ2P.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9e3106sm13881865ad.300.2024.05.24.06.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:41:23 -0700 (PDT)
From: Chunxin Zang <spring.cxz@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	yu.c.chen@intel.com,
	yangchen11@lixiang.com,
	zhouchunhua@lixiang.com,
	zangchunxin@lixiang.com,
	Chunxin Zang <spring.cxz@gmail.com>
Subject: [PATCH] sched/fair: Reschedule the cfs_rq when current is ineligible
Date: Fri, 24 May 2024 21:40:11 +0800
Message-Id: <20240524134011.270861-1-spring.cxz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found that some tasks have been running for a long enough time and
have become illegal, but they are still not releasing the CPU. This
will increase the scheduling delay of other processes. Therefore, I
tried checking the current process in wakeup_preempt and entity_tick,
and if it is illegal, reschedule that cfs queue.

The modification can reduce the scheduling delay by about 30% when
RUN_TO_PARITY is enabled.
So far, it has been running well in my test environment, and I have
pasted some test results below.

I isolated four cores for testing. I ran Hackbench in the background
and observed the test results of cyclictest.

hackbench -g 4 -l 100000000 &
cyclictest --mlockall -D 5m -q

                                 EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY

                # Min Latencies: 00006      00006      00006      00006
  LNICE(-19)    # Avg Latencies: 00191      00122      00089      00066
                # Max Latencies: 15442      07648      14133      07713

                # Min Latencies: 00006      00010      00006      00006
  LNICE(0)      # Avg Latencies: 00466      00277      00289      00257
                # Max Latencies: 38917      32391      32665      17710

                # Min Latencies: 00019      00053      00010      00013
  LNICE(19)     # Avg Latencies: 37151      31045      18293      23035
                # Max Latencies: 2688299    7031295    426196     425708

I'm actually a bit hesitant about placing this modification under the
NO_PARITY feature. This is because the modification conflicts with the
semantics of RUN_TO_PARITY. So, I captured and compared the number of
resched occurrences in wakeup_preempt to see if it introduced any
additional overhead.

Similarly, hackbench is used to stress the utilization of four cores to
100%, and the method for capturing the number of PREEMPT occurrences is
referenced from [1].

schedstats                          EEVDF       PATCH   EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
stats.check_preempt_count          5053054     5057286    5003806    5018589    5031908
stats.patch_cause_preempt_count    -------     858044     -------    765726     -------
stats.need_preempt_count           570520      858684     3380513    3426977    1140821

From the above test results, there is a slight increase in the number of
resched occurrences in wakeup_preempt. However, the results vary with each
test, and sometimes the difference is not that significant. But overall,
the count of reschedules remains lower than that of CFS and is much less
than that of NO_PARITY.

[1]: https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kicks-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb

Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Reviewed-by: Chen Yang <yangchen11@lixiang.com>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..a0005d240db5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
+
+	if (!entity_eligible(cfs_rq, curr))
+		resched_curr(rq_of(cfs_rq));
 }
 
 
@@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
+	if (!entity_eligible(cfs_rq, se))
+		goto preempt;
+
 	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
 
-- 
2.34.1


