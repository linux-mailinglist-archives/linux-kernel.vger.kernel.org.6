Return-Path: <linux-kernel+bounces-344612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB398ABE0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692C228349D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80619DFB5;
	Mon, 30 Sep 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rUBOu0W4"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AA19D8A8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720212; cv=none; b=IkxZq8hpZ/FrJIORMI/n33i5H1yI9XtlUxqQWmMrfPMC4Ko8uC2FkyfRyCAcYZlXmROt1xLjUfCAufXC46ZKLc2o8Uy2uqfcRVmg50VaT4p9anTLDIP3ieAgqS4MpVgxsPfj4Sz9pm6XsFyR3r+9yzZ6B8mtIrXM+ITU7y2dKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720212; c=relaxed/simple;
	bh=8v/58WzxNnxLRb175HPYtfxGGsDNWsrM0Ct3W6UNqa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN/Poue5O7Fpr/GGpLoWQTC6yyPbtdq9DCEZ5nmb8lMgfggvZleu3N9zes3HgkLRobTcsT6Ot8B4fFX30cuzOD6//I27nd6fGT+fzpZgvpFbkdreU+5D8sppi/ay+O87fEUxWwNOhT4M1qbJ/l7l5F0q28PCrZNZUxsU5jOJkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rUBOu0W4; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmS0TjqzlgMW6;
	Mon, 30 Sep 2024 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720198; x=1730312199; bh=5a6po
	uSYWdtK1TWtGuOchtoffRMZMEn/NuCrDlZbg1s=; b=rUBOu0W4IXAvJ/LsXRAHj
	AqXr9VXXuDNVM3//HLCR9jr2G4WYJ5qqZGGTQFtU7r2kY77r1Cj58hapkxKu8f4Q
	fXfSg5n9ya/zDdzqnIG7GeK8LvTAHWa4/IV0YMuyUYIY6wsJEfu5MsIxZLuRPPrk
	VAkf/2eZ38PgJODhlrdIUQYUlPf/txE6I6BVRorFSyb4yyV9f0fJj8AC5TXDUA3g
	tjP2MCWQBPEhW1Jn9HFMlpV0GptXP3SffWbNuHi/n2yCuSZAiiDdXQgp40JlQ4ps
	jNOJoMfEz+qy8vAg9ubsuZ7TPj0iZvThME3+dNQv6FUIzm9MOPcGHLP/BvkbIvSL
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gIGuqHPtpyNT; Mon, 30 Sep 2024 18:16:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmP3fH3zlgMVg;
	Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 17/21] sh: intc: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:56 -0700
Message-ID: <20240930181600.1684198-18-bvanassche@acm.org>
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/sh/intc/virq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/virq-debugfs.c b/drivers/sh/intc/virq-debugf=
s.c
index 939915a07d99..09d685cda79e 100644
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -22,7 +22,7 @@ static int intc_irq_xlate_show(struct seq_file *m, void=
 *priv)
=20
 	seq_printf(m, "%-5s  %-7s  %-15s\n", "irq", "enum", "chip name");
=20
-	for (i =3D 1; i < nr_irqs; i++) {
+	for (i =3D 1; i < number_of_interrupts(); i++) {
 		struct intc_map_entry *entry =3D intc_irq_xlate_get(i);
 		struct intc_desc_int *desc =3D entry->desc;
=20

