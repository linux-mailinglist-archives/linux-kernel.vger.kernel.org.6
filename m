Return-Path: <linux-kernel+bounces-355900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0599586E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25197283918
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B421A71A;
	Tue,  8 Oct 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="VbLGoEFt"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981F21A6EF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419204; cv=none; b=FSH9586/80B4VGFMowJ+UuvlquK+bggPpoWEn1Ce87tY8PKCCpKsV8aeZEa+n54lj6yC05urTbNuOAYVx5Gh2tJMPrzajvMox6uh9IYnzJuNdtUgF2ncZoxKy4FV1IDp4dZq6YLBQI/Qkgs2OVymOTW41EzZ6TOD1N5nfQqjZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419204; c=relaxed/simple;
	bh=re/kXkGT5/zjgbRY6YUf91t29Klzj2YoHn5+Kb1dGs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xzz1obr2cmLiOXF+z6Qd6nh8RcrebZu+VcgfUg6ayg6/o7z/Oue6Nmtj6Nl+T/H3DpVKiTtK5GbGaHlAuXFhDuV5VMcmfZrGCoq7Wog9JBo/eFW74AdRSoYgVvMEqpX3LeGwjktbGJuiWTWmE1ITOcWA74ZSJlJaWN0z48SPFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=VbLGoEFt; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGf1Q7Fz6ClYB0;
	Tue,  8 Oct 2024 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419191; x=1731011192; bh=p7o11
	FVa5oIVd0b764Tqg46wzHmV1oraPIo4X0Cac5A=; b=VbLGoEFt/nq4bVh20T6H1
	4ALhykzDUhl3/PxqpOKIjyxxzx51+uFfoZ9gCG60iV27FwXMAARmVR+Mtj/1zTqj
	Wxer0U9NOETfE3fMVqp0ep3lQWiJQq5O/RX8UHPxVPih/Yvrunih6zvpOjj9VPnO
	JcRNTUI44bF1loZbM1ntcqCUXmVAE1sKy73By9l55ihYFUArszegDk0Sl1ap6v2p
	OlY1LSpczHQ5wvysoFYvuEkgjqvDszn3fDhIEDvv/uEwoLx7OWeiSvIOYHLIVCd2
	HKOkV73wGYYDX5lhXaR/ErcSjFArQ9WUhnWW1UEO7Ky9c3gAxvaWioC7Dd4cSVTN
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 72tRgjD0rhz8; Tue,  8 Oct 2024 20:26:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGb1fhbz6ClY9g;
	Tue,  8 Oct 2024 20:26:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 18/22] sh: intc: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:57 -0700
Message-ID: <20241008202601.3737326-19-bvanassche@acm.org>
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

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

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

