Return-Path: <linux-kernel+bounces-298898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A73295CCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FFC2825D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183A188917;
	Fri, 23 Aug 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T18ARMPQ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4C187FF4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417500; cv=none; b=S5D/mgDTA9WDn63L6sJmv6ChRuIv55p/t11rZ+o7rIpHgW73y7/LuCldzC0pVUaesWeP30AlDbxPoAijY5jHUTVMuEkcNREDd93pOS1p2cE4YWisQkAfxmA/JfshcJWc/+TNuwux5qCXu+j9dhRySjzqjwv8L9BvkanzpDm6uDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417500; c=relaxed/simple;
	bh=SsKn+XKGNdg5Lu4TYJpa1Z5yeroNI9GQomQEQv1kKlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=honK40XGHJZOsWaIV+sCiylxZZDEeZ4QeKJVeZNnXEv+imAej8DU8pNtI9c5xaZc8FJIR7PyikEa1VFxHESkQxrBGy+PZ274ruzSDrjHZHhp5TT8ZLWx8dlc4iiJj/53yGoxsSxSxveDgkEkxcMHwmoOlT8ueOeA6ot/bbp1ryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T18ARMPQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bebcdc75e9so325245a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724417496; x=1725022296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa/KHRgT6a9iG3/ETlQHPI59tAN0SqbzEBXVbMy78Ls=;
        b=T18ARMPQSlmoGh4NlPQ4GRI1+eex+9BQlgNe6kO0m6r2fab9xjGOzCrbodvb5EtrUu
         50xr3JNJbFmUuJqOdxBH0Sln0Y/WhYGzQXmUBGw6RrNJI+gUJSM1ES65/QuTsLWFqrh2
         J49qZT6ADr5BKWO1sMrP6hHgk6VV2ibYsXozDJmsz88rj4YkirWMoKsD5P/MozxZfAbV
         4SYJ053CTIZGhzxaai0JeLHLmQ3LbC5wydw1rWCDyb0Kb8+DNdmZWGMqcKJwbSLIpPa6
         f/FB+H2ZhmfnwYVIfQp0XznIbbmEH+ZIiF1GZpv8GSpNckivLcstfYHKWD+N/LdFBm/V
         TJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417496; x=1725022296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa/KHRgT6a9iG3/ETlQHPI59tAN0SqbzEBXVbMy78Ls=;
        b=aZ3xc/wMsbFGqpPjSpGcfMZOGmo+QLYlRVvoxc0zE9giRPleOWDf+cAVV06SmEvHll
         Y/Q843wy/bLniyXzs24rFv1lCTnxsS97UQLh2IjVgDIqG7Hf9mN57xQi6DwNsYQJMN8V
         9j2NzOjL/T0n85LPotDis0ZdKpaL1mmbQvQ/fEzl6/KYqiH0TVPpQiT3JBPCVtJWmbyh
         jfY4qaK+BCxyVQTNJ4tr4bet1JMscLdntNTW+odOvCKNeHbXtN+hYRJ0ZMi8N0aZw0Gd
         45Cyyjy/a/2DvcYIykF5fexp8SNOfZzTK0dYLuOzGphfstBWD7XooGUJghvr0dtPH4sE
         VhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDJud6cnu1Hyj0Eg5OwHS98Ev9+46eQognUjynujVaQJ3jhU73CFPzgCnG7h9z67a1BlJTWHji2L4uKw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sKSfI4TPnta6i2aKppphErphvsddN6mMp3PAITd+7lSd+fcl
	X8cej1tlJGK/JWjIJFTfCt0gbjm3mAmNlTILbQxw+h+SrXfU8ekF0kcskOTNSvg=
X-Google-Smtp-Source: AGHT+IEdA/oEZ97C2qOqfjgHLdf7GZtFRbhRivaHzioPPap69e5acBh4T0xkHuu904RyEID7S6Zhew==
X-Received: by 2002:a17:907:968c:b0:a7a:a2e3:3736 with SMTP id a640c23a62f3a-a86a5489a72mr92536566b.5.1724417495945;
        Fri, 23 Aug 2024 05:51:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f384bsm255931666b.192.2024.08.23.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:51:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 23 Aug 2024 14:51:09 +0200
Subject: [PATCH 05/10] pmdomain: qcom: cpr: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-cleanup-h-guard-pm-domain-v1-5-8320722eaf39@linaro.org>
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SsKn+XKGNdg5Lu4TYJpa1Z5yeroNI9GQomQEQv1kKlo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyIXIAE/UDGNyaNfdauaVBO6LIu+O/X2S8PcEz
 tOZoQCDU0SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsiFyAAKCRDBN2bmhouD
 1z9AD/0SCxM4givKRDsROWCOR5j/+4VWWxQLgTTNLssfQNDBH81XPQ0y6u5DXPpwX6GDZuFE0KG
 AGCPQbxe50w0leYIkSfhdQcmHV5GegOp93DcIhTKAThLFFJJfNFoNYm6NLqFo+2/JngjpIWosI/
 jumqWnbvSxujOR/S5APTM6m2LisQte5FJFkVfp0fy7rTJNPjWBea8nhcre0gRoU+ECZ6hnDuogv
 Rc/ncG5TXQntXUbni/M98iXqDOMb79XVVsYwRMW0h2ZI5ATxcP+xF/BMpXSO4tSwAtuvaScNZrA
 +lOW8wz53KFD3F7iaOVpgEQ4vgqzNaWaBeh6g/8kgAwcWZZroJsPA/HGbulpkzCgvujAc8yIe4Y
 L3N7+1BRdGP1/+0DkFhr6q7hC6IoetUMtK8/S/OlnoZU6tIZCzL3dsFEGvIjlAGSJFV/eHSY5Ui
 X3BsRg5nI5eL5F5bwKuXxXzGX5IEu8uwLYdvRQfITeluiSylB/x5sDeQffM/PHtDoDQIddbd/D1
 eTzAs/GUBiAJiWE5lLNx1Wa65YWa3olzZhJCbZtGbt3XKLVv+gxrwcCCtFCJt8KpW5X5kcMIFNq
 RbIza/sGz8mkdHAj5bG4X5zTXQ8cabGsaE2qdP9UWVpiyzj4Jv+c8oDlCZ5WWwUlU5Z9cnpnkrW
 xm+1Jwl7sUAchbA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make defer code handling simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/qcom/cpr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index c64e84a27cc7..1bef89712188 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -1470,9 +1470,8 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 	 */
 	drv->cpu_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(drv->cpu_clk)) {
-		ret = PTR_ERR(drv->cpu_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(drv->dev, "could not get cpu clk: %d\n", ret);
+		ret = dev_err_probe(drv->dev, PTR_ERR(drv->cpu_clk),
+				    "could not get cpu clk\n");
 		goto unlock;
 	}
 	drv->attached_cpu_dev = dev;

-- 
2.43.0


