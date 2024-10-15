Return-Path: <linux-kernel+bounces-366524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5D99F6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927B41F24194
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA31F6689;
	Tue, 15 Oct 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YOApN+Xd"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDD189510
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019431; cv=none; b=IoyD9FEqNKHM3mGWT2LbjnadBdx7oO84GZzMya/AC+TQ+yo4VJ+iKWXOD+Zllf8Vr+N53sgfulrgPdi/vg5P/hT1Cf/vjpYCrzJo7vOnrM65KvWpYM863CF+gFySqIkpNtq2bhX6uG3ureOrg88AKvcbHLuUAMhNF7A8X7K9Ml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019431; c=relaxed/simple;
	bh=bQUB7pynh9jjkq7C2QfJNutdv3zPU7p53lT366Klq5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHq16SuUs+kUlgWMx0sOTKFun6qmaxebz5JPGLOAjbHVSudp+bxflHxB8UUDM+LC9uApoQFtLl2Cz9aUOBtXjEUn5PcjED2ywdKHJC9yLGtCfYC9/iOXfFHzaumH7fJxrkfPR0x4i/sQe51qu0T7bPVwBTYKrWKcrX++kPTwWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YOApN+Xd; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFd200qzlgMW1;
	Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019427; x=1731611428; bh=a8VVy
	ORugI65pZgJ4lsYDnzdi/YfbW579d1FONGibXE=; b=YOApN+Xd6ORuRC4Obgx59
	zwffsbNNCOIBNH7tcD/DmSac8Ds+a0YEs8P7pmnYOXtHfTstw9dXyi7jgLioaraO
	x6uvel8TDyOqIDPwqjc847jEjb2/nl079jF1Y0wSae6Pnxqzaz1AlFx8qgdjZpbA
	VA4ec0bDQUnW8wjXaiVPvgrDVNn3DdrA+NMidzu2ZyOuCysy1YhnL59rfq5G1hWT
	D4oIpIZirDvbh3jbVqZJ0f0ybr89UjibKtM1BBEaAosBXSWvAN3BtQi1sMDmBD5y
	dsBTr3yc7KypmuIBksbiqT5Mev4YHktWYtQ/vS+y6DCLrSICmwjOKxezjRjG+VX3
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uWXsc0yOTolb; Tue, 15 Oct 2024 19:10:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFX1wmgzlgMVv;
	Tue, 15 Oct 2024 19:10:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 02/22] ARM: Switch to irq_get_nr_irqs() / irq_set_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:33 -0700
Message-ID: <20241015190953.1266194-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241015190953.1266194-1-bvanassche@acm.org>
References: <20241015190953.1266194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the irq_get_nr_irqs() and irq_set_nr_irqs() functions instead of the
global variable 'nr_irqs'. Prepare for changing 'nr_irqs' from an
exported global variable into a variable with file scope.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/arm/kernel/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index dab42d066d06..e1993e28a9ec 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -111,7 +111,7 @@ void handle_IRQ(unsigned int irq, struct pt_regs *reg=
s)
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(!irq || irq >=3D nr_irqs))
+	if (unlikely(!irq || irq >=3D irq_get_nr_irqs()))
 		desc =3D NULL;
 	else
 		desc =3D irq_to_desc(irq);
@@ -151,7 +151,6 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-	nr_irqs =3D machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	return irq_set_nr_irqs(machine_desc->nr_irqs ? : NR_IRQS);
 }
 #endif

