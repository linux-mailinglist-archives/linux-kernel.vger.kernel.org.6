Return-Path: <linux-kernel+bounces-384271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C809B28DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4713A1C213E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542671D9668;
	Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3nlWm8+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3Z+Qkq9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69831192598
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100743; cv=none; b=KPF2PNEA2xVDMEZQUiwiQBLEJ7O8Mrn/7XFKlLpRN3i/IKosMT4tUury9QGq4IX8zXzAXlPKtoxBBsY1hhQGJElSKDtUUpC63cesBJwryw1hXLJmZ66UcadQrMzZaT82em+KScW4qtcj3NRZQMqQM7Yk8vINj2sL0hB2YyHbNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100743; c=relaxed/simple;
	bh=LXpvU1UUt7B3sh4Trxnx9NpWLLGwl3SdmlEwiVkDrs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRoySOqOTSEpxg4n/YOM35XxzKXUfJ7wv40okXWm98TVh8BpInpsg6tfNwapQOssF5J+ChWGeqXBnwUQy+XIaHjbGCrELIc8n8ltAhXduMgBl6deJ67BWEWi44YI8O1oYZVd8nWacT1eminQ/KV1kUj+b1iJYgolLvIoMCvcqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3nlWm8+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h3Z+Qkq9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrfT+2lc1VSoJ47yhkWIvgcQ4dSCLxfio26mAKCAksE=;
	b=O3nlWm8+DkygHkHQCATfcz1vLNFbXzKJbDkkSuCz1r/eRhWcCK/7oskJPrcw5xDjW8F08K
	VSOson6hRMjY+3olXT5nNdps9b05iU99/zrVkRYekKcDptJ1p92U1Digwhvfp5FUnXUDvf
	MatTD7DSUOJzlB++G+so/SWBXoVp03biazLMyFHmHI9dePHK88w3wri7UIgU8tCvYhpdYm
	aUGJJQsI7+a6KmpwxLZ0LIbFYocFZMO6o1XUUAF26LdNes9loxHC0BRpaIUl/g4ygf2TRR
	kLPhyFt9ve2x+Mn/pkW8Bg+eGyoXROSK23IVgQm/QkUbrLMhTYAOkuk1qkc4Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrfT+2lc1VSoJ47yhkWIvgcQ4dSCLxfio26mAKCAksE=;
	b=h3Z+Qkq99Xgf0uS7AerTofTATmO1m0I44Fig28vA1CcTxYtFmJPHSDruhcDupKzHjZqEgB
	J3Xb3sL0Jg0FU7CA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 08/31] ARM: imx: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:41 +0100
Message-Id: <63ef9ac46df5156bccc35b0a907431be49d0b055.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mmdc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index b68cb86dbe4c..a568b5e15dcb 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -509,9 +509,8 @@ static int imx_mmdc_perf_init(struct platform_device *p=
dev, void __iomem *mmdc_b
 	pmu_mmdc->mmdc_ipg_clk =3D mmdc_ipg_clk;
 	pmu_mmdc->devtype_data =3D device_get_match_data(&pdev->dev);
=20
-	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-	pmu_mmdc->hrtimer.function =3D mmdc_pmu_timer_handler;
+	hrtimer_setup(&pmu_mmdc->hrtimer, mmdc_pmu_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	cpumask_set_cpu(raw_smp_processor_id(), &pmu_mmdc->cpu);
=20
--=20
2.39.5


