Return-Path: <linux-kernel+bounces-355886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0C995860
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD301F246E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27B216453;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nP6zLf64"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F74215F55
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419190; cv=none; b=TCtS8DQFGCkEQLVLnN58NY3a6XlQJA4P4Zr2cQaBC61oRieJadTXYN5T8BWu3MsL7z4enpW8g7RWVfEL2Fwlss4xzFcCattqr6JZI9lPRdtcrDpn5L4w1w6U9l+TfTOKUvBV3PqeNd6SG5BSoEjMAqwgNXVax8rwEIF5IjU2TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419190; c=relaxed/simple;
	bh=LZHlm7CjWTjn4ZVlwuP1XH0lQQa9FSrmpnkGHu9aEDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2uE5gNDW/JeP8U1rsM2zsRIz5KWHqhuk629JHlQ/ZW2pCm1f010dZwiyHa+yRzM+1Z04AqUfioWH7SF3+KpJ5KKjq4bVy4vJZnBwwrPcDkgmsHiNzQCCXMrC+cgFdcWZvjVi7gZmxMaIE9FNILKZBkp1WT6zCUP5rTiBUbK3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nP6zLf64; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGV5q9Lz6ClY9d;
	Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419184; x=1731011185; bh=MyUaP
	bvugmKd3NVvycIqSqhXcIEjEkyEltEdZjwCUac=; b=nP6zLf64ncxoqFuow88JG
	PVz/1BU/VJ0/+eAKkW0zzH1vKaMXqfNnI+SbvKfnQnW3rPvLOt1klprltNo9c0Sg
	jNqnd8L6Gbk6qsksxWUNcq+M6nAkaxfiUH2wU8fV7vMcoVJBkkkrEF3Sjv9RQ/sP
	ajKN4yd1zEb4Ht7QqtAXvScPla4VlogqMUI8jtIAH/fjHgEZEaLYc3bO1kw/U5Ft
	dMtxLERx2QBPC9ozZ9IejIWwTCggADUl8ehPHUyTHn2NHFj/zpvcCpPh3KgJDCmw
	vugGMRrqC7i8xVZYdPJ+U3QhPo/oygIhpWCRXBWRceiPPuEhiM64BEuW8tzgx7Uh
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id n9sqEiyXRz1i; Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGQ4TP7z6ClY9Q;
	Tue,  8 Oct 2024 20:26:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 04/22] powerpc/cell: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:43 -0700
Message-ID: <20241008202601.3737326-5-bvanassche@acm.org>
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

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/powerpc/platforms/cell/axon_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platfo=
rms/cell/axon_msi.c
index 28dc86744cac..d243f7fd8982 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -112,7 +112,7 @@ static void axon_msi_cascade(struct irq_desc *desc)
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
=20
-		if (msi < nr_irqs && irq_get_chip_data(msi) =3D=3D msic) {
+		if (msi < irq_get_nr_irqs() && irq_get_chip_data(msi) =3D=3D msic) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] =3D cpu_to_le32(0xffffffff);
 		} else {

