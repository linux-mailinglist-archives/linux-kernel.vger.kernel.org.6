Return-Path: <linux-kernel+bounces-402180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F39C24C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490091F220E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715A71A9B4F;
	Fri,  8 Nov 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KkSGG6LC"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D4193075
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089914; cv=none; b=ZXp9FS2ZV856MO0K9kQNIIxfWyuZcI1YMNu33oisukqL/TRjiNHz46iuHUklEFsn2pMOEv1mrB/wAJvlKDdKD1BKWNG03lD4CxqJBCB7zpTrVmfn9ptHDe78OGzffDCOl+p1d9LOlywwcltfdpAa9EJcGNwUl/EcfCuke9mxYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089914; c=relaxed/simple;
	bh=Soo2G8t0NXA91E6oudkN/8/zcOyCMAVec/Iwsw0h1+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VddYmE/Cq5aqh22AUxZ7bEpf2scJWIai8VY3uwV1r/iniN9rhZ4x4uPvcjxes16xhvriAxvrnVzFawVfWu58xrRmNqsG8Jn2xjf8EzlFsm8bTGiChKFV9HhGf2bAepnzo+/TZkIjc9J4Q0v5riOFL/A6IMeDSuQmGIZz0TBiY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KkSGG6LC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1668555f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731089911; x=1731694711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKwWHSoHSIifyFzb86cJwaB60HH9m4ZFRXwirC1czF0=;
        b=KkSGG6LCebY1oSfqXpno0XbYRioEY3Taxh0qH4KkNWd5HN1d8zcIxBMzDveRVChZ8E
         WyuktUBMPiTjhsps8+8WhmCSJ6kaHBAPkcswtbGAnoewogl73yPNFJeVYxdJ4sV1Wqs9
         buOz+T6MtRnu0o305ZA5svjjmW01+WwP0favFqCMPs5/rr8wqFkhG2AmmRc9J9768976
         yjjIUIOjEteMpjrbPTCkReugayEy1/6r1RgV6JGh1EX3U2qHY/liFJzAp/QuRuJwBVAm
         rUX6Nofz+Hmb0Jm1NbsqiYQF/r+BFUjU3qZgD2ImTgDtAOybdWVGo2dQWFUMCgQXxfST
         TzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089911; x=1731694711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKwWHSoHSIifyFzb86cJwaB60HH9m4ZFRXwirC1czF0=;
        b=LvMRizEY+8tOPAIGSr6WLY1jl8tFfdorAVmR4Uox438o9QlynOOmxpx7hcrMaGjZRq
         QyB8qtCL53Rib/hOTl/wUNztfNtnpkJo5UEnw/J+83NEaFmqCCEDhhrmYJjwr2M6YKSG
         UE+xKw03Xp4yw0Qg+VPJ2dJQl9FmD3VekkoH7E2t2ci5hKy8pOBImcVIQsygpmjBF8vi
         Jd+tAOL8sZ04kHanoZg/CH4EM6nOB6rZmFgdLQLAjaEj3Q3Zkh/qIMGaj8DR+Uqw8M3D
         AaavcSme5UiM96mXjQjVUG8Kn6GynJIKDKYcer2gS2iFZmS2iHsMx/a1+lquBUx/xZJx
         C9NA==
X-Forwarded-Encrypted: i=1; AJvYcCVL401Nf+aheOW15/NYeB4lVMS4J3sKST5hNWWAbLST3TuWsf0MkUftRS/CHiwbWGdirWDG1LABxdbPH5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIA0PJLK69E8u6LGsgpT/s5IUcFyJvadbPznqNqtpqFK51Xg7
	4itnES8cwyqPh//vq2by785pBst+drr2s0OZFdf4scP9tjRdth9y/y7wDivaGkM=
X-Google-Smtp-Source: AGHT+IGSpDqH97Zn1Dmtd467QqutJspx8KTRaiYZdzeH8N44fqSgGAXax6raoIjtA7LDz2vx3qjwVg==
X-Received: by 2002:a05:6000:1a88:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-381f1852b7dmr3194234f8f.56.1731089910967;
        Fri, 08 Nov 2024 10:18:30 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed999fe3sm5657580f8f.57.2024.11.08.10.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:18:30 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Mircea Caprioru <mircea.caprioru@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than the hardware is capable of
Date: Fri,  8 Nov 2024 19:18:03 +0100
Message-ID: <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Soo2G8t0NXA91E6oudkN/8/zcOyCMAVec/Iwsw0h1+w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnLlXpmJ0lJEmiWqTBrsESFZ+QOszQZeRPiqRFs xwnJpbFTtqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZy5V6QAKCRCPgPtYfRL+ ThMOB/4+/mwIxOELrrydszzv4QMeaB88bzhejE2A0B5eLshyaWjbwkJAbROsEFuYfgDgDDmzoqV cNttL9o4cfxm9Tawe6idTyFXMglZtKhrS7oDquIE5X/+G0NITudDu1NRExqnPsuOtX5xiW8COge WYjaRLjxn1iE/SbxrwjvoVrBqJl7JysOWJ02OxlVEhYXNeQYIaDzbmTeJl86aew4p91KGv26sZe prl1V6Gs5BRKWnWRelkAXN8idyRFIV9UT9aK0cHhmOmxv3SvLZoJd+PGnAlVYpr3vNn5u7TIN7j rWwam3yGnAdZkx5gnNFnUzKFdiVS5l09B5d7kWiZk4pZG6LG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 and ad7124-8 both support 16 channel registers. Don't
accept more (logical) channels from dt than that.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index a5d91933f505..7473bcef7bc6 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -18,6 +18,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/stringify.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
@@ -821,6 +822,11 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	if (!st->num_channels)
 		return dev_err_probe(dev, -ENODEV, "no channel children\n");
 
+	if (st->num_channels > AD7124_MAX_CHANNELS) {
+		dev_warn(dev, "Limit number of channels to " __stringify(AD7124_MAX_CHANNELS) "\n");
+		st->num_channels = AD7124_MAX_CHANNELS;
+	}
+
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
 	if (!chan)
-- 
2.45.2


