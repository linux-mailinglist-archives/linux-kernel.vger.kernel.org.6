Return-Path: <linux-kernel+bounces-263661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F493D8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7742E1C22139
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F447796;
	Fri, 26 Jul 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekruv49D"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08C2AF00
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020312; cv=none; b=fv+K9jWiJmcOdt3EADD0mp+lUjNDNQJzI/iTVcOYG+IhjtARXX4rPabf0o91SyktRlyK/j1kxWPwSYFyu37lY0P8TjtUiuQ1C6mU70tFczPGvtaMnIb2d5dprDG2YaODwy3m9PZnXFllooc60ZfmFho9EmGtixnj74B2/AcomWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020312; c=relaxed/simple;
	bh=kz2Unh4yY0gYDKwCxg+Jv0iD4wGw/CpddqrQ3La+fic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SK70Z+UWiY83HimNGWeFSA+9DCS3Ps++hyetdrtefiVRzSt4vDABvpXWxE+Z/QXUJvd1k+l+yTrs5hbSqjSADV+wSVNBlHDqlRD4DQe1D4aaSJeF4/dZYI9jUg6Q1zshCXO7r8EC+pI3nbSV5u2QAH1/LF3xzpWwVYkRhLLACiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ekruv49D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd9e70b592so8178475ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722020310; x=1722625110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6yw1xHD9zAEjVMpNg+C0xVl0GDWtgqUwsdpTjnl5Jo=;
        b=Ekruv49DEyFfIDk8C0T0pXvaqe4AAnLscDhJWRiD/3f0wkidjZJEQH6vqNUrKpwBDW
         LGci9fJmEvIksCTwQzecKhxDKivDa7VkaTIOP7NKHW+Q3eKhYftVUMzF8wb7poFFeRCn
         Gz18Z+/jUil5F7Ddji3SkuOhDaJol9ZyuVY8s0I4P+DP40cku+7k9VxqwBKQQYEBSFEW
         pmlCrgemSat64PMW9XKKhHNgZz7gClragSiJqTEiiejIFfKf8s3nRfcn9n5idb3E2jvq
         1tXBCV+GqoVmQxI8faSyU8tb9icRrY/NE0xbGULuipmhvOZjywltzJt8K9ysLOsb/BEm
         wqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722020310; x=1722625110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6yw1xHD9zAEjVMpNg+C0xVl0GDWtgqUwsdpTjnl5Jo=;
        b=S+RsGZfQl7KFGzs+7w26DrSgsHOqsPJp96PRh9Gk79c66+flgHfQKGXbQzrgNeg02V
         RPMRkij/7mcNcSW9ePN6q6xDzEEySL0cOyVfYJwl/sERC3TV5392Tv/v6J1NK8OXqz8Z
         q4KQU+o7yOmbjvylywu6sMgeNlMJrTjGq7oH/UyiStMP5EQh0FBWXlBmcwUgqeiikkip
         Nhed0xk6R/DDqIEVg+0/ZlcuMtt8uWpoVFIE9H/nCAG0+lgTwRWxyyE94Y/6Y9OYQUWQ
         6i7Mp82nfLRe2TQOmYOdrIYzSN5HcvUUSBRTo00O94CKnKu3TQqK4s6rzDNAd4RD9UUw
         1sBw==
X-Forwarded-Encrypted: i=1; AJvYcCUCtuEgCoznYTTL2H6HUT3nqM7hUWnG8luwwkYVa/tqRsKDetWA7FRpgZnsRfIx4NjiN5gPljyGxUF+NMP+/zDPHIko2SyP4S85LeWr
X-Gm-Message-State: AOJu0Yz0eentZdaElQpafMMtAG9qLvhJy3n8DZadDR0TYsDm7eRMu9ic
	4AFaPn13WnGLs4XZfEUw+WmVEwYsMMuxAsgrI5S3A4ECcJIlIhOd
X-Google-Smtp-Source: AGHT+IEYn3QbUlB6VurnfiUMl6eYXmGcorf3BPimFXSqrqw+9CtH5v7QARH5+IR7lXBiGnEzdi09Ug==
X-Received: by 2002:a17:902:fa8b:b0:1fd:a7a7:20b7 with SMTP id d9443c01a7336-1ff047d8f85mr5766985ad.30.1722020309790;
        Fri, 26 Jul 2024 11:58:29 -0700 (PDT)
Received: from localhost ([2600:1700:38c1:1d7f:f66d:4ff:fe3c:3ceb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1168sm36416705ad.167.2024.07.26.11.58.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:58:29 -0700 (PDT)
From: Brian Norris <computersforpeace@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
Date: Fri, 26 Jul 2024 11:58:18 -0700
Message-ID: <20240726185825.142733-1-computersforpeace@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These flash chips are used on Google / TP-Link / ASUS OnHub devices, and
OnHub devices are write-protected by default (same as any other
ChromeOS/Chromebook system). I've referred to datasheets, and tested on
OnHub devices.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---

 drivers/mtd/spi-nor/micron-st.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 3c6499fdb712..e6bab2d00c92 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -436,6 +436,8 @@ static const struct flash_info st_nor_parts[] = {
 		.id = SNOR_ID(0x20, 0xbb, 0x17),
 		.name = "n25q064a",
 		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x18),
-- 
2.43.0


