Return-Path: <linux-kernel+bounces-554029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464A0A591F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1816D028
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DFB229B2C;
	Mon, 10 Mar 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhNEV+Ds"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B4229B11
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603934; cv=none; b=BybAQ7i67fEzKzQ1t2FAynFT6Al0iWCausaTzot1fNcJjxnpJ9gw9xfifUlTGgtAKFJgOcuPU/YDvTOS4jAgXMKvEtqQItGhbziY/v+Ng2iWvTq0nMGXjraLdEcE9/zxHOoloypoar5PvvRCyxtv/GFH+A3J5rp8N/jToxsF/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603934; c=relaxed/simple;
	bh=vVKnwODUdAiwe/gid9w0DRJv5TpgZa3pSP8IVebCvGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fqtSyXzL0cp0nlOAfD5ooDmOSxXRe+tXiWj7PFE9BqORrIfidaj+JIS/ID8tcoijiKUMbpNSoLyIwDSoDWtxnUvbVzybZqpkyu6kfmlj77wF7L+yypmHZLSpC6BYoEoA5n7Hnf3nZMRv+bcpVdjyTJyMSQwAXCoYsgQ/WLiCVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QhNEV+Ds; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390cf7458f5so3850207f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603931; x=1742208731; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T60o6gi3usu2ntppRywUa3E8NpwOZr/s4pv7rr3CEFs=;
        b=QhNEV+DsQHmMFF/3V3N/rzgReacxeQcne8aEUk2tC7Vas5wbteFmTJWVIIfrPdSN5f
         TWcvtXZaHO8jm9WeefqnmRybkZOkTs2gRfhfMJpoIXDB0bQiO8kGnbJMXGSK2RNQKe9D
         XnG6PtuUl5c8a87o0PF7REyKQY1LBHCm+B0DmDED6kwpu7pNBgHO9CU540QBGHa/Ga9R
         N5i5f9pyZZrvJT/WOH0dOp48s2L2Ermc5yM8SXVzikbQrJKg/MZLvKSKq+stou4J5kDO
         LXz46UB8l/egDb2ug+8B3ylcNRNkLqdrkkzXDCsI7XugvvYXUwWx4mmQtpr7tgXUJvfU
         qUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603931; x=1742208731;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T60o6gi3usu2ntppRywUa3E8NpwOZr/s4pv7rr3CEFs=;
        b=lNjfXY2L851pm2Ob8UoHC01cOfifVXdkTd79eePzsowTwvwWsBIhzTXUeJD0W25Rwo
         v/QsYVm9XUnsHyK7+8atWt/f8y8hseDqMU2ocfu2Z9uDl/U2Cm6LLLEKh7gZoUR4TgvV
         8pwR3BDvY2F/2iY25JT28mKkNkpnDOc+WncU5Ph9LwdRFVvIiNS62YlP7e/oTvyk9rXu
         4DTEXgowYDsHrfNnuqZCAd1O4HdlUyam5Bkm2ejRC46aSwdvWHUsueSvmioKvyaFGBg6
         bsiwEVJa1tfbaG/zuSVg32mvHyTh6vVj4yalaqr7i3TU3kPLPPphH/oyOCVnW1jD2NA2
         Sn0w==
X-Forwarded-Encrypted: i=1; AJvYcCVHEFZhVPsapVONpan/r7oJEmHE7UN9SRGedSrJbAJgte86urBgXtdY54dBQjse665GdD2e7y36s63v6DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrFGCRUZsYu852Y+ntw+vxEJDEFcng4hgCIRwYRpanvppGtyJ
	XAsBHc7MEzTsaS6iSnYatBzE1MiHBE3vQ+gdrb9ZYIeVrWmf60c3zt4j2k5qRlY=
X-Gm-Gg: ASbGncuL5Wo/dDmQ7zeo+WJBTQ68niIvzuf2K8TYl03SuQmkeNf/GQOkm70udiqYE/A
	FHTQIf2ifQejCVjFhVJwD9+PMySjMFxKuW1mM7g7VLviSWce76B9GdUYNNm5Hw5CIB7EGUPi6n6
	bMA+CceKJV0FmGIakaaaO8wLG4UvV3pq2kbMRPACSUbqwNXuTKGWz5E0c8bHrTDIJJC4nnaVVys
	TjVziyr6ND2CyxBpLi1KaOqJybVN2TXaMqhZ103qsWMAby+q7ji3XhY33H5sOO/ph7iLtxBlxYw
	9eKXEHtiGhDq1FHsMsvnt1wl5PFXAnpUuY7RhQP8BJcdPmnsCw==
X-Google-Smtp-Source: AGHT+IG9NsSyCGpPSYGknbpw3bJVRYQjo38717W7yKTXqETR+ruZNlHceeFZwXiH5qt7jRD0fRgUGg==
X-Received: by 2002:adf:cb01:0:b0:38f:3245:21fc with SMTP id ffacd0b85a97d-39132db1fdamr8297936f8f.50.1741603931088;
        Mon, 10 Mar 2025 03:52:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e2bacsm14468396f8f.78.2025.03.10.03.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:52:10 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:52:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] pinctrl: amd: isp411: Fix IS_ERR() vs NULL check in
 probe()
Message-ID: <617f4c77-7837-4e24-9f4d-620ecfedf924@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The platform_get_resource() returns NULL on error.  It doesn't
return error pointers.  Fix the error checking to match.

Fixes: e97435ab09f3 ("pinctrl: amd: isp411: Add amdisp GPIO pinctrl")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/pinctrl-amdisp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amdisp.c b/drivers/pinctrl/pinctrl-amdisp.c
index ce21ed84b929..9256ed67bb20 100644
--- a/drivers/pinctrl/pinctrl-amdisp.c
+++ b/drivers/pinctrl/pinctrl-amdisp.c
@@ -183,8 +183,8 @@ static int amdisp_pinctrl_probe(struct platform_device *pdev)
 	pdev->dev.init_name = DRV_NAME;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
+	if (!res)
+		return -EINVAL;
 
 	pctrl->gpiobase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pctrl->gpiobase))
-- 
2.47.2


