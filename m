Return-Path: <linux-kernel+bounces-323454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A48973D69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408D1B269CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0341A3BC0;
	Tue, 10 Sep 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JBIhqjh5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6E13A3E8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985988; cv=none; b=IlFW+H122E0UQs+s3RXV55Fl6ZppqEdidR/U4QtpkcIGNKwVTkSj/o9itt+x1j2qT5WecnVDFl7QoAOi4+DSaOvZJAoWJBt5+MjHon3utOq0t0JMy2CgFSu2GgGsAMnCqdAampnaQ91xV8anU7xM9sRsWTLHcYCqHptMGaGgvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985988; c=relaxed/simple;
	bh=TBFxeGrFtyl6fNkBC1RzGGAepksDKxjvf8LT6xC71TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLNY79D/tddjSrQNui2X326K76cCA2pucb2Gln1gnJ9TYH0Ykpa852GrvvSM4WVm1R17qeGFNPeVbMrty2qzgjvdGecfR44aN9SQbqTqgmUyHeQllW/p9Cjr6OieyDEtGH0Z0ejgZ/EzItw5gEKFJvWUQUIWeP6gEsTVLiHgi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JBIhqjh5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so22006355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985984; x=1726590784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0U3ETN12gpBLws4jxOpUFqH+6wugx8Wdm0xkOdNhP8=;
        b=JBIhqjh5Du32dWdvK3g7k5yoq1nO22IwYLcr0w1E+8xNDuRNJFCD9SalTRFfSr+Dk5
         NEJqnSvfKSQTPcKmI1/RzFTheUSZilPDTrGHgcAHewKIm0fcMQDEuSTH8tDbwLVhuKvb
         p/6hEQz9/me5jUJRxyKFI0f+P7E88dszxTHsXTX9hf5G0UJOGY6yikdbIjsTj2QZ8Gcp
         jXkE4QsiepJ0kJjHpwnxPMtduEPSkMX9YYPIBZrPbv05tsK/+DWA0+KSO+eg44Ezse2E
         pV5uo5VZRs7nCl2NevkXfAnVodYbc9S4gZD3ExDzqxw+UkSGCNV8/1E1arjYKMUA+TNF
         cYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985984; x=1726590784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0U3ETN12gpBLws4jxOpUFqH+6wugx8Wdm0xkOdNhP8=;
        b=S2UbPG6IIVYSZKEIp76QO5jQc4V9AH/U+AKZdovHodDio62zaF0FczphiIeHVC5fTO
         CiexxkuMMl/PZ8i/9Aw7475bLLFHkpi0XhKr6yotqy8KCScsDk1gMHGjx8M2ruxXxNLf
         d6lAVnTTetC6WMb5giM0lCJ1Kl0Kmn8VemvhdQ6GMrP0mr3t8VNgkYtp7ytoH+0m1RWd
         ss/IMUayl957S5d4fHTd5nCzFF3PwMCrjyXGh9koAZHk72T9fT+CrONKRNFwXUkyHbzk
         lxIoO97OXc6XcT+6l9J6UTDrvj/mncqaSSBRUDzBqPYLO2im6tW+0/kO4CmA7BXUMk74
         Ovdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0dL948hAFmOCTjfiEhVEbut8ujck3Ca94RGTrjA5mmRMt7Q4on+oiJjvMJb3oJFxtOOPWNrGKMYNAEfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPh7eZHC3vzMwYQZfiBNxNKc6Pk2qUaFD9PPu7XBQoRIfyAAv
	2G0aG6dctSbwOhvmmyDmglhH9NpbC0BitEldLVN5OjwiGfCkQkw3rsZLDyWnK/3cPZERHpTYRFM
	f
X-Google-Smtp-Source: AGHT+IHShZC5ser6whptXqE3MziINpbjBLNBW3nIUDCuOdeUJAsHeKnZjihpf41vXmHzwdkenZA7/Q==
X-Received: by 2002:a05:600c:1ca0:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-42cb99524bcmr46920325e9.6.1725985983707;
        Tue, 10 Sep 2024 09:33:03 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:03 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:44 +0200
Subject: [PATCH v5 2/9] reset: amlogic: use generic data matching function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-2-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=TBFxeGrFtyl6fNkBC1RzGGAepksDKxjvf8LT6xC71TA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS1Tkc+OOhDTyGuf4iOz47SD4YGoUz7E+CiS
 j9zs6E46TSJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0tQAKCRDm/A8cN/La
 heo4EACaHd8VKcIzQJwErNdFqhTeL2cOA+CG3ICx/ce5La3RkdLGPTaHDUhm3zbPRsiJD9yjhDq
 h/cSnJ9bJlHcZq1G8m7oLngE5vcTT+m1hRv2I4qoFPXJBdv5/UceUHfpAXOhEURdAVbGLBNm27V
 N4l0Sy71IZ6tzRTbH+upcUJ6Kx9CzgKthfROp1YZ7zD48S5ISB20/G6n8pPfmXETtlzRNqgisOm
 B1fYBxPUAlBBnEtiXYzcNJmfaCo5jPHevgij4uwrsie185bk1AFr3KaDGGPw/LNEOs/RY5XhzUD
 YOUBpGTjZChUJtfyOr3z1WdR5+yqgonHq5ZLr7PvZrDjbJ1mY26anrHktPP0tAlSmle69BZbNID
 wE2ahBPtUKhUSBkpbDpG8FqzLe7rU+frCKzvt5XMYfoknEwpFIoHVYamq1u3p5MkThrMe4P52Ug
 z65bOHFHwfvFMcKNhxzOoKPA/LjGlaccL3z2/p8iN1CNzAztFKOYijwJ7eAD73YYNe4SKj3CcZ3
 /MnmvxyB/4wg1gQcPyZCQVzdEtozcDAp1V77yOuDntw53GaXCaMGrViwCt3xxsiUL4+S8TkCyuN
 p5X7wasd/QoChIDLr/pf4jHpOzFtzOiiBO4MqvFz1cN8fH/QmIf7F0WsK8muH1OOvO21Vo8QYll
 3Xl8IjLdwY50hfQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

There is no need to use the DT specific function to get
matching data, use the generic one instead

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 9dd38cc209e2..848c2d88503e 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -134,7 +134,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	data->param = of_device_get_match_data(dev);
+	data->param = device_get_match_data(dev);
 	if (!data->param)
 		return -ENODEV;
 

-- 
2.45.2


