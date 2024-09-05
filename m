Return-Path: <linux-kernel+bounces-317167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192FF96DA4C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD6428665C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9319D08A;
	Thu,  5 Sep 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEybFqNL"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6B19ABDE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542948; cv=none; b=fY1KNaFSiWGmv8JYdZ5rYOEi2+vxwKM7y3RmKPVGJNjFq+C0Gt2id0vsv0xJd//h/APR6J+EXPR/pkeZfvsYgoCDL2+ytIn1rhiwqFoYDkpmILHz70bXtp2x9Tld3N71JKww5gynH/bZp9ROTx40rCAd2t2b9fTPhNGVuZTYrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542948; c=relaxed/simple;
	bh=5evTdunuLhVAJcs/+kUduc/E4egJQadthe4kW1wlI3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=USsq9d3O5hYAKjICpXtnOesEyF+iB02Rm7I5exISubJrl2IlVmvhBetlCjIRxIOXb9cWNe+Mx+w4IoBL8t/qgzSr4KznGdFClzZfV98kxoZg0l1acEVLKxqI5xomBTBzJHL8uVNApdbwdz6NWA6zvGqxGeeiNY4Xk2i1m0K5U3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEybFqNL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c2e50ec6aso4613555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725542944; x=1726147744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mmo44zFx8mrvsxCT8MsK26g0o98DN2eXGHyiYlsG/6k=;
        b=FEybFqNLjPU3DSuy++aT6kG/iP1oegSY5KCdeqqtpy1yBIZqKmg4BBKbqHb5qOifpi
         1bGJq63JCO5uq6BKdnPveSslvcPp7/9ABiu9lFM6+A+dBuzBPY5j+4SoZqPyb0geF4sH
         ODh4ZMDycG+Ui0zyPBAQ92c0VZW2/akNGxnOTCnld/PIFvR+nobySiw22C2ZFtpp1Oj4
         fPsg9eTZTkJBdXmdYHbj+V3K3nYDmCemIUeF4aLKcWMSXCL/C18PDWGmTkpaE9b+iVAh
         0S8iywz3b+aPu4GfrCiqSXbBBo/sgvmrJiCTjaoMAAl452ljdMU4JzJmTbwU4YW2fEWm
         KtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542944; x=1726147744;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmo44zFx8mrvsxCT8MsK26g0o98DN2eXGHyiYlsG/6k=;
        b=QP5w1f6ur/TuuCiblrhbrGroAz34PlKRIFWhODOqCk+f6SqaUIEjUjyeVB2iE5iCYO
         bMd63MRVWH8OuFDMNiJbi+R2R0W3+kWkDwstImCQkC1YM4Tlq72DBYsygx+J5B7hwtSK
         ShrakOBKwAAJZJyX0+DdReheTCQBezlOBFYT8hb130m2w25GQSDA0otj6q2RP03zCA38
         vckiba7Rkog8kYUzFAnoGCpYYJwG2Zo4slB0QBYiN98/+TolHPKi85S1l2Dybt5EvAUq
         tgvatvb07vEZc7w/RKB0QEqWE/1st58bX7c1IwihKA08o37j246N1CsaTSkyCVqJ5xxt
         3p4A==
X-Forwarded-Encrypted: i=1; AJvYcCWJmJDyBMc51E1QMcXH0L6voQpTpM0l4wnDMr+SegiKFNzdREJE+t9kk8cGkN4K4oCHOfBqLJNqQ1gU690=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzlkjQk2vYCsdJDiIzLUNwOLXJUszCDTawxgJji7G+L6lRGIK
	ZpL/J4Q4VkgO/CTRxEtvaRHxx6gzj/mInBC86CAhXEq+X3VZQPcv5hkAHkxEJb+0Wybv0R2tKYX
	X
X-Google-Smtp-Source: AGHT+IFsWenqoAd2RFaGr+OZ74a6/40O2rid0oEltUVZXpv8n2OTkZHPQAC4DFZMtytig8GfX00Tew==
X-Received: by 2002:a05:600c:3ba0:b0:42b:b016:70ce with SMTP id 5b1f17b1804b1-42c95ac1978mr35442465e9.1.1725542944053;
        Thu, 05 Sep 2024 06:29:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b9859486sm16167785f8f.111.2024.09.05.06.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:29:03 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:28:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] power: supply: fix a double free on error in probe()
Message-ID: <9c2f76e7-5679-473b-9b9c-e11b492b96ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In this code, if devm_add_action_or_reset() fails, it will call
max1720x_unregister_ancillary() which in turn calls
i2c_unregister_device().  Thus the call to i2c_unregister_device() on the
following line is not required and is a double unregister.  Delete it.

Fixes: 47271a935619 ("power: supply: max1720x: add read support for nvmem")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From code review, not tested.

 drivers/power/supply/max1720x_battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 3e84e70340e4..2bc3dce963a3 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -427,7 +427,6 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
 
 	ret = devm_add_action_or_reset(dev, max1720x_unregister_ancillary, info);
 	if (ret) {
-		i2c_unregister_device(info->ancillary);
 		dev_err(dev, "Failed to add unregister callback\n");
 		return ret;
 	}
-- 
2.45.2


