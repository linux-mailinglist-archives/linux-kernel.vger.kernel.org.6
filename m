Return-Path: <linux-kernel+bounces-446622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B513C9F274E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD0818846D0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39FB1C4616;
	Sun, 15 Dec 2024 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUlENTn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PSxVCp5D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0713E88C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304015; cv=none; b=MR0kasJl8kJbWYDrJmtPPaRQarBN+JPlXXvfRX262Yf4oMSLr0vEHCkBFHJy0g156HYDwTK6ww5oPmIvBAUEfqJhRUm+xVq4qS8hGSL6NK78l+87J4MMurg9nJ1d/loDyxVYdEUHXFrR3j/FOW32eWG39pswc3LNXtsOBvIHYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304015; c=relaxed/simple;
	bh=InvQp8csFucSAYHvhD3g6l+nVFgce1XtjBnaPhEq20I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMZLG53ayR2VxQsHEz4YJRX+WYELjTy5Haq+UFeZxlO6txnIpUMfuDTZbyO78UreDXZ8Y2f9sCvYsqpGyjzjLb6LXLKeT1k29PIljLbd2WDY39hQHti4aMcaO+I2t7AR0KftxuuadIYm4pCx5l3/us+YI/bh6thmg117i5DjCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUlENTn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PSxVCp5D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQw1ajNgbVfr/Cy7eKebvTHzkVUlLunUhj0hFbpNeGU=;
	b=oUlENTn11fS+Ps+HAxDLNvmDnSMpjmWsEOcSjenuBt1BP2lYbWKEFFRi2btesLeYGbOzii
	iM/xVZjI1JTyw/QIm8wt4QZTryaYfdDT7qz0t3lT7bffqAABh6WF4rOydSTul46Wvds3TR
	Ur+hqfZA6KklIRjx+wTEN6VwUSjlugeC63uwUNVxWHlbmQA2Ypy5Ww1MQbrxwhzX3P83ri
	5HagoamJpit1fVj/1I5L5AdLYj73LC/AyYQVNZOYbz1MjOvCrxCC2Juv+3aIP1sCLERVI/
	6LZluqtMed4+kvLQ2ftRSCN0wb9603A2/tV8faL+NSFYBaNt3F8rJFgguAftTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQw1ajNgbVfr/Cy7eKebvTHzkVUlLunUhj0hFbpNeGU=;
	b=PSxVCp5Dqex9WilRqkXsfn+9tBzZK+wSjJvvwwhM6sCxqhKm9Y7vmuYXwtUM/Jk8H69VCK
	KTDDTGISl0SdU1AA==
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
Subject: [PATCH v5 01/14] futex: Create helper function to initialize a hash slot.
Date: Mon, 16 Dec 2024 00:00:05 +0100
Message-ID: <20241215230642.104118-2-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factor out the futex_hash_bucket initialisation into a helpr function.
The helper function will be used in a follow up patch implementing
process private hash buckets.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index ebdd76b4ecbba..d1d3c7b358b23 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1124,6 +1124,13 @@ void futex_exit_release(struct task_struct *tsk)
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
@@ -1141,11 +1148,8 @@ static int __init futex_init(void)
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


