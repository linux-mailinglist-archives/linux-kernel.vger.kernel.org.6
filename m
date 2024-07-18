Return-Path: <linux-kernel+bounces-255900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867AD934662
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5191F2281B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D495727462;
	Thu, 18 Jul 2024 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPKBNa0j"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8E1FB5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269559; cv=none; b=heZNbufzOIy8hj1xN0pvEEK++CWaXNY9isJ8PZLS5eqwzxiIuHesH6zd94CVJJPSoH/I3qn8CaWSdaNVp4oMqxyW2HOkUcN5wDVC/6Abtt0QogmyKBruuk4jfOKOtHCOOKEazMnoSAkzYMoqu0ayNxLeOt9bAeFHjjvEAAgiQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269559; c=relaxed/simple;
	bh=M6VIKClxCKUTHKil/lftXivMZWewfbeoa7Xddd9eHf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z6upFjQBs1xCwwH8vUq4trI6Dl+82iaoNIoPjFxl6XRNNnve/YzL0VzEg0pd5wwaXB50kYr658mfjJDqdgYnvjAyNvVoc2CwLfVBn6LtN4ruXfx4Y+SGZShp2KT6xrS+JvZFKYCFNmswhkY+jNerAYxVUGACHW9GfOZ52n1Q8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPKBNa0j; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260e6dfc701so186969fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721269556; x=1721874356; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gklRP1Mg2lPJDFn6YnROe/wcKMjIXNM5Cvhi4UGcBq0=;
        b=xPKBNa0jmD+kLpOtPIT1JsGpQgplR6ypUfDz/AjTVQUUGLhubdKwFnLmGiVP4MM0FA
         KtiCK6+qNneo90+fSnQ5BFgm0F/OTPKiEMvim3EoT49k6bCMs4lQWelOSF22isfCBOhW
         CesqKLr0Q8ThvHmXeB8q77wGxJn77gA53ddXfucNxKDBXqGMq+MXSYoQAlCw1q0/WVBH
         bBuFtb38CbAcLniP0ICCmzFSZxmaZP2oEsL6b2h2ZHIbVK7wFQCQfMSroEThfVeoweaP
         JWUD3IO+vAiurkQhI/6KhNuqrmQzsjhSFJPXpcXH9y115EFGXO/uThqQDSzRmRi1UEht
         oFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721269556; x=1721874356;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gklRP1Mg2lPJDFn6YnROe/wcKMjIXNM5Cvhi4UGcBq0=;
        b=KEPz5YOEN5RlZpvRiEWipYjJ3e/jOlBbh4CHxp412E+VQJMsi4+TyTc85TGfxYi7Je
         RBmJMJSm0Zs5S1uk9WJ1HozF5ndE3fu7RNqqBklxDzHUg6JzUwPVB5pPmGvuokcRwm3g
         6goarIAFrhrX4oEGLFhpT+SYYkbHeoWMXDo8FSDlOcKZ1+tHgbOLkOevvksnvYuZsdjs
         VVcZxYGejSmhNM3961MA0xH5by2Om+ZY3WjeCFF/VHN/ErNCGyT0B0mV1THQ9h0lPBGV
         +52/qBNPErFkRF6Par9q5oYnha58tBCN/ShzB90L8vkKdhc3wpnDc7YyUWU2vTEAF4sd
         3f3g==
X-Forwarded-Encrypted: i=1; AJvYcCViARzF8AT8ZyAU7vrjqn7H7eIIR96ixtixP6g5cSY40jrcWpui5WBr81KFqX74Oj7QbP/lj/vLWoFdq0n2HXZf2m0mYP9emKlS4Y4D
X-Gm-Message-State: AOJu0YwQJA85v/xRxD5AgT50k4i0OZC338z+XHlQs5ojdbZoEyzz9h/r
	4VER4XZZ2VHVlDP+FKUdTRsOzv5va6ktEnhkpx5TdV+RmWXNd/KUfJ8x1GL1dkQ=
X-Google-Smtp-Source: AGHT+IHupNh4IdHfYITPiJHzo+24fJypzIvoRScwFusZfpcnc4Pu3dq0o5eCy94zxrmTygwA8vdt/w==
X-Received: by 2002:a05:6870:d206:b0:260:8f6d:f029 with SMTP id 586e51a60fabf-260d9504d8bmr3106193fac.42.1721269556637;
        Wed, 17 Jul 2024 19:25:56 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:eef3:26c0:a400:406b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-260ee947f82sm192994fac.50.2024.07.17.19.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 19:25:56 -0700 (PDT)
Date: Wed, 17 Jul 2024 21:25:53 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] clk: sophgo: clk-sg2042-pll: Fix uninitialized variable in
 debug output
Message-ID: <baf0a490-d5ba-4528-90ba-80399684692d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If sg2042_get_pll_ctl_setting() fails then "value" isn't initialized and
it is printed in the debug output.  Initialize it to zero.

Fixes: 48cf7e01386e ("clk: sophgo: Add SG2042 clock driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/clk/sophgo/clk-sg2042-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-sg2042-pll.c b/drivers/clk/sophgo/clk-sg2042-pll.c
index aa142897aa5e..24b0eab6154b 100644
--- a/drivers/clk/sophgo/clk-sg2042-pll.c
+++ b/drivers/clk/sophgo/clk-sg2042-pll.c
@@ -387,7 +387,7 @@ static int sg2042_clk_pll_set_rate(struct clk_hw *hw,
 	struct sg2042_pll_clock *pll = to_sg2042_pll_clk(hw);
 	struct sg2042_pll_ctrl pctrl_table;
 	unsigned long flags;
-	u32 value;
+	u32 value = 0;
 	int ret;
 
 	spin_lock_irqsave(pll->lock, flags);
-- 
2.43.0


