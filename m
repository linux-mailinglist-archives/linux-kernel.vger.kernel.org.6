Return-Path: <linux-kernel+bounces-204486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6F8FEFB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183AF28D6A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B3719CCF7;
	Thu,  6 Jun 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lmbm5cNx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC91974E1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684616; cv=none; b=Q+qTTtmMPP3U0KD0fhdxs8YIYHCbOwEFtNfUZISfT6M0actW2OVtoqZ8uaslajYVcgMqtm5wOXRTKeikhI/3Mey7W2TXGrkUONLJPz4cEa08jUZ04SqHPhbuvz3eKhfPFACypsmJkzHNwkoY6YJgU7q1rcjNwvXCDIqMda+f4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684616; c=relaxed/simple;
	bh=9gyIokVicuhxbeWTupBDVovN5lebwLBLjKOrrkbqEoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGYPHad/XjaWLshpkHgXwSk9QjVsdc1atSqSopIIeMWdnAENNvJGRMxXXYVVSmOP6kAyzMwE/a/iOA7HNCstEJ2rTtY6CheO4IS4UiiaHsz8u6EuAU2Ge/SD2q1YH3keo51RMiCYo89zVnnaep6fgd0iSG7qo1nNXQeuI4OUac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lmbm5cNx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421396e3918so13843015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684613; x=1718289413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFnV2pRf1FmcK1ZExXtDIcGcJDZUgCsecv4UoOT/g6I=;
        b=Lmbm5cNxd+hXB9PBnc20FO7XqEauoTlAyMRlzVlYbrV3n8upXU7cIfJG5lWWiKBzVV
         TSfy+CoqUJJVoljH0manBtq4eaEeY2enwUCMBzggIHjR6zG4Be+eW4Q4yfmuq0CTP/XJ
         zMiApBDChc6fDtFQ0N15D6+ULws3DH06UblYR713qDBxJDKG1ZZqUnyfP+koVO7NTVSw
         dgEi+4Db0dnqazl5EeIQFksMao5HcrOORj42fqphkqwXSQg1QDPyWmkka8B56mnjQus7
         m7PcU3L41XEVZ1Q/OmFRAK0E/Fwz9zP4fw8R6E8iwwl+CG/OJNkhQCHd5uOHM/hF2ljB
         9USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684613; x=1718289413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFnV2pRf1FmcK1ZExXtDIcGcJDZUgCsecv4UoOT/g6I=;
        b=KRWUwv+aZ6QVt+Gw0X4oixBGdl2GRbQaWmYYcv/NBxomch+hbfUqqe9ucxP4tqliCF
         5qdsxoRFTKl7SDEilBVP+TtcG4vQAqLvCmwlBpp7YNr8RAyB94LsYRJSMMh2odq70+SR
         XhZDeFEifdNdp9QB3r1SqaWWBquyuJK5ImmpQRKCwFlvW+60S50b95aPh/1n10PEzWj9
         wllFfIpT9rnrup48tn8vSiIQlc5Uu0CQuqPuulS3wz/LdwV1o6sv9HHTWk8blVcdGxra
         4SizCNVgcXdrSeWCjUYU/+ioZz23jbWKbkZ9p7EN9JG91V0kG60QDuIz+PI6r6+UTpen
         00gA==
X-Forwarded-Encrypted: i=1; AJvYcCXSvfLiRgKWEjlQ4aXK0qs47h7gPCLzOuPcoXRI9ogxCNVe/ys69NoanLpbIkRoor+gfprUOWsQvdBU6yrVHxk8BihXzBhEfgaRf2uU
X-Gm-Message-State: AOJu0YwRuH3vk/B0AFy5DodiQ13CLu3bdHrv7/mKNRSEeJ2LwJbm8EOf
	l3kKCzJRyPzi2/g0RLzXJ3c0nyprNWeJsFCEjRLwh7/EIfuiqdwDJHi3qh7mCJY=
X-Google-Smtp-Source: AGHT+IEl9ZyRAcSIX5UQpPead73VIlTKgZG4JDvlzUJFXbj34q/+RJSy54ckSAI9W87xI9+q/46GXg==
X-Received: by 2002:a05:600c:138f:b0:421:5604:d1c1 with SMTP id 5b1f17b1804b1-421563503fdmr64858635e9.35.1717684613218;
        Thu, 06 Jun 2024 07:36:53 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148ffasm59540865e9.38.2024.06.06.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:36:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] mfd: mxs-lradc: Fix Wvoid-pointer-to-enum-cast warning (again)
Date: Thu,  6 Jun 2024 16:36:47 +0200
Message-ID: <20240606143648.152668-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
References: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'type' is an enum, thus cast of pointer on 64-bit compile test with
clang and W=1 causes:

  mxs-lradc.c:140:15: error: cast to smaller integer type 'enum mxs_lradc_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Year ago this was solved, although LKML discussion suggested warning is
not suitable for kernel.  Nothing changed in this regard for a year, so
assume the warning will stay and we want to have warnings-free builds.

Link: https://lore.kernel.org/all/20230814160457.GA2836@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/all/20230810095849.123321-1-krzysztof.kozlowski@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index 73893890b50a..b2ebb5433121 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -137,7 +137,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (!lradc)
 		return -ENOMEM;
 
-	lradc->soc = (enum mxs_lradc_id)device_get_match_data(&pdev->dev);
+	lradc->soc = (kernel_ulong_t)device_get_match_data(&pdev->dev);
 
 	lradc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(lradc->clk)) {
-- 
2.43.0


