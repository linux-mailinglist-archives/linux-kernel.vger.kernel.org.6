Return-Path: <linux-kernel+bounces-334604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D384A97D988
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D311C211B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845518454C;
	Fri, 20 Sep 2024 18:13:23 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E6183CCA;
	Fri, 20 Sep 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856003; cv=none; b=tOdPDsZkJpE3JStZbUlbdyIePxEH12grsLiMoWhEYTWWVsr+Zxqkyck2rGhDwh+XtYCKuXpvrrYkxJyhCxqMSResTMM3PJMcReuXcfRkxzEVgtCYZBQxoUSBLAP2eBWbq0tb5Rz3w5g9EJyAQAnhPGQgXd2pJszYCIw0QEy+lZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856003; c=relaxed/simple;
	bh=Ve/+ZonvDNGWe7oZjfCCGrglLlhE4a92ZIQ+Gp9bncI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNkTbOmlo9Is764A9xSV4+olRAJaa1l7SbI2Hkf39mJ6rguUXU4j7FvnQekLqoAqbikQiTrHzcG2D4af1CAlYg5SgDJ9EOyKPjTqKqfzCft45RYRPZQbIRLTRT+pxTBRPsSCbudvzQdTF//rhw07fwAta9D0+0LfqDspmPBCntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip-77-25-16-238.web.vodafone.de [77.25.16.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4X9L902clHzMR7l;
	Fri, 20 Sep 2024 18:13:08 +0000 (UTC)
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
Subject: [PATCH v5 2/5] mtd: spi-nor: core: add generic functions
Date: Fri, 20 Sep 2024 20:12:28 +0200
Message-Id: <20240920181231.20542-3-erezgeva@nwtime.org>
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

Create a new internal function, spi_nor_send_cmd_internal()
 to reduce duplicate code.

Add generic functions for use by vendor callbacks.
The functions contain dispatching for using SPIMEM
 or using an SPI controller.
It is better to leave this kind of dispatcher,
 out side of vendor specific code.

In this patch series we use the new functions in
 Macronix new OTP callbacks.

The new added functions:

 - Send an opcode without address or data.

 - Read a register value.

 - Write a register value.

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 drivers/mtd/spi-nor/core.c | 130 +++++++++++++++++++++++++++----------
 drivers/mtd/spi-nor/core.h |  27 +-------
 2 files changed, 99 insertions(+), 58 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0238475059f0..e486596fc70a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -354,53 +354,134 @@ int spi_nor_write_any_volatile_reg(struct spi_nor *nor, struct spi_mem_op *op,
 }
 
 /**
- * spi_nor_write_enable() - Set write enable latch with Write Enable command.
+ * spi_nor_send_cmd_internal() - Send instruction without address or data to the chip.
  * @nor:	pointer to 'struct spi_nor'.
+ * @opcode:	Command to send
  *
  * Return: 0 on success, -errno otherwise.
  */
-int spi_nor_write_enable(struct spi_nor *nor)
+static inline int spi_nor_send_cmd_internal(struct spi_nor *nor, u8 opcode)
 {
 	int ret;
 
 	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_WREN_OP;
+		struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),
+					   SPI_MEM_OP_NO_ADDR,
+					   SPI_MEM_OP_NO_DUMMY,
+					   SPI_MEM_OP_NO_DATA);
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WREN,
-						       NULL, 0);
+		ret = spi_nor_controller_ops_write_reg(nor, opcode, NULL, 0);
 	}
 
-	if (ret)
-		dev_dbg(nor->dev, "error %d on Write Enable\n", ret);
+	return ret;
+}
+
+/**
+ * spi_nor_send_cmd() - Send instruction without address or data to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @opcode:	Command to send
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_send_cmd(struct spi_nor *nor, u8 opcode)
+{
+	int ret;
+
+	ret = spi_nor_send_cmd_internal(nor, opcode);
 
 	return ret;
 }
 
 /**
- * spi_nor_write_disable() - Send Write Disable instruction to the chip.
+ * spi_nor_read_reg() - Send instruction without address or data to the chip.
  * @nor:	pointer to 'struct spi_nor'.
+ * @opcode:	Command to send
+ * @len:	register value length
  *
  * Return: 0 on success, -errno otherwise.
  */
-int spi_nor_write_disable(struct spi_nor *nor)
+int spi_nor_read_reg(struct spi_nor *nor, u8 opcode, size_t len)
 {
 	int ret;
 
 	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_WRDI_OP;
+		struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),
+					   SPI_MEM_OP_NO_ADDR,
+					   SPI_MEM_OP_NO_DUMMY,
+					   SPI_MEM_OP_DATA_IN(len, nor->bouncebuf, 0));
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WRDI,
-						       NULL, 0);
+		ret = spi_nor_controller_ops_read_reg(nor, opcode, nor->bouncebuf, len);
 	}
 
+	return ret;
+}
+
+/*
+ * spi_nor_write_reg() - Send instruction without address or data to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @opcode:	Command to send
+ * @len:	register value length
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, size_t len)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),
+					   SPI_MEM_OP_NO_ADDR,
+					   SPI_MEM_OP_NO_DUMMY,
+					   SPI_MEM_OP_DATA_OUT(len, nor->bouncebuf, 0));
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor, opcode, nor->bouncebuf, len);
+	}
+
+	return ret;
+}
+
+/**
+ * spi_nor_write_enable() - Set write enable latch with Write Enable command.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_write_enable(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_send_cmd_internal(nor, SPINOR_OP_WREN);
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d on Write Enable\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_write_disable() - Send Write Disable instruction to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_write_disable(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_send_cmd_internal(nor, SPINOR_OP_WRDI);
+
 	if (ret)
 		dev_dbg(nor->dev, "error %d on Write Disable\n", ret);
 
@@ -521,18 +602,8 @@ int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_EN4B_EX4B_OP(enable);
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_write_reg(nor,
-						       enable ? SPINOR_OP_EN4B :
-								SPINOR_OP_EX4B,
-						       NULL, 0);
-	}
+	ret = spi_nor_send_cmd_internal(nor, enable ? SPINOR_OP_EN4B :
+						SPINOR_OP_EX4B);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
@@ -765,16 +836,7 @@ int spi_nor_global_block_unlock(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_GBULK_OP;
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_GBULK,
-						       NULL, 0);
-	}
+	ret = spi_nor_send_cmd_internal(nor, SPINOR_OP_GBULK);
 
 	if (ret) {
 		dev_dbg(nor->dev, "error %d on Global Block Unlock\n", ret);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index c862e42c844f..615c399dfb6e 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -25,18 +25,6 @@
 		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 0))
 
-#define SPI_NOR_WREN_OP							\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 0),			\
-		   SPI_MEM_OP_NO_ADDR,					\
-		   SPI_MEM_OP_NO_DUMMY,					\
-		   SPI_MEM_OP_NO_DATA)
-
-#define SPI_NOR_WRDI_OP							\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 0),			\
-		   SPI_MEM_OP_NO_ADDR,					\
-		   SPI_MEM_OP_NO_DUMMY,					\
-		   SPI_MEM_OP_NO_DATA)
-
 #define SPI_NOR_RDSR_OP(buf)						\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 0),			\
 		   SPI_MEM_OP_NO_ADDR,					\
@@ -67,24 +55,12 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
-#define SPI_NOR_EN4B_EX4B_OP(enable)					\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B, 0),	\
-		   SPI_MEM_OP_NO_ADDR,					\
-		   SPI_MEM_OP_NO_DUMMY,					\
-		   SPI_MEM_OP_NO_DATA)
-
 #define SPI_NOR_BRWR_OP(buf)						\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 0),			\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
 
-#define SPI_NOR_GBULK_OP						\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_GBULK, 0),			\
-		   SPI_MEM_OP_NO_ADDR,					\
-		   SPI_MEM_OP_NO_DUMMY,					\
-		   SPI_MEM_OP_NO_DATA)
-
 #define SPI_NOR_DIE_ERASE_OP(opcode, addr_nbytes, addr, dice)		\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
 		   SPI_MEM_OP_ADDR(dice ? addr_nbytes : 0, addr, 0),	\
@@ -604,6 +580,9 @@ extern const struct attribute_group *spi_nor_sysfs_groups[];
 void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 			     struct spi_mem_op *op,
 			     const enum spi_nor_protocol proto);
+int spi_nor_send_cmd(struct spi_nor *nor, u8 opcode);
+int spi_nor_read_reg(struct spi_nor *nor, u8 opcode, size_t len);
+int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, size_t len);
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
-- 
2.39.5


