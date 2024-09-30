Return-Path: <linux-kernel+bounces-344608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C498ABDB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27374283833
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A619D087;
	Mon, 30 Sep 2024 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kBXnYR7M"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30D19CC20
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720209; cv=none; b=EMKZhvym8vw7EjevVVtgmDsquYh5LpL4zxmm2CQVsWnzp6CHo37LitkJNLrfXLShlz1mpku8Yf6mLlMLBNC4eeYfjtK92EjjopKcft9lcWV2ZCWEEgJR/+qxIWCVfsqWZZn5UiH5ewpDsDz8ysBuYnx4/9fJQjp5Rfh17etGfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720209; c=relaxed/simple;
	bh=/746B1eXYZ4bBzdzOVzZg3wkKT1O/Qxb4H5zg2Odi7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXLX2vgUW+7LzBFL0zX127Mn/MhSwsaMFZb40fmw7ouJC6PpRge5ptvvvmRlOWLeWv0XjdRCjbfzrZ+o9kEqb04fI9sr6RySXomU5GmhPTW3e77ZWVHXE0vdIDeoahHPoNUBhXLT+tqQ21K0Q1Ll1gtX4Zvm0/S+89EWyG4cUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kBXnYR7M; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmN2JK7zlgMW0;
	Mon, 30 Sep 2024 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720194; x=1730312195; bh=u+sFl
	u8eJJTe64wgC0yKvq/efAuGCOLY5zAnQdyMmvU=; b=kBXnYR7MQZyOupxy4dX6i
	CJ+AwilNKpvdn6SBSrMoiy6/+UcJU/BxZ4rSl/9Y6MO3P/++hKZm52so1rLRtYgy
	2A2ExCtkWvYSzSLmv5MZhd6ZAnqgyaiywj3iN8Z6XrPE4oLw/NXSo8o5HYvqsWZ4
	RQoK1jayIhsNb2AfbJ3+J17TOVTxkk4XF/JMbVWt75425OzzCgqxUgl7XT/XxW2p
	OVQeMRMD42+k/aYPuPZ2HciVsLAq7aMH61iDy1RCS6KhoUrUIpZj70HBgtZiGSbY
	m53Q90Jfkf4sYbgujIsIjkfHgUY17IxuFdAjc26Og39Z31JBeLE/2VCD3+EzbiX+
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id U4kccfj2g-h3; Mon, 30 Sep 2024 18:16:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmL17cXzlgMVp;
	Mon, 30 Sep 2024 18:16:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 12/21] serial: 8250: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:51 -0700
Message-ID: <20240930181600.1684198-13-bvanassche@acm.org>
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
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
index 3509af7dc52b..7983526539fb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3176,7 +3176,7 @@ static void serial8250_config_port(struct uart_port=
 *port, int flags)
 static int
 serial8250_verify_port(struct uart_port *port, struct serial_struct *ser=
)
 {
-	if (ser->irq >=3D nr_irqs || ser->irq < 0 ||
+	if (ser->irq >=3D number_of_interrupts() || ser->irq < 0 ||
 	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
 	    ser->type >=3D ARRAY_SIZE(uart_config) || ser->type =3D=3D PORT_CIR=
RUS ||
 	    ser->type =3D=3D PORT_STARTECH)

