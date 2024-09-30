Return-Path: <linux-kernel+bounces-343513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6A989BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC61C20FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4D168497;
	Mon, 30 Sep 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFmBFKnx"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD42A1DC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682700; cv=none; b=SjhQoe5tYTCanZJuwfKOPhLJPPSgkxz8mNwtOPcfKJ943sJYpV4gkKYnY+MTf2Blz2bfKph33leoe36y2R9B4Hs7VMqFtCV7iTAYWv7SDSm1Y/KsRUai8PyfU9LYycCP1l3Gt5fdo+Bnvrp9SZeRwZsq1xAyjCylmKw/xYdRfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682700; c=relaxed/simple;
	bh=TNlfPXvCSXrywBW07xjSEhEu5J7xV2EvmCrnlOk0vB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o4UZhpisMqCa6SNyKSKjFydXoUbwffHNV88pZ/uL+feU9d0loyQmXHhh4hN+3PDh9smnz1Dhzgb3tc4xC0cMshByaHjgVKYFpRCdGvWFfPhhmg7e/Wj7NE5fUqCgM5MJXnn9IwTrOJ7f30bnc9giJ6d40ghXC2nxxGU4tZcugUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eFmBFKnx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c882864d3aso3558526a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727682696; x=1728287496; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HtLOXTTjIcKqonfJsLlHp//JVeIA49rEwOK0SKZI6w=;
        b=eFmBFKnxICtKJC2VYAdq7exIs/1DDP41NTsN/129lo5VKOwP/x8ctl/0STdnuGArTP
         E1hTKB6Zmacmiu53nF/y9PcMB96adApXn+XPHyRCdmXJC/8V55QbQScXBOuTp9ELPFnh
         4xPt31tDrFxxsJn7Vprf77YLBFKUg1ZWG/sJHYX0jU7cwi5C2TkSyBy2pY7mUM9JD6CL
         +V2YRA9iBH5nOziUncLJgOUvzzjDH4auLMFGTht8oIbULt8m7TF28U+7ehOAgAxN6tIE
         sXUJ1x0/autbyOdjmxrcUxqghEouKdUYzq+L7pvuy8Nggu0C59oEAF2GfrTho5YVATB9
         lVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727682696; x=1728287496;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HtLOXTTjIcKqonfJsLlHp//JVeIA49rEwOK0SKZI6w=;
        b=JSvP4FNOqVAogrjxmI+Q+psnAjsD3aeRpJLIFpcZr6XG/59DBzG8ubR0NVPizO/BKr
         Z+RsuKYFmz6da2ioSoPJaE+oKl9MLp9fkYKCkOu926b3M6lxNGVQBOlXNMAIpbAbG8nr
         MsiMKAJA8RAoHEbmE/MFety03FxY5QlmQhHTGl5oxinUmgMX5pa49BkF9JN/zZ0lH51J
         jq7ikjMO9Bt3XhPIjVYnMTLTwcMSAI9L1D0ifJvwLX6uxklQTspMJTBf6QB0goDV2eoh
         7gPo1GMzSBBIk8xjvNbXe5BpZkou4g9t1B8vqufU439Mj+FfVa5S8OMHjIJZWNK5hyA/
         IQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCXDmgX4M+DkAq8QdxhgMFUdYpTjFBJ8Xiv0NXHIBc4pCPzk/QG3QlCo9QnxjpOkOtfkmzZacDRZ9fhLNjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoWZH+Q0zDjQE8wHl50Z+wT/w0uwyrYbhSJn3c11Lwdy9fjrN
	amdmCWAgVJPuk56BvkcDr/NQ0HM6pX4sPp08Mus3c/QPdFp9SPSMlLfnRNIPImk=
X-Google-Smtp-Source: AGHT+IHNGEtodHztnoGGjOwFV0dQ3UkYN7qzkRnQryDHhNT5sSIM9HlQ0MdjV9+ul5NE0K8elqMvOw==
X-Received: by 2002:a05:6402:2406:b0:5c2:112f:aa77 with SMTP id 4fb4d7f45d1cf-5c8826085ecmr9855869a12.31.1727682696042;
        Mon, 30 Sep 2024 00:51:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405ce6sm4127857a12.13.2024.09.30.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:51:35 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:51:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Evan Green <evgreen@chromium.org>,
	Andy Gross <andy.gross@linaro.org>,
	Girish Mahadevan <girishm@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: qcom: geni-se: fix array underflow in
 geni_se_clk_tbl_get()
Message-ID: <8cd12678-f44a-4b16-a579-c8f11175ee8c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This loop is supposed to break if the frequency returned from
clk_round_rate() is the same as on the previous iteration.  However,
that check doesn't make sense on the first iteration through the loop.
It leads to reading before the start of these->clk_perf_tbl[] array.

Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 2e8f24d5da80..4cb959106efa 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -585,7 +585,8 @@ int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 
 	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
 		freq = clk_round_rate(se->clk, freq + 1);
-		if (freq <= 0 || freq == se->clk_perf_tbl[i - 1])
+		if (freq <= 0 ||
+		    (i > 0 && freq == se->clk_perf_tbl[i - 1]))
 			break;
 		se->clk_perf_tbl[i] = freq;
 	}
-- 
2.45.2


