Return-Path: <linux-kernel+bounces-384347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607169B293F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A7B1C216CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7EE20110A;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JCaFB1ko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kW69CFbg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A681F756C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100945; cv=none; b=FwO2zmJh6EF4INP424ZfqNPJq+/USuIm3JAo/C/wFsQMcnlwrNl04+Mc6inU6n8h9m/NRMQG+YjZG6STeHTjipWgVzt98nbtlFmjY+UFqkwvsoEZQbk2TsHirSRrzj1u7c9qzOrFPZOq/HLk5JVtPuuUDyPTppbmmEmM0niZJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100945; c=relaxed/simple;
	bh=knBeue0vxxbZMBDfG5hh41rBBao+jZIq3N/1K0eM/aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgTkaNFWJdXpMWpuHg2Mn+BndEoB/fw7lJPMtQFlQ/LFzxfXXcK/FuBPk/6nNUHGz+dk+WU78UsfQ8cSuTPuxYinOrX6AuWLVwySimcgWEYb77dpc2js7R+G7d8wqyaFyxhj4hQLO8bLu7Vq/TAygY/d2RO+wNuDFEIzYw6Kxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JCaFB1ko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kW69CFbg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbgF2i9QvMxQBC8ft58I6SsiBpsx5sKDsa7ekiwBM3k=;
	b=JCaFB1kox795DpP4Sv+5dVuecVFLZ9h6nwj11L+L/Kf0E1GW7IMDhB21vfxpGYKbBSLm3O
	IkklTbDe1YibFfqZyyW32Xre+PWs0P8OW++loDjsQCviyrRS8DJqifsiNtifbjvX4cTdyF
	hlqZ4X8Vbx5JEEAl8zVDgxE0AP+GUiFzZRv7o5oxYSkzknWSic5MmrDwX26BJ/sEbxUALd
	lfa40Imo73jPTHCqa/kvicg/gSHCghigfv7GxKJAaSU6r+0iWKTHaXV9xBkn0cjTVXnwHJ
	flGs9fB+WauaZEZVCDJKHM5pqgoSlDAKhsXgyxZaUFg7LfYt8IEwx2cg6N5IIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbgF2i9QvMxQBC8ft58I6SsiBpsx5sKDsa7ekiwBM3k=;
	b=kW69CFbg5PWj+9FlGl4CRU2ZtdJ4UMR9Z4j80m30OyMlpUg+uapZZeTbEnwXGc+MnLrJZZ
	bkcqTOPOHyP10rDA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 23/44] mailbox: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:59 +0100
Message-Id: <3fe81b988c439f1bf52be74368268dd113728a69.1729865485.git.namcao@linutronix.de>
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
Cc: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2c9895..118beaf447aa 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -534,9 +534,7 @@ int mbox_controller_register(struct mbox_controller *mb=
ox)
 			return -EINVAL;
 		}
=20
-		hrtimer_init(&mbox->poll_hrt, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		mbox->poll_hrt.function =3D txdone_hrtimer;
+		hrtimer_setup(&mbox->poll_hrt, txdone_hrtimer, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 		spin_lock_init(&mbox->poll_hrt_lock);
 	}
=20
--=20
2.39.5


