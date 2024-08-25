Return-Path: <linux-kernel+bounces-300440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0AC95E3B6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53EE1C2187F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0F15530F;
	Sun, 25 Aug 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDhE4Y4c"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465798C06
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593809; cv=none; b=rPBzb1nOR0JoEzpHwJLuJ3cz2ar0eGtoR3Tfsc9GOu7tTwxDo7WY62knL8VpkX6jPIorLExdgg/fTMAHGdLPQ4TxW6wDXfGF7BDyjvCmVN1vRwySwZOaoYX5eVlZO+M60v0Esk8dNVBFwmbGwdOPVl7YAKCsDTLF12UsTBdxZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593809; c=relaxed/simple;
	bh=7IYuEojjPznm9/vsb1RhP2UVp3hjpuLjgYizZyhxQqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaWkrs+YLLZedkUM1usBNHwNB3jud1mUpWiwQ2bts2Ih1f/eNWrvoEdRjl9X1kE5pNGvUDLPWd5ixq8loVfet8cv7hOTHLh/DRuGhFwmY4uQbbECILie00qr0QvaKK/6WGSVyaLpVycUqlFAT4sWhZuNScqFpr0Xz2HqudauSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDhE4Y4c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280921baa2so3910855e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724593805; x=1725198605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EF9Qqgl26owRqH1FstKdyvbEmMtUlay6Jv/0hyaG+ok=;
        b=BDhE4Y4crHWRiP/fTMucjBMlZbTrpIQ3M6aI2P7YSCV1d9IyBVAhEkT+4Po3s1yY0v
         eHcX+abGR7XBNr06EdLCv56OXO+W6ow9+cxU6Tb6in8ZtZNkXH6lwKpx3UJLAeDQj81/
         JDWP2EWWk3btblUt8k0/Kvs/euXRUa/Zbaa7eyxrg7bYrWNuUNf/4CJQAXottGom6S9S
         +clHh4vLEl9uGb1imeyrz/y+aldYPDRIVsZdmYX9BB1ahn/pgi6QuhmZQw34hHfndUZ/
         gpl8V0s7jdpvbwbxVKWgUcKkJO24SNvUYYdQJavANvwYxeRAlv/7M530dMdnPsSF9Lv6
         vbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724593805; x=1725198605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF9Qqgl26owRqH1FstKdyvbEmMtUlay6Jv/0hyaG+ok=;
        b=PCq+X6V30T7n+u5U+kix/2Pzk/av0o4IIaK4A9faBjCO5MotiiohR2jQiOaRUxhODb
         O2jONBkDHprBxOmncj8ZQ527DAH9EIUUE8ZFnlIKsnrDuduc1F5Li/SPOionJ7m7THdg
         Agy4fefGsMt47Dc0C19beaO3+ybU8+oBu1fFKgjl1hx/DgGeZ7KhPR00xNGhNr1Ai5Uu
         RHdtCfDEzKcr0SDeLh2A8MkGU57z9wXoItGywQIbmTscMBRrvUxaFb3GBgwiSPNiDGhx
         cjPDaE3T6FvxHP2YxJLqNX712kWzwp3BmdosVSv944QgeUsrIby5QkZjMZPPi+koY+VX
         EKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmS+3YqbmX+Zu6wtEIolVQUGxpAlRv9u9nIlo7jvcHvZ5+hfH3fKgX0KrjLn9c5R82MjeiGCmPiHv5oik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeDS6c5Ks2oZr52wzrSXU8J4k065IN2LFFsMlCapiMrPWmDPO
	apze4TG/PMd9zKFNE+xie8fNl9hNwCf2/lJ4Up/3iZLoBb/T2rXy2mihx/j7rCo=
X-Google-Smtp-Source: AGHT+IGnENfrPvjukEnSzPjhx2HARE0cEYrdN08tvFIdvbOIg83EEt5QK6KAQ4UxwiIxW/204HD2Vg==
X-Received: by 2002:a05:600c:3b90:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-42acc8dedbfmr32194235e9.2.1724593805455;
        Sun, 25 Aug 2024 06:50:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e1f7sm122188365e9.5.2024.08.25.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 06:50:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vladimir Zapolskiy <vz@mleia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH 1/2] memory: pl172: simplify releasing AMBA regions with devm
Date: Sun, 25 Aug 2024 15:50:00 +0200
Message-ID: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset() and dev_err_probe() to make the probe()
error handling simpler around amba_release_regions() cleanup.  This
allows to drop the remove() callback entirely.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/pl172.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/memory/pl172.c b/drivers/memory/pl172.c
index db5fbee34077..be7ba599cccf 100644
--- a/drivers/memory/pl172.c
+++ b/drivers/memory/pl172.c
@@ -187,6 +187,13 @@ static int pl172_parse_cs_config(struct amba_device *adev,
 	return -EINVAL;
 }
 
+static void pl172_amba_release_regions(void *data)
+{
+	struct amba_device *adev = data;
+
+	amba_release_regions(adev);
+}
+
 static const char * const pl172_revisions[] = {"r1", "r2", "r2p3", "r2p4"};
 static const char * const pl175_revisions[] = {"r1"};
 static const char * const pl176_revisions[] = {"r0"};
@@ -232,13 +239,14 @@ static int pl172_probe(struct amba_device *adev, const struct amba_id *id)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, pl172_amba_release_regions, adev);
+	if (ret)
+		return ret;
+
 	pl172->base = devm_ioremap(dev, adev->res.start,
 				   resource_size(&adev->res));
-	if (!pl172->base) {
-		dev_err(dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_no_ioremap;
-	}
+	if (!pl172->base)
+		return dev_err_probe(dev, -ENOMEM, "ioremap failed\n");
 
 	amba_set_drvdata(adev, pl172);
 
@@ -256,15 +264,6 @@ static int pl172_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	return 0;
-
-err_no_ioremap:
-	amba_release_regions(adev);
-	return ret;
-}
-
-static void pl172_remove(struct amba_device *adev)
-{
-	amba_release_regions(adev);
 }
 
 static const struct amba_id pl172_ids[] = {
@@ -292,7 +291,6 @@ static struct amba_driver pl172_driver = {
 		.name	= "memory-pl172",
 	},
 	.probe		= pl172_probe,
-	.remove		= pl172_remove,
 	.id_table	= pl172_ids,
 };
 module_amba_driver(pl172_driver);
-- 
2.43.0


