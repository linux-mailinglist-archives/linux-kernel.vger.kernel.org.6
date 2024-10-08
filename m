Return-Path: <linux-kernel+bounces-355893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5853995867
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA7C283276
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4685C218D8D;
	Tue,  8 Oct 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lmrd/5Q+"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBD218D63
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419197; cv=none; b=buFpubteoA7f0lNpvgGIhpVRHU3hD/tpkRFoh4DOZijUtI/zSok5UcvI19q9fGbenzYtx1wPDvawtvZQ+AmdmurY2FkQApLylWBU+go+7EnfN1+oMIStHPFN4qihaaKEfKlx78Wc70tmEgz9D2zh2JFgX9WivW2uj9aKKsoP8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419197; c=relaxed/simple;
	bh=N8Pso7LIEKhmPYJAcyd+pmpEUBsrBXHmEtMjCkJ+cks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOlyo/QlEf1Byi5xYVxa05id2ESU0NTwOna+2qTrE95C0LElm8L4SeHh9AdjbeNzeOSRrKITaim2ky2ijOCmKygQ52zxiJyBhLyvjIUQt6antKUSgqpnQe8jtkLQgzFN+WkgD1UQKSC4wOlnYAp9JIzLa6+2UuUNw3s8qjtR4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lmrd/5Q+; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGZ2Z8Qz6ClY9Q;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419188; x=1731011189; bh=s82ew
	VfzzQ8AbRkob+216KEVDAY5/NdueDD2UstRjTc=; b=lmrd/5Q+ebJYB3HqNEUU5
	jchmCRRXrHExl7Be/IpWeYaku/zXEvTPZ+Ttf+P8/1EJupKlehPk28jnxSxQAV6g
	DJb9hgCASlumEWmZT8/Io0QAv2MxNEVg88HlwBxzUJhobzrhyGJHX1PMaAwg6Mnj
	7AvAD8WJV2S7bSExBu6GpL9JcwFOM9TzOpSdO8HEBc7NrS5aSN7skS+UOTkx3mkX
	eKcGjvo76B5fgn1co/KAyxEPzrNC9Vd7wqFW1Y0t5WmLM5Ove+eDJzxErpsqjlOM
	LB7HsAdXN/kvIF24FN+OJ8ZVzOjvWc1ywCnRog5QEKXWdlwZb/vUrjTr2gtoydx+
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id E14x2V409nIb; Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGW6CzQz6ClY9P;
	Tue,  8 Oct 2024 20:26:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 12/22] serial: core: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:51 -0700
Message-ID: <20241008202601.3737326-13-bvanassche@acm.org>
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
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
index d94d73e45fb6..74fa02b23772 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -919,7 +919,7 @@ static int uart_set_info(struct tty_struct *tty, stru=
ct tty_port *port,
 	if (uport->ops->verify_port)
 		retval =3D uport->ops->verify_port(uport, new_info);
=20
-	if ((new_info->irq >=3D nr_irqs) || (new_info->irq < 0) ||
+	if ((new_info->irq >=3D irq_get_nr_irqs()) || (new_info->irq < 0) ||
 	    (new_info->baud_base < 9600))
 		retval =3D -EINVAL;
=20

