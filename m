Return-Path: <linux-kernel+bounces-390744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6F9B7E19
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A681F214DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FBC1BD516;
	Thu, 31 Oct 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yxGAz47h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T17HRGfN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB519DFAB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387709; cv=none; b=qEJWbzq5xSCM37bpgbmXZSvSTyLh0VB6MBICm8g3aiw522LaY0e4eKeRvnOmaV6+ro3aj+FKPryynyjBBohKIuNp5kYaqpWmV1hb+f/7/aXAm6r07V6PcyoIggQkkNgG2RhtUxM7OyiRbDrv6ky8LzcsqPRXM1OKjPAc0lQ4Cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387709; c=relaxed/simple;
	bh=lyvWCRoP2a1MaCIJFFS+qPNDimT8IhKEbi3bTW86r6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gh0jI93mQmPvxltfHt4ObCDJgfz7CJxSBapEcSQo5Tf80nmRNHRlzthKPgONRk9qXPHA17CmUU5Fg4FAdKrrzohSLabiz2DLK0y4UitEoob3R8ve3M9cZylcCuoNbTKkukU3zuRdr29q3gOggAXIkVQ2MWzslC5nBE9nBPGD75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yxGAz47h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T17HRGfN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sns3owJJ1g5SJOVsE11NYeiKC9zvBohYSIHK9XSQxGI=;
	b=yxGAz47hg+xN1wnLqYFDctZ2sn9Ujw5ytQE1byQCTKcCfxbvp2DGHiP9362f2lr543az3p
	gHEgizXYWPK3s0NSUu5SS+zz1h/kVrDKUNgY4XT8k9OsO22/yFCS0LH+hWxXTRfF2CqCF3
	nCyFFqq0r8zU1rhVvbozVLJaMIT70alPfW/0OL2K6LSlbDSwON6WNujUAIfq6Hz9VZQCXj
	TlKyyaLvGs4fAFalzUFkUKB5jgHjlixFJEguZnMJOpSTLZ5Hs4rAYwmMp+rsQN1WynADDv
	o5vd5I7AY0nWrWZiR3Y0w1xS6VbzlQFIQDUx5jSw9GMzVIwi5zxp/Ay9x+KCtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sns3owJJ1g5SJOVsE11NYeiKC9zvBohYSIHK9XSQxGI=;
	b=T17HRGfN3sJBYQ1qOGf/HGL9R/XXGtOx7PITdK9zzn2j1JlHM0XCd+cbpxUPDYYb/qCyEg
	l6w7Q5w9hhyMbsBQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 05/19] io_uring: Remove redundant hrtimer's callback function setup
Date: Thu, 31 Oct 2024 16:14:19 +0100
Message-Id: <07b28dfd5691478a2d250f379c8b90dd37f9bb9a.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The IORING_OP_TIMEOUT command uses hrtimer underneath. The timer's callback
function is setup in io_timeout(), and then the callback function is setup
again when the timer is rearmed.

Since the callback function is the same for both cases, the latter setup is
redundant, therefore remove it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 io_uring/timeout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 9973876d91b0..2ffe5e1dc68a 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -76,7 +76,6 @@ static void io_timeout_complete(struct io_kiocb *req, str=
uct io_tw_state *ts)
 			/* re-arm timer */
 			spin_lock_irq(&ctx->timeout_lock);
 			list_add(&timeout->list, ctx->timeout_list.prev);
-			data->timer.function =3D io_timeout_fn;
 			hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 			spin_unlock_irq(&ctx->timeout_lock);
 			return;
--=20
2.39.5


