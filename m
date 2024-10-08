Return-Path: <linux-kernel+bounces-355888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B07995862
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612CC1C214CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3121790B;
	Tue,  8 Oct 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="upFCslR+"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C9216455
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419192; cv=none; b=NjQ/JHA+jDA6K0jrA0/k/D1nXxyowTJkFAt4b5YFAtSaA/nVJkbZUqoQMIzUZ8+sMjG/jBcTK3C0xp3XNmVWIoX/RD2Zhke5aUn7wezZrAQ3CAvgbom86z1x4PViPUukXmUZO57IoF39vRcofhPdctS55HkTuerJhd5NpnrRdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419192; c=relaxed/simple;
	bh=4g4+rCe9fjT03ga0XaFl2S9QVagxsEwgsi/Uy47iMxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7mYnfsA7hto2CoI99epKgDax2rWl+lcnmEM1QOJuNKeCbu75+MO1LcIH7kR+mqiqKOr9g4PH4OMkHfpr6oY/LO5mMr2ITu0/nfbz5beGEq5OGcnW4Fn7wXZt0WuS+qoPh3y6od29xFin2IyiaxaO1yYLsoM5TpyaaMUinFbP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=upFCslR+; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGX4wLyz6ClY9h;
	Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419186; x=1731011187; bh=G3QUn
	uM0CAW8g81+YiCD9szTVl0B+RfQeSeKwgSjpAA=; b=upFCslR+OAHEFXJiggN3p
	UeSIUJM0Tx7XzEvSjigJ4iwvtr9D/kMckenXF7ARlLVfkb/WXeOdysZQKMdQzSoB
	WTpRRqnjeVaoeS1KDPclBbWA0g1SV8Prqg0DfeFqPe/55oXqt3qa/zDP4H6dHr0m
	ObKXCi2sHqBzDTtxSMmXRF0P2D8iusBMrvosDOlyH02nUUO7gtqM4Yjx15nik6Xw
	rc2/tBcXma2PhPOBFFJKXefZVsCeqZvmaH4QVNxaFVgc97pbi4wPxH/ZeVxtmcD1
	cZ0ZyvC/Mj13yCN/BfOkQenze8w8jBFYECDR3bgSxwoZghf1+RG4LRV/gCNhRKyi
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id v3ARXb8bwgw4; Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGS4trQz6ClY9L;
	Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v2 07/22] hpet: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:46 -0700
Message-ID: <20241008202601.3737326-8-bvanassche@acm.org>
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

