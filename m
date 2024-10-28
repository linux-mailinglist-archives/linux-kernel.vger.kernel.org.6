Return-Path: <linux-kernel+bounces-384349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A989B2941
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9B11C217D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4849B201246;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4zn/ctHU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DvOWG/1g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7F1FA247
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100946; cv=none; b=c3BcmCPdcoPsAYxhGkms/Z5dPcpoUoXTrOfOYmGs3mHFRK3YUGzjgqqW+nYkpTvbN/DGh6/3LyjyW4hBXJ4AcqUp4zOVm9OvOzces3e3IJAvWOkJ3RpPXbCZ8i11tH7aroeUf0GVkIh/rgQTJTXJT7wjLdQrAANtxmVNjM08JUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100946; c=relaxed/simple;
	bh=EdgLF+69z/CGFE2jZ9Kv7yN+UmZ7c70icomEwXkRQ9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFkRDTMOo87QQHWbb30ke8wM3wTChEZwcaD3tkB0CuD7O2nofMl/8Zfpht4XLx920j9AYuUhO15yXdfuXL91zzQ72HB5RSiXDyoGDSzgx6jkTpHTvn8ZyjOhY8RnIu6Acz6IKhBR3q28f7Meq3XBMC+GyoifXTpf4ItAZ6bhYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4zn/ctHU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DvOWG/1g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoiFWKtoup9C86Z8bmgOdqqWAr4blrjshDetktRQrH0=;
	b=4zn/ctHUBX+NmqStWfbTRIpcWnILuHKxV/jLudT8xN4Ntq2HnrNOzUSBuv3Lsas6nKXN6a
	ojw+BdaL596bVfsCJhNzdPcymj57hNUwrvKM4V1mQJKfpfPkZg+1YjDM38C+xMyZDidxIk
	uWXcwlpThiAKJKQ4eGeDHuOsXfy/lP4QXl66f9OrZoRoMUQcqLoPXeiJIkys5a6U94zOl4
	GS/ggHWDJKRbVeh4+TBbYEbpzCz84bxOY2e5e7BnrzZyigvlVQqlDmALyX4sL2eAETx4G9
	qOdz5WRVIB2h4o97eWQ7xCY2ly99VLz4i55fQ7fqk9OAmclR/Y5V8/ytREb/eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoiFWKtoup9C86Z8bmgOdqqWAr4blrjshDetktRQrH0=;
	b=DvOWG/1gPLjGi4wshb6/4FKcMQZgQQzSmB90eGQSQm6hPNsoqGqtDqS5kl2i7ScuYNiOWo
	aEDSev89j5advPDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 26/44] iio: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:02 +0100
Message-Id: <516b30771b0d627d6b7461611cbf476aa1fa0e6c.1729865485.git.namcao@linutronix.de>
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
Cc: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ti-tsc2046.c           | 4 +---
 drivers/iio/trigger/iio-trig-hrtimer.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 311d97001249..87c86d752293 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -812,9 +812,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
=20
 	spin_lock_init(&priv->state_lock);
 	priv->state =3D TSC2046_STATE_SHUTDOWN;
-	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	priv->trig_timer.function =3D tsc2046_adc_timer;
+	hrtimer_setup(&priv->trig_timer, tsc2046_adc_timer, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL_SOFT);
=20
 	ret =3D devm_iio_trigger_register(dev, trig);
 	if (ret) {
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/i=
io-trig-hrtimer.c
index 716c795d08fb..82c72baccb62 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -145,8 +145,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(co=
nst char *name)
 	trig_info->swt.trigger->ops =3D &iio_hrtimer_trigger_ops;
 	trig_info->swt.trigger->dev.groups =3D iio_hrtimer_attr_groups;
=20
-	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	trig_info->timer.function =3D iio_hrtimer_trig_handler;
+	hrtimer_setup(&trig_info->timer, iio_hrtimer_trig_handler, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL_HARD);
=20
 	trig_info->sampling_frequency[0] =3D HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
 	trig_info->period =3D NSEC_PER_SEC / trig_info->sampling_frequency[0];
--=20
2.39.5


