Return-Path: <linux-kernel+bounces-555769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E98A5BC89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9A13B3406
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A1233151;
	Tue, 11 Mar 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa3+p/bB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F25233141
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686172; cv=none; b=NgPkBdQ7UQUMkPhXeRQK+Ibh2kaYTfdoHucmeVexNtbbLtYAS/DiDGnhtMAUmceIFcwQy0kCchNxd/1/Aaxy0G5zlqrLIDT9Vlksb1AFHjIGlgVyfRRIXGm3j0hBCIVGTUpsS+77GH9iFnJ3XRubuK7KYi3xb+CoHJnvJS8VA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686172; c=relaxed/simple;
	bh=Q+8vPxxDbfpg9fRYXDZlhPTHw0u84I0SSyU4Nc1rsy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFpnt4PkDuKktaoLVjap+NJ1oiV7owamRtEiTOGkUWG9emSx4x2tc7qDC7stx2gjS2uiR5xJ5jk328REX+mvEWDx55WpL96ziDA/CREORn/anaVSXsuIfMZAdlss+sg0v+/StazYnFTQXq+mAZoi5/dAgw1EyjzMwb03vbfBlvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa3+p/bB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wb6+hQNYEWIXedIcFLeKnafG1DD76+LTwe3b4OwUzY=;
	b=Fa3+p/bBqiWbStzZ/OO1jL/aNdU+e4d6okFQZhuPLsPSxLa+emslQRaHo+onVUBuTrY0mf
	d7Gib7JnT8qWZbcTPCw1JCkUnJzw8PUjR2BgGVPC5KezUyVnqtLLSHQDPnTzf13IzVV7UA
	vZeyKX6p1vKF4vfCj59W/kUyuQ/BVqE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-o8fi6RRcN7CZK2QghF0CIg-1; Tue, 11 Mar 2025 05:42:48 -0400
X-MC-Unique: o8fi6RRcN7CZK2QghF0CIg-1
X-Mimecast-MFC-AGG-ID: o8fi6RRcN7CZK2QghF0CIg_1741686167
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2573f5876so320083466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686167; x=1742290967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wb6+hQNYEWIXedIcFLeKnafG1DD76+LTwe3b4OwUzY=;
        b=Amp/AH4TnKvydF4vv2Zbmsm3N0nkEsoNan0SAJuyFaZdnIETnozkgCbeIPS/mqOOUo
         SMIhzlxkMLBmNYUmoWMtXzYZN0J35AVj+Upe84IACd9j3kotdtH/8hrYWgeXOkzXRgcG
         v22QJ5pH2llhqZw6fkaf6mmhIU+NritacJDD/94U6FoP5yQBbmsqHXacGovwtvJPS9Kf
         EklRCyH+FJPzIJW1GfU0wyrFJpyyCD6yzokFn7M/24nKrsWT6Jlnge4f8Hve7p3ddc38
         tITwcq3m15CXDyzJ9P1+m8RoQM+nYcuHTnmfaDfbOVVr2B/UcVHiGf3WrUtZ/Y8SmXL+
         Sqnw==
X-Forwarded-Encrypted: i=1; AJvYcCVkwzgqzj2Re5ON8iQluw9trpxvqL1U8zyfW3zY63Gz8uy0k/7LE1lI/SRMJnIsUqbKo3y/QK2S7JPygDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbolbjDftKc+yyEQAzdW/KNq+omaRdicbc3+MfUoAnQ9ReIuM
	mpwtyFuIhydk1UCVsdF1DsIqFVNQPYNtK01dvey4g6sSki5+WHY45z0vALgDeCbuYYgtG4LLC0l
	CDZipYohizVNgLZ+nx/XQ3KV6fYjVewVb3c1PTJ9kU2yy/CSY6or2THVKDvWL9A==
X-Gm-Gg: ASbGnctrWLNYeRSgvU3wbBQKT0tpo0L51PnAcbbtmwt8egUHrdZtK6mnxTxieVJUcun
	mg/YeXhkcLBj/jeA+AzMEZ+DVKi0UeQEKXZSqpqFvtyB2Q/JTUHmQ0apNU//vEN1Zfeq0wlmUVS
	RvNRCXFrXSNWP9XWymprG4Xy+hTqIOeAjGqjXNaAb3TlMEi1bzJCuRz/X9reJnvioxbfF3x+EHT
	NFiPAq6aRHLmlbt3sO40A6I7iwAYlBH1QOaeJpr2KwVIrABGVMQwinQKcKiuAqTMnWBaNMY5Hha
	sb1TNvo7qRhR3Nu8i5a7gTcsh0t+fKVWSff2avGPQnOC7Snqin0eqlO9GbcHtwnZaijxqn/Y
X-Received: by 2002:a17:907:268a:b0:ac2:1c64:b26 with SMTP id a640c23a62f3a-ac252b2354amr2037758066b.32.1741686166799;
        Tue, 11 Mar 2025 02:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWmq7wXuMFVs0mGI08LvEZtWDeEa9Z/7uGOGcAtsq0hFXFdDMeo+Cdbl0Zx81eoMP5bl5BOw==
X-Received: by 2002:a17:907:268a:b0:ac2:1c64:b26 with SMTP id a640c23a62f3a-ac252b2354amr2037753166b.32.1741686166106;
        Tue, 11 Mar 2025 02:42:46 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25fae7d83sm701558766b.99.2025.03.11.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:42:45 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Date: Tue, 11 Mar 2025 10:42:24 +0100
Message-ID: <20250311094225.35129-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311094225.35129-1-sgarzare@redhat.com>
References: <20250311094225.35129-1-sgarzare@redhat.com>
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
v3:
- removed send_recv() ops and followed the ftpm driver implementing .status,
  .req_complete_mask, .req_complete_val, etc. [Jarkko]
- removed link to the spec because those URLs are unstable [Borislav]
---
 drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_svsm.c

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
new file mode 100644
index 000000000000..5540d0227eed
--- /dev/null
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -0,0 +1,148 @@
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
+#include <asm/sev.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/svsm_vtpm.h>
+
+#include "tpm.h"
+
+struct tpm_svsm_priv {
+	u8 buffer[SVSM_VTPM_MAX_BUFFER];
+	u8 locality;
+};
+
+static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	int ret;
+
+	ret = svsm_vtpm_fill_cmd_req((struct tpm_send_cmd_req *)priv->buffer,
+				     priv->locality, buf, len);
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
+	return svsm_vtpm_parse_cmd_resp((struct tpm_send_cmd_resp *)priv->buffer,
+					buf, len);
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


