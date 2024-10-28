Return-Path: <linux-kernel+bounces-384358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DEE9B294B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9221F21BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB72036EC;
	Mon, 28 Oct 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Qw3/rFe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4og0OaC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAD200C8F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100949; cv=none; b=QHhQf2PPib2qKVyhyEnJDYZCm9kAPegscUN93kfioBb1pTmLjxPCCLvDOIlatPhR4tab44qNNkSKXtZ5jqgOCvz8i9UOUCM7049fDnGDRHi9CDspChEV45+FDFSP1wxXoRmx54fb04rY+wzOVVX42TiBrhnguV0b/4Jg9LMZ8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100949; c=relaxed/simple;
	bh=nEONyEsUSCrrS0hsgsyrJ2ySafG5OgnOcI8JTHw7cKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBQfFrEvQyuEaWI9vxzPAjvsBiK0wQwz7lfEqe0g+DQuwKl00F8mItnL81qpE6yWK6x83BUpd+sR3R3hf4XzyU58LW7Rq1D1p2pH4VLMTV+/ksTMCReDaTZFqn4au112tXralw9GUTqwmbCt/CHPrjSlZumlE94GGysYH9dzmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Qw3/rFe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4og0OaC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbNTGlA+VNHMHDaobMkh+EYsbe82kvdxQksahuPMkMs=;
	b=4Qw3/rFeyoZR3AiiBmp05TPuxIJCWl1zKk6nP2aUwCGRguC0XZ2wG9zFQT+MSB3bWm08HA
	k5My+aeS84R+TRwLW/PKHLYCk3FcQmx7LkHgDs5xj9U0iXkgXgnZr/bKSQwOHzoMBH2Jjx
	ZlHGSelyBNNJYJ0KKJTrRLdJgiBGPz9+xn1b9XDNomh73qtAInVzSIC6+nn8l9HBISzhBq
	tKMzwJS5tksaVeANuOX0m7+TY7WrBIPdKai9sXBSA5/A9C+nhXSrC5L0y/2YqlQpxsSwG7
	FrK1NQxeXziijjoSWipod5YfTc8ncxnyNW5ni0rNLRCMmRFtxiTklK7qBT/oQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbNTGlA+VNHMHDaobMkh+EYsbe82kvdxQksahuPMkMs=;
	b=Y4og0OaCBnUVUwaii38xxHQxp3PeeIaq4St8yRY/Ln7bPF26mpIDAXNx/9CJQM7V8Wt4oN
	NvuWtbN0lHBBOGBA==
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
Subject: [PATCH 32/44] drm/i915/perf: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:08 +0100
Message-Id: <4b53da59b57bd6beacc5ab6e3cb069eec380391f.1729865485.git.namcao@linutronix.de>
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
 drivers/gpu/drm/i915/i915_perf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_p=
erf.c
index 2406cda75b7b..e82a47ceed68 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -3359,9 +3359,8 @@ static int i915_oa_stream_init(struct i915_perf_strea=
m *stream,
 		"opening stream oa config uuid=3D%s\n",
 		  stream->oa_config->uuid);
=20
-	hrtimer_init(&stream->poll_check_timer,
-		     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	stream->poll_check_timer.function =3D oa_poll_check_timer_cb;
+	hrtimer_setup(&stream->poll_check_timer, oa_poll_check_timer_cb, CLOCK_MO=
NOTONIC,
+		      HRTIMER_MODE_REL);
 	init_waitqueue_head(&stream->poll_wq);
 	spin_lock_init(&stream->oa_buffer.ptr_lock);
 	mutex_init(&stream->lock);
--=20
2.39.5


