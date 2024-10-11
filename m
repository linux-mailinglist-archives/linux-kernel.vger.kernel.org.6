Return-Path: <linux-kernel+bounces-361168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2052499A489
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AC51C22ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0B321A6EB;
	Fri, 11 Oct 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd8R1O43"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472D219CA0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652181; cv=none; b=YKRKBdnhjQOg/+mmnqw+53jPSUJfb7KgNogyvLvC/+A7VEioT0SWNQvNuXs+CH3lERKrIDzP8dZbh2IdBazG3fCB5G0ehqle15m/A91xZsck/nb9BlE/oPjKR3Ife8ouIUqK/5d4dn3Vc3vrJ0eMdySP5WUCL6LEXSkcluL6pS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652181; c=relaxed/simple;
	bh=7kdOoNfMlZbYPfmRo7BU7gqeehZO4mpSsH4l4kVhdVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOpAmgPWjnqZW3Mcd6G2ImSUwesAIzxQt7pLl1EM/iBSajfc98cfVclbEdiWieiC56wy5aJx2AIdyGDCpG2LZ0lcxMJtIUSwIvsC5eG5z4Bj4SaLAAgZyerB48n2EGuc7oXn1gtfQh5zsSSvhhqa730zRdMyBlUItopQbTVHel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jd8R1O43; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43111bdd54cso3270525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728652177; x=1729256977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1REIJgEpdIx863Xckau1T4eHu3s++vgqgq7X+I/+RaE=;
        b=jd8R1O43/eJ7gUCFXMpAqfNeHj7nZuQC6fY3b+XbeN2gg+95IERI55nv2DdQiaQX7z
         XM1ZH7ucZpcUlIg/1e5lbCpoCFosP+YaenJFN5+uwCL3fkZU69sfpQh6MV8HdRCkO2lW
         yGlgkNWkZHKSIT11119pSHuEmYrQji9ruSHKNsRqsZfTZhEB+BbUfURQ3JywM7Glr1ae
         alfdDbY+I3z7bDAWDvch76FLQuyrSTt/i73WBUx2FAmAadz+YP6I3dII/BL/vYQdFRhc
         ctmQPIagcLd+bLDcZgaPB0oSKbzum3TvJDajLkFwG4jNGtzHO3Jn+fXYs9v9H1XVN8M3
         yi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652177; x=1729256977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1REIJgEpdIx863Xckau1T4eHu3s++vgqgq7X+I/+RaE=;
        b=ThdhoMKAP9NAWAT7yZPTtiguChCrw25xim9mBRlTpR3zeg6JiDO0A/rRmbN+AD6AaW
         nzlUiBucP/gjygHCfTZI7mYdVzWPWZ4Uw7WmVFw02pFV0bMRVxpjRJ21VSF0LD8oVAh7
         kexSx3DpXvU5zD6jDs6u7p+ZYBNPQJUxNV+TohsUW0nnsnzMYy9NwvzZOgLHk5DhgnMJ
         vtjGZ+lxjuwyG9+iFCg8Ifzecx96Qemaj3ktdC5NE9JtoAvsHvMXhmPvBONLFfjgYDx3
         TDzgqi0tCmA7YRuz7as5m0ii1LtvPO9eNl7v0aZZbi3Chm0g9JRGaEKrPLAsBDCDwEuG
         zShg==
X-Forwarded-Encrypted: i=1; AJvYcCUFc8zvLnJOEZuHRC4+cJICssh2TYf4KtzRRuVwPQEvIRXKVnMhmCU9aJ6SorHL2TonTvJfFZlDLN8qs/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxelvpQoisIhg1MJ0jIMJTXKmYrGAApAk2TUpuVri4wpDIK7UeY
	ar/QMuRp9LD/dDSVZyXhAP8ON0PDbKXsNfC5bzyKCMOdKwRX3ae48SuUruqA4R/kz4uzoUnwkfM
	c
X-Google-Smtp-Source: AGHT+IEEkKY/6b0TIyEQcSfAmiz8qvdUcFi/UqnhV9Vtt0lRZyZBwwpEnou/+4xo35nG5z92Ey7g+w==
X-Received: by 2002:a05:600c:4f85:b0:42c:b995:20c2 with SMTP id 5b1f17b1804b1-4311ded2070mr9874195e9.3.1728652177461;
        Fri, 11 Oct 2024 06:09:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm41621835e9.12.2024.10.11.06.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:09:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 11 Oct 2024 15:09:13 +0200
Subject: [PATCH 05/10] remoteproc: qcom_q6v5_adsp: Simplify with
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-remote-proc-dev-err-probe-v1-5-5abb4fc61eca@linaro.org>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=7kdOoNfMlZbYPfmRo7BU7gqeehZO4mpSsH4l4kVhdVo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnCSOChz9N3XKg18dB5jGjrrzdkT0/FM1v/WZMT
 Mg/6ZCzNRqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwkjggAKCRDBN2bmhouD
 1+FCD/9OQZ35fwISw9kTwuj+H3KepvqgGpP5+XA36+ilYkXTMPLj0c8xqbs5Vv3xldDmUt3SMca
 ISqxeZnjELmzQt1c2kRIgqC18EevRbmZ7KUpqCmUTauDlE8eNewjUE9m19j3KxVBHr2Msd6apKh
 e7SLStsvyoyXsodwnvkZSxhV8zHmnDF1nO63PsiC1LGe54UyuVpEaNLPpHibzBYfr8rA+y3WYZc
 sh7ah01pZxWqhkcVPT0gNXxw/qmK23S3XLmSALGiYtv1yihK7M9lpLnNWwIYFa6Wuo36FLt1jnn
 oi+0WApEy+FC6cv9xsofkNZqB2PoDhbiC2XV5M1iJknbpuggR5i4Zz/pDS/yRLF0OgBYrlC+oRQ
 PlOzdyyU+STDh4JsYs9FFdovbuJ9XfQ9lENjKzSv8wq+anNdJ+RWMqjpw9Q8GtsgM6m2bQA1RN+
 m89NyKVOm/0mebqd9uc9FZFDgrIzY80Yjf/yEwmnhkMvzCYVX9opp6GFuc14tAdmK9waz+ioWAS
 0mR0vQXDJYc2bHnV9hpWA3meATPYs9DZKvEL5WBm132DeMx/R5gSpNm0+7uxMGaVzwlDCFkhcot
 q31hXet6OCV8BJfL1BqcX5vJIo9MNMu8t12USNKnSwPklLAMIKVsXZe6yjvv0UvTMmTrGHh9J1b
 879wxj+/Q86VILw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make error and defer code handling simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 572dcb0f055b764f36d0da7c851dcc707bb5ff6e..79dfec517d38980e05ef0196138e6f312c84511d 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -534,15 +534,11 @@ static const struct rproc_ops adsp_ops = {
 static int adsp_init_clock(struct qcom_adsp *adsp, const char **clk_ids)
 {
 	int num_clks = 0;
-	int i, ret;
+	int i;
 
 	adsp->xo = devm_clk_get(adsp->dev, "xo");
-	if (IS_ERR(adsp->xo)) {
-		ret = PTR_ERR(adsp->xo);
-		if (ret != -EPROBE_DEFER)
-			dev_err(adsp->dev, "failed to get xo clock");
-		return ret;
-	}
+	if (IS_ERR(adsp->xo))
+		return dev_err_probe(adsp->dev, PTR_ERR(adsp->xo), "failed to get xo clock");
 
 	for (i = 0; clk_ids[i]; i++)
 		num_clks++;
@@ -708,10 +704,9 @@ static int adsp_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = qcom_rproc_pds_attach(adsp, desc->pd_names, desc->num_pds);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to attach proxy power domains\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to attach proxy power domains\n");
 
 	ret = adsp_init_reset(adsp);
 	if (ret)

-- 
2.43.0


