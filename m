Return-Path: <linux-kernel+bounces-366529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952D99F6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB381C239FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1C1FBF4D;
	Tue, 15 Oct 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rHhJwuK3"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31F1F81B3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019437; cv=none; b=BGqzxasxLjhbsaUk5VHaVLGq+xvcl0kdMKk45cmM2OOOtFsvUCvW01OzzfQ7uANpbcs48T5JjdV3yeQYIhFI3UF5ynqoAeuNaV3Xyh/io3nEIAGlM+kcEW2/Ij6ughn25i2mgrnvs8SBfBKcYYUBfvAXNTf4oaRx/vyUuxFmIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019437; c=relaxed/simple;
	bh=LYtuUylPHKKH+GlJhGmuWNWP5jskJZLyFB9n0vNCuKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4w05x7ACjKnxgzpRDPBhxyHbuJSLQgNdkJJh+9Nj/hAJUvjU/jU4CqBXCsdKsMsdiyg7CIULNRkX9ktIDhpk0Mi1jmaZ6IF/dwkV2vn2pk5zY1ffChfleTSx6Yb57BI0Q1nfcx8xZFD0g+vAHFiyUAq7wsPzDUfn/UlHzIPTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rHhJwuK3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFh3jzpzlgMW4;
	Tue, 15 Oct 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019430; x=1731611431; bh=pbtGB
	NBQZN396qyjoB0E5v4HeTkStlGxTWnWL8M0RdM=; b=rHhJwuK3P2N+6IGECCSCF
	yZVCY1WOC7UtrLa+Hlnbl3eHKREjM5xGk6lm9trykFgc6MAykscP3QiU9vWHucNo
	o+lC7dma7BfM9oFrwhphCrOaR5O9iJ130XfGinFBKnFx3Nvmqt5i/bwgjUG3r9qM
	T2TrVEj+gAgFMTCwNx2KjcMW8tQQ2RcjCYm+PzKv4YchJsVz5EJzPlrTNy0etbo7
	DoGHjY+sZ6HNykMfu3CrHWsKzRVj8BHNW1QjCeBTfrXudNw6H0jhI+9cWUYt1Tpl
	tMUQQBjaqJgmx6wn98GjnZySYvsl2dqTHaWeCu47apyZGjkgnZJro2EcB+xb5eqB
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HT5k7WwQuqqz; Tue, 15 Oct 2024 19:10:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFf0KHqzlgMW2;
	Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v3 07/22] hpet: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:38 -0700
Message-ID: <20241015190953.1266194-8-bvanassche@acm.org>
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

Cc: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/char/hpet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index e904e476e49a..48fe96ab4649 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -162,6 +162,7 @@ static irqreturn_t hpet_interrupt(int irq, void *data=
)
=20
 static void hpet_timer_set_irq(struct hpet_dev *devp)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	unsigned long v;
 	int irq, gsi;
 	struct hpet_timer __iomem *timer;

