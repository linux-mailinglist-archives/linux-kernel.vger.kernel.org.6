Return-Path: <linux-kernel+bounces-291364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4490956139
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865FC2819BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63F24B2F;
	Mon, 19 Aug 2024 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fMqrLBKK"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061671BDC8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035661; cv=none; b=uyR4rOBKFz5JXO5mSAUR2aDhKszSL3MSIuiiXVc4Mg5RXESVfbJITQfcnRlnIoUDx36zqufwGnxdzEOlYSXVX+mowHbFXys8noi3ENl933QS7siatoZgiNtHfUHNtETNcxv8f87WZkIn7JGSn0f3z0rclI4mpk4OwD1n8vR03b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035661; c=relaxed/simple;
	bh=BNQ6RnKhtJl1A1zIxPsrNi9yDt0ev+ZW+tZIueUwrfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ux0qeigqnr3Oe08AP+xToFD6ZbrDjlPHcH3RAHEb//IPe2FQTCnIqubF6/JvYz8BgA/lr4rZgCK3W+6G/Us1rmiQueTV8+ZZ/IYMEOsve2oJNTgvjtuOhFLNKsFwuow82uqqr6p7784gE1W+Dxw8Vd/XFDoZbINQQxIL8f0J32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fMqrLBKK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7105043330aso3062275b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724035659; x=1724640459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H01fKKssvZW2iMwVUpbWWJktHPLlFst8VnwpXINn2fU=;
        b=fMqrLBKKeNadd4loy9cm1gs+jSKiKEUF8jF8nvCye3oJbyQf303hFoeGmloXFPXmcf
         RmHyXFdBp0e2vZFURodna7IlmpzckzUZvg3mPD4KE/e/EO1fRdxN0qiCDOD+zCctowW4
         F/X/WzaQkNKumBgKemczpAtor+3kDmBIXxx5P2V9io1Ww2lP7QKHumf+HVUP/utui4tw
         Iukg6A3o6yyA9VbHTKRqeHk1+oWH45jhYrt/qqSh23NXhG+N2nGXl/iJ2ZX7MRkIonNB
         luB6Qe30OUpG/KopV8hdK6Q6pX7kV9P1bZiIqCCkW6UFAZLCl1J/xKNnYqJEAzf2lB7a
         L8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724035659; x=1724640459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H01fKKssvZW2iMwVUpbWWJktHPLlFst8VnwpXINn2fU=;
        b=hyeV/79WRVsyqzNEm8fDIBdRa8n9fAt8CdrpbMOF5bLUsNj1DO7tjsldABC7I4gXg9
         o2rsZ2PKGGhNwfFDlUoIVAGdlT0ho+9cR2pnXD020Odbhu1XwOSjr9ewC/qMr2VtnVhh
         a5M7h9x1K9MOF1ztzMvUqtTAf/c3JKh2aftcRRYzMvXixneOSvhJcCRxRsRrhxuHq7f1
         TkmixBbpGpuJ3KYZ7pYeqSjnX4DzU+M4hBEKJ/En5fM65upXoVb7Pxt2/jbqdAY3lXf7
         PzCQWMTxQf4etKtYVQRwI8HLLYcXC5Z2K5rLraqkMbrL4xWGp8+Emg9bFu03A5KDjsZo
         t8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/aF93IiRsBKhDOt1r/hq14Xc4WvltrK7F7UPND8quM82bN6FlSgn9CuTpS6csReKR/++pwPaeejrrbtfVno8Lk2gY83Gggb1x8bUo
X-Gm-Message-State: AOJu0YxW2aGBs6Qo0pvMcFgP4yw5JvPsHG8s4D0GMaXKOJZQuq0HckOb
	Ahhv/a/N/T65fiYcTgJQ7TXgXjtoAqR1YwaptNntD8M8dbqcHeKh7/zqVLhqSoo=
X-Google-Smtp-Source: AGHT+IEOg4XHq9d1HT6mP/xo7PxuV2UlF9STDjKMmwxtXxhTQD5bppuT9zqBITNR83zhXh7oONQEYA==
X-Received: by 2002:a05:6a20:9d91:b0:1c6:a656:84c9 with SMTP id adf61e73a8af0-1c904f9111dmr9780459637.16.1724035659064;
        Sun, 18 Aug 2024 19:47:39 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef57fbsm5972482b3a.97.2024.08.18.19.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:47:38 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2] perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time
Date: Mon, 19 Aug 2024 10:47:20 +0800
Message-Id: <20240819024720.2405244-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If sched_in event for current task is not recorded, sched_in timestamp
will be set to end_time of time window interest, causing an error in
timestamp show. In this case, we choose to ignore this event.

Test scenario:
  perf[1229608] does not record the first sched_in event, run time and sch delay are both 0

  # perf sched timehist
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
   2090450.763231 [0000]  perf[1229608]                       0.000      0.000      0.000
   2090450.763235 [0000]  migration/0[15]                     0.000      0.001      0.003
   2090450.763263 [0001]  perf[1229608]                       0.000      0.000      0.000
   2090450.763268 [0001]  migration/1[21]                     0.000      0.001      0.004
   2090450.763302 [0002]  perf[1229608]                       0.000      0.000      0.000
   2090450.763309 [0002]  migration/2[27]                     0.000      0.001      0.007
   2090450.763338 [0003]  perf[1229608]                       0.000      0.000      0.000
   2090450.763343 [0003]  migration/3[33]                     0.000      0.001      0.004

Before:
  arbitrarily specify a time window of interest, timestamp will be set to an incorrect value

  # perf sched timehist --time 100,200
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
       200.000000 [0000]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0001]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0002]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0003]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0004]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0005]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0006]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0007]  perf[1229608]                       0.000      0.000      0.000

 After:

  # perf sched timehist --time 100,200
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------

Fixes: 853b74071110 ("perf sched timehist: Add option to specify time window of interest")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---

Changes since v1:
 - Simplify conditional judgment. (suggested-by Namhyung)

 tools/perf/builtin-sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9c1276dc8ef6..1c386ebe4b98 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2683,9 +2683,12 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	 * - previous sched event is out of window - we are done
 	 * - sample time is beyond window user cares about - reset it
 	 *   to close out stats for time window interest
+	 * - If tprev is 0, that is, sched_in event for current task is
+	 *   not recorded, cannot determine whether sched_in event is
+	 *   within time window interest - ignore it
 	 */
 	if (ptime->end) {
-		if (tprev > ptime->end)
+		if (!tprev || tprev > ptime->end)
 			goto out;
 
 		if (t > ptime->end)
-- 
2.25.1


