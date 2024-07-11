Return-Path: <linux-kernel+bounces-249225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061DB92E8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EBC1F231B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330B15F401;
	Thu, 11 Jul 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="1EIEvOmv"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624615ECE8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702831; cv=none; b=JT1cH+DqDarMJ+MFimxRa+MuGoWFF/av/n67dBeik2bpy/JRHnbit0Zuygp0yru5BGut3R4BbNMznHyfFGhzjY7mr8MEZa4NOsvahH1UOSlYwQpNlrjIIcuJUMDzcV/YuTdl1/0G85dYmrHUb3mJ2pTE3WxOkR5r1p791aYDzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702831; c=relaxed/simple;
	bh=E9Xx4YsmdLPl9JM6Nb956eFYmxW+WJmiJqnM9qnOYgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2nktgJxj7NEBztIz3xEO4xpme4Ix5TSKxdqqPIatnCtfffA6BI/1KSuF0JPPXvOYu3LxajQKejd3ZlKP9n8OYVAEXvibPxmTNjWOHYJR/mSVlNygoQK8NNxMAOV7CaaGKsM6Oi1onWbj8tsrUuSmpqrvyc2oTONevESv3tRpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=1EIEvOmv; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XeZX/fN1JLnmI+FO4xROcdTsrgS/vV35tYbkT3yOVA8=; b=1EIEvOmvQ7ULVcq45LRry6nK+v
	VWNoV6X660XoREPEAEvVqgKdJ68SLIs6yKVHRwIOgq9d6avjydiTEOwFd9+9ds2HWkFYTdBY+qVCJ
	4f2VRs1dG9MMp6DHEGCzSuIYTQZKu2JeelQZtDfR9e+ZFTsQBx5dzSgLN8linWJDHfgJNT8yC4Whs
	c/m6KpDD80YNKKl22TY0clTUz8JEsw1LdtlRVLVIBnDH0Fp1nYC3FAbFwoQqiSQFRXh9opvBzjpAw
	OxnXbMEmrjNaSJmD6F5ygxKJsUj6pSOzhYigSnwEZHhjwwC1ZbTfzXJzRN+kxyOzOj/ROEvA78AgE
	UR4K5seQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPG-000BSC-IH; Thu, 11 Jul 2024 15:00:18 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPG-0003Cy-14;
	Thu, 11 Jul 2024 15:00:17 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:03 +0200
Subject: [PATCH v3 03/15] mtd: spi-nor: Align default_init() handling for
 SPI_NOR_SKIP_SFDP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-3-99353461dd2d@geanix.com>
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 linux-arm-kernel@lists.infradead.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=1243;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=E9Xx4YsmdLPl9JM6Nb956eFYmxW+WJmiJqnM9qnOYgU=;
 b=iK/XDkcF02QhGwuqjgh2t6l5BJL/gsQcEG0/ScrlXESFe8xr/g+CctSmS5HLiXLNi/HxeDhFX
 5CtBi7zMusPB9+er3muBMrXmcaN/Ifhs4E9uKWeaWXMdIXDmshi6FUW
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

Currently, flashes declared with size != 0 in struct flash_info and without
SPI_NOR_SKIP_SFDP in no_sfdp_flags is initialized using struct flash_info.

Flashes declared with size != 0 and SPI_NOR_SKIP_SFDP set is handled
similarly, with the only difference being that the ->default_init() hooks
is ignored.

With the only in-tree user of SPI_NOR_SKIP_SFDP is the Spansion s25fl256s0
flash, which does not have either manufacturer or
flash_info ->default_init() hooks, it should be safe to align this, so that
they are handled in the same way.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 39b28700ce28..d58f107f62ec 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3029,8 +3029,7 @@ static int spi_nor_init_params(struct spi_nor *nor)
 		}
 	} else {
 		spi_nor_no_sfdp_init_params(nor);
-		if (!(nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP))
-			spi_nor_manufacturer_init_params(nor);
+		spi_nor_manufacturer_init_params(nor);
 
 		if (spi_nor_try_sfdp(nor))
 			spi_nor_try_sfdp_init_params(nor);

-- 
2.45.2


