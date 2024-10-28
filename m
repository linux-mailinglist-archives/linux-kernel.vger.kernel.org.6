Return-Path: <linux-kernel+bounces-384283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA5C9B28EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19EF2821F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6F1DDA3A;
	Mon, 28 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uPKByuFy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dPzTHwAP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95631DA100
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100748; cv=none; b=qloqbERKMEKFYTOyePIlAgbIs0JOgRxja4evSEkaBTfTjunoaVHCDzHux75N6AOJcic05X1IV+f8eroBVwfA4k48ZdyG3t2UwJECNgEN2/nrd9z1aW46h48yOT5u3E0xJY9SbIBAgEm4quHqcnaOt1+mYbcCZeEiti6H7owY73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100748; c=relaxed/simple;
	bh=smHFkqsz3mw1mDZYwEhWupekt1AIYFjkWHBFa6NC69U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RG/ssroU4hr9cS6l0TW28/z59Ia5Q2RRzBG8Dx8Sfzt0S0VRDgtu1yD4/ugV23/OKb83S1x4uAkRdc7qxmhU/Q56AoJIrcRKQVhl5ZCE4skJeBbda/xAgllQJWXYF1JeUFrf/pT0htyTLpaxGLU0i16BYf/jsYnKJ/ueOYjD/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uPKByuFy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dPzTHwAP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Z9eNHLYeEy7Ewiv3AXJ5/PjzpzROuY0tnmMn4YrxhM=;
	b=uPKByuFy8eQA5q6FZkkpPZYrQOAXxjp7KtRGY3m4d5EqHMRHEXWO3YubzAmQo/vcRPOdDS
	ch6t9gbtixJ+Ba8Qq/scI1CI2mC4ygQkkzbPLs31HRV86en5PqsLunLzMYy/Bw0vudiFP3
	aAaAu248rOZduD013uoIyCfTBmhuBV10n6EkV7ONjyX+xV3uY3MzbK7QbO2NV/gRgRA1ky
	TeRG+8koZlKrSVm+coyYImSWnmC8YwJl8N39APNk/luU7+VBUOf8Dsf8YRsC42p1cVuaz5
	dX832jHji6C3RGyCTK3n6MKRJj9PUmsS70yDB5AfcIcPFz+CCwf+thl4Ubsv6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Z9eNHLYeEy7Ewiv3AXJ5/PjzpzROuY0tnmMn4YrxhM=;
	b=dPzTHwAPlJ5PR0o/inpR9cRDEqbn02QRO+yW7MFpDPqEHg1kFFfnESmdkThcw/7ivyHUFn
	cEHDqE2H9XJmXLDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 19/31] timerfd: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:52 +0100
Message-Id: <5155e89593a311901e2bc2fb3a72f7fbfea2fb57.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Christian Brauner <brauner@kernel.org>
---
 fs/timerfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 137523e0bb21..c57ebced16bf 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -207,9 +207,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int f=
lags,
 			   ALARM_REALTIME : ALARM_BOOTTIME,
 			   timerfd_alarmproc);
 	} else {
-		hrtimer_init(&ctx->t.tmr, clockid, htmode);
+		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, htmode);
 		hrtimer_set_expires(&ctx->t.tmr, texp);
-		ctx->t.tmr.function =3D timerfd_tmrproc;
 	}
=20
 	if (texp !=3D 0) {
@@ -444,7 +443,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flag=
s)
 			   ALARM_REALTIME : ALARM_BOOTTIME,
 			   timerfd_alarmproc);
 	else
-		hrtimer_init(&ctx->t.tmr, clockid, HRTIMER_MODE_ABS);
+		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, HRTIMER_MODE_ABS);
=20
 	ctx->moffs =3D ktime_mono_to_real(0);
=20
--=20
2.39.5


