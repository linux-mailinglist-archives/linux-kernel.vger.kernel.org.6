Return-Path: <linux-kernel+bounces-282979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16D94EB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC4B1F20FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F04170A2E;
	Mon, 12 Aug 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5EcQnsR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3qOc1st"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCF166F29
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460013; cv=none; b=gyEvuBC04CxQyVXz0elDlqKWCOT93V4YhAXrHrskB7eMGhbxsecyl7H8dyXQbsE1622IA9/PZNNyJR+4cXZKtgGyQdcLaeu3LXAKgHvDZboM+Ooca7wP50qVVv7mNMMRA203Mai9/LTubiwUEwvV5+Cy/dKH18mhJquLqDz4IwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460013; c=relaxed/simple;
	bh=Vvo65eBZ3fApHBgj8mgkZYRoUX6eV/raJvBbZmdKM6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZmcKXUfXV2zJu7WnyELbOHkELOXFs823WN5CQupl+otMPpKuBuHg85IuYuxl/5EcB5EPGBLlnhuu5hc+POC/3Fch80W5vhU3gOXldd2UtmSYmhLF2i6g4btT2Py5A7xoAHE/Rpfwk47YPwxI0YPGHl+eC5Ry/YfsmHwl9Ve2+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E5EcQnsR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3qOc1st; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723460010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcL+zNGIx3Ivr8BjLOnyNxuRZmmfsnShYAT6NnWXJq4=;
	b=E5EcQnsR1sirmSNqMi0LGRx+Cu5e/4zHbnY1xE2EtotPaf84WRvMsdcKh6oWuX5CLPGx7L
	jFZMoiPuSMbaIjNzjKhCfbMcSj4Tu+QkAd3DMsbsFzl3CKF59QPdVyed5MU/BtFMPVa2Z7
	HOpxNbH1kjEqH8z7k6An19xjNEFJ1Y+NuTwtCk22VpP+qq3fDVjL666BJZfNE1S0RI16jW
	tRer9ZQCqGJRdOd/fVQjIopSAjdIsVeqmOYt0tfegUt3/76cc1O9O4LRYTMm1ObrZ57J/j
	lA2hbUqEAkVYNGVK7aOsAohDJl6Hj2A3QWDajra1wBz453Be7e5ggPaAbHxnkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723460010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcL+zNGIx3Ivr8BjLOnyNxuRZmmfsnShYAT6NnWXJq4=;
	b=D3qOc1stzinaCf5qAp5bTNPMLUy5oEqsnhzLeP4/lrFBN+KJ69zEMrBCQBNN9q8itUnKMj
	Y8cbDlANSpBUt/DQ==
To: linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] timers: Add sparse annotation for timer_sync_wait_running().
Date: Mon, 12 Aug 2024 12:51:04 +0200
Message-ID: <20240812105326.2240000-2-bigeasy@linutronix.de>
In-Reply-To: <20240812105326.2240000-1-bigeasy@linutronix.de>
References: <20240812105326.2240000-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

timer_sync_wait_running() first releases two locks and then acquires
them again. This is unexpected and sparse complains about it.

Add sparse annotation for timer_sync_wait_running() to note that the
locking is expected.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 64b0d8a0aa0f1..429232d8659a3 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1561,6 +1561,8 @@ static inline void timer_base_unlock_expiry(struct ti=
mer_base *base)
  * the waiter to acquire the lock and make progress.
  */
 static void timer_sync_wait_running(struct timer_base *base)
+	__releases(&base->lock) __releases(&base->expiry_lock)
+	__acquires(&base->expiry_lock) __acquires(&base->lock)
 {
 	if (atomic_read(&base->timer_waiters)) {
 		raw_spin_unlock_irq(&base->lock);
--=20
2.45.2


