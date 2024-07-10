Return-Path: <linux-kernel+bounces-246838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1692C7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AE01F231E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B991A947;
	Wed, 10 Jul 2024 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6lucaWl"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119C4A0F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574226; cv=none; b=L5lsy1Y20MYiCThP3E1M3Id1deVHeM9rTl+8ZEy3bUYmFAVcG37b8+MTP27k+jhirS+8SH6f3xKo343cHHGDqtrmtqu+HQbCbZN9g0uIK6hxofaSDAubb7YxODvwgqsOnraZLkNzOAMnimFy7P3QaX/JbYHBYCbxOIEtOuLrQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574226; c=relaxed/simple;
	bh=Oc1eD38l/cLvI8egL9nQZebSf+gkc/Z7A4dohoKdyQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5cJMzudJWOHcCBi2kleoyd7fueKCYAIG+TVBaoIYOkWC6zY3IwcdS9dHd6SLfgCV47vmOO4yVZ/UwLa2QhW/jVIeFEYFKElB1mwi3rKvEyDDPrMdXkcXirf1eHKxSseSyMk4oJR7F5tYjkJaW/v0gW7g6WWh8G19a4oPNB5Rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6lucaWl; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75a6c290528so3149169a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720574224; x=1721179024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2dsJ2aWzWwaeeiB+7cgn67HIrpaGRIuOZ04+FOm5ts=;
        b=l6lucaWluIvt6O7DO0q2FSV2wB9Qm+NfVU5HYa75VK8OCsf25nAujLEQj26qOgYkVW
         Im/Lfnq4vBqUitbQR9dBPnRy/FYkchvS2nemSNRP4lzbRFvnJNiIxb0wXmHmfSwdOqVR
         d44iMfw2KQifAFXmAxO/8FdqSpgAE8Tx9KSvVMfnB39m+nt/hnSm4oX03phLg5EXUZSM
         UHzeBJalyLuuU7v5c691xtLXbWh6zY2ktdM8CmikNKXowEek0g7tFQBV4Q8mURQlbpjx
         6NZfVXG1OUT6zHxjJ5K0WoQobN7cwH7+BLyDnIqeeJUUU8qZ6Gg+AfNFJzpuAWO1cL/X
         6E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720574224; x=1721179024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2dsJ2aWzWwaeeiB+7cgn67HIrpaGRIuOZ04+FOm5ts=;
        b=wms7SdEEwo/cnV/7Ovbcat2Ct6YL4+nAfNzZ5cI61u6wZHD0Kzi4Vl4PHOjD0oXwxI
         4jhlANjw2pMPFnWaOgZ6PL5LedbATjvO1oMfRpPEmZ+VzInJ8nB9Iv/pncsiyGWPXaru
         zYPAF0XIjwfa90vAQ7kI49PEhBljiX8l+Kqw+LR3Q6pZRcT8hqkEcRHpzjf3PemEFDcs
         LPTSx0qzjYvhSi/n2m/Lg/rz/khRoxPd1z+RHnAPJylcJ4WplJJvLes9EXPpk434fW/V
         IdaVusFoj8IpAWr0xBjf4NjQJKT+ymHxttqbzkdNyXnZIOpIdrr7jDJnE70tdiw+z/M3
         NmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/bpqpxIQS1zwg7sH+aQt4icGxhQR1JSOQr4i/XSHHTrQhw9IEGbfJB+HREb21pHPdI8e0wrLibBd2JpLkiVILZPUfs8iltKyBA1rb
X-Gm-Message-State: AOJu0YwfU5O2v9XTVd05Q0IQWvjxgJ/ZLMecb8DsTJC5hxcLsVuQt5oa
	0Ytm9Bjd4PTni0Wwrn4GHLAsUElGmPxraZejgAP1672zGmVpzty0
X-Google-Smtp-Source: AGHT+IHm6oTa46wAfHgqvgABJgg5St2rt8NOqt0qemFHgyPVBzhcmvIccECM4VmefXK8hvUPLjeUqw==
X-Received: by 2002:a05:6a20:7288:b0:1c1:f6f1:de05 with SMTP id adf61e73a8af0-1c298206687mr5241342637.6.1720574223818;
        Tue, 09 Jul 2024 18:17:03 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad4b60sm21960575ad.296.2024.07.09.18.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:17:03 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 5D9C480DF0;
	Wed, 10 Jul 2024 09:26:29 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 3/3] mtd: spinand: Insert Plane Select bit for the column address
Date: Wed, 10 Jul 2024 09:15:41 +0800
Message-Id: <20240710011541.342682-4-linchengming884@gmail.com>
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

In the function spinand_read_from_cache_op and
spinand_write_to_cache_op, add an if statement
to determine whether the device has fixups and
their corresponding functions. If so, give the
Plane Select bit to the column address.

In the function spinand_match_and_init, add
spinand_info in spinand_device for determining
whether Plane Select bit should be inserted.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfe..d6d6f3832f9d 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->info->fixups && spinand->info->fixups->read_from_cache)
+		column = spinand->info->fixups->read_from_cache(spinand, req, column);
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -460,6 +463,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->info->fixups && spinand->info->fixups->write_to_cache)
+		column = spinand->info->fixups->write_to_cache(spinand, req, column);
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -1095,6 +1101,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->info = info;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
-- 
2.25.1


