Return-Path: <linux-kernel+bounces-294326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7070F958C46
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFFAB22F12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F221BBBE0;
	Tue, 20 Aug 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="V6TR+HEk"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718B1B3F08
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171722; cv=none; b=pJKnh70EkdNMhoro8nJs2qgYxaoVZsyIEZYq/PcvGvmBu+0FOc1CKAWBl6EIynSPdR3FcmVsI2iY85OBE7RuUdtFTPDyCyTXA42df/4jr3d5S0pWc0TNnsfrsxpAEqeeJrdqHYk//5wvbHRzNtkZaqL1QzQkk8AqFUE14wkTKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171722; c=relaxed/simple;
	bh=x61t08722IA9HiK/FzMTCXQkBhUf938GZOXU6aQsSSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yn9+Yv1L4MrSlF4unn8EEv9Fsx4LNfpzaEGSJ8Pc2N9cp1Zc3z14Mm39TLJvORKDS+E81funCEwTGEuHjobGp0ZE8ZKrK8vgPW2H/R8e9Gxzf2EIHujB6fX9mpTLQ6U4+vdNiW/RRTN5oLUnXmfr0lz82gETagZkoXTND5L0JNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=V6TR+HEk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso8653171a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171719; x=1724776519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4GvNZ2q2vkKbUvc/NgCLEzCheBxpfsamb4EXfBM/Og=;
        b=V6TR+HEk6ch4QlU0saqGNMJ5DhHPrFkh0qnwkkIkhf/0rInDOAi1ajEM91s4akYkIR
         oCv9yClD3OTbLl8kyOeWbTIsGihOBFlKn6E4j2/q3BCrcVkcCnaUaQWkcTnfhCQ4Bb22
         tAh3+7g+dIphmESa6y1cVQCKCRcsnnf14Vno3QKL5826xuLylVi2ErstQCLz/7+pMjwI
         mHaBz9VYiHsBHaMqUlvhhRc3hmcfFU/MG6BjizdwMowafdQfVNq+R1p8jot7WqQXmX6I
         MHw3IfTHV2sRUlUYcKN7fidLgJfpaWVgU3mbg5JzZ7KmIOi5NwgFAHSz4AASMOf6bcDZ
         0UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171719; x=1724776519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4GvNZ2q2vkKbUvc/NgCLEzCheBxpfsamb4EXfBM/Og=;
        b=RUENz0qtB1Ff4Zpbb0BuI5oR7BTg4A4mJmdH0e1tHg1ThFG4An7v9Pm64aDoByeLmi
         W7bAEE4VhfEty+I0PC4DuI1UAGlXTbiFLM8PhCyWenM5iMGqToLOm8FW2/LPuGsQTexW
         4R4FdJerVg+s2OI0cLL4B0J19junmT5FrzVTS13pZE2WBantoxQKu+BM2e+KWx0GiIYM
         zidR7q1hErV7b5YJUwHPgKTQgDOly96vuBKUWukrQynTWOiOLUlfC//WPHwEz50b6CBJ
         PgEd1LY4XON6HxBeJhHJCBgAzJpKvknkE0iIqkNdzbhb0h9YA50IbLpD73QDQzmYTkbo
         j44Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVHcHXmrBCu+8SI+A4NFM/xYcyGNtYTdRzef28BMY1KQpS5fnMRKqj0FgTnnjYF0O8Yc4YhKlH5b1rbpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wNCEbniJnjDyGrPRqvVj77S/RPbdO8uJj5dpFwzIcWzdjY+x
	RFtu5l7pcx9n+FnewmwDtxkcwbs2xHpaBKFa0v2sMyqfsCVDxzzazb62xDzRmaM=
X-Google-Smtp-Source: AGHT+IGANk0JtgzuFnotXZ6oaaNXX0v0ntO5GyaujzzJT2sPsn/z/iWuqqA4+lqIPu3rUA7Z15IshQ==
X-Received: by 2002:a17:907:1c22:b0:a80:f6f2:e070 with SMTP id a640c23a62f3a-a83928a3333mr1164972466b.3.1724171718395;
        Tue, 20 Aug 2024 09:35:18 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:18 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 02/16] sched/pelt: Add a new function to approximate the future util_avg value
Date: Tue, 20 Aug 2024 17:34:58 +0100
Message-Id: <20240820163512.1096301-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given a util_avg value, the new function will return the future one
given a runtime delta.

This will be useful in later patches to help replace some magic margins
with more deterministic behavior.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 22 +++++++++++++++++++++-
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fa52906a4478..2ce83e880bd5 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -466,4 +466,24 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 
 	return ret;
 }
-#endif
+#endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
+
+/*
+ * Approximate the new util_avg value assuming an entity has continued to run
+ * for @delta us.
+ */
+unsigned long approximate_util_avg(unsigned long util, u64 delta)
+{
+	struct sched_avg sa = {
+		.util_sum = util * PELT_MIN_DIVIDER,
+		.util_avg = util,
+	};
+
+	if (unlikely(!delta))
+		return util;
+
+	accumulate_sum(delta, &sa, 1, 0, 1);
+	___update_load_avg(&sa, 0);
+
+	return sa.util_avg;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..294c6769e330 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3064,6 +3064,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max);
 
+unsigned long approximate_util_avg(unsigned long util, u64 delta);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1


