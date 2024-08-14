Return-Path: <linux-kernel+bounces-286203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE839517E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CF91F21666
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A84D16BE1F;
	Wed, 14 Aug 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojVUnHrf"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C55166F10
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628406; cv=none; b=Atje/T2bSrvwnoqnGxup2ptF7lceItyRuCKfBHoviXbz0SqvfYyWGe9MFu66otbzLPKDaIj/4/ZX0I2eVHjtvNGbx7Vo1+ihohvHm/XiTph1kr8z1I6qbndbcn4gVPO8exrhq8UNDY9jhUuDH5/hTVC+sfMnMxe2MnYWPX9SIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628406; c=relaxed/simple;
	bh=6Hu1M4Pivk4SN1qDKdBZUfJZLXx91ytTpMSmo2rqxTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBwcWb63oWK9RDAvhav2lL7mEp6biFLfYFMAA7O6BEJpIAxRu3/PwlQrimGdpYCi0GH5RfIw3jvCF9AYTBYuTPBbvUUUceZp2g0kR7t5FtI5HBPnw5JKo8oCPctFR7udZUMiwcoTA7qMR0lbr5XYiXbmcMtPhH6DGUBIhBJPCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojVUnHrf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so69452161fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723628403; x=1724233203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGrgEwiDQnCrsN02sqw6lNl+tSbCrY1oNE/v488RmdI=;
        b=ojVUnHrfmF4XdE15A5Un/GZflOgRBS5yfflbArLX0XThGkVXbb/F8Ed5tGE4a3kPzQ
         XJFSVvR5xxzgWO1jI8AqNC6S4Dq18gc2Io0mDNVS1YPhd8AgziOILYOTu/fBgm03Apzn
         S3P5NrrmmQUDgAEBWuAgLj+p2TWcYNYMUjXGqZOLICF3TC1K39C1D248B9f5PsZHmMFi
         4Shs8L8YmnzehATM8jnACeEZ2ilKdnWIBnXYHZjX0q6/Py+XgBEDrdK3yKDW86VbLFe8
         RdW3Dovr9dwHUECoeyhrxJW5XzG+4wcRwzCjBkv8COJEO6ZeyFJzCyJRQApYJdBspFHa
         G/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628403; x=1724233203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGrgEwiDQnCrsN02sqw6lNl+tSbCrY1oNE/v488RmdI=;
        b=FkZCbLuy6c4JGQVd3S3AlyEJY6aGEGxn+eFx6aB67indm9rIxT+vHI6VaZzPUiav2+
         XiiREF8t1N5IzoBN2pC+WS7qT79Q3cz6lglgt653uvZfeweP6YseBGkfYzvzstuWlBXe
         nzuXkvmTYeGfQmMyQVpg9/Rx8tlBG+CINHXfLVngq5IfoqJvwsbWlIkGtkm9jABijH8g
         4E7frs6gOzFiaklJk9tk3txEC0/DIdDeZDOxrBsDoqo7wWWP6TV3KeJyhTqECyqNCKDA
         u2ibhUD+jMOKNzLKp5kVOLFrXM01Uv7zhjyyWmJa2fU8cMktmv0YkA4f5nD0BtmBqlX3
         xITA==
X-Forwarded-Encrypted: i=1; AJvYcCXMofXM8zGRy51Jnk92VaosYL1tuoAIlocm9nq3BdSaVN7K2YvdFdyEEpo7OcfLHj6ouQlmPEAjIO77q+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYtW3OG1b8Bc2rdsaiaNAhB148bQEwUkYpJhaSMnH6jtsR+u6
	9OQZ7HW7eXFIU1Ws5D5DCyncmA6TL1GeRWixltnvdYUvZXBp+k4bZfNCQfOcyEA=
X-Google-Smtp-Source: AGHT+IHrsSXMDzPW+YC1yMSEObvTKIKA03QKkD9vhWlsmxjtI4DSdraFVWhJ0pwmrnCg1VCCTAW2Bw==
X-Received: by 2002:a2e:e0a:0:b0:2f0:1c7d:1ee2 with SMTP id 38308e7fff4ca-2f3aa1f99e7mr10852261fa.41.1723628402703;
        Wed, 14 Aug 2024 02:40:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded28cdasm14195615e9.16.2024.08.14.02.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:40:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <balbi@ti.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: dwc3: st: add missing depopulate in probe error path
Date: Wed, 14 Aug 2024 11:39:57 +0200
Message-ID: <20240814093957.37940-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
References: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depopulate device in probe error paths to fix leak of children
resources.

Fixes: f83fca0707c6 ("usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Context of my other cleanup patches (separate series to be sent soon)
will depend on this.
---
 drivers/usb/dwc3/dwc3-st.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index a9cb04043f08..c8c7cd0c1796 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -266,7 +266,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	if (!child_pdev) {
 		dev_err(dev, "failed to find dwc3 core device\n");
 		ret = -ENODEV;
-		goto err_node_put;
+		goto depopulate;
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
@@ -282,6 +282,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	ret = st_dwc3_drd_init(dwc3_data);
 	if (ret) {
 		dev_err(dev, "drd initialisation failed\n");
+		of_platform_depopulate(dev);
 		goto undo_softreset;
 	}
 
@@ -291,6 +292,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc3_data);
 	return 0;
 
+depopulate:
+	of_platform_depopulate(dev);
 err_node_put:
 	of_node_put(child);
 undo_softreset:
-- 
2.43.0


