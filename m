Return-Path: <linux-kernel+bounces-384305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59509B2914
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E51628217A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF163192B81;
	Mon, 28 Oct 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xu+E1iXE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="53xYap65"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487A1D31B2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100891; cv=none; b=sZ17eVNIszoDzp8ZrKpq3DjvqMplsnv0LY/v6WaSVMCWxmWAlnASaeCL0XSMD+nMq46hx6KngRcuikJ/SPoZ0nsUlSc/JC2GDE851VEX9qy2nB8gQmEoWYc9gsALDHk49Zi8peZBXWICxe9vJC0wVrmQWcrupa2Imha4H5Cza0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100891; c=relaxed/simple;
	bh=Y+77rAFyJjr6O7/apVOnG8fQwHbcJe9D5sPzG/4Owag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZCD9gliUSHcj4BITgOnLCs+D7mkaHZDx/2/m6GdH3XSSAsMeheX2L5vU2+J/MCeWRXm51QQrT6c3+J56RR5uvyiSXFIYVfqV3fXx/SlU2ujFP0lXodSlvo+woWRjgEMRXLAwqgfc83oZF6i6/JlU46VgXWrK2PFOopk2msQrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xu+E1iXE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=53xYap65; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7uNKWBbzPWz95iDcacBD8fF+R+5w+Zgbamu/TqXvK8=;
	b=xu+E1iXEltSH0t9a/aUDFztFpYx0kvWVe1V2ANGuT8DOk2lEyjKkRtVNE+1lZm+DCe1fP/
	7le5QBFAoxxusTVpcv/A5EgSKe15t31lSU1LZyvktgN8CkTsL9HszF8rDd4lfqA4X2ZnrZ
	bi09bRZX84W26NVVSLvz2IsTdsnqVonLZRcSiIHugUHlnijloukxpLCXr4FpyQVrhsOI+T
	rQuzRooU/No4KDZ+75WYieVuMcwqMol9+EwHYgWE5ic/obKoAHgNIGX+gSQcwXaAJ5EOKH
	W3JpeTHHZR86CBAo6m9ENDfjhcvlmX0D1N5XJAcM6UhbrMiEHHNjQqMOrDhyrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7uNKWBbzPWz95iDcacBD8fF+R+5w+Zgbamu/TqXvK8=;
	b=53xYap658irjfX1tehZC26KfxX03emaDgTjD62jZOAudG0DZtMdp3k0R53iwt3mWaeJCp7
	fBFqWDYfuRdpCODw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 05/24] can: m_can: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:18 +0100
Message-Id: <16cb05a8163085445bd17b68ad54bb11d2b2c450.1729865232.git.namcao@linutronix.de>
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
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/can/m_can/m_can.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a978b960f1f1..183f6eceb7e9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2383,12 +2383,11 @@ int m_can_class_register(struct m_can_classdev *cde=
v)
=20
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		cdev->hrtimer.function =3D &hrtimer_callback;
+		hrtimer_setup(&cdev->hrtimer, &hrtimer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 	} else {
-		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cdev->hrtimer.function =3D m_can_coalescing_timer;
+		hrtimer_setup(&cdev->hrtimer, m_can_coalescing_timer, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	ret =3D m_can_dev_setup(cdev);
--=20
2.39.5


