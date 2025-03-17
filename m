Return-Path: <linux-kernel+bounces-564891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE571A65C64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763E87AFF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6D41E5214;
	Mon, 17 Mar 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQjdkwZe"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191A1E1E1B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235669; cv=none; b=gTtTKdDw0PvzW1PrKuXUy5r30cYTozoM6aGd+L/t49gxMnwCdxGqe0fLs5CQxTP+0OblapFj6ykF8Wz29nUJAJILrsN5JYrdWmZd7bx2ec7Hgf9yX+OW8Br+IeCUFoKoN2Uk/rPsS0J8+7OgZmqcjMuxyN+eV+j54shBSrDjhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235669; c=relaxed/simple;
	bh=RQz+jE7EdCsn+aZe60lHze1ivwflmoAUB4YJGZZVPIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=nh+uCvWeIEHbdshzNvZ9mlbctPYUh3eFbc9tB/qHhqSvcYzLkVhVXp1wQ0Plw24GQvULn28kl3nALbzJXq7KqIMj+khWWXrgR6dfrZ30b87omybUwnY8q2CVNGJ+wr9kJY6C2s7yLAIV4GHCyyoWtwzPGJXUqlCDPdNUae+p7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQjdkwZe; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ac31990bdfdso416080566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742235666; x=1742840466; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aEJdtqNjODGZ3ZX8sSDy8Zo80L0HCxWOwxmMOMmUXvM=;
        b=lQjdkwZeMCUxZ6DjW5IJ1rdX2y7crnkZQ9A+Tvj8g6Uddu/9SkdtDhi/RCz5jn2abl
         luKx+B1uD/xUQsWt1DW120xWqsSioZyfgnkAHJq99XKuHI/UYJD1c+sQSjaLICYauR2S
         k5wVVImZ5+R2jP4B+qzAkRfW7P5IfHmU/Gj0tSCnt0ubKZNqTGE/kZOe/fyWBY6KCbgg
         EpgGH1BL8Tu6T0GmLm73XaD0GpeP//1u/Bdat0OkcFzcTkDXkYgVPmMUgj9DWrIgbNNe
         XeNF7vi0fVVphCsnpEcGSCqO4pKTtQkozNbKcBAJi9Vc3ainuP7lEZrHHiBM0jkHvYm9
         KPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235666; x=1742840466;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEJdtqNjODGZ3ZX8sSDy8Zo80L0HCxWOwxmMOMmUXvM=;
        b=i5KPLH7n9ec8TVzaEX7sS0bCT7mVXJWs2q0BLOWP4Kr4uuOEGW30VIidJrAE8omyUJ
         RvtoGvUHQctmjo260iz5hG7BrWDEUKQCAmiPKpzpfwkRPvVvVSD94gkbkM1CLunD5PyM
         7KLuvLntcXLLdHGDPqB3IVyz/rDJPR78lgEuVPwYOMeB3l8lTGtUK95dDMHgfBi4X5dB
         Fdq2WLNqdonFVOLzhQ4wbQ6Scr/uFeIYLpZqYK4C2BQsXlwv9lCBH+BQC71hlRkP1tog
         7t+dS9AkMGCLuK5r9cwn7gWJu7DwOkpXVRYMB0zeALzvomXay6pob81i8nZXQnEx3vOT
         J32g==
X-Forwarded-Encrypted: i=1; AJvYcCV3ib+rk9eRBUOUTzNqtTCxRQIzyyzo2Ih0EqvRMtcY/69HyUulWPGjeQfMT8JLvPhz/AsW3fKqtlqgHzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYgclMzGOTyzrnhRM5b/zG064y0oBR8RhONxz8nx34OPljzSM
	5LKx8Nytr/hDKzQJfr6O6X7kPNNHsBhy3Tx5VjjtqQnETATLkeeeCQhxdV4wJJjQpkX230ba43z
	PWY5cEg==
X-Google-Smtp-Source: AGHT+IG62DU4FaPgOOjSsVcgGi6Fs8/7pGDekBp9Bu2Wa+gKLvgqybFgjFcRqZMrNlNjOBn0Ix90T12g2Uni
X-Received: from edsq20.prod.google.com ([2002:aa7:da94:0:b0:5d8:476d:1082])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:e88c:b0:ac3:8794:21c9
 with SMTP id a640c23a62f3a-ac3879427camr170140766b.21.1742235666136; Mon, 17
 Mar 2025 11:21:06 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:21:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317182103.2060524-1-czapiga@google.com>
Subject: [PATCH] mtd: spi-nor: winbond: fix W25Q256 and W25Q512 chips configuration
From: Jakub Czapiga <czapiga@google.com>
Cc: Jakub Czapiga <czapiga@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fill and fix configuration of Winbond chips:
- W25Q512JVQ (+lock, +tb)
- W25Q256JW (+lock, +tb)
- W25Q256JVM (+lock, +tb, +4k, +dual, +quad)
- W25Q512JWM (+lock, +tb)

Top-Bottom selection bit is SR(6). All mentioned chips have 4-bit long
Block-Protection field.

Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/mtd/spi-nor/winbond.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 8d0a00d69e12..8ebb1461a4e9 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -145,6 +145,7 @@ static const struct flash_info winbond_nor_parts[] = {
 		.id = SNOR_ID(0xef, 0x40, 0x20),
 		.name = "w25q512jvq",
 		.size = SZ_64M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x50, 0x12),
@@ -190,6 +191,7 @@ static const struct flash_info winbond_nor_parts[] = {
 		.id = SNOR_ID(0xef, 0x60, 0x19),
 		.name = "w25q256jw",
 		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x60, 0x20),
@@ -221,6 +223,9 @@ static const struct flash_info winbond_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0xef, 0x70, 0x19),
 		.name = "w25q256jvm",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x71, 0x19),
 		.name = "w25m512jv",
@@ -249,7 +254,7 @@ static const struct flash_info winbond_nor_parts[] = {
 		.id = SNOR_ID(0xef, 0x80, 0x19),
 		.name = "w25q256jwm",
 		.size = SZ_32M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x80, 0x20),
-- 
2.49.0.rc1.451.g8f38331e32-goog


