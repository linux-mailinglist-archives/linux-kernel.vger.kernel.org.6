Return-Path: <linux-kernel+bounces-282980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C674694EB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6438F1F227E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED00174EE7;
	Mon, 12 Aug 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q71xkR3T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oDzZ/IpV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC6170A0B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460014; cv=none; b=YU/CaBDsRYJrd0yt5KQ2HpDD9X8sZ6VeCm8Detc7JbNGNvndZfQI7T0V0IiMHui98i0qdnf6U020AbsIggylPXVrs6NcZaqE28RvU4FAqeYcpv624eJdr0Myd8cNfeBeeJLCbGJ59lx6OBmJPtvCDvF12R1MDlsE88vKwtj+TKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460014; c=relaxed/simple;
	bh=VKiIt1cw1TGdGgBj49i0dm9y2zD7jsGlYQ9bZ41p7C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRC96MWkZoUtTVT05PhnSbBX92bHrujkNxWMuY0WHrqeIwZhoBIE2gTomWq4NcmVfgKPitU2/D7UaCdK4YH8KXZmAxF2LHdE1qYslYbUWDLkdZiGLfYbz1bdDdA8YMqSUY3CyVJ+f+fk9VWxMl1NVmK551tnaMH3qidt3JlHarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q71xkR3T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oDzZ/IpV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723460010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNehWMeYt1ZrGOgLXiaU/DzVkqIQBQkzqxpsIkD5InU=;
	b=q71xkR3TGpk0X5746BZTo5PJc2IjL6Z2nUKrznTe+57T283WAeVpHbRARfm2/ftaJFVve1
	1hSGP9WlHqzLrNlMlx5vFUty/X/KBYcQ5c3H3dGG8fzF2WH19sEpNNfuvsVmxMR69qhE0/
	v/ClGFNhXJP/sK6pSZpQAlIqPD5AgBeU5u6EZ41hZWG7XMGIjp37CWutY5s27Mdr0Q5V7G
	xb+txmkuRTvAq1HHJQUc2TBLFmGtilMj+5F5w0SdaE4UoE3AycRUDCnCrsXDyHzkWSnSZZ
	jCr6z5x+89YV92GA18SUicYftHP9Zti+PSdms7it97DU9tec4t62AtUC/9+1qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723460010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNehWMeYt1ZrGOgLXiaU/DzVkqIQBQkzqxpsIkD5InU=;
	b=oDzZ/IpVmajgRCg0NbxqG6aFuV/tSKfbH7jNaRFkyO6BhBRBlinUzzc9RWsYotvd9t7lN3
	2u8vjQ6ZLxwhm0DA==
To: linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] hrtimer: Annotate hrtimer_cpu_base_.*_expiry() for sparse.
Date: Mon, 12 Aug 2024 12:51:05 +0200
Message-ID: <20240812105326.2240000-3-bigeasy@linutronix.de>
In-Reply-To: <20240812105326.2240000-1-bigeasy@linutronix.de>
References: <20240812105326.2240000-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The two hrtimer_cpu_base_.*_expiry() functions are wrapper around the
locking functions and sparse complains about the missing counterpart.

Add sparse annotation to denote that this bevaviour is expected.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d41..f56ef23aad903 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1351,11 +1351,13 @@ static void hrtimer_cpu_base_init_expiry_lock(struc=
t hrtimer_cpu_base *base)
 }
=20
 static void hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base)
+	__acquires(&base->softirq_expiry_lock)
 {
 	spin_lock(&base->softirq_expiry_lock);
 }
=20
 static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
+	__releases(&base->softirq_expiry_lock)
 {
 	spin_unlock(&base->softirq_expiry_lock);
 }
--=20
2.45.2


