Return-Path: <linux-kernel+bounces-344600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717998ABCF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADE21F23B98
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FF0199FC8;
	Mon, 30 Sep 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ELHSdJJZ"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8469199933
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720201; cv=none; b=BtYxRm01PG2wWxuybwWnFxDgYoOLTmSH/IVpB9RVzceacKhL43dhEN7npDW88EEsUsXvrL9gsd4qQCAhZOkgzuNb7fyg+RAUtoA2nhpeU8q1QOf7Lz2iavYprSqCEZWJ1dUbyr+ZIfMQJnirHk/1qrUq9/Lke3EQH7FS4yhJlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720201; c=relaxed/simple;
	bh=qfpysv51Zsfrkk0FRiBBsywBaSMTVnlq7M+eczb5k1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpytJ6fvvKZmYMn/d6+Yylyvcc0N9AZ8OHPOMt4990l73DpfIa28lp5D8TE2CTdUiAQZVJRxGDDYKi721FxKQcmKw8UUDcmU5N5LxINlNNOm49mabxieSQjJFWmsSiHYCMWVyUeH8qPhHiMKIC41NPluiilzAFmZz0hhHl9vdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ELHSdJJZ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmJ63wzzlgMVs;
	Mon, 30 Sep 2024 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720189; x=1730312190; bh=zaI39
	plbOj1b0fMPH7CHurh+dET18cQh8zlGr0HXTtw=; b=ELHSdJJZaYp7FTWNj8JWl
	0t9zqDuLCCUrsH5umTrlv12Jm7F2aCziZxfYDTQ7bCdQjriDquPkv296VB96DWgV
	7G63LC/njwBukmkiWnhCqv5OtErCw7PbrMPCdEObffF+A2CuxtABZgphJwO/p6VV
	jM+0nSGrx7inGGU4FDGP3t5fWfbcJj1HdQ/kMlKMV4xwPQnME6TrnyM4zTOaFqLT
	yBUFs41qDzKhbhSV8E8bf0pgfcELoFUZlHiOkYQlcdjJpliHKaQHbxg+P0lBVdJX
	U5nUMMgLPuLCZ+34Dh0cveMID7hDcBzblIoCCm1G0Tk3hVSrs6lGTUGyyd3fZAqC
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id b-l6cx9my2_3; Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmD5V7ZzlgMVj;
	Mon, 30 Sep 2024 18:16:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/21] powerpc/cell: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:43 -0700
Message-ID: <20240930181600.1684198-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930181600.1684198-1-bvanassche@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the number_of_interrupts() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/powerpc/platforms/cell/axon_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platfo=
rms/cell/axon_msi.c
index 28dc86744cac..b7996bc091e6 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -112,7 +112,7 @@ static void axon_msi_cascade(struct irq_desc *desc)
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
=20
-		if (msi < nr_irqs && irq_get_chip_data(msi) =3D=3D msic) {
+		if (msi < number_of_interrupts() && irq_get_chip_data(msi) =3D=3D msic=
) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] =3D cpu_to_le32(0xffffffff);
 		} else {

