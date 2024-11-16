Return-Path: <linux-kernel+bounces-411694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C79CFE56
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AC21F244DB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4CB2F29;
	Sat, 16 Nov 2024 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huM4oPOu"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48126190063
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731754577; cv=none; b=rTuv77C4iKeSt624c/lB9z3oGguaTAPc61/e0ki7stAKcscrk3m+4MMKNg2u+kYGDwr8qp3rvWbLb1Eg2S1BkZc15sKnT5hz/Gyw/vhPV1zKxXVbrfvlziBysc7q9aV+YJ7zkljqEhU6AB9fpruhS5npVxhYp3z2hpuS6Oe3iys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731754577; c=relaxed/simple;
	bh=S9eRxq402eK4I35Xnjw+5DdjS0TnqMYqf/6CHY6wIAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dXT2rQzPyP/8urjgIONrOKRRAdoHhde2rCTqfiVAKCoVnB890fBBLYP5F+0EHwa/+c1sNzIhPF/n/VoIWh4loAZB7C4Vgc9EaPjWHcc9n8RYr7TvRFrZ4YlI9LcgwzATXUufKJc0hKtfh/gr1T3mxO0K9YoV9PFROcmvkk02L5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huM4oPOu; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so21216871fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731754573; x=1732359373; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsK2HSjEed8EMz5ILwoIkeMUbKZSPGTUjsgD49Z7xGA=;
        b=huM4oPOuYCcX1jChWX3rM542HeNbm4HKz8fwvz959KKm9c9CgVTtUtVAYEChQEgS4U
         aLJcE3wlVd1aQGoh57PW+1qWfd/QjFQ7pfoKYvLbnBx/I6BUgo+vNUnf8E7UAa/vwij3
         5IWHGNecxvmoynqex195A2PKyxdzWeY//tUXMwo0vTDxlJ/zNpkqPls+vtwNY975qzTU
         HlMKf9RQMEQcnRFLjS/19s9ij4AGO/Rg9Wq1clz6lAiiJzgV/DRI/ybxt/HfmftAvGjm
         QZddbSkiKwKj7R7Wupuaj8LZSdf7TMmlZgsn+KLERAO0Hn1A5lyf6eHP5Q6AmkHSHR8+
         6dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731754573; x=1732359373;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsK2HSjEed8EMz5ILwoIkeMUbKZSPGTUjsgD49Z7xGA=;
        b=la580xR04iP8CrEhilHl5DJtqtkoW9UhCJm00+INuNiPgSVaVPr+8XYCQYYqKdNQ90
         XvFD8QCPAOeknPiuFWeQe8jzIj7MzWbe9N3VwVPnw0eQbTbG14VbiaqDGY5BMTi7wvD8
         czU99AtTjps/Nju2R2SWek75ibB0AGcD6i/KNjnsRlNox2toT/nj1U2C3J3/AXJYI67F
         WZd7EFiAVjZm4Wl5NCD7J1MJqj8HwFiTg2rtWhfBxvZzRtnhZfRVSke+UwNu8/sFvGMd
         37lZD89Ydvx4K3luPZzqDsCqYuAaHb2F0DC9A+AMdf9Jbhf+6TvuXYtxIw7iAWzNdUEU
         E0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCX0VQT0lMSGSEmSAGHL7IUleGRytc9BtLJ6YProGqmQ+aA9l1MNuQxc1DTTWRRrxhoqcNNgZpZX60+aRmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMA0sshDcq4IOvQikONoLGwB4XWQP04mXuznkFX8BK0hF/KL0G
	S2l/r8+LmkeMGEVfqHYqKyrG1agIDps9sPJW+CF0esd1xgJfFvFd
X-Google-Smtp-Source: AGHT+IEK8/b0zHZVkVOqjdtIvar+DEHmvQ9/RvK13Xl0AsBy6sPbYs/kgVQgfmYz7Sp5NJTIFX8hsA==
X-Received: by 2002:a2e:be25:0:b0:2fb:5e64:327e with SMTP id 38308e7fff4ca-2ff609c654cmr35086611fa.33.1731754572865;
        Sat, 16 Nov 2024 02:56:12 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69b158fdsm2289301fa.102.2024.11.16.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 02:56:10 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 16 Nov 2024 11:55:55 +0100
Subject: [PATCH v4] mtd: spi-nor: atmel: add at25sf321 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-spi-nor-v4-1-3de8ac6fd0be@gmail.com>
X-B4-Tracking: v=1; b=H4sIADp6OGcC/2XMTQ6CMBCG4auYrq3ptPzVlfcwLqAdYBKhpDWNh
 nB3CxuILr/JPO/MAnrCwK6nmXmMFMiNaWTnEzN9PXbIyabNpJAZCKh4mIiPznNrpC50ZbEWLUv
 fk8eW3lvp/ki7p/By/rOFI6zX/0YEDtyWMm/aphSA5tYNNT0vxg1sbUR5cFLvTiaHUBRGaSEQ9
 K9TuwPId6eS0wpNXmVQlqY5umVZvjtp4J0OAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4883;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=S9eRxq402eK4I35Xnjw+5DdjS0TnqMYqf/6CHY6wIAM=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnOHpEhuDfKZJq5pNn5HGrppcMqMIFW/mvGNTVD
 6wy2OGQw5GJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZzh6RAAKCRCIgE5vWV1S
 Ms4dEACJPrCLNfXlv8LSAo2ITG/27aqRj1Dux1Af4VpYRkhUvt7tAHQ9ZPBbd/IxFZbzbjiXOe2
 67z7quG11la+0eif5vghMRHIQFD9TlBXnwzH8bANPMkLhCTfa9FAsHIWSaJroDVW3fpIPcLbi/O
 ecnaCH40s1oJ0nsJmmVtir90GeVptGAbsNsh5HuG+8fJGO95vDooMZZyoDlKLoC/0UPehbJELo9
 Yev671hIVjlvmvn9InEj8QGXqs3PJOIZ01D23+KCkwttEhOr22KvaSMaaSPeXY7os1SJ/RkCqJf
 lUHsMU8prc+FRvDnIL/HPE8J0uqw2bkxoIONyrfF9oWchX+LS8vvjJACL2YlBLUdVpyJ3hACc3Y
 FPnXy0jLYW+CiOhMcXXlDYFnYlf/GC5tDjXhRl7/l3qhx6TQa8QI/E5J+teoybwCZG2rWW59DjO
 /eREh2oqhXqn5+vr1NT2Go+tU7av3I652UYE3bwO8MzhB2t+Uy1FB1LsNNj+653EdkokOTU0tcz
 E1bgcZHoEKq1jnV+m/54Q2guLBPTfFF5miRTdvnU/ksFaR+ck22xUonbrDKMdKMBMu9JzfO7rS6
 Wte/dEC4HAIiyqxYJu6lcXZtoSlr5mItkXATxUVFXViFVJvCLQnVHkGt6hIxdzBAh+3EULZTcoq
 SwNMGlX1HPU5RJw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add entry for the at25sf321 32Mbit SPI flash.

This flash is populated on a custom board and was tested at
10MHz frequency using the "ti,da830-spi" SPI controller.

Link: https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=1608801
Reviewed-by: Michael Walle <mwalle@kernel.org>
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
 1S-1S-2S
  opcode        0x3b
  mode cycles   0
  dummy cycles  8
 1S-2S-2S
  opcode        0xbb
  mode cycles   4
  dummy cycles  0
 1S-1S-4S
  opcode        0x6b
  mode cycles   0
  dummy cycles  8
 1S-4S-4S
  opcode        0xeb
  mode cycles   2
  dummy cycles  4

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x02

root# mtd_debug  info /dev/mtd6
mtd.type = MTD_NORFLASH
mtd.flags = MTD_BIT_WRITEABLE
mtd.size = 65536 (64K)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1 
mtd.oobsize = 0 
regions = 0

SINGLE
======
spi-rx-bus-width = <1>;
spi-tx-bus-width = <1>;

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

DUAL
======
spi-rx-bus-width = <2>;
spi-tx-bus-width = <2>;

root# cat /sys/kernel/debug/spi-nor/spi1.1/params 
name            at25sf321
id              1f 87 01
size            4.00 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_16BIT_SR | SOFT_RESET

opcodes
 read           0x0b
  dummy cycles  8
 erase          0x20
 program        0x02
 8D extension   repeat

protocols
 read           1S-1S-1S
 write          1S-1S-1S
 register       1S-1S-1S

erase commands
 20 (4.00 KiB) [1]
 52 (32.0 KiB) [2]
 d8 (64.0 KiB) [3]
 c7 (4.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-003fffff |     [ 123] | 

QUAD
======
spi-rx-bus-width = <4>;
spi-tx-bus-width = <4>;

root# cat /sys/kernel/debug/spi-nor/spi1.1/params
name            at25sf321
id              1f 87 01
size            4.00 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_16BIT_SR | SOFT_RESET

opcodes
 read           0x0b
  dummy cycles  8
 erase          0x20
 program        0x02
 8D extension   repeat

protocols
 read           1S-1S-1S
 write          1S-1S-1S
 register       1S-1S-1S

erase commands
 20 (4.00 KiB) [1]
 52 (32.0 KiB) [2]
 d8 (64.0 KiB) [3]
 c7 (4.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-003fffff |     [ 123] |
---
Changes in v4:
- Join line for link in description
- Removed .name as the ID is reused by different chips
- Link to v3: https://lore.kernel.org/r/20241115-spi-nor-v3-1-93ec584177cb@gmail.com

Changes in v3:
- Add SPI_NOR_DUAL_READ and SPI_NOR_QUAD_READ flags
- Link to v2: https://lore.kernel.org/r/20241029-spi-nor-v2-1-e166c3900e19@gmail.com

Changes in v2:
- Change from at25sf321b to at25sf321
- Link to v1: https://lore.kernel.org/r/20241018-spi-nor-v1-1-d725bfb701ec@gmail.com
---
 drivers/mtd/spi-nor/atmel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 45d1153a04a07b7c61f46b117311b24ab695038f..82c592f0a1e156e6871785d58b670f76a0c03911 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -238,6 +238,10 @@ static const struct flash_info atmel_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &at25fs_nor_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x87, 0x01),
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	},
 };
 

---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241018-spi-nor-dc29698dea0f

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


