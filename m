Return-Path: <linux-kernel+bounces-539023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59476A49FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51438189666B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D71F4C9D;
	Fri, 28 Feb 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+QtIARl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940A1F4C97
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762489; cv=none; b=fySfoTeFPN67QNaInBdiNCJ1GMa/7O2gN5lCshx7esHTUX3rSXsu0CzMeLIik7cJJT5ecOZZZvKnJwtrvvEAuW+Hgs0MxLk3CvS3rYm8I2NlFy3ZHdk3E4w39zNRbSKubtwmKQID78K6apeDuVMUv6chZqFEPxCpKPhwdBH3Y2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762489; c=relaxed/simple;
	bh=fD7myLE7ZbsP4UOrvsDMKLYCzpzMGkG8rvS6jnv0syU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heQ0i78XZkoAQea1Jed5DfMTp787fH9Rd/621FP45tHXludchXhSpXfX3lJMRd9//dCLG+J+M6Rp1mhFMoiS81sCdYdwFj41Jp0uKmaN9qzbWJ6m6st6wpNv2HT4ts0Ha6clzwgsqSlF0bYjgxZyzmqEdDGwrQsiIzLrbZx0zDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+QtIARl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCDQVqTr6hmhHqFxDWe5bIvKzwcioj+1kYTpxwIAaU4=;
	b=i+QtIARlpqJqXiAAS5gddm7MLIR9bUlpJlbCgtZYVwh7KVQa9pzQvtSGK9f2rqCfwQ8f79
	oUZ+AYVJUz/1c6SDAZ2JLuHWRt0X6l2QHRUBifLm20EzQooSsWakqBzeuECurpQHlAq3Ws
	Lyk7A4TNylS438rvd01Hztq+OS12684=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-PYR8LiudPnSw8T0muAyRng-1; Fri, 28 Feb 2025 12:08:05 -0500
X-MC-Unique: PYR8LiudPnSw8T0muAyRng-1
X-Mimecast-MFC-AGG-ID: PYR8LiudPnSw8T0muAyRng_1740762484
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f4156f3daso1762444f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762484; x=1741367284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCDQVqTr6hmhHqFxDWe5bIvKzwcioj+1kYTpxwIAaU4=;
        b=c4x6Boekg9vyaK8NG9t0nrhwGkOCmOtw7jiMMSyO9JYaIZdnpVCeeKi9h/1Hsleqk7
         HtV5XXLBt3EnJqf/Y1TReueDVOKEH7eU0gK+kz6CmwvACvCmZiAtEq4w3goh6HGtpWce
         hUp/JVHEGdUBs0xT+P18OyldOqXUpImqa8uhYNF82YM+2XbGHBfDZq/6uOD/pdnsy05U
         /3mKgT2g29ci1gCk3DspFtA6WsUiGNGKGnuRW9Ke9+VWMbbY2gUfPeJHDUazS0e9E9Re
         CoC+EqlNxB1lmrruH19psDqEBAz6+4P1rR5XzfcOOC5LLRgklgvfcKDv/03qmTt2iCEO
         y+8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/zYpDlKiGpZtZ3qjFzD6UIPw7LY+S1b0JhSLYayBtaMHKhGfDUdUrbmdwAiRULtvr/fILzK8WCTJkAf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd0tG6LSWL8xfvZSVki0ooiHby5WX/BPLrnf3ALUydwz941HQ2
	UGdOoI/5wm1Dp/vCHtI2+7Gj+ow/Yv03jzZbts3Jr8Td20t9kiZc1t9y4FzC5nVlyH90F0Demcp
	Vl7izjDn6V2EE+rjOYCT9sBv99ahKgAjUkkT/LlPC4H/+64D2od081lW2HfXMYA==
X-Gm-Gg: ASbGncsjND3Ys8FL8NoJkpaqvHAbn1lT50r6RKsoQRV8l/cSPuoC2afB9vinlJGET7M
	Vm/DK3g2H8kJL7hNG5Phw8RwfOPY9HUuuacLC63UD1X9TsnWkugUbEeLhISAsRNxiCeyN5epToz
	031UCI55QoAkTfr3m9JGc8EyDrkBBy+mUH14ZpjIARKK1wXfIrh/WG5OQDGCP3r/kskpuzas4id
	/Srjf2Y/tk9YEvmzAJnsFZnAzKDJ0Nm6+VruzEh/5Zg6LZldS8KklwJ1riI2cxZgxNan4vSR5Bz
	x6FVhH3wPnLzNQ2xkF/L
X-Received: by 2002:a05:6000:1f8b:b0:38c:5cd0:ecf3 with SMTP id ffacd0b85a97d-390ec7c8e6amr5632226f8f.11.1740762483981;
        Fri, 28 Feb 2025 09:08:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi3+55T3gLjFA7+VRsA+/+pw6DGiNP5lywvegd/8noBWWF1sFz3oYBCHvDQEOy4ijFyvRJyQ==
X-Received: by 2002:a05:6000:1f8b:b0:38c:5cd0:ecf3 with SMTP id ffacd0b85a97d-390ec7c8e6amr5632102f8f.11.1740762483303;
        Fri, 28 Feb 2025 09:08:03 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm5911935f8f.60.2025.02.28.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:59 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ingo Molnar <mingo@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Date: Fri, 28 Feb 2025 18:07:19 +0100
Message-ID: <20250228170720.144739-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for the vTPM defined by the AMD SVSM spec [1].

The specification defines a protocol that a SEV-SNP guest OS can use to
discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
in the guest context, but at a more privileged level (VMPL0).

The new tpm-svsm platform driver uses two functions exposed by x86/sev
to verify that the device is actually emulated by the platform and to
send commands and receive responses.

The vTPM is emulated through the TCG reference implementation, so this
driver leverages tpm_tcgsim.h to fill commands and parse responses.

The device cannot be hot-plugged/unplugged as it is emulated by the
platform, so we can use module_platform_driver_probe(). The probe
function will only check whether in the current runtime configuration,
SVSM is present and provides a vTPM.

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00
    https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/char/tpm/tpm_svsm.c | 120 ++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_svsm.c

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
new file mode 100644
index 000000000000..1c34133990c5
--- /dev/null
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ *
+ * Driver for the vTPM defined by the AMD SVSM spec [1].
+ *
+ * The specification defines a protocol that a SEV-SNP guest OS can use to
+ * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
+ * in the guest context, but at a more privileged level (usually VMPL0).
+ *
+ * The vTPM is emulated through the TCG reference implementation, so this
+ * driver leverages tpm_tcgsim.h to fill commands and parse responses.
+ *
+ * [1] "Secure VM Service Module for SEV-SNP Guests"
+ *     Publication # 58019 Revision: 1.00
+ *     https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+ */
+
+#include <asm/sev.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/tpm_tcgsim.h>
+
+#include "tpm.h"
+
+struct tpm_svsm_priv {
+	u8 buffer[TPM_TCGSIM_MAX_BUFFER];
+	u8 locality;
+};
+
+static int tpm_svsm_send_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len,
+			      size_t to_send)
+{
+	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	int ret;
+
+	ret = tpm_tcgsim_fill_send_cmd((struct tpm_send_cmd_req *)priv->buffer,
+				       priv->locality, buf, to_send);
+	if (ret)
+		return ret;
+
+	ret = snp_svsm_vtpm_send_command(priv->buffer);
+	if (ret)
+		return ret;
+
+	return tpm_tcgsim_parse_send_cmd((struct tpm_send_cmd_resp *)priv->buffer,
+					 buf, buf_len);
+}
+
+static struct tpm_class_ops tpm_chip_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.send_recv = tpm_svsm_send_recv,
+};
+
+static int __init tpm_svsm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tpm_svsm_priv *priv;
+	struct tpm_chip *chip;
+	int err;
+
+	if (!snp_svsm_vtpm_probe())
+		return -ENODEV;
+
+	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/*
+	 * FIXME: before implementing locality we need to agree what it means
+	 * for the SNP SVSM vTPM
+	 */
+	priv->locality = 0;
+
+	chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	dev_set_drvdata(&chip->dev, priv);
+
+	err = tpm2_probe(chip);
+	if (err)
+		return err;
+
+	err = tpm_chip_register(chip);
+	if (err)
+		return err;
+
+	dev_info(dev, "SNP SVSM vTPM %s device\n",
+		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
+
+	return 0;
+}
+
+static void __exit tpm_svsm_remove(struct platform_device *pdev)
+{
+	struct tpm_chip *chip = platform_get_drvdata(pdev);
+
+	tpm_chip_unregister(chip);
+}
+
+/*
+ * tpm_svsm_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound
+ * at runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver tpm_svsm_driver __refdata = {
+	.remove = __exit_p(tpm_svsm_remove),
+	.driver = {
+		.name = "tpm-svsm",
+	},
+};
+
+module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
+
+MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tpm-svsm");
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 0fc9a510e059..fc3f1d10d31d 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -225,5 +225,15 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_SVSM
+	tristate "SNP SVSM vTPM interface"
+	depends on AMD_MEM_ENCRYPT
+	help
+	  This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP guest
+	  OS can use to discover and talk to a vTPM emulated by the Secure VM
+	  Service Module (SVSM) in the guest context, but at a more privileged
+	  level (usually VMPL0).  To compile this driver as a module, choose M
+	  here; the module will be called tpm_svsm.
+
 source "drivers/char/tpm/st33zp24/Kconfig"
 endif # TCG_TPM
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9bb142c75243..52d9d80a0f56 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
-- 
2.48.1


