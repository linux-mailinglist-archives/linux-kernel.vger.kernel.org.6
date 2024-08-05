Return-Path: <linux-kernel+bounces-275111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47F9480B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9FA1C2123A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153E15ECEF;
	Mon,  5 Aug 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mejZILgA"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AB2AE95
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880292; cv=none; b=ZJSJcVjcW8EKPCJqSJwXgOy4uNrG4WYNrKzzGw0U5WHReIwqJvsvLQBMYLh6dfXttUn3ax+hqak7WBl9NrkpVLexh1pfbO8mRYE+mP+orQU57jhCcxbmlULss3ErQZiJMc/sSxhbURq+WRIMV/1hORBcwyNxBpr1P5B3Abw7mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880292; c=relaxed/simple;
	bh=jQg7iXv8NtRmFFX32sMAC00Ru8VzrLsWVWyEMEZxKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFo05Kt+IcN1wmmEzfTcF/MOtg/BY8htS/m6SkpU1yzuD5Cgv1xmTgnxF9n1PBLczlCIinlUbxzbHaMGd2qINInFMJD2BxnGl7DGzBpxse8YB4meWfIcsuPUH5tJzbZsqcLGOY9ktFZnOM7HzHt9JmnT9pQ1ZcAAD09RvMJ299I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mejZILgA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso14263088a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722880289; x=1723485089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkVJE+4Fx6/uTP+LZJrDSqoUHx3l2UcP7rIRvO3yBOk=;
        b=mejZILgA2JcCnJY+FkOWSuTGjTV4MwLXlfiFGuRjZs+TMo3q9UYkQe5dj9YTeS6fgO
         5vyAVVJwQTPfYjtyjxKvf3YTABjhuIFQMZ5BgCF3EFXU56CS1xMArBOT6Effw1sQd8VS
         RTYT90P3o4bTvtwo4WY5c4mL7FrFZRKvqe4+Z/JcEhQeVYHCEuwuTA8acoOk6vcg5iNh
         R0qFW6C/qSi4YmLD6dIo3lQqgLDJyTD0urwdEy70xngkYEn2ZlRzffhV7xQYcM7yQ0eY
         Muu9CV4Zag6yleGtAd8YPpB+BTVLBjl9GuPos1tDKtvFZFzRt00uAZqo2XvEwOCHnUFA
         XxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880289; x=1723485089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkVJE+4Fx6/uTP+LZJrDSqoUHx3l2UcP7rIRvO3yBOk=;
        b=pjv0XJ3EzrYe1JC6YFm5fjI5nBziuT20aj5ELIY3B61rKsarxb17Lx/JqGQckEfWUI
         0NyWftTAy+48EGScb6c9Ysc8EmaKVL6XP3DFFF1PXEDEoJjMQ101/sbzm3igLB6CgTmU
         7o7KtPnSDwwh5AbPE5SzTOUvx5kD9p27XnGn/vcxCjnrB/qBu+tuWIx4xsNtc+7inI/f
         68aHOJ2fB/N3yqeRMSZQnUhui5PjFbQLfrJP6z7gz3GFboplBIoB2LIjCSDhBwGKT/h9
         wwH3AuZX7o8SsLWHWMzzkgpH6f62AFOJ2z71jCLPRYbwd6Rhgg7b0ms+mXuvM+0vP3C5
         1sXw==
X-Forwarded-Encrypted: i=1; AJvYcCUNvCYZVjK7f6HWy5bc/rSzQxMfJ/vqijpWwSryserBgFbjqar+4cONcCE8SBg0LBgzg/eYv5bK0f4797pR+Z+TqC74UeRmpngKsBj2
X-Gm-Message-State: AOJu0Yw+R78O7Bp3hvxdip+klTYZfHfEa83S3hMLiXxVx8S42zbz3BqD
	IYdkZqwSoefoUkIFS9uRGr7e9AJWL7+QkrzWhN5a0bMT/d4XFwbTU6kwPQ==
X-Google-Smtp-Source: AGHT+IHjO4GgAgcN5k7pxECHz/NsgP0x2hgZBtlquP4Xx433OfXJFukMMot6pi70owBA+ZhTUVZ8dg==
X-Received: by 2002:a50:ec8d:0:b0:5a2:2b56:e090 with SMTP id 4fb4d7f45d1cf-5b7f3bcf9aemr9258970a12.13.1722880288807;
        Mon, 05 Aug 2024 10:51:28 -0700 (PDT)
Received: from fedora.. (cpe-188-129-46-109.dynamic.amis.hr. [188.129.46.109])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3b21dsm5148453a12.89.2024.08.05.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:51:27 -0700 (PDT)
From: Robert Marko <robimarko@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH] mtd: spinand: winbond: add support for W25N01KV
Date: Mon,  5 Aug 2024 19:51:02 +0200
Message-ID: <20240805175125.6658-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Winbond W25N01KV 1Gbit SPI-NAND.

It has 4-bit on-die ECC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/mtd/nand/spi/winbond.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index ba7c813b9542..f3bb81d7e460 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -76,6 +76,18 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
+static int w25n01kv_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = 64 + (8 * section);
+	region->length = 7;
+
+	return 0;
+}
+
 static int w25n02kv_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -100,6 +112,11 @@ static int w25n02kv_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static const struct mtd_ooblayout_ops w25n01kv_ooblayout = {
+	.ecc = w25n01kv_ooblayout_ecc,
+	.free = w25n02kv_ooblayout_free,
+};
+
 static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.ecc = w25n02kv_ooblayout_ecc,
 	.free = w25n02kv_ooblayout_free,
@@ -163,6 +180,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	SPINAND_INFO("W25N01KV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),
+		     NAND_MEMORG(1, 2048, 96, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n01kv_ooblayout, w25n02kv_ecc_get_status)),
 	SPINAND_INFO("W25N02KV",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
-- 
2.45.2


