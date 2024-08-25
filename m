Return-Path: <linux-kernel+bounces-300577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971195E55D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9871F220DB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65966BB39;
	Sun, 25 Aug 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/EvnRRJ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75858321D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724619690; cv=none; b=X4q07M5b5NUL8IGZgtSxAThdXtog+ttdhZ2WSABh+p9Is1iHC9g+UWZwRmkWdeW4c5b7JLvO087jMeCVN0VCAs9typ1uDmKNJLIuSmIUTLh8DCVFRWl5riv2rGtRORGXfOIYV61wyaCp98TwkABx7AyC1GwxIhpP8EpX6htC7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724619690; c=relaxed/simple;
	bh=29OtgiivKXw1RNPm2Q5W3uKzpD1siwDnfzXkNtICMhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=epDFClrFbBH7J1YMQ8lgB0TgXuXY4A6QG094cFkqixyDuxJWIj03x2XsR81qb8N0tP1Ql0auh1jjFzeP3ZXjzdMW64Og+ucvof1vbyZG+MBUxkb5m/Tf0CG1eWxa1+PcHH99kt18p8pQt6QaXjBWyceUeCVnRfc2x4HNAlrbI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/EvnRRJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3718706cf8aso2110854f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724619687; x=1725224487; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wa+hkyydXRkXaIiCJUAcOvtBmQ4J45tTDcz5icJDZw=;
        b=H/EvnRRJhfZDC4BR2tptvfaxtJXLiIAOeceoJS6lbBldqV9qVPVQXcunzwKVvcj4L1
         SNWPkYT6ogFIIfRZ15Tkx0+Qq5rBF4fY03qnNCT/pZhkhE0F1JRIO9T0of2JQJaVQ0xe
         ItWZMXpMull4LLCKubt3sKlcgMsosnSxvefTftBAVvUJXDu3BiRbWjv0fo3QQHxjMDqX
         WDEj4fVhc+4EiTnpK+Hk/7sPenSpkON2qe4o2zWQDhXqceBEc90Wb/NBfsezBdtOF81j
         TlsXECddHOmCX/uQZYd3XJxoKkCbmjWXEcWpKMKdlKlYRWb9jAip9ZXgiIINaEplrueD
         IpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724619687; x=1725224487;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wa+hkyydXRkXaIiCJUAcOvtBmQ4J45tTDcz5icJDZw=;
        b=b0gZV2Y/cFv5Dv0ALAWwjoSF9HAyXmQExG12u5KmtdjP9+sGeBoNqnlv1IOYcQpETS
         hCwiVsfp+vHfLnBFotgK2CrBCNBhC1r1gCfdXcG1Y7L7ncstAA3W+mlMcE1ZOrNdct/Z
         2f0MhAk4pkgQkGJG87ULncEfeqQ2NUfVNianPHjks8IA7XtvUxh2tNSNAcBjUViQ0Dbq
         buQCVgckANJC1MIiXIJuKODoKLnx1KhBhckMZg8XID3HVvhjdPGH0uJ6LugWTZy7R7dF
         m3tq4flQy7NYWcjj2tE5lk+rRlUdpnFpO8vmWIw8/zyBVhHytbHkZrq1p/2FaZVoy14R
         3zbQ==
X-Gm-Message-State: AOJu0Yx/DEHi5ef/XzBbq5A5oE4MFLJGc2Ago+LWgDVVdRUUC3t2frgX
	/1MZQr1WkDX1CkINudA5mV6LAePR2eUN9O/injDwBatZEU1xh0X1
X-Google-Smtp-Source: AGHT+IHVs0wi/0elvxTxsoNx5tUIwtBsR1UjsLR+gvmv5iqUuJAFKgtiSK8ZbTM/AcEpahmJMCcjyw==
X-Received: by 2002:a5d:47a7:0:b0:371:8cf9:27e6 with SMTP id ffacd0b85a97d-373118e404cmr6614088f8f.56.1724619686442;
        Sun, 25 Aug 2024 14:01:26 -0700 (PDT)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac516252asm131336035e9.26.2024.08.25.14.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 14:01:25 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id B5AC55A01C5; Mon, 26 Aug 2024 00:01:24 +0300 (MSK)
Date: Mon, 26 Aug 2024 00:01:24 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] sched/core: Drop unused return code of context_switch()
Message-ID: <ZsubpFiRXXvkxZzw@grain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)

Since the commit 565790d28b1e @rq returned by finish_task_switch -> context_switch
call chain is not longer used by __schedule() so there is no need to keep it (and
compiler already optimize it out).

CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
Initially I thought there might be some hidden use of @rq returned by finish_task_switch
but didn't notice any even potential future use, thus until I miss something we're safe
to drop this redundant return variable.

 kernel/sched/core.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-tip.git/kernel/sched/core.c
===================================================================
--- linux-tip.git.orig/kernel/sched/core.c
+++ linux-tip.git/kernel/sched/core.c
@@ -5088,7 +5088,7 @@ prepare_task_switch(struct rq *rq, struc
  * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
-static struct rq *finish_task_switch(struct task_struct *prev)
+static void finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
@@ -5168,8 +5168,6 @@ static struct rq *finish_task_switch(str
 
 		put_task_struct_rcu_user(prev);
 	}
-
-	return rq;
 }
 
 /**
@@ -5200,7 +5198,7 @@ asmlinkage __visible void schedule_tail(
 /*
  * context_switch - switch to the new MM and the new thread's register state.
  */
-static __always_inline struct rq *
+static __always_inline void
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
@@ -5260,7 +5258,7 @@ context_switch(struct rq *rq, struct tas
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	finish_task_switch(prev);
 }
 
 /*
@@ -6602,7 +6600,7 @@ static void __sched notrace __schedule(u
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
 
 		/* Also unlocks the rq: */
-		rq = context_switch(rq, prev, next, &rf);
+		context_switch(rq, prev, next, &rf);
 	} else {
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);

