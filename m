Return-Path: <linux-kernel+bounces-344611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C4B98ABDE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7564B28375D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4319D8BD;
	Mon, 30 Sep 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TIwefqC6"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BD19D082
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720211; cv=none; b=OWRYEg+uYwDwXLm8uoeFfSJWqiClwpW6nWQ/Be4UvFNliGvxEO+mC7YY4KyEZhUWiuo0s3YmPDgHNEwQkydVU5JRNCe9ELHJcXMYnJ5vPwflvY3937pxN3jjSfoRKPsQc462JQdm/8rlVqE4cu0nd/J40RGYuWxgPNAPFgI8xuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720211; c=relaxed/simple;
	bh=USEVRV59wrWZF9ktvY4Wt2hvc8UNViV538emReu7Lfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjPCDI6xOp768x3zex3qXnnFwvC0yD816gPWeQO+rkCkV6mBXCvn/rJgx64V4quFa/AghkZ4g6HM/H2CxD6Fpl33IszGMEE/dGVcK1hy6pVuwGGmDuZFAuRH3R1Oc6XG8Gn92t5/4O9hG88fqh6Fwbm/bIX4FkK021Ka70+wn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TIwefqC6; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmQ1zh4zlgMW3;
	Mon, 30 Sep 2024 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720196; x=1730312197; bh=dol9f
	d1k8nolm+CvUvBoAtlfmUf3G9p/YNW+cEUXfGI=; b=TIwefqC6o5hv0FkNtEQT7
	HpxS7riKMnlx8k+RY5/CEYl7rP3dMCUmmKkdP/CwXaEePEjhdXSdo2hzg223VLzm
	KrtJPEPKRHgzG50AX2DiA2ANzpZsAX3BIFOF748SHVTK37U3fLuD5axcOFXb8bVt
	w3+3f0kz/csn9EFxMIfR/BU+eO5Qc/UMq37pYFREoqz9cBcw6mLQplORxxXv+j5l
	9yt573okHScgz/FZcupHnzBiKdct2crsZpoYjU08Au23kCPnTCoQyENcdBdyojwd
	O48Q2T9CfY46I/yqevrO93QKGR4Y6AK/ZkOonRf7KH+1qTTo3V9YicKB1LktibJ1
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2gzk1gNurX02; Mon, 30 Sep 2024 18:16:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmN06lhzlgMVt;
	Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 15/21] serial: cpm_uart: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:54 -0700
Message-ID: <20240930181600.1684198-16-bvanassche@acm.org>
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

Use the number_of_interrupts() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/cpm_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.=
c
index a927478f581d..7ead7277e817 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -631,7 +631,7 @@ static int cpm_uart_verify_port(struct uart_port *por=
t,
=20
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_CPM)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D number_of_interrupts())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;

