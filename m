Return-Path: <linux-kernel+bounces-573519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F8A6D893
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6091892FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713E25E45B;
	Mon, 24 Mar 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQpFeEdj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82125DD03
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813237; cv=none; b=PN8wrMcQcT3IeVVKMd6upWVt22RYlmrLP6UxbldghGP6ahlx4xSgDnKhyXOyiT/1YEy5NQONRS+ronzP2qgHL3lMVgmlxtMO3aURvq5eSXo9Up2QyWSCOFtLIvGpmXE3O2ChN1q2fMyMwSDi0OZkxzw3rGU0NyX1sbvhdnHlMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813237; c=relaxed/simple;
	bh=fYETXP1a8TOssFuTHBuHbCaB4dw0eo0gT/SC7oA1iIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+xZAcjCT/3IvKPeYr0GjCqiZilcCLYDWhrdNhZaXHgM4jCBE8wFDtSFjhZgOTGpakJRuvpzRFxwr2nEb4KYZc9o5zg0AdOmidXxXtLoOAWLWdqkrBF69QtpHkCEVAKWWJ1bgzEP6GVmALl7bRjUqnG9myjtC0F6GWsaBNfVhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQpFeEdj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742813234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyDOxzFU6JupwzWJAiTz5FZI+LekQY7HIxOgSfWPZ30=;
	b=ZQpFeEdjhzkbqDF2SjaRxQbWWKwRBbt4PWOJeEoqqjQAQP15jNhab5KxHLREPm9mnCPz4I
	XksWZHivLeF7NfjFgTanYzwXtBb2oJX2YLoF7evQef887ALklqblTbE+BhQIjP6m0B0MKm
	WGttjZxQgZSdZ7IdF0SOIY4ColSIMug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-hBdtX7JNNPWvVs7hWAcARg-1; Mon, 24 Mar 2025 06:47:13 -0400
X-MC-Unique: hBdtX7JNNPWvVs7hWAcARg-1
X-Mimecast-MFC-AGG-ID: hBdtX7JNNPWvVs7hWAcARg_1742813232
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39130f02631so1677056f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813232; x=1743418032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyDOxzFU6JupwzWJAiTz5FZI+LekQY7HIxOgSfWPZ30=;
        b=KMqKc0lvYf/AACEjRi4wjbsHSyw7kuUNY6WovGUzc2GuQ9wYf8WGQDa5qtSuWTICjv
         Bm8OtRiKuxPQ8p3NK8COlhvqenLBFpGiaxxvh5Y6nwPgFQKzCC//oF5RKu8pHSHNC9HX
         wG/N4El51arCT7CmOAbD4wcLF1o0faQVwNjr4HTG3c/5fvtI5ncj7+FmPZHQyq6wugtj
         y8YrqhFOamaxpx2bTtmOvskZxvyoDiH1lDAIPiRpQBGiXsq5mAii68DpvwNeiyTlnx56
         5pHqVnqALDrneq57264x6R9HGiTBZsSkyxB+V5EJMJ5q01HMM1x3OhSPvm8t+3CHFEBI
         UOPw==
X-Forwarded-Encrypted: i=1; AJvYcCX/ehSyvor0k6xugd+riVirht8pKUtTrHw/z7Am3+D7VmqRB8jWs3cakG0KCUY5Khd/wPc0sKVCIh+3m0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0u5ljadqxvzqxSa4q9ET1G1fbOMwWgIL5jBxbe+EL4Y24LGmW
	9GeSkA/1ukZPALDh0DG1olFQr3F0pgp7WQiebfEeHJtfEvL+x2plrcjuRXhSX+W2oT0vdNnKkep
	bksvZRlZbl+VUFq89BiTfHJx4rmKvruEjx31YTnkLnbyLv2d2CP/3ZhK+iQgxcg==
X-Gm-Gg: ASbGnctK7i67xxK8jdPwJ8KCmwa7CtyxpDGo/i8L1HObH8j8olVhlP1Co8KlH9cn27h
	M+fxoynm7pcUMLUNEiO1NUYvXQ1X5sKrAf/qcVLHCvmBV1EnwS0IRWNkMosQlu2jvUDR02Dmv0b
	PD6BRLpQpAXVb3VB5cnr8Ke92tr1wwdk685UAygJofiJnL1RrA8FqshbKhX+3Hxm8YDAgNJ/og7
	fth1+GClMJmXV5zEocWfHb2FrSjy++mM+H37/QTYwy7VI4N5Un7NcGsxLkQmQt0hGbQW40CLEee
	YaWTI73b5UI6CG6eEM+grct1UCD/ClYFPUo/pZdnC5w+kpH4OjL09/iFOZSmbVcvCw==
X-Received: by 2002:a05:6000:1f86:b0:391:3988:1c97 with SMTP id ffacd0b85a97d-3997f8fedcemr10427622f8f.17.1742813232204;
        Mon, 24 Mar 2025 03:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrTWSDELo5BJGWG2u5TFc15xbVywo2ZKnMk5vePN5f5p6dnyWwAdc8cl4oqo1bOvngslZPTQ==
X-Received: by 2002:a05:6000:1f86:b0:391:3988:1c97 with SMTP id ffacd0b85a97d-3997f8fedcemr10427578f8f.17.1742813231553;
        Mon, 24 Mar 2025 03:47:11 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43d7c6a5sm168667675e9.0.2025.03.24.03.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:47:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 3/4] tpm: add SNP SVSM vTPM driver
Date: Mon, 24 Mar 2025 11:46:48 +0100
Message-ID: <20250324104653.138663-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324104653.138663-1-sgarzare@redhat.com>
References: <20250324104653.138663-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Add driver for the vTPM defined by the AMD SVSM spec [1].

The specification defines a protocol that a SEV-SNP guest OS can use to
discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
in the guest context, but at a more privileged level (VMPL0).

The new tpm-svsm platform driver uses two functions exposed by x86/sev
to verify that the device is actually emulated by the platform and to
send commands and receive responses.

The device cannot be hot-plugged/unplugged as it is emulated by the
platform, so we can use module_platform_driver_probe(). The probe
function will only check whether in the current runtime configuration,
SVSM is present and provides a vTPM.

This device does not support interrupts and sends responses to commands
synchronously. In order to have .recv() called just after .send() in
tpm_try_transmit(), the .status() callback returns 0, and both
.req_complete_mask and .req_complete_val are set to 0.

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- moved "asm" includes after the "linux" includes [Tom]
- allocated buffer separately [Tom/Jarkko/Jason]
v3:
- removed send_recv() ops and followed the ftpm driver implementing .status,
  .req_complete_mask, .req_complete_val, etc. [Jarkko]
- removed link to the spec because those URLs are unstable [Borislav]
---
 drivers/char/tpm/tpm_svsm.c | 155 ++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_svsm.c

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
new file mode 100644
index 000000000000..1281ff265927
--- /dev/null
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -0,0 +1,155 @@
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
+ * [1] "Secure VM Service Module for SEV-SNP Guests"
+ *     Publication # 58019 Revision: 1.00
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/tpm_svsm.h>
+
+#include <asm/sev.h>
+
+#include "tpm.h"
+
+struct tpm_svsm_priv {
+	void *buffer;
+	u8 locality;
+};
+
+static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	int ret;
+
+	ret = svsm_vtpm_cmd_request_fill(priv->buffer, priv->locality, buf, len);
+	if (ret)
+		return ret;
+
+	/*
+	 * The SVSM call uses the same buffer for the command and for the
+	 * response, so after this call, the buffer will contain the response
+	 * that can be used by .recv() op.
+	 */
+	return snp_svsm_vtpm_send_command(priv->buffer);
+}
+
+static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+
+	/*
+	 * The internal buffer contains the response after we send the command
+	 * to SVSM.
+	 */
+	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
+}
+
+static void tpm_svsm_cancel(struct tpm_chip *chip)
+{
+	/* not supported */
+}
+
+static u8 tpm_svsm_status(struct tpm_chip *chip)
+{
+	return 0;
+}
+
+static bool tpm_svsm_req_canceled(struct tpm_chip *chip, u8 status)
+{
+	return false;
+}
+
+static struct tpm_class_ops tpm_chip_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.recv = tpm_svsm_recv,
+	.send = tpm_svsm_send,
+	.cancel = tpm_svsm_cancel,
+	.status = tpm_svsm_status,
+	.req_complete_mask = 0,
+	.req_complete_val = 0,
+	.req_canceled = tpm_svsm_req_canceled,
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
+	 * The maximum buffer supported is one page (see SVSM_VTPM_MAX_BUFFER
+	 * in tpm_svsm.h).
+	 */
+	priv->buffer = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	if (!priv->buffer)
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
2.49.0


