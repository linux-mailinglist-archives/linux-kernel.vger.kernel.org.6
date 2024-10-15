Return-Path: <linux-kernel+bounces-366541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE0899F6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D6B222A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D300201013;
	Tue, 15 Oct 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iEW75WHa"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE022003C4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019450; cv=none; b=NKiEvgyTiP5RcwuTuHkVuFrE6QnJARte+7xCErx9/5KoILTxs+6fO1bX6Zkkls6/ST1096noX94MX3PMM12Xtd78TOkQ8igxVSqvJJOqVJIcKPa+QbSXH4s9BJo/MgFi905vQyTTivKfAObABTq69GPp4XQcUOXLhu4wk4Tpplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019450; c=relaxed/simple;
	bh=ax3djP+zZvZU2aaZdzcUsZc/ClscWEMSJQtalnIGHDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwyjrwEePX8l2AKf2ouPgb09Z+vcRkyr331ty1ZDAVqa2SRMgNqgSaW1Ewlpe6D/mxOVchAcaG2UvdSlxsp1vxOjzq/SNPiOFkpVLAjn8ag9Ew8WCVR6ePByKYtvkj6qx9hpC91GQ7dJjnL6vb8RprPOTZjLxIFzRhLTlT/kSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iEW75WHa; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFy5LLFzlgMVv;
	Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019443; x=1731611444; bh=Xd6Zs
	c38bHpyyyul0CsyEa1dCceS06rn+bSuiYRZsXA=; b=iEW75WHaaCFCjYSXkJQ/D
	U6Y5n0B12glC5l0fNQ4/B+NSrgRukmZmsPYwv9hAwVloR0Ybfcil9f0wQG1Ap23K
	11CBdb3uXhx4XytDp1CTKP8EhCzeuldOUnod/KPnHobtygF+TICIgIJIe4Cxan5+
	CttYN38t96eH5xo/9IEPzXsaAp1QNq/2tV555PE4H+/LGXzFFebUG30Iy0cGTMrS
	2jUSXOBxxhSPmzebYVGY8HKsqcmSWB5C/W9eBF+fphA5YPihfHOuPQ1Gecjv+e8M
	L5dGXKENxxsg0SPqasP1RlI2eRE+tJR9iajznJMR//goe3AmkWgb/s/XSCkk8Iu+
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id miY22hxJuvol; Tue, 15 Oct 2024 19:10:43 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFt39cczlgMVy;
	Tue, 15 Oct 2024 19:10:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 18/22] sh: intc: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:49 -0700
Message-ID: <20241015190953.1266194-19-bvanassche@acm.org>
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/sh/intc/virq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sh/intc/virq-debugfs.c b/drivers/sh/intc/virq-debugf=
s.c
index 939915a07d99..5dd8febe6da5 100644
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -18,6 +18,7 @@
=20
 static int intc_irq_xlate_show(struct seq_file *m, void *priv)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	int i;
=20
 	seq_printf(m, "%-5s  %-7s  %-15s\n", "irq", "enum", "chip name");

