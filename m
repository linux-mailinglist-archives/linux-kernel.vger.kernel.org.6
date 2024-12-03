Return-Path: <linux-kernel+bounces-429862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB359E27DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243FB168AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB271F8EE2;
	Tue,  3 Dec 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="li5ktNZV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1mKlZDg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390621F756E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244220; cv=none; b=pu64n7QjShaY1eSaXDMAVedopcRc/Ne2diJ/EkGUkSGtQ0MhJWy4+gHD0tLhQa19i9DoZynf6PsfT9ai1Q7YJyAajkCY44SsIlb3mbKFYQ4n5jo9GFoMoXWG7zC+qdrnM1C5ilCSihc9wRE2Mfipppq9ynUF+Hqtjbh+9ZH1fyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244220; c=relaxed/simple;
	bh=mev7mpyqFcGhGcFLm7uZaP+9Wq71MjLIv/zUC+zUGlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAsjk3RQiyPwpQwAh4bRpr8sk3xGVOXxSfggapDIlvbbPVcIwzY77gz9N4JmUZRN8IArQjEGYv+yoymOgWbhEf6TFtURqH6V/u4lZTcDx6sqb4yKHB/GYFKl67w0FE5lSh4NzDPEP6CBTcllYaVTK8wnPRvNiP/0A5SnQC+bukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=li5ktNZV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1mKlZDg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tiz7IpGB0/Q4xmudvzY6v3tsedJV49r7UohyKrwKBEw=;
	b=li5ktNZVN7SLq0YPxZLS/Sv6kmTMWjxrk5txelzuP/X54MIHCdumDndR+ddp1bjdz1evQz
	g930/5mh/qO5aIbuaEqs3rAeQAgcn6WgvaNoSyf76DnUSeNrteNGSI6/GNod+Q3caDlpcb
	lahUg2XIUdCfC8Z86RTKpGmkZ5UbGZBQIplmaEKpEcilcc4uJjAwR6yXx0MIOpViK6oj5s
	e0oqAorKbBPZpJ4T2rbEvdr3XCxXqG3pL+fi5vVm7qfkDeSV6ubN5FqD8vwYYmXBnLyZwE
	fFEPMks0B9fZw2fZCU6qzINdElK4TNXGI/U+qak6E/7Aw2hsZM2jpseliLT38Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tiz7IpGB0/Q4xmudvzY6v3tsedJV49r7UohyKrwKBEw=;
	b=u1mKlZDggOWHwlv+ccFNtXcjILYxjd1KkPE0k9Hgi/uSCO+bn8ns5OigXkqD8+DiJSZ5ur
	tyYECb6rpUFV48BA==
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
Subject: [PATCH v4 01/11] futex: Create helper function to initialize a hash slot.
Date: Tue,  3 Dec 2024 17:42:09 +0100
Message-ID: <20241203164335.1125381-2-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
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


