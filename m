Return-Path: <linux-kernel+bounces-355887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30BC995861
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B0D1F24D96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E0217338;
	Tue,  8 Oct 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IReFh1kE"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46C216438
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419191; cv=none; b=cmmHRPKIqDMITjzxp+XSjKBLKwKHORHfDIjfPU/bUI65FgNd+RmDkGnSCr1iVuxYuxe+3aPiiLc+v+XEzMzPvbFQF5nt8ZCjN/aLaYFiT4EOsrkG7dcyrJ3BwA4MPaz3JosgqmgdPXhD2lnJPunpzbpRKE2fUdA31N3RPwIR+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419191; c=relaxed/simple;
	bh=v5+WlhCYp3nmMU6WLvuEwiSxxIt3K6XhnsHw3qlIlT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujbMxMGJvhSNMmvpnimPho7gPw3uNk5i2q2wMGoPnJvGtOxQnZs4CK1t84B5TP7JBNyVyj9d+exu8S2wc7aD7w+4KhAPLuNreXDehCOmhyzntdKjZPHUsiMnIrIo/hXVLC5VYfLuVw28CCh00v6FE8iYblY1pC6pvJS9U9HOkm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IReFh1kE; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGW1tDfz6ClY9f;
	Tue,  8 Oct 2024 20:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419184; x=1731011185; bh=/XeIP
	NRcpqtMH6mznQch4+Ar5ZL668QdZHfyJcueCk8=; b=IReFh1kEfvONVFrHKdhiP
	fhOhxi2UjzpZtTkq2ZdU5aUT+Vi2icWTQqk8kfIq3Ij5PSN09lrEvHOp4RdNqW/c
	kixO0xqvjbfHOVjaOmgMQHWKTn8/UTWhIS6soWVvjWfYZFPVgqUjBuPkysRRd8r2
	WtpgPKuUWJDIFAfqDQ0bmulvz7YOZZGq+WItKQIp+OTo23ME74v1KZ6imfZl5voa
	kki7uJOxDehj3q/m1F1yoluxn01Ca+Ya//m6DfBmeukwd+7aVjXSmA/6dwdbxWBL
	amIg0quXRCbbQe/0fSihXDqlR4p7Dfa7TIALa1Z39ynkuHrC39B2OUWYZiY0aJkz
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bK9icmbkKRjo; Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGP6cdsz6ClY9P;
	Tue,  8 Oct 2024 20:26:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v2 03/22] LoongArch: Switch to irq_set_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:42 -0700
Message-ID: <20241008202601.3737326-4-bvanassche@acm.org>
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

Use the irq_set_nr_irqs() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

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

