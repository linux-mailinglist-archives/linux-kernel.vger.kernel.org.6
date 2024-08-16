Return-Path: <linux-kernel+bounces-289238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A7954384
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639CC1F21850
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0AE12F38B;
	Fri, 16 Aug 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQsA+kPI"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D27DA64
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794858; cv=none; b=Pn99v05uoupWrFtElYp6MVPuE5ncwZcD/G+D6Iep9Zg7+ObqLG4anjVqv2vRSU+6jfRq74UbdLSqnrW9Uw92Foj48+E9l/5XkparQE5ROz49ta0dlhdIJ83V3smdzKmSh+aJ/W3cONMV3ZAerdmu8lsX0pzKv7KS+jg0XYRu0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794858; c=relaxed/simple;
	bh=fRFrl2xxLajW7BRlASDFQqs8x0H30DLVpH4SEKpcKME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krQSMAOJf8OVtppEMU8znr0vmCaqeKhE3z6iOQ/K4VYeg0VF0cdrfWujJIcbuiX5ebcrdUYBRig9j5otDLsarXUwAXZOxHwJ36YrjGNe/V/wX+SIWeQkQb5Mjb8fSR9mTIxoH5Il/HydfRwma3tE5Pxo6suBv4sfO66bi71Ib5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mQsA+kPI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso11493065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723794855; x=1724399655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3rfqVHruVOGC2FYVz0rFlsxOciO54KGc2d/kghQsw0=;
        b=mQsA+kPI13RKBFLvR2K94Sea9cG9BePP8h6T3TdgDXuqxAi100wlm4+ixEsEkpk/cf
         l/zUU+JSnKgOtn15WiFfNQ6F0u6ZPZx4csdoWnSPAMwVg5UFI9eLpl1L6y49ZuBdV/zp
         iTMGkXzRhOHMcS2Rx1mwX9zy4TaoCRV4f1Z/UysAkt+fRmPTbrBDznOTCv/Isz5mWpwC
         cBpyswdLOlakwPJ+aZ/fI6yCb/cA2wMHnFqVm5CDaVwlIeRZFi42m94oWT8Bn+3Ihb0+
         JIzHNiUEqiX4U7Xfvo0jsqIDvZSyKV+4Xi3BW2bV2rKI2oL6I7vvi6K2GR5Cm8pL3UXN
         hkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723794855; x=1724399655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3rfqVHruVOGC2FYVz0rFlsxOciO54KGc2d/kghQsw0=;
        b=My8+JNFk3YKYQMEaIJGY42aY2/GmbCI+52uQLQ+XZT7FL+9jQLfbEFVQQ0eAeJpgEL
         hPX7sHEBjHZWspIrlbLjfNlcOkRyDIiWD0DJpzUE3epoohll+UqM4bapOkuCq9tKq01M
         v1JSRwbjS5nb1bLznPIaoo6Jq1pqxccVATiTfqxHJ0jKpGegaymR/fjj3VkTLte8RjIf
         JQOI07Oy1HQhnyqKO3bz1lGEpslLzA1nzBlNe/I9nLUzakOf6Fbl6939sWtGksVRxTD/
         QM4WxTISrbLV2QUJgn+svKiuPMtvMaRNqDxeNH5EDIjFt6UqybmEU4THyFP51WnxyoSq
         Dtqw==
X-Forwarded-Encrypted: i=1; AJvYcCUac1orEk2q5ab7HA161F+TsXfMQGu8NQxiQtL74TrlnR0fEcCXlfIVUxeUuMx12ycPzvMaa+hi/kQirvVUivScmOQHB673vEidCmV2
X-Gm-Message-State: AOJu0YzBxNuebUxreTncXqHAOjuHxFgOBYL1rd+ePbokOOGR8E82ngZA
	NUc8tgPZRlG318GrNPkdZAWN1uXt5CzLgycHf7ms7FOZb6WtdqA3sludMF4JUTU=
X-Google-Smtp-Source: AGHT+IELJsEIdJrzfxRlYTFmph//NPsFzW/KOkCn+6qANqNPjCBjFgoONw7BALUdqn6MkGE37+0afA==
X-Received: by 2002:a05:6000:dc4:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-371946a3dabmr1036836f8f.45.1723794855161;
        Fri, 16 Aug 2024 00:54:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189863109sm3049587f8f.65.2024.08.16.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:54:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Vignesh R <vigneshr@ti.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Piyush Mehta <piyush.mehta@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: dwc3: xilinx: add missing depopulate in probe error path
Date: Fri, 16 Aug 2024 09:54:09 +0200
Message-ID: <20240816075409.23080-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816075409.23080-1-krzysztof.kozlowski@linaro.org>
References: <20240816075409.23080-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depopulate device in probe error paths to fix leak of children
resources.

Fixes: 53b5ff83d893 ("usb: dwc3: xilinx: improve error handling for PM APIs")
Cc: stable@vger.kernel.org
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add goto also on pm_runtime_resume_and_get() failure (Thinh)
2. Add Rb tag.
---
 drivers/usb/dwc3/dwc3-xilinx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index bb4d894c16e9..f1298b1b4f84 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -327,9 +327,14 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 		goto err_pm_set_suspended;
 
 	pm_suspend_ignore_children(dev, false);
-	return pm_runtime_resume_and_get(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto err_pm_set_suspended;
+
+	return 0;
 
 err_pm_set_suspended:
+	of_platform_depopulate(dev);
 	pm_runtime_set_suspended(dev);
 
 err_clk_put:
-- 
2.43.0


