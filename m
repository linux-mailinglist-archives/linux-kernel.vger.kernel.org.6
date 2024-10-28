Return-Path: <linux-kernel+bounces-384329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E559B292E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DDA1C2164B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411E1EE021;
	Mon, 28 Oct 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TU6vzB03";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtNYUEtl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA861D88D3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100939; cv=none; b=RDL5Ti4BoGykTZQ8ECobRekJJaGOXpdvm+DcIDY/WdjFRiRz+gFFMu9/T/ZhUbRc9bqg670CpqUa2HG3L/ITaa8FtekNCGBX6YzBjqv+pQGsJSODwP5EzGJK+NNqCe5msEpucIbROvEk/7XEHO48lZ21Hg3Qgd0sIUmuKXThbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100939; c=relaxed/simple;
	bh=ocxJPXrRMX9AKPTRCsMQE3+IzYihoZ0YsOyAwjdYL8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PlqCeU2WLFgz0gRzLJYEM9lHdvf9eD084UchbdKli+Fd2xHh5L/URFdcolspgYseh4HYctBWYjImAf8pFpbzSOLe6TS715gZOHeb7hUtUjgirkT2JXqT1bZVe7EZJs/TESpjBvASMOf13I/tMrephjCLisgzL6gtlfDbRxW5DAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TU6vzB03; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtNYUEtl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zUA72cF0wRisdlX9SpPcqHHR3ShFEagmFS22tbaE90=;
	b=TU6vzB03pYEwWF031wybG3X0tlwMGQG2PuF83IqHSEkd0EqfAdOgI1NZ2mhZc+Nh3hDits
	Ksnr4s+5E/CzuakoILHpqN/dRtb5JeoGtYHALbZf75JGITRd5oI4DEAgzsXLD79Wg4d8ti
	zwLCl/sx252JNlJFIzjqq4KWAZx+dDdTEQe34HBudrf2A+Mu2TgAoSi7/Tb6pelzYW0zfv
	dRK7mN2P88cbcv+RyQ+jta/Hfv56ZaFEjxDg8mU4tyeieJU2DJsYALvhvSm5QDC2wjRXkL
	m2CMmBM0CfXbLbdY7qCPbF5chh0lRUccgJKVECoYSMyMmrWlha7NmlmGyipSGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zUA72cF0wRisdlX9SpPcqHHR3ShFEagmFS22tbaE90=;
	b=WtNYUEtlrmiBtb9Wk6Z7lzRJGoQxhZ2BmJEMrfMEmG02mFq5HaIYVcXZLOUsslmyUAdG5m
	ZgAS983lVH7HWBAQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 06/44] usb: musb: cppi41: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:42 +0100
Message-Id: <bf24b4f931658fbad245358870900c7fb74bc2c9.1729865485.git.namcao@linutronix.de>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/musb/musb_cppi41.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 9589243e8951..4cde3abb7006 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -760,8 +760,8 @@ cppi41_dma_controller_create(struct musb *musb, void __=
iomem *base)
 	if (!controller)
 		goto kzalloc_fail;
=20
-	hrtimer_init(&controller->early_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	controller->early_tx.function =3D cppi41_recheck_tx_req;
+	hrtimer_setup(&controller->early_tx, cppi41_recheck_tx_req, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
 	INIT_LIST_HEAD(&controller->early_tx_list);
=20
 	controller->controller.channel_alloc =3D cppi41_dma_channel_allocate;
--=20
2.39.5


