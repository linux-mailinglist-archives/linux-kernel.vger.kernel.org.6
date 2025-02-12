Return-Path: <linux-kernel+bounces-511146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30345A3269C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33263A74CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD0620D51C;
	Wed, 12 Feb 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DlDBY0BK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D2209F4B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365789; cv=none; b=OSNGGjSOLqd9cgA5k+wNmnfmRbSqjq6DD+xPvquB4kSskZMu5Z+U2qWEbgpXe22r9M9pTUwEhBKEWoKImwgnSdplhPcVsP05SZEKfPnmryiL8tMC6/5C8NY4K0qDIcsfLHUhOzFTjA0IG/qUDHu4uYjyrDGJ0f6sMoMUhHEZDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365789; c=relaxed/simple;
	bh=lQUEv5YmwWK7wvPCt/F6JWaCfa6N6zJgZXTWG/KSprQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YhMgywmrdGUQ2Dd5IX08u5D2Z6O+l0ZTzb82qTJMx1wdPXirtNQLs0jp/SkRKXTJC64UV+nuqgBYiB946DceTlRuSImP5b+bzGU71/k0F5RoCVwiyGRE61DcOD5pedGluaKUvNkZ6D6V5BGrWSZVzkpda6QxpInvUV8OsYAVq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DlDBY0BK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f0444b478so95563665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739365787; x=1739970587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycB9PvCBDDFXn3L0zvAWttQWV/QXKmAePp6fF5m2DJQ=;
        b=DlDBY0BKx4qkcB3cJSFdLhXYUYsvpDYkKrXGSyrEhWtmD5f6uoQxw++qn3pfr+4LmB
         zn3CLbMN5i1D2r0dIfzf2PWJ5Ag5wHqkhLxDX3XSm650p8vwSp3wTYgX84TMZ+8HQFiS
         Dg8JIvNKjOyDT6utfDi5evhmPq8KguMjYO6yltKt2xrkHriOQCsOhw35zAdeUJQWeK3Y
         IpjCl7ajm9tMm+i0kazlT3BG2WiOFYdvvqbCTIHsYf2CBGY8On1GFFjqruJ8LdOROJlF
         lf6d858zJuJejDr3eL39/glImSlzoeHAgLC6SvFoN3a9SViR4Z6KrFBlK/An7rxJaRD3
         Cz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739365787; x=1739970587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycB9PvCBDDFXn3L0zvAWttQWV/QXKmAePp6fF5m2DJQ=;
        b=o/vGA526r5lWHJLeb6cSoFoeHGavkQj7bg/9wP0c3kBNzAZv4xnUndKkuwOVeNVqhm
         S39a7W02pLvKXQq0FnpePJkcHMLzynGdoc/AP+3DRBd77lY+a61AAbuAaa2aGisPZwpj
         0GKrLE1tHKOtLhRaeChd3sS3vOCk8mGMXfipdddLOw3eU7TMPRsHETSfAum1yJeKGz8B
         ABc8wXkivPOH1vIY3UgRHEiTUS1n2Y9VTNI5Rt41P2O5QwLWWSaeljZ87vqOgyfAkqZm
         5Np8ykmog1U7iTkSmelxp2ESeR9yFX9La+x7EpFnoZNSnecKxZb9fo9j/5R93zLR/6jp
         qLWw==
X-Gm-Message-State: AOJu0YxuhtXHYkaGavOvrhHF9VMzfqLbvGY4DXNshSm6bX8g2ZSQZy/v
	PQV+ky5tgGVvXq80S0VEDzZ3oHppV4qOLht/KUVRIg9fJhK3RapnOC9sNC1T/Q8=
X-Gm-Gg: ASbGnctmyUEBeBE2S2Eky0mCgWvWyrezys2YqpfvQ4pTYHPYWsh3F13dKyPXkNBEjqU
	LOPn8YKAZIkhC1Cdh93wGE3ajl4kFQ4MWbnEd3KQud7FBd2pNtTphDt1/cMRrRGZzgdLorKMhGl
	vZbaKTjM4iFqTm7w00Y6tEctUbGP7P2TTFyXcMHj1SS+rou/IC9vF/I2X9ItzkO9M6kBEJtPAUR
	YyKlRUPe/hvFFsmGxy92kHB+/wwfbeevSlgd1aAy3S0suNISjM/5yifsGYWZxwJt1cMvdrcFkFp
	sSP2YrcYmnE+nbcPkepCFQF8S+x4KGJkFw==
X-Google-Smtp-Source: AGHT+IE7ggGjSbDO4jOs3p6OBokuLuoUWKMm/KSVoIs03Nfj9VY+XsE6p3N0W2V5uqr8fIEMDzwPfw==
X-Received: by 2002:a05:6a21:32a5:b0:1e3:e680:8c91 with SMTP id adf61e73a8af0-1ee5c826233mr6509298637.31.1739365787142;
        Wed, 12 Feb 2025 05:09:47 -0800 (PST)
Received: from n37-019-243.byted.org ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5427bf46bsm7489687a12.49.2025.02.12.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:09:46 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH] sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx
Date: Wed, 12 Feb 2025 21:09:35 +0800
Message-Id: <20250212130935.1585338-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now when we use scx_bpf_task_cgroup() in ops.tick() to get the cgroup of
the current task, the following error will occur:

scx_foo[3795244] triggered exit kind 1024:
  runtime error (called on a task not being operated on)

The reason is that we are using SCX_CALL_OP() instead of SCX_CALL_OP_TASK()
when calling ops.tick(), which triggers the error during the subsequent
scx_kf_allowed_on_arg_tasks() check.

SCX_CALL_OP_TASK() was first introduced in commit 36454023f50b ("sched_ext:
Track tasks that are subjects of the in-flight SCX operation") to ensure
task's rq lock is held when accessing task's sched_group. Since ops.tick()
is marked as SCX_KF_TERMINAL and task_tick_scx() is protected by the rq
lock, we can use SCX_CALL_OP_TASK() to avoid the above issue. Similarly,
the same changes should be made for ops.disable() and ops.exit_task(), as
they are also protected by task_rq_lock() and it's safe to access the
task's task_group.

Fixes: 36454023f50b ("sched_ext: Track tasks that are subjects of the in-flight SCX operation")
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 54edd0e2132a..5a81d9a1e31f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3899,7 +3899,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(tick)) {
-		SCX_CALL_OP(SCX_KF_REST, tick, curr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, tick, curr);
 	}
 
 	if (!curr->scx.slice)
@@ -4046,7 +4046,7 @@ static void scx_ops_disable_task(struct task_struct *p)
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(disable))
-		SCX_CALL_OP(SCX_KF_REST, disable, p);
+		SCX_CALL_OP_TASK(SCX_KF_REST, disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
@@ -4075,7 +4075,7 @@ static void scx_ops_exit_task(struct task_struct *p)
 	}
 
 	if (SCX_HAS_OP(exit_task))
-		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
+		SCX_CALL_OP_TASK(SCX_KF_REST, exit_task, p, &args);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
-- 
2.20.1


