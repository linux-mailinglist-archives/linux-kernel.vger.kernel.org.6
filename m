Return-Path: <linux-kernel+bounces-334606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC997D98C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22721F21EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B2185B43;
	Fri, 20 Sep 2024 18:13:27 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC67B185920;
	Fri, 20 Sep 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856006; cv=none; b=JhMP13S6vrbRmDVZHAKY2th40cDbXCwGqGYNgZ5RO7vM2CXWX6SRuSC4oolmFbmz5fr/RT3CMbrdtF7lxncWDKAqJ/msK289JeUiPgkC5SVA6Da770YFKGr3NmQhlKdPwC7wSSgWB5tZj2c0v4NkbBzmX/XEy+Ra7/YXKxojt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856006; c=relaxed/simple;
	bh=T1nFgEJWHZEsX591v8Hi09zr74+KOQ/DBtV9mJr4lOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qONrABnx+c3SFtvBgmWq3PZN4ItWXZq7ND+gL1vGoGeywvh2bMMXAbuqxJpnwLVOggwWOVIbpKMmxmea2yawZ7NTMbmyb2njganH4eKphl7gYlNaelQzW+YLrsSBZVm0y22W8wuExG8Wxalrv8QyUGmMYR6c5F+xfV8ohKiAdWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip-77-25-16-238.web.vodafone.de [77.25.16.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4X9L961qzVzMR7t;
	Fri, 20 Sep 2024 18:13:14 +0000 (UTC)
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
	Esben Haabendal <esben@geanix.com>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v5 4/5] mtd: spi-nor: macronix: add support for OTP
Date: Fri, 20 Sep 2024 20:12:30 +0200
Message-Id: <20240920181231.20542-5-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920181231.20542-1-erezgeva@nwtime.org>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
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

Notice Macronix OTP do not support single region lock!
The locking includes all regions at once!

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 drivers/mtd/spi-nor/macronix.c | 167 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |   9 ++
 2 files changed, 176 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..bee62e9051d6 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,162 @@
 
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
+	if (error)
+		dev_dbg(nor->dev, "error %d on Macronix Exit Secured OTP\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_read() - read OTP data
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
+ * macronix_nor_otp_write() - write data to OTP
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
+ * macronix_nor_otp_lock() - lock the OTP
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
+	if (rdscur[0] & SEC_REG_LDSO)
+		return 0;
+
+	error = spi_nor_write_enable(nor);
+	if (error) {
+		dev_dbg(nor->dev, "error %d on enable write before update security register\n",
+			error);
+		return error;
+	}
+
+	error = spi_nor_send_cmd(nor, SPINOR_OP_WRSCUR);
+	if (error)
+		dev_dbg(nor->dev, "error %d on update security register\n", error);
+
+	return error;
+}
+
+/**
+ * macronix_nor_otp_is_locked() - get the OTP lock status
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Return: 1 on lock, 0 on not locked, -errno otherwise.
+ */
+static int macronix_nor_otp_is_locked(struct spi_nor *nor, unsigned int region)
+{
+	int error;
+	u8 *rdscur = nor->bouncebuf;
+
+	error = spi_nor_read_reg(nor, SPINOR_OP_RDSCUR, 1);
+	if (error) {
+		dev_dbg(nor->dev, "error %d on read security register\n", error);
+		return error;
+	}
+	return rdscur[0] & SEC_REG_LDSO ? 1 : 0;
+}
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -190,8 +346,19 @@ static void macronix_nor_default_init(struct spi_nor *nor)
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
index cdcfe0fd2e7d..ef834e7fc0ac 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -81,6 +81,15 @@
 #define SPINOR_OP_BP		0x02	/* Byte program */
 #define SPINOR_OP_AAI_WP	0xad	/* Auto address increment word program */
 
+/* Macronix OTP registers. */
+#define SPINOR_OP_RDSCUR	0x2b	/* read security register */
+#define SPINOR_OP_WRSCUR	0x2f	/* write security register */
+#define SPINOR_OP_ENSO		0xb1	/* enter secured OTP */
+#define SPINOR_OP_EXSO		0xc1	/* exit secured OTP */
+
+/* Macronix security register values */
+#define SEC_REG_LDSO		BIT(1)  /* Lock-down Secured OTP */
+
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
-- 
2.39.5


