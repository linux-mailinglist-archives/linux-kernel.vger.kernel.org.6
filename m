Return-Path: <linux-kernel+bounces-564887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECFEA65C56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B40882155
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D61C8627;
	Mon, 17 Mar 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BF1hVki"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78361AD403
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235623; cv=none; b=LqTmxuWO2WwF7fH7AjOFm75MON+N55TeLaji+QDY4hdEYsfyvYPsFtQfCmENq/0fEmC7XoEvMVRMWgC5XHvRjtQprhn2BtgvZJ1OlKgicFcc5S4zNWCGDpj+Hfidm9oOgb2QnjANvFaMy5yaVBRR+mUhNpHds7GgKAUA8qZ+f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235623; c=relaxed/simple;
	bh=tlnyXjcJkBX833gIcJu1QtnQCG8uMa8bA5wrM/847KQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=G/qitjAH4w5SF+qTiUYXfsqxuo6cdjmoIpW+qvfxbKQrQH8B4DT7wNWCM96EIFbaUMKZJjy7ZPAkUet8CSyOTjzkAL3TWulx124Bu4D0WM93AoGissmomC86xg6GJz32pEnW/MYSJBm0ZABS1J1OmiiQBzHtVrIOTFF3ou3sW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BF1hVki; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ac2840b1ee8so493156166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742235620; x=1742840420; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7NZ7peIlm0yG+Cn7UyH1yowKXkfRqsYGiOXYDLW9yw=;
        b=1BF1hVkiSZRrROVQYlJlq3zS1ulDKKQJsLSFYilTSgn6cAIC/OtwKpd5/CGKudGOLk
         3X+rsuxa60tm8XZe9goRouTGp8J2bEHE1lAWfCiNOHafuI5rSMzNbWYMvhndfZr9oGsQ
         rugx936xptHCZoDK91o2RAUav6J/qonInJSNlMElzUqylNNOWdrjHqGswxBqPsQzCs2N
         7Hgxlc2mKRPJQummmSBB6e4gQsDUgrdRoi6RhTJqaZR9SMXg0tIXy1MkF+SIj2g30wpZ
         ygm9yxeJeyFtZnnzu++Kzkh6H0unZcVT5qAFS0zvAvy7D+I0DQS0LlQdV9+QgYgntc/Q
         1S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235620; x=1742840420;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7NZ7peIlm0yG+Cn7UyH1yowKXkfRqsYGiOXYDLW9yw=;
        b=ejPXhKUdT1NmHpOOxHsx7D5i/ew25RBedeqLoyf2FBIWsNvVqQV3HlqxTj2RRHd9Dm
         jaSKJCR15BJd7XkfeAa6w1iqpF8qhfxGSHnu8U5aFTg4RtdjZmcDQI/nlEMwY6Ctgkm7
         3A352BHSQpm6VEW9pT26wTlQH0CqnhR+DU/QiKh25NfP+HL4VI3ndz5YxGwJ8zVqaL1P
         4jIUIUlNdMeAD1yTuq6oDRlwMs8BUFKe47xfRwVEs1AKayYlzzwDN8JZB81+bkR8IKHm
         Cy8crZ5BKyai1pkYGob6n4NNN2NaESUfxb3xNHcm4xejH9AFjkDY2K9wj6hgixF1wNzm
         CXtw==
X-Forwarded-Encrypted: i=1; AJvYcCUN4dX0R8AEiTSrOaUvmBolwIr7dqc9IpTJEMoaT0T5oGnXlMWvMBzWBTjrJRUyp9ttGyvyNByKm4jn394=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvJ+T45Jp/SDEwwDznjLO0bj9PkZrSBZxnmXEOJ87mbfDaiF2
	L8+1BdGqabaJOdpkAJvn84CPafIxHGPS4dPJKRYcuePVLTk7EsDuHQ5Uhxw1x+DFjrwCsiuNtHM
	najwERQ==
X-Google-Smtp-Source: AGHT+IE84F2eM4gDbNKOPL/wvEHNq3+GiqxIQtJuObp+x01KaqbBtyapAgs6XaomjtlNda8x+qKPNMx0IHSC
X-Received: from ejpl10.prod.google.com ([2002:a17:906:7d4a:b0:ac1:fe6f:8a88])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:368a:b0:ac1:f162:fb0d
 with SMTP id a640c23a62f3a-ac38d514eebmr71247366b.37.1742235620357; Mon, 17
 Mar 2025 11:20:20 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:18:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317181856.2059536-1-czapiga@google.com>
Subject: [PATCH] mtd: spi-nor: eon: fix lock and non-SFDP flags
From: Jakub Czapiga <czapiga@google.com>
Cc: Jakub Czapiga <czapiga@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set appropriate FLASH lock feature flags for chips that support it.
Set top-bottom protection bit flag for chips that support it.
Add no-SFDP flags for chips with missing SFDP or without clear
SFDP description regarding 4K sectors, dual and quad read support.
Remove no-SFDP flags for chips which documentation states that this
information can be extracted from SFDP.

Modified chips:
- EN25Q32 (+lock)
- EN25Q64 (+lock)
- EN25Q32B (+lock, +tb, +4k, +dual, +quad)
- EN25Q64 (+lock, +tb, +dual, +quad)
- EN25F32 (+lock, +tb)
- EN25S64 (+lock, +tb, +4k, +dual, +quad)
- EN25QH16 (+lock, +tb, -4k, -dual)
- EN25QH32 (+lock, +tb)
- EN25QH64 (+lock, +tb, -4k, -dual)
- EN25QH128 (+lock, +tb)
- EN25QH256 (+lock, +tb)

Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/mtd/spi-nor/eon.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
index c1ddf662f782..10ed06022a76 100644
--- a/drivers/mtd/spi-nor/eon.c
+++ b/drivers/mtd/spi-nor/eon.c
@@ -13,10 +13,12 @@ static const struct flash_info eon_nor_parts[] = {
 		.id = SNOR_ID(0x1c, 0x20, 0x16),
 		.name = "en25p32",
 		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK,
 	}, {
 		.id = SNOR_ID(0x1c, 0x20, 0x17),
 		.name = "en25p64",
 		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK,
 	}, {
 		.id = SNOR_ID(0x1c, 0x30, 0x14),
 		.name = "en25q80a",
@@ -26,42 +28,51 @@ static const struct flash_info eon_nor_parts[] = {
 		.id = SNOR_ID(0x1c, 0x30, 0x16),
 		.name = "en25q32b",
 		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.id = SNOR_ID(0x1c, 0x30, 0x17),
 		.name = "en25q64",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.id = SNOR_ID(0x1c, 0x31, 0x16),
 		.name = "en25f32",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.name = "en25s64",
 		.id = SNOR_ID(0x1c, 0x38, 0x17),
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x15),
 		.name = "en25qh16",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x16),
 		.name = "en25qh32",
 		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x17),
 		.name = "en25qh64",
 		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x18),
 		.name = "en25qh128",
 		.size = SZ_16M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x19),
 		.name = "en25qh256",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 	},
 };
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


