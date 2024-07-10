Return-Path: <linux-kernel+bounces-246836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDEE92C7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD8A1F2394E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659D4A3E;
	Wed, 10 Jul 2024 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LInam0wu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27F8BE7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574224; cv=none; b=OGGYHSfXkv+2FkXfP/p9GMY64eLHvsueKZc3DG48KgODM0ZmlPML9gNcj3c9DVJa2DBs6XwSMMF8u1TxXozkjtjOVanssj6qXeo/zH2Vut/zWVYQtgneUK6vxZc6TsNvlzRA2DhLfn5cFz6LbDvhCLMcADVl4B91j1fZP7ovD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574224; c=relaxed/simple;
	bh=4m0kxCVKUAnDd/Uoez1WAkvoNV+NXC8WY09fkTZTebs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iU0iQC7VbyrSGxmbsqJoRgO4SWDJja6xlDg5ZeJPVMZP1PT5CBtSTyvoHhMDqH+OlKpEd4se8BvsSXmOuuSPUXvAuC6SL38lFSVjWMgOLEDkNiP1dV8RRd9CIC9fRVN4V6gpAkEqxhmWUUKTvX7jD2H5hgS/qXBuQxO8ECrxNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LInam0wu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so29605995ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720574223; x=1721179023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf0ReuyQOi5SXQsUOQzTmoOvTe5c8o2DFeqT2/r8W4I=;
        b=LInam0wu9PQA1+yfPhdCYg5s0U8rFqSHLRB/3smlg3rfv0UNQhT1nYcP2UYUUV2LeX
         erVhxtJILqd6MJI5V4REgzGWL3Rm0vKLReC6XDCoaAXoo29EYHmtH13eoLzbNtehdn7T
         hFIrREFsIUoR4fs+mlW+HuPhbf/b+5ySkZ00ci4Xfp5aaO2fw8FHl/frTkZlFU8xMOkH
         x2JGt0FuxGLQxMpNTUjVx4UnauiWh2CC0VeMkNuBiWKEtaPae6FePiDjKKKjjIxKejR1
         8Psuzis2BS3WOx4dIqktV8IX8wws6kF4O2h/pTx7avETKiWX6w1HmRcefnJoAv+6Wnl9
         o7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720574223; x=1721179023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf0ReuyQOi5SXQsUOQzTmoOvTe5c8o2DFeqT2/r8W4I=;
        b=rmdehWWnIpgJvwujWfOiOLppfnZarl68hAo7Vs3CS2J/UKVi3J5fN1HYhZD1IxOYcY
         LpzLiXNX75iXOh53L0GOI3HTuz2ap6TmI5WIohz1+itWn2e+rObHHA4T3vJ+Q95CyJ4k
         F82Bto3wiYoBrPLrbP+FTOzoT8upMBK/C4nJ+KO3mV5mSRyQBSyat//jFeBCthRVHU28
         WQAwMgoqoSjb4DH3tCdjegjMnvQXO6vbxv+Y1jhw+rhzAeFB5ocluknMqZdlLw3Kcuc1
         YiKxU3VgyS63osMy3ps8rJnxosDWSZ2HFkHYGq1WL6susOWZLFwFqJs+x87cFYgLKp8q
         34GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGruhNk7u9WwjAOngG3jI0kh2ofsm7ITzXY9TyBLORfMC1edA9C2rVDSoo56VEs43faJHCJ3u69M+ooe/UCw4yR9Xo5UXn6jrvaaKb
X-Gm-Message-State: AOJu0YxkIDwHvmGTOcNeZ/l4cO9yCYQNaMubTBJRWZTh4Qico2VNR40r
	I4QF4ynHtlbXUYbeqeBO1mLeaVREuSB2Zb0NieDnu/l22HOCpbMy
X-Google-Smtp-Source: AGHT+IEgKzUS2C58JGutlZ0YXRBY+FjMO0+UJyNyABmzG1f2vpoCM4JuCsrJpw5PgmaB9SqS74yOZQ==
X-Received: by 2002:a17:902:e54c:b0:1fb:5c3d:b8c3 with SMTP id d9443c01a7336-1fbb6cdab3amr35816045ad.4.1720574222520;
        Tue, 09 Jul 2024 18:17:02 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad4bc9sm22010445ad.286.2024.07.09.18.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:17:02 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 9157880B36;
	Wed, 10 Jul 2024 09:26:27 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 1/3] include/linux/mtd/spinand.h: Add fixups for spinand
Date: Wed, 10 Jul 2024 09:15:39 +0800
Message-Id: <20240710011541.342682-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710011541.342682-1-linchengming884@gmail.com>
References: <20240710011541.342682-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add struct spi_nand_fixups as SPI NAND fixup hooks.

To determine whether the Plane Select bit should be
inserted into the column address in core.c, add the
member struct spinand_info to struct spinand_device
to ascertain whether the device has fixups.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 include/linux/mtd/spinand.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..c079c6ac1541 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -354,6 +354,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	const struct spi_nand_fixups *fixups;
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +380,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_PLANE_SELECT_BIT(__func)					\
+	.fixups = __func,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -398,6 +402,18 @@ struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
+/**
+ * struct spi_nand_fixups - SPI NAND fixup hooks
+ * @write_to_cache: program load requires Plane Select bit in CADD.
+ * @read_from_cache: read from cache requires Plane Select bit in CADD.
+ */
+struct spi_nand_fixups {
+	unsigned int (*write_to_cache)(struct spinand_device *spinand,
+				const struct nand_page_io_req *req, unsigned int column);
+	u16 (*read_from_cache)(struct spinand_device *spinand,
+				const struct nand_page_io_req *req, u16 column);
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -449,6 +465,7 @@ struct spinand_device {
 	u8 *databuf;
 	u8 *oobbuf;
 	u8 *scratchbuf;
+	const struct spinand_info *info;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
 };
-- 
2.25.1


