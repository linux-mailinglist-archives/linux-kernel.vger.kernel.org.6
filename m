Return-Path: <linux-kernel+bounces-176742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7448C33F4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC53AB20DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55345BF3;
	Sat, 11 May 2024 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCRuRaDv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB224B26
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715464570; cv=none; b=WcqAmlzGwV0/utcdhiZDuVsO5fyudq0UicHYjerxcVY4jiERUZqkFjYNbjL1fXDh0oKbQ5F2kwEsOgDQAChJ1UbH6cIxCfTMgYXle3/Fw42WgQRtYkK9tqbbu0780UvyHIMw5OoZkC+BkDdruBpDwsYlnfcGd4ulMo59uBeiHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715464570; c=relaxed/simple;
	bh=owB14EagmPWW4gOZA+FP/m7NDDNKyR5GX/j8+fIMUws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjjvcCNg9sycxUrzvL2tDaH76padFQVvJIl5pn37SFQiao8CkUsGU43ccz2QZNbBfWLofbVCEg4fJbrHx3HxBE20IxEoNvvfGoVqDVjmKddH/jdmo3ujoj57nROKJ/wCpndYu+4K5IT9RcEoN66Go297ZBovjnU0k0AxtF+tRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uCRuRaDv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f174e316eso3754634e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715464567; x=1716069367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvgC56LyaFUK4C15m3b/VQxk0Rs7izNvxRwmFZWzOTk=;
        b=uCRuRaDvTYZu3Dt+uXcG5QSA4Wr0Sdoa5zCLVEajQcoGxQHgTHsFp5sA3zcPKtDuu8
         4jlypyOttBYRLLXYcfaGRouUtzmM3/FNp+rA2jrZj3LZ1mZogKdgvvAgYEUzvDiCusPX
         VaRrEQDs3MLHL5W/42+w/Jl3vm7YBxxDMPhwGem29AmBR0MBhl9CQjv575ONdJ0bDma2
         kY/TxVixp9WxBfgvHVujhXuCnIw+uhlVJFqb1KaN8+scnvyRXy/02JVFQF82FdSdGvQD
         RzJ+Qh+wlHuIYivy4trJTFVEoPNPj7DgFqplmfnCxQMgBqARS4nJ8/vU2ayaWbEDZCv7
         jkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715464567; x=1716069367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvgC56LyaFUK4C15m3b/VQxk0Rs7izNvxRwmFZWzOTk=;
        b=BPFTkR4GCdbdtQsTnS6BzPaVorEkHyZpCI/s6Mf5wfGkKdJhkRyiOOXLt+mG1Lilfr
         ez4wLKtsyL1CXnGnct/fy8km/davB9q0wNzMjct+Pf+6ymqtsfvUw1d9xfLmymlat22L
         JYtZ+19iPFarYIq2YI6xH+itB9AGCapgsw6Pcap59zbrfeH//U0rAmdQUa1BeZsgreZP
         yCOtIJSRFXso9v6FCSHxtEGgT/Ks8o77fo9hueef7Dk/QFRpjORTXmebSaK8EhaL6nPZ
         PXiYXUr8R2yppb712TVb7/aKn5ZjfEm887zrnDRb7OOt7ex7ehcYJ8mrPbvt5sQ5I7VI
         aJCw==
X-Forwarded-Encrypted: i=1; AJvYcCUHN0MGa9CGQIXklJ5yXJiLv+NBFPJK/7UYjTKePQkULKHmMNFRFFcejxz5Xc4AWz38+redb83byL7vs2oipOf7E9ACnCszlRQsed7q
X-Gm-Message-State: AOJu0YwPAmSaG4kTssfMG8NLR6NZE0igrgFtmMTHO5n+hUKamtDzNjaS
	7VsUUdoztPUmOlgdYlqtu3KkE4LhNAkGzNOp77JuSbztu10zAYmkmFtGRwMXi64=
X-Google-Smtp-Source: AGHT+IFYxL4clAyZO6ReuSvucNP2UlUV8QFbhZhfnT8q9vcLw24oEbuwzQ0X+Fur4wC91h8T5liN3Q==
X-Received: by 2002:ac2:46e7:0:b0:51e:f68b:d266 with SMTP id 2adb3069b0e04-5220fe78ceamr3485972e87.50.1715464567182;
        Sat, 11 May 2024 14:56:07 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d31d1sm1127576e87.286.2024.05.11.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 14:56:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 00:56:04 +0300
Subject: [PATCH v8 2/5] soc: qcom: pdr: fix parsing of domains lists
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-qcom-pd-mapper-v8-2-5ecbb276fcc0@linaro.org>
References: <20240512-qcom-pd-mapper-v8-0-5ecbb276fcc0@linaro.org>
In-Reply-To: <20240512-qcom-pd-mapper-v8-0-5ecbb276fcc0@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Xilin Wu <wuxilin123@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Steev Klimaszewski <steev@kali.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=owB14EagmPWW4gOZA+FP/m7NDDNKyR5GX/j8+fIMUws=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP+l02sEGrQpRPdi1hPa1DAZOE/JO4CuTM1Dkk
 wrPcB/JaQSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/pdAAKCRCLPIo+Aiko
 1dAqB/4nkeRSMzX9CaTIhgjF60nM+tE0UzqvRKW1UHEMWlJEbUSgo2xYkBcv9Hu6VcZXnN42ogj
 4ZHBlplcE/2NEnqRlwrXNu841a7E23gZLTVZCDoh1Li4BstRgOFFiIAY+cnUOM4JBNYc8LsQOdq
 qAVq1PYBbvfBaCjw/yGLqUlbSpZibg6W2klgGs0WIAgz3zO/iFF2zGuGCmk/OoQ/ZK1F0Kku2Qm
 NW4cjv04HgNfWlDH0UwGIDFdLiZP5Ay5AVtm9s7MmM/mIvM4b3VDzKRU7KroXscSNp6aSrtAcTu
 kQHIJA699+tBbqaeCvP/OoMVHN/to1+eLEd8B0vrWwtw2gOe
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While parsing the domains list, start offsets from 0 rather than from
domains_read. The domains_read is equal to the total count of the
domains we have seen, while the domains list in the message starts from
offset 0.

Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
Tested-by: Steev Klimaszewski <steev@kali.org>
Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/pdr_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index e014dd2d8ab3..d495ee736519 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -422,7 +422,7 @@ static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
 		if (ret < 0)
 			goto out;
 
-		for (i = domains_read; i < resp->domain_list_len; i++) {
+		for (i = 0; i < resp->domain_list_len; i++) {
 			entry = &resp->domain_list[i];
 
 			if (strnlen(entry->name, sizeof(entry->name)) == sizeof(entry->name))

-- 
2.39.2


