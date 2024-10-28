Return-Path: <linux-kernel+bounces-384321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94099B2925
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF4E1C214D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA31E0492;
	Mon, 28 Oct 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDSGQAN0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByjsyEvY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDA1DF73A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100897; cv=none; b=IXd9pGWIWumwJ4NWEIZyMZokN7x4c9jH9z+3Ruc8QxyulDlygL9lmCpwVUyCeUax4UYxsSFdgoC2roXE2OvUivev+vrKFb7KKvDb2WCm+lKmcOPY0qkztU8JJ8L9UFSHUqd40NF2C7TuOiIlTKi9655thd6bNkX7szybSpJdyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100897; c=relaxed/simple;
	bh=VmkTmwcgVzhe9ycIhehKyPzkdH7l5VJ1pDloqDmkPdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryWdcAzjIFBRZj9m1ab8X9SCDNnVEHrfgYUUwQsRSXIQ2akzeH+cs5NaV+Tm660VG8u6X8XIl4yHPdJ7/MFPYAsraOCx05n8MTJh26Q0BO6venQgsQrwDuGMy2ztL66/tltLnQK1+wRr+DjxhPGj1QC5weh4nRE1gcdft2S0rJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDSGQAN0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByjsyEvY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB+IC+lNc5s7NmD1jfQf+sbexs+9okrxF59BOPlS5FQ=;
	b=QDSGQAN0HkM2VqQfPbSndPWtWIdQTgoA9uTrmVssH+7r2hXrVSDRXGvTQakt4pHgKN2H8E
	33gzygABLzKKmsDqm2+fhfW1JR0HSvas3/Rk4Ho580Ky8l9oJ2/iuTmmYGd8apX/wlitcT
	HRc/pIrVqiidcRrwJcU5Lq5quLyxBEZ9y1PUHpZ+xY1rpYW0AjJw6Rvj9KZuhYKUYxyfv8
	/F0yptGYWLTd/jbMpeRmeD9kzTlpcKsHfqNOYrQMBOGbiERkWeCXFH5CK47dqCPpoX1IsX
	Ax2vyQrFnXa/gtpSlXaVFQVdjSJCoJeuPvymgVAGyy74xl6g9ncLTD28Dp++bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB+IC+lNc5s7NmD1jfQf+sbexs+9okrxF59BOPlS5FQ=;
	b=ByjsyEvYorV2rmcaG9/eXCel5BAzNPJ2rS4gcdSw1F/fmo/sOZAe0nap25pSyReTUbdXMD
	p8K3gwDuTVIo0HBA==
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
Subject: [PATCH 22/24] igc: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:35 +0100
Message-Id: <13545b09f6ce1a19db0dd3d66e8fffbcf0dc56a1.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 6e70bca15db1..dd5190a2a4f0 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7103,8 +7103,8 @@ static int igc_probe(struct pci_dev *pdev,
 	INIT_WORK(&adapter->reset_task, igc_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igc_watchdog_task);
=20
-	hrtimer_init(&adapter->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	adapter->hrtimer.function =3D &igc_qbv_scheduling_timer;
+	hrtimer_setup(&adapter->hrtimer, &igc_qbv_scheduling_timer, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
=20
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg =3D true;
--=20
2.39.5


