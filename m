Return-Path: <linux-kernel+bounces-384335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F59B2933
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1491F2213E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45F1F4286;
	Mon, 28 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pplijDq5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0qL25RT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE21D90B6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100940; cv=none; b=IXf59XBhVWFamdlJQOA0RPHkaOFxuSTqebeJCMCV5kam/J0OfF19zfovPe31FdJKWxn0ZNZE2t/VQxbplLjonBZZc4HEyECKWgygUZCMqmMPvDiZJaiK3aJh5ZbmXgJiJAAJioq9lnuQmGlSdtOMM3ouySKprcmMz2p0e9mdeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100940; c=relaxed/simple;
	bh=pdbYB+u46eGaJDT1PSJvYcZGhsghd4PRRmyCH9BQDKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWqsRRNbWmukrRv08E10WVi8N+H2ZQGsZMjvg8Bo8i5hMbmBVWwaYxqUrg6yknC2hKncRtDBeMSnZ2acTnuzihjpslHxkCESUJzNmgGEqHaegoiuTl5CcpElrynHFGbY3F4quEmHWYfvyM2lTulAdsEw1E+OCLOVU77nCBqdlls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pplijDq5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0qL25RT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKuavl6ftw7muQYWbF/ONalJr/LauagWVFwayn43ZU0=;
	b=pplijDq5bJvlh2+26/gpEB2d4LVzhOaZ49bENsQ05+5n5LYmw/ORuEccMFolhnBOhB2IDC
	Sz1DO8AuZRy1/8qu5rDNSWKLiiMx/NIO6ZQ6tk9Ys7DZggHnAda/OXmw94nbLgaKfqg4al
	amlomYdRHh0GFXffQKAgm8hHjLKesS+qZcD2cLsvxru9EiBBOHoAUmjzHE1lvzQCCJJ1Lg
	dVbrP+SRxYrXl87YfDdTGvXkZUeZY5OWKt2oOWwmAOmh8vxKmdtqjrBrMVoqNSZ7xFFZ2a
	THsnlJ+HbUwMULfmQvdhSfcZ7jADaro+Gt8rz30VYKYIW9IGPH2MLSqxS41PVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKuavl6ftw7muQYWbF/ONalJr/LauagWVFwayn43ZU0=;
	b=R0qL25RToYpmX/sRk3UwAc9dR1ZxRsV9f+oKjMRpHohuTac0t7Ry0YN5FTxtMLagfQmIsz
	NN6jR4LdZxIvMGCw==
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
Subject: [PATCH 10/44] serial: sh-sci: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:46 +0100
Message-Id: <f15804227be29b011963828e629b751c97d476e1.1729865485.git.namcao@linutronix.de>
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
 drivers/tty/serial/sh-sci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b80e9a528e17..42e9722c2c82 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1695,8 +1695,7 @@ static void sci_request_dma(struct uart_port *port)
 			dma +=3D s->buf_len_rx;
 		}
=20
-		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		s->rx_timer.function =3D sci_dma_rx_timer_fn;
+		hrtimer_setup(&s->rx_timer, sci_dma_rx_timer_fn, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL);
=20
 		s->chan_rx_saved =3D s->chan_rx =3D chan;
=20
--=20
2.39.5


