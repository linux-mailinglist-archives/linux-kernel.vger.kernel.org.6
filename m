Return-Path: <linux-kernel+bounces-384279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008129B28E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920BDB2147A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E91DC05F;
	Mon, 28 Oct 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GsM0Id4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ad4MP629"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F441D9A43
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100746; cv=none; b=deff8rMu51lnjYUihqR3bO9rd5gz/TW2sJ5b8Tf1SZJNwGZSPLwBcSgLvUaKOWdZRQ0stOHF4OSBp7cmrA/IC9YJSTMCiCUbnBZvfRZC7J/fpz0Y5KZKvVFEkE8/nMSj9A0AT5HsQokfk70GcJbfT0DfUGEn+0h4ygYPaB0rPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100746; c=relaxed/simple;
	bh=pBPcBdVdcXr6X8+Bd1rD+OFstKHVX3SZ/1x9RfOtVjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMoCa8Qmir8Yn50wcl28Zh9II+l19fa69ycFZ5qJK7yFfDi80ZNbCQYVf+JDYz0W9e/qbxQk4wPas3R04ewrMgTy/B4FxL+APw/5jCzhWzoKioWcRXvQIQpc+j5f1PovjLxr9oy0ujCzfcjInanaA/ojJ6ocUhMj0UJMnBnPDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GsM0Id4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ad4MP629; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0YTJ4rNcKrR8odEM+5Vgl9rVPk6+FQbqrJCGZPG1E8=;
	b=3GsM0Id4iZ1D7Wc9Vki5NlJgO1LyNyNf2V5IXQWQv59ITxVMZlLpjxhTQGOXAQ2G9AMo2W
	Uod/yIO9BM+RtUGRgAQJKqzpA09H1sxaan//03S8KxjITYneGEt66yLBTaGFTKl9hfaCug
	RhQ2oqhUmaQYDu8UkR651eeS4MzoleUIV9QqS3mLHu5+HboNrPJ7WJdj4rBak9PmVSEAqA
	iwddDpPewNtyEGxHsVaMFES5pkHIqwkBxfhTg5VkWtxRmpLwDml8Aoz5suAksiWY66y9R5
	4PAFHgDRxoiQsp00U0NjCugiUDQRZ8DSZ1gRlWrbAMzYBqqzum1WsXW3ZrSLrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0YTJ4rNcKrR8odEM+5Vgl9rVPk6+FQbqrJCGZPG1E8=;
	b=Ad4MP629P/JQy5mUoHc6yzto1eEknlIMn9QO7C/j0Idl36jnoy0fzQqy4AhG4ZO4FkKaVA
	0XjtSemoGg/9RFBw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 15/31] lib: test_objpool: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:48 +0100
Message-Id: <01ff5361b87371fabf5dfd4a9f9f1e5a30894193.1729864823.git.namcao@linutronix.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_objpool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index 5a3f6961a70f..89db1933eb41 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -190,8 +190,7 @@ static int ot_init_hrtimer(struct ot_item *item, unsign=
ed long hrtimer)
 		return -ENOENT;
=20
 	item->hrtcycle =3D ktime_set(0, hrtimer * 1000000UL);
-	hrtimer_init(hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrt->function =3D ot_hrtimer_handler;
+	hrtimer_setup(hrt, ot_hrtimer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	return 0;
 }
=20
--=20
2.39.5


