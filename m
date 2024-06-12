Return-Path: <linux-kernel+bounces-211362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3CA90509D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5999B223A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2F16EC00;
	Wed, 12 Jun 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nz5ecIO0"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4516EBFD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189021; cv=none; b=SGdFU6zAyxNp/p9ApX4jSB0Vt/V/jutRRCSSUMyFx+6dxsVcnftUmbKUtbbBapS8bSqZ1NPWuyUbZ1XMXIu3+0LeRh1dslXMT3FW1I42kNo7Gs1b1Np9pcYalZT4fvQsX8eJ94Cpmj997/eQjEmcwSwl+84Nn8mSR/XwgxCfBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189021; c=relaxed/simple;
	bh=REYZcvusm3pkwQ7HGYtJFqKnsOvXK1eSq4fjluTiMa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KXQUGG1PToVQD0oEer7jsUtGYqF+ZQTYhc9auXPqLdQ3Ar6T0FDw+tgwCBUre8Gl5AtAsiYqrvHXLsy2wQmLgubehZkH20N53yP0TH4tx/1CydQBBKK3iKqBBw57IQBl6JG7gYfmYCE3YipaaryvcZbvhsYD3ARk2ytYqIJTxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nz5ecIO0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebd421a931so44251831fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718189017; x=1718793817; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=en5v3zZb3SYUynuEEvB5KY7fvjCtjNs2C99/5XHt5sQ=;
        b=nz5ecIO0pAY/S7aL5GGowJEQAAJHigWeTCvTLfrU434O6+lYLQ4pMiQpdHx44i7S07
         uLavFrc8a/A6vwKIlUUgnhSDKbvYSfhFody4I34hFYeyod+YcOFazPwgHQZ3Q7hJzuB3
         QzQMdFpLD/m2bOpX1vzEAbETmqydRUHx3BYtGH+WdG+FPFnvgF4F9zQcwsAaYOq1jipp
         xr1jdppunOWlitTbbZhalwQFI206a3PefqXcvmIJezYqHeXs/INrjzfFJlIHx5ZFP87+
         IovLV4n3tI4ikkID7le/Ag8TLRG4iDNkJAlIsO4PHpBCFMLH+VfeTMLE/NSe7hitSNIq
         iGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718189017; x=1718793817;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=en5v3zZb3SYUynuEEvB5KY7fvjCtjNs2C99/5XHt5sQ=;
        b=j4agTEgW3A6h7NhWAiNUryQW+DPVfFnnZ63kI14dJGJ7ZVaF5ibqLUhegw1ruhggUP
         2N5RDu7Su8ZeegNV/aoNCGfrP3EI4Va3HXdOa2lMmVGf6mPrTzXbXkpISgdsqCa7/Z2E
         Ich0iAX9p+zCPywgw62Mv3g/kClARU+XMrq/h8El51G17SYkmhJMoSfQ0MtZN3dMhyHO
         limird0yjJzT0/QhLD/ck6qIUnwVzvyr4W9d59KfHTOi/RCg59Mf/GmQqQSfG25GS83d
         XOSr7RPDhWA8TiA4YiY6WktqAusc6Bm0Qn0MPzBhzbCJO74LIblu5fjvXJtWAU0NcKll
         GPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGgbYoRSigS3M+CJJeeR+jt3lMmPBoXPrTXVRzXhgmRY4VTREdpk9TVr8LCn9z44n6S60c32aikPl/Pdq5vkCw7FIjfeCsXe/kQKKp
X-Gm-Message-State: AOJu0YwAzgkB5VStr6QjIN6hTRbvHPaC39/4lfNEUp/pPrAsGHwb+Q6k
	EMQ5DCgrHnkxp3VVzDfI6gxGDd/KKNH64yRKki76jDhMxThJIuojOCc9udyT2bI=
X-Google-Smtp-Source: AGHT+IGAjGH7WuBg4zqQ4D62wvnr79c+GSlh8tV4aOGiyUMLTUamEwviTONC6JOitXK9+WCXuDW5Ng==
X-Received: by 2002:a2e:a796:0:b0:2eb:fda7:e35f with SMTP id 38308e7fff4ca-2ebfda7e40bmr8240381fa.5.1718189017181;
        Wed, 12 Jun 2024 03:43:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de62fsm21843715e9.38.2024.06.12.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 03:43:36 -0700 (PDT)
Date: Wed, 12 Jun 2024 13:43:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Huang <ychuang3@nuvoton.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] pinctrl: nuvoton: ma35d1: Fix an IS_ERR() vs NULL check
Message-ID: <840152f9-d3bb-410e-8164-4c5043e1983e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The fwnode_iomap() function doesn't return error pointers, it returns
NULL.  It's the same as of_iomap() in that way.  Update the check
accordingly.

Fixes: ecc5bf868673 ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index fb933cddde91..1fa00a23534a 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -571,8 +571,8 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 {
 	bank->reg_base = fwnode_iomap(bank->fwnode, 0);
-	if (IS_ERR(bank->reg_base))
-		return PTR_ERR(bank->reg_base);
+	if (!bank->reg_base)
+		return -ENOMEM;
 
 	bank->irq = fwnode_irq_get(bank->fwnode, 0);
 
-- 
2.43.0


