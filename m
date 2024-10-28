Return-Path: <linux-kernel+bounces-384306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D59B2915
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC40B22209
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710C1D7989;
	Mon, 28 Oct 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3z9JEsN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxFHg79Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6861D3644
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100892; cv=none; b=tpmvdwsffzdhX3nq8XXKYCgwVxIUxLY+3CX4C9GRS1va0yEGWZVXJuP3AX01DbsC43bo0lX7Zp9iLOTMjo7L0YC5zWZu/vKhq1RkXI4XEcHZWCiqr6+1jlZN7NC9Juppc0nVknjR2tbOQEpnKWXvYncMWHfQUTdjTrRpbJuX9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100892; c=relaxed/simple;
	bh=AyFqTh/LTXdnFtVjfZsqUZtU1Ntr6JSA0nB/tk5Lovw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UplzCvNBV0FoHt3zjgX4w5mfLp/p2nSBe9UGWFlfE2yaauIomskRmG/H7wA5t22mOB3dfW+yAley+XVXgmCnFvygw7WhW4Om0lZgAwv59MFEaOHZc54J6DRyCdksocnjCZkxp0B3ROAv8TeaadFYoEZzRqOH3o+ZE86UNu7M19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3z9JEsN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxFHg79Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fM64bpc0cXbY46rFUm7HVL20B9YCPcyUvXqkWIDluk=;
	b=b3z9JEsNl8p0Cnn4U5Pur9IjWd7HVUU4nB/We2YjA/aHythZx1TTGOu9sD0v6zikGapx3b
	MmTkcatUQ7Op0Aesy9TKbWHKvhdBuSKd586SmS9+bEM9ysEvIC2LNFIgWAy+ztKqxMtY2+
	3Z7PzmC48AtCEzc430aLeTaK6USo5pY0lQFu2/BbF6wd6OtQ4SVN9jQn2pWntrLvgXgDAs
	h5yGRNJU4zbWmVUhZKQ6WFPZIxjSRT124nWosI3F/3M+PQy01UQMQC3GsBbytDApSNVQTm
	YUOOffs7AzahQha2olmjWTC+zQ9ues56lWAjWt/qrYLko/Sg+4XuzJizsa1XiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fM64bpc0cXbY46rFUm7HVL20B9YCPcyUvXqkWIDluk=;
	b=MxFHg79Z6Ge0F+8kd1x2lPFS1TM4G3MBAfAyGeh7ZzgusZbaXH8ES/h0BfdVhRG6xU6eBk
	Ncd7t6T7NODlMoDA==
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
Subject: [PATCH 09/24] net: ethernet: cortina: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:22 +0100
Message-Id: <f9c0a0885dbad431e3c320348350c653d9590e08.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/cortina/gemini.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/c=
ortina/gemini.c
index 73e1c71c5092..5347431a089f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1833,9 +1833,8 @@ static int gmac_open(struct net_device *netdev)
 	gmac_enable_tx_rx(netdev);
 	netif_tx_start_all_queues(netdev);
=20
-	hrtimer_init(&port->rx_coalesce_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	port->rx_coalesce_timer.function =3D &gmac_coalesce_delay_expired;
+	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLO=
CK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	netdev_dbg(netdev, "opened\n");
=20
--=20
2.39.5


