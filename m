Return-Path: <linux-kernel+bounces-384357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861ED9B2948
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B621C217EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019E20262A;
	Mon, 28 Oct 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKlA4hCW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2XRLCu06"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E61D959E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100948; cv=none; b=DNY+BSgFBdD4zdZt4DyOEqle8vHoSRr60iR62AnnmRvWst62nhyjQSPKJnSiL2DtgZQmaPBlfDJ0uLULsNehOPh9Ia7QdlqxaJ6zPWNVSomRMe6oE4aR90tB1rMk77PziKUJK7NGLPdjNtW8M4SR4qIFsS21WGH2PdwBX3FQ54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100948; c=relaxed/simple;
	bh=PAgFHu0Asgi4dB6XXNFVWXBQkZak9/WYPuGFM5/xz6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEtHF1qqjq9bimLGxFc6PyY9tFDbnr30KGgO+QjCyN9oJDBGC9M1KxPr0ch/XlykMD49iR5im/gHkYWxm6ZYDUSgJqvXC8tHrQ6+VZVawST8FD1Ts8DC72xS6Hth6g/IHdCoe1QmS16QV5tj4N8kpaq9WgdtPw2SSn9cK8+3d3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKlA4hCW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2XRLCu06; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yfx4w0eTC0A4FJ0ettAAD2eMSeGPaC/JFUMPU2GvCA=;
	b=kKlA4hCWY4n04CZUrP0qavj3M85fqvpUyVjkxm4dwc+biD8ay2ItRhXUNBOG4z1kj+zWug
	s+HNrs6WQ0E20f7jY460VWlAJop65+od1DHxnI4K4drXBibS008xLiXJJXZUEGPK1L5Djx
	pOZ+usGVTQzkAp+3+uqGXuTXSBc1fUPcrnHZoil87G/+1csivqwa5YuT69fG1R2gMPehij
	TDWi+weYfr0bzGK8RZtIe8HowiWXcHVvv9LZ7OAAiJC9PsvSwpiiiRUe08o/dwoqGlYbzw
	mgpZZxpm/IENKx8tNF6JyOPjyse2zmEt3WAjV3OoNECJG1mqRiYqLA54Mmi/7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yfx4w0eTC0A4FJ0ettAAD2eMSeGPaC/JFUMPU2GvCA=;
	b=2XRLCu06QnDW2ewnovqTDrfEfrQm4gsiGp0gpMxn2OVqZkhfG5Tpxgp0yQpLL5YhomZoh3
	A4+UhVENfh/vAhAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 31/44] drm/i915/gvt: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:07 +0100
Message-Id: <a88a637f77c3568b82cb1dfd47c37ba5e61acd8f.1729865485.git.namcao@linutronix.de>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/gpu/drm/i915/gvt/display.c      | 3 +--
 drivers/gpu/drm/i915/gvt/sched_policy.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/display.c b/drivers/gpu/drm/i915/gvt/=
display.c
index c66d6d3177c8..0e80251d2666 100644
--- a/drivers/gpu/drm/i915/gvt/display.c
+++ b/drivers/gpu/drm/i915/gvt/display.c
@@ -575,8 +575,7 @@ static int setup_virtual_dp_monitor(struct intel_vgpu *=
vgpu, int port_num,
 	vgpu->display.port_num =3D port_num;
=20
 	/* Init hrtimer based on default refresh rate */
-	hrtimer_init(&vblank_timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	vblank_timer->timer.function =3D vblank_timer_fn;
+	hrtimer_setup(&vblank_timer->timer, vblank_timer_fn, CLOCK_MONOTONIC, HRT=
IMER_MODE_ABS);
 	vblank_timer->vrefresh_k =3D port->vrefresh_k;
 	vblank_timer->period =3D DIV64_U64_ROUND_CLOSEST(NSEC_PER_SEC * MSEC_PER_=
SEC, vblank_timer->vrefresh_k);
=20
diff --git a/drivers/gpu/drm/i915/gvt/sched_policy.c b/drivers/gpu/drm/i915=
/gvt/sched_policy.c
index c077fb4674f0..9f97f743aa71 100644
--- a/drivers/gpu/drm/i915/gvt/sched_policy.c
+++ b/drivers/gpu/drm/i915/gvt/sched_policy.c
@@ -286,8 +286,7 @@ static int tbs_sched_init(struct intel_gvt *gvt)
 		return -ENOMEM;
=20
 	INIT_LIST_HEAD(&data->lru_runq_head);
-	hrtimer_init(&data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	data->timer.function =3D tbs_timer_fn;
+	hrtimer_setup(&data->timer, tbs_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_A=
BS);
 	data->period =3D GVT_DEFAULT_TIME_SLICE;
 	data->gvt =3D gvt;
=20
--=20
2.39.5


