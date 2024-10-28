Return-Path: <linux-kernel+bounces-384284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D09B28EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79892280B96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048F1DDA33;
	Mon, 28 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z/CH1ake";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBSSkSda"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702001DA2E5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100748; cv=none; b=e5HVVRpo8iBIrH4VcOCvy5aVC2AFR4UPHtGBDuRK6KeDsgnlpszfEA8+iIVJrnFG1ZsBb3YBRioM1SFpSUZQ/XBuU+sXhGhz1hztwL364tLk1nVrVjEoqgh2S2rWQURwJmPmkYKQr86zHJC8DKArmzSNPLK7UgHnbI5KJIurWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100748; c=relaxed/simple;
	bh=pLxhj5bKMX4bcctwIPGHD0uwceLobFGtNcrfedOzlEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjth78hwOAhk7gtuzJPgveeJSzR2NpdBRY7scEJgn0WW8QrktzaI2keQYlQYAYNOTRrSGrC7uc1Ye7l5CFxwj04pfLY+IDdgMmN7rGsbMuMcIm06XvTn6OMiV5IjeRGDDsVC5YiJ27/4tb7AQ0d/IN9cc66YdtCEMUEZUslsWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z/CH1ake; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBSSkSda; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjWG6LJTetYcLcPDh5I0erASVjRFAMJtO3qW93fU5ME=;
	b=z/CH1akeCVekbuFwH9mAT/40T+JyON7TM3wN3UmHwFL10Tu0j7n2Ka/aATuQw1UvdcSIcN
	vRw29d5f3Zq6Cj9ZPnZIJgQchnNN871VDsNs8pV+i/3qkvbTz07CL9X2tNIw/TGEhZZ8XD
	MLHQpVVzGZrPhdCeIXSV1uOM5/q6+XhXMe8du4u8ZH08+yru4BaCKaV7Y8O5NtH4pKnxQw
	qH8igT1xsA78l6Vo7pIjfZXU2yp8R2yk9v0VSiQnQzUMNm3c75K1Q6g4uuyk+MlOWK473H
	/E2pyBNW0mwLl/RYrT8G9Zj+/LAe8aHYS7gmkuSQGS8qqZq4fT1sS8caBUQAzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjWG6LJTetYcLcPDh5I0erASVjRFAMJtO3qW93fU5ME=;
	b=xBSSkSdamZNfVePK5zUjKMxXQ/RgXeKfZuywTyPAkietjGwhggliOspb7P8Q00Lxp7Cvhj
	K0fxhDvYgCPFBGAA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 21/31] bpf: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:54 +0100
Message-Id: <6f1b677bf762e116278d5902be61af1eeefc78a7.1729864823.git.namcao@linutronix.de>
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
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..3518519e468a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1284,8 +1284,7 @@ static int __bpf_async_init(struct bpf_async_kern *as=
ync, struct bpf_map *map, u
=20
 		atomic_set(&t->cancelling, 0);
 		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
-		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
-		t->timer.function =3D bpf_timer_cb;
+		hrtimer_setup(&t->timer, bpf_timer_cb, clockid, HRTIMER_MODE_REL_SOFT);
 		cb->value =3D (void *)async - map->record->timer_off;
 		break;
 	case BPF_ASYNC_TYPE_WQ:
--=20
2.39.5


