Return-Path: <linux-kernel+bounces-384365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68F9B2951
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7321C218C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F17C204F67;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxDe5a4W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dKlZs5h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29020127A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100951; cv=none; b=LzqBjmBX8Z/VwGqqOWxHI/M+znoB901fmt1RlhzB/OjvhdUWsV16RFpV4xtVnra0gQEQ9HNeiBOnKBtJZzv5BKKlGMGNrQU7XIYMKPn5fR8DRm2MqmJ5/fJT5sbjjCauVkUou3xnpdAic6dpFKbCcKK/06PVKsa8uRZptg87KkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100951; c=relaxed/simple;
	bh=vPGZvGlbPtskt2lK/AjYDSxjaGWBno2DNvg/vnO+qUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4LiS4bLqmVVqK41eQlJPdfQbpTG2WzkOyndJep6iC031eSrxqqwa0QUlif7YsdHIpWz9Rloh+TfNwxPEvpmhx9YLtw5lofSBXkPEZo2iTuh9hn6dshlsIsoYaK9glJpgK1gCbg3bLPSdbAzjOTbE6jzndID8MJL4CHp2bwvFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxDe5a4W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dKlZs5h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VS1859LQxqyTAz1K0RecplOSM81fFsQLMRyLdDYxYys=;
	b=MxDe5a4WYlp83mDeR7avYEQosuTgknKXUT8q5leKuaD3VtFZIaoTYIS4T9ens9bVyVrj3g
	P7bk7Tbjm/I70dH6Le5e77CdmncuSuprbJkWFAsct6KWIjCAqa7vv+U38UkqGt7yojpX7r
	XlncpXre0yoDv2ioZea0Z+zbQhdnuZtSbFrcstvshUj6y09TNkTmzbCFQU984vGXwxO+nW
	hfpbJncdzJQGRUQhx1O7ccI+DibKID8MTJqfy7miBrPMDwRaVNCuxWy0Gw4tvQmHTlPd6B
	fcDBu37OTXUAHm8Zo5rIvRUTWkcIkYLDTIYWD43lko4UEs16OQBk40CSvrhLng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VS1859LQxqyTAz1K0RecplOSM81fFsQLMRyLdDYxYys=;
	b=9dKlZs5h6QT9drx29CAofTWFMeFfjpoGITnrWeaI1BP30pO0KM/lRHVDvR0/wQ64yx84ob
	4Wfut1xs3wqcxXAA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 38/44] drm/xe/oa: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:14 +0100
Message-Id: <e488e80d08016ec8f9dc7de2cd6cd81e22b60f96.1729865485.git.namcao@linutronix.de>
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
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_oa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index eae38a49ee8e..600eaaee8a72 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1437,8 +1437,8 @@ static int xe_oa_stream_init(struct xe_oa_stream *str=
eam,
=20
 	WRITE_ONCE(u->exclusive_stream, stream);
=20
-	hrtimer_init(&stream->poll_check_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
);
-	stream->poll_check_timer.function =3D xe_oa_poll_check_timer_cb;
+	hrtimer_setup(&stream->poll_check_timer, xe_oa_poll_check_timer_cb, CLOCK=
_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	init_waitqueue_head(&stream->poll_wq);
=20
 	spin_lock_init(&stream->oa_buffer.ptr_lock);
--=20
2.39.5


