Return-Path: <linux-kernel+bounces-545111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C902A4E91B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BE2420841
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C82BF15F;
	Tue,  4 Mar 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4wQBx0N"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72F28D06A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107943; cv=none; b=ZePn45p9cHenrcnczOstXQsBhS5olSTG5NCaJU89qKwjYUG/P4BuXPa65Ck4XYSzUp0RobPVwVigpFCK190FSqXoBYOUsYHPJzO45q0wKM3sdRn6r1PwM8XDfOTBjBKMxf0Sk7qCnNVTC1yhQyeH9dN2jnRwAiHk3f1bRGPgHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107943; c=relaxed/simple;
	bh=w6Ez2HJK0lLtjno5cUxK05/kYeMcWHjoaFlGGgugd14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9CS8B/OI5D+DxQeyVofw9JcLx9ddylG9qnmeRqAyN1OcAbcdpCoh1gjNPZj301zZQ6clZJHHAQsfNNg92JDnWC2gWODN7ImPkfFrlUXsrBuOlBHMTkyxARaru6MpEXRqQ8Jau+VAVoZQlY3/oE24Ks0sEH6Fl85WjyawOMQypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n4wQBx0N; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso7977603a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107938; x=1741712738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1dbxTlHkaw5uSKNsqDfe9Jgr4Kg+vWUXd+ullz5kUQ=;
        b=n4wQBx0N1w5ENAaX/0C2H1OLJrJ2AZ4Sa1Y8rwOYtPRxSx3d1wWcB+1K3jeM85jw4y
         iKOTh3c0HII7ikEh9wkb7DcikKMjlhoLdoR1gvCLTSVDKwYFDAx06ruJ7O+s+KQW+5uV
         2XVLhhVJAj4o/ZRBNdX6Z0v+jGoP/8yU2+mVnbKb6Mk0YdmHyLAR/WglgvAzp27IJaAd
         /0jXs2AR/Lw2KDvdkB/2wxfQ2Ib1Sy3j+K/sfLSxMZ2reJAaNft7G7BHRdOPgLCkKCP7
         MB+eQybiTh5qGX1R2PMfyG+R8DskFbK51x3SnN7SuIfS+fQdRzJhVKzZcT0b7NqdWLMn
         SEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107938; x=1741712738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1dbxTlHkaw5uSKNsqDfe9Jgr4Kg+vWUXd+ullz5kUQ=;
        b=Lv5VSNC86rwiaMg9E935ae3LWEEQSUQesqCjTOWWndCU5Vu+iIiyidTzwVxfkyEUbU
         9S18uU0z/DHHVG7n0DXS1XPxG6kSlQ1D52TJRgCU8LtQmtz5u3h35JRLAbVA7mtXjkAO
         sXAJk1bqEWbB2lmN21oxOBQo3hIE1yhw93t9j2E9fhsNLSLNdP+CIO0CFNuiy/VcN4rg
         Z3WTVCqDaR8rMprzmBB2CwNkCFnUcEtXOq86/Ed1mJfHsY2VqL7jaVLf0a7jdyY9pnn7
         EDWqaHHpelJLmiIqkQqcfBIT3fEJSlB7nsldL6EAqzW0QXKjMo7PVQtRE1dNJcHnvkUJ
         B4Ng==
X-Gm-Message-State: AOJu0YxNzJ/6MiFdJtHyzRdCW7QYURUN19ix29oKOPagROknSKmyi+w5
	CyTEVOiW9ZMG2wBicLMDgtEmgYecfyIBNYrkM11TkYO3l0aEZFWz1Vv36Q0rFJA=
X-Gm-Gg: ASbGnctMqiP9D4OnGG9YbR27P3xz0bJu1jI4rZurdRejyEpUiCnj87URODe/aOVhJm1
	ZsD+tWYaxZinK5W2GvvglKQkMMDBycdBVaR23qINyq8RmOVkcYrX6zmYKuYd44jO3agboD35O1w
	2JPwrOyQyFRMWBdmJ5ofw1gDUgK0gIPcqeIXXRFKV0M1bvVoBkAxsVoFPTixPlMsoCE8gqC1ZSY
	Emg7G6SIjnHrXZCbXmYQ4W9utkgdXJ0wtMghA2HwQeFfIa4ZvFUIp41WD2wFKgTjV97NbAwYEIv
	xKmaovX5xlMhkXM6ytFsfz6SbN74Xc1r6sdHyw7r31fYHLpNG+CzjyYxT3q39UnZsOMFz+wRP+N
	CD2qZlEhR0cgxSXVx6omg58qc9++b
X-Google-Smtp-Source: AGHT+IHF998NpSXE/Qa2EdiSn4vtx17I0lnFV/wyKnxAJsCHaDM1j6HSEMvcUwtHdnvoXlFd/CgYog==
X-Received: by 2002:a05:6402:d0b:b0:5e4:c532:d693 with SMTP id 4fb4d7f45d1cf-5e4d6b8535fmr16782448a12.31.1741107937989;
        Tue, 04 Mar 2025 09:05:37 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:38 +0000
Subject: [PATCH v2 10/16] rtc: pl030: drop needless struct pl030_rtc::rtc
 member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-rtc-cleanups-v2-10-d4689a71668c@linaro.org>
References: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
In-Reply-To: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-pl030.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index 39038c0754ee55a952e5986afe711cffff35840b..e7c81740061bb60c4d8447d6522819685bea9180 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -21,7 +21,6 @@
 #define RTC_CR_MIE	(1 << 0)
 
 struct pl030_rtc {
-	struct rtc_device	*rtc;
 	void __iomem		*base;
 };
 
@@ -86,6 +85,7 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct pl030_rtc *rtc;
 	int ret;
+	struct rtc_device *rtc_dev;
 
 	ret = amba_request_regions(dev, NULL);
 	if (ret)
@@ -97,14 +97,14 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 		goto err_rtc;
 	}
 
-	rtc->rtc = devm_rtc_allocate_device(&dev->dev);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
+	rtc_dev = devm_rtc_allocate_device(&dev->dev);
+	if (IS_ERR(rtc_dev)) {
+		ret = PTR_ERR(rtc_dev);
 		goto err_rtc;
 	}
 
-	rtc->rtc->ops = &pl030_ops;
-	rtc->rtc->range_max = U32_MAX;
+	rtc_dev->ops = &pl030_ops;
+	rtc_dev->range_max = U32_MAX;
 	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!rtc->base) {
 		ret = -ENOMEM;
@@ -121,7 +121,7 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto err_irq;
 
-	ret = devm_rtc_register_device(rtc->rtc);
+	ret = devm_rtc_register_device(rtc_dev);
 	if (ret)
 		goto err_reg;
 

-- 
2.48.1.711.g2feabab25a-goog


