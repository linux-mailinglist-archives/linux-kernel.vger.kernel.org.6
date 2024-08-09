Return-Path: <linux-kernel+bounces-281020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB394D1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08D9B20A90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43F197559;
	Fri,  9 Aug 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lrzxzqAF"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51D197A65
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212968; cv=none; b=JCQ1ZyaiX3BBxOuQkcg2svdSPblzaf6OS3tEWLdJLGsZMHiG5Dz976J34v9QhROYeOkL79wqPqAVsn1HA2KXDS6XiMijCjOuEcXcsQ4kGqlSzYvDWSf3seK+Qe0R6L1M+9KOdtLb2XIUnI26yJI7vEhfbbjnal2HSqc/G6iZnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212968; c=relaxed/simple;
	bh=si420KfCAbUwj7Tl7OeH9FIMAx1kEhyq0ushc0tBMas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laIiFjoWwf14fFkG22m3iltvav8Bnhh3xof2a3jL39yNQ3cbxF5aassRlon7gdl36NX3VgSwEmabFN10Hi0bCP2TpRfnC26H11Bj7nw5wZtOXpHXqfAAfrPfkzH4L67g8Q3noUz9ZiaRAvR8nOhjvvVafeQxsGHVa1JnnOkNmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lrzxzqAF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso21370981fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723212963; x=1723817763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuEBO4wKbN1vPlCMZPv1/VInONtPQvpG32vpeJJnsnw=;
        b=lrzxzqAFBZ4Z5iAz72nTvPLaSTMo3McM57G+4F+drQsZt9Lu+6qJLmBk7UGJBkwJU9
         vAzUetucm9YkPfdY1tHdDbMYTiPCHNcTbQAis3Ug2lcMQcTAzaxjZVVH7LWLUf6FarTU
         D6zRMMqt3mD+ewcDBSnUtvhiuzfv/s8iLTI9ekjO26suSxmVHjeYvugOqKC7g4/96DEf
         eg/9+c5FhPKjTXaKgP9mkOGJCLui7aH+CjWmWZFpCKuO0Ui4jZz6qdwN6iTEQvpFtPWb
         +apLnUSH6qM42kRwVQSeuMAcVxKZR20bYKIUY46UNn5CdXYo9keRHW9gdXvrKbFK/GSB
         NFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212963; x=1723817763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuEBO4wKbN1vPlCMZPv1/VInONtPQvpG32vpeJJnsnw=;
        b=MQU1FPZi9PRB3zML+oqkcaeKI0FUONheNSxniW/cn3a4odNS5u6U6t/39cNARY+eSq
         IJsvpWg5gLXuajWXbLdpYi4zNsfTsviDhEp0VawdYDp/NJXVWRqvrMn6dnsxRLKswt7L
         qJUGcEE3Ie7X5ejzNAlkN1ab2sMgT3SBFBiMxJRar5PkQ5oEH5uFqbHsRONrPp91AT4S
         pCiVOCI4Za794K3gP62CAhTRFwqckOlYbBZTemSj/2uecRdBAhnjkOO+nsz/WK85qHHf
         XeOWrIc1OqN3/N7u5nrh4i9qVVejLB+wegr2krQMyhiC5v1z5bZbP/Vvnd82x544Ji5o
         jMHA==
X-Gm-Message-State: AOJu0Yz6leWiMgQW0Ep4WxXM5ohjLkmnhDYRXxRDf2ETC98L8PvLvYBi
	IQEX1hIRc3WAEnSoYMpmgyrb6UIeBHX2gFXbJuwx6692U6JEnuDnYCRVRD40W0M9D/GaXDhUcqj
	O8lY=
X-Google-Smtp-Source: AGHT+IHVxYZTB3+5C/bLdwl8tmgK2qdlEhZuk6zmXr9zkNR1b9s7hNzCSmnIVjdrgk9ya98wdxofAQ==
X-Received: by 2002:a2e:6101:0:b0:2f0:198e:cf86 with SMTP id 38308e7fff4ca-2f1a6d58063mr13387381fa.33.1723212962857;
        Fri, 09 Aug 2024 07:16:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8289:d6d0:e805:3543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e049sm130484035e9.23.2024.08.09.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:16:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 09 Aug 2024 16:15:55 +0200
Subject: [PATCH 2/3] memory: ti-aemif: use devm_clk_get_enabled() and
 shrink the code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-ti-aemif-v1-2-27b1e5001390@linaro.org>
References: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
In-Reply-To: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=QLCOikcdb83kfBUsdtAVnu7nuom9wFaV6X9ZQKuXYVg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmtiSgMppcNGIE0Wpw0P2Ejq6cXxo2JMWS1m8+X
 rXRS5dJ4k+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrYkoAAKCRARpy6gFHHX
 cnxUEADL7a37jKreuJKSkNeGmkGxP6NSiJXUjqFFgOIEBNBc3LDde9fg4rpdd8f3Am2ELrahJDk
 f69Y1FvkBuGz+ziXUXnKGp4n6OF92iLgjj68Uzna36bFtg9Oz4nt1PmUHuOlj4iADLpOHCFtUNm
 E2U2RhPesW0N5mYY209bdJ/OkqfU38dJC0OyNRoqp1lmobgeFE7VsTq8XX0yJjODbO5r9s3w0gO
 7oLwA6JG4x5KRQuK8LzJ5kd2Th3fCtdkQflJy0+cVms37ned0hEC0ppyjafQSpTOMIqNjawZW03
 GhXrGf7L9KVPyupQC0+jcCHt8AanX+HJifhRgFOFw07sxpKLVIvkJNubxuSbkIX2dn6La9jObf8
 2FJTlKHx48WYfwe/p3WHvR3/K7PjQ68Z+ZIB4O9ZsJxBCYQ87FZyn7FNHqHeJe1KmydjWpOw3aq
 fcBE4szjMDFfNcMEPOxBAwyJAPf8w6If8GzrYGzA4TW1BkaCa7AGsrtpa5a7j5GFClaidslEtJR
 e+3HL739Ml1zNqukuq2Tq9hdfcYNeM6hLDXZM7hRj27LYGSBZflq1fkqNJ4FgagHWTh3cQLuSBD
 El+TaSH31FvVY5iT+jkZQS7mZlm/3JpJ2rtq6gGRkWzbUEy5Gdxu/tAKsPI1zm5CJklLk7DoNe6
 PzzEmLCNMWVkMfA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove several lines of code and a jump label by using the managed
variant of clk_get() that also prepares and enables the clock (and
disables and unprepares it on driver detach).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/memory/ti-aemif.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index b92cab455cbb..fbe0786f5ac4 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -338,26 +338,20 @@ static int aemif_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, aemif);
 
-	aemif->clk = devm_clk_get(dev, NULL);
+	aemif->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(aemif->clk)) {
 		dev_err(dev, "cannot get clock 'aemif'\n");
 		return PTR_ERR(aemif->clk);
 	}
 
-	ret = clk_prepare_enable(aemif->clk);
-	if (ret)
-		return ret;
-
 	aemif->clk_rate = clk_get_rate(aemif->clk) / MSEC_PER_SEC;
 
 	if (np && of_device_is_compatible(np, "ti,da850-aemif"))
 		aemif->cs_offset = 2;
 
 	aemif->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(aemif->base)) {
-		ret = PTR_ERR(aemif->base);
-		goto error;
-	}
+	if (IS_ERR(aemif->base))
+		return PTR_ERR(aemif->base);
 
 	if (np) {
 		/*
@@ -370,7 +364,7 @@ static int aemif_probe(struct platform_device *pdev)
 			ret = of_aemif_parse_abus_config(pdev, child_np);
 			if (ret < 0) {
 				of_node_put(child_np);
-				goto error;
+				return ret;
 			}
 		}
 	}
@@ -380,7 +374,7 @@ static int aemif_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(dev, "Error configuring chip select %d\n",
 				aemif->cs_data[i].cs);
-			goto error;
+			return ret;
 		}
 	}
 
@@ -393,27 +387,16 @@ static int aemif_probe(struct platform_device *pdev)
 			ret = of_platform_populate(child_np, NULL, NULL, dev);
 			if (ret < 0) {
 				of_node_put(child_np);
-				goto error;
+				return ret;
 			}
 		}
 	}
 
 	return 0;
-error:
-	clk_disable_unprepare(aemif->clk);
-	return ret;
-}
-
-static void aemif_remove(struct platform_device *pdev)
-{
-	struct aemif_device *aemif = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(aemif->clk);
 }
 
 static struct platform_driver aemif_driver = {
 	.probe = aemif_probe,
-	.remove_new = aemif_remove,
 	.driver = {
 		.name = "ti-aemif",
 		.of_match_table = of_match_ptr(aemif_of_match),

-- 
2.43.0


