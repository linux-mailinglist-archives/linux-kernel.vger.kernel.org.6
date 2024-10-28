Return-Path: <linux-kernel+bounces-384311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC69B291A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053E61F21EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035281DF73D;
	Mon, 28 Oct 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejWBxQxo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAzsxZcL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E331D5CCD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100893; cv=none; b=C9MIHL8wFLAHme2I640jV8EtaNuZMRJhogwL29ULihLlED6XL8j1muOV+SrjRDHbuHzqrzzQ7ebsxqvrN0wKG87/NTIlM1Y5oV/p92z1RqnSFuiLAYaov1ASuR6Vf5POKWdAxZpzbws3ez3BbILjY+Of/SWo4wpg8zXk/Wkt/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100893; c=relaxed/simple;
	bh=gyrFNuy5vudjM1FLkrlB1tmDnkFne3GntyyK+xSUUIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFQSwYCClNdlVZjwXUHTcX2D88XWdu9KzuNJQ42Qa9snpnrDMYWQf6eHH2j+IReWYYvyIcqHajgAZGbT1jEOiZYCPVX4tEnFGKGxMEplU4R0d8Ram3bGS0WK2L1oiLj8gwDedPcWIdoH5qsvST9BRkebr8jDzPot3O/tdNXsFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejWBxQxo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAzsxZcL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGSlDHf/SBeslCdjprCChultehdciaufyoVKgGuOcx0=;
	b=ejWBxQxoFSyUBbDp8E5TOIjyyQYyabsnsZpnPL+gCVBCTNC0D45El141XjSx+baWWDyNTp
	tNi+2r/2oifi5Wv9mVZRH18Y7Bl1jZ/aITQe3cjps1IAipHdYhFwyEdS7UtMIuVBuDo+Bt
	lF1ConQdZRtZKyai4sXpA94A04LF0BBs/dlgPLoPuMHnLjNguGTSnhSNET5HHMYX0yBVZM
	oeralENlDHkiGgTOFfYQE2/OHiznXQ4ZrbPeWMKrmQf90URAkhN+Zg/PFMX8WVkBeHj70+
	7Z1pyd0tS09pYeOkdcqavEAwcBlA5AUShXGPikBd4vNajC4b+98+O0Tu8Sw1fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGSlDHf/SBeslCdjprCChultehdciaufyoVKgGuOcx0=;
	b=hAzsxZcLJRMYO0wcpz0/SjeD6fmVGj0W4UefWgxEil/NAsWN0pL5tkUHA6tCr5qGa3nlBE
	pfOPlCGuiG1tRHDg==
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
Subject: [PATCH 14/24] net: mvpp2: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:27 +0100
Message-Id: <9e05dcbb3bab1cf10dda5b5f0d4c8519f68f4efa.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 3880dcc0418b..03038402957e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6914,9 +6914,8 @@ static int mvpp2_port_probe(struct platform_device *p=
dev,
 		for (thread =3D 0; thread < priv->nthreads; thread++) {
 			port_pcpu =3D per_cpu_ptr(port->pcpu, thread);
=20
-			hrtimer_init(&port_pcpu->tx_done_timer, CLOCK_MONOTONIC,
-				     HRTIMER_MODE_REL_PINNED_SOFT);
-			port_pcpu->tx_done_timer.function =3D mvpp2_hr_timer_cb;
+			hrtimer_setup(&port_pcpu->tx_done_timer, mvpp2_hr_timer_cb, CLOCK_MONOT=
ONIC,
+				      HRTIMER_MODE_REL_PINNED_SOFT);
 			port_pcpu->timer_scheduled =3D false;
 			port_pcpu->dev =3D dev;
 		}
--=20
2.39.5


