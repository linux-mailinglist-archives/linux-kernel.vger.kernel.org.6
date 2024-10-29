Return-Path: <linux-kernel+bounces-386814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729F9B4831
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1CCB2175A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34009205124;
	Tue, 29 Oct 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhP6I8fq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E6F1DED5A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201046; cv=none; b=b+pkPmfnbam67Y+SfbaJ7+b+v0bYVN4Lgib3Nhtq7zw7fl68eb8STCTFwdOFhuTktRfvfac5jowmmTCYa2/tjmBJmHM861jT7bW36bmHztuRiFtEwqXkByjEoJITqLooHKTTohtl2zEMnZvzWj5KI0DZD5yRkb1/0oP3qA2F4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201046; c=relaxed/simple;
	bh=Bh/pCGhgwpeso/ZlnFF+4oo3hRtxyJ4ukGqD9q6lDhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZuSZVPw2BQ6pUEdFrYdvwpX2c8MSM6ZLMlxtav1QCzH1kMAM8G2X+cN2i4hCN5I3Wc7Oma37qs3UBUPFw8dh2GdcpqYVGzl12vHdYpkflBbXA3gr9984lYpA/OdJx3uwxHVa6jv/yp4dk6qPB9JJntyxlLZii6po1rOPAlHPLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhP6I8fq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso52736601fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730201042; x=1730805842; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RlZ1TnHpvCKbzlvSM/hs6o2BD2pnpvAtKzCAXeYDfw=;
        b=UhP6I8fqhBOmZi+qmc34ENjezmCkq8icuckcUteNhbYb7I4sJbKsC2SNTDK/rrrztb
         X2Mv1EQKSBnVBsEOe+yAvx3jdx1D1AxLSWl4a/q/nqGSPfupADg3tZrUqqTfNhbkzSyq
         JZphHzumNqhUdZmpefIVPamxYFYhy7TLj0IN4US8fTjs9jFYQpe+q3/H7s52Cog3tu5A
         rZZORkqGpa7fsYp/OERzWS2miWDEuW10ZvjftGxsrAQfMBgl8QfKiU0fHGd1BeWIATR3
         T1xMtCBMVm7JYH2M8dqJD+B57RYc/CwW31O73FV9zjk3ynLP0a81/4l6O0VZw21/7/QR
         pJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201042; x=1730805842;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RlZ1TnHpvCKbzlvSM/hs6o2BD2pnpvAtKzCAXeYDfw=;
        b=XuNKuUmGL15cbri6gVvfsSe4QSAm3GhjhSv4lBfVTb7tWG125azZZ4iXWu/xdM2y2G
         +5cxfETsXKxURtbg9aNrk8MUaG9Pp4Tw47wg+Wp6ABIqJz5UbUX7pZOl2kM7iTSxGxjx
         EJE5aTxBdLstxnWWgUPIEvfpS/hxqTovTdq0xz9xJuwmPplvXPe5dg2D80P3sO7GDUct
         t6c19IZQlM0nbYIv+g0mfMy/usFHR5jeVdjsIIhEAOVyrn1rrMMErsLfnBh0gyseWMdf
         pZF84H6EdIOrW8ailcK/EzcJ0xCXivzG4bfii3c+mRA8b3ZGcfTP4Ejm0V8X7mT1FQU7
         0q2A==
X-Forwarded-Encrypted: i=1; AJvYcCXQXQfi9coBCC4KXCPAFPT5bd3tpg/OtjnbawnXl779o3B4pLey7IwCAqMxA/IOm97eWBWNlW4hmvRTWFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQI+l5WppiHui9oTzzCtE9ZI0I4YaIbFjeFyNNfx4jL7NJ2sDC
	aC0txzGM3FSi1WU3w6LVuvg0+vWxgL21/wLgKjqoNKQwbPml1Br2
X-Google-Smtp-Source: AGHT+IEHQFQWslu58ODNcgJ0kA7mcOUn92YiGRqwT9IXE64HXJya3wT0vI60FTSmoh816Nm6CnQPvA==
X-Received: by 2002:a2e:be09:0:b0:2fb:50e9:34cc with SMTP id 38308e7fff4ca-2fcdc7f6a51mr5886061fa.17.1730201042130;
        Tue, 29 Oct 2024 04:24:02 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d20dfsm14691601fa.80.2024.10.29.04.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:24:00 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 29 Oct 2024 12:23:30 +0100
Subject: [PATCH v2] mtd: spi-nor: atmel: add at25sf321 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-spi-nor-v2-1-e166c3900e19@gmail.com>
X-B4-Tracking: v=1; b=H4sIALHFIGcC/2XMQQ7CIBCF4as0sxbDELWtq97DdEFhaCex0IAhm
 oa7i926/F9evh0SRaYE92aHSJkTB19DnRowi/YzCba1QUl1QYmdSBsLH6KwRvW3vrOkpYP63iI
 5fh/SY6y9cHqF+DngjL/138goUNhWXSc3tRLJDPOq+Xk2YYWxlPIFZ9O5Hp4AAAA=
X-Change-ID: 20241018-spi-nor-dc29698dea0f
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=Bh/pCGhgwpeso/ZlnFF+4oo3hRtxyJ4ukGqD9q6lDhw=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnIMXLk1V2su/q8mCIPTOsrJENpDhv/6uVHZuvj
 k1jAj4sLd2JAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZyDFywAKCRCIgE5vWV1S
 MtE6D/0dhDciMdCaBBKUIEVGnm65MDeeHCj5uxDQhy5EdwWO/LIrD/paTeTRKOizfdjddOCX/Yx
 nB1kBZHlvWeoTNkarX3fENeCca2t7fI4BFSG7Jq5MnhQAion0YxLsczQa73jv+WFlD3q3QN0fHo
 asVkPagkJsiIM1YHpbfPuU2mxe3jFujXT2Wg5+5zsqa5eIuH+ybMgGE+rU6nsw2KI+8eFtuOUbM
 GCss0zZqQmrQ+ASg/BwEaa9lKKprmbqzOOL3ykEopy87gXtrQgwoVXulm8qbNm7Ugf6efqRTRAm
 +0hri72DrCgi7Im5IAxGVzfG75FEDQKC7bj2xwEPbm7mG3373qWxpvqx3QNPR+wAi23hR1j+sn0
 CqonFM0Hdr7uH7pNNAf6r3AMCE0XQM+35Z5e2gO8NitmxpFt+Ep5ciHHVJ23W2gKZrbe/+1sT6G
 ZSPnr7dAu5yskxZhzV3yab+fMBrpOVNyd1FpvELpBr74tVQO1EVpNkYALlDTwLQz1Z3GGiw+8WW
 uGQr0ExilGiMuaFf2GWp18S1xOOPZjU+9GlYnfzWlQoAOVR3RY9KYN5tggIogxWv7T3fqvDI3m0
 UB6Fs9CpQCW0ACwziipYqlpbJsueJsCyRKIU7vPvCSu8f8OpzApGkwACBvJaAlcX9zBnSc+nL4A
 6q1AR+CdoauNAtg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add entry for the at25sf321 32Mbit SPI flash.

This flash is populated on a custom board and was tested at
10MHz frequency using the "ti,da830-spi" SPI controller.

Link:
https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=1608801

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/partname
at25sf321

root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/jedec_id
1f8701

root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/manufacturer
atmel

root# cat /sys/kernel/debug/spi-nor/spi1.1/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x03
  mode cycles   0
  dummy cycles  0
 1S-1S-1S (fast read)
  opcode        0x0b
  mode cycles   0
  dummy cycles  8

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x0

root# cat /sys/kernel/debug/spi-nor/spi1.1/params
name            at25sf321
id              1f 87 01
size            4.00 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_16BIT_SR

opcodes
 read           0x0b
  dummy cycles  8
 erase          0x20
 program        0x02
 8D extension   none

protocols
 read           1S-1S-1S
 write          1S-1S-1S
 register       1S-1S-1S

erase commands
 20 (4.00 KiB) [0]
 d8 (64.0 KiB) [1]
 c7 (4.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-003fffff |     [01  ] |
---
Changes in v2:
- Change from at25sf321b to at25sf321
- Link to v1: https://lore.kernel.org/r/20241018-spi-nor-v1-1-d725bfb701ec@gmail.com
---
 drivers/mtd/spi-nor/atmel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 45d1153a04a07b7c61f46b117311b24ab695038f..8285a16b253d54ae8c4a5302850244d2248aa755 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -238,6 +238,11 @@ static const struct flash_info atmel_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &at25fs_nor_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x87, 0x01),
+		.name = "at25sf321",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
 	},
 };
 

---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241018-spi-nor-dc29698dea0f

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


