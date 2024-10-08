Return-Path: <linux-kernel+bounces-355898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC6099586D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5222AB23B53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053B21A6F1;
	Tue,  8 Oct 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1uhjo6oo"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706A219C98
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419203; cv=none; b=M3AbgYFqBXGNpVz3TmRVApkonVCCoviqGk1VBWszAOtjfqiN+nNTkG2zpYjB06fX1o5QoA1+yV8H91RgnNs/As57lgQGH83Ku0qYzx0sofMRD1q8ShUIGqac8ds1Hy/GsSuyXcbMsEJnrSyN9SSiYLtzXDx/TNDrvvKzYPNOuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419203; c=relaxed/simple;
	bh=3XJdmd66oELlrEy8vgIP+/fNwdroiL4PtG4UX2JO9dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc9olC2vL/xCZeFkc+FfpMfa/+dxYS8JKHXndDZYnySfXJezHjVji5gnKBINdCmzNrln25kwc/FziyYCDioHqH5Lnf5HbA1FDgJ7r8TZ84kq5Rr1bHnXnP/A5NcGwxRA0arCdkeN337MY7D7wtbBoCJRCbaVHHFdNHpJ8seazqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1uhjo6oo; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGc4F8nz6ClY9t;
	Tue,  8 Oct 2024 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419190; x=1731011191; bh=yBBrw
	fXqXxwNlNvecvySeiGRVQDZXt+uV5hagQ0dgf4=; b=1uhjo6oonwRD2Ihm0MlZ9
	eqeG8xpOsGwNTc5AcZdN4yvMnHyRuRtyLHVMJUA72d27JS6Bs+DMsxtUK6BzOkoY
	giTitF+yc+mpDS+dR8t1cSAjBMVJULORxuBFz17k2a9R3oqhE2s1KcKtot2TJVlr
	WQSktXMPXDryHA0AUZJ+iRxXzP3z+FeB3PBel01loRFWLJCpDshq9XFwsPnKvxkI
	cZMcqf2YNx7uSTSLsC1aNhCNa+yxJJzKxHEEs+PBJVxOjxyXfeyfXPhII7/t2yia
	QbcdtDHDdnmhdjpYaSla5AnUWm5c+/O4fTUBwejNDpLSUctco1uMD4+z7CXh6kiF
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mqKQnbO8UTYK; Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGY6q0Qz6ClY9k;
	Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 16/22] serial: cpm_uart: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:55 -0700
Message-ID: <20241008202601.3737326-17-bvanassche@acm.org>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/cpm_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.=
c
index a927478f581d..6eb8625de435 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -631,7 +631,7 @@ static int cpm_uart_verify_port(struct uart_port *por=
t,
=20
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_CPM)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;

