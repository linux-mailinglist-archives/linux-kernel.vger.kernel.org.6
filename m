Return-Path: <linux-kernel+bounces-416153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B899D40FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9752836E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17641B0109;
	Wed, 20 Nov 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjWA2Fl4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F71AD5DE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123131; cv=none; b=HldJqsJoWBgS003c7bmvPLYGc0Q7cd0/IVAXHOKdxgXVn3818EJnDayFYusJDTkYq0IVxpvlTTa+N2l81CbW7hksjcsCy82aU+12nx+qMTOs4DS1uv/S8xkBKPPOUTGe4VGp5yOQCfm4hMoxK4P6OWsRH4zM2OC2FNCSr3o6KUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123131; c=relaxed/simple;
	bh=S7sVTT+BQCDyJvL+YQlxm6ADZ+j/s89qtEt93n6e5G8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HgnV9CuBcXNA18keSO0u0KZUtQDuFH2Vjl6X9dw7aTLXhdi8cpi4nFshKW/IS2bFiLuF6719B/FrSPMyflBt0uQLhdCtaOzgK9OipTWNyVnKPI3T6D6Jtvlj4Dq7GVQIGJpTMaRGWlr/0e6O8fQXxsUjJpzqIXqxc6khs9riIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BjWA2Fl4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43169902057so59195085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732123127; x=1732727927; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkJOMjQUTSactWFyt220pM1QP+p6v/Z5uBayhWP4whA=;
        b=BjWA2Fl40fEmh4/KQIHP4u20JnhjSeEACz6EVQpRt1ins34DMVSngHMvfjIeQavn4O
         dcf2ksQPi5rGmB5g/WOS1YTHsPvm4mtxlANKBAsxAAVH1YA9cTlsHrHr0QEJ1pgPw83Q
         p3YQnfsbtf50zc7JVq7fSZzrdKfrii1GhDrwLVRLj1jcicH62NlOa+06osbYj/LST0k1
         22/BXRLSgwjNbrkWzZoYRnV932YSyJBPAKtjCa7XONmOpqaNKpNOgYhYFSqxsVOLj7hW
         5PwkEmMPucrbnFvEglBuWMnlxUYciokQHr9SQ6ceP7F0SbRANQ6tNxFDPvUIzwNO/o3H
         gNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123127; x=1732727927;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkJOMjQUTSactWFyt220pM1QP+p6v/Z5uBayhWP4whA=;
        b=ZuuJNdaFfcxsVJRYZnOtudT+vCXrwUyxgA+4FeFIiY7tLCoLQVodterg+nXMzF6+tB
         OwcI2pggq721h8YUZYhBVBok1xleLgkHeYRIlXbrXJtydNXQ5s2nyZFwhKVB53J3VzuG
         SPPfmXjUDnqZx3Skuizro5O7Y3IhaAFF6B+N4iE+rYDe9uoHnC2odR09xMrtlhpv47n8
         bjrIzYfhscL4nGr+qF6au0UvHVIMh69RY+8VrA3c64yPER+DK0hr4PPcDFdB42WtxqAO
         7YIZtkFRN6qeB5NLwIJMYnM5Ps9cVQSbFbxOo9OACPOngMUE6Az7CONWwhmUi18TsOvc
         jovQ==
X-Forwarded-Encrypted: i=1; AJvYcCV17izUQQhYcpbNGqm93DySBP+i7YSgcNVdLdeQ8dFTX2hRYoBpaEqSSP6KYsG11hbyMlNg9fe9Puj/t4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqIGrGY34eJv00DbgnVJuxAUwHLAO9slKs4M6PvlcWspnEY9x
	CLM2ajK2lqbIEDGhRpH/6LZYQwJxomjJ/3QoOGq8x1oxJ7ajwdzGTdmc/jXD8GE=
X-Google-Smtp-Source: AGHT+IFij8ZHbrHGnZwpofbTbq17XmUYoHM7wwOZwc2/mHQ70jtcHcBKktTC3s8tkz8+09L/SeJAig==
X-Received: by 2002:a05:600c:1d0f:b0:431:5187:28dd with SMTP id 5b1f17b1804b1-4334f021032mr27206045e9.28.1732123127205;
        Wed, 20 Nov 2024 09:18:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4642b8dsm25797235e9.41.2024.11.20.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:18:46 -0800 (PST)
Date: Wed, 20 Nov 2024 20:18:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] clk: mmp: pxa1908-apbc: Fix NULL vs IS_ERR() check in
 probe
Message-ID: <d7078eb7-a7d6-4753-b453-8fce15245c34@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_kzalloc() function returns NULL on error, not error pointers.
Fix the check.

Fixes: 51ce55919273 ("clk: mmp: Add Marvell PXA1908 APBC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/clk/mmp/clk-pxa1908-apbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-pxa1908-apbc.c b/drivers/clk/mmp/clk-pxa1908-apbc.c
index b93d08466198..3fd7b5e644f3 100644
--- a/drivers/clk/mmp/clk-pxa1908-apbc.c
+++ b/drivers/clk/mmp/clk-pxa1908-apbc.c
@@ -96,8 +96,8 @@ static int pxa1908_apbc_probe(struct platform_device *pdev)
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


