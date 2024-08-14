Return-Path: <linux-kernel+bounces-286202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019B69517DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91486B24EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D2165EFE;
	Wed, 14 Aug 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dukT9She"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8D152196
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628404; cv=none; b=gmA7i9bTYrpR9UIRuwY3mH9uZWmkKLV2IolVeoqYe9IwJ76/Vwvm6LUF7PcXjivNI6LQbQcUqfEjn4GZWTiErcpSO+UCFSG/Lp7BlfGm47pFV0z1ibqL/QWA0ZH1QtSPeaxESimSqHMMZd8+6a+ObEtTGYDUKD/ElvdS9Ogf68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628404; c=relaxed/simple;
	bh=K7a0LCBXq6OZZ3B7ZT3AYD2E1d/U39ngdeL5y8O277s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0qTz8hrrkPC533uyzBTGr1vQwzOvCMCXGZtRxp+LBAeIOt+VoXeO16dkoLKzLM9666IQlRAt81pDgnQw7ug9mGo84Zfc0hGYLBvWXzAY02tchoy5zv3sOxS9aevD5VdogkIHtRuq5TJNd2XfgUPSlB4BoLxLuigJdRUTKDBLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dukT9She; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so34612935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723628401; x=1724233201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JmXmcga/zjb6ahfiHPXOSzwplx1CZRP7/PHn0u7sCk0=;
        b=dukT9SheX7TvEIR5S+jpcr94AZUkvlsmvl3MbErWvJyM5j62080PdspnaMT7pJ9bQx
         9zsL6Kyo7TAuNjYSh7BK6zr1PPAB95Ef3t+SfsKaf5fwxTQdm5uP9DAQsZ8+OllOkYi7
         zzwEaYA9lTxA9ptAbz7QT70RpGCsb0adDacca1843junx1eTYV6frc7BjxfKFM5frd3p
         u6fICjQDefWWZgE+HY6PQay+XcsbpZTtiJeupppd0l7Dg0ix9OTWfmXQkTFh2dL/9WN1
         OOLnaMoLctG8P7XbEBsufkYhgRwQWp/gODwAUxJJDlHMy7Eie752sx+SZ84tV5NAZmNt
         XVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628401; x=1724233201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmXmcga/zjb6ahfiHPXOSzwplx1CZRP7/PHn0u7sCk0=;
        b=dUU8oTZNSY4H87U1Q+rqft4a9lhqAAKgGR0YXCYJaTLb/SBKc84Qp7FO9xNfX7hKvv
         2veaGbr/FvjwLvphzOpbnxynEfhT3xlnI0iQRrHHyNvG5nbZBN0SzJipi0FfQlG6WHvL
         gp/HXHZv/lOwbn4uU50K8q400cV3PldSqemHmz7Rdg1l29Vg46zjp6VvtKPEaFi1c2u3
         0xouLKwTCtgdiD1q/cuOLNqXR7rtO1/Cs0z9PrvbJYqCR6WX96LHDdwOM1lApY+rlA1G
         AtAARS2gEYsCS+SMrmUopKxXfuL2ZFGlEsBazzw64gYZ1sHf/+dvq0D/MFOH7nJOWkKQ
         8+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWRXy/KpUqQ+WZrYY5Weh9NSwvGE8IVONqGLG//PMA0CGne5TKrH1xPSETuGBc0xMFl9weKO7aqLnCGuXBNJ+nzgZQqPJQx3Ieeg4Eo
X-Gm-Message-State: AOJu0YxKtQEIEkkC7fI6SoO7aIMSyFNfIcL8WbtUCgFncdRUQ8x4HTn4
	DSsUTTmgeMwn7XaixaDsVm2lMAlL0NQSapy3EAzuVxW3FPpZtTZGd89G4iFB10I=
X-Google-Smtp-Source: AGHT+IF/bJMKfHmeWBSdbtMjSNM/VzBYMVOeE4F12fOKUYhXLXD2wvGqLv30n/W4um8EnKsh44iMBg==
X-Received: by 2002:a05:600c:3c96:b0:426:6eae:6596 with SMTP id 5b1f17b1804b1-429dd264983mr13645925e9.25.1723628400773;
        Wed, 14 Aug 2024 02:40:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded28cdasm14195615e9.16.2024.08.14.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:40:00 -0700 (PDT)
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
Subject: [PATCH 1/2] usb: dwc3: st: fix probed platform device ref count on probe error path
Date: Wed, 14 Aug 2024 11:39:56 +0200
Message-ID: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe function never performs any paltform device allocation, thus
error path "undo_platform_dev_alloc" is entirely bogus.  It drops the
reference count from the platform device being probed.  If error path is
triggered, this will lead to unbalanced device reference counts and
premature release of device resources, thus possible use-after-free when
releasing remaining devm-managed resources.

Fixes: f83fca0707c6 ("usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/dwc3/dwc3-st.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 211360eee95a..a9cb04043f08 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -219,10 +219,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	dwc3_data->regmap = regmap;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-reg");
-	if (!res) {
-		ret = -ENXIO;
-		goto undo_platform_dev_alloc;
-	}
+	if (!res)
+		return -ENXIO;
 
 	dwc3_data->syscfg_reg_off = res->start;
 
@@ -233,8 +231,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 		devm_reset_control_get_exclusive(dev, "powerdown");
 	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
 		dev_err(&pdev->dev, "could not get power controller\n");
-		ret = PTR_ERR(dwc3_data->rstc_pwrdn);
-		goto undo_platform_dev_alloc;
+		return PTR_ERR(dwc3_data->rstc_pwrdn);
 	}
 
 	/* Manage PowerDown */
@@ -300,8 +297,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	reset_control_assert(dwc3_data->rstc_rst);
 undo_powerdown:
 	reset_control_assert(dwc3_data->rstc_pwrdn);
-undo_platform_dev_alloc:
-	platform_device_put(pdev);
 	return ret;
 }
 
-- 
2.43.0


