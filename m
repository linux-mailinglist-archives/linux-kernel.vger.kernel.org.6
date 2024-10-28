Return-Path: <linux-kernel+bounces-384373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576749B295A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B80B1F23ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66061922E6;
	Mon, 28 Oct 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUi8TyMq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6jwxBGTZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C22191F85
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100968; cv=none; b=rTqea4upbdDSsMqRldyuQz8GbbewCsclIEYEaCMRF88eJpsQFNedqSqKla6pDT/QgytV4Sm+MYiM+DjZAbYIv/tHZvarqyjzEptP5pmBrIT0t15Tf6ecz1QP9fkb71GPV64XuonbOwe6Gda+KiJ/nMizb/csDTSFIRxwPPbJ0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100968; c=relaxed/simple;
	bh=TpOh9ROK/VSlXafyqKtyrVdbtpvuGB2IkT5/hojl8Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNsy/ErNCSUj7jvcHax6848kiq0aIhcoDaitJ+5+Pvk90hLiVJVgYyIs//4+uQBETRDPSvJQvmvVoE/XADwR1WA+M93/9YqihJZw5S9Bg0a0iAubmuSAvCIPf1+zk9Hwed/jooUpK/4Jd1tksB8zRsCSWQYYWHpW8dQBZnZFxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUi8TyMq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6jwxBGTZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QydA6VPhoUGgQIOxZVkz7av1esb3qdpjPoxkLWDvXyw=;
	b=cUi8TyMqpQ241YQqy39nXjLnjI9k8v20oLOoPeevII+NnnZ1Poz0pTz+iQ6s1DpdmdnypV
	rwoDd1kzhXhVSLYivIQ5ieCFU/++eG8ignMPPgVfjDY7i3Bv56NLGrkdpssv4A7rFGv24X
	QtZyI04iacBGi8omuQ30jGr+jtX8jiZ5Q5K7W2NJWOKE4Sy6KyqeJugoyaApFXqEdN0ePP
	ZgISrTSWqiZ4ZY34N+Fuhun59zQzGpv0Ky26qfHRVYgiywzfLKYm0hmDVDOZigMvELpbeh
	h9XJ21115IyOrU7kFnUwZlbfpac9ePTbQX/kNnXZ/I/mbBi24fEwpyhUjTxOeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QydA6VPhoUGgQIOxZVkz7av1esb3qdpjPoxkLWDvXyw=;
	b=6jwxBGTZO5Pojb8OciVgm7Y+5fpYlMHcQBc88hyqUhA8N3y/10B0lOLIYW2HOzf330MpAT
	lgvH6YQxL/qU/6AQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 02/12] hrtimers: Switch to use __htimer_setup()
Date: Mon, 28 Oct 2024 08:35:46 +0100
Message-Id: <ec256435583fa0abaf660d3fb13d32ceb7626fb0.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__hrtimer_init_sleeper() calls __hrtimer_init() and also setups the
callback function. But there is already __hrtimer_setup() which does both
actions.

Switch to use __hrtimer_setup() to simplify the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 60cb805a6b0b..45225fdf7cd2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2009,8 +2009,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sle=
eper *sl,
 			mode |=3D HRTIMER_MODE_HARD;
 	}
=20
-	__hrtimer_init(&sl->timer, clock_id, mode);
-	sl->timer.function =3D hrtimer_wakeup;
+	__hrtimer_setup(&sl->timer, hrtimer_wakeup, clock_id, mode);
 	sl->task =3D current;
 }
=20
--=20
2.39.5


