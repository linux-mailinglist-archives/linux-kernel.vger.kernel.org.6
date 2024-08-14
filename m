Return-Path: <linux-kernel+bounces-286271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887B9518F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67611C210A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F21AED53;
	Wed, 14 Aug 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aci/GkLg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC81AE864
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631764; cv=none; b=EXAztCDa6Ee9GJYqlrvK73BO+BYwVa9tLklDkpP4fpL3G/TRm3LL76VSysWg8Xhl52AvtyI5p4IGmhClzsjJya0rQxkrh1f+mG7ncQ+TKOf9hXRmMKIps8cOXKdWTT+m5DrsuXQ2kz6+lWKU25o7AjT32YNnxOzLyKpsFg3rnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631764; c=relaxed/simple;
	bh=TFH+4tMh9QXGQRjmYFo8ohxscUnzlx/tT6fY+TrZKG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JK9ajYIYmW/HmGRuBjhotUrfHxQJi3NAG0Gov7cw00MtbKMmiyanqQnLp5e172XJ2IcXDNk1CDiNXKwmX1KVcqu6/xFLdpg713iJkeZX/qWZjjkED7ld8y4gQLXwecdj0MRxKnCZgOfbQhLQFsf5ntXSFd7ym492HWbIraHfiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aci/GkLg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280c55e488so4374305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631761; x=1724236561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TblL9Z19XAohhrkaXRX6MPVRFbSGmMy0aOK/sLyoZUY=;
        b=Aci/GkLglsgkZBeF/e6ZucK/IkNsYC5nUK6dXlHLjrhhASQ04nf8n8W7JCvo260CAz
         Eded21pDhZZeJsRq30oWP+OltwaFSNsks638jTwW0M3nYL26/pI0v7STwgXpamRFjWOP
         MewPSbV8OVIWx22byHJJtiKOGeSswNxFxdQBuIFlVsnk/hBarGUAsO9RC4Pd63PGhYB1
         v8jF08hVFwbgAf0SWaaMRRWFRsl65H52OSpdKbphMCH11gbxChfOinYcAtPxFN7iESLN
         ooTsCYmaYKW0zYtoaLnDMeuP5+FtM9aCedQVLoIxnHoi/apVNFXspFLrm7sR3ZzHiMDo
         ECKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631761; x=1724236561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TblL9Z19XAohhrkaXRX6MPVRFbSGmMy0aOK/sLyoZUY=;
        b=HEFAGoAtJ8PoKIZgbINlr+xK9Qw4f79uUtBLXnI1+M+Er43CvGELwSTPYf8NPrsKj/
         VqIWacZfxQiW9WJssECSgQ51+AYHXbhBADxLw7I6AXxJdRyCsmniStxIZn2fRh8pgpwH
         SQZbKuoeceJ2YvWEAU5qO79c+Wl2/Q+qw030oF6eMyijObjV1/8Jc1mKmuLrq3dKXtr0
         gSUJRQynNR8hxnlqNVRp4gpWw9u+qZKP6pTYsq6rlsSUW82hbGqwWgLM8nJakp7mYCpu
         g1NUBkgVmIors877U7+ibf+9DTstpmi2LJEI/Ki+RaFcZFGcfsL+/thoUbX2I4kbZ09t
         qurw==
X-Forwarded-Encrypted: i=1; AJvYcCVjIZdZwKctgSvFkTF3rnIFJPazeCV0hDYrWk1xsAtfDrqm0pdURdsZmYs/PMtfLZ2DOKU9evnoUxzFVe8wHUntvQEix00ZiPo09QaA
X-Gm-Message-State: AOJu0Yz+SApuK+WKjf7yzbxTQrXHz78p+7PgJaEECCiYU7Xof60vdu0F
	TuBSpT8gJoBhJqmfE+VG5euoDK0tH5drZOuTsKAWjeV+ExpffHA4Lzwq6td74yM=
X-Google-Smtp-Source: AGHT+IEdI2fPfqb0zb5Eip7GDLT8WAfJbIcdmN8zHY3NjYo91M3bh3D1x8MPYOeryuxOSX6c+LjblQ==
X-Received: by 2002:a05:600c:1d24:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-429deea537fmr12997075e9.4.1723631760814;
        Wed, 14 Aug 2024 03:36:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3dd4dsm15501835e9.29.2024.08.14.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:35:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 12:35:39 +0200
Subject: [PATCH 03/11] usb: dwc3: st: simplify pdev->dev usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-usb-v1-3-95481b9682bc@linaro.org>
References: <20240814-b4-cleanup-h-of-node-put-usb-v1-0-95481b9682bc@linaro.org>
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-usb-v1-0-95481b9682bc@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TFH+4tMh9QXGQRjmYFo8ohxscUnzlx/tT6fY+TrZKG0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvIiBpIEfWgrpGhUt9gg7zd995/w3Rni7GrFxR
 QazCeDTFx+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZryIgQAKCRDBN2bmhouD
 17zZD/0V53NfF3yWdAvXnXh9hLWejd4wiyYVZoOefkdRoPhetU8Jcy+fHjQkGZU4coKf887uX4D
 qxp1eOBcED60oYovUPtNMcWgdN2v2TLhD0nQXSs1mw8JEFMcU8jLv55XMbqDFW/aA1nWpXarf8v
 KlkMX8r8WCtVbyuSB2W4SDaI8R30CrirvMy2wKtQcJZ3C6VqL0PLkc98FMzhb5+wJFMduDa01XT
 OD+7AzldNfiZ8LzG6lcZ47D+qCpN0PbiyU7yvYPRS7CQS8IWdraUMQxP7hd3Yrp3SFrJBEJj8V/
 aU/nNJRnFnGsRK25n0BaTXMzHiC7TU7AOICyfIOdMUTNoeggWHly6QWkRs/RopjIfKmX/4iEi7m
 Ta6A7qon1pCJah8PkqlOTtHyPS7h7HpT2AGfCCbDrHWzmGp7HJb10yEEM+tPXxgYTxiGsCeGBRu
 w8WaYcC0S/Ss5AtqbKyGBlOAHTPxYSA2/7JqaP5hZ0DvxiotsGm6Xaw4ZeoY8auUnN4TbwQXay5
 oZTuUhSkVSBZzc45PE1U//rJeLfjU/xFP8XRNCGFAD5w41C750Bb+SyQlDAcyoz5gcmHuuHzWi2
 STH1qG7JRIrLsCOYAmiyA7hPfbtGyv1nnPRXiCzleDha0TkfUq+1dhACtnEdjGuJdCgwmYHhN1K
 HTKH+VGcd9JStdA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The probe() function already stores '&pdev->dev' in local 'dev'
variable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/dwc3/dwc3-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 7a0b1821768a..2841021f3557 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -225,13 +225,13 @@ static int st_dwc3_probe(struct platform_device *pdev)
 
 	dwc3_data->syscfg_reg_off = res->start;
 
-	dev_vdbg(&pdev->dev, "glue-logic addr 0x%pK, syscfg-reg offset 0x%x\n",
+	dev_vdbg(dev, "glue-logic addr 0x%pK, syscfg-reg offset 0x%x\n",
 		 dwc3_data->glue_base, dwc3_data->syscfg_reg_off);
 
 	struct device_node *child __free(device_node) = of_get_compatible_child(node,
 										"snps,dwc3");
 	if (!child) {
-		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
+		dev_err(dev, "failed to find dwc3 core node\n");
 		return -ENODEV;
 	}
 

-- 
2.43.0


