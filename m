Return-Path: <linux-kernel+bounces-384292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E703E9B28F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247031C214E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540A91DE2AB;
	Mon, 28 Oct 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hi82KPv8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HeFKQPF2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433911DC06D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100750; cv=none; b=iHiVVvkd6XaGwNnMud1pd4m2phYfsRIjYmeU19axGAqsX294Jx8l5fhwsddsgvP0MmSDHdNvFsSbs1oTgLxklxSe1TMjZDiXcHzVwYVztevtS/Jta5iJoy0i7WRK8MTLmLtbyOl9/DAfoCWlm+nSh9xoMWWndUluKSX80IOG9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100750; c=relaxed/simple;
	bh=DhzKvqeRZCgzCbPwGfMFRCarwmIz8Pm4aHmF+hZLuGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZ3ELFmcUfdJQAIu+RdEJUrHfsAIjWzbpyZdQHq9xHd1Y0EmaIm+xFOcxfyvjfelCLMlWN9A16amFbho9dVVlJXvDkM7prJLCNa7rGtuFM6FxdNxhwZux2rjQihb+irwFhyTJnMVXnUwBVE+RmM9r9wM20OH/2koNQOq7JcEirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hi82KPv8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HeFKQPF2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THd1owm8cfZMhPubsxWYL3gOzIIwc2BWgS1eTHuFjoY=;
	b=Hi82KPv8X4UZ2OFonnyARFwVMq5lc/hnISeV7L/nb76evvBlFF+bXr+cYdC8I0PwQjrcZG
	r3/9WzkKURcPJ6hntn4OM2HgdHf/MuCQO781+OApoadrOfCKEbYQzaUVMAchE5h8M73YYK
	4feOpPaqF+9kgKweD6QKvgZh+ShN5WtdOauT2KUXLJl+0SBcuynttrDzGa8MAqRqLfK60D
	2EXePBKcAn2OeuKtqSYyCaIB0SbhcFQzLgyOKZf64gj6iRNRpiWeZY6qzGYwcoF5EfGHAJ
	/sghbBm2Yc712GVqZ2hGz5EoZiBuwrSFszCg0sKP9Rbd4SJdBK3ffaPqirmvBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THd1owm8cfZMhPubsxWYL3gOzIIwc2BWgS1eTHuFjoY=;
	b=HeFKQPF2YyTRdZN0lVLuXPtnJuHmwZAjf/iubMmaITCOEI7laBRuKYANcQ2rxmioPsoxBv
	birnbG4HKqLBwYAA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 29/31] PM / devfreq: rockchip-dfi: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:32:02 +0100
Message-Id: <f32741a5ad67d4cee6323757f3b8108084127cd5.1729864823.git.namcao@linutronix.de>
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

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Heiko Stuebner <heiko@sntech.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/r=
ockchip-dfi.c
index e2a1e4463b6f..0470d7c175f4 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -642,8 +642,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *=
dfi)
 	if (ret)
 		return ret;
=20
-	hrtimer_init(&dfi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dfi->timer.function =3D rockchip_dfi_timer;
+	hrtimer_setup(&dfi->timer, rockchip_dfi_timer, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
=20
 	switch (dfi->ddr_type) {
 	case ROCKCHIP_DDRTYPE_LPDDR2:
--=20
2.39.5


