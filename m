Return-Path: <linux-kernel+bounces-346831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857998C977
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42B61F23933
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C81CFEDC;
	Tue,  1 Oct 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgcBB1mk"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14A1CFEA2;
	Tue,  1 Oct 2024 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825157; cv=none; b=dzaPgrwsgpf6l9QrZhcS8ViipyBFsxbpslFkoeeFFckGkVQi59w2b2ePaP8o0zq56+gg/2skfYI4CuHUJTa4PzXWkTFL/Nkr1RyvgTTJdTqECLpdEyubk7TGaniSQSGp7ASmY8XU2GsDSR3GIfwMfM4a1XqQapLz3LwSD3oehiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825157; c=relaxed/simple;
	bh=va2VM1Kx0bEZi2np1B9hWqdoRpyE9ylYPhVmxGhoS00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuxinwHyi1x3fwjzcBXj7suR1dCliW4Ua+r7COHKxUpQVLzI7apsJLk6/MI6i7fCBsrcmHQzwb3yA6hQ0aaxxkXiA38izeGOf4FYrtBDd6Ci8GHR9c0XMJmccZV3b32Y9AC9bIJ/I3DNsnJAXM9BrEcNfyRB5BmduIXmlDAIAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgcBB1mk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d704704aso5124927b3a.3;
        Tue, 01 Oct 2024 16:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727825155; x=1728429955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap2wC5QiwJQNfwy7ZlBVUJpCk6c8LIQbmbBdGbf3UjA=;
        b=dgcBB1mk+2KcnPt5dYVlrVO4gkK+yHwDsvfofICX2Kx6MtorHFCMzficsnGVreg7q4
         y4VsKkTwsucr6JL2oK6wmBvFvj4RtahrHoIcPDRbYAqLbWbjyQC7+SwO+iWrjeAKTr4T
         Ev1DuEvD7qN0hMaNPdpePKbWX6hwDwb2x8QxpoRNG5Lk0OXsc8C+G/jmKYT00wkQ2Qrs
         L6Alc/2mvDzikoMRoHl2fzfZXC9IFZA7XBdo9SpP3pzhou5PmNGnlR4zlpd+DzO3m0gZ
         Sl+IrYnDMibJYf2UbkTNwJ4Gj09rqv7bD/R3GY2wdhsB3cZXyvW5etAQ2Q+pLqIFeKLO
         ejjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727825155; x=1728429955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap2wC5QiwJQNfwy7ZlBVUJpCk6c8LIQbmbBdGbf3UjA=;
        b=uGj3AManoUZyNUMFBa4wJI68xcndkPDNg9xmYU3Ky3imqwhZ0wNVLOTRfYg4oZ8Z9O
         a11qkoPKqpr4JZXSygc+4EN8cQhFPz8skuTO6tHdBjKAdvKr9vnHxTmzeMRLItR4muXJ
         MS2ngIN6ZYSciESF18qu02ll5OUy+7BP7/i31vvcH+Iz933aj12a6Ud06rzx+6ZgzaMN
         mKWM4zVsgXtbLa6srE0WTrHGh8s1f9YrHn9S736kdVBcTfEFifAyrp34qVxkU3pxRkA9
         52RQMECXCkFUFbL/JmMQ0cIdZedO3pLn82FC/z49NReEbiUT8UAhiEMTscJjmcGPVcKK
         e0qA==
X-Forwarded-Encrypted: i=1; AJvYcCVcraJk9AMD1vqf190L+LKzosMcobYMnAbqF4K7JehZ1Y4yDUmWmNQUniB575L4DhTbejJdqk4s99fb6z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3iPglSVDFS0airrKuBIeYp6PMSOB1F9H5VRdBkBDj3bABzEj
	CLe1pLuAtTxMpeQoFEx71YegsqGxOH92gOsIHK8/RbY7cmju0zg2XMH5pl+0
X-Google-Smtp-Source: AGHT+IH3Hc6Qddyg7UCnLzWw1vhPHLpVABqaFDRF9F8dEQ3A48Nz6NdzTE9PHR3Qqx8EkvdKrSfgcg==
X-Received: by 2002:a05:6a00:4f92:b0:718:dd80:c2bc with SMTP id d2e1a72fcca58-71dc5d57ee8mr1646652b3a.19.1727825154703;
        Tue, 01 Oct 2024 16:25:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26539c5asm8628143b3a.210.2024.10.01.16.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:25:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rosen Penev <rosenp@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] crypto: cesa: move loop to mv_cesa_put_sram
Date: Tue,  1 Oct 2024 16:25:46 -0700
Message-ID: <20241001232547.355947-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001232547.355947-1-rosenp@gmail.com>
References: <20241001232547.355947-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler to move it there. More readable remove.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/cesa.c | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index 6098518e136e..3dc74d1a8514 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -416,17 +416,23 @@ static int mv_cesa_get_sram(struct platform_device *pdev, int idx)
 	return 0;
 }
 
-static void mv_cesa_put_sram(struct platform_device *pdev, int idx)
+static void mv_cesa_put_sram(struct platform_device *pdev)
 {
 	struct mv_cesa_dev *cesa = platform_get_drvdata(pdev);
-	struct mv_cesa_engine *engine = &cesa->engines[idx];
+	const struct mv_cesa_caps *caps = &orion_caps;
+	int i;
 
-	if (engine->pool)
-		gen_pool_free(engine->pool, (unsigned long)engine->sram_pool,
-			      cesa->sram_size);
-	else
-		dma_unmap_resource(cesa->dev, engine->sram_dma,
-				   cesa->sram_size, DMA_BIDIRECTIONAL, 0);
+	for (i = 0; i < caps->nengines; i++) {
+		struct mv_cesa_engine *engine = &cesa->engines[i];
+		if (engine->pool)
+			gen_pool_free(engine->pool,
+				      (unsigned long)engine->sram_pool,
+				      cesa->sram_size);
+		else
+			dma_unmap_resource(cesa->dev, engine->sram_dma,
+					   cesa->sram_size, DMA_BIDIRECTIONAL,
+					   0);
+	}
 }
 
 static int mv_cesa_probe(struct platform_device *pdev)
@@ -562,21 +568,16 @@ static int mv_cesa_probe(struct platform_device *pdev)
 	return 0;
 
 err_cleanup:
-	for (i = 0; i < caps->nengines; i++)
-		mv_cesa_put_sram(pdev, i);
-
+	mv_cesa_put_sram(pdev);
 	return ret;
 }
 
 static void mv_cesa_remove(struct platform_device *pdev)
 {
 	struct mv_cesa_dev *cesa = platform_get_drvdata(pdev);
-	int i;
 
 	mv_cesa_remove_algs(cesa);
-
-	for (i = 0; i < cesa->caps->nengines; i++)
-		mv_cesa_put_sram(pdev, i);
+	mv_cesa_put_sram(pdev);
 }
 
 static const struct platform_device_id mv_cesa_plat_id_table[] = {
-- 
2.46.2


