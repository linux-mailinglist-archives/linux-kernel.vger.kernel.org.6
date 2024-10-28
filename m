Return-Path: <linux-kernel+bounces-384310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93349B2919
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF451C21497
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D2F1DF270;
	Mon, 28 Oct 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tw6bmISP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suvGOUK6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61641D5156
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100893; cv=none; b=CyB/m1OZGjjlMMXIxM74ZTXWj+DDi23Ve3lb8EwLjBTTLZJOSa2y1FQw7cdFXR5+qbY9PJP+VsZKzRu9mdzNDs+1DJgvrBUqcYe4/k81y1whsDKxn7Gl6FmqpaKlJhgg9rwR3BGcE/j993JFjLEOrS+S7kYpJ+A4snH3RReS86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100893; c=relaxed/simple;
	bh=ShcJLsHx91+2JlgZgzJIEhoY+tzqmgS374Lx5ocZN7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5lb8hT6uil72yhAbN1EFxioTGrrGGjOEBVN4FuuvuO1frpTtJPqh+mr8FF6OKrA6sGNK52qWMW8JH5FWTErqUXzUqD7BnhCbIR/pFKg8SizGaqDTDZbAoCTSJF04Z3xXso2LXRReesqgkx/Keb0+vq9hIA2BgLqDZ5lF2OFRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tw6bmISP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suvGOUK6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsQNG14Q324MnNU5r6jpHCOYzSsrtS0Bk0Sr0BZNMBA=;
	b=Tw6bmISPyPJZjyvK8G9QxQYin37qigyoi5jCeDwwv9hA+gDJVY8lr4ITw2sTuaPB/RqK6+
	LMydblaera2u+Gx3JD3JkoTKpXcMqvRVwLKFFXxuT5+V9u4L9Rs+0disOYYgLX3Fl+WC0X
	B4wQGHEw13uyiPeCdQcGwqbHeRhYJbJ0mNavDGoFcCg5oGkxewSGHx7BANyqCLfzcJVc2s
	SmDN5eRqDjL6I6ZEJrCl95H1TP/bcG4PqGxKRZzP88jfymEMjVklXineRfcqvFL8yifzIw
	VMW71GBGtWtp65g7MrziT+vzztyXxUKfE2cH7uM5wW/5VW0Un0hevm1wjtTJBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsQNG14Q324MnNU5r6jpHCOYzSsrtS0Bk0Sr0BZNMBA=;
	b=suvGOUK6+yfqH171YtBCpf/+8Fy8DWN1dHub3+95hCCHGq4C5iXBRYKKkOBzO/MzNYQchP
	bQLIyzQz5N4tqVDw==
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
Subject: [PATCH 12/24] net: sparx5: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:25 +0100
Message-Id: <e77a522e5f74499906cbc28d2c3d7c80c520c9b5.1729865232.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/driver=
s/net/ethernet/microchip/sparx5/sparx5_packet.c
index f3f5fb420468..89e25292d8f9 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -356,6 +356,6 @@ irqreturn_t sparx5_xtr_handler(int irq, void *_sparx5)
=20
 void sparx5_port_inj_timer_setup(struct sparx5_port *port)
 {
-	hrtimer_init(&port->inj_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->inj_timer.function =3D sparx5_injection_timeout;
+	hrtimer_setup(&port->inj_timer, sparx5_injection_timeout, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
--=20
2.39.5


