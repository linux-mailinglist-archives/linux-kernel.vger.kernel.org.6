Return-Path: <linux-kernel+bounces-273663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D18946BF6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1409A1C2107C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A4B1173F;
	Sun,  4 Aug 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHRL79fo"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355FB67F
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739259; cv=none; b=efPF9i79QANdWhLqw7z9TxdFMsWi0IqoqTpnltpgXSNEqIrkzpHnxx13cS7oyI0+RNCP/mxmucW8pd1mGtJPJA4Gw49njHrBqqCRa/nLSxA7BMvummjWdD1Cq/1CIE14YfGuOE5iMuDcPw0qLw7fgk2NOhz+/qs7JQN5HiNByZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739259; c=relaxed/simple;
	bh=PCnsViA3SRaWBaDdsNyqQ7wWVBPr6DJlkSKXZEIovI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNLL7BGsqTQrJ8EdkuQ5asl0m0yybijreXjlrbZylQbimFZ0/jR39RcsqEOhGA/rKE7g2KfzNzA2ZcrE5I7zpVvfskip64MYD4OjKnaKxrPATFSEra/wIw6m3nyiDpzLs5N2H9RRLvPA2SFhS4gpZW7SS5w4cs0cl0WJjJOrEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHRL79fo; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db14930a1aso6217422b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722739257; x=1723344057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fY05t9ZQw7FtyTkWrUg4d66R88bzwmwMEAHZnk6Hqc=;
        b=ZHRL79fovhhin8XVn8PfPBKoZfC/n4S/aeb7fXpeJ6ybaOyGmNGQMHMZoHF9NK74t9
         8UQDUjRDUmMv7J3EensrW70k8Sd9RUuabqV0GzcZSSBa/WvLEVb4/W5WDFPB0TT/xo2W
         +GPrm3h62HvMJO4o9naIFyIuSB/1ZpmWvalZBV2n5TnkctMgyezQBPvtpzqPbBmU8YZm
         YhpINJeyZOq2tnrOe2VTJM+2jmPXZPA/yOYP8u2szbEgOtHoLoLjNMt/Cd+pE+S3lRFR
         t2zGLlJBrYH8YTXSGi/YNHDfWPLp25igi7VapvbjZH67LjupSMcu/6QLGZAfNkqSQ2TW
         SqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722739257; x=1723344057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fY05t9ZQw7FtyTkWrUg4d66R88bzwmwMEAHZnk6Hqc=;
        b=HZPPPDG6xdkBBPfs9FUiWHVtWR9KItM79Qg9wyX8uVTwlo7fBjXXAgHYrlTYZ2HKWd
         s9IVA60NZUnyNeqHDs6UklfgkePyA8df3JARnmW6O8ZmGz+AB/C4W7XwOSh8Uc3nHKVP
         bxqWye0/aIPCQC7bGWBWksAY10Rizx43UZbJvFmP8+bqjyvbr+40vtXMO8bE+INKyakS
         MdRpDyZlwxHiR++iArjZqpLoZTs1cJOO5nIIMatZjOAN8gpEAKuhP64y5KxYb37d2tS1
         KcM8yATq32CRotvaB5/BiiRIRReh6ESur+j2e4UGb32KC0MWhbFVvVKEP8k7ncr1akmg
         jBeg==
X-Gm-Message-State: AOJu0Yzt7o/9uNxBWNOreScN8Zey9r7pF44phuaJYx0kd0KI1fPnpUgo
	1ZBoW5LJqyJmlxkamlWrTGXTbrLGu3XmvLLUZwsrh9j4MTxSRF4/
X-Google-Smtp-Source: AGHT+IGELBnAgMTgS5Hi2UoF0wZHSLLsgGWVQ3icRrmY1U8Uh2e/Ock8i3t/4S9EoAoi1Yldug27eQ==
X-Received: by 2002:a05:6808:1a0c:b0:3d6:3106:52bb with SMTP id 5614622812f47-3db5577f29emr11245541b6e.0.1722739256824;
        Sat, 03 Aug 2024 19:40:56 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29d88sm41711555ad.8.2024.08.03.19.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 19:40:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Use update_curr_common() in update_curr_scx()
Date: Sat,  3 Aug 2024 16:40:10 -1000
Message-ID: <20240804024047.100355-4-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240804024047.100355-1-tj@kernel.org>
References: <20240804024047.100355-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_curr_scx() is open coding runtime updates. Use update_curr_common()
instead and avoid unnecessary deviations.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/ext.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 938830121a32..48f8f57f5954 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1466,20 +1466,14 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 static void update_curr_scx(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
-	u64 now = rq_clock_task(rq);
-	u64 delta_exec;
+	s64 delta_exec;
 
-	if (time_before_eq64(now, curr->se.exec_start))
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec <= 0))
 		return;
 
-	delta_exec = now - curr->se.exec_start;
-	curr->se.exec_start = now;
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-	cgroup_account_cputime(curr, delta_exec);
-
 	if (curr->scx.slice != SCX_SLICE_INF) {
-		curr->scx.slice -= min(curr->scx.slice, delta_exec);
+		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
-- 
2.46.0


