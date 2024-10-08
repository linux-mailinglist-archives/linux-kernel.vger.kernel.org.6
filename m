Return-Path: <linux-kernel+bounces-354621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4998F99405D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CD71C26850
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58B41F8EF2;
	Tue,  8 Oct 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXFAXajP"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C11F893C;
	Tue,  8 Oct 2024 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371001; cv=none; b=tZsp5ph4KYwVX19B8pvPuH7sIFkFQXKnGTBvIfJLdqsec3gFDmhFiCV0sA8PPAp7vJhD0N3Ys7qnqcnboDs4ils/Hi15hhJzy976xLpUKk/bVNLcGU8AslG2ZSE6SToMHPl2Y9pFVAHo0wK4m2pegVmFMN+o6nC/1aVDMcLGGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371001; c=relaxed/simple;
	bh=PDm1f5NEBuhwxeXGvwzqxiOMHTZXe7TWbR431qOgkS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJx3EJkDAAopfCdRVazwWpItXcg3Fb0+Dm+reBSR3SGHX8NCHzsbW3t22x0iXG5hrLpW19lwenfCeCggoSO32NdgOrRgNEC2C53BKN5ueQomTdyGmLhjyORCFxnr9b/8urOYtc7dzB0BuIgyftf3YPHUHrnHNLSP1GoNoirsXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXFAXajP; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2facf40737eso57115111fa.0;
        Tue, 08 Oct 2024 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728370998; x=1728975798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=GXFAXajPZtGS4VY+sVq60YYd1uPrwT6nwP+2g1YaJKcR0WIcc5sxrRNG7Rn9fuZUi3
         Y/s65mS/gO2n9J2Xuc3kjw+oqrxYMoFg+pc5HakBF4E4RFkGvn7UeVVw//0xmgrqmjk1
         9E/ol/1jsOaJTkQYFvZsBgB1BW7mt/2/r9CjevtzAC93B3MIWLYK6r0DkbjHXq9YgiCe
         PBv4RQ4SGcVYd8FUhS+449ImojzCB+Ef9AwYUA6oPeST4K/t6XlcLuVCoB8mhEDnhSiQ
         p9qyxnLDwK5ADQcpC5hiaAjOk3Bq+Bhs0rNJwSdI5XVyzwL3hNhvTUMXe/NvSzjc2Va0
         DNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370998; x=1728975798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=UQh/okukcr5Dw6Ax688FqKH/gYXFbbDdzkWoO4RzFIO/bFw9CVk6h9gtUsau1QWIpr
         qIc9gPeAbYwPhavHBjGcqsoRER8IjhMVE2H8nVS8SxqCJVdfsfQ9olEr1BM1Vxi8ilU6
         ysLZKPfGBH8Lo52zKtVPPQ83PN0QtPp8rxAGQ99upp/0plsAlFMjMbXuMYbNm57KWiB/
         2zYQ3SwUXettJaBJMPUeGYUjV1t+qxA8QjB1qFBa0+WVoyp0OIpNlMUhXbLGhjGFlrQL
         uR8fud7dRlwOkpXJ/yc+3+fQE6HZXW4M99vL9lLS0wfaUwFup3IccOEDincYJrPqB5c3
         5W/A==
X-Forwarded-Encrypted: i=1; AJvYcCWAO0hsraM2k15x1bxTX8bqcDGLTlGltYIBJcciibr00LTzbwJP2nultx4BFKTfUCx1WyRdtSfqvqzrfy6E@vger.kernel.org, AJvYcCWwuuR0YewzZtZVc13+Y33E2RLObJjpEiuv+4JgpLhLn3wivjnTEo0moK9keHsOYzUeyFy0yTFZcEFR@vger.kernel.org
X-Gm-Message-State: AOJu0YxjzOX2s5T2r5dcTbPJUrRy9oL3skPeNjZfO/PCGpzb147E3/p2
	TWZ4wZ95Nojxsj7A9erCvb89Lj/TUx/T/hBh4q/ApNSdCt+rJBsE
X-Google-Smtp-Source: AGHT+IEpK42WxgBmDByl49S3Rv1fsmpO7eFqdwZwlDNyECMz3g/TSdU1T92CRunXSrS2pbGvJRiLGA==
X-Received: by 2002:a2e:a546:0:b0:2ef:1b1f:4b4f with SMTP id 38308e7fff4ca-2faf3d98cb5mr68031481fa.34.1728370997499;
        Tue, 08 Oct 2024 00:03:17 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ab1564sm10972441fa.7.2024.10.08.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:03:15 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 08 Oct 2024 09:02:44 +0200
Subject: [PATCH v5 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-ondie-v5-1-041ca4ccc5ee@gmail.com>
References: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
In-Reply-To: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=PDm1f5NEBuhwxeXGvwzqxiOMHTZXe7TWbR431qOgkS4=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnBNkebjGmYRrtlhenm+K3h8wiuFZxvVSZrNvwD
 ArtFpwR3SGJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwTZHgAKCRCIgE5vWV1S
 MruBEADehX3XFOMU22oAj4rCjhuoOpjY1i8KZ7VJFHpHztpYdurG8OpZNw2ZPWw3LN1gCGZiUqa
 pytKoyHppOK/HFoTv48/GQ64kAUWoyYFpYEKu0gyxBXy65U0zllfn9ER51Ed4BTCbPGn15V0ylo
 OUhYxCU5HIin7sEu7QyaO61mO27Kx08i+f27qS35/ROp3vge4MP15olSsF5JaJMjAHTf7w1nTAR
 JRAxQ+dJ3ldSSB2gDEeAQ13Tvq03ZWF3hq4g88vAhUZnH04hgdhtyN+0CuIKIy+lp3fg0YqR2Cr
 LB3YkbVRh77cjXJppZEZdQEUsvEyz3Z9vqrNsIvJJNXgPTPnQAXBQ8m+WyES/7LNWbo2NI5+lNR
 6sGBUfAe9xnJkameaw81NOlIAptgje6on4YAm9vDURoGWyphM6oKvQlrQuDVkkr7BUmR8IKWv9Y
 PqSpv6tvRjEuVuzHlS/PAsyazqm1OEP6gx6hM61Kbx3oXz9dLwpfa4S0ZTVxUK2VHO220IyxQZN
 W/Nci58Ixja/SEbtZaBAicrKouGf6rn7gR7rk6NLXQrOBaFbFICkebMYPngaj+ZeGEGOD7yhxe1
 tZ141OsiJOrrEMOwqgGhUtMsLWFN+g4r6WuzcJ12YY1dX2HABJLO7MUHvzCB6ea9yZQTgzKw0nD
 YouXThlSAhTsRvw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 392678143a36b20b42c1827eee8203dc2e41889a..79e768d337ae12f6e8d7f21f1acd4e259f4f3020 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -66,6 +66,7 @@ struct davinci_nand_pdata {
 
 	/* none  == NAND_ECC_ENGINE_TYPE_NONE (strongly *not* advised!!)
 	 * soft  == NAND_ECC_ENGINE_TYPE_SOFT
+	 * on-die == NAND_ECC_ENGINE_TYPE_ON_DIE
 	 * else  == NAND_ECC_ENGINE_TYPE_ON_HOST, according to ecc_bits
 	 *
 	 * All DaVinci-family chips support 1-bit hardware ECC.
@@ -524,6 +525,8 @@ static struct davinci_nand_pdata
 				pdata->engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
 			if (!strncmp("hw", mode, 2))
 				pdata->engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
+			if (!strncmp("on-die", mode, 6))
+				pdata->engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
 		}
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-ecc-bits", &prop))
@@ -580,6 +583,7 @@ static int davinci_nand_attach_chip(struct nand_chip *chip)
 
 	switch (chip->ecc.engine_type) {
 	case NAND_ECC_ENGINE_TYPE_NONE:
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
 		pdata->ecc_bits = 0;
 		break;
 	case NAND_ECC_ENGINE_TYPE_SOFT:
@@ -914,4 +918,3 @@ module_platform_driver(nand_davinci_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("Davinci NAND flash driver");
-

-- 
2.46.0


