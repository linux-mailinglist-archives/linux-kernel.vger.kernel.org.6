Return-Path: <linux-kernel+bounces-355884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9251299585E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB591C21209
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E5215F58;
	Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="n+ckes7m"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75D215024
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419188; cv=none; b=JUsTpLobp/D6HHS2KaLH+XQf/ne7EpyKgGWdu/KHiTRLOImPDJ/g05c7+Ej+jkD3cYVXypblpg5qLmLy3xeVJr8rLa3kBpINVpqyTdXRrd3DLR75m4DEVwPMdDJkHDr77UatqlP1FL3pmG+lf+ulYkGt3ploWwshMKOClV4cog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419188; c=relaxed/simple;
	bh=GwL3T8/NAgxurVcKfArdlqPpL3Gi/OqPSpb74GoAS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMG7efkB5C4NJmrokeC3+U9DkcAZ+dYXq7mt6YTCn3GFNFmmBncP7qjqxNekrBO6opMO607qtMJmL591N6eAu5/e+DNXboVpKfdszIKQb2TWuwTLGO0a98NiRgOIc1GhVNjM0PsdT7c2e7XenFG4E8CFGkAI6YGrzMrYqTzQn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=n+ckes7m; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGV2VVCz6ClY9c;
	Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419184; x=1731011185; bh=teMoD
	VrbQQRpfWAMGe5SkP6JT1y9EEqndgcPVPB9Azo=; b=n+ckes7mwmctAyEPxF+Zp
	bjJcmgij9TDVbdjo8pZMERIFvZk9vesprhToRJT32JnXW7rsUKPw4Kii2qHg+F3M
	VuU+bT8Fd/RIeq+TfilmQMLFwMQku9RZHa4QWfojT50L2Otv6TnDHJijHegTrVIC
	dq4+BJJbI5b6bDW645arnhyxdf1WQk0vf+VPA8hqvGGjxlXbPoE/sQkZZu3yGg3N
	m2yiCae/3ddNdwz+8TE5j8ekZY5SklE3w0mea3QsNtBjkjWIg2gbgIkcmKN5h0fL
	pBSWuePsGPEjsnNW5rxXDxKUbRiD49/H5B2XqEOvjAEcFYRJzh0s60dTYHxBh6ea
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oD_cL8X0JP05; Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGP2qHXz6ClY9N;
	Tue,  8 Oct 2024 20:26:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 02/22] ARM: Switch to irq_get_nr_irqs() / irq_set_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:41 -0700
Message-ID: <20241008202601.3737326-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008202601.3737326-1-bvanassche@acm.org>
References: <20241008202601.3737326-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the irq_get_nr_irqs() and irq_set_nr_irqs() functions instead of the
global variable 'nr_irqs'. This patch prepares for changing 'nr_irqs' fro=
m
an exported global variable into a variable with file scope.

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

