Return-Path: <linux-kernel+bounces-344598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A7F98ABCC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46DA1C214AB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF94199930;
	Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Vq9qMDyH"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52371990AE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720199; cv=none; b=jwyRhJsfCIX49YzsW/h7P3vSQpq3Zh/m4NFu4WBh/Nui6qeJWhcdtWdh/qdDaNdI9ItPoSbZSgzk+a3ax9dGHmU9tCv/Q36Jo30V8wydT3G5/3cJ4M5CcrIHGOLunVfY1Q5Dn1zcuS8vjIMagCqvfD3BqUz6eW2+4y1+vbRehUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720199; c=relaxed/simple;
	bh=5I6wz9M27IcXTxnFZLa/TqfhYhbKFw6K5/l72hHPrFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSKYrhTVU23SPBEV5FaVVwNAxqGVJvE2Jq1urC1aMtm4/EY4xc67T3TLVIS4aorIckKBlXW8fQy2pQuIvtHuveOwvlVhOIkRFjsRdM/Vcgk0SNG9Qiina4dryRx1Z7duy2LPyiKYofn1dod2SoDmu1OrWdV9vhH6DLLxYTshetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Vq9qMDyH; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmH4wqqzlgMVr;
	Mon, 30 Sep 2024 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720189; x=1730312190; bh=uAc6w
	J2DvVJs/XUQfbj8AVim8BHt3tJ+/iQnEfFBomo=; b=Vq9qMDyHYgOZsfn2mZs1R
	ZbzujqBT7Us7f5rnEPpAVwtRW+YX0vrF0Bgw9tJZjdyzZn89AgqtbkiguCAi0WdW
	lxj+yNR5V24Io6fcne+KCHAMcuMTSP5WUnY73zG0qa3e9LHStI/E64gHYv6Clk3w
	4fTxU0bfiGOPmq68MizUwNffERGTzW2yyzOhrteJtnDCXUbsuroZU7NfRll9+qcu
	xX9rdiL+o3pmakg1SuzVb6OWjCmdceMkah9BeR1GNgKKA2IzBjuwrtWDPBIFuVD2
	vte9cgfb6yEvJ30/B3tJ8danUDdvUjLtccE/uaxmi6e/epl2ASnqVY85t7MJhG5t
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 17P_pviP5kvQ; Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmD0DCrzlgMVh;
	Mon, 30 Sep 2024 18:16:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH 03/21] LoongArch: Switch to set_number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:42 -0700
Message-ID: <20240930181600.1684198-4-bvanassche@acm.org>
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

Use the set_number_of_interrupts() function instead of the global variabl=
e
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/loongarch/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index d129039b368b..8eae704ab5e4 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -92,9 +92,9 @@ int __init arch_probe_nr_irqs(void)
 	int nr_io_pics =3D bitmap_weight(loongson_sysconf.cores_io_master, NR_C=
PUS);
=20
 	if (!cpu_has_avecint)
-		nr_irqs =3D (64 + NR_VECTORS * nr_io_pics);
+		set_number_of_interrupts(64 + NR_VECTORS * nr_io_pics);
 	else
-		nr_irqs =3D (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
+		set_number_of_interrupts(64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
=20
 	return NR_IRQS_LEGACY;
 }

