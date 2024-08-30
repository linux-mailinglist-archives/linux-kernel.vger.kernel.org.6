Return-Path: <linux-kernel+bounces-308519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0554965DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AFB1C22461
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757BF185E6E;
	Fri, 30 Aug 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUt4Eli3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFF184524
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012333; cv=none; b=pYRiMndE/jyoJnfLNCVMXei0FizIST72f1Fw4c3YJGS6S7ZE/ClEJgNFPI7ewVeZID0ErWbc82n3HvX6myR+jSPvr+ulJWvW7ZoqkHKGFlAnm06kd7vypkYMaQok8+eQDmffzrZNHlpXiGtbqLxpochiSDOHFFGFQPbXBeylBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012333; c=relaxed/simple;
	bh=tolGfl03yLfaWqeEhCeWkliWUwPxOzr1OwxM/FadN28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kwg+0cUNgj+4CZFH8Pf0qbW0ZTDd2/gilp9SqSbpLNcXVQOwupFp/fD/JiyS+6KvD6LUF03uuTYrxJYT/ZkWcG6Qs9mCA7rXY6pTfHUr1T3XrLwkzRpeIDjRssOosZP6MTwUkywQEVBUhqIb9K864BaSjZ0BLNxC7yV5jaJNDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUt4Eli3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20536dcc6e9so1484365ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012330; x=1725617130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujFttD3pwqoLnOaK61kxmmuY79VSw05G+mBIn6vQcDE=;
        b=LUt4Eli3dRB1jHxj6ufWMhCqXKNNAe/1Jr+LHz5roKy8jjLtacKrWBkgDuSNEvsXND
         vQoLWE4mPvxw/jGiUJXSLTQGEl7aBxIyK26CKs+swOaLII4F5cS6DELoUDoCR+KYz26i
         s3fyuUdb7pdwIs8yyaBn/kt7vx12TlrmDfQ/b6pDcSfRenNb0D0wZ51PUxSuNExixXKX
         DrwoPJdCP6vGdC+1fOZuOlC2zC+lUkbOnO3ip8ZepD5xzgXD1Fmi68UpIlsGPzaqqsAA
         B+BpgpoiGTrAXUGQB7jlOMSaQ7JnYNBQNZ9SfPMVvJLHZbY5mVQHAaIb8u4ymn1il5NU
         pHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012330; x=1725617130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujFttD3pwqoLnOaK61kxmmuY79VSw05G+mBIn6vQcDE=;
        b=jTx9988g9HFefRhG5mb84QX0AADH2dh8seEK4czYN/SdeS32hgmZDL8LL6mady/xzw
         XG3C8ZmwuoCnpZdwwRhn/qJqQqsu4czvwAMpmfEqQg30t2RJL2tqevjsuI9eTS2ijTQd
         AjE2Gik0MLUW44c4Pw+Wv3SVCwy+8LCQ2VCcl9PM2ytPIQF9m/kQiCAoYa4eoQOuxsgG
         L9phrKbYKCjGr+MC0bZ4L3gn7GpuGhZOCO+oKJRk5gdDDxaTZaU1WDPFjinmGGhDOL5h
         QltKscjM7JwTSaJEAQD93y2yvK6AW34+ZLWc+U6DG6ptUWOVfCojxeSSMmk6b37+T1HE
         0pug==
X-Forwarded-Encrypted: i=1; AJvYcCW53ztjfQq/QVOFChERVgDScr0vLR5J2ysh2WvvObVBHBPgCw/7+assgvoeJUBHyaV8e/Tz11gid5YVFSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDL34/ZNAK2IPDmNNL65IqzjRwxcbjjhYauV5ThaBAaowSDaCB
	Kuu/1HRdF89Fp+YMrL5g4lvtMT3X2KJTb7CKc2sWzubsxd7MYMtiJ7dqgw==
X-Google-Smtp-Source: AGHT+IHLBKlMUybqKBiC16M66/nmTmwdFS/I6Vt4aqj2C6ubd3+YM203iTJ4l88THZY/kpa8NjVnlg==
X-Received: by 2002:a17:902:f550:b0:201:f568:b8fd with SMTP id d9443c01a7336-2050c40de86mr65686325ad.42.1725012330414;
        Fri, 30 Aug 2024 03:05:30 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542376sm23934725ad.204.2024.08.30.03.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:05:30 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 5BB2E802C7;
	Fri, 30 Aug 2024 18:14:04 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v5 2/2] mtd: spinand: macronix: Flag parts needing explicit plane select
Date: Fri, 30 Aug 2024 18:03:10 +0800
Message-Id: <20240830100310.1553675-3-linchengming884@gmail.com>
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

Macronix serial NAND flash with a two-plane structure requires
insertion of the Plane Select bit into the column address during
the write_to_cache operation.

Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of
the Plane Select bit into the column address is required during
the read_from_cache operation.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3f9e9c572854..9c93dfcb955d 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -118,7 +118,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26, 0x03),
@@ -156,7 +158,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
@@ -174,7 +177,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
@@ -213,7 +217,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
@@ -223,7 +229,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
@@ -253,7 +260,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
@@ -263,7 +272,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
-- 
2.25.1


