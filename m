Return-Path: <linux-kernel+bounces-384254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4279B28CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F712813C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72C1D0E36;
	Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BxPIdR2y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Pix/2IZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88710192B7A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100636; cv=none; b=ooRyYjw/TV6KDYECI0a6DU9wA2dm7fv2V0hemgsHZcX4HREpkUDDcZVpW3N5i3Sunx22e539u6z7NxdAu/gN2vzQfPsYfnckQikOZL9bQ/bTGyD6/pL4wBM+P1+TaFDrBMJUz62NvaUgJFpp1L4pfdu/wFJbNoMwgZyC5VmMKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100636; c=relaxed/simple;
	bh=71b5zUUJ/UGx5uVYhEk5oBVg4LyLSar6M9kLrnKWKcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3cFh7bRPvMIg65hlF51WOESuiMzcP+v+O65biC0hiD+LGXVNmCbdpJcoa/CkqSbWeEt/i14MdCaTEx9yO2GwbQJK0e5neEb8z4za2cgsigerLod/pQ2mMmRo+QOKVJ15mzpsVuzVj5eVMHEnIMUD77rB83XLgtyv06pP1vVQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BxPIdR2y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Pix/2IZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQ891FWRaeZntw5HFf5qoaiNenDTaKPknthYCbWCOSA=;
	b=BxPIdR2yTzlvpkfPdHE8QdI45SrMcVIxBMm+n7E9P5kexXHrw00lLccTyaj1IIH83SRt0l
	tcaI1EoeqSjGDBDMZ/AdF6w4HEEI60UZy05BB609A62oRNIA7Ydrbzx7S/OeuLZeuKS0Rk
	5+IEnOQPq3PV1GQHQ+SW3wH63mb1rRT5GTD2vqI29SruSWiSRC3z8Tx7u3clEC+wnQqGvz
	6temfRihbBuNakhVGjU7xjhqFsUUUvtDPYwa8ARIr8kt9maE8izCJqqQkErImYL0n1huM5
	vFexEC1HBXtGvQt4bd/Pb6yFmHljX2dyRCXwhKfWmO2gLoPKKLfWy7wITggX8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQ891FWRaeZntw5HFf5qoaiNenDTaKPknthYCbWCOSA=;
	b=/Pix/2IZU8PlJuERNfUAmg0fjEyWbLvtQ+CSqYGl6eMPmVhEw59NaWP0izkSJ9eJfoxUDl
	aUKJqm/ZiXNepaCg==
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
Subject: [PATCH 12/21] fs/aio: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Mon, 28 Oct 2024 08:29:31 +0100
Message-Id: <7748a432845a9748d3e8d790a5d08b8bbe3b4af3.1729864615.git.namcao@linutronix.de>
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
Cc: Christian Brauner <brauner@kernel.org>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index e8920178b50f..a5d331f29943 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1335,7 +1335,7 @@ static long read_events(struct kioctx *ctx, long min_=
nr, long nr,
 	if (until =3D=3D 0 || ret < 0 || ret >=3D min_nr)
 		return ret;
=20
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	if (until !=3D KTIME_MAX) {
 		hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
 		hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
--=20
2.39.5


