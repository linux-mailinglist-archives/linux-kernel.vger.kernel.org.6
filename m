Return-Path: <linux-kernel+bounces-195357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDC48D4B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF8E1C2202F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D371CB322;
	Thu, 30 May 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leOYbNI9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD61CB320
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071879; cv=none; b=NQ3eqJdWU/wqCIqJhQN0PiYuqTlpDrJ+4snc7j26sB82nJoPbfABJaDBidVsPAbDy79VN6aHPo5uq2Xvd/QKur63ndxPcVgsbTeym3kERkTEq4l9i4VZL0ylGPjl2co2dfu6AZp3jhlMYxQpwU6nO6iKlzMyXaLLsxprlg2e2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071879; c=relaxed/simple;
	bh=c341nJ/WXptGuINcJPQ3UBxK8YzC4fSd7OjyiKpXNwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ0TqxCdyYGLf01EGvHNbRnkHw/sYcyeuJApusfRV+axupZCIxLrFeuSSXP2YG+zajgBkFAd5ybAKP8uC77t5M18dzuEPjH/rNLoDc9ebpEgtRhA3ZUB5pDP12Wa+IdsBpphaOuatSTG1/DuxNEMZZqUtG+vKLK6G9oFfpCb7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leOYbNI9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6262c0a22so1634835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717071877; x=1717676677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU/qwrYxGt9NVMt/p2uhxHpwoKeT7zg7pi77Z75VH3I=;
        b=leOYbNI9731PXMXplBP7wNiaLdd1IinbQw/MHQ7bNDuHz7sAEYxrLd9COdNBOg9d2X
         1xC5L7CNgCTj2SfF1P3/YnGzdjOd5VPz8R0D+sc/QVZivJXwf++ThZKBrqsRdYqO5UTY
         uu1gMcPeMgqGVGVQsRScwmXTsdeynL5URC39orZOueO8gIqqsjNw2vEts37Aw/msBqJ7
         eEnrulnxD2waaoZIuAVdBCWarsMU64vi5LV5wMnmbF0ZKDyaOBJtqS+ehJHPIE51IcBN
         Ewiq/v/DPtq6A5awqNtemXGO8+9xJin1Is+rLY3JJG03N2VU/UdMA7efZTyzOMY6I9jK
         Jhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071877; x=1717676677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CU/qwrYxGt9NVMt/p2uhxHpwoKeT7zg7pi77Z75VH3I=;
        b=dmWwb3iGK6Ji9equqOp8LvBjB3jFGdXoykEJWEzbeUpCm9ELjtdATbby2Xlt7E/39b
         4mY35s991dpyIED7F0IQ6QVTwzuun6eouxiBuycvc683Ue26Jcrs2Y3SCkGgcArr5viX
         u18vr9grvIpM8bNt5Wx/XSkkhgwfU7yAtRwlQJ8SG2Jfg3pubMVz5EaYV2YBAPb0MFn3
         xwHA8zuQUn+bB1czbESQmXdtIMxLeiqIz2yBVlVOQq7hTTbds1IKvHGeKmfcDmeVnf2w
         SoQ60hZZfAAPIXlF2aJvNzgXtnGrkI3idEfHYPKTGONf03lEc99g1cRXQesR+Lmd4qsr
         elvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7gj+oB7irutksgwvhnvcUQlZXScMzA2tsmoMUHRhXL+qmFguC6QRbDgpPwm50QWXi3dqGwA70eHbDYQJ+L+0TUlwAp5O49Fxm+5uZ
X-Gm-Message-State: AOJu0YzcRoq9XS+LlUaltnW0YZA6fYGv1+iCBCpvfBhWcLBIyYhxOGlE
	bi8Ux3NDbA1cgyj7Oo8ySjmxoP81GRvC87vP9UEZF+ArYy0nWel9
X-Google-Smtp-Source: AGHT+IE7ADXNoK/kJenrb1y2YQR0elP5Pl+YgGUiCXcWKNCvmH18Ej/6BU5+Oh5J+58u7rOkzDG+5Q==
X-Received: by 2002:a17:903:2292:b0:1f3:7da:b0f5 with SMTP id d9443c01a7336-1f61be85067mr28972765ad.22.1717071877158;
        Thu, 30 May 2024 05:24:37 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f44c558ccdsm120548185ad.0.2024.05.30.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:24:36 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>
Cc: Cruz Zhao <CruzZhao@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH 2/2] sched/core: Remove sched_core_idle_cpu()
Date: Thu, 30 May 2024 08:24:01 -0400
Message-ID: <20240530122401.3826022-3-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530122401.3826022-1-zegao@tencent.com>
References: <20240530122401.3826022-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there is no user of sched_core_idle_cpu(), delete it.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 include/linux/sched.h |  2 --
 kernel/sched/core.c   | 13 -------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..85ef086362c9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2182,11 +2182,9 @@ extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 				unsigned long uaddr);
-extern int sched_core_idle_cpu(int cpu);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
-static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 #endif
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..c42fe87e07d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7453,19 +7453,6 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
-#ifdef CONFIG_SCHED_CORE
-int sched_core_idle_cpu(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	if (sched_core_enabled(rq) && rq->curr == rq->idle)
-		return 1;
-
-	return idle_cpu(cpu);
-}
-
-#endif
-
 #ifdef CONFIG_SMP
 /*
  * This function computes an effective utilization for the given CPU, to be
-- 
2.41.0


