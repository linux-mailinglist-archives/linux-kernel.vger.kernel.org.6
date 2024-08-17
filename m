Return-Path: <linux-kernel+bounces-290725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B29557DD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357EF1F21B93
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF226154444;
	Sat, 17 Aug 2024 12:42:28 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580815350B;
	Sat, 17 Aug 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898548; cv=none; b=EVNbywkzAh9zCYX3bgjEGCOkYj3te39TqNM2ybTBniugS9rQHZ6Nlbh4l+0mbvpFa4XPdoPD23PqiwbgRmyLCmGzVsAarv2r3Saw6GPi2uIL+Uknzs6qg4NTnErSb3Vnh/yKRtdBmvBhNbxdcgrKo91tZNN76T0Sb+BEzbrK0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898548; c=relaxed/simple;
	bh=8MCq0A44ypknCHYEOPZoHWh8xeuUVB1YzKZnquigXZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nM36rJZkZJZHdK2SjcXiP0i7rYnx1iHe4KuFaAE1u2MRwadcX3Qo5ZmchNVXo4tqd0/vwZEe2QNWfxjjTfP4yvu3GcyOtZdyNuBnTby0I6tdGRV8RE9/sNpqjxmlKejGSxwySm7noOOAfEm2T5NIwoI35Mk+2QLQz/SVxFax84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip1f10f85d.dynamic.kabel-deutschland.de [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4WmJQx2dGgzMQvc;
	Sat, 17 Aug 2024 12:42:17 +0000 (UTC)
From: Erez Geva <erezgeva@nwtime.org>
To: linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v3 3/4] mtd: spi-nor: macronix: add support for OTP
Date: Sat, 17 Aug 2024 14:41:39 +0200
Message-Id: <20240817124140.800637-4-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240817124140.800637-1-erezgeva@nwtime.org>
References: <20240817124140.800637-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Macronix SPI-NOR support OTP.
Add callbacks to read, write and lock the OTP.

Notice Macronix OTP do not support erase.
Every bit written with '0', can not be changed further.

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 drivers/mtd/spi-nor/macronix.c | 185 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  10 ++
 2 files changed, 195 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..8df87b414e47 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,180 @@
 
 #include "core.h"
 
+/**
+ * macronix_nor_otp_enter() - Send Enter Secured OTP instruction to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int macronix_nor_otp_enter(struct spi_nor *nor)
+{
+	int error;
+
+	error = spi_nor_send_cmd(nor, SPINOR_OP_ENSO);
+
+	if (error)
+		dev_dbg(nor->dev, "error %d on Macronix Enter Secured OTP\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_exit() - Send Exit Secured OTP instruction to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int macronix_nor_otp_exit(struct spi_nor *nor)
+{
+	int error;
+
+	error = spi_nor_send_cmd(nor, SPINOR_OP_EXSO);
+
+	if (error)
+		dev_dbg(nor->dev, "error %d on Macronix Exit Secured OTP\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_read() - read security register
+ * @nor:	pointer to 'struct spi_nor'
+ * @addr:       offset to read from
+ * @len:        number of bytes to read
+ * @buf:        pointer to dst buffer
+ *
+ * Return: number of bytes read successfully, -errno otherwise
+ */
+static int macronix_nor_otp_read(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
+{
+	int ret, error;
+
+	error = macronix_nor_otp_enter(nor);
+	if (error)
+		return error;
+
+	ret = spi_nor_read_data(nor, addr, len, buf);
+
+	error = macronix_nor_otp_exit(nor);
+
+	if (ret < 0)
+		dev_dbg(nor->dev, "error %d on Macronix read OTP data\n", ret);
+	else if (error)
+		return error;
+
+	return ret;
+}
+
+/**
+ * macronix_nor_otp_write() - write security register
+ * @nor:        pointer to 'struct spi_nor'
+ * @addr:       offset to write to
+ * @len:        number of bytes to write
+ * @buf:        pointer to src buffer
+ *
+ * Return: number of bytes written successfully, -errno otherwise
+ */
+static int macronix_nor_otp_write(struct spi_nor *nor, loff_t addr, size_t len, const u8 *buf)
+{
+	int error, ret = 0;
+
+	error = macronix_nor_otp_enter(nor);
+	if (error)
+		return error;
+
+	error = spi_nor_write_enable(nor);
+	if (error)
+		goto otp_write_err;
+
+	ret = spi_nor_write_data(nor, addr, len, buf);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "error %d on Macronix write OTP data\n", ret);
+		goto otp_write_err;
+	}
+
+	error = spi_nor_wait_till_ready(nor);
+	if (error)
+		dev_dbg(nor->dev, "error %d on Macronix waiting write OTP finish\n", error);
+
+otp_write_err:
+
+	error = macronix_nor_otp_exit(nor);
+
+	return ret;
+}
+
+/**
+ * macronix_nor_otp_lock() - lock the OTP region
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int macronix_nor_otp_lock(struct spi_nor *nor, unsigned int region)
+{
+	int error;
+	u8 *rdscur = nor->bouncebuf;
+
+	error = spi_nor_read_reg(nor, SPINOR_OP_RDSCUR, 1);
+	if (error) {
+		dev_dbg(nor->dev, "error %d on read security register\n", error);
+		return error;
+	}
+
+	switch (region) {
+	case 0: /* Lock 1st 4K-bit region */
+		if (rdscur[0] & SEC_REG_LDS1)
+			return 0; /* Already locked */
+		rdscur[0] |= SEC_REG_LDS1;
+		break;
+	case 1: /* Lock 2nd 4K-bit region */
+		if (rdscur[0] & SEC_REG_LDS2)
+			return 0; /* Already locked */
+		rdscur[0] |= SEC_REG_LDS2;
+		break;
+	default:
+		return 0; /* Unknown region */
+	}
+
+	error = spi_nor_write_reg(nor, SPINOR_OP_WRSCUR, 1);
+	if (error)
+		dev_dbg(nor->dev, "error %d on update security register\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_is_locked() - get the OTP region lock status
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int macronix_nor_otp_is_locked(struct spi_nor *nor, unsigned int region)
+{
+	int ret;
+	u8 *rdscur = nor->bouncebuf;
+
+	ret = spi_nor_read_reg(nor, SPINOR_OP_RDSCUR, 1);
+	if (ret) {
+		dev_dbg(nor->dev, "error %d on read security register\n", ret);
+		return ret;
+	}
+
+	switch (region) {
+	case 0: /* 1st 4K-bit region */
+		ret = (rdscur[0] & SEC_REG_LDS1) > 0;
+		break;
+	case 1: /* 2nd 4K-bit region */
+		ret = (rdscur[0] & SEC_REG_LDS2) > 0;
+		break;
+	default: /* Unknown region */
+		break;
+	}
+	return ret;
+}
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -190,8 +364,19 @@ static void macronix_nor_default_init(struct spi_nor *nor)
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
+static const struct spi_nor_otp_ops macronix_nor_otp_ops = {
+	.read = macronix_nor_otp_read,
+	.write = macronix_nor_otp_write,
+	/* .erase = Macronix OTP do not support erase, */
+	.lock = macronix_nor_otp_lock,
+	.is_locked = macronix_nor_otp_is_locked,
+};
+
 static int macronix_nor_late_init(struct spi_nor *nor)
 {
+	if (nor->params->otp.org.n_regions)
+		nor->params->otp.ops = &macronix_nor_otp_ops;
+
 	if (!nor->params->set_4byte_addr_mode)
 		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index cdcfe0fd2e7d..86490c291b88 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -81,6 +81,16 @@
 #define SPINOR_OP_BP		0x02	/* Byte program */
 #define SPINOR_OP_AAI_WP	0xad	/* Auto address increment word program */
 
+/* Macronix OTP registers. */
+#define SPINOR_OP_RDSCUR	0x2b	/* read security register */
+#define SPINOR_OP_WRSCUR	0x2f	/* write security register */
+#define SPINOR_OP_ENSO		0xb1	/* enter secured OTP */
+#define SPINOR_OP_EXSO		0xc1	/* exit secured OTP */
+
+/* Macronix security register values */
+#define SEC_REG_LDS1		BIT(1)  /* lock-down bit 1st 4K-bit */
+#define SEC_REG_LDS2		BIT(0)  /* lock-down bit 2nd 4K-bit */
+
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
-- 
2.39.2


