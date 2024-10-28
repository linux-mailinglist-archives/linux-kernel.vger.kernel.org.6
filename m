Return-Path: <linux-kernel+bounces-384377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3139B295E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9A01C21942
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE4206E70;
	Mon, 28 Oct 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2HyZhgd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7r0Bouez"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF1206070
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100971; cv=none; b=jiWAxPD4kB4LgQXfr44jeQPPs3bOvryFIK3umRx4Rgr37BxbuIAjVdGkuZYHQSkidUQv0cFo0zRyit/ELWC3SNG/7hqxx20Z9BhjJV3w5ZnYnpn9KiVuvJ38HBYycd4vBxsyR4RPRhJ0wybY2kwnzXiFLSe6fpN95HeBKR9S/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100971; c=relaxed/simple;
	bh=HjA99v1D7iWoKew86XFKmAvQUs9tcncD5FJUQn1bXkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIfaCuWizkJCDB8iA53h2DcmjtCL1IUMKYjuKE+5G9beBVK7TfSB44kCgTeejZzGhGZq6WwcdU5jGiTY1CvNo9xf0PulRQkB5VBGtTGw3lD8XC6S57xP0zJ5Z/yl+k7U5e4tfCd4pbtxXo/8BpMvrUqYCeB4asF+NSV8+ml3vCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2HyZhgd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7r0Bouez; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71d+7ald+cjcmP7u1NI10JhUTRb/W3I8OffII+X4pAU=;
	b=s2HyZhgdw6GHqFOJQ+7IFGotV3328XI4gqeFWNr2Fi+IXBR5KM6DEzW+rb79wPGl6xKfo+
	BWatmSvTipMz22X96FdQgKyNmLjRC/MAZW1mp0JXuAkv/wdv+AlIOfEPD7woSEi5GbpcUC
	mRB79QwNTncjugDft2U9CqKOuWxpz4vtnUadBA8NNSY8tUn6Q85U5nWzA+w271phoKI1aN
	U5N3f0ZNfVrkNMm6BRJSaFy9QRfujnafp+7X7a7kSFM50ryMqIIt+SBZApZWZYmZDdbedk
	4W716e+GcotXrl3CKu0CbpnvzzbnHZmTAQpDeSSB9nRGO69o1gdk1AGTocoplA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71d+7ald+cjcmP7u1NI10JhUTRb/W3I8OffII+X4pAU=;
	b=7r0BouezZVScrWutcMVhVP5A0wttZ4loesMi0fo/kubotR3w9dD/xzJzCNEuyNsFX6lJCw
	+81xRerFgHEHwSCg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 06/12] wifi: rt2x00: Switch to use hrtimer_update_function()
Date: Mon, 28 Oct 2024 08:35:50 +0100
Message-Id: <3dc739e1317de4a63223dd89ce7734bc2bd1ed57.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a new helper function hrtimer_update_function() to change the
hrtimer's callback function, which also performs additional runtime check
that it is safe to change the callback.

Use the helper function instead of accessing 'function' directly.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/=
wireless/ralink/rt2x00/rt2800mmio.c
index 5323acff962a..45775ecdf221 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
@@ -842,7 +842,7 @@ int rt2800mmio_probe_hw(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Set txstatus timer function.
 	 */
-	rt2x00dev->txstatus_timer.function =3D rt2800mmio_tx_sta_fifo_timeout;
+	hrtimer_update_function(&rt2x00dev->txstatus_timer, rt2800mmio_tx_sta_fif=
o_timeout);
=20
 	/*
 	 * Overwrite TX done handler
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2800usb.c
index 160bef79acdb..b51a23300ba2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -618,7 +618,7 @@ static int rt2800usb_probe_hw(struct rt2x00_dev *rt2x00=
dev)
 	/*
 	 * Set txstatus timer function.
 	 */
-	rt2x00dev->txstatus_timer.function =3D rt2800usb_tx_sta_fifo_timeout;
+	hrtimer_update_function(&rt2x00dev->txstatus_timer, rt2800usb_tx_sta_fifo=
_timeout);
=20
 	/*
 	 * Overwrite TX done handler
--=20
2.39.5


