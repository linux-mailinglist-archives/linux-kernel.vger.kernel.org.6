Return-Path: <linux-kernel+bounces-223199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B92910F82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F03FB2248B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A71BD4E0;
	Thu, 20 Jun 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3xaxEw1"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A91BD03E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905331; cv=none; b=gPe5bCfX7EKwHeVEe0YgodHDNMx9LWbvUvWBEdWlX0hjCD1ujEa85GYn7mAFk3ftt8PVLx3CZLaJxx16Ct0qvy2PL628qcA8cadxkUIbVbk3HCxmIIRc9JKSve1fBGPv3ILkgjcCYoDSngLWbkxk9Ns0XJe8LTeGUWApZivitJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905331; c=relaxed/simple;
	bh=DJN1/0dLnS+Xs1C5uz+BTPgNljTUd6WrcnPuKPbssCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FogupICx7TBdbD3CnJ4VgohsCnuSoGMFGRQAie6/JJZRR85M1vs3HcRSFIQAHb1hj4TwZ360sDqaYybN9LwDn3sssy8DnZEQik6hXqdHD9RHE8Pg8ls7P5IFSIKJapglEUYruxMUXDQ4k7mXR8t12xhJvk0AySfnXemdyrLiCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3xaxEw1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso976380a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718905329; x=1719510129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h1QiIIir5vunr9vjaC2dataFjUik+pcjP4k0418uA+c=;
        b=s3xaxEw1InKBlcPPe7/o4VUtnlfelfuKF2Om+p7oKj9Kxj7S5ZCxCuCRo9j77pGYRx
         DdZ+pf3oRRAw2KmOMrSmz3Uv/5pUlAhCJyRIoMJlGayAvb1TVD+hRRa670pOB9cI6Orw
         mP4zsjOp3uDF1YnhSBdYiwnxZrlzCYpOvJxNW39OVR9SOIrQE8eMvaDWdtSh/80hgCyC
         GUfcmrh/JOx9IJstLAHwBrdih/jirNiXzJbrTKNdDylk2P7J3RAhlxamMqXMTJbaRDJ0
         6pAVGpavg3n1JyOdj182atnLtji+jiq2CnXiLY6UdL0xtx3hcZ69NX6jIc9bxLhTCyKn
         FcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718905329; x=1719510129;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1QiIIir5vunr9vjaC2dataFjUik+pcjP4k0418uA+c=;
        b=b0r48TKgloxqwHuDyDzY8rqu/Y9sGflHAPkfeZd7GWd7J3QARIeGk/ms+puPgzwlmy
         Xi1jFMMRrt8W2BQHSGJrKmVmEzoAWjR54IFjK6OHCOXdWTVMJ/rNHtSceo/cK3t/ElnO
         aOoWlUI5VYwjmBQJ03waEzfNfMmb757W9Afd7iZHd3UtMiFxPMvxzD3QxHhoakVT8ikk
         D6j8jgpcBqmZJ6ZgEANt4XeQLjAAjqcV4+WB1LnT7P3yxOG6AxH1tV2uVH1nxBkkiuEh
         30Nc/HOIY4S7AoSWUHViWXzdJrD3or/7B1HUOyKcdMSEAGUnvE4YY8JR6CJmhTobjJqL
         nbYg==
X-Gm-Message-State: AOJu0Yw9ALDTtK7rlbCBb14wkAgd5+M7186e7RkDPEbVdsBF9QhaJorb
	TrDvTKByQC4Hw2x7D/dtu+3GLc0H7C89RVC3EcNJyN6Uf4gPIuG/d/Tauqa3QqgvPt9ezyiDIps
	cqUM9WG5fNwl9No+tpaaImXj2gdbiHqWUrUsZEaNmXqQ0FV1uTj8I5iEEVHGDwdfT2CXdiyvdkA
	9VTTU+pE/kjy6fgtldda+fBhQ8Htrm9jh0LLuUa/H1bgch
X-Google-Smtp-Source: AGHT+IF1woX2SNWshgADpWOWweU8r5YWNeDTkTU3tLgfRhzX8b47i80LVNOdkkpTh2ltwafKfd/PsvxThrCV
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:e047:0:b0:659:6d57:7a5e with SMTP id
 41be03b00d2f7-7108ae61581mr19042a12.5.1718905327861; Thu, 20 Jun 2024
 10:42:07 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:41:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620174204.1802235-1-jstultz@google.com>
Subject: [PATCH v2] locking/rwsem: Add __always_inline annotation to
 __down_write_common() and inlined callers
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Tim Murray <timmurray@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Apparently despite it being marked inline, the compiler
may not inline __down_write_common() which makes it difficult
to identify the cause of lock contention, as the wchan of the
blocked function will always be listed as __down_write_common().

So add __always_inline annotation to the common function (as
well as the inlined helper callers) to force it to be inlined
so a more useful blocking function will be listed (via wchan).

This mirrors commit 92cc5d00a431 ("locking/rwsem: Add
__always_inline annotation to __down_read_common() and inlined
callers") which did the same for __down_read_common.

I sort of worry that I'm playing wack-a-mole here, and talking
with compiler people, they tell me inline means nothing, which
makes me want to cry a little. So I'm wondering if we need to
replace all the inlines with __always_inline, or remove them
because either we mean something by it, or not.

Cc: Tim Murray <timmurray@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel-team@android.com
Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reported-by: Tim Murray <timmurray@google.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Add ack tags & minor tweaks to commit message
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c6d17aee4209..33cac79e3994 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1297,7 +1297,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline int __down_write_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 
@@ -1310,12 +1310,12 @@ static inline int __down_write_common(struct rw_semaphore *sem, int state)
 	return ret;
 }
 
-static inline void __down_write(struct rw_semaphore *sem)
+static __always_inline void __down_write(struct rw_semaphore *sem)
 {
 	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static __always_inline int __down_write_killable(struct rw_semaphore *sem)
 {
 	return __down_write_common(sem, TASK_KILLABLE);
 }
-- 
2.45.2.741.gdbec12cfda-goog


