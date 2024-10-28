Return-Path: <linux-kernel+bounces-384337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D669B2935
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A4F1F2123A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FA1F7551;
	Mon, 28 Oct 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxZJQMxm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUeeXWSS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC21E7C1A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100941; cv=none; b=slSvoN+iMIGzs7DrGndfVmmpCVXSk5CeBRC/j4M1rVaCCNFMZhs89herOg3z7qq1acj1karT8wKv92rwui7YO7UBD/QqYcLLxiTLgmJr8Vp3Ep0eA6zeYa59VclXngpcI+jjmjKyAeT9aik2y6yRf0ij1Cgek8Q7kI+mBc59Llk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100941; c=relaxed/simple;
	bh=XyDLzycutE3haSnlwMMFjd/eXRDfpKNC5x78QccVAnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LwAhPeQCm/LJBvUXF0PpBJc0RCaCa04hzTksWneqQfQslWYpGZyil0IzJhnPT1Z9UZsQvM0vRrfsFlf0+Y0/CNjgCf5pwuHZDFHciRNFA9xTCNeeF6vkf2bfiKJdtadGMsMwmhTw0krPKetCLh6iG5ZzMZlIUQJy/01xdzPGsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxZJQMxm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUeeXWSS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNvhzJvkORL21CY5jsD75ElrQToYLN+MvRbU7d88fDs=;
	b=cxZJQMxmnZPgnrXiCh+hwIfVrMMQ9DiOdgZnxMWjUtSthX8ZVCjaM0Wa64RNXRKU3YG0bl
	+8hyeAH/cN0IMrbR2ls/sd3uR9AGCil2R4p27TXUSKn/sYKvB1d7w4cLFW03TsdZJlorkc
	6DFgL8OwnZVKE94wyZJTTaYXPC7T08Yt/G2DcloP319obc5gVtEek9hYRgg8hbz2n0DlPy
	h701bXrsPczcob9S9pWcgcCli1N80TxmpHX6/NjrQTi4N4LghXfw4raYzr3WkOK4ySWanm
	dnWfh59LHWtTsKTMPJGfWgQMZXw9uS/qrfqimZfHGm+qSFLEXOm6fOIAkSJb3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNvhzJvkORL21CY5jsD75ElrQToYLN+MvRbU7d88fDs=;
	b=bUeeXWSSCxxxkgHySzzMBOVcDVKB776tTdGKSXLOQx7y553Td0CXQGa0NrbpvDETpcnQBm
	tkqXPqWFnU2+6VDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 13/44] rtc: class: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:49 +0100
Message-Id: <558650cb8c501ba6ec3f054e9173701f493a2ae9.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
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

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e31fa0ad127e..b88cd4fb295b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -240,8 +240,7 @@ static struct rtc_device *rtc_allocate_device(void)
 	/* Init uie timer */
 	rtc_timer_init(&rtc->uie_rtctimer, rtc_uie_update_irq, rtc);
 	/* Init pie timer */
-	hrtimer_init(&rtc->pie_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	rtc->pie_timer.function =3D rtc_pie_update_irq;
+	hrtimer_setup(&rtc->pie_timer, rtc_pie_update_irq, CLOCK_MONOTONIC, HRTIM=
ER_MODE_REL);
 	rtc->pie_enabled =3D 0;
=20
 	set_bit(RTC_FEATURE_ALARM, rtc->features);
--=20
2.39.5


