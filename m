Return-Path: <linux-kernel+bounces-384332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA419B2932
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB11C21624
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97121EF950;
	Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MP+wdI4H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XLz+QnqC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403631D8E0F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100939; cv=none; b=B3yxYadhe+F7NWxNtHMxdXGEivkphpD8Ct93oBwTPzrdV5oYDaYxetOKAM6jbYzEmLcsOA6YsiJ/zqIdg7bvh0TDiw6jmtA4Iclkpy87Spmnf5W0Id1CAlAcfQxly4aNmRlWHlKLsiOKuAtZ8D36nzn5km4mTsdDA0ceaWRM7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100939; c=relaxed/simple;
	bh=UaYxAumF596mIKmZqycLpRWoB173w88RHVYNzv7Ytgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awHg+HThoWja9qgT8NlJCROIfEQu6y2xizLpovbKhCeQN/ggCW5M9PoKdMmo9lRDfAPdmjr/sNZQBlDPiTMZGxszmWPVaG8AHb5v+6WHUHFfY2MbPAKAIZ86oCL/1ZpjhdCGm9xzPBwfCcL3iY+s5y8HIj1xtogJFWCxEELfSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MP+wdI4H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XLz+QnqC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhW5CIf5rCBS5Mqnn3c+MLTZGdB9bw1qRERMonk4LY4=;
	b=MP+wdI4HVSxDO1UKJirOUN4ncC9hqP502lX3iduze8QA7FittXropIAgJpxCAB587K5yyt
	vDsn98v0rml2ZbOsdSZ1fajjD7iJ45e/e0pzMJMqRgP+RzF5alhUvQhDkyEKEnUcV/g0ZG
	igCh0F/+dRIVV15qL642OaihS/Y0f8T0Zzx1EWi57DpehD+2+bL2PVDvDaE5yqy8EQtRxU
	KiBipLI8yeKZwdpJtbKldmFpZuxuOfpW66oXZ8Q2hCZFF4qR9e6STKwXLf1z5H7rzHSn3a
	cVGWgwrFYdn4gmFI0glFx/9a21U4gQJXiZgtVM8px1dSAWmwG1qgeC1EPYydhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhW5CIf5rCBS5Mqnn3c+MLTZGdB9bw1qRERMonk4LY4=;
	b=XLz+QnqCQSqWBPmDOFkLXEH4QaV1wWl9rOiDLXO9QrCHFXMsil3xcNw1Lgat+kOMu+hzgK
	howd0J1YLTNDShAA==
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
Subject: [PATCH 07/44] usb: typec: tcpm: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:43 +0100
Message-Id: <6db894f0aff57181987d7754ad315883a046bca5.1729865485.git.namcao@linutronix.de>
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
 drivers/usb/typec/tcpm/tcpm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index fc619478200f..48ae73033972 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7587,14 +7587,14 @@ struct tcpm_port *tcpm_register_port(struct device =
*dev, struct tcpc_dev *tcpc)
 	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
 	kthread_init_work(&port->enable_frs, tcpm_enable_frs_work);
 	kthread_init_work(&port->send_discover_work, tcpm_send_discover_work);
-	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
-	port->state_machine_timer.function =3D state_machine_timer_handler;
-	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MOD=
E_REL);
-	port->vdm_state_machine_timer.function =3D vdm_state_machine_timer_handle=
r;
-	hrtimer_init(&port->enable_frs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->enable_frs_timer.function =3D enable_frs_timer_handler;
-	hrtimer_init(&port->send_discover_timer, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
-	port->send_discover_timer.function =3D send_discover_timer_handler;
+	hrtimer_setup(&port->state_machine_timer, state_machine_timer_handler, CL=
OCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&port->vdm_state_machine_timer, vdm_state_machine_timer_han=
dler,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&port->enable_frs_timer, enable_frs_timer_handler, CLOCK_MO=
NOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&port->send_discover_timer, send_discover_timer_handler, CL=
OCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	spin_lock_init(&port->pd_event_lock);
=20
--=20
2.39.5


