Return-Path: <linux-kernel+bounces-344604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A798ABD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF0E1C213F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F119B59C;
	Mon, 30 Sep 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Oj2zYuN3"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8519ABCE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720205; cv=none; b=Is8A7GTPDIUTXeC2ChyFvXNwe02YVW1v3Z1I11hdoW/F4QJvZqKwH/69ac7Xi1gw3/G/lygJ1rF2xRz5F5+s+iv4QLg2pR1rZ/8qpsFe2TnlQbgIR8OOjzd3Gq5siErJMPNNxezUS5LAipe8ca71uYRD5c4CB05jA+MXpSAfAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720205; c=relaxed/simple;
	bh=qK+yhVEih4H0ozFaKmGAkd6Fs53sWMLxlTf59tCc8DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPMhmzb0oKOKbfeXrj30QLq5F92JIs1WKFBGPlcSN3Lq2duxSMbZGszqdF44IwzYwSFmK2/KPGiWTCMqNDbdpH7VhoTht/7dXZ1iUnkjjeEd/4wQkLp3Qr0E8Y3njIdpWMuBBiZCo6Hur+DptmOoJ5VQALXDSlKuZZSfOeuG7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Oj2zYuN3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmM16HwzlgMVx;
	Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720191; x=1730312192; bh=3+gCB
	p2G77lOsXDqUrahPgiTbccwX1nHG5fzQzmYVZQ=; b=Oj2zYuN3Mv+58D0pF6HcQ
	CwuvFLKgV/Hvgfz9MpWKVYnfd5/U/tGC2hQ241WUYCnHLcsRRwLTEZN06BMBe9Fs
	9kjOeMCVHR12R7Xs5GAvIYBfHrR2WQcKhWS/jbVIMn0Vk8d/sxwhB8D9NY2DRMEu
	sfhm7v3lCTXiNLO/ZG11cuQBNkoQmejS4asJsrAhZCGGmkrWNBm7o8rStP5PdqFA
	puVokmyTWH4nogtpYuW+UpxMcoOwD1ZzKhlMXkldOLDcf+FQx8GHktDAPFULVpRD
	Fo+kY1/Le3Xtd+2Kggsb3M0PF7CO+NWKK3oaki6qvlDNOonnzrdR7W2h09Tcbqt/
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WjCuzC71WABI; Mon, 30 Sep 2024 18:16:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmG0kB1zlgMVc;
	Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 06/21] x86/acpi: Switch to number_of_interrupts() / set_number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:45 -0700
Message-ID: <20240930181600.1684198-7-bvanassche@acm.org>
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

Use the number_of_interrupts() and set_number_of_interrupts() functions
instead of the global variable 'nr_irqs'. This patch prepares for changin=
g
'nr_irqs' from an exported global variable into a variable with file scop=
e.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/x86/kernel/acpi/boot.c   | 6 ++++--
 arch/x86/kernel/apic/vector.c | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4efecac49863..cba2c735dd03 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1171,7 +1171,8 @@ static int __init acpi_parse_madt_ioapic_entries(vo=
id)
 	}
=20
 	count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
-				      acpi_parse_int_src_ovr, nr_irqs);
+				      acpi_parse_int_src_ovr,
+				      number_of_interrupts());
 	if (count < 0) {
 		pr_err("Error parsing interrupt source overrides entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -1191,7 +1192,8 @@ static int __init acpi_parse_madt_ioapic_entries(vo=
id)
 	mp_config_acpi_legacy_irqs();
=20
 	count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_NMI_SOURCE,
-				      acpi_parse_nmi_src, nr_irqs);
+				      acpi_parse_nmi_src,
+				      number_of_interrupts());
 	if (count < 0) {
 		pr_err("Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.=
c
index 557318145038..cbc68ffadb7a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -712,8 +712,8 @@ int __init arch_probe_nr_irqs(void)
 {
 	int nr;
=20
-	if (nr_irqs > (NR_VECTORS * nr_cpu_ids))
-		nr_irqs =3D NR_VECTORS * nr_cpu_ids;
+	if (number_of_interrupts() > NR_VECTORS * nr_cpu_ids)
+		set_number_of_interrupts(NR_VECTORS * nr_cpu_ids);
=20
 	nr =3D (gsi_top + nr_legacy_irqs()) + 8 * nr_cpu_ids;
 #if defined(CONFIG_PCI_MSI)
@@ -725,8 +725,8 @@ int __init arch_probe_nr_irqs(void)
 	else
 		nr +=3D gsi_top * 16;
 #endif
-	if (nr < nr_irqs)
-		nr_irqs =3D nr;
+	if (nr < number_of_interrupts())
+		set_number_of_interrupts(nr);
=20
 	/*
 	 * We don't know if PIC is present at this point so we need to do

