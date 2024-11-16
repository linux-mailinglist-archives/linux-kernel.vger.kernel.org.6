Return-Path: <linux-kernel+bounces-411797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E59589CFFBD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929AF1F23B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760AB19048F;
	Sat, 16 Nov 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5PaUiGU"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC63F18DF6D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772925; cv=none; b=gqP/NGokaLw8VcgkJCBvUAtEm3twBixXbAxXvK17fvueVt4ObgM0Fo2JR4sFtnMh6LcSwX6bZwBH9ctqS9bVy8nAgU+pn8o1lwReNQ1byEiMF3qtJYdolsVPu/ZSHrLbk+mto23ir8azufW5Ae2t6nYqx8NJD93WgDkn79Sf3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772925; c=relaxed/simple;
	bh=+MG52QQoyvMX4PhF1K/8jvNUimDPdhZ2sTZ6kij+eCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEsnTqTe98L5AOBnaAeA5yKM6yBy7tQP/tGNQ5ZlG86Erco8nkwBKCpHRftGBkJPVpD4Q6kZRp73ZqYx76sV/MJpSlcCXudosZmp+yFQ8sYKjGyxEiG6iCdErclcDLhcM30bKYbDbboUuW2QxCy4HvPfg8sxqkaPlnJCIQbCU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5PaUiGU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c714cd9c8so4233745ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772923; x=1732377723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38PQp1RQQ2NMP1hcM2NKIXHciL2ilqE4M5FPbIzuslY=;
        b=L5PaUiGUbXBB2SdVNkV2IWSGLcQimmx6ywB+hK7XfXs5zIEwK5MYIH77fULjzjfYld
         LFYZQYAW5oVzWp4ttbUHHAr3sPVPdo2/Q/Q26hGN9m/1LfdlK0X5l1mjjnXlPHLAP14f
         dEYtHlgE3FVxBU9qXWnCg7bkCbxsIqayP1xCsQt/mwziLX6Z+8/T6erHP/dR6Es+ChoW
         tPdTD1LN6FtAW1ZYzHX+rbxSEPGdL+iHXRZZQaIsPVCetFLUJekFFCprk5lOIbEU4uBU
         C2/b0A0+AQL2EOxz5XGCUIBmahZPC/UePvU83z4Egt9B7mcMhwGHxznYSaaUDtdfUc0j
         U2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772923; x=1732377723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38PQp1RQQ2NMP1hcM2NKIXHciL2ilqE4M5FPbIzuslY=;
        b=Lc9Q9aq+SHvMaOT0nRfz8xedDfigji81png3/O/mmfRLfDIsw+IWlRecYFGekU250h
         /evxkClZmydpjC1+4TuSdEenzXXkWu2uP7FA8heQrO/Nhpzx5P6JsOPaFbkQXLurypKe
         zF2TRl75aaYL4YL0nLuxmLJHJubTL9qF2vGo68eK6mUv/MhXkKRbMSfFb2j1+V2iw2pz
         jpSvbtyV61n+Nfa+ix3sgmmkHjB3RGvjDnqlFX0upFHoHA4S8aMfigrpCHd0a7pyPLRM
         B8fust/iCf2/36AMjnbLuw1zsnLMhNssgRyPgKbyxAsLTKDNXzHf8apzUQUUg9VxiKjY
         +b5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmueibSe3MrlOP3YWC0B8LGOPqVycLW9wM/S2kLm8z+AQlM+TuEeuzo2+bchbmd3TlbZcl17XWyx2dvd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdT5ggBxTewHuAyGZ1qRbUHc+vzqXkuFiZRI5pLI7IWAGIaW3K
	0501lQEgIpW0m2/I2dD+nXbrd8cYiZOP74Hd0M8psaG3eGFpr9my
X-Google-Smtp-Source: AGHT+IEyY5xTEzo2l7XaqcLEW8MmJjYA8BSONOvXiTv670zrm9w9LaEoXycJgP5gUCdOsieDWorNyA==
X-Received: by 2002:a05:6a20:729b:b0:1db:ec2b:7322 with SMTP id adf61e73a8af0-1dc90c18aedmr11919815637.46.1731772923095;
        Sat, 16 Nov 2024 08:02:03 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c3224asm3116635a12.29.2024.11.16.08.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:02:02 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sched_ext: Manage the validity of scx_rq_clock
Date: Sun, 17 Nov 2024 01:01:23 +0900
Message-ID: <20241116160126.29454-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116160126.29454-1-changwoo@igalia.com>
References: <20241116160126.29454-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An rq clock becomes valid when it is updated using update_rq_clock()
and invalidated when the rq is unlocked using rq_unpin_lock(). Also,
after long running operations -- ops.running() and ops.update_idle() --
in a BPF scheduler, the sched_ext core invalidates the rq clock.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/core.c  | 6 +++++-
 kernel/sched/ext.c   | 3 +++
 kernel/sched/sched.h | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a910a5b4c274..d0eb58b6a2da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -784,6 +784,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
+	u64 clock;
 
 	lockdep_assert_rq_held(rq);
 
@@ -795,11 +796,14 @@ void update_rq_clock(struct rq *rq)
 		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |= RQCF_UPDATED;
 #endif
+	clock = sched_clock_cpu(cpu_of(rq));
+	scx_rq_clock_update(rq, clock);
 
-	delta = sched_clock_cpu(cpu_of(rq)) - rq->clock;
+	delta = clock - rq->clock;
 	if (delta < 0)
 		return;
 	rq->clock += delta;
+
 	update_rq_clock_task(rq, delta);
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9f9bc2930658..b8ad776ef516 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2928,6 +2928,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
 		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
 
+	scx_rq_clock_stale(rq);
+
 	clr_task_runnable(p, true);
 
 	/*
@@ -3590,6 +3592,7 @@ void __scx_update_idle(struct rq *rq, bool idle)
 {
 	int cpu = cpu_of(rq);
 
+	scx_rq_clock_stale(rq);
 	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
 		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
 		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 61efff790e24..03854ac9914b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1758,7 +1758,7 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 	if (rq->clock_update_flags > RQCF_ACT_SKIP)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
-
+	scx_rq_clock_stale(rq);
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
-- 
2.47.0


