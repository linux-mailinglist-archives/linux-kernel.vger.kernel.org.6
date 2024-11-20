Return-Path: <linux-kernel+bounces-416155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4AC9D4104
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CB72833CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD601BC086;
	Wed, 20 Nov 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSRTU90A"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6271AB6FD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123152; cv=none; b=mltY6ehr0zGGoiZoivVUV80/7Lpg9nGjHqzB+eyEtX8boaW6Hb6S00oMAxuckPGY618Di55BF6nrHujzgngv+wl1zJya6vD7KdNy0JUOHCpcopEyZI8uZOyb4pSCD+PTi7bVXYKzpAxn37vVAzEJPHdqSjG+neokSpcW4HFVNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123152; c=relaxed/simple;
	bh=aMlj912aJwM7LIeO5svmmFwooxRnaRCe+Yl+8o1KcuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KoB8y58VBiTKCH7otzjAu2Tz+zWXIHrnwk50mbBt038AufAOBK1Ule9cmCJqtdYkKQyIz4x+7uSuZhksvILI1OZnlw2mnqsdwpuvZdONXcDOyyiATkZePSkz4WUJY4JQ3CxTLCQ2KURZMgwqeLtFbeG5ToOwouyDsy8Emz4hLg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSRTU90A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso43081615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732123149; x=1732727949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyiP0MxQdAmx7H0LainU7jczTRUd4MKDrKPjA66RP3I=;
        b=SSRTU90AB/FImv+Oov9FKEre//n4Zjo2YM3ajRDib0FrfNHea2nQSIa831/VtMnZ24
         oyMWbYFWfoOSb0k5S72KEjC6NtkolS9TVwXr5ouqboocuSl4ReqHMnvLxTWM83SnRNKg
         wM4Gfub9gxxedKd7ZatbYAvvqurwNHCMlf/ouiVvMyxhjaqVMEjA8+OQfB4dtSYcxDfm
         ilkE+H5hbCK3LruVQvSvH9YMfYWCckp9hjWH+vGfaf+vl9M/Nn/0VmXNbh+uzbmhGndK
         zfNRO2ukBXMSSzLO+HIjRXJFeip2NbvJRqfzhZe3zuIQeFZm0lpNzrBr37WXYZTDA8dQ
         Cyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123149; x=1732727949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyiP0MxQdAmx7H0LainU7jczTRUd4MKDrKPjA66RP3I=;
        b=FYxRrLsRuoBcFm8B6//49JRmhEJyEO1KkIpAnTAh6tz+YU1Qx+yg5FyNdNirGdc+tR
         Uhi6xD8l0mTuJ1NbeatImtivJf0biB4g1X5TmWxwKqkaVqYFKvRkttUvhbfmGgui4K88
         ksD2G2+gxOV9aHCacquPmrQqZwSSZRN7UfXSD+u/HKtk5TFnt2RA+pySBptd231HEgf5
         Ns+tUGjSvrRRkgXWrxwgDj2azsGQ8/o2mtQ0H1g7ceu1AgppXlpAaE+b6obwl5lzFMUy
         jiUPjwlBt9qKXtiHQkVrcp8uoIBdbpOVxTWsbB9VbL1mVmKiF6so8P7d5VOHCl0Ulc61
         x+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAnHBdmo+XiL7b76d4kIbc0fANJtR/3Kcxr3IRJgBAepwNP+BxbTWREWabO7yI9LUOOPp6MPpepILWTJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzso3EORuDr6qyIeDGCGn//7IpMPVaIoG8U8wOeGJ8t0X3iCRsC
	KoBTzAbbVHkpZIH4NXaiBkFdM47KzcdcXMLgRlhzmHo7HKcfXGWz9vN5R5S5Mps=
X-Google-Smtp-Source: AGHT+IG5JIx0KMSnLhIOx6fmV+jjW0KaoHFqxB+0+tP9hY+E93urgyzJG12FpUEVyW5mCoKbBXDttg==
X-Received: by 2002:a05:600c:1c16:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-433489ca97fmr35463405e9.16.1732123149443;
        Wed, 20 Nov 2024 09:19:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463b0d1sm25375975e9.42.2024.11.20.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:19:09 -0800 (PST)
Date: Wed, 20 Nov 2024 20:18:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] clk: mmp: pxa1908-apbcp: Fix a NULL vs IS_ERR() bug in
 probe
Message-ID: <6155067d-aed5-4799-9e14-6dff7be1cb3a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_kzalloc() function doesn't return error pointers, it returns
NULL on error.  Update the check to match.

Fixes: a89233dbd4df ("clk: mmp: Add Marvell PXA1908 APBCP driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/clk/mmp/clk-pxa1908-apbcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-pxa1908-apbcp.c b/drivers/clk/mmp/clk-pxa1908-apbcp.c
index 08f3845cbb1b..f638d7e89b47 100644
--- a/drivers/clk/mmp/clk-pxa1908-apbcp.c
+++ b/drivers/clk/mmp/clk-pxa1908-apbcp.c
@@ -48,8 +48,8 @@ static int pxa1908_apbcp_probe(struct platform_device *pdev)
 	struct pxa1908_clk_unit *pxa_unit;
 
 	pxa_unit = devm_kzalloc(&pdev->dev, sizeof(*pxa_unit), GFP_KERNEL);
-	if (IS_ERR(pxa_unit))
-		return PTR_ERR(pxa_unit);
+	if (!pxa_unit)
+		return -ENOMEM;
 
 	pxa_unit->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pxa_unit->base))
-- 
2.45.2


