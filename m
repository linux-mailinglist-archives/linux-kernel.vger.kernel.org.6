Return-Path: <linux-kernel+bounces-446626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B99F2752
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D361884627
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC371CEE9F;
	Sun, 15 Dec 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SxP7NIlj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8RfJP0Oj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BF1C5799
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304018; cv=none; b=d0V1e+MHDAg7oySHl5E6Goj+/9rZx/yqNLAozUNLaTvoQBcf9OtgkFl4QiYDC6bFF4cW9bvxbAXtSXhVMssDad7wBFILx0vuJW1zHNQW+FgyOIU9y91KhG0B6iBsdEa/Ir+d93+VI0RMh7vgCdyJ+SXZEZuBOrY8FXl4h+WhKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304018; c=relaxed/simple;
	bh=JzPYQE+P5+fF624i5y2tKmR1xSJxMzO6QO9QQ2LID5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX+3Xd2ybTPvhez5d/Olxh/g1qE4vXT/xthO71TvBi/BCvhUysU2qAY8mNzjVh89hYuDpy+78WEcgppP9XH0CixHGGuPzt9yg5KPe85figu2oVDVw1VDTUbH986jhmsW1gIGzCnJE863Zi/UF8jvxr/vrU2VRs7PS5nErWriFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SxP7NIlj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8RfJP0Oj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK8t4exBPPa9fF54xJFbju/ZW1xJhzX3gtrTdYSijx0=;
	b=SxP7NIlj5sDEYxlUWp3HgN4P8cfFLfdgRxuYoEuzE2LpDhYNfbhocampRVQBcwDzE5WaMN
	1pCegYt1M+CB74GMe68dgI4GSO2XTo23v4ayUd8Y5frLg4etMlx8NlRkFfW1Whn9hyAH1x
	Pu6y3q1OHtGtOVKxcuhqRKjCYVIcqhtHIqWmdxWO52jhXmdkuEJ/1ytOE7IMCHaJ+DZAYK
	wyLv6DKMRnnfhW3I+MkXfQefhR+equBntx5+vSRb+e+gbtlNEpX/y1/w1gg6SYExWG1V83
	v2GDmwbmz+AIXvP/tZRg2y6I55qNSR+j3p3ybTFOlCTjw0PhGICxrY+XZU9VFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK8t4exBPPa9fF54xJFbju/ZW1xJhzX3gtrTdYSijx0=;
	b=8RfJP0OjUYYDhsK6VoGMjifRMrOD5YNA7easdUv3xpFklp0xM21ynZYpYcHkSy8hnrAJlD
	Pmn9trwu5xIitwBg==
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
Subject: [PATCH v5 07/14] futex: Move the retry_private label.
Date: Mon, 16 Dec 2024 00:00:11 +0100
Message-ID: <20241215230642.104118-8-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The label futex_requeue in futex_requeue() and futex_wake_op() is jumped
after the lock is dropped in a retry operation. This assumes that the hb
does not need to be hashed again. If hb is resized then the hb can
change if the reference is dropped.

Move the retry_private label before the hashing operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/requeue.c  | 2 +-
 kernel/futex/waitwake.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 80e99a498de28..0395740ce5e71 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -443,10 +443,10 @@ int futex_requeue(u32 __user *uaddr1, unsigned int fl=
ags1,
 	if (requeue_pi && futex_match(&key1, &key2))
 		return -EINVAL;
=20
+retry_private:
 	hb1 =3D futex_hash(&key1);
 	hb2 =3D futex_hash(&key2);
=20
-retry_private:
 	futex_hb_waiters_inc(hb2);
 	double_lock_hb(hb1, hb2);
=20
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index fdb9fcaaf9fba..ec73a6ea7462a 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -267,10 +267,10 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
 	if (unlikely(ret !=3D 0))
 		return ret;
=20
+retry_private:
 	hb1 =3D futex_hash(&key1);
 	hb2 =3D futex_hash(&key2);
=20
-retry_private:
 	double_lock_hb(hb1, hb2);
 	op_ret =3D futex_atomic_op_inuser(op, uaddr2);
 	if (unlikely(op_ret < 0)) {
--=20
2.45.2


