Return-Path: <linux-kernel+bounces-384309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9749B2918
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF871B21B23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7D1DF25C;
	Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOw9pOes";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wMaklpl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CA1D365B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100892; cv=none; b=elobQy4RIIcSlgOadQ3BKE41U5QXz+WhrQBDUuCSBJyhD1+fDvyt8s4X5LHDhPe0Oq2ofiahwwdKg/98Izqyouf/OYAL+85XcVI0ELzCWTu8LPIuHP72021ayUtRE3yzWcEJ2J0N9PMSilfTTO7g9Gddi8lP1ejFZ1HJxBKFISo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100892; c=relaxed/simple;
	bh=rzqrdnivDl97wmegK5ckmhXV74XxLo/jUNE1guP3qvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDNyo5AwRamDE+4R+7eHk9t9dh9g+aJc2no6UwidZsh+6gW837W2pLyBlHSwAxXny9Hsg06ZGccvKxa6JWxLX7JW6v2K5tMdV/F9Agfxmy+sCZjjsH639hHrPQc02GjwtgOMbi4FlPiekbZTRk+bv16HAGnUeZUF8Xq7Wje/4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rOw9pOes; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wMaklpl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFc6mraY/kK+oDpjLr7TplQK2q1zRBQUEBNW6Bb6d90=;
	b=rOw9pOeszun7xyHx77M1vd7OfvPAAb4mi9R/V8GgHxXz+DMr7imJteS44nUqg1cgevvc5t
	4KYTDOcJN4dPTFEMZLKTGJYK/Fxwu8gEq2cpGYj6D6wOfdwilgekMNWliLay9+d93iRcMe
	l43jKOwRusszACWziSPp+A1+cZH16IKPIEkkSw2egcRLYAvub7gGeEzkWTGba7HI1ui9rS
	HSQJiIBqUUTocCewUjJMPDBoVL9ij3Nzhm+VN/TnidSR2lSyZHlhPy/XCryqokclbODjgF
	kgIcYanROUojxvwgfQuOn1MjKjvzitNjrTLNt14I6F2Og7J8GT2BYBD5CUyh2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFc6mraY/kK+oDpjLr7TplQK2q1zRBQUEBNW6Bb6d90=;
	b=2wMaklplQGgt+gpHV2JJSe+Y+NE3iJbct8EkTTlE4nFVf6TcORd+vf2RORXMdlRwdvSeuj
	hyuPTrzOWmwQqpBQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 10/24] net: ethernet: ec_bhf: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:23 +0100
Message-Id: <4e703b61cdfef59049291a6c3a8558f0ac432409.1729865232.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865232.git.namcao@linutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
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
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/ec_bhf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index 44af1d13d931..67275aa4f65b 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -416,8 +416,7 @@ static int ec_bhf_open(struct net_device *net_dev)
=20
 	netif_start_queue(net_dev);
=20
-	hrtimer_init(&priv->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->hrtimer.function =3D ec_bhf_timer_fun;
+	hrtimer_setup(&priv->hrtimer, ec_bhf_timer_fun, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 	hrtimer_start(&priv->hrtimer, polling_frequency, HRTIMER_MODE_REL);
=20
 	return 0;
--=20
2.39.5


