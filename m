Return-Path: <linux-kernel+bounces-379809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD629AE412
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D261F1C21A42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932421CFED9;
	Thu, 24 Oct 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfiJh5r0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE751AA7A2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770061; cv=none; b=YYx1GyoeB+YeIpLtwsjiTcoPxbIFtPVyveOkVuwEkwyIOI3Q9BhdXpL0LMw/EFgfI6H+I2ElUrKDPRsN+naYk1aIVz0JLjjR1CojrQEZOr2TjjBFmbpLtstLVfi6b18BL694KN2IJlCrhBKZ2PuVSB+jef+TR8tBPgxh98cBXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770061; c=relaxed/simple;
	bh=es1jb7tQYlEcRpPqZ63IbTY8LaYiPvArFElIHOAq/R8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hlke3ToWoZ21gHqyn/XPoRYxrhN3qJHjverNevXXorOwLLcN3ujsf6KQrBUuWt85kOuyObPHIMC8HVf0Gz4Wkh2cIykExO4gQNV+XEsjzEqNPQnjVFlYWZyhDQozylzoKSH0N2N2boVioitcJKaNgu3G+C4Qw8bHAGinD0j3v3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfiJh5r0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315baec681so8396915e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729770057; x=1730374857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idzdbKFgsUG7OY55yXSHUR0pooUCkPncNXEk/U6JGi8=;
        b=CfiJh5r0abht+Rf5dhH7IT9wRdyoFnazDv7ZVbhG8rt03OEfKyBMezdBrA4gSSv+EI
         IsGXM/wucb3O3csw89L0sDwnR06YuwlBPkJgEdWKUenxNbzRDpdDpU1S8wYJfktb/1Vi
         QC9hBbEqRIBNJkmuYCtMR8tu4uxVA+BPWBa4fxFG5vcCeSFVyriTWEJsOO1QxQfPvahd
         nHiIVdPOWJ7nXCgdRejDe3oLceVu53YmJR8hViH2U7iHKVkm8kjOLxb85rub37N3CIUJ
         eVjL6bmvr2OgV6x5fh5Yp+A7EjUHFVlsXlNZqnelofD+7YtytQbwQnHBA11NnSahQW0z
         nGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729770057; x=1730374857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idzdbKFgsUG7OY55yXSHUR0pooUCkPncNXEk/U6JGi8=;
        b=KwoR7/6DyBaNG4XdpgaD+my9cjKeFVrsuwk1JChXQlzNY5tyfE7WAc/UvG9srkvcXE
         juVMnZvnIRvwlKe2equ5pdDmgQKkxU9lU+Vir0R6BDDJfZNiSVGNQcx0+TEC8NYo40LK
         WzXnqdgREfzVtbVRjKhFrf6Pw1ynmIiho9AlkG0tzzS568Wm1zVoByLGZhRCzSOPEVlg
         wp0aAiHsysWbozWumL2Dgq11g7o/ccFBMPxnU5gzFnQRvEkw5bJRTGcCbmYI25EuyNBe
         JlxhDGeEoO7sKqWAVv7Q4nnrwgQpdf/mVRmu7CGmCEbrYni/C0SQAZJUF+o6JNnaeXz8
         ML/w==
X-Forwarded-Encrypted: i=1; AJvYcCWBtvWVTjCUxTOfndJS0JYD1W4Y02bGXJbwdA4+gTVX2FHH2aEdANfQLhX6oKyDfRrGdD6mr53j9wC89X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWGfGOEQ50pL7CaNQx1iWbfvDZ6sn2/iIyBTD5rXKuujKa3d+
	0MafZYIc//2Sq4KiobHcbKJCcik3jpQK0V4h0bsbROafef/9yEHf
X-Google-Smtp-Source: AGHT+IFCf69WqMZ4s8O5S2d78OdM8YtP+bJ7yi9UW7qwMQdIAywbaUYKtN2mQ9IT6hphj1T44Cy3xQ==
X-Received: by 2002:a7b:cc88:0:b0:431:1a98:cb40 with SMTP id 5b1f17b1804b1-4318d7f2fe8mr10377555e9.18.1729770057089;
        Thu, 24 Oct 2024 04:40:57 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bde267sm42396385e9.13.2024.10.24.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:40:55 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: macronix: enable dual and quad read for MX25U25635F
Date: Thu, 24 Oct 2024 13:40:21 +0200
Message-Id: <20241024114021.17567-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

The MX25U25635F supports dual and quad read operations. Set the
corresponding flags to enable these features in accordance with
the hardware capabilities. This change also enables dual and quad
read operations on the MX25U25645G, which shares the same ID and
has a superset of the functionality provided by the MX25U25635F.

Link: https://www.macronix.com/Lists/Datasheet/Attachments/8663/MX25U25635F,%201.8V,%20256Mb,%20v1.5.pdf
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
 drivers/mtd/spi-nor/macronix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..be55558c8ad0 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -129,7 +129,7 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x25, 0x39),
 		.name = "mx25u25635f",
 		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
-- 
2.34.1


