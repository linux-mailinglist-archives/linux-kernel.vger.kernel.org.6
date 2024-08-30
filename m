Return-Path: <linux-kernel+bounces-308518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CED965DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DBFB22E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C717DFE0;
	Fri, 30 Aug 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAe7RmbF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17617C232
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012327; cv=none; b=gk14Yua0Nuzi/4IorU/5o2rs55evYQECt6hVaUh3PM2lW2H6vkBxhJO7UQlvuuNFg/0cTu6CYBuVmImRQVxwRitsCBZ/vpWRZpoG1TcMwPZlXyDCZZdZV5Lx9wb7rkhUoQMRTXWXMY1zKXSIKeAhGYoEtUgPbOslkhc7aygnItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012327; c=relaxed/simple;
	bh=aIpQEyFAcDLz5PuuxUDCCMmXKqKJf+KfSWWjFnGsyec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNlsPe59bTu+Biu2xugsz89qwlVjhcIo5ibc71+JQO+U8h1mjQ/l/v0ZiJ8FCtvKPO5HRPDaBe5u1E2+l/MKClHQlZ28vrjWlC+PFftUVSz0aFVn6Fhx5nOqiI15QUYIar6IRwmCcLpcdGe/MkZlSt2kmxYu4F7RKDHvMBf2fpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAe7RmbF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2020b730049so14833165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012325; x=1725617125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhQv81jehYoOx+1+pRcsKIRWyPRSJ60CDoR58IZcqF0=;
        b=gAe7RmbFxGilwI/yyH2fNL1UCqzROdAGzRST7BHCUQs6Hs43wpE2h90BG6W9SWVyl2
         PlAZGmODJ4MLymi4tcMX8AFG9K2rcdPw1Q7yl0y6ZL8B9oIINNzUuMRMQC0QV8/YZQiy
         DjuWBHP9GQRzo1RkMfXvwpYWviaqqhUT9PWlH7beazNNkW+jyTUZpYYvH/YDymK9t+Uf
         4RJWHhZefuGWZ/PpH7qA/Gvf4QCsA/agtXU6dOFrcglMjksDNLRb1bFDx+3Nou6XnvB9
         BxVJJv0eNB0hAwJaUnCn5lz0TqcZC1jytnmPfBRObaaVkMO2qxwxpqTDzguyg2XB85Lj
         Pp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012325; x=1725617125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhQv81jehYoOx+1+pRcsKIRWyPRSJ60CDoR58IZcqF0=;
        b=ugU9UW4JxxIKntXr6dpNMHy//ml7+uTPWpA4QwRRUD8FzcPYj8cLsuxyYZ9ED06fG0
         J6kIyZ1+gvCGOEt2Mei23xoqLIr96BB1bQpV/orC+FKHM2ydBFXkldBLGHbg54Gko6gf
         k+EsX2kGzSbvkLrXEibe/RAbOqrMPkE5aBkpgzKrN0WdXWNXOi2MbobsXXMa0YN1yLxj
         /yjDIT8knc02ymxR5E1qqgE99L+YYhlKmEgiX5LZeEvQ3avDPyt5r8MNnx3L/ulQnNZm
         MZ5GKc4SvJhGuyD7LxagjKDPCfHjRT/xn2g9ZE6aKWgmyrCH126Xs2tna8ox50Go4XQq
         M4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCULeb6bQW/JA0FpR7mjL3MpthxuXky4nwrIr+nuOzPmMUsoWSdbWAOdoLQhwrSRFRDwXOXf/zCDwuGfGKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+DpKi93s7axHX23CQhi/MjnfWIhmu3efNFyzapYaljRKP+Ut
	FknHl6R/FxiiDOQZNuf4SSg+tMXSIdloc5BmmUFje0UK1uYEU2isIeHx6A==
X-Google-Smtp-Source: AGHT+IEEY/dv/vIcB5h62pI0nEUacj3+bS1H10RrD2W04PiglXKVsuq2qH1jtGC+ML7zHnSz5DjaEQ==
X-Received: by 2002:a17:902:da8d:b0:202:18af:2f9d with SMTP id d9443c01a7336-2050c350625mr69836085ad.31.1725012324406;
        Fri, 30 Aug 2024 03:05:24 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515545d91sm23885375ad.223.2024.08.30.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:05:23 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id EF4FE802C7;
	Fri, 30 Aug 2024 18:13:57 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v5 1/2] mtd: spinand: Add support for setting plane select bits
Date: Fri, 30 Aug 2024 18:03:09 +0800
Message-Id: <20240830100310.1553675-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830100310.1553675-1-linchengming884@gmail.com>
References: <20240830100310.1553675-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfe..e7b592cdbb4c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -460,6 +463,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..0e0df620da53 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -312,6 +312,8 @@ struct spinand_ecc_info {
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT		BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
-- 
2.25.1


