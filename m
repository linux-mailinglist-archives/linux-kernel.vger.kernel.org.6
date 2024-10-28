Return-Path: <linux-kernel+bounces-384291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E59B28F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFED21C213E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE81DE2B6;
	Mon, 28 Oct 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUlk+eum";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zS7j8YX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD081DA0E0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100750; cv=none; b=sy74Mu/+sgzx8VvCYLcbxI9j6J8KxhYrZ9oR6OCddSeFeMbPIRuvgTJdlUBB5unDtlt2twExp1m+f/U/bDpzikUEj89x/byDk/DgOnVHT1ANDMLoK/jNhXBzAvja5zDqU1WEr50KMSzin4/Xrw7wjUcReIhwieA1662a06E1lGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100750; c=relaxed/simple;
	bh=MGKrfpZTfDRgBmEIFyYFYPSnBcuvfm2nLXvgfiyhRP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulkebjrlNXhMxOspUTLKYVtGbL2eopYTqDHAnOZmAFeeXZNq3Cgo5VkQKKpW4pTpYibFvB2qNR/3ElObxjkuH2lSKycgTajYTmDdqJy/FbahNlysAc4kQkS1dnBrW21Q2fgATiK74u4/IRKaXsUPPdJ/BwtR6xGd0PllK47er04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUlk+eum; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zS7j8YX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPn7JOx6/bF7AcYZnwASeMF8q3ZxVgTkAErO6IDHn5Y=;
	b=zUlk+eumGqnDs+VL9bv+CvmdauZzoxRBB9gdlc8HrcUOddT+4ZtVHUgjmzzs5Jjgb5lGFK
	iuoYF0Ue92wDwDA13127Tz4aIsRJvVRwQKI7uKykeoHqAn4mVzG5Ej4CcOYgz8Sld+j3u/
	jpveY1uIja1J1UZl3tSMkeF6k/r++FB0MGXmztmB6gBhfVXEzpGaPP1k+APjLKP7jguxGl
	9OvqgkMJeaJIfsvohB7UIGJ29F4BhQD94unwlXPreWMgNIcrQjl+TffpQDvD6J2eHxodK2
	HvIn6y78tbzWE912EuZkEqlfIjOFEdbAizYDA7COeMdwwrWPlh47FOrz29sh3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPn7JOx6/bF7AcYZnwASeMF8q3ZxVgTkAErO6IDHn5Y=;
	b=2zS7j8YX5xbobtYXaWuYtwmN/Dg8WkGOGkCEYVnd2wrjp/aYOhyctf9J8/S1LHxTo4OSk1
	OcwznRgCBs8YpkAA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 26/31] ata: pata_octeon_cf: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:59 +0100
Message-Id: <ed3d9c1f672708ba5b77f1d903e472bdd310a037.1729864823.git.namcao@linutronix.de>
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
Cc: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_octeon_cf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 0bb9607e7348..29be47fd8e03 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -935,9 +935,8 @@ static int octeon_cf_probe(struct platform_device *pdev)
 		ap->mwdma_mask	=3D enable_dma ? ATA_MWDMA4 : 0;
=20
 		/* True IDE mode needs a timer to poll for not-busy.  */
-		hrtimer_init(&cf_port->delayed_finish, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		cf_port->delayed_finish.function =3D octeon_cf_delayed_finish;
+		hrtimer_setup(&cf_port->delayed_finish, octeon_cf_delayed_finish, CLOCK_=
MONOTONIC,
+			      HRTIMER_MODE_REL);
 	} else {
 		/* 16 bit but not True IDE */
 		base =3D cs0 + 0x800;
--=20
2.39.5


