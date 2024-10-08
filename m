Return-Path: <linux-kernel+bounces-355894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF3995868
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60244282BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CD2194A6;
	Tue,  8 Oct 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pFsx19Jt"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4B218D85
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419199; cv=none; b=T5SyWyNN6yO/RS/yieW8d2hpO7UDpxfpJxXYX0ubunBeEvpaTw5St0lp45eWgm0sqqSd3CCu+lGraK3HRBXNN2PXTqLUuNmjQWG9hQ0UWVuxuQ6G7QFC+87VuBSY5jJLuATb1AHa2GQqTMKnmMpkZ0pcs6gqLDlMn/XSdL2dO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419199; c=relaxed/simple;
	bh=GM3WUJp6PlTXVW7zuDxGprOCJL2aOZqrdGfUHItLHk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+85Yt+1GJfhvUoxZh5AJm8pFqPr5iaKDdAXASGJpQMQIgU71SUGA1LP8u8OlYCMUpJj4L4tpsugFAxTGHWIOM7PLioOJgf6Sgb1vz4Ve6OF52aqx8pE65b/DsAwi69K/mxtzzxg6EawmPn1BQaAPbVDTJ6S7nh34iF6ZKd4V8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pFsx19Jt; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGZ4VZFz6ClY9R;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419186; x=1731011187; bh=5o3gV
	/RPFxVSDgTN7GytVoLdXfYOY+TDXun+fn8fKSA=; b=pFsx19JtO3V8Ql4meqzOp
	UTfZ6BuNDfxCPfHArYS6RZ0Q5GeFkzoJJzdPFoVAvTP2vlB+3m96mcrAP8P39U3z
	ZHWh+X9TaS+cOxUi//HEIwLeNJsuhOQD4gAdF7/5+R1uLA/+hz/hk6byAAFBZGx5
	34XldKUTiaBpm4DehD6HcBy2W3ZbGhl5uUXuN4sPdl0yGQrm8n945bQ670Jmek2d
	9l6qLYk4hPfDxfc5M24/rdtO8/jm0c1s7Hu1v18iBb1lo+mHOTDHxugNFPDGtApK
	iGTgnkRFyMH1afKkb2HoNpwBjV4kCpPbi/bxJ3aQrrMXClfp+ZBApTX+woXZsotn
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id V6WbZJvh6vdi; Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGR6LnGz6ClY9T;
	Tue,  8 Oct 2024 20:26:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 06/22] x86/acpi: Switch to irq_get_nr_irqs() and irq_set_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:45 -0700
Message-ID: <20241008202601.3737326-7-bvanassche@acm.org>
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

Use the irq_get_nr_irqs() and irq_set_nr_irqs() functions instead of the
global variable 'nr_irqs'. This patch prepares for changing 'nr_irqs' fro=
m
an exported global variable into a variable with file scope.

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

