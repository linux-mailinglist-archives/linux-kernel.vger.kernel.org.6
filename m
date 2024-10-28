Return-Path: <linux-kernel+bounces-384348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6B9B2940
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AB81C217C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14B20110F;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwsokf7b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YxKDlbxs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5331F4FA9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100945; cv=none; b=rA4MFp8nTiSguRreIzJB23mF/XImeaOhpChGT5SWC6ZTO6B07gGx6qVxcAtp/NufTNxVvlmoEeEDMcqmk8DFeW0Bue+cPuiUFwyUcXhzcBHmjlMO1SpKyB+QaNBFZnZm7Xift6ghYsoIZc8BydHFBbg4wxG3b4NekOh7IbsA39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100945; c=relaxed/simple;
	bh=AHF5o5vNEOXkzMJVYoznmT+6csMX/dc0lZOFe+Mr7dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVyhc1IQlsWdn7Ze92CLVQ+nHZnzg/cGC4vG9kFB0llIDcv4bdlKu+3MoaqsP2P/lrNAWempQ6rQChh+wehBBajppM70jomQJ7ci38r+f85SnmbFZymThV/kd0iE1IZFuDTbem+Uy4hS0cw9ZSOoo3NNI0/HdjxvMhZAUm4IFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwsokf7b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YxKDlbxs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MihCUk6iO67SYt64qJ0M+dIX/dEuDX6YcAJM7Mh4EKY=;
	b=wwsokf7bSD9VCqJlMfI3Vmu1rPWnyUw8ir4KtQdE0OVthwJkiTSqw0MzIWaEt0FQIxiU1c
	UifDMQIViyNaoMMDi8N+3LSQ1ykLxWeknP+2kPo2H7FDhpiXrd24svDBnxL5p+9hJGllQN
	qndtHGuowHnpa+/CJ32vNDSrvM8lbHWVLmTzxwtWP8quC7NjRsLGo8odqjIRIFBz4QzVdL
	Zy8Y9LUBq749KSwemsp4zj/vOvcVW1AgWTGUaGgqe6mE99Nh45x93EM0Ke0MT+uTW9MZ1h
	YuVyfubgZS2qeuG6PszcrxXBlmWJk3wH/FOqRbDpqGMpraodD81ltr8qdc9B+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MihCUk6iO67SYt64qJ0M+dIX/dEuDX6YcAJM7Mh4EKY=;
	b=YxKDlbxsl+pfSPSvzUvME/8kPLBvNgtEE+ZpWCKtWaOrBmbegRnyiFoaDx8JzmnZiaIYUC
	k8WronQsq48QniBA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 17/44] power: reset: ltc2952-poweroff: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:53 +0100
Message-Id: <da657b931d74d712e7185a0b9e63263f1ac59291.1729865485.git.namcao@linutronix.de>
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
Cc: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/reset/ltc2952-poweroff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/l=
tc2952-poweroff.c
index fa25fbd53934..f87ce4686d4f 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -162,11 +162,11 @@ static void ltc2952_poweroff_default(struct ltc2952_p=
oweroff *data)
 	data->wde_interval =3D 300L * NSEC_PER_MSEC;
 	data->trigger_delay =3D ktime_set(2, 500L * NSEC_PER_MSEC);
=20
-	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_trigger.function =3D ltc2952_poweroff_timer_trigger;
+	hrtimer_setup(&data->timer_trigger, ltc2952_poweroff_timer_trigger, CLOCK=
_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&data->timer_wde, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_wde.function =3D ltc2952_poweroff_timer_wde;
+	hrtimer_setup(&data->timer_wde, ltc2952_poweroff_timer_wde, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
 }
=20
 static int ltc2952_poweroff_init(struct platform_device *pdev)
--=20
2.39.5


