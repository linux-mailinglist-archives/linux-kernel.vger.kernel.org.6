Return-Path: <linux-kernel+bounces-399588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4439C0126
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF645B21F77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9C1DF266;
	Thu,  7 Nov 2024 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT/oxgNO"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8318785B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971884; cv=none; b=ATOcDb9tpSA1OTwX3cOpib/45mJPCPTz+oKA1XZb0HlJCbxRAv/B6bzGCGKWn6ZZ51HvtZStqE6BPTWI2Ur1/FIU4j4nmCQ4vMM/WEWh45JyvRx+6aPPE7qxwtSmT8onJ0sch0gRDSm9cRK7ZoBdbBeU9/YUQb8YqmOctotFM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971884; c=relaxed/simple;
	bh=zhh5UkiTs5SGsZEgIEockHkIU+5XUlkgxmSOpqQuviI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VndhdhPuuQyJ7Pg1MzsQA5XYwxuLYA7BiW/KRKOvDCK52Z22DCzR1fo8JceyiccU1NoPV4DLO7aajFQLFeoaAR/AThp4JVaqfaX7GIOudTqWf94h4JPRs1jgXiieN2EFwh8x2KTXGlVqV3EpiruxHYKZI/x6k6lwebBKyHhBqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT/oxgNO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e59746062fso594938a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730971882; x=1731576682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JeMAIR9iEI5n6d08kWR1HWHfaPm/uZGrAZ7QGzkzYV8=;
        b=VT/oxgNOfYxt9rtGat/s2ZxzRlOj9RVxas+lCpnP03I9k2AgyU/NkVIVQQQLIn9jPp
         J3XgM+q9uwR+CNJfGCkzva0r1FPRQF19O8QCyFiXLQgSbU97EfOw56alKuC7SE1kYF+G
         maL5nRAvXccUufZk8btpqNn7fDYUlfb1ntKoQlFuxU3HgdA23MjagIPr6kLjsULP5OzM
         xenKVMRVx4LSixaULs7B3xh0Kj13qGOp+S4YqOVR1dsH3GaefGFJA69SSzcTaTei71dw
         arHE7pB2KkPkdmzf6R6xoHmateLVAcYWNoeG8K39I6JupCtmF9/9VoJWJox7roVz5h+k
         LvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971882; x=1731576682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeMAIR9iEI5n6d08kWR1HWHfaPm/uZGrAZ7QGzkzYV8=;
        b=qFtwPQEz+NvNBMdMoIid5tOn9Gecg30ui9ZBeJVJs7jjfb6XAaOB4NQu9CAIMcMjIn
         57qhZRgqaaMukQx7qDfQPiOHVjJkSAeP9VJNj8Qt2etwcPuLb6aMipig+8xe0ZwZN9bH
         nuLwccOfJCz4n6T+4tasujIUpcOXmVjkicInf8wO2IvqtL/ljeBgg8gqBaaPVFmnPE7w
         9A1qbuh8Dgb/vhMJfIflnWaXa4OgowxYj+W5pyEMn9sxQd//YzDuhOex11MR0DsGFo5B
         0/95V1gzjsqgqEuV0QMXn9sGQykY3H0RL+zwAODpv+zTIDa+DRwJGY6yThSoCRE+a87Y
         vIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnSz9+aWsb59AqJ6Cn/eBXV4ho+w4LKuJ+qBWbt8Tz7szBFkOYsOqxb6qb0tYEDTpjjM82s2O9NyYjFZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dAjcu1NCUnTmn4jeIo39GpmRZydM/D/R2cBL0FtcHKoRlaUC
	dRtyVopoj9DNS8E3gCv9dizTFQPqkTC2c1FUhphQyaabL6dnGF4+
X-Google-Smtp-Source: AGHT+IFrRRrnlLAowFtunzpTvMHx7ihaYENBpR9i88LgwFXGyQ6Dgby+fj35g8yAa++m97kR3E8MSA==
X-Received: by 2002:a17:90b:5444:b0:2e2:8995:dd1b with SMTP id 98e67ed59e1d1-2e9aaff9a68mr467311a91.3.1730971882207;
        Thu, 07 Nov 2024 01:31:22 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a4fae10sm3015116a91.11.2024.11.07.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:31:21 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 181048015D;
	Thu,  7 Nov 2024 17:37:59 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH] mtd: spi-nor: core: replace dummy buswidth from addr to data
Date: Thu,  7 Nov 2024 17:30:16 +0800
Message-Id: <20241107093016.151448-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

The default dummy cycle for Macronix SPI NOR flash in Octal Output
Read Mode(1-1-8) is 20.

Currently, the dummy buswidth is set according to the address bus width.
In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
host to read data 4 cycles too early.

Since the protocol data buswidth is always greater than or equal to the
address buswidth. Setting the dummy buswidth to match the data buswidth
increases the likelihood that the dummy cycle-to-byte conversion will be
divisible, preventing the host from reading data prematurely.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f9c189ed7353..c7aceaa8a43f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
-- 
2.25.1


