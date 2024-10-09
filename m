Return-Path: <linux-kernel+bounces-357372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2C99707B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD61C22D56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35191925B7;
	Wed,  9 Oct 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l9aua0Z1"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90D1DF275
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488509; cv=none; b=XbMKnXsT6k3SR4GhdThu7Yi/3igEtFcgjEGVpTk/VaMGz1MNMGmOcO1yIcy8GPmFHqBYexac8/UsdI7Tto9Lh3/YoN+sxTjpFibB4/EOPxGqMl6r0hh7C/95CpL1bKZ6/tq9r6Pb+NdQVOHQcLMiOJzI1nWX0z7QttfJn84t/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488509; c=relaxed/simple;
	bh=mv1rqLSiLOHCZU0q+61i6vEQA6V5lDbT2Ykwn/MSTnM=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phQkCtItQpeLSEJJEKazhMq6Y3HQFyUsTQ16lo4hcCZMF2q/9449QahBD5uRMl6LsvjWeG/8OGRz8CtWNlGSnX/l3cmS3MZUZqgtcRUZBkLt7xCn8tmWm3T+TUbZLH45XTHPdCUksx85m/Ce9oPxFQJRTGaVvhSMDvZ8LMriR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l9aua0Z1; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e4d649cbc8so170507b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728488506; x=1729093306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gd0Hd1MakjxQ8aCm1xPSRU0H3xeGSc63YXhhZpX4cc=;
        b=l9aua0Z17OfgOREv//Zmb7jjzBV+DZOg0abPjFY9/A6q2+SkT/dhQJSghw+JdM+e6E
         I9za6MlHLEmnzkR33QBwBDV/1AOkUlGRDaUd/5BqghL/z+Yim6sd4FkF/0P1kknW2qF6
         hXqECRymSVYR/dW8MIAFd9YM9mfhaLc1SKIhBOmMB4nhCMgZeo947uCNE68++0JwhiY3
         uLVc3t8lJ5mJRZsw4ub/pjS/OJqSv+IJ36up72ghIPaPRhvPypd3DpBQ8adchchL0aCF
         ugsRhU808gkg2xPl1WMGGBzdAEqrdxnvOa1EUqxdU22hSjG04Za6XjsMqB5naSjOf5qq
         gZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488506; x=1729093306;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gd0Hd1MakjxQ8aCm1xPSRU0H3xeGSc63YXhhZpX4cc=;
        b=csSsrovKidcH4zix9Z2ZEo7K4UQ5O47B4awI7u6OCp9SaGD0G/xGx/G1DQqnAO4Zp2
         AfVs3FMUi9L2RuTSZdZ+d39fuA6e0xjZg1tui48RoqJvyvKYBx6JdMeW7DOAOv1rlZ+r
         8eZC0xu8FIplrxviCc1lmbviMYNXPncGphEbRVLzFH9R/jYthAMTKFYTsohW2SG0I2b/
         47lvAsN+pGZ31tBXyDBEOu1ywFzisoAzJofzDdrQ/VVn/CPA1URj5cmRl5CbYmOsWSvd
         u++UJ6C/qvv26HRUgBbTRFV88wXcH6Tsu7CSwcUZGzGUEJuO/GEgLtD1t4gbkQKFWJjN
         u+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuu7G/TB2YsKM+G0fxuPIydjEtFYuvyCok2J30WtNpGRyUOfJtQR46KpogdCkIN50ulFnu8zzwOM+U+0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7FPwOOT2WhDVPwEr4pr82YvVpJ9JreLeYaWICga21/djD8ST
	4oywVxY4nO8/S7m8fKmGP8U+a65g+M226Wz2maoblTfjzeB95v+OQVT6zfEObAGsClD7xgfUOIu
	7Vp/zIDOv6oeaJs4rNXNb2QSigvBIyBVkx2dtzw==
X-Google-Smtp-Source: AGHT+IGSAbf5K8peyNanI54kI2R8bIyKMUOuELhCM3eQhZJMBHU1uq8bm5qKHyh5KBHiKy63ie1sfKPMxntzRYNSqt4=
X-Received: by 2002:a05:6871:7505:b0:288:2b44:5577 with SMTP id
 586e51a60fabf-28834458deemr1908641fac.18.1728488506041; Wed, 09 Oct 2024
 08:41:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 08:41:45 -0700
From: Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.8.7
References: <20240927153305.27642-1-liankun.yang@mediatek.com>
In-Reply-To: <20240927153305.27642-1-liankun.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 08:41:45 -0700
Message-ID: <CABnWg9uGR1yn9EsRaMjihksL76dwUv9vEi9eF=OCpzLfTvyYLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/mediatek: Fix potential KP on 0 bytes nvmem
 cell read
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	rex-bc.chen@mediatek.com, msp@baylibre.com, ck.hu@mediatek.com, 
	jitao.shi@mediatek.com, mac.shen@mediatek.com, peng.liu@mediatek.com
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sep 2024 11:03, Liankun Yang <liankun.yang@mediatek.com> wrote:
>If the len is 0, kernel crash will occur when performing operations.
>Add the len check conditions to prevent kernel crash.
>
>Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
>Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
>---
>Changes in V2:
>- Fix the commit title.
>- Remove blank line between the Fixes and Signe-off-by.
>- Modify the judgment writing method.
>Per suggestion from the previous thread:
>https://patchwork.kernel.org/project/linux-mediatek/patch/20240925084116.28848-1-liankun.yang@mediatek.com/
>---
> drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
>index d8796a904eca..9ecdf62398ee 100644
>--- a/drivers/gpu/drm/mediatek/mtk_dp.c
>+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>@@ -1082,7 +1082,7 @@ static void mtk_dp_get_calibration_data(struct mtk_dp *mtk_dp)
> 	buf = (u32 *)nvmem_cell_read(cell, &len);
> 	nvmem_cell_put(cell);
>
>-	if (IS_ERR(buf) || ((len / sizeof(u32)) != 4)) {
>+	if (IS_ERR(buf) || !len || ((len / sizeof(u32)) != 4)) {
> 		dev_warn(dev, "Failed to read nvmem_cell_read\n");

Hello Liankun,
Would you be able to describe the crash with more details?

I'm afraid I don't understand the fix?

if len is 0, dividing 0 by sizeof(u32) is 0 and thus != 4
So to me, checking for len != 0 is redundant?

Thx,
Guillaume.
>
> 		if (!IS_ERR(buf))
>--
>2.45.2

