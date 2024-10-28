Return-Path: <linux-kernel+bounces-384339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499909B2939
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E63728237A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575BE1FE10A;
	Mon, 28 Oct 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+I+5Euz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VdAryi5k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717111EF92A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100942; cv=none; b=VVPh5wJG3PMIlnecliY//ZToV81eQ7dA0fszRMOCwJpqdjRn88mW723f4UE+Ae6tiudCQZogo+Iphr7UYb4DXsjNSMUmgP7E1x25p1f/X0X2xdcgUX5sPg61Z7JUIaJkm1N6b0zRDyjMeXTfZ6XZdxRqibmq3svVeMPzey20uwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100942; c=relaxed/simple;
	bh=EPkvy45eVSUHipqlaDurGAp7pgrNaVpAtaQpHmvsqcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEk3Imtaw+Dim7Xn1W/B+ycsh+N2iJUCrnqmaFXJcnqqOwpioylfyce0L4hG4jqDLsBT71W+aQicr+IG+KWuuCB5KvgKDcapnFN0BYjsP16jV8PQWTYV5KqBAitokbJeaPsf9gRhfPfkQ6yJz9m1098LJ3koNYepOpLQ5SMJqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+I+5Euz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VdAryi5k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGO2/skIrnyTgss75i/snh3hyXg3vEmnpgGNi1VNx8o=;
	b=i+I+5EuzrRQFslV6/iKNQXuy7k43XcKFlcalosmFpXjtfIF+HUZST0kyfSelhtJhik14kw
	aCf/1hQkXDWD/GRkTb6nyBPD6Xw7xKUwY9bjuspV2dVl2CGQ2R9UkGUDLL1P57M1y2sRQ2
	1qFU4cRI4IRBAfSVMzTk5Re1T3Jwz1YJwKfRPpw79XG7pISOJjfWqFgRmNmVJWI2AXZsLt
	JdW+zAM58pxKej7d6LxnfQlZfZEHZSoXzqk/fQGPiCh3CZOvh+GA8t2pVlN9SY+J6qXQ07
	MLaBQuiZHM8BaCcLFMS1P2mmsvvj7u4kDxwyWLescWfyKVgon5cUZ9mTkoLl5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGO2/skIrnyTgss75i/snh3hyXg3vEmnpgGNi1VNx8o=;
	b=VdAryi5kUER5p54Sspq5OPV0Tb1Yi+NmTeu8UWfEIJjDfI6q22VqfAtSB6w1sEFgS9E7YA
	9Ao8a/uo2sOfHzBA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 16/44] power: supply: ab8500_chargalg: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:52 +0100
Message-Id: <f4e18d2fafd5a412626456ec3d5be427ad1035e2.1729865485.git.namcao@linutronix.de>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_chargalg.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/=
ab8500_chargalg.c
index 854491ad3ecd..56afd5d1f8c3 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1788,13 +1788,12 @@ static int ab8500_chargalg_probe(struct platform_de=
vice *pdev)
 	psy_cfg.drv_data =3D di;
=20
 	/* Initilialize safety timer */
-	hrtimer_init(&di->safety_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	di->safety_timer.function =3D ab8500_chargalg_safety_timer_expired;
+	hrtimer_setup(&di->safety_timer, ab8500_chargalg_safety_timer_expired, CL=
OCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	/* Initilialize maintenance timer */
-	hrtimer_init(&di->maintenance_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	di->maintenance_timer.function =3D
-		ab8500_chargalg_maintenance_timer_expired;
+	hrtimer_setup(&di->maintenance_timer, ab8500_chargalg_maintenance_timer_e=
xpired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
=20
 	/* Init work for chargalg */
 	INIT_DEFERRABLE_WORK(&di->chargalg_periodic_work,
--=20
2.39.5


