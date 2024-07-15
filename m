Return-Path: <linux-kernel+bounces-252718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD66931743
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792BD28359B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFC18EFFB;
	Mon, 15 Jul 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nF3Yowwb"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBED18EFF4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055588; cv=none; b=B3+jac6DPhOdaiWRa2MzN0EUzEgkLXamuLYRSIBLqqVOWkpgyQUMZoScG0w188hV+x+eDrd2Gqc0EfT1uQoEn2wQDiq3NkFnMrZtCEr4TwpOT7AOWEoY+RdbZGxMnSwVQHyRmQP1Vib/u7xXv141RCgB/5g3LUKsVJnHj2A51+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055588; c=relaxed/simple;
	bh=rzHANoUqXG82QQNq7zWwsJk3/CBVzuayepJXbnfYmTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XbNBD7X3AAmY9wUQHIHZel8jG63YtphCHx2I9df0w34tyKiFI0Pc55YLzt50Qw5jA9kRlyUgKP6ImuDO1WO1G5YhXS/NzHJ2oFAzEPNWes3i/2npcZvgmrQGox9R2p0t/msCaJlm8HUNp214c3wh0R3BxEyi3NjOgnjnKke8JaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nF3Yowwb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367a183df54so2977283f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721055584; x=1721660384; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C12lGQoC4O6dCA83BitIObz0vvscmP1VuajGEBqvvq0=;
        b=nF3YowwbFlQoo78IH2LtbW0vYNg/QcsJ1ZdwEFchlq9+Xt/0TScrbRIdT/b3vnoH3V
         toj10IQK0xVWqtalCLq6lBCTKSPp93Jn0KR0RyAY2BXCOzGjEjAmteUjEIyWXHUUCP9t
         lg3GqYBCf7mtwQEL5nfaIC3jL+4+BTb8vu5fEZUboHOeJNrnxjMAp5sAc/R6shxwQiGr
         DdecaQyxE3SjG4hdb1cgeTiSthePvvDsXec22nQ48IwQr4IcR/leQRmoCMZsCK8r2vnl
         it6rWDLYVtdbGtQ+Y3B9IK6TbjPviIK8v2n+sJYH6DliAUdrA8sW7xm2J3tiOAU9MuAR
         Irsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721055584; x=1721660384;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C12lGQoC4O6dCA83BitIObz0vvscmP1VuajGEBqvvq0=;
        b=pXxLx4EHk0Ky/mofIvbf7L/ilmJdm3TsbHOuzkuS5jOgGmTINhdaSjTvS5nieOl/AR
         RG0hOAPagsxzt0XgyrqcLdJZlL7ZsEM6N2Le4+3vkOTMUySJJSGZ8woH03KdpY6nMi1O
         VCGuy/+axRV5ltiKWcKw3aFIWHrXhT9ERwrs+BHbhRNNqNRSalgY1gzVRUv0vKmQ13HH
         t61JF77DH8HiVjCmrOUEfUdXJNNpJXpYy0xaDDtfCBv8FqeIrUNhJ+ZR7wYJ/SRexRNu
         80miGu6McYFaCxsshYRYqqBkyU8UdGUV+fT3X5IUxUyHr1mzoR4LHS+1fG0tbvsyXQ37
         YmRw==
X-Forwarded-Encrypted: i=1; AJvYcCVNTxjcVb7IucixyppUOV/BGNGR/d5OQMa1CPy/n0av5Y73bJaow88pQkwsPNUlXxboAILNdW4zwyhyu1v5ZIQorWFb8TQiWV0SDRkD
X-Gm-Message-State: AOJu0YxJZ498e4AVxEKVKG3k7/NWzRiUnGsgCz66F8RfshCSgnGOJl/H
	vTlCSfWZyokebO2HgFQc5dGL7+T78TsuBjt4+ZQiyXsxTXTD8h+4dUYKGllsquw=
X-Google-Smtp-Source: AGHT+IE5W5I4LS+aadPJhSFJp7ycTKcKABcEYy6T4uVw5x69VrvDLqCqxJv/YubQ0h6t6A8Gr3Gw8A==
X-Received: by 2002:adf:ae59:0:b0:366:f994:33c with SMTP id ffacd0b85a97d-367ceacb515mr14464668f8f.56.1721055584197;
        Mon, 15 Jul 2024 07:59:44 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368155f7891sm4373260f8f.52.2024.07.15.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:59:43 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 15 Jul 2024 15:59:55 +0100
Subject: [PATCH] clk: qcom: camcc-sc8280xp: Remove always-on GDSC
 hard-coding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGo5lWYC/x3M0QrCMAxA0V8ZeTbQZNVOf2X40MVMA1pHq1IY+
 /cVHw8X7gpFs2mBS7dC1p8Ve6cGOnQgj5juinZrBnbsXaAjPi19KyatH2SPLiD1WGTgwdUFJb5
 EcLaqBTn4mWjqz6co0HZL1n9ot/G6bTsVVZQKegAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: dmitry.baryshkov@linaro.org, quic_skakitap@quicinc.com, 
 stable@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-13183

We have both shared_ops for the Titan Top GDSC and a hard-coded always on
whack the register and forget about it in probe().

@static struct clk_branch camcc_gdsc_clk = {}

Only one representation of the Top GDSC is required. Use the CCF
representation not the hard-coded register write.

Fixes: ff93872a9c61 ("clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC")
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # Lenovo X13s
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/camcc-sc8280xp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
index 479964f91608..f99cd968459c 100644
--- a/drivers/clk/qcom/camcc-sc8280xp.c
+++ b/drivers/clk/qcom/camcc-sc8280xp.c
@@ -3031,19 +3031,14 @@ static int camcc_sc8280xp_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&camcc_pll6, regmap, &camcc_pll6_config);
 	clk_lucid_pll_configure(&camcc_pll7, regmap, &camcc_pll7_config);
 
-	/* Keep some clocks always-on */
-	qcom_branch_set_clk_en(regmap, 0xc1e4); /* CAMCC_GDSC_CLK */
-
 	ret = qcom_cc_really_probe(&pdev->dev, &camcc_sc8280xp_desc, regmap);
 	if (ret)
-		goto err_disable;
+		goto err_put_rpm;
 
 	pm_runtime_put(&pdev->dev);
 
 	return 0;
 
-err_disable:
-	regmap_update_bits(regmap, 0xc1e4, BIT(0), 0);
 err_put_rpm:
 	pm_runtime_put_sync(&pdev->dev);
 

---
base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
change-id: 20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-274f11b396ac

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


