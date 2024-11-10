Return-Path: <linux-kernel+bounces-403362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6029C3499
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BC71F21414
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DAB149011;
	Sun, 10 Nov 2024 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPCacCJO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584313C670
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731271858; cv=none; b=b4o4xsjMwVJ789kx5hBb9rpGLiyf7QVIUJFBwApPzHqUrMyXBq92LK05LdJmSX4wP6WUMI/GOhg8P7agJe7XE/nXHT8tuNIeJWI+ed7t0aoC0FJ6LN9XW6A242BcmzJK5gVfpw5jsB9mdjmlRUUzg5flXHfAq635/JAOlUcZHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731271858; c=relaxed/simple;
	bh=QZqNhfiqHKv6NJ6lA3foYKspl5Ef0xIdowNIMwgKhyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8pgMqWM3+sAyK/VKwSVz/ovjqMcuUz0Jefvtn7rUXv/wVIY/RAXois1yvxBHcPsJ2xx0N0Qddnr05oomq8TRXuyeucQ5Q890GesSBzyXXmtvv8BeJAUPsJNBbaMImVsGDvrboK94YIJBgjtg7iCWcxZKkrJFLrymIKTTbH1e+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPCacCJO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9aa8895facso734711666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 12:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731271854; x=1731876654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQvwoWucpk9OxilYFxI4xQ/zPw71rC1deeGQHgd2Vls=;
        b=dPCacCJOZpT7+vFTPFYI2OKu+GhilLmMpLCtdGNR/wvKdAQ4tYXYt3SQGZXHz6zUZj
         frBolw0RFLyAbSkJCVr4Cs+YvkyTAnDRvvekIZ7plAhOSM0Kmi9rcJ6pRfRVOQ9MhRW6
         6+3SnvM/iW9nzTIG6kPEpM6Y6swaK5lOKfoZMAeKAtxaBdlSarl0FjMCkvexsP5JvFJj
         pmMb2+rB57p4CwssWbT32vLYc8QR/wQqJc2ELErqQaUAu2uiKzyBTHy3BppkFTD6N5+t
         HfJys2BxaT2LYAwNb/0ip+ppozjofq2/7jq2vmRHvDFwTgTQyURlK3Uaos5UlgwZpg7r
         gJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731271854; x=1731876654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQvwoWucpk9OxilYFxI4xQ/zPw71rC1deeGQHgd2Vls=;
        b=SAfWEnZ/g4Yfk1fmfRSr5CPvEQFCVTz7PiPxvRHeHu1RBLtViSfzfvh7JqZqbAoCSH
         DuVixltetWu5UpPpHHLT7jlm/uWWUIOvHdaBHu27iLw85FLTr3EV9YNPc4w88gcDqJRL
         M25Tjer38G6PEb+CN1nvS3AnOspK3rygsft6k6RAjMtMMS+aQ/94oqNqJMg8qV8Pa0WD
         w+nYtYxSecD2oXtPvqg4FSCkOMpyUntmJHnxA8IvH0S9CR3B9Q0GwB/pI6x7EAi3vIcv
         9lC3mPs6NEVy8KppKtW4A3B70uR/4jAudB+peS2KHGD4qmjUBlD6eZvGbDI6NZD8lHav
         jWew==
X-Forwarded-Encrypted: i=1; AJvYcCUiEEMgJgheTVmyxUh2IdFujsZY4O81OjLFO8t8o3FXeuHOhUItimgVSjgWqDGf5pWoYj03YhVfa6vkeag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgeNW+CE+VBCQ8jY5CuN+7FDyvBjwafDc1M9a/DATl4CMIhTo
	/La4aDRLacXFik3BnglaxazVuIy6jSO2VFtgdfUgzEeKdFaIp0zd
X-Google-Smtp-Source: AGHT+IHuzXjkaETWOavLmRFnSQA+YWENaxM84Z+PqbgnAtjZoXxVGujY+q/lcF58GcWjaQvwlweO2g==
X-Received: by 2002:a17:907:e93:b0:a99:d308:926 with SMTP id a640c23a62f3a-a9ef0009df1mr1002240666b.57.1731271853615;
        Sun, 10 Nov 2024 12:50:53 -0800 (PST)
Received: from Bogdan-PC.lan ([2a01:d0:9759::4cbb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e8a3sm511227066b.190.2024.11.10.12.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 12:50:53 -0800 (PST)
From: Bohdan Chubuk <chbgdn@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Bohdan Chubuk <chbgdn@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spinand: add support for FORESEE F35SQA001G
Date: Sun, 10 Nov 2024 22:50:47 +0200
Message-ID: <20241110205048.1751377-1-chbgdn@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for FORESEE F35SQA001G SPI NAND.

Similar to F35SQA002G, but differs in capacity.
Datasheet:
  -  https://cdn.ozdisan.com/ETicaret_Dosya/704795_871495.pdf

Tested on Xiaomi AX3000T flashed with OpenWRT.

Signed-off-by: Bohdan Chubuk <chbgdn@gmail.com>
---
 drivers/mtd/nand/spi/foresee.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index e0d2d9257..8a01582c0 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -81,6 +81,16 @@ static const struct spinand_info foresee_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
 				     f35sqa002g_ecc_get_status)),
+	SPINAND_INFO("F35SQA001G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x71, 0x71),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
+				     f35sqa002g_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
-- 
2.47.0


