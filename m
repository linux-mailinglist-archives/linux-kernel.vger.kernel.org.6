Return-Path: <linux-kernel+bounces-366530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE1A99F6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A258C1C2344F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E51FBF54;
	Tue, 15 Oct 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XPZrGfRQ"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7A1F81BE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019437; cv=none; b=g5iXDbQvQGlx4PcXoMWhgfXMIb5oO08WMpZvJt8HaHm1/REjjxA8q44YLF+SPiDRvGB4BqYAhLNarnsyZcyC8a3gaAiF2On+870Z0+GAOt21zsk8B5NdrqjaVrxQu/BOYw9MWBw+L3hF822tc+CZYkEHBmkawziKtyZ3YW5ihSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019437; c=relaxed/simple;
	bh=G4rSFhV8V5M5z8r1yfy2hhDROYLKbS5fa5Y8orG4SRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKIJ6jJ4z1agOjp0dZvHBJvy7Fq1Y2rOcV9slS2TQhIyZGRLyRrHIhzMcub2YrtnuH1hX8C50zje8YoFjIeC+yqSvY33/E9HWU3KQlcv8PV+f7r5nKF4uBMS7vgvijCCyQDoqDk0dg/gDSHQ7lq6/pVfSkPC18EZkorbyu+k5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XPZrGfRQ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFk3TkRzlgMW5;
	Tue, 15 Oct 2024 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019429; x=1731611430; bh=kllgx
	Ol6bQ8oQUVdCzWxpp2VorZwc4sp4dvRdCTY4pU=; b=XPZrGfRQ6KRswZIKA3R1d
	mqhol+v1I4+YqWqzIKuwruPhtAT+ntMkQ+sGkukceMmsLF2vCcQVQvQGZS3F3717
	TmR5nswC1eeqxixk+7LE1WCYzHIA7lfbjYSbK4fUt+sFa9PADs7YMw6kFkUxkDj5
	4+VOjShcXpb29zTVO5VS1DBaKkWqOfQ/PMWlnGhmo93eWERAHhv1Qcqpc/ZniDzK
	jGh6ir8PErPbfYPzM2F63cb5KoekR4eVc1bfCDNjFFzLlTOeOazdLtg5CvxJj+Ek
	XJq5CsXdjLsGu/n848+kaHvrpnVEjkKNypePK0v8PGl4UkF3S/C2haBHT6z/aQKt
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bgf1qY-tN5Ox; Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFc5LNzzlgMW0;
	Tue, 15 Oct 2024 19:10:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 06/22] x86/acpi: Switch to irq_get_nr_irqs() and irq_set_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:37 -0700
Message-ID: <20241015190953.1266194-7-bvanassche@acm.org>
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

Use the irq_get_nr_irqs() and irq_set_nr_irqs() functions instead of the
global variable 'nr_irqs'. Prepare for changing 'nr_irqs' from an
exported global variable into a variable with file scope.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/x86/kernel/acpi/boot.c   | 6 ++++--
 arch/x86/kernel/apic/vector.c | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4efecac49863..3a44a9dc3fb7 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1171,7 +1171,8 @@ static int __init acpi_parse_madt_ioapic_entries(vo=
id)
 	}
=20
 	count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
-				      acpi_parse_int_src_ovr, nr_irqs);
+				      acpi_parse_int_src_ovr,
+				      irq_get_nr_irqs());
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
+				      irq_get_nr_irqs());
 	if (count < 0) {
 		pr_err("Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.=
c
index 557318145038..736f62812f5c 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -712,8 +712,8 @@ int __init arch_probe_nr_irqs(void)
 {
 	int nr;
=20
-	if (nr_irqs > (NR_VECTORS * nr_cpu_ids))
-		nr_irqs =3D NR_VECTORS * nr_cpu_ids;
+	if (irq_get_nr_irqs() > NR_VECTORS * nr_cpu_ids)
+		irq_set_nr_irqs(NR_VECTORS * nr_cpu_ids);
=20
 	nr =3D (gsi_top + nr_legacy_irqs()) + 8 * nr_cpu_ids;
 #if defined(CONFIG_PCI_MSI)
@@ -725,8 +725,8 @@ int __init arch_probe_nr_irqs(void)
 	else
 		nr +=3D gsi_top * 16;
 #endif
-	if (nr < nr_irqs)
-		nr_irqs =3D nr;
+	if (nr < irq_get_nr_irqs())
+		irq_set_nr_irqs(nr);
=20
 	/*
 	 * We don't know if PIC is present at this point so we need to do

