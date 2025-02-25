Return-Path: <linux-kernel+bounces-532009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F2A44792
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D4F178D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B91A2547;
	Tue, 25 Feb 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgE4klGO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zbX3Os89"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE11990D9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503371; cv=none; b=YtmEWBWVer2yDuYQrsgRFoju+r+oPSdlyh8Cj9AJnJXht15HsA3BNvwevJDO/9v1tcS4rLpBNorYnnURxaZHD1zjiKjRopAy5+8C8yItVfUvXVkYycWPD8qWZPpk9z/Cth/AzDCVBRvdjuh3P2h2zgSyV2Bn6NEiEaMNQ73vF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503371; c=relaxed/simple;
	bh=9+u0fxT/kKUJdd+zdmmGXakO8qf81Dzlwd7I/W/yn4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyD/Au5QixiIWp0l+jYyxS5XA21/dtpd651qR4KPElBj8RoejRE7d/pb+Y2+khENgEtZw/08xvu5/bo15WZEhynLSd3ug6zkM67oaI3KDjwbkX2SMtjso46Nrgqk3u1fDhFgmTcNl13jSlpuXzC84N0VzM8HZoux7C9+s+zUnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bgE4klGO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zbX3Os89; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIUFWfMZivwhlZ0/mkumDKTy431rCC/YdcJfJLYMkgs=;
	b=bgE4klGOrsqTdb5ztP5v0EdsDZpDOzegHzttyk/X4AlBC7PoJJh2PxgiPKOaMtdRN1fAp8
	7XtTNXOnB4+8x/XIaPLzOVnOSUBi8XC7/8uWWlE1RJN/dYJ8T9Uc/I/nAvjXn1ByMLyXWK
	iih7z9vsI++LLPXO5Vfzmn4Iw6a2s6qC0XIq6Auif3mvlzdyvY2mF9gb4DYSSFq/+uFKV0
	5A0+i9F16qdZWw4w23Ylyhu4Fk7XRjQqJk8lMWiJukuwQfTE2zk9649/kNdxXjTShkc1Ff
	Qj3O+ZgkkcymIOV2AdeQB54GTWDdRQlyGb2CvFLa0oE/m8t9b7BA6IYOe9mHWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIUFWfMZivwhlZ0/mkumDKTy431rCC/YdcJfJLYMkgs=;
	b=zbX3Os89pkk8x/dg5+jnRRq4RQS+PWNidSDO/WO2G3FCgDeplycGEDwsyx5N5F/Sb9kurS
	jrf5Rxd0UfY3GLAg==
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
Subject: [PATCH v9 02/11] futex: Create helper function to initialize a hash slot.
Date: Tue, 25 Feb 2025 18:09:05 +0100
Message-ID: <20250225170914.289358-3-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
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
index f72f4561eb94e..69424994e7d9e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1122,6 +1122,13 @@ void futex_exit_release(struct task_struct *tsk)
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
@@ -1139,11 +1146,8 @@ static int __init futex_init(void)
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
2.47.2


