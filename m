Return-Path: <linux-kernel+bounces-384351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFB89B2944
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB51C217A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C92201255;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmQOg8uj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9fGD2tML"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AA1F5825
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100946; cv=none; b=KTMTiEzWjBIhMMfIbDB99fpMCg64O5EAKTsE7wSnXExlCJgOnyjO6qOp35/Hpts3mnu0OPnGIW9jFVEuW24MTG64qmTTtum6HoR2r+8DnDdFd+2dg1b9//91SRlJgyhlLnKWx6QcUtocivVnlmIxw/Ty8W98ImA1gURpyNaoPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100946; c=relaxed/simple;
	bh=sIBpB1p22LXxCTNhLBfRMNcuVXI+HTt7YVobMpwcZtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCKZdHbT+cLJ1WA5TBy4/Za6vwEjc6ar1DupR1T7CrMsDTy1kfnhhHM0oHxuBWgyY2P0NXpWaJE0AO7B4P3YjEmozOXeXkKqLe7rE+PDUhduoVGH3UDTs+mrajdgP5as7ssRPZAeIUGjR+zKA+P3MVijFXaIkIRP6wWsGmAHxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmQOg8uj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9fGD2tML; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AHiYiPcHPN4NENoHrApHqwIjUfPWMcojvq3BpSPvh0=;
	b=dmQOg8ujQcDbhqqKsSp/hryzktJfafLQ/o/r5SoJzMCFKJZPJMmdgO4kB9FK63VBHRSPVm
	CoQhMbO9uX3/X7nzxYbCtyWZaViFnry7/Kqm+NCvpim6opmjZk4LjF1N8aApdLDPE72bIz
	BdHIOBVno12DBojzVjDwCbbl8/lDuhYivV6PBgdiTOzz6+NsPPeTY4pYvF0q+4hoHUpOtx
	FNcBbok+Cp0Zlxbb7fRetQiEPB6Hr7v7H5y5MG76gJu3gvUTTTaK+bRW9VeNzTP9RxMYKj
	Y09xonR028ERO2Lu5uFVaJlKNftETs7rRwovRHjm1zLx3vBm0joZ/Eseq6v03A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AHiYiPcHPN4NENoHrApHqwIjUfPWMcojvq3BpSPvh0=;
	b=9fGD2tMLYTT05ljSErBZfXPDB6lXyYTps8CySEjgjhjsAM50EB+LHuUEG4mdwspxfJNE4j
	GZqicrG7aQAYooDA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 22/44] media: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:58 +0100
Message-Id: <2290f8a566605247d9842575dc3e6a630a1c1a72.1729865485.git.namcao@linutronix.de>
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
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/cec/core/cec-pin.c                     | 3 +--
 drivers/media/pci/cx88/cx88-input.c                  | 3 +--
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 4 ++--
 drivers/media/rc/pwm-ir-tx.c                         | 3 +--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-=
pin.c
index 330d5d5d86ab..fe1cf365a25c 100644
--- a/drivers/media/cec/core/cec-pin.c
+++ b/drivers/media/cec/core/cec-pin.c
@@ -1345,9 +1345,8 @@ struct cec_adapter *cec_pin_allocate_adapter(const st=
ruct cec_pin_ops *pin_ops,
 	if (pin =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
 	pin->ops =3D pin_ops;
-	hrtimer_init(&pin->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	atomic_set(&pin->work_pin_num_events, 0);
-	pin->timer.function =3D cec_pin_timer;
+	hrtimer_setup(&pin->timer, cec_pin_timer, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL);
 	init_waitqueue_head(&pin->kthread_waitq);
 	pin->tx_custom_low_usecs =3D CEC_TIM_CUSTOM_DEFAULT;
 	pin->tx_custom_high_usecs =3D CEC_TIM_CUSTOM_DEFAULT;
diff --git a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/c=
x88-input.c
index a04a1d33fadb..b9f2c14d62b4 100644
--- a/drivers/media/pci/cx88/cx88-input.c
+++ b/drivers/media/pci/cx88/cx88-input.c
@@ -190,8 +190,7 @@ static int __cx88_ir_start(void *priv)
 	ir =3D core->ir;
=20
 	if (ir->polling) {
-		hrtimer_init(&ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		ir->timer.function =3D cx88_ir_work;
+		hrtimer_setup(&ir->timer, cx88_ir_work, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
 		hrtimer_start(&ir->timer,
 			      ktime_set(0, ir->polling * 1000000),
 			      HRTIMER_MODE_REL);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers=
/media/platform/chips-media/wave5/wave5-vpu.c
index 7273254ecb03..d7795d7f8a35 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -229,8 +229,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	dev->irq =3D platform_get_irq(pdev, 0);
 	if (dev->irq < 0) {
 		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling=
\n");
-		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-		dev->hrtimer.function =3D &wave5_vpu_timer_callback;
+		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 		dev->worker =3D kthread_create_worker(0, "vpu_irq_thread");
 		if (IS_ERR(dev->worker)) {
 			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index fe368aebbc13..84533fdd61aa 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -172,8 +172,7 @@ static int pwm_ir_probe(struct platform_device *pdev)
 		rcdev->tx_ir =3D pwm_ir_tx_sleep;
 	} else {
 		init_completion(&pwm_ir->tx_done);
-		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		pwm_ir->timer.function =3D pwm_ir_timer;
+		hrtimer_setup(&pwm_ir->timer, pwm_ir_timer, CLOCK_MONOTONIC, HRTIMER_MOD=
E_REL);
 		rcdev->tx_ir =3D pwm_ir_tx_atomic;
 	}
=20
--=20
2.39.5


