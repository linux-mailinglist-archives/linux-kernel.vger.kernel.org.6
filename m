Return-Path: <linux-kernel+bounces-384344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ABE9B293E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390B21F22244
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C646201101;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HO4fKTp6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1DA/IYkr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0CC1F428A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100944; cv=none; b=jO084vNEnGwGqLl3iflKju1/ylW6X5AdpvMYgYLYaTtvOdT3+3NEOZBDCHe9jr3IA8tVXhSOKk1gOhWyp80FyBLfE7e8q7wEUmsQ4/zeOTVpXsOW3qxJeAXJU64LikZwNySB6LMZnPuyTi2sdoU0tpTwswDD2Csee221uP6Gewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100944; c=relaxed/simple;
	bh=dfhV6QTj4uKGmAcfXlfFgeGsNNdxnJT6m4fdmZvkJ9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/vzfBwLCtVihV2h2pCGzzpIH6+UaIWFmFD1EyDKcp6HO229DFtUr38P5hvBxJalMCYBqIFoMMX896aP0hVNq0NM+eYExOGZ2E/1UqpPqUbrosgu9teH7g9DrSZ8MSl9g9RS29w1CftwwAnJBoAd1LRDw8sLznbnCSeFk+0TV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HO4fKTp6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1DA/IYkr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7SqXAyAu95z0uwouEaFv/TdsfEFGlIdHdkVNRvQbQA=;
	b=HO4fKTp6HmSoShxSHRM24sSkLFnkfXFetdwbF48uqlkmaO/x6KgBELbQARo+gvb5i1G3n0
	7EgGMNBX1VcWMTG0e4B0LwZYHbfmxvZpvLMujSBiUUp4/qdUIVq3dZfyEYuQzuBmgaCiu1
	7InviRAdSPaOyoPVS9TguXBDeD02f7aZRkP6TapJCQmM9UVx1IfKoq8nrMi/OmXSBWSGkj
	AoxdtyZMLGQcJHKPYve8ZMlvr0IinnTKlvFu0lhdBJPmx6WevtE3onF5nDXFW8scisArDc
	vUbTcCKuI5rwO35M2I5HVhB4DhQfFUxD0pRpo1GexpSybJm6T69I8WObAhpKmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7SqXAyAu95z0uwouEaFv/TdsfEFGlIdHdkVNRvQbQA=;
	b=1DA/IYkrTVrNbRMSQ8L+zA+U0OP0guimX9FekS9rUlgs0uWKtp9e53H9CzKo2F7yqa9B39
	WhzMdxSAWdwqieDw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 21/44] misc: vcpu_stall_detector: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:57 +0100
Message-Id: <c240a4d0e142a0942308a563c841a79f8e72d250.1729865485.git.namcao@linutronix.de>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vcpu_stall_detector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_d=
etector.c
index 41b8c2119e20..dea5f8290895 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -111,8 +111,7 @@ static int start_stall_detector_cpu(unsigned int cpu)
 	ping_timeout_ms =3D vcpu_stall_config.stall_timeout_sec *
 			  MSEC_PER_SEC / 2;
=20
-	hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vcpu_hrtimer->function =3D vcpu_stall_detect_timer_fn;
+	hrtimer_setup(vcpu_hrtimer, vcpu_stall_detect_timer_fn, CLOCK_MONOTONIC, =
HRTIMER_MODE_REL);
 	vcpu_stall_detector->is_initialized =3D true;
=20
 	hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),
--=20
2.39.5


