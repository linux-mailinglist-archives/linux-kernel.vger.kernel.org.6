Return-Path: <linux-kernel+bounces-384902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686E79B2FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04389B22F46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF321DA2E0;
	Mon, 28 Oct 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Avv09th";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzCZRmyC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D31D95AB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117972; cv=none; b=MloILe2fhdDFjtMN3agAVD87HjP85V8F8VBUBMKtU2niKKOiRVRED9vOyPF73wU3eNse7A4QayGoWZmMyOMoJphTt71IQMdqrWOzHcsDDtVtCvTp7UxeLgMeWFzOXZqhwMgRL+qEUzvGKPxULkk1skrlbWAWIWzidvIyRmwNqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117972; c=relaxed/simple;
	bh=wxTiCPgczYeasflXTB3Gnf/RVwmWOrJrFbwDdZDzhX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBHa1dnW7GAO4hWv4Tf/QqatBux3FsFkY6MJYa+KLHLytADJyjJ2buZoc8x9pCjaukRwT5WJJNRNcsS7xtVLftUyq1rJoVFxA+VDDjtCSFLdiPo+z2h8u44/KYoNjREv2b2kSi0l5zR7hsCmcLr9U/b5x3wkXrP5InUMYy9Ecag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Avv09th; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzCZRmyC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730117968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mZlKRrG+DPnUxrk/55cv+455WXnVQzhH1V8fNj3nts=;
	b=0Avv09thCxTzw/EHsXH4o4jpe6LDkiSXGPP5UBrDLlZMlKk+p5aoUm476tIi6spKn54VJM
	3SScuAQH3jbLLtDRxMjoGKOX1esdZGyUjyRu3fgf64SR+2NRpO1LxsE0mFy2O19SBCI+8u
	/Q61iwqY78rsqq4guXlewMG3VN1d/pgCSqBGhpXtX3liCX6VSk2QCIDc+2P+7IJe2f1H6k
	i1z4jlNoT3QFvJfKK8r3tBZ4HYQYhuFQ8VxfXmZQ1RIgHBulWi2YcJOhbihRSi7qxMA35T
	IpKKHGCyVFAnAkH3qw3/esgDndtm6Zeduvy0tfvTtvrOWsCP4dq+lSFeCFmmCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730117968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mZlKRrG+DPnUxrk/55cv+455WXnVQzhH1V8fNj3nts=;
	b=EzCZRmyCicW2lvutwRArQOFBk6Izps7xLRpleRA/WfLnkR293QDN/8/H6yfXaXu9z6J27h
	3iIEBz+s2/R1+wAQ==
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
Subject: [RFC PATCH v2 1/4] futex: Create helper function to initialize a hash slot.
Date: Mon, 28 Oct 2024 13:13:55 +0100
Message-ID: <20241028121921.1264150-2-bigeasy@linutronix.de>
In-Reply-To: <20241028121921.1264150-1-bigeasy@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
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


