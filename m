Return-Path: <linux-kernel+bounces-434092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8CC9E618B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA2128414B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F528370;
	Fri,  6 Dec 2024 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xedgUuV"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842241D4341
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443218; cv=none; b=fdM3H564nG8d9jWBfTPyre57nujFndtQysey6VL9j6G6jcueFE34TzkXkmWQL/jpy6pk2Ktt9YuiTccYKVTT1sOypJmcOD1ocQeBq7UHjUkIYLHUJFA2VW4eBphmstcaIKq6EYHujepZxj804G3r5mMq745pWkDt8x91qrdxruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443218; c=relaxed/simple;
	bh=KV96hu5ahn+RnAFW0mDzCC5tpVcRmsTK6B/4HteOxI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0lKIonLzzbuoIe76flLUn6MMoo+Xc+Zm5X71hypwvI9LsUEeXgT/eet/3ZVuHdmuGf/bXRCLREFCy2r1HO2oedQC9nigW2MTgRCx7MC7AwjPgFWK5whZv2sb26wOIuxUh7NQTQVItiMfWGk4ICN2MBz00iZ0q5vvAChSAxli1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xedgUuV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7250863ae6dso1492951b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443215; x=1734048015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFJh/CnY6zCq8QOWGv+Dgnz7IoEeL/cfqf4tqMYmVCM=;
        b=3xedgUuVU9NgI4alrBk7bFhdru0MLcI7isdOlcF1IS6GpWr8g+hZTDzTQFBHx2EZHN
         R0SkIw0mYYLUbSZhLRETGIpRdvOpe15ugJyyG5sAS1o1wMUSwosu4ea0pzVtfzJGH/E9
         vYAlXckRKJq7xm8WSnu+tgNlucOHCJse92nNQ+ZGfsB6tlTmVCJKPcNsOc6PfDdqtGXN
         h/Bfa2Fb4DaQ5xMjKapJQarUeZVPN2ZWiBbL5Y9+xrm1SkHJkyqy8Oa/+M2rN4+3GFa6
         nKXdzsmneewdnc9VPHx0ISDzILaEx+6dp2AjqilJL5deqJC+CAQgCfUCteyc7CkgIt2Q
         Z00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443215; x=1734048015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFJh/CnY6zCq8QOWGv+Dgnz7IoEeL/cfqf4tqMYmVCM=;
        b=xGa8REIE5hNHfPrE4sRZm4yONyDLEcu92E9zOr+dSTBYHeQbBPsS2recRv2kOksj5z
         aJkg863O1ZzzNWdYmb+xVhOQLOrzzbUXXAuSriz01Ax/4HnP2u3UtTulH3FcPCfsCpn4
         pWvorcBabA1Dcrgk6Gq27SAFqY/gkXoyWkNmiu1OvFtLjUc8xnxCZbhae/xynkkK9Kq5
         CjZtXH5lVAyND8lLRO3cxPlNQayIpS9kaOLG0shuniI1rz4xfiZBa1pWB12eAd8dEBvn
         FZuQ8UN3b/JVnLryH3ByMkNbodwRTOsMqY8W9AqnBv/G+MX66N0JAeayxKgvCbkbk3qQ
         nQbA==
X-Gm-Message-State: AOJu0YwRrs3ue8HtMdj8g32WxobXZIjAgC+5PdaAevCb/h9kQjZatPV8
	jNBJt8LnXb+NTzqeGwu6/jkMDGmDMIoyGbz3q/ceUP/1HL9hHQgbOaZvazUgMv/xS0xhpEEQNPu
	yQiqccsdL1Wx43XT3BOBWmHRlNlQUuL86luBd7IbelIXKQ03lrTGz4bAxwRPKMMN5Nb/fTquPpa
	YK7d38mFUQJPh/Pl9t0zyBiDTgiCbS4jM+/PcZCH9tqyr1
X-Google-Smtp-Source: AGHT+IGP6vishNOzvSXZDYZAgM2rzGgsYfQjjkcrlw1G27tT77h8JjstuB8EuiloaUqvd53maF6HLqG6ydA3
X-Received: from pjbdb7.prod.google.com ([2002:a17:90a:d647:b0:2ea:5613:4d5d])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d81:b0:2ee:cb5c:6c
 with SMTP id 98e67ed59e1d1-2ef6a6c448dmr1315461a91.22.1733443215369; Thu, 05
 Dec 2024 16:00:15 -0800 (PST)
Date: Thu,  5 Dec 2024 15:59:35 -0800
In-Reply-To: <20241205211632.1181715-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205211632.1181715-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206000009.1226085-1-jstultz@google.com>
Subject: [PATCH v2] sched: deadline: Cleanup goto label in pick_earliest_pushable_dl_task
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Wanpeng Li <wanpeng.li@linux.intel.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Todd Kjos <tkjos@google.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
added a goto label seems would be better written as a while
loop.

So replace the goto with a while loop, to make it easier to read.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Wanpeng Li <wanpeng.li@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Todd Kjos <tkjos@google.com>
Cc: kernel-team@android.com
Reported-by: Todd Kjos <tkjos@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Corrects my misreading of the code (as pointed out by Christophe
  JAILLET) as already having a while loop, and switches the if to
  a while.
---
 kernel/sched/deadline.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a61..b2cc71984176a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2501,16 +2501,13 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 		return NULL;
 
 	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
-
-next_node:
-	if (next_node) {
+	while (next_node) {
 		p = __node_2_pdl(next_node);
 
 		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
-		goto next_node;
 	}
 
 	return NULL;
-- 
2.47.0.338.g60cca15819-goog


