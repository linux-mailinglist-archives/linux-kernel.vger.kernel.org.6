Return-Path: <linux-kernel+bounces-384253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B19B28CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67213B2195A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4761CF2BD;
	Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3WYO9J7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/VaS/zF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4FE192B86
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100636; cv=none; b=QPl06MoxLy6AjoJmBimovBJtzQG548K1G1bcO7Hll3unyzMwbkh1oOlrt08SaHFkxGWvwxrDiNFiZxNwJ2EYS6VTW47oDQaA6orBPZqd/bnn7Y0HDj7BPUjrsaxPqCYdTio5PYLfg4aj8ZOF7qFmSzBxwlX+QXBKgJf6pnUKR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100636; c=relaxed/simple;
	bh=W8sSGd3DOu4dlaaIRbN4pNaB/WXYoZyugu3aIyeSMas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUT2gN4OwRqqPh8q0Z1PoJCzYLkLa3fkU4HC+donrEtlBAlChe3xfOAtRQIrv7Dk419aE85YwbvQ6b2x+moYSnEyWR9eqFYA8OEaE9PUGJ4oVjAjUDjHPSd2jpMiLJExPpcoh/fhvHESbiqjclTRuPlRbwg5E20eAJ1E37W3pNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3WYO9J7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/VaS/zF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NppdOpxaoe2zPIqJ6mIEaou+D+Y+s1PgCXxaH7Okx+Y=;
	b=H3WYO9J7r+mmJOFeLBpxElk6evq4e4e3ilpPtTHYgmpw+4wJnLROsVEVkultpC9j3j3Sb0
	FUp7kfWrazQa1zvSGMr+Lgo8d26syMOt7t1PjsfjcATEMRDHrcPC/b82sj/RJoMFOnmXyk
	TnIurDyThShXxxbzJK9vZD6Z7wOl2b1ymYUJkgJHMxgauu0sb5cu6M/uIgEFDU+39JO42B
	IjI2D5gxzNIFDhGrNBnqux9lQIHUrJB8GC0eLhDAnAixQ7Ol+47u68vpnE5uRreeIE4b9O
	Eh3urWcnZEtPM6YwT5ro6mkxuc6JU/Y9F2fGs0dho+lzN7OZ6j/Jw9uZ+f81hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NppdOpxaoe2zPIqJ6mIEaou+D+Y+s1PgCXxaH7Okx+Y=;
	b=Y/VaS/zFUvIANDBwxw6fmH5Z15xuhQUdGoRB3Ogv25nhychWNHh6Y2nP8F0Wsh/vDOVS5w
	mcbnrOPh1GPP4yBA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 14/21] net: pktgen: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Mon, 28 Oct 2024 08:29:33 +0100
Message-Id: <e9d9ef31d1b443e358f5f3c50f7dbeda1ed2c0dd.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced function hrtimer_setup_sleeper_on_stack() which
will replace hrtimer_init_sleeper_on_stack().

This function is the same as the old hrtimer_init_sleeper_on_stack(), but
it was introduced to keep the names consistent with other changes with
hrtimer.

Switch to use the new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jakub Kicinski <kuba@kernel.org>
---
 net/core/pktgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..7e23cacbe66e 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2285,7 +2285,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t =
spin_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
=20
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	hrtimer_set_expires(&t.timer, spin_until);
=20
 	remaining =3D ktime_to_ns(hrtimer_expires_remaining(&t.timer));
--=20
2.39.5


