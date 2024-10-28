Return-Path: <linux-kernel+bounces-384338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FA9B2937
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCF71C21039
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763D1FBF75;
	Mon, 28 Oct 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GawyjlE+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KoOegUpt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25701EC009
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100941; cv=none; b=cXKRdVwMpJDcyQNuqA3L3k7ZyJ+PAYurFLOi/FzrnTC0FIGFabJWQzP/EGwOp0zhYkGpK0qIWQuqmkZ74mfHEzItdEHdvEebQPr8Fa4YMcr43WDTG3rojgvZ/+V1Ly3gWzMOVBhGuq9FgMvdwUIQ8pQwoDpkmKKbYQ0C7FCML6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100941; c=relaxed/simple;
	bh=yxYaRz5YYKNw3qdQtujufTAlDrtbm5aDY9tbNBu2xDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTj6wqHxxxBJqZgmdaTkr/6/s5W7mDkzuW0pE0VC2OikfgrnSdbhdWx0BN+EqWBjnHXYiUNUQXMT2e5cc/fZubU0r5ktrP3HiJGQg8lfURZvjYOQW/vFxO1kRLU2ZQx4YmLL7fvtYyC5slvdidcCcMhtJPzcCPfIDMqlAzNkW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GawyjlE+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KoOegUpt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDNK2Ol6tPyckkAlsSArdJh2aHoZHCL7LbAKeA5xR+k=;
	b=GawyjlE+iDtRyDMlUdbk4ZMRObPUTperX5IwKMW32d/pn1+AFiqitO6x1h/YhMctybmJg4
	dHcm6TEcQJEJlw2r3ODxJbq1ILt6/IKr6FzXKpD21/FaTMqarU/4xs23SD7Nc8gkU/cHWt
	MlnitDtP/JF9UcbA+KP8gfS3UQmN1De61uIXHRQF3Yw0/LJ2RehS/hcJsNDweQk2ixhULr
	rpc1+ZX/uymuhNO+3kK+rv9hUL/SAmqH1BP127waLVgnfvTiu4B9R6Dx7Zlpe8+BL5NGx5
	LTnox6yGO3lsY+DRWtgo1Ceepx5qhL61AeSs6LCtp89N6ba4oEz9PuqW9nKShg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDNK2Ol6tPyckkAlsSArdJh2aHoZHCL7LbAKeA5xR+k=;
	b=KoOegUptPjcWL84/CWz6Db7RjRv5xw4C4g2nXz7QfOfPXc9QDColFQEACSg9VvueMQvdOS
	Vt6FIk41dZcfIABw==
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
Subject: [PATCH 14/44] pps: generators: pps_gen_parport: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:50 +0100
Message-Id: <2600255ebe981f4ca08ab529d18ed961fe01472e.1729865485.git.namcao@linutronix.de>
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
 drivers/pps/generators/pps_gen_parport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generat=
ors/pps_gen_parport.c
index d46eed159495..f5eeb4dd01ad 100644
--- a/drivers/pps/generators/pps_gen_parport.c
+++ b/drivers/pps/generators/pps_gen_parport.c
@@ -208,8 +208,7 @@ static void parport_attach(struct parport *port)
=20
 	calibrate_port(&device);
=20
-	hrtimer_init(&device.timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	device.timer.function =3D hrtimer_event;
+	hrtimer_setup(&device.timer, hrtimer_event, CLOCK_REALTIME, HRTIMER_MODE_=
ABS);
 	hrtimer_start(&device.timer, next_intr_time(&device), HRTIMER_MODE_ABS);
=20
 	return;
--=20
2.39.5


