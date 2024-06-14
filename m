Return-Path: <linux-kernel+bounces-215273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16B7909082
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75D61C22CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D619FA6E;
	Fri, 14 Jun 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="JrVPo0pZ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CD19E7D0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382967; cv=none; b=nye4zaPhVAlT+7kufLAS9b4YI7f9+lPLIITCRmzzXB0XyIHQMVxPXan/s5FPXnaXPNEVBN7vcb3om/8SMc8LlHcSC3I6E7kSks5HpgCdkcUGlF/1Ys5WhtZp7NZOgOqbCeHxEAP89bBYcOvcnEIjulubXODjHkdB+cIfVL3DVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382967; c=relaxed/simple;
	bh=w7D4H6haG4wr9/zSA8Ls/XStp8bmY84epC3dKNvwTuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dv6gRrmos8BDLEn83LIPmZydO/V2TSxCiroVqJBHfp5eL1BnSP6NPaKO2qo+JQgStqIHYQfunf80rTugOliG7skq6za8KJuuI3T1Ruum2umtZeipGHXm1EwuwS+JwO81sCm7itpx79M7OQXLRQI2Ubzh9+h++9+rOixhdbY6hBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=JrVPo0pZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so25594401fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718382962; x=1718987762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy3GGlbh3G2vnmNyR+RwO5HO4iCoGtDW9R/i+yrCC54=;
        b=JrVPo0pZHGBTg0OBKIqXEm9LdBvBPzSvGFCPSmMcidbx6KQmltZ+5HWze/CbIl4kha
         krtnJaynDlxTUn0p6LODsyQ/01IezZhkS/phxinxEuBapE33fCGGBOqXjTaOtpQ94Q4s
         A/TMZ0oIwLCip0Ea0VFsr6nzKBMIQ8w4m3XDCClJnAJL6u4aCUFtN6+SKWF7yPYki26F
         DfR4qcTXdb96OdGxRoNx6JN7eP5AMhpS6VQxcnbuQhBfIKrhCH3gspX7q3gOtgYAxini
         oTmw09t3MWTRH1ejE7Q/hGCd8NKToMwlFV8JHWjDxauu3+ll3Bp3zxOKWxNRZvt8n5Da
         BnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382962; x=1718987762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy3GGlbh3G2vnmNyR+RwO5HO4iCoGtDW9R/i+yrCC54=;
        b=wedAEwOwkSkb5SjfGDC6jhBLqLyN5M5Ctf+//G+ntj/kfN3ld82/sX/estE7VU2VS+
         QPfGBApYCJecUpKcanwixZoR8IHGPJbCm74OKqu3WX1MvfSDrjo2ziY6c6V0FSCmWGmV
         VTkMYT1WLMBBy0XBeCHVHIpxksKR2nx/gGDXV7dPcTsF+BP8fH+209MpyDbIVlhDzfOP
         M8NdufyFPReJkeHYsxlnfv0mmDFUJ+vFRG8eSfqgfs7I4YMmhwU1xiiwLtkDCX1fIR+y
         hWQD+/8e0CuqBKuN4nvlluplsZO0aGwjeISehAl90+8Cq+h+6Lq/wlKG7/rKuxNUqB5k
         D9fA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxGL6YvAzlkvqpVAKDGe89havVK1o8OdIsiNih23n1nYjeR0MguVjfnnTkJAoWJLSFhR4S+Qmq2ASe6sAtQYdjq5fTGwTa6cchXoR
X-Gm-Message-State: AOJu0Yzk3fs/Bg5b6T2bHPFIXuul9Q2d61N1GUmoVi4q9SMND0KhMngc
	ZdRGJPIAQWKuLw9N/fMK8SOzha11IjiohcPpb9Gj2fQgnVEoSCqPlyjL7msOT+M=
X-Google-Smtp-Source: AGHT+IGObyo93x6mViEfQkk8dvpSrxYPk4M/l+DCC0LbAFJwHdY+8GEZYaPp5jt0ycxMk4ErP7bBog==
X-Received: by 2002:a05:651c:153:b0:2ec:19a6:d5c8 with SMTP id 38308e7fff4ca-2ec19a6da8emr14442551fa.12.1718382962310;
        Fri, 14 Jun 2024 09:36:02 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm2462893a12.22.2024.06.14.09.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:36:02 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: 
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/4] ARM: lpc32xx: Add pl08x virtual dma channels for spi and i2s
Date: Fri, 14 Jun 2024 18:34:51 +0200
Message-Id: <20240614163500.386747-4-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com>
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the signals are multiplexed, multiplexer configured at a signal
request.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v3:
- Split previous commit for separate subsystems
- Add pl08x virtual dma channels for i2s1
- Add dma mux handling, required when requesting tx dma signal for i2s1

 arch/arm/mach-lpc32xx/phy3250.c | 111 +++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 5371bfaed799..2ec0411964f9 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -9,14 +9,18 @@
  */
 
 #include <linux/amba/pl08x.h>
+#include <linux/amba/pl022.h>
 #include <linux/mtd/lpc32xx_mlc.h>
 #include <linux/mtd/lpc32xx_slc.h>
 #include <linux/of_platform.h>
+#include <linux/spinlock.h>
 
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "lpc32xx.h"
 
+static DEFINE_SPINLOCK(lpc32xx_pl08x_lock);
+
 static struct pl08x_channel_data pl08x_slave_channels[] = {
 	{
 		.bus_id = "nand-slc",
@@ -30,11 +34,97 @@ static struct pl08x_channel_data pl08x_slave_channels[] = {
 		.max_signal = 12,
 		.periph_buses = PL08X_AHB1,
 	},
+	{
+		.bus_id = "i2s0-tx",
+		.min_signal = 13,
+		.max_signal = 13,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "i2s0-rx",
+		.min_signal = 0,
+		.max_signal = 0,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "i2s1-tx",
+		.min_signal = 10,
+		.max_signal = 10,
+		.muxval = 1,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "i2s1-rx",
+		.min_signal = 2,
+		.max_signal = 2,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "ssp0-tx",
+		.min_signal = 15,
+		.max_signal = 15,
+		.muxval = 1,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "ssp0-rx",
+		.min_signal = 14,
+		.max_signal = 14,
+		.muxval = 1,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "ssp1-tx",
+		.min_signal = 11,
+		.max_signal = 11,
+		.muxval = 1,
+		.periph_buses = PL08X_AHB1,
+	},
+	{
+		.bus_id = "ssp1-rx",
+		.min_signal = 3,
+		.max_signal = 3,
+		.muxval = 1,
+		.periph_buses = PL08X_AHB1,
+	},
+};
+
+struct lpc32xx_pl08x_mux {
+	int signal;
+	void __iomem *addr;
+	int bit;
+};
+
+/* From LPC32x0 User manual "3.2.1 DMA request signals" */
+static const struct lpc32xx_pl08x_mux dma_mux[] = {
+	{3, LPC32XX_CLKPWR_SSP_CLK_CTRL, 5},
+	{10, LPC32XX_CLKPWR_I2S_CLK_CTRL, 4},
+	{11, LPC32XX_CLKPWR_SSP_CLK_CTRL, 4},
+	{14, LPC32XX_CLKPWR_SSP_CLK_CTRL, 3},
+	{15, LPC32XX_CLKPWR_SSP_CLK_CTRL, 2},
 };
 
 static int pl08x_get_signal(const struct pl08x_channel_data *cd)
 {
-	return cd->min_signal;
+	const int signal = cd->min_signal;
+	unsigned long flags;
+	int i, tmp;
+
+	/* Set corresponding dma mux bit if muxed */
+	for (i = 0; i < ARRAY_SIZE(dma_mux); i++) {
+		if (dma_mux[i].signal == signal) {
+			spin_lock_irqsave(&lpc32xx_pl08x_lock, flags);
+			tmp = __raw_readl(dma_mux[i].addr);
+			if (cd->muxval)
+				tmp |= BIT(dma_mux[i].bit);
+			else
+				tmp &= ~BIT(dma_mux[i].bit);
+			__raw_writel(tmp, dma_mux[i].addr);
+			spin_unlock_irqrestore(&lpc32xx_pl08x_lock, flags);
+			break;
+		}
+	}
+	return signal;
 }
 
 static void pl08x_put_signal(const struct pl08x_channel_data *cd, int ch)
@@ -61,12 +151,31 @@ static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
 	.dma_filter = pl08x_filter_id,
 };
 
+static struct pl022_ssp_controller lpc32xx_ssp_data[] = {
+	{
+		.bus_id = 0,
+		.enable_dma = 0,
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "ssp0-tx",
+		.dma_rx_param = "ssp0-rx",
+	},
+	{
+		.bus_id = 1,
+		.enable_dma = 0,
+		.dma_filter = pl08x_filter_id,
+		.dma_tx_param = "ssp1-tx",
+		.dma_rx_param = "ssp1-rx",
+	}
+};
+
 static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl080", 0x31000000, "pl08xdmac", &pl08x_pd),
 	OF_DEV_AUXDATA("nxp,lpc3220-slc", 0x20020000, "20020000.flash",
 		       &lpc32xx_slc_data),
 	OF_DEV_AUXDATA("nxp,lpc3220-mlc", 0x200a8000, "200a8000.flash",
 		       &lpc32xx_mlc_data),
+	OF_DEV_AUXDATA("arm,pl022", 0x20084000, NULL, &lpc32xx_ssp_data[0]),
+	OF_DEV_AUXDATA("arm,pl022", 0x2008c000, NULL, &lpc32xx_ssp_data[1]),
 	{ }
 };
 
-- 
2.25.1


