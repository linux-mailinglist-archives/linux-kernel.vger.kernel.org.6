Return-Path: <linux-kernel+bounces-429549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B059E1F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E13EB38B53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EDD1E3DCF;
	Tue,  3 Dec 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgtpWOG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5051EE031
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232803; cv=none; b=PKIikPJxghYQgISvWzMW6n6QibLft+ntYHi0mM+zwvmPf6i5nQRKd1xtxuJplAyvWCIrI0OCZKcJ3QPvXsbk8zKC26VHDSXUr6raqX6ZKx/Z7AQctleXCh9gPvNILbAuVMJyPIf/0NJyCS4jowLqetd9N8vplg7d6QuRtjBDqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232803; c=relaxed/simple;
	bh=rMaSDNSAJrbcxHZSVbXsKcHrwaahyhZiCTadCvujcTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iKB+ZDUBx4ZVnZ4qxkEKk1N6yF7u8zS8IWhJH5449YrXRDG8gK5AIaGac0KKGxTjq7RjRGlhi1LCp3KBoTrj521xiE/DMZ45cQfhMQr9d4Obtzn+mwR+2LjtcSbOyGtN1svfpdXblvidJtiSaabGTqOWCtuG47GC3/qNkN3OV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgtpWOG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D542C4CED6;
	Tue,  3 Dec 2024 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733232803;
	bh=rMaSDNSAJrbcxHZSVbXsKcHrwaahyhZiCTadCvujcTM=;
	h=From:Date:Subject:To:Cc:From;
	b=pgtpWOG+zcKRKdVjqh9iU3+hyGm0TqFnqArKydS09r2e6nQw4nV32sg15c9J5ZWcW
	 weNz0O44yMGyHeBQZ24lUrtmxv4Vtgd/vNIj8lujOd4FssrD2lXMTmwMAZrIh/w9Hy
	 xRU1ZGJHZCptYzBhvTsuEttLWozs5fkoaMczl3uoethL50oq8vN7Sv8dtxSJNJ/sNW
	 iaK61o2Wy/CKqjr9PA7jcxKZ3vMK73p/nawAkKOTaOBOzZeTSb+JlD6yZSR4CcmklY
	 jj7rp+J35XKn/AjpVtC62WnVgLTOJcJtQBq+ByWwidLmrrmoSJdcan0r2MSR2x/I5k
	 ehlW7UPixHG2Q==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 03 Dec 2024 15:33:17 +0200
Subject: [PATCH] mtd: rawnand: omap2: Fix build warnings with W=1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-omap2-doc-fix-v1-1-f46cd2a5c055@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJwIT2cC/x2MQQqAMAzAviI9W9haRfAr4kFn1R50YwMRxL9bP
 CaQPFAkqxToqweyXFo0nga+riDs07kJ6mIM5Kjx5BjjMSXCJQZc9UbhWcQ1XcsrgzUpi+n/N4z
 v+wGJlMBYXwAAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4570; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=rMaSDNSAJrbcxHZSVbXsKcHrwaahyhZiCTadCvujcTM=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnTwih1vcygEgDaCB6oM4tIWffmiDB/Dsp2OrTy
 8ZGkkapbGKJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ08IoQAKCRDSWmvTvnYw
 kyVkD/4p+IhXsNs7coGVFFZDAcqAcc6xwYQahANbTwCI+x3DaH+6Sv9RsR6JocmOjveVkxzdLF5
 yuJVp+ht1pKFtomZd38xrETk9SVGzrutoZB1yH5o4TWukF9+WuZC4Y6myHRD1h9XttLVkLe2Gwe
 Ya8AIhhZ/6xmchoVmt0ijrZro51Ifo9lzw/TwaG7FWxQrqMRLDZvqsXT1NY4ChRK10+kmiqkiuP
 GREWFZ16OAyTSiTDOae4cIbIjd8SZNBS445tYR3oC47HJtT27Iptc39nrW37ewhgdx1d3lzfzCG
 oIhVe4DwqSvWcHZ0bfzRZN6DSOLQ9Y+719MoHUO/n2maCJ8zxwxtSfmSfMp4/vjsFcyNrYOf6gm
 2X/Meaf5KHix3HXZCPwLjIhRTZhdRMKyI4iUZMiPxq82FJP5ay20nsNwbec7j4Gd6IuwFVtR7mW
 /Z6JmavkOuOvPMwhvgIxvCjyyWltKqGNrEJvfZ/soG04ZaEPE4RBP4T26fVcGywIXIof9wBnp8l
 RCv6IcsCRXmAtKhIrD+yRmYxoKdZ6O75sb3dEzY9tU9zTNdJgWQaG95U8Ls7jVuwrKdNjA3aBAH
 UdRs8HKxSSvtHHVGzvNXUFZWqRHaelNGi30QUKK93z50J6f8s8ULdEnuuUxO4q/Mz9dhRNhsXrs
 MxeTBS/DKbbezRQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Add kernel-doc for functions to get rid of below warnings
when built with W=1.

drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_in_pref'
drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_in_pref'
drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_in_pref'
drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_in_pref'
drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_out_pref'
drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_out_pref'
drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_out_pref'
drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_out_pref'
drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_in_dma_pref'
drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_in_dma_pref'
drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_in_dma_pref'
drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_in_dma_pref'
drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_out_dma_pref'
drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_out_dma_pref'
drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_out_dma_pref'
drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_out_dma_pref'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412031716.JfNIh1Uu-lkp@intel.com/
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index d9141f3c0dd1..b8af3a3533fc 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -254,6 +254,10 @@ static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
 
 /**
  * omap_nand_data_in_pref - NAND data in using prefetch engine
+ * @chip: NAND chip
+ * @buf: output buffer where NAND data is placed into
+ * @len: length of transfer
+ * @force_8bit: force 8-bit transfers
  */
 static void omap_nand_data_in_pref(struct nand_chip *chip, void *buf,
 				   unsigned int len, bool force_8bit)
@@ -297,6 +301,10 @@ static void omap_nand_data_in_pref(struct nand_chip *chip, void *buf,
 
 /**
  * omap_nand_data_out_pref - NAND data out using Write Posting engine
+ * @chip: NAND chip
+ * @buf: input buffer that is sent to NAND
+ * @len: length of transfer
+ * @force_8bit: force 8-bit transfers
  */
 static void omap_nand_data_out_pref(struct nand_chip *chip,
 				    const void *buf, unsigned int len,
@@ -440,6 +448,10 @@ static inline int omap_nand_dma_transfer(struct nand_chip *chip,
 
 /**
  * omap_nand_data_in_dma_pref - NAND data in using DMA and Prefetch
+ * @chip: NAND chip
+ * @buf: output buffer where NAND data is placed into
+ * @len: length of transfer
+ * @force_8bit: force 8-bit transfers
  */
 static void omap_nand_data_in_dma_pref(struct nand_chip *chip, void *buf,
 				       unsigned int len, bool force_8bit)
@@ -460,6 +472,10 @@ static void omap_nand_data_in_dma_pref(struct nand_chip *chip, void *buf,
 
 /**
  * omap_nand_data_out_dma_pref - NAND data out using DMA and write posting
+ * @chip: NAND chip
+ * @buf: input buffer that is sent to NAND
+ * @len: length of transfer
+ * @force_8bit: force 8-bit transfers
  */
 static void omap_nand_data_out_dma_pref(struct nand_chip *chip,
 					const void *buf, unsigned int len,

---
base-commit: cdd30ebb1b9f36159d66f088b61aee264e649d7a
change-id: 20241203-omap2-doc-fix-e3bee04753f3

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


