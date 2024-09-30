Return-Path: <linux-kernel+bounces-344597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD1498ABCB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7791F23A91
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4820199396;
	Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AnhKnrV/"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F0198E96
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720199; cv=none; b=i1jIH8gWbUu7txyducoKNtPhQ1yOJmTftkOhUfPvpOpbpcLMTXVjqPmpjIZQAz3DtrBXRVA+6OD0LT7LlccFC6XAyx1ygYZ4HWQDUGGkE5NmPLFdseCaQfuJHLDPcvmbGpVmE/pXFmzciOxEx9b6guH5lOp3AP5qpNR7rNIReyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720199; c=relaxed/simple;
	bh=WDwc8gYRpmtgbBeDHWhLAwhbFk4YkTn2Rhm0f3uqWv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj9dlCjlGbuDZBiqbH1f+MsPLIhjphLVawrdonGjIipwvDqww/Br+c1SVfoPwd0XUIxuVwQiFm/i6I6wnAvnaZMDNOJjHGvOexD/rdhRdDFEcLku6Dz5xnLyWq9xKCuwpcf6EEWc0D8SfuMi1MbTR/4hqL+3VSBxp+glHZutTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AnhKnrV/; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmH2QxjzlgMVq;
	Mon, 30 Sep 2024 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720189; x=1730312190; bh=VgE4P
	OwXumHDhbRY9QKpNFZsu6mNBvvMCT12mJbhiPA=; b=AnhKnrV/mSVKjVYVo8tke
	33+4elrMc0zFln1DlMfnGIfks0xgQ8vTRHZ2Q4UkAsP9JQLANT56KvDRaa8DLubB
	X5kGGsahV1uIBD6ByUC/baebWn22tCaerue90UVUkE5nIKYkyVENVxnxAcc1qzDD
	eKFtN1e7oUen52p9asaY3mJSZ9A/eTpJlq86Vw2Zf1DlbCvnWb4cn1V3XwnUYW5d
	iKgCa2+QxDtu+91AZc9npFzAeuiTFu8zZ+i+MWcc4aHOsmMkJaH+wVJ0cUsS4k7E
	7RZdXuxFjuHaLBs+TtlV+V7nl3ES7RV79He+Lz90IIJ6SQvCJGL57x7uRCxLFs2W
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vk56X9ezNWrz; Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmC3SH3zlgMVg;
	Mon, 30 Sep 2024 18:16:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 02/21] ARM: Switch to number_of_interrupts() / set_number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:41 -0700
Message-ID: <20240930181600.1684198-3-bvanassche@acm.org>
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

Use the number_of_interrupts() and set_number_of_interrupts() functions
instead of the global variable 'nr_irqs'. This patch prepares for changin=
g
'nr_irqs' from an exported global variable into a variable with file scop=
e.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/arm/kernel/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index dab42d066d06..cac062d5c8d5 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -111,7 +111,7 @@ void handle_IRQ(unsigned int irq, struct pt_regs *reg=
s)
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(!irq || irq >=3D nr_irqs))
+	if (unlikely(!irq || irq >=3D number_of_interrupts()))
 		desc =3D NULL;
 	else
 		desc =3D irq_to_desc(irq);
@@ -151,7 +151,6 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-	nr_irqs =3D machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	return set_number_of_interrupts(machine_desc->nr_irqs ? : NR_IRQS);
 }
 #endif

