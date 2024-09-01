Return-Path: <linux-kernel+bounces-310204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E3967647
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAE31F21951
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49900171644;
	Sun,  1 Sep 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="On0Yubt8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+LLBaqy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48F16F265
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191051; cv=none; b=bg61JiVc84II2Z4ARrjiFECtHH6KVETyjhotFj5Wahya0whTTL/vy6SkcS9MxN0JTT+M2Kg6FZacHJlsCthLXANaxtYjbDXQqNVdrkrh2p6EJkDTcfIIGaYUj+Pvwd+3PB3FDyFAJBfbaZ4bPxZCAzgsvBkvwkekCyZFhyghfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191051; c=relaxed/simple;
	bh=3/ooiwAMCzuD8/iqu5kr4KA/Lc6pRQ6S8kLv5jnNUuc=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=BtdB0tdqftILmu1+vL1hbuzkX2Pb4OsZM7uCY1xsH4M828NTKGJessOi1KTkWXrDZGw0A465E5aZnuBGczGFBujIRlSVawkjSmqrDNBq/S/uSAN07nNcMEVCt/x2HPbyvEllXVLLNd4dVxKt3H0JSZhAFTWl18JqD8dftcKy3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=On0Yubt8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+LLBaqy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725191041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=FKx+OGzkQWvF60x4JoV7VO+witZOCz5/me1a/JajBAM=;
	b=On0Yubt8pxBfSJfl62HHRipOPZImXjR72UCtwFsIJ47I91YtkqW1LPUO0derC1JIoHie4c
	vrm3MOZtv8+LUjAAQJCLE7nC034rQT9iMY5E10yicagUsOiD4DG/1AJIxUYMwa+pNY8EH4
	1Fjy/xtIF+S3TBjvs1vzBD5kd5P71x5i0ApWmmK3PVU3WAXY9ona5MDO9DgWhHGF48K8+r
	Ef+lMCrmN1FHgcBpbSTtCXt2wNV8FrF/nfrGlJDBGIAPqOB0QArzhegiMrivFPt1StT6ON
	OK/7vzfxyBRNjLMdNxDTjsZmusg20BqvmQXMApBROD4dVONfPuhiRDHOnUk/SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725191041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=FKx+OGzkQWvF60x4JoV7VO+witZOCz5/me1a/JajBAM=;
	b=Z+LLBaqysdnpv4RwRiB25mLQyWwk0MwoAoQBHjNs56dxm/HnsbvbqojUNkqDnAgZZsCmG0
	8WGLym2q0dsdZNDQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v6.11-rc7
References: <172519097408.1871736.16401401125691449823.tglx@xen13>
Message-ID: <172519097566.1871736.15971434529600428822.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  1 Sep 2024 13:44:01 +0200 (CEST)

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
024-08-25

up to:  d33d26036a02: rtmutex: Drop rt_mutex::wait_lock before scheduling

A single fix for rt_mutex:

  The deadlock detection code drops into an infinite scheduling loop while
  still holding rt_mutex::wait_lock, which rightfully triggers a
  'scheduling in atomic' warning. Unlock it before that.


Thanks,

	tglx

------------------>
Roland Xu (1):
      rtmutex: Drop rt_mutex::wait_lock before scheduling


 kernel/locking/rtmutex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc0..fba1229f1de6 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1644,6 +1644,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mu=
tex_base *lock,
 }
=20
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1656,10 +1657,10 @@ static void __sched rt_mutex_handle_deadlock(int res,=
 int detect_deadlock,
 	if (build_ww_mutex() && w->ww_ctx)
 		return;
=20
-	/*
-	 * Yell loudly and stop the task right here.
-	 */
+	raw_spin_unlock_irq(&lock->wait_lock);
+
 	WARN(1, "rtmutex deadlock detected\n");
+
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		rt_mutex_schedule();
@@ -1713,7 +1714,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_=
base *lock,
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 	}
=20
 	/*


