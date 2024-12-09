Return-Path: <linux-kernel+bounces-437478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ABC9E93CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E36B1887020
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A482248A0;
	Mon,  9 Dec 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwjWWKg/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B82224894
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747059; cv=none; b=fAAZBxfDgFEPKdaAUi9F+wwjFRLMxCvizU0OezK69bCSD83/W/bZLPt0SzDunDSCXz78PL6Fav+dt5gxRkh6nCyB6zSFLMGN5n882JYRp3kzPq6aiR76FQywQpdoOQWAtpq7NpmkrBvibBSA05gPeZ8jeXThHsP4CvCPGt8GUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747059; c=relaxed/simple;
	bh=dXTvMwZ3IWa8w/PCirVYpiMdDockPwSZQVUAZm7Ua1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnxec4hgdcfX4hroVH+Tk3nWonJQtqOfFRKf2FW/pbEoWtDpmlzwZFQD5Z03ELAddr8pv0MIGrc4IR0ZeZUHz4Ms+rBto9P6XT2GnLarbVcJIdIfSn7hrV4jb7ekpWYoVUQ18R53uvCQCPLt7wj1vSR7n5VcOsGx4RfkeDEwAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwjWWKg/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa680fafb3eso11770266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733747056; x=1734351856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoCVrD28ayqu5D/DI17RscermoixTp22627F0aNO5EA=;
        b=ZwjWWKg/iwSlnFS+GTCOaFYbL/Y4ag4IGujXPUwQJ7U5gJfs9Z6M8NxNePkPFWv3y4
         lMUNLBgNHer3UmMQVJEcXybf/nDsJX81h+juUNafmMuMUtbA6Os0ukHNci4yAnj01pKN
         tcUr66SbmlX+a+5Ilk4I12bdQKKdIqhMVmubbrVAXwH4cOkBd9ODOwrUuypzD9V0FhWP
         mLdLzkNrwGwWcJHC8RwRn+sLaFzqqBGYDSQ8rF1O1weHkM/GxDbr6a6oaEla6WbEB+Ta
         itX9PTo4/Rk2U9dTfYxnc28QEXup+J7jEGlRFvQohb/5aPQc+TjHX+EetdY4fSnk8zrh
         pshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747056; x=1734351856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoCVrD28ayqu5D/DI17RscermoixTp22627F0aNO5EA=;
        b=tvUyV6vi8IMIBDQN6w1yzJgUN4q6maFSgRC6gKxTM9EbeMUmfJNHWFRadNZRQplT6V
         Ii+XrGgNbKG/1dRP70s9ln2AKjFlpSPUQt81I7lm+lQZQHrwWSuV548bxEXg8f/7BOR4
         zBtRtyQcbTjF1qkK0sfZJdv7cDQPcbCb/4v2ZD76q98InzsQchKrfsowLkMrvWTGzgMk
         3iHdqp6luAAMTXyVW+5R1LkA+EDWX/m7Und0L4JVvqaxukdBos1J0Bswn1wxfCbMnFOL
         /Mh+ySzcGn8wMKaSpLzLeVdJYjZw8tGzWkAL/ONUj4J+5KmEEwWu9BRSVSV3gr1lnqhO
         fR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqBDG2inlAzC3QAagBt+a3xg6em20V51lmP780thR5GK+f6A8OvtvEkWBvTLnSOe8bV8hJBJShI8OjXe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQO65XhSagqykmq1KOK17eKBG/qPJCVEJ/pTlMXjSuJGAUhUL7
	bnDDNpzDtcyy83VnWA6PghgAP8wU3HNSbUzMvLyFuWd0cekxM5Q7nnKXEWjL9u8=
X-Gm-Gg: ASbGnctMBi3bsL/ath597AquSooK6d8L1zSbWz1eSlHni9R4sKtnwS1+6BEl++I7B63
	1v0mBQTMGjdjAfNLATLvsV/c75A/khV7rdml2wo8PyZYBtHRZt1cctf8KAU3NO8btI6HnhH9to7
	teC4A2ODvZDgA+TjM1HncHLMMcUShXk8sef7YX47i4m9Ngg4t7PdVh/aQnOt7L6JLC8w+I0EW7R
	dGRSchh1YIayNTRL8FCCJHleODJxmYi6xVa2HRnGrRqkt3J3rIywNZ/hYNwbRyHUA==
X-Google-Smtp-Source: AGHT+IEL0p06Hwmo+9E/f1lCO4dyZG2n/TdjzYJd+woyN99M4MYMI2vd+kMHzKES2YH6I7KFGRLVew==
X-Received: by 2002:a17:907:c008:b0:aa6:79e6:5b03 with SMTP id a640c23a62f3a-aa679e65d87mr176768466b.6.1733747056131;
        Mon, 09 Dec 2024 04:24:16 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66b96a249sm309925866b.159.2024.12.09.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:24:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 13:24:06 +0100
Subject: [PATCH RESEND 3/3] clk: qcom: spmi-pmic-div: simplify locking with
 guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-cleanup-h-guard-clk-qcom-v1-3-b1077540230c@linaro.org>
References: <20241209-cleanup-h-guard-clk-qcom-v1-0-b1077540230c@linaro.org>
In-Reply-To: <20241209-cleanup-h-guard-clk-qcom-v1-0-b1077540230c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dXTvMwZ3IWa8w/PCirVYpiMdDockPwSZQVUAZm7Ua1o=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGdW4WqjVaZZPkcN8v9OPTJHUcgo366JtrL28bgL8+92JHHiT
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJnVuFqAAoJEME3ZuaGi4PX+/cQAJk+
 Nt95XiYbAfyAfpF+qC/Os14df5UkJTTbXxd/sOxHbKrDVc8xSx1fyqDWRaTcOD5Pe0wiD4glAzh
 FlXAenPqrW8yS3Vsne+gjpl3Yy9MknYypm+Wieyxvw3Uc0WUYJ9J3uf24bzJk/a0RGQIG/lq/Qw
 oOH6GoFnzTfQCDQeILelFLUkuYrnxQi+k1rs5rdVVL+8JYOBNoOVnjcA3DGFXvHmfWlV+f5xJcF
 JtcXMOUMZVrhra+7Tp7oLXbgaANGpci3rsCG+1cYV0OHsa0nqSivyPVfaIvX2PeBYJuiRUxbnBM
 /07FS0Cgmh4IYDM/zGJUQpXv66VARq3957sN/+kxJa3aOGa7KUjn8GQTZiu/pr5vr3QHA81ou76
 CbqlYK4hEWS59pz/LAp5afj6TZIHqK+4v/oHQfttCrpGI+nojazSGCIlC0oA5Pkvz6rDlllc19n
 YEo90GQZW5Z06eYCyzJ2UocPPDpWsGI3vU9aNgpXoT4RYLSvrWUXLcLR3WyF72Vsa8mCH/oEVab
 oDk2Vl6hs7wb/GtKKh2ljMeeXrL1k+JuSnERSXmF7hPTqNNvlJF7bO7xJVX6MJZOtxhuz5ELHyT
 j8Je7O7bNIj7bs58E1Gfvfdo69Pk9YphLl8kHumVDITdXye1khfPUhziiSbxHT8okOoRoCITbw0
 ymeVV
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/clk-spmi-pmic-div.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/clk-spmi-pmic-div.c b/drivers/clk/qcom/clk-spmi-pmic-div.c
index f394031eb0e520b1b59e863dfbda4312f4f8215b..41a0a4f3b4fb316827365a522079dcd99630c49f 100644
--- a/drivers/clk/qcom/clk-spmi-pmic-div.c
+++ b/drivers/clk/qcom/clk-spmi-pmic-div.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
@@ -140,30 +141,26 @@ static int clk_spmi_pmic_div_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clkdiv *clkdiv = to_clkdiv(hw);
 	unsigned int div_factor = div_to_div_factor(parent_rate / rate);
-	unsigned long flags;
 	bool enabled;
 	int ret;
 
-	spin_lock_irqsave(&clkdiv->lock, flags);
+	guard(spinlock_irqsave)(&clkdiv->lock);
+
 	enabled = is_spmi_pmic_clkdiv_enabled(clkdiv);
 	if (enabled) {
 		ret = spmi_pmic_clkdiv_set_enable_state(clkdiv, false);
 		if (ret)
-			goto unlock;
+			return ret;
 	}
 
 	ret = regmap_update_bits(clkdiv->regmap, clkdiv->base + REG_DIV_CTL1,
 				 DIV_CTL1_DIV_FACTOR_MASK, div_factor);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	if (enabled)
 		ret = __spmi_pmic_clkdiv_set_enable_state(clkdiv, true,
 							  div_factor);
-
-unlock:
-	spin_unlock_irqrestore(&clkdiv->lock, flags);
-
 	return ret;
 }
 

-- 
2.43.0


