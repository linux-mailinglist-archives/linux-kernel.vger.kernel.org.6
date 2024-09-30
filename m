Return-Path: <linux-kernel+bounces-344614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5C98ABE1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211411F21185
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA119F10E;
	Mon, 30 Sep 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tTdg6DMN"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C219DFB3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720215; cv=none; b=DVEmKi8dScAupR1ztLlHscgsat75aXFHIp90I2wBXa3o88Vyp7ZwzTj8H/Uuc+5lAyzeS4MNZeWPYF/ugUIeiOlV53A+GPvAQHu7EzeqayJ5rfqLpsQTgMywmc8UslojP903xVUpK88maENCOHla4+AX+1dIli6zhGx0U+OUgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720215; c=relaxed/simple;
	bh=yY126fpNQKloOUBb/bLXX4qB+ANKr8lK0wYuZzQNHBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf09tnCisTd4sCpRhIBM7lryK0yxtgIs+/nv1vkUd6D6I620/B6sBYyLb9ssziIiUYiHs/cDnzyWIpfljmQ1Ziod62boSvFKw+Q6ieRB/1X+ciAP+IDHhx8GRCF6ney0gpEs1EqnTD4CDVyosN4xzFEYq9K/7unnZEqgsAFsAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tTdg6DMN; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmS4lVczlgMVg;
	Mon, 30 Sep 2024 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720198; x=1730312199; bh=pzisv
	+a5MmI7qfRna2sNh8SvaZCFQQ4DC/6HLiU1P5g=; b=tTdg6DMNcRHFUcJtS1Rse
	lzrOl4N7AzLG1ozTUmkgJ+qjiCSUgmqNFQcWxPdSSlIwaiyM1VBHEco4b6eABhSx
	lrR9uCrSXlLZKZyoTBRbL/Jr3jeYzlwJU4HqYEKBJpIDZ0Z/mdZq6oXmXBIu6urS
	KZ4B8v/6gvKE4qh/pfZX2lmIvwTFlRMc+19HyzRb/QNlFgYay6tikQz2ZDP/8vhG
	nhTvbgiKL8dyqojTcbP07nj+oV4T5aNjigpBxd/53oYJmwmHEqMk3Tpb1tdhd5Gb
	W3CDHfGfeP6ZLvQCsXhpsySp5GbpovthmJasJAkr/FlWrSCDjMzUj6f+mUVzJCAH
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CoZANu8PyOqr; Mon, 30 Sep 2024 18:16:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmQ14YKzlgMVc;
	Mon, 30 Sep 2024 18:16:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 18/21] xen/events: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:57 -0700
Message-ID: <20240930181600.1684198-19-bvanassche@acm.org>
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

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/xen/events/events_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events=
_base.c
index 81effbd53dc5..3c020b3f583d 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -411,7 +411,7 @@ static evtchn_port_t evtchn_from_irq(unsigned int irq=
)
 {
 	const struct irq_info *info =3D NULL;
=20
-	if (likely(irq < nr_irqs))
+	if (likely(irq < number_of_interrupts()))
 		info =3D info_for_irq(irq);
 	if (!info)
 		return 0;

