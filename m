Return-Path: <linux-kernel+bounces-366533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93C99F6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73175285D15
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED961FE0FB;
	Tue, 15 Oct 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Hk9/x0th"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902161FBF77
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019441; cv=none; b=DOooceRYUXoGtAhwGipuE73lPyGsoJNPYihPljM1te6vWTmzd2GJaC57t2L6UlOK2SpaWDJDuTjDXkOSfVmcobpcajB7lNHIbXaMnQe/AgT6UpnlBpdXoB87eb2RlmGODtsOWETTZxL5/9unpO8+ltzIR5Q6xjJ340nfsp4g/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019441; c=relaxed/simple;
	bh=i8+UMYwGt+Ax9MlFSymDPDEXPbgE3tjLLNQl/G6fieM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaf9ZxunaIHGHbHBCxVOc8k6Cq+eYp73Bzeo99PG8ugDPn3gf9cvdHp8IsVIbE21zPhbd/rgsELaNt5VUlRh4NQ3c/bSVNCBkNisgb2S8hat3oUr/obYpp8OtQMvPN7BxAbEObIR8FUdT4WMAIwsuM4IcfTvttHkZ4paSV+ms8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Hk9/x0th; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFn0Bz4zlgMW7;
	Tue, 15 Oct 2024 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019434; x=1731611435; bh=A8gCo
	PSUc1XHIfuDt97q/U1JNeKk8hM+DU6sGZxR2qc=; b=Hk9/x0thrgT4HBisX2lq8
	hRtMXQyA9ZmkTeA+TA/WeDDaq7wTf4+yaO8VWHrmeYIJnWWtOaIA0FvMb7iJ3flY
	KC/MtoYah+uUJ++YaR1tJXk6hOeHmM8RxCBTn+hD6suFOEWmF35c5R8fCzdbR/oL
	5vsusrrzWLUL6Xv5vxHX7BfCwcMRdYwwPzFaJ8s9qlyaIBk6spnGhVAckskO35Qq
	anM6wdUhzcG2nBleimr91ZfL/1sMagfIaljb0bjP1pmBe5Re8yohRLBYpa6cDNe9
	lTU8CpsmX3OpT3QGLCXX7OXhzPowfGr2oMKcM6Qt6+SRChVdkGYFQ9Fn/ZXiRzfV
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TAflxTEG55PU; Tue, 15 Oct 2024 19:10:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFj3TgJzlgMW2;
	Tue, 15 Oct 2024 19:10:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Joerg Reuter <jreuter@yaina.de>
Subject: [PATCH v3 10/22] net: hamradio: scc: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:41 -0700
Message-ID: <20241015190953.1266194-11-bvanassche@acm.org>
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

Cc: Joerg Reuter <jreuter@yaina.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/hamradio/scc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index a9184a78650b..c71e52249289 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1460,6 +1460,7 @@ scc_start_calibrate(struct scc_channel *scc, int du=
ration, unsigned char pattern
=20
 static void z8530_init(void)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	struct scc_channel *scc;
 	int chip, k;
 	unsigned long flags;
@@ -1735,7 +1736,7 @@ static int scc_net_siocdevprivate(struct net_device=
 *dev,
=20
 			if (hwcfg.irq =3D=3D 2) hwcfg.irq =3D 9;
=20
-			if (hwcfg.irq < 0 || hwcfg.irq >=3D nr_irqs)
+			if (hwcfg.irq < 0 || hwcfg.irq >=3D irq_get_nr_irqs())
 				return -EINVAL;
 			=09
 			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
@@ -2117,6 +2118,7 @@ static int __init scc_init_driver (void)
=20
 static void __exit scc_cleanup_driver(void)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	io_port ctrl;
 	int k;
 	struct scc_channel *scc;

