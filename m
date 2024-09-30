Return-Path: <linux-kernel+bounces-344613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6598C98ABDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147471F21B76
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B51991DF;
	Mon, 30 Sep 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GvONdykt"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570119D8BC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720213; cv=none; b=Zs8NMyju4iOXpBnqEkgnmiMTPnuPAJs22RccNUhA7efy8aZY246E7m/XGjgxjwcYsgn7JqKqAOwvZ91vaQ2ExNs1GIc6ZKbBuhzpi5tjwhzg+sMCbfR04WV9SPpHjjQk48Y60nDDc2nx5UYzNmk1msUw3zKsjET+pz1/nzoPopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720213; c=relaxed/simple;
	bh=elbBnFaboBEhKE8L7Bl7wq8Vh9v9tzVvntJWKlqpPKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHxyxzaf5ULGabhPM8mPgGOUpQ12vZuRB9alrz7L6zELm6ceR8aMjarwmKF0NqI4tB/Fdeu1tHBgGD7Y5Lu28xBqiKaN38f+QJmwD4BeUinNEUUONRzRIVyQopGkmWVEF2SM4OH1HngIbq4hm/m2rN4qF3nag2qh1hVGqco1Qig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GvONdykt; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmR3KJZzlgMW4;
	Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720197; x=1730312198; bh=DPrnF
	K0dpYtOOzZYHtSHUmrlCC/d6Z54q8Zc86YJrig=; b=GvONdyktBlMhQU9kjLp1W
	ue+DMNJVZdtZTR9qCAN45kM/d5h8d+0enBUp/wLKF7Cz78nmbNPwPBoYo0icirDi
	dpNiI/BbKRClJ08KfIdcOsxMaGwIyjkwGmWGENkdngNf1i2MaBvOTAtvlvWT+oSq
	42LZnRdFgTWqc+fZH7wGoXOJnC+eXRcPRwkjfIER7W/Y+wm2cUh/ErSnvVKK9Qj+
	SSw7lARJsgccuqF6I76LxgXWmSagbrrd8IYs3SBI1osATueqvpIdWytWPiv9r+HK
	DfWBZiO6xlNTG/jQtkG14FEiX5DjvCWOy10yO0v1eCjuWfN5smCy/0kSfDsMRU2f
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sczgfUcg-IqG; Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmN4JxMzlgMVp;
	Mon, 30 Sep 2024 18:16:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Timur Tabi <timur@kernel.org>
Subject: [PATCH 16/21] serial: ucc_uart: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:55 -0700
Message-ID: <20240930181600.1684198-17-bvanassche@acm.org>
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

Cc: Timur Tabi <timur@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/ucc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.=
c
index 53bb8c5ef499..73bdb306a160 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1045,7 +1045,7 @@ static int qe_uart_verify_port(struct uart_port *po=
rt,
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_CPM)
 		return -EINVAL;
=20
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D number_of_interrupts())
 		return -EINVAL;
=20
 	if (ser->baud_base < 9600)

