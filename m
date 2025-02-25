Return-Path: <linux-kernel+bounces-532006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF16A4478D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC4616BA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961DC1990CE;
	Tue, 25 Feb 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RXJUfcGn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROVoj/wr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D141991AE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503370; cv=none; b=qFRNAZVUPjhIf1UBeEWClmPoxXIc6fMbzTPyWtGjGae+pvARSP4Y0g3CNgbhDVWTUxA/5nub1Cp2dpjJlD8FOJSpoSsCZ1ND+i5jMcIwcxS57Ce7D7uG00+5YgsDM34da29cCBZHjMmu3g70KoQwJtQoj8/IepKFZpxV1yggWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503370; c=relaxed/simple;
	bh=1UFPStimk7GCMSpObszKn0RYDzCLZgqRppp75U5nMoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXFsyAmnpqFcj7wQMlVHOlFMIhynwSBwOkleISpOObYapdoknnmU7VErpXE2yITspPe8ZWyzGOZxM6d+UhFfGFKabW2C27sofAwM3nbri0IaEpbCRWoS8nLz2t5OYtev+kMoTSkPwDTvNbbZJoNe2dOlKHCS3TbNa/2VKV4c1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXJUfcGn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROVoj/wr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6Q5cz+NF4t9mG06Fvky1LDdpbRbeDpEwN6yr1SC6h0=;
	b=RXJUfcGniJLr4k2j2Q18xfYYZYQFusS0Za5OWSLlvpKKdQKIxSDKt2ltWBv8a8es2FSVbG
	CZEWefyXrvUbnRLP2whf8MDprvJsHlLQ0YGxI/06KmuwAs8I3SZJ00zGtWUMB/EFkn1dY2
	fjbY6vu6uvUi/9lN/VHcoS4NAY4byltGigfcuETDPOQ7gQXyLSjppxdXXRIRKoFyNBEwWm
	Fzzrl5TRwlehEIDgj/c1ATEcxPzglyEX0fCB3FvK3iIFeBTQ/+VpQc2vBqHYDG8AU7cVAA
	Y8pCKIr8ja4sp7EGdhWigu1Hg6XYIiKzePDiI0aon8kadThO5n1qhTp0/HPfgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6Q5cz+NF4t9mG06Fvky1LDdpbRbeDpEwN6yr1SC6h0=;
	b=ROVoj/wrSayRMjK5OpYPG5X7uErMr5mDtLouFpfs16nj7az3dBXPZePy1TcNTS8CowNM6b
	n551CJR+Bx4owsDQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v9 01/11] futex: fixup futex_wait_setup [fold futex: Move futex_queue() into futex_wait_setup()]
Date: Tue, 25 Feb 2025 18:09:04 +0100
Message-ID: <20250225170914.289358-2-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

we could also make @task a bool signaling it is either NULL or current.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/waitwake.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 7655de59ab3d6..44034dee7a48c 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -571,7 +571,8 @@ int futex_wait_multiple(struct futex_vector *vs, unsign=
ed int count,
  * @val:	the expected value
  * @flags:	futex flags (FLAGS_SHARED, etc.)
  * @q:		the associated futex_q
- * @hb:		storage for hash_bucket pointer to be returned to caller
+ * @key2:	the second futex_key if used for requeue PI
+ * task:	Task queueing this futex
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
@@ -634,7 +635,7 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
=20
 		if (uval !=3D val) {
 			futex_q_unlock(hb);
-			ret =3D -EWOULDBLOCK;
+			return -EWOULDBLOCK;
 		}
=20
 		if (key2 && futex_match(&q->key, key2)) {
@@ -648,8 +649,9 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
 		 * futex_queue() calls spin_unlock() upon completion, both serializing
 		 * access to the hash list and forcing another memory barrier.
 		 */
-		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
-		futex_queue(q, hb, current);
+		if (task =3D=3D current)
+			set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+		futex_queue(q, hb, task);
 	}
=20
 	return ret;
--=20
2.47.2


