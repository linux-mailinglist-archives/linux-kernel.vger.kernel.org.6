Return-Path: <linux-kernel+bounces-564888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BAA65C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D05988255D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D41C8627;
	Mon, 17 Mar 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2ysSVvW"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4A1AD403
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235659; cv=none; b=taB8kctCN59kpOr0q1RvbZKILy88/rdN1/UVXvpgOjq7QyyHO70gq4dMuaT6uL8rhoALn0Ri8+odmUcrN1hgrhDcCPXyXz6B/4xrGX4Xy1Si/wethuhq0A7DDJcRltxnvCjClYZAeo7DljaJDNXxM80Gu/QHQfYi6HgwOCCz1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235659; c=relaxed/simple;
	bh=6vBrLA9rerjT1JiQXteOtoki36y3WaAlLpdjheNBOOA=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=ki1owXySnB5pRR3BodCPuzO+GYKyX89C0IQ3ve6N4nG0pBMnwEoObqx29hWR0sMBMcG5DaaOoysVy147vtYl1RGxZfp2Sk4n1NfNzliY3vFfUkmmdeNd0/QkH0s6FdgDgBqVkk0sTxOgGraXvjY+C+vu8wtx8XMn94UhwuiVpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2ysSVvW; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e5dbd04225so4392263a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742235656; x=1742840456; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=78VRu6+9psP2tn8WejDwRNX+ffhQVxd9hB24F6U+zQI=;
        b=D2ysSVvWRIFz0nRTRBZKmun0jZzsMxSmNsgQsGGzy1PSrhPZ+V5AjVGHNbotA0virH
         ICwisoGtBul251wu40t6edaxon4PrKqkVEUUqc2eX+6UDgf0LNnY9vQhp835MJ0DAhg/
         qWEh7jc4MJxXSO7rtsOMGv5roSZQcp405DDkyN5SFCowX6wN8ChbASK1cYSzJSUjIHXR
         UVSMRzL8NYeyjr1Ure6Eq83b8jzFU0a3R187UwamSOparxLXC1j3wIBT975i0ptWA/yi
         iG+2OZIbfSDqlJ/1M1cV5QcMDjHxaxMt/vqlTinljQHDSTYUXo71oxSo3z2rcBZ0HpJT
         gL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235656; x=1742840456;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78VRu6+9psP2tn8WejDwRNX+ffhQVxd9hB24F6U+zQI=;
        b=v9ei82bQWLv2TimQhPyUVt7+XvLnWQbsXZrnMfjc2EY1KvQx+wJim/Vi4+yxCZCpjf
         81f6xeOY56tSikxXAHgejQssuupk97Vokua2rRRaMi2Ir76azg3qK5t6eFduA4SiaovL
         HGIAdJfJNSnjpJXKzKcqKiMNKavjluwNbdcbC9e4FfMi+ev5iZeL+vm4CByzgoUH/cew
         uDAwrrHJ9VD7y1AnVALi5GD7SIGXoyzoSgGtWG0qxz1+oqQIiL2CnBz68WiR8X2hoUBJ
         vjVL05j7pGJJWDtP505y74m/xjjFilFNVp7I+qb9apTYDGteGdii2NsfBJEBfrFCa68k
         Bozg==
X-Forwarded-Encrypted: i=1; AJvYcCXJrE53zb66QVaGubvYkymTSoPBM1suwWiWyAseQawxlJo081SMaBXgGbC0mMMS1rslQbDRp6pFCnz4ypI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXFGIQ6Xfkm/eVhNtTWdb8r+wVKbJCxj2s4TacQwPOl1VrSnp
	ExC5urzYpFAkd/rd1wc8S44R12BVCDvkZHloN3boS//hBED9dieImszJwUt1Szbvw4j52nIDiYG
	IfFWBJQ==
X-Google-Smtp-Source: AGHT+IESE69/iddcPk7ehPy7NsOJmNhG1D3/pIzqBBHE1LoGJdUPkmqYoQ6QIm5bo43o00RoxkTuy8sKiOiK
X-Received: from edbel4.prod.google.com ([2002:a05:6402:3604:b0:5ea:815a:c43c])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35d4:b0:5e6:1838:e8c6
 with SMTP id 4fb4d7f45d1cf-5e8a032c2b4mr13262186a12.22.1742235656080; Mon, 17
 Mar 2025 11:20:56 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:20:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317182047.2060036-1-czapiga@google.com>
Subject: [PATCH] mtd: spi-nor: gigadevice: add lock flags for GD25Q128/256 and GD25LQ128D
From: Jakub Czapiga <czapiga@google.com>
Cc: Jakub Czapiga <czapiga@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set appropriate FLASH lock feature flags.
Set top-bottom protection configuration bit flags.

Modified chips:
- GD25Q128 (+lock, +tb)
- GD25Q256 (+lock)
- GD25Q256D, GD25Q256E (+tb)
- GD25LQ128D (+lock, +tb)

Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index ef1edd0add70..8eec6557b036 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -16,6 +16,7 @@ gd25q256_post_bfpt(struct spi_nor *nor,
 	/*
 	 * GD25Q256C supports the first version of JESD216 which does not define
 	 * the Quad Enable methods. Overwrite the default Quad Enable method.
+	 * Otherwise set TB to SR(6).
 	 *
 	 * GD25Q256 GENERATION | SFDP MAJOR VERSION | SFDP MINOR VERSION
 	 *      GD25Q256C      | SFDP_JESD216_MAJOR | SFDP_JESD216_MINOR
@@ -25,6 +26,8 @@ gd25q256_post_bfpt(struct spi_nor *nor,
 	if (bfpt_header->major == SFDP_JESD216_MAJOR &&
 	    bfpt_header->minor == SFDP_JESD216_MINOR)
 		nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
+	else
+		nor->flags |= SNOR_F_HAS_SR_TB | SNOR_F_HAS_SR_TB_BIT6;
 
 	return 0;
 }
@@ -56,12 +59,12 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.id = SNOR_ID(0xc8, 0x40, 0x18),
 		.name = "gd25q128",
 		.size = SZ_16M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xc8, 0x40, 0x19),
 		.name = "gd25q256",
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_4BIT_BP,
 		.fixups = &gd25q256_fixups,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
@@ -80,7 +83,7 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.id = SNOR_ID(0xc8, 0x60, 0x18),
 		.name = "gd25lq128d",
 		.size = SZ_16M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	},
 };
-- 
2.49.0.rc1.451.g8f38331e32-goog


