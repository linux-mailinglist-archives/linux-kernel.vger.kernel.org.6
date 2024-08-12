Return-Path: <linux-kernel+bounces-283164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFF494EE16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBEE1C2188B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38917C232;
	Mon, 12 Aug 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LQb/1Y78"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC917C21C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469180; cv=none; b=vEcyIzdOhdVdwXoGK+Mnycm7scPKZpJL4o7VNAZ1xpqSlD813ghJmTZjA9CQTtrTXJ0Ag7z1HmnLyfNobpiuRJccuHUQkk6c458h/Ai2nQ0cgOcFd1iFlueoZmseSipKSNFkd7FPGJzjNjWbKeEJ4/AEm5L7phPR+EF+WEee+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469180; c=relaxed/simple;
	bh=GjMwa80uHv+0E1lhaYHJsXXqp2AxfFRpT9UXo2NQjTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dtnREcXUny51hz1bvnuNRMJVqPab9v0bTxVh4lxJA2WhcHnMHJ49Sq4iCiQr+uDjns4xGEo0PSG3o4Xk39sus9SVMn7M/uq8ArY5UMj/ZJuHNLeW17aLFMCF/OjFbfRH/c59B4jWiLAOuv3Gqmu8RPMsklcBkI3AZzOyGcyOAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LQb/1Y78; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd9e70b592so32470915ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723469178; x=1724073978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClS3URwTgmC4dcvx/1eXZKtTTpG+wT/xAPMbqpdjYxc=;
        b=LQb/1Y78EWBcZDo85d/cH09J1ZMLgxnhln4T1NwTGQJ+Zmu6lAfTe/XRGrzMoeksV4
         QGPLW97vF6/7Pnh/ZmTyLW3/91ho6ClhrFqVtOIHPb5nsn741ZE5E8uK/Jq8X/vyR+/w
         75wIkAlnaLe8K1lHTIvzG0lvju1BdIcL52js5qHjS/EfnuYJHurXbrlxsL7Yga2amO/b
         Po+O/+9t/jO5JIh+KqQPWE5xBNzz7PUBnsQNJTxE/OuuolQ6PIh+hepn+rKtxiAilCNF
         c9FyehBM34lBxzUqzbiHwWJzB42kzJ7UtCMYdDOaDDKWlKxVUZ3w5eIQIWQzn94KlDso
         ZAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469178; x=1724073978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClS3URwTgmC4dcvx/1eXZKtTTpG+wT/xAPMbqpdjYxc=;
        b=nH76UUGzHiIAHqJB32M4EOdw809Wc355XHDo9FeZGfhhXXlnkVS1Gg3vcgj21z3VVg
         SezqHRpgJQLOUIfC0lBI0z+Frl/s0AWVAoVc5RaorwtZK7aLH6UQD+Fd+LJ3jsHxkf3H
         bMikbxk/ifBmg5YroPxz0Fh8+bpXBRaGbuc6t3eNxu50Z4AWtpJYmgY37RR3yNiKBCej
         ccMhLa+2GI0lODHaIETRLwvma0Mt3NN9ltWpqEtzWXNJ2QdVk91+dWQ0mSapraMX1qLF
         00cIqyq0YUNfU8lJ5L6MQFVfXRUGvyxoD+exYTHZq9CeyfnW5bi6TO5+CoOnU3TrFG+N
         FRYg==
X-Forwarded-Encrypted: i=1; AJvYcCWA91sy8R0+USntjXO2X1Y22K+7TDmzMsXgCYfm4Mt3eENo4Ecch+mqJbLYSutaSWwCxK/iGvxsUV9qz7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhifamuK8fw2ciTCcOwzlpuTwpcejJWs9xkAjAjANisIhA89+V
	jcplkujWaoLU6wwjraE0OwmRzn9lUgpL0VHzuyTelldYOi/b5H3rup0+e9asNQY=
X-Google-Smtp-Source: AGHT+IEeTFtKvC/exK1c3CFB/+fm9o5FyMIR+G+N18lopbk+OZT9fGjopsi3em2SJIJgVdI0U4CyZg==
X-Received: by 2002:a17:902:ec89:b0:1fc:3600:5cd7 with SMTP id d9443c01a7336-201ca12b206mr4911305ad.10.1723469178558;
        Mon, 12 Aug 2024 06:26:18 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b2f81sm37683395ad.150.2024.08.12.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:26:17 -0700 (PDT)
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
Subject: [PATCH v2 1/2] perf sched timehist: Skip print non-idle task samples when only show idle events
Date: Mon, 12 Aug 2024 21:26:05 +0800
Message-Id: <20240812132606.3126490-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when only show idle events, runtime stats of non-idle tasks is not updated,
and the value is 0, there is no need to print non-idle samples.

Before:

  # perf sched timehist -I
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
   2090450.763235 [0000]  migration/0[15]                     0.000      0.000      0.000
   2090450.763268 [0001]  migration/1[21]                     0.000      0.000      0.000
   2090450.763309 [0002]  migration/2[27]                     0.000      0.000      0.000
   2090450.763343 [0003]  migration/3[33]                     0.000      0.000      0.000
   2090450.763469 [0004]  migration/4[39]                     0.000      0.000      0.000
   2090450.763501 [0005]  migration/5[45]                     0.000      0.000      0.000
   2090450.763622 [0006]  migration/6[51]                     0.000      0.000      0.000
   2090450.763660 [0007]  migration/7[57]                     0.000      0.000      0.000
   2090450.763741 [0009]  migration/9[69]                     0.000      0.000      0.000
   2090450.763862 [0010]  migration/10[75]                    0.000      0.000      0.000
   2090450.763894 [0011]  migration/11[81]                    0.000      0.000      0.000
   2090450.764021 [0012]  migration/12[87]                    0.000      0.000      0.000
   2090450.764056 [0013]  migration/13[93]                    0.000      0.000      0.000
   2090450.764135 [0014]  migration/14[99]                    0.000      0.000      0.000
   2090450.764163 [0015]  migration/15[105]                   0.000      0.000      0.000
   2090450.764292 [0016]  migration/16[111]                   0.000      0.000      0.000
   2090450.764371 [0017]  migration/17[117]                   0.000      0.000      0.000
   2090450.764422 [0018]  migration/18[123]                   0.000      0.000      0.000
   2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
   2090450.764505 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
   2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
   2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
   2090450.764590 [0016]  s1-agent[7179/7162]                 0.000      0.000      0.000
   2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
   2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
   2090450.764639 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
   2090450.764668 [0017]  s1-agent[7180/7162]                 0.000      0.000      0.000
   2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
   2090450.764672 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
   2090450.764683 [0000]  <idle>                              0.003      0.003      0.010

After:

  # perf sched timehist -I
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
   2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
   2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
   2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
   2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
   2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
   2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
   2090450.764683 [0000]  <idle>                              0.003      0.003      0.010
   2090450.764688 [0016]  <idle>                              0.019      0.019      0.097
   2090450.764694 [0000]  <idle>                              0.001      0.001      0.009
   2090450.764706 [0000]  <idle>                              0.001      0.001      0.010
   2090450.764725 [0002]  <idle>                              0.000      0.000      1.415
   2090450.764728 [0000]  <idle>                              0.002      0.002      0.019
   2090450.764823 [0000]  <idle>                              0.003      0.003      0.091
   2090450.764838 [0019]  <idle>                              0.000      0.000      0.154
   2090450.764865 [0002]  <idle>                              0.109      0.109      0.029
   2090450.764866 [0000]  <idle>                              0.012      0.012      0.030
   2090450.764880 [0002]  <idle>                              0.013      0.013      0.001
   2090450.764880 [0000]  <idle>                              0.002      0.002      0.011
   2090450.764896 [0000]  <idle>                              0.001      0.001      0.013
   2090450.764903 [0019]  <idle>                              0.063      0.063      0.002
   2090450.764908 [0019]  <idle>                              0.003      0.003      0.001

Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/builtin-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8750b5f2d49b..177634df1ba5 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2727,10 +2727,10 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 
 			itr->last_thread = NULL;
 		}
-	}
 
-	if (!sched->summary_only)
-		timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
+		if (!sched->summary_only)
+			timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
+	}
 
 out:
 	if (sched->hist_time.start == 0 && t >= ptime->start)
-- 
2.25.1


