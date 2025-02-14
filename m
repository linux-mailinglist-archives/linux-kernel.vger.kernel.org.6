Return-Path: <linux-kernel+bounces-514512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92620A357EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF07F16B3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB26F20C02A;
	Fri, 14 Feb 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHZ4IOu1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AC18A6CE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518381; cv=none; b=F0URqHkKaHMzXi5A+UHulZkxrfmqTUIdeEpDzRCg8rLcNQiRxlWWUncwFLpD6uCF1S7Dt3DMmc4yGM/TAww66MPCRLXLrubR2nfNvtaFXj7kRmBJnxO1//THUUt7B6lCT9Pcs+0CmWtWCNCejoeSY+M2t+LNF16jxx+S6hMtAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518381; c=relaxed/simple;
	bh=qroXXeauOVL+Iovn6a2A4yrahP1v9fykcfW2iddMnS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bZAMGKC6fnx1kRdiPPrtamaQtV023OcWFw42oa1f92Pf+gDSrV8DLDZ66CXI06+Mr8mrRo4Vn2Ur9Byr6KZByCMIZ4JBsZoxGTK83+nGeelPnNPAzJfuJJXyGMgy8M//3CcDaWPF0hFeMTDpiDA+HQ/I6aodT/jaXZq5oCE1LDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHZ4IOu1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a39e659cso12090545e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739518378; x=1740123178; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shBU7AF8cc3Gg0wYtL5qbOpWyX+VBS6JrNAtiNUzXh4=;
        b=YHZ4IOu1XRgQ4UbWIpLBcs5tLQ6S8O5Jae2W75YjqI/t9P2PcfurXhs4GCD5TPCNed
         S0MX/SqaTYZ4JIEBvC+Z8VOlrZPKA8UorEAhpfGAYLotg63zB/ThPnBAynCkLGs/WvJH
         g1G3fAO+MPb80tXRDwNfULztgYXengQHi5KdMtMLAbteqri9hx621GXJsa5SO1cfpGmC
         xVX1ChvY0Qkp00vRYqaaStpvZXoe6huXX8zZImOnUb1reLGNcd1gpZXJUU9sT0xPpvMK
         AJDEx6lcMeJk7Bbw44oU86RSxVQ2vkToQABRUu3kuzjsomrdunSz50qMVNY/hPQ0FbsM
         8/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518378; x=1740123178;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shBU7AF8cc3Gg0wYtL5qbOpWyX+VBS6JrNAtiNUzXh4=;
        b=BQOQbyqnIhQxRhIQlPN7wouHvi8gTBdNPsG04SRrOMjI1SQzFOzFvx5WHkSj7PAW1b
         Qq92wbCM17esK3Q04G7gLR5EZh2ixN/EY8W+mA2987MqLXQL+f9O2h5CC4O6PRxJjAuh
         B3+MnoevhBtnetD+zeOdr7igIgYO3DTTER34tDU/hwYg43UBDDTHO5rw6oSoCpWP3iDH
         FEfG63s2XGIL2x1MMSHQ7yba5zj2wcP4ibNzZMpkL9t1eJF84sZxcOqRVS62RpN03kEf
         WLezllDCHxUC0WksK5CtGysrb2GKO8cty1eBSCJl2lJZGCJzIAcPJgVn5fSXCCv5BqvO
         LVGA==
X-Forwarded-Encrypted: i=1; AJvYcCXPngX2mgvIfdvDxoS+Eu6nkIIQn41YegPf48J7V4u1jhnPL26leYYhIvRrZQu4F6my2a5F9crw1x3/8rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0/SgTLbgnBk5XCt5xovNyBo8VlwCFAg1XwUBVAv7ZmuE9Kub
	COSq/QXb58iJMWCCDP68SLZBGZFP/RusBF+Gg5xT3pXy3GC0lEsR+si5Umx15Os=
X-Gm-Gg: ASbGncvFc1JIj4OYFmyteMa9gqQxPzYFB//VFJxcd2jkYaytpWViLDex5gizpnKtltS
	0rxRkwzNrPk3aVP1noOS7oz7Spz3ttsqHmYfz11E0PwyVDgSl/ZxOonDbC0LNR6628OWLBBtR/l
	TYesz3WKd2sNO8p7v5qwSDQgJtfo6l+XUR4xpf5RmMyL/KVUTF7d81qLjsl4GyVKmr1nhC77BaO
	X3IDp/UOBQBOBA8lZUKGURsnbVbVd9z3fQ+fy7EVDCyvCld2wWCVfuXzbWjDxkgU8yT4ccTXhPR
	alVDOJNXtOpQlhdxptZOROi8DTBswZTJkWaH1NrjSCW9P84TQyRPpBArdK2LFvwkqQ/Oolc=
X-Google-Smtp-Source: AGHT+IFuIc7UiGCJhgZrFsDUkrGq451Woe/uSGjG7ifl7lmj2MKi1SN0qMavFWZVChA7j+uVL+MrSQ==
X-Received: by 2002:a05:600c:a00e:b0:439:688c:c5d7 with SMTP id 5b1f17b1804b1-439688ccb9cmr14257345e9.14.1739518377759;
        Thu, 13 Feb 2025 23:32:57 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617da779sm37914255e9.7.2025.02.13.23.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 23:32:57 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 14 Feb 2025 07:32:51 +0000
Subject: [PATCH] spi: s3c64xx: extend description of compatible's
 fifo_depth
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKLxrmcC/x3MQQqAIBBA0avErBtQK5OuEi0qx5pNiRMhRHdPW
 r7F/w8IJSaBoXog0c3C51Gg6wrWfT42QvbFYJTplNEtSmSUZrVtzhg4nOgpXjva3vVBK7eQa6D
 EMVHg/I/H6X0/Nv6BHGgAAAA=
To: Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, linux-spi@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739518376; l=1528;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=qroXXeauOVL+Iovn6a2A4yrahP1v9fykcfW2iddMnS4=;
 b=pC0wnwQmYJD4VRMIu0mEU35gRvOsR5+nV7P0t6kj2Mi0FELhmNG6Z28A98l1CakNjcGIhYM9U
 cVx5nVDITq7CFuVM5o68gNDX3iuVdvCxa9gdRYs8H2LLzjPOiRybBHF
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The FIFO depth specified with the compatibles's data is used where all
the instances of the IP define the same FIFO depth. It naturally has
higher precedence than the FIFO depth specified via DT. Specifying FIFO
depth in DT becomes superfluous in this case. Extend comment about
compatible's FIFO depth.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 389275dbc003..9c47f5741c5f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -139,7 +139,9 @@ struct s3c64xx_spi_dma_data {
  * struct s3c64xx_spi_port_config - SPI Controller hardware info
  * @fifo_lvl_mask: [DEPRECATED] use @{rx, tx}_fifomask instead.
  * @rx_lvl_offset: [DEPRECATED] use @{rx,tx}_fifomask instead.
- * @fifo_depth: depth of the FIFO.
+ * @fifo_depth: depth of the FIFOs. Used by compatibles where all the instances
+ *              of the IP define the same FIFO depth. It has higher precedence
+ *              than the FIFO depth specified via DT.
  * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
  *               length and position.
  * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the field's

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250214-spi-s3c64xx-fifo-depth-6787f108be83

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


