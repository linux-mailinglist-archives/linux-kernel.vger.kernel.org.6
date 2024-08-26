Return-Path: <linux-kernel+bounces-301235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D295EE13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD201F2326F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91C11487C8;
	Mon, 26 Aug 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE+yZajr"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E0146A79
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666859; cv=none; b=JFU4fvutKYzqi6feHV7cR2lBFd4bkWU64A/4rn27jh8/lTMj7aztt9wyKEtko+Lv8cvRwZ5Fci0sTuo8odW/iKxKnbTgtXcv3puhorXaX2Nl6dhdlUfz4xpYAaXLqJAQ/kXgl1l0J1kfEssvuOaBOpOsdCrJ0ZENmrXPCRl+7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666859; c=relaxed/simple;
	bh=ConX1xoV1bzBjN+wlA70XCF5X6wLZIQ8hExvfXnxdUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpSCOPG+SOkV0+emlxR8NKbhQwSjoKYK80TPYQjMe5BA5gnxpv6ZksGGCFJfXVdgRL7z6JbaK2pDNN32qJnANUkAM5xwYGKsuduM4Jg+QjrmsUwKIUcYaDA1hOzWyckXsJ9O1uYxPWxZvCLvxjjUzlKORdLgT3h04gUmZWk/t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE+yZajr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37308a2ea55so167557f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724666855; x=1725271655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCMHxzrRAUFzpSiPm8CMwi63rbNv1pA6fVNc4IEznk8=;
        b=XE+yZajrRFbVU1pvJfi2m7Ln33oFZLmSafj9TD7Fk/OACJaOmotfePpsL54sz5lTtJ
         esWq0zFPKbkwT1wAwOhq6okD8ey8XmSRmTHsUK/JORAmCyQZMXFvcCycSMIZ9HFgGxtY
         LvzAIk13kqfihMl1zKV/fXLSVnOjpAGwMVsuDgix30QxWwnVCr+e9vLkgzosOmVleObk
         2QdV1rWK2fb/jfRXzKqPQtfoLYi/6g4/8ruWQyMabQsJ1MduHk2yfoPDD0wd99N+CwYe
         s2//MitqcakdM6O0puUDTMFCNR+6E7JCpSc5ByxG45xGm26sZhxdbat6t5tMyb7IJ2FR
         koUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724666855; x=1725271655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCMHxzrRAUFzpSiPm8CMwi63rbNv1pA6fVNc4IEznk8=;
        b=DTa7RXJ2NUSLruB0k/hdP7+JrS4WVlzvACSzdCz5EdbOdH0thDM/beeNvLS1u5V1IX
         LbtuB/fYfdfVbqHrrMjuulUzQ2nxVhAqeXZVx8+ZpNUg02FRyJDWzOBVvi4xCQHEzs+4
         6ewI+/Y6GkKvw9uHzc+VuGVYWv1JxjVQK8W3p8JGaz5+upExlMJe4ap4Bz0vEva1LuYB
         C+Re5PfnXbfHW+TeQ9SHajVis0dBRghwA+dODXcl1Lppqc8Cmd6tGtZzHw+mtUKXteYe
         DK4N9WuEihG75KXbhF7RdNE5IRRlinlTqoHa9+s2fu4k8uPRt0QT0Bx7eEX2wgW1Tm6Y
         QDwg==
X-Forwarded-Encrypted: i=1; AJvYcCXuaR5P3uT/z0wkZOWXY5k9VRLaBw9lJAHw+16Uj4IshGsulF/44ZY0cRXI/7fKYwI8jTjsKRAfyyzcqco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8FsUa+8aNWOPz3uPudvKgd3U0OS7c46SyB+iBrO5EO8/CESQ
	k12umIrpTjN+6UJjKn5W2dWe1qkfOEbslfDa9tlLoQrD2PUpXdipgOY2qbRuJyw=
X-Google-Smtp-Source: AGHT+IGDbjrb2B74Avky6eGU3oCwj+LoFI4qsrsHH0Pjzz9kol++o/r/gWi6qLtWjpZvcSj6QuH++Q==
X-Received: by 2002:a05:6000:4024:b0:368:654:932b with SMTP id ffacd0b85a97d-37311869b4fmr3577298f8f.4.1724666855475;
        Mon, 26 Aug 2024 03:07:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110009sm10324821f8f.18.2024.08.26.03.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:07:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 Aug 2024 12:07:18 +0200
Subject: [PATCH 02/11] phy: broadcom: brcm-sata: Simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-phy-of-node-scope-v1-2-5b4d82582644@linaro.org>
References: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
In-Reply-To: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ConX1xoV1bzBjN+wlA70XCF5X6wLZIQ8hExvfXnxdUA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzFPaAeuDX82FFSM9E7GPDKBAAJHUMIGLxCR53
 Wk0I4/gdS6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsxT2gAKCRDBN2bmhouD
 1z/GD/4rnKh987w+rowE9WN5LMMk5lpIXrTDF1Oo6JkEirJ25CDRj2sQ92va/oAOeJhejh8xGla
 HlDBqPx+EXsaGhdf/ylIGJVhazNv0+uzaqTYc+gMkmRSFf+TWrYJY2bIeFYgOTcyhwizbUws4vm
 ASegTAtFMOWoeirXz+AehNgShieLrrYGKAm7JSGi+scXFZgQ/xn93v1TZ/M02QWkHcE//iGoroO
 fRm14dbzPmlc30IAvCpwkvr6G27AnlapPXqu2jK7cQzuNxsJ7IW/Wm7qP47DPGBnEdQdN2+FoWb
 ZlGBn8VA/dC1UqxtSxrkK93jlaDZgaFosf2E8qdjsUp5Tz0ylLt796ANXnnrIJchpjOcvgCo6BO
 pJlaTZLh3NSnh/MgaUkuiRV618lQAG+FLxOkqfOoCEkmPhg87S9ueikASenGqVYYhPafvWySuwk
 BS6/0kVFjq/UyGFUJuwtccMe1syDjg6utm3UzHgby8rU7IzwDg69lMPs06674gQ60SItOjDMEiz
 /z3dkObv88z1C6n8YUmcXrSsZhUDaFRS/7uX6rwCWB3CzyjyAcsUOmUcwRkbGzE9xfN1QUGVB69
 RdpwSzoIaQ5SqXhUuKz0q64uI6bSb0/Dc+nzAflvSdqqcLQ+zEHNdfLLE3KONoxjrMLCzZESSXx
 dDK+gMmEU2nLPxg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index ed9e18791ec9..228100357054 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -751,11 +751,11 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 {
 	const char *rxaeq_mode;
 	struct device *dev = &pdev->dev;
-	struct device_node *dn = dev->of_node, *child;
+	struct device_node *dn = dev->of_node;
 	const struct of_device_id *of_id;
 	struct brcm_sata_phy *priv;
 	struct phy_provider *provider;
-	int ret, count = 0;
+	int count = 0;
 
 	if (of_get_child_count(dn) == 0)
 		return -ENODEV;
@@ -782,26 +782,23 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->ctrl_base);
 	}
 
-	for_each_available_child_of_node(dn, child) {
+	for_each_available_child_of_node_scoped(dn, child) {
 		unsigned int id;
 		struct brcm_sata_port *port;
 
 		if (of_property_read_u32(child, "reg", &id)) {
 			dev_err(dev, "missing reg property in node %pOFn\n",
 					child);
-			ret = -EINVAL;
-			goto put_child;
+			return -EINVAL;
 		}
 
 		if (id >= MAX_PORTS) {
 			dev_err(dev, "invalid reg: %u\n", id);
-			ret = -EINVAL;
-			goto put_child;
+			return -EINVAL;
 		}
 		if (priv->phys[id].phy) {
 			dev_err(dev, "already registered port %u\n", id);
-			ret = -EINVAL;
-			goto put_child;
+			return -EINVAL;
 		}
 
 		port = &priv->phys[id];
@@ -822,8 +819,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
 		if (IS_ERR(port->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-			ret = PTR_ERR(port->phy);
-			goto put_child;
+			return PTR_ERR(port->phy);
 		}
 
 		phy_set_drvdata(port->phy, port);
@@ -839,9 +835,6 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	dev_info(dev, "registered %d port(s)\n", count);
 
 	return 0;
-put_child:
-	of_node_put(child);
-	return ret;
 }
 
 static struct platform_driver brcm_sata_phy_driver = {

-- 
2.43.0


