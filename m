Return-Path: <linux-kernel+bounces-384380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8489B2961
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DF61F24749
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03A206E96;
	Mon, 28 Oct 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TNvdOrkY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YFv5AFKi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0262064E9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100972; cv=none; b=EzrBY7mkx+8tWtr6RgUoKV62JlEvh8Gct7Wypd0Ck4F3UG6viB+VUWkymJj9K5izAklRHTv3BRfi8hHd7IxfixuV+M3mYNVfOF5wF65rcdHvy0jUtbidyQISIkaBzuGl7yPlvIhtUDU2q7HS1WnjaiylCC4HuoxP7QpA+DxN4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100972; c=relaxed/simple;
	bh=dHCtJjOVtAag+Bg/wK60QRuUqnfGU3A3wK1zm9IkNs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqhfCmULfLOeDhVgYGIhxH4wMfaPKY5eC9zIiAdjRb9D8DU2gzv5IQGR7cVVSyzZ/OPL0ygR8X6N9dR0OEEywHI8IBdW0yGEByRW3CtvwM69nxy3lafUg2sLtlIOPlTW5zP2EXnRc9L73193jalcllv6JxZkjXWSIHNXCyE+UTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TNvdOrkY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YFv5AFKi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRz7QtyGXezmKWopxXfmDRDYnTNSdp4skn3MHlnNYb4=;
	b=TNvdOrkYLIEFvxBu2f0blMtbeKz1csEfgdwmfKa6bYkva8NjFWoiXZi5o1ES9/4UOgE9II
	HvJNINO6bwNR0ko/0ULnsdQWo723iy9e0XZm3so36u83I0yq2TaNHvm8NUr648Hs1qx8dV
	6R1ZPhaStQh98QrXBoXkkibu2JGLdywmnwvYre5Hff35geuPaW+zUkbvbKruQQTAaUHORS
	ainaBJ8vr5HB0p7mlt8oj+Ftg6hwjalT+T9MJAX9Fe5jQmj8bbmDM0qAMIyM0a/o6phoIc
	Aa6md8SjGPr1BToSXuKIhy4daU2K/gBojshFYhfdUrF3eCwhdbhZFiz6FXyJRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRz7QtyGXezmKWopxXfmDRDYnTNSdp4skn3MHlnNYb4=;
	b=YFv5AFKiEEHijIEVby9ycqDMMvncC/sBwUHN38Gq1s6bHn2oPouatgtMzvO6mCXR3oTQvR
	/7EFhJgyjL5yV2DA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 08/12] hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()
Date: Mon, 28 Oct 2024 08:35:52 +0100
Message-Id: <47dcebb90753f8647a946442df4d8cb9bb9621b8.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'function' field of struct hrtimer can only be changed using
hrtimer_setup*() or hrtimer_update_function(), and both already null-check
'function'. Therefore, null-checking 'function' in hrtimer_start_range_ns()
is not necessary.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d11697492bdb..2e03b07cbdac 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1276,8 +1276,6 @@ void hrtimer_start_range_ns(struct hrtimer *timer, kt=
ime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
=20
-	if (WARN_ON_ONCE(!ACCESS_PRIVATE(timer, function)))
-		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT =3D n. With PREEMPT_RT check the hard
--=20
2.39.5


