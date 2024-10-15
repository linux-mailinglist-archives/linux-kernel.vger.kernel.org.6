Return-Path: <linux-kernel+bounces-366526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EED599F6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE8C1F245B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0361F819A;
	Tue, 15 Oct 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WE2KIG2q"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA721D5152
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019433; cv=none; b=f3n+eK4OSPEN/wEjfoaZoG4yHvfp2KJqOx941jKaPCoDhThVRI8HbyV2eJyVagB++sXUEUhVN4ws8MsU2Vmz58MWH5buHCvd246AI12SWWGYcUXsA32R+vjvPKJ/oWU6eOzPjlcHPHcvYe0IGPqIAYAAMXysoP85sHEK5nPzgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019433; c=relaxed/simple;
	bh=ncsbuhfar7TrtH8vlM2b163FxnUgkhbVMQn0EibzUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wqc7iUvNNJ/9sdDf0zxpH4afN1J0gY+kCvNNjzSOafNqlbZeJSJsJefph+AZNGtkEtgmXVEQyq9bgaAUYyeFnpla3osAJz0qtBJEq5snRalKMYy0f6ivtzlHyfwET0mpjjpAPThACkRPECbqVNS4nu6Ea3KMbCenY2sq/C6oBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WE2KIG2q; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFd67QWzlgMVh;
	Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019427; x=1731611428; bh=HRueg
	HGqgyJbW5wMoC2dhYR76II1xukR2pgXVbmRNMA=; b=WE2KIG2qyzKstueSZkW1B
	VhbwdIW3BHcyWbMnBTSiP/tIezw+OizUrLggkF2+bwYP0Ub+4sTgPEdHlvPZ2l/F
	NTGopZRstnINCoDvB56DqlcZT7sj9Lt8i5dozWWmLBj1k4CVW706oX+dmSzIJnBB
	8RUdJZ3yHPpGIEodmMRh709yrgGAHcGf9GL5hVllbWBkoBYZ8BqXovZ7/hFc/ZZH
	UUYZjOjAJjBQsNXhGltWhSpuMIzblq/TRfxfivk/6tiPtZDhHyCb5GdhCnxR0Bbs
	7dcSEPsF51wvJi+wnijm+hyLBE1sR0lqQkiWzbMsmnzQOJ0GGLv0QVycBcqMrELM
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EpjFfHSLstae; Tue, 15 Oct 2024 19:10:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFY43fnzlgMVw;
	Tue, 15 Oct 2024 19:10:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v3 03/22] LoongArch: Switch to irq_set_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:34 -0700
Message-ID: <20241015190953.1266194-4-bvanassche@acm.org>
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

Use the irq_set_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/loongarch/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index d129039b368b..80946cafaec1 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -92,9 +92,9 @@ int __init arch_probe_nr_irqs(void)
 	int nr_io_pics =3D bitmap_weight(loongson_sysconf.cores_io_master, NR_C=
PUS);
=20
 	if (!cpu_has_avecint)
-		nr_irqs =3D (64 + NR_VECTORS * nr_io_pics);
+		irq_set_nr_irqs(64 + NR_VECTORS * nr_io_pics);
 	else
-		nr_irqs =3D (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
+		irq_set_nr_irqs(64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
=20
 	return NR_IRQS_LEGACY;
 }

