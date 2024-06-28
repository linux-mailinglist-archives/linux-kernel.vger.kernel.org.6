Return-Path: <linux-kernel+bounces-233359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B1091B602
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAEA1F22D83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22D3C08A;
	Fri, 28 Jun 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WP//koJZ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD04436B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552031; cv=none; b=jmQtGjdBA4t15AKa1rQRXUeo8CJVmmAyK3dvYsEGYcbEKOyJRsv9dFg0A7L9bFzNBQWr5OdDMutIy7JoC1HZPgoMn4BUqWYmrRMDzGOl8XPiCysQ/l1s6JRnp+Arc3aBRqaBuZGI0l66+sUuCVQ36qDYnIKdUQ8cbYMTHcPF7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552031; c=relaxed/simple;
	bh=FEeU+ilaz87za6zCPoFOaXlZVVMvh4npbKUCi8WeMY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJHxNPokjk7J/Soyohy4wY2TtYmz6SFYhBye15pWydVNnTcKZIoQyAa34nfBo7mbRf4aWjF5IVSHP4zfRT6AyJWOjYhzfkUxMtuxtqfRpAr57mIEQSveHYA2USJM8LLzrxOlibtEQc7OBTLAU4FN+9dVlkzJxcBVrx+OOKwGx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WP//koJZ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so176660e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719552027; x=1720156827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE116OZhrAVtMTDLnoQyRJAzaM6771HphQwBOF0FA8Y=;
        b=WP//koJZyAchgYrt88VAsD8Auu+edhF5AIqLLaU2a4PKvA3s9+GXL4lTOuVFAwmF9c
         dbJHJVppKko10srTytpdn+CB/yuToyM3BEREGHbMHi7gx1Uqlqx92Ngre/uUEcJNEdqb
         JlWaJvCgi2WTZ9GiQ19yGcc+vbHRJdBUqnenOhnaZK7zQcnKopl1SIkcuvEJJbCCU2ux
         GNMprBX1veZbgOLa/C/CAIb6VABhq+yFZh54j9zYUCmrBRqLrtvyG8+NMA8vZZI54z7Y
         +V38fjTc7coHKM57QQsevGH1Y0an53HLIMpR6HCj2T0ucYSjzh6xuQz8h0nuJEbu1Scy
         z1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719552027; x=1720156827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE116OZhrAVtMTDLnoQyRJAzaM6771HphQwBOF0FA8Y=;
        b=c988Bly2mEo7jYWdb4GjGK2n2xlYBjmIDql7llciY/KJvPKx7brSN482QW0zZ48S11
         AAc+Wf6TR4RoKaAt5ByHNS9KbS3704U94ZujzhR3+H5WCobqzo0TBAALcsXshBOK1VDm
         LAMp6FJCMQ+1vd1KlkNrl7fYPpZr/S1+TIGPSCIpBQKq2C362oeve9wMkXBNh7p5e6lR
         VPpD4beLseyxGAwdJVSUQz3+2UjL3lSd9NyXSh7GCenA/KHuMUEUfZy6kG/tIWEVckFx
         jR7nGbSKvn622SZz61+uXQ3C1TWx4i9hw9R1F/GAQ83EWombggeoHDHBbab9xxdXSbeY
         7ZRw==
X-Forwarded-Encrypted: i=1; AJvYcCWzAt1/fEYRNa4znYgvZvVIPI0kRTlELDkJ42r+7C/wWpSUODjAB8gZaRlYL2HJSp0Epyn+HZPvrBZ4qc5eVxWRAItXQoxZXulTVzma
X-Gm-Message-State: AOJu0YyhbrpCscXeNulXNATdbxuDDbzX5vF7AMvOHgk4hvrCpgKdgnuq
	iWUcugavvUF7+MmEw1EDIX8qtMP0T8h7xBEvqpp6nUC6KlKe+TT/ggu6U3KSN6A=
X-Google-Smtp-Source: AGHT+IF4eRuRBZixOvQGuZCBjBcZCcjgRAouzf5T2iMOhKSrhskvdlh7B9lkuHj35Rhv+diaJJm5Xw==
X-Received: by 2002:ac2:4c84:0:b0:52e:7125:c70a with SMTP id 2adb3069b0e04-52e7125c847mr2357345e87.47.1719552027519;
        Thu, 27 Jun 2024 22:20:27 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab101c5sm167736e87.79.2024.06.27.22.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:20:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Jun 2024 08:20:22 +0300
Subject: [PATCH 1/2] clk: qocm: add qcom_cc_map_norequest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-gpucc-no-request-v1-1-b680c2f90817@linaro.org>
References: <20240628-gpucc-no-request-v1-0-b680c2f90817@linaro.org>
In-Reply-To: <20240628-gpucc-no-request-v1-0-b680c2f90817@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=FEeU+ilaz87za6zCPoFOaXlZVVMvh4npbKUCi8WeMY8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1qdh1RGtLDqrSahc1eU78cyaX6fMsk2Ms1cU3jH+5Mnr
 3jPjJ/YyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJ5Exi/6en+kjt9wSPSSc/
 v3DbN6/GxTHnVxK//+UQj21NK55PelrscvGXSN5NZ5aDAdZ1EZEOFx7NyMiT2Pow/6S56eZqtwu
 a6hfquOV5D3suq7grr1S8Z5Zm4J4Im6xIoSr9bvGmlvV8sjF2mzk/v1/sH+MinDzDnrc28kXT8g
 snlOR+Gy08ZCx89p59/NzM5+EMgRI+ywMbfHUbJsv+0JwhmvnbbmfFYYdKEX3HuV31jkwuzGu4Y
 xd0eZhouamI7JpY2G21Pqgut1OukDU7zS3njblriP2avWJJLB1ys3li1N6wP77Wz2p1Kkw18+4X
 l+T0d+ekTFuzY1TOXNx0v9wj3bnDZ4sO942MF1tNrwAA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The GPU clock controllers use memory region that is a part of the GMU's
memory region. Add qcom_cc_map_norequest() to be used by GPUCC, so that
GPU driver can use devm_ioremap_resource for GMU resources.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/common.c | 20 ++++++++++++++++++++
 drivers/clk/qcom/common.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index c92e10c60322..dcc73bc22606 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -113,6 +113,26 @@ qcom_cc_map(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 }
 EXPORT_SYMBOL_GPL(qcom_cc_map);
 
+/* gpucc shares memory region with GMU, don't request the region */
+struct regmap *
+qcom_cc_map_norequest(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *r;
+	void __iomem *base;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return ERR_PTR(dev_err_probe(dev, -EINVAL, "resource not found\n"));
+
+	base = devm_ioremap(dev, r->start, resource_size(r));
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	return devm_regmap_init_mmio(dev, base, desc->config);
+}
+EXPORT_SYMBOL_GPL(qcom_cc_map_norequest);
+
 void
 qcom_pll_set_fsm_mode(struct regmap *map, u32 reg, u8 bias_count, u8 lock_count)
 {
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index d048bdeeba10..6cab7805a92c 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -60,6 +60,8 @@ extern int qcom_cc_register_sleep_clk(struct device *dev);
 
 extern struct regmap *qcom_cc_map(struct platform_device *pdev,
 				  const struct qcom_cc_desc *desc);
+extern struct regmap *qcom_cc_map_norequest(struct platform_device *pdev,
+					    const struct qcom_cc_desc *desc);
 extern int qcom_cc_really_probe(struct device *dev,
 				const struct qcom_cc_desc *desc,
 				struct regmap *regmap);

-- 
2.39.2


