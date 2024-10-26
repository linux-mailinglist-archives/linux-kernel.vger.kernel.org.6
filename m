Return-Path: <linux-kernel+bounces-383406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888F9B1B59
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D41C20C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB51D88D7;
	Sat, 26 Oct 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dN8Yc4mF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtXaU3ku"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8241D7E33
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729982598; cv=none; b=mtyh/fI0vQ8o3RvZkMfKcn23QZGoxR75EOgd4YoJnaDTVuhImKlnDMJIkGO2yS37idPqgmgiX1XR0WZ3zm3WTHqGkaYTmI6I6zGQp5JSy1n5FpfJ+VqkmEUKSTKeA6mLmr7rzyw2SmjgIuGrwqf+q41U4S837QJm+fd5Y84Fr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729982598; c=relaxed/simple;
	bh=wxTiCPgczYeasflXTB3Gnf/RVwmWOrJrFbwDdZDzhX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWXoM5ysbFQbR0X69nSW6SuTaFrmxEh/xjsJ4EO+ZJNpaQEaF8Z5ht5mo4VWcrEHwmoh9z4dRxSyb58Evr1foB7imnja2zakqgmVjoD5X3yNb+jCanYpTNg4XVzEPLC1M7Aw1eRokj8u5GO363NmkLbhDkPiHDYA7jysyiLAT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dN8Yc4mF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtXaU3ku; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729982595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mZlKRrG+DPnUxrk/55cv+455WXnVQzhH1V8fNj3nts=;
	b=dN8Yc4mFkpnPZKnvzje6g584r8zGyazkKarQMzLtUPEu15h6BUvjLGlVR9P28soLeCoCqn
	3WzcxXnWYvVIq6NV7jRfyILExp4K1kPwSnhIn9ytth6oMWJo28QXOFFFOClCI4cv3suzEx
	eKQaUZ72178rjqOlDDOYbTOg3VP5+6+BhHmWrr4BTQ8dwoNSbCmbGzov5ArnLPul0gdtSv
	Bpwj5D3p6pdVFGlf79IvmXSzf7b8sLfxrfrRjjVBSLL6vA5GTpg6qkkdCc8OSnJfmLTowW
	/jIR/GoVsCihKeyuDQyabrv2M8q8Z5etCXpUefX6UssJhjkmyXJHzqOt1vE95A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729982595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mZlKRrG+DPnUxrk/55cv+455WXnVQzhH1V8fNj3nts=;
	b=TtXaU3kuKjfHUvz5ealc1qZWbOSqeu0vIs5y5m+DRPtWmYHc+fRt+JfFDR8CQCymvSeTcc
	/sX1Ic8+xR/Uf+CA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 1/3] futex: Create helper function to initialize a hash slot.
Date: Sun, 27 Oct 2024 00:34:50 +0200
Message-ID: <20241026224306.982896-2-bigeasy@linutronix.de>
In-Reply-To: <20241026224306.982896-1-bigeasy@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factor out the futex_hash_bucket initialisation into a helpr function.
The helper function will be used in a follow up patch.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae26375..de6d7f71961eb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1146,6 +1146,13 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
=20
+static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
+{
+	atomic_set(&fhb->waiters, 0);
+	plist_head_init(&fhb->chain);
+	spin_lock_init(&fhb->lock);
+}
+
 static int __init futex_init(void)
 {
 	unsigned int futex_shift;
@@ -1163,11 +1170,8 @@ static int __init futex_init(void)
 					       futex_hashsize, futex_hashsize);
 	futex_hashsize =3D 1UL << futex_shift;
=20
-	for (i =3D 0; i < futex_hashsize; i++) {
-		atomic_set(&futex_queues[i].waiters, 0);
-		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
-	}
+	for (i =3D 0; i < futex_hashsize; i++)
+		futex_hash_bucket_init(&futex_queues[i]);
=20
 	return 0;
 }
--=20
2.45.2


