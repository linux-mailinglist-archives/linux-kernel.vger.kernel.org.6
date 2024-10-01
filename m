Return-Path: <linux-kernel+bounces-345701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0B898B9FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69091F2391A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF771BC9F8;
	Tue,  1 Oct 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ2CxZsS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634981BC08A;
	Tue,  1 Oct 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779383; cv=none; b=cRNOyE/YYcShMh+7HsA6ivmzfLsdx6OHhQeQTEZqUtysGTUj/hRThlQvMY2kPbvefiaX8Tp97Nfxo4YSl4Kghfb4x85mf1Z6jS3/2nK7UDvltPLWrr5lm291Lc8Bu4JHZh2n+Is6MVHTEUlcJyBIwrfqujVpxMneoGqNebU8aRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779383; c=relaxed/simple;
	bh=PDm1f5NEBuhwxeXGvwzqxiOMHTZXe7TWbR431qOgkS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brI4HXzccw64TtoDQpa0urvwD7028ZtXAHqOiD8fugqBHc/RyQBA3L1l2Aq0Cai5G6k3mThpRAQ3Rf7eCykAwCvuIbxJgKYzTvIBB17ankGduAdluQMfD0C4je527fTMfBhGnxZzlCHTe+vt5s4Wwv9bkz2Ua+ud93YwmZtsHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ2CxZsS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5399675e14cso2327374e87.3;
        Tue, 01 Oct 2024 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727779380; x=1728384180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=HQ2CxZsSXDY94Mow8mQCLuLkNxU62ErthofTOZgukgRVqCbbQByoRHa1LAzlLiDemd
         CSwY7UX78F34iYyMfKA7NeMwvUAip1DXEzUduJzZdRMCYyFsRGBAL8Al+yn950tDYFL7
         7z0qG+evuemHbAYTvuUBZGXlBTJ2Jl5i4KVUHJgUE8aGhPY8FbnFZRBpOo8fPhbfGqpA
         ZJD+DMluzJUJr8Y1EnxVkkxnUPKa8Ij/PrtXX1xLe+ruVc8OzT7VlNQhUYr1i/SUjyqW
         3gKqUFh994ZbC2d1QUEfrRm37T07NI5MxSUZthtLgz81Aslkxa4PUI2oFYY+o+ksvbUJ
         hPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779380; x=1728384180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=LMPTKds5J07YA0K8sN1+9G5/Yt3pfCbmG8p5E85GhtX/RyAs90EIN7UnYxHTf/wuae
         n7M8jAi5A7MQ6D2+/kqRGMq0x0F78sQBaZz1C1eNlgCK+Rmrsg/WkjyTU1EEud5EOJJV
         yC0VC23kYhkvAnSpUY94lw2nL0lQQN5NwZzEmZ8FD/ki2iORu8V1SmV73vj8gxelIVRm
         9CmEnGt3OE+YkoeayP8MFH8+mAPxAHaOgsnei7CFbJjxm4RK5dibrbiQVOk0v31q87E2
         mj0o9+IEtVM+xtworNO7X8+i6W+lbDJfMTVxt1YjaChhblXhneU3PIfrQfjHO4toZq6b
         2hAw==
X-Forwarded-Encrypted: i=1; AJvYcCUIpqqCcY/NwPhAkLeBnt3DVCakW2dNm7JIOuWPFojMK/Dqd16QFE0seAJX+Uwot/2ZlP222eh2mQPWWwzw@vger.kernel.org, AJvYcCWBYclhAAJVApwOLdUrpzf2h4lj0ozJnaoOb5LHJ/9OyN30aC3Cfl4dwblXGTCFigcJWLnaXSpLwmxe@vger.kernel.org
X-Gm-Message-State: AOJu0YwyyfgEb1TuRjYd34fXNv6VTRkDz2IIL1bS6lVPXaSQGsfKlfmt
	AO3CUzRapSOy7Gqx+JuKQRaaQaWnLZUOfUxAkSUSIr0XA3S8RnCa
X-Google-Smtp-Source: AGHT+IG/BL9G/CZbs5/Ht2iGEeN/cEVttH0ft6CqPCNk1DwVJTPXgXzlAtVOF0UsrZaLqTUuPf9RsA==
X-Received: by 2002:a05:6512:6cd:b0:530:aa09:b6bf with SMTP id 2adb3069b0e04-5389fc3747emr8558112e87.24.1727779380179;
        Tue, 01 Oct 2024 03:43:00 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd53a02sm1549026e87.31.2024.10.01.03.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:42:58 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 01 Oct 2024 12:42:26 +0200
Subject: [PATCH 1/2] mtd: nand: davinci: add support for on-die ECC engine
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-ondie-v1-1-a3daae15c89d@gmail.com>
References: <20241001-ondie-v1-0-a3daae15c89d@gmail.com>
In-Reply-To: <20241001-ondie-v1-0-a3daae15c89d@gmail.com>
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
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm+9Ih92PxVphriOcHjQalCKMkkaHpNrUhRbjz4
 cPS9+Z8r12JAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZvvSIQAKCRCIgE5vWV1S
 MpvtD/96jhTVsSN+ptMU+Evlwhv4dTAoF+mcghcW50wrwJYXrKw6dk7YYGRIJJ2FuoSfzJh+umA
 bpomSUCLh9GjLDlFKY2iC77wbW04fuuib3Gwcx8Tvyz+zqDxDRwjbEBZ9XM6NJUPprT61m0yJYX
 geuuwzG9yAL0GCMKW3IQD8f/HXEWkV96V60dFrf/hqYVuhsmh7v3juoy0m2oRjE67ButuD3eB5G
 U8gV19UImOA6G0WubUc3uLHC4ormjbYV7GPP6uUJ/3OEtqynTODYZiy/rPxHU7/gLStdMfG0el7
 zQME1WtkXJMcGlcdEw1gGpGYG22vIBYiJeW4jkejWPm2KnBCRQuoZrtq1y77xyDfj0S4bx5DWsF
 U23nq6A6oE+v9lQNCxeUX+XKfkd1y/zkkrdBbLfvkgfpu5mwtZ5SRqgayZocYv/sz3iUd1TWsts
 IWPGTqhpr9bbjiAIIytn9hI6qU4bbaATOs1TVuMSwlPDbfYxSv2IueSfuNOohuDmqCWVaYLYDD5
 FAAxuwdrS14E5dBDD+PNHsJnXv5ZszHKmpnJZO4UIPVnSpoH2G2f/whmMNkITwGwNxOoIMmHLP3
 nenkxKdIrntuUldfB3QRADQvvXenEHN7FUD+3jo5rWgSdv7AKwXxQu58N2TNEQIUd4kUY/iKKX0
 M3stbVMlRmcfc1w==
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


