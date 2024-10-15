Return-Path: <linux-kernel+bounces-366544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736F99F6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13831F24C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B81F80D6;
	Tue, 15 Oct 2024 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d66RtRAG"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93E1F80D1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019453; cv=none; b=jVBVs0z+vBDV72haWinyv+s7EAn9CQsG3RJmAmHzS96Q2D3DnQvCumQB74j9NGuu+M7hsjIldY0gK16oAwsWPsCKigr+/ArqlZ2oIAB85C6G/R/VBob07o1KsI2lZ6H5P475j0rV+//e7EkflqD0tY+3s2o9mcRWkRSNbYJ6ZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019453; c=relaxed/simple;
	bh=UybMUcR+599A7o8i4NI+AzgUVwmatR93PUrtXeYW8EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgqcL2/aR6Qe0Oke2Z06RXNcptLuNN1q7/PfKPSqQpYhKdJ81BlBQUFTdVS+pSo9JNRDfCyPSlaO4bDV7N0nFgGI5nCLslvHf+iE4qo+qkGqTLzZHxEMkcFEQIjILTsIwZ5mlGaOlzB+BmNlqaaUw+ijHQR5d8/xmANc+vRe1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d66RtRAG; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkG04w6yzlgMW9;
	Tue, 15 Oct 2024 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019446; x=1731611447; bh=nJ/PN
	WbgXqDkmBydxBghlnc4SXVStgqLWpje1vc1+RE=; b=d66RtRAGi1pzjif1UTzr4
	Kg29Tw22fvEF7v6FD4wEn15LNa0IsD4O/o0W+001+aKiwf45hkRY7iwMK9JOpheD
	Nn8Af/N+z4gY7m56TQtnOGM8KU4oAKeh+Tepo6/aTOGJSu5yIDdNXy91KbMHwJcU
	Z/xe1JUZTTeM6k5iT5aBoVrb65WFOQLUP3RJWeRpHy5aiSOd3glynYGw9zY2Zyog
	R4JzwFiN4Nc4nF5S6yU90a8XsiwexkABJpciYlZ95rTrw4Dv0VznhhXRcEadd76L
	ctuvndJfHo5gfQFeBAdakX68pbhaqbkG/opfCnmpboD9VN1Wden6U3ALVZEABqbt
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3_IITjJB-gZV; Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFy1KDDzlgMWK;
	Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 22/22] genirq: Unexport nr_irqs
Date: Tue, 15 Oct 2024 12:09:53 -0700
Message-ID: <20241015190953.1266194-23-bvanassche@acm.org>
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

Unexport nr_irqs and declare it static now that all code that reads or
modifies nr_irqs has been converted to number_of_interrupts() /
set_number_of_interrupts(). Change the type of 'nr_irqs' from 'int' into
'unsigned int' to match the return type and argument type of the
irq_get_nr_iqs() / irq_set_nr_irqs() functions.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/irqnr.h | 1 -
 kernel/irq/irqdesc.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index a33088d27c54..e97206c721a0 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -5,7 +5,6 @@
 #include <uapi/linux/irqnr.h>
=20
=20
-extern int nr_irqs;
 unsigned int irq_get_nr_irqs(void) __pure;
 unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b0733959f8ae..479cf1caa610 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -138,8 +138,7 @@ static void desc_set_defaults(unsigned int irq, struc=
t irq_desc *desc, int node,
 	desc_smp_init(desc, node, affinity);
 }
=20
-int nr_irqs =3D NR_IRQS;
-EXPORT_SYMBOL_GPL(nr_irqs);
+static unsigned int nr_irqs =3D NR_IRQS;
=20
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.

