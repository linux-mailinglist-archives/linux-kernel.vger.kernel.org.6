Return-Path: <linux-kernel+bounces-384356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FC49B294A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC58F1C217DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF80202634;
	Mon, 28 Oct 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H6TVH1G3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xxxT2y7m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD51FF7C7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100947; cv=none; b=K1t6rV8+j0LZX88f3pt4B3zctcj6pq9SUW8ybwgpG7Za0sxd33LE+nUzF7TptRg3p9LqJ8CLxRCGjBsTJ3peoA/bb2Cq/POK4Ei01aXvI7fuznqYFUjVbqLmhJi10u1VwWQf+6wclqf2RFubru8hqaZslx9r1PQcGAHjgQzvNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100947; c=relaxed/simple;
	bh=PHW3uWUFg3kPDXSMJT3XFZrMVuxH+JEUmKjcZc6HOow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VH3rMv7YARPdC28QY2oz0xCTY85GXEInepBM6xt7ldiw1gF90hkdzSj351p60ud/6tb1aQLgC9reCMGlU6PFU9+LD2jEuQf0Fv70VXT7+ZBnqrl+dGyXmi+q40x1qFFH6OxblhZe+XjGHHn25ukScM7BTMSRfus+l0xL10hM//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H6TVH1G3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xxxT2y7m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQvlrZTQO/eppjto19VpVjTAhhmXdR6H5TyrBCfrBFQ=;
	b=H6TVH1G3unPhA6f/SalYvNMRqlq87vb4VsvHGMSaT3G+oxPqzzgV1VwE8lxzYNTDgNJhUC
	pPnVQkQVJyP+j1KaQ9c9Vku+e1QPTZgpzD+JT81/mV1Y101D3HDqV/v3BC1VheqV7D1rvs
	yTm8WSOnm8sKxbh8lRis1tsinyWC8++1LSEGjFn2zYHMAiiw5t8f7LhprKd3GmfiOw/Jgh
	cT4ap1uyCR6PJWxThCFFywBXqhUWPcgc2R1GB+mm5riJ4Fbk/5Zor9p4WedNObLQyFDk3y
	ydF/pnrVEAv2xp0Bbcyux+XtDzYwzMHRelvtyrlx2x/iTHDKsriqY6306W7qSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQvlrZTQO/eppjto19VpVjTAhhmXdR6H5TyrBCfrBFQ=;
	b=xxxT2y7m4brZMjIE/83kH8bN1BePRUBsFOXvhF7FfrAEhUGGjJGzisIh0g//8GfeceUFt8
	FLL2R5rZ5bWwmZCw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 30/44] drm/i915/huc: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:06 +0100
Message-Id: <afeea4a8ddf80814f9fba05b8df428164abb940e.1729865485.git.namcao@linutronix.de>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_huc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/=
gt/uc/intel_huc.c
index 2d9152eb7282..1c1582aef8b9 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
@@ -231,8 +231,8 @@ static void delayed_huc_load_init(struct intel_huc *huc)
 			   sw_fence_dummy_notify);
 	i915_sw_fence_commit(&huc->delayed_load.fence);
=20
-	hrtimer_init(&huc->delayed_load.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	huc->delayed_load.timer.function =3D huc_delayed_load_timer_callback;
+	hrtimer_setup(&huc->delayed_load.timer, huc_delayed_load_timer_callback, =
CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
=20
 static void delayed_huc_load_fini(struct intel_huc *huc)
--=20
2.39.5


