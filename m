Return-Path: <linux-kernel+bounces-311512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F369689F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168871F24C89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB93DABF4;
	Mon,  2 Sep 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/YSLaCG"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664021C17D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287413; cv=none; b=eT7f4Cgb7MzaRS8PM2Rw81lnsyQ5dAg9g7nAdYtSEU/b+AGKlSxuNuwfG71ZGTD9Ib7sSPgECuCMda34bLcRThoYIxh3m5OgYVQbG/wldnGFHKp8ejbtDtphno1zbkmkog74JQTnU1x2WWHxEFoeazzyX1nKVDvyMYoymY4RQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287413; c=relaxed/simple;
	bh=XHf1PxvMaYpt9H9YkJQcuwUwUJRg2m4RddjadU32f/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxewGHgyg1qqiTp+jn+Hm2feQ106cW2FcYCmoUT+VJQ5PGt2eZaHBTRG7S90As+9OpxukoxtoB2YGVzgbQW60XieKmjQV6rsr6Bfg37AMerrRmSEuh4c7TwFCyKN+5tNEl3bF/7/VWHjDdt/e130hjJhKNvopTKn/bswt0GESMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/YSLaCG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so921031a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287410; x=1725892210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np21NntzYSGuYS09nKGt/s8sAnf5QNjafiADebOVCz4=;
        b=X/YSLaCGc4kN2Ss3Uu9tLdddpv3Eqy4F6zuXY6zhi/ANj2GWYETC34UwZfvK0FO+3p
         vZj8vPslWud7uatYXBEriJuAmmrDiWtoZMZZ7fswuitQAujA01BEJ1KF7uXx+PbBXLdw
         /QhD9Np6Ony6QgUBJ+7RHSyNFjKL8gJQsiOxOhHe/PFVcUC4WF3F8xjk3ft+FEdMLecK
         HhXFH5aucPFQvKEzLRAnL/WLV7MomCJoZPoE0ZStaT/HlO2WnNV2RhOyMsp6U30sfIGr
         QYTBP+aH5H2H3/wffhwDF8puBMP7BblnNrGgzjaoxBeS1AnmjckBPHeStJemwxfqygfV
         mRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287410; x=1725892210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np21NntzYSGuYS09nKGt/s8sAnf5QNjafiADebOVCz4=;
        b=q5epa721zLqONq8pvsPjNHTzNrwuo425oJfCscewICPRVhTNGhyaW5txn+UiGA0Hm+
         j38WvMRRAUWeZSPVPBzHLHXB+eZyc2n0ocYyx9SAUVWA8lfHBLDDh4YnX/IJTAvKHdz/
         6uLR6UqqXpdg2z7bDEoxeDa7EvoTahnFWodbJR3rHrfJHKmCavUY9ENdAOvmHI50XI1v
         65FVJIj++ho60JfvUu8pevqQbzB0IyduWGyQ7lfmjKlamYHsb7Vwny/NqE1Jb57FH9TB
         4oE2D9IhshYC+AXtxeXyCaUPJl8IxliW2b3V7MZS44nsVMCYLC/B7QUNCEG7EQWrkuZq
         jtyQ==
X-Gm-Message-State: AOJu0YzDMYDlgnvlzYyFME6cAHtS6cyDZgGqf5pbVQSK46IcToAsZapy
	TcXJ1QuCmQCaW93DXc1JH9nwGSyi7jtLMjBbN72P2zezI9OW37E+nl0//fwNvb0=
X-Google-Smtp-Source: AGHT+IFNetQ1ayTq0+0UbEF9VKAgYXpTLAsierdeBXRAFRgvCcDWNQ3iu5slAt68fWdL/xme2ycSJw==
X-Received: by 2002:a17:907:7d89:b0:a6f:4fc8:266b with SMTP id a640c23a62f3a-a89a34f9fedmr797517566b.3.1725287409734;
        Mon, 02 Sep 2024 07:30:09 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Zhang Zekun <zhangzekun11@huawei.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/9] nvmem: sunplus-ocotp: Use devm_platform_ioremap_resource_byname() helper function
Date: Mon,  2 Sep 2024 15:29:50 +0100
Message-Id: <20240902142952.71639-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Zekun <zhangzekun11@huawei.com>

platform_get_resource_byname() and devm_ioremap_resource() can be
replaced by devm_platform_ioremap_resource_byname(), which can
simplify the code logic a bit, No functional change here.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunplus-ocotp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 38f5d9df39cd..30d55b111a64 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -159,7 +159,6 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct nvmem_device *nvmem;
 	struct sp_ocotp_priv *otp;
-	struct resource *res;
 	int ret;
 
 	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
@@ -168,13 +167,11 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 
 	otp->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
-	otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
+	otp->base[HB_GPIO] = devm_platform_ioremap_resource_byname(pdev, "hb_gpio");
 	if (IS_ERR(otp->base[HB_GPIO]))
 		return PTR_ERR(otp->base[HB_GPIO]);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
-	otp->base[OTPRX] = devm_ioremap_resource(dev, res);
+	otp->base[OTPRX] = devm_platform_ioremap_resource_byname(pdev, "otprx");
 	if (IS_ERR(otp->base[OTPRX]))
 		return PTR_ERR(otp->base[OTPRX]);
 
-- 
2.25.1


