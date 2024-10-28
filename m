Return-Path: <linux-kernel+bounces-384341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA49B293A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF3A2817E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15B1FF5FC;
	Mon, 28 Oct 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StYj46Fi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pznUBsi7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C461D9329
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100943; cv=none; b=rVmLva4c319zASRLixTfl17HcgyBvIjOlr9ZM1wjnLfPEFe5vDoYDj0bCUN/4xQA+QS0b5hMA89BJ2YO9enKFFiuAD3TF45FIuyHcj316Rbtrxg0oa4T6ey7SZBnZLUQiJffJ5oOEa3mOZj0U4gyLtojALMfIQSjiPDABI3ScbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100943; c=relaxed/simple;
	bh=hSmVDB9s3opYUP0w5UY+8MvpT15czToBUrWu5deqcY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMRYZ2lv9ZgsMr+dXLvTlMWEa2d9aGT1ik84xVNKxkg3byL4h1DNFSUS2szPoknwRC8P93GVAti3U4F18qcr/Hq2kKJL9Vuq5OZI+kNAcb+EImi7T3a0Mj9TxfBh6lHSnbMZv1kyhimOSn6hpwRLwYuM7OAXQptyObakvyJD/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StYj46Fi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pznUBsi7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/BI0j8RPfznxjeHNdSm9jjPqIqDQjfttM8HSUkmB+M=;
	b=StYj46FinBqlAgQ+A1/ns0QJFX99k/K8y0SMMFbwgcsuo4fL2w2/q6euiJiEmXQgNMG7AD
	+DYUC38D+IYQqVyO+X2+dRIjIaOnBiYpUXULMID5fH+N9IJdpyvY/56FKc4ao1AgMJir8h
	PAQX4BtP6CiGlFWXSrLZmKKgTZCF8jI3/BeZh5bncII/JKbwTRDsWjxUPE10yWVmtbzNbZ
	bY1910FrkHnE9utFzWY2JfwT2brpifUWSW9mPWdGm9tiKPvuvwZRUdKO7+xClXlPNERwU9
	wOfqq2DSCT6CKWVfD4tf8DFvAjJRlLPhsvXhZYfPK/dk4pRqzDDDK1ILeuKylg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/BI0j8RPfznxjeHNdSm9jjPqIqDQjfttM8HSUkmB+M=;
	b=pznUBsi7aQ/8Vp4jefHOp8iSPGxW3fG4fjg2Ng3895iuQbzIqY0BP8fqA6eE3PCsgftHrM
	88nsalIZbVfKtVCQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 18/44] drivers: perf: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:54 +0100
Message-Id: <663c8175de33876af637e2934241967557ac2cdd.1729865485.git.namcao@linutronix.de>
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
Cc: Will Deacon <will@kernel.org>
---
 drivers/perf/arm-ccn.c               | 5 ++---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 4 ++--
 drivers/perf/thunderx2_pmu.c         | 5 ++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 5c66b9278862..716c14da5564 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1273,9 +1273,8 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	/* No overflow interrupt? Have to use a timer instead. */
 	if (!ccn->irq) {
 		dev_info(ccn->dev, "No access to interrupts, using timer.\n");
-		hrtimer_init(&ccn->dt.hrtimer, CLOCK_MONOTONIC,
-				HRTIMER_MODE_REL);
-		ccn->dt.hrtimer.function =3D arm_ccn_pmu_timer_handler;
+		hrtimer_setup(&ccn->dt.hrtimer, arm_ccn_pmu_timer_handler, CLOCK_MONOTON=
IC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	/* Pick one CPU which we will use to collect data from CCN... */
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn=
10k_ddr_pmu.c
index 94f1ebcd2a27..12ee0971b6ee 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -677,8 +677,8 @@ static int cn10k_ddr_perf_probe(struct platform_device =
*pdev)
 	if (!name)
 		return -ENOMEM;
=20
-	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ddr_pmu->hrtimer.function =3D cn10k_ddr_pmu_timer_handler;
+	hrtimer_setup(&ddr_pmu->hrtimer, cn10k_ddr_pmu_timer_handler, CLOCK_MONOT=
ONIC,
+		      HRTIMER_MODE_REL);
=20
 	cpuhp_state_add_instance_nocalls(
 				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index faf763d2c95c..769a088c8747 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -752,9 +752,8 @@ static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pmu=
 *tx2_pmu)
 	tx2_pmu->cpu =3D cpu;
=20
 	if (tx2_pmu->hrtimer_callback) {
-		hrtimer_init(&tx2_pmu->hrtimer,
-				CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx2_pmu->hrtimer.function =3D tx2_pmu->hrtimer_callback;
+		hrtimer_setup(&tx2_pmu->hrtimer, tx2_pmu->hrtimer_callback, CLOCK_MONOTO=
NIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	ret =3D tx2_uncore_pmu_register(tx2_pmu);
--=20
2.39.5


