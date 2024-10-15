Return-Path: <linux-kernel+bounces-366528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DA99F6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E184E1C232F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D21F9EBD;
	Tue, 15 Oct 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YZjQMa5c"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AD1F8198
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019435; cv=none; b=jZZ3iGHopyevOt4grXXfuGHraYBSQ8IK36knYjzck+nIsiSHe9Zu0HyNZDBlaxzNCIvnZ2baP4FBnQ464aVZzacqM1Qxu3JBXopPoDgXlO1/zEwhnluDFCrGqgOLC0J9nIZ8S/eGrjkHacPyCzOz/nNOoOVF9smA1qMfVLuFUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019435; c=relaxed/simple;
	bh=hdl7P3518Wa8B2pH+sfzuuxEBq3wpRU5CNH/4ln+ta0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzyMVuQH7PRcrzAIhQEMr0yp/radG/dI4HrpEaPR/NXXYXSdMAAqw5ZVWxDhgpbabuv9g2kvm5RNpBdQsOUjT6IdQOixmHuBElkCVvVTPKAO6IUcgWRrryY4yZ4B3uPciZtE7RlWx5Iut7+173yngX3gnv24ohuBaQ93ex1Eu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YZjQMa5c; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFh2D6rzlgMVx;
	Tue, 15 Oct 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019429; x=1731611430; bh=E4Yda
	0E0N/XZhjJiXkfg+hITaLxsQBgMMyd1Qzy18BY=; b=YZjQMa5cOdMJBezhcaOMe
	+ciEIpmbjc3T6GAxdNXNaZHHc2kiTI9GI1BjQ0ExmyDh8vLlWsOl45a1JJXyUJMq
	VxqJjOK9zKZqMzZJALRGxx78KRxvb+IcIRX5sOtmxMSPBh5UIvryiOgO7t9K6nxQ
	eZgv4EiP7iKoQY2V88qffOFW1AujYMiBKfRBVSs+jUdBHADD0LFQ12QSZ7xHm/W6
	1KK+l10W5O/qTO47pFMnWFdW6s3PGnvisP8YZVoawMO/nrgqZsevUPo/UfOpWoFl
	vfHo3Zv3IPWF/K234T83BV8rtKXZ4kD7AI99fRz8WnsTH2p+fvDOP+wRCeX8LiZu
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Gfc0b7DyCtZU; Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFb6QB3zlgMVs;
	Tue, 15 Oct 2024 19:10:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v3 05/22] s390/irq: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:36 -0700
Message-ID: <20241015190953.1266194-6-bvanassche@acm.org>
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

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Cc: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/s390/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 2639a3d12736..a2c867181b5a 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -253,7 +253,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 		goto out;
 	}
-	if (index < nr_irqs) {
+	if (index < irq_get_nr_irqs()) {
 		show_msi_interrupt(p, index);
 		goto out;
 	}

