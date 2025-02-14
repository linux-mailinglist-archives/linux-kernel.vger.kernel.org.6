Return-Path: <linux-kernel+bounces-515199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD4CA3619B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8040E1892D54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031C1F92A;
	Fri, 14 Feb 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0KQb9os"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D24D8C8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546713; cv=none; b=OV4gP+ppH3JOgFiJbE9G3PwDA+JHkHnYRiilaI0RxQdbI9i0Auo1Bv1p3kXEDk84gCArj5eqDSQUaGekEaLpLdGykXdT2nfefAfeW7+igsxcE8hqmZi04//kjPh1RuYA2lQ73aJDcvBX5iuO1wFlGXr935gLSXH4ZmVeCYUIRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546713; c=relaxed/simple;
	bh=sVHPC/lBcsgIEQI5v6LxtJLhqrzFn/Ov1rcgY7j58bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAzLvp5AYWABvNDsnlUtNP5cMs9MsjfCLtPZLfN7CePKrhY5yI/abdtXK9VCx3FaBFpHjSa4UptVXtxfJTa8xDhW88BSRSXTmB65klVfClOrMKDSdwM/tMCQ1pwNGCDwXPh0+aAic21sr5VzMWW5LVLGpfcBlSOKKwAWMGDROIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0KQb9os; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-308eebd4938so20739591fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546709; x=1740151509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QV017oy9c2+67TXbcW6HEVWCD0Wca5ntOQ3G5XPdyw=;
        b=H0KQb9osSGyE0GqK/44oOM7crwOOvI3OrMa0NlR6CJu5OYu3fB22AA4BslvYcUJghv
         uWq2bZNp3L5RNLWmKQ5CX/rsgGQ6LvZv7eByv6u9pECVa7w/xYnpHugxAhvBO0Fj7QNb
         uJwl58x5tt76I8dm8Q9SfGWFp2aTyOxLECoJo7u/MzXdecA+iUpKt+VZdVSWkne9F2u8
         fQuU/4DQRim9NSp67cVbjSKq0GZZmfjqKnoAnxbraUWmjAOmhxEsEOkxY4zL4YSsUgLY
         8R/7OiArpCB+4TPeI0Fn59kuZMddunIyxtQXHmNwNmKRfvSY7VqTbmSQOfEpsPqtHj3Y
         ZKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546709; x=1740151509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QV017oy9c2+67TXbcW6HEVWCD0Wca5ntOQ3G5XPdyw=;
        b=pDjKKijXA/4I84iul2jHGjm9QwhhGdW+pc+M7NlbmDxiA/MMMv3dirr9k1Bx3DP4op
         /YbTV8eEoq8iYHe82JSu8scNO0Q1FU/sVL3iHxMxkrGIwRP8xvNWYbEx0WEnaJo4E15X
         ZCQ+4ttE5B0Jd8chOv8iz9M62r3zkTolU8jNYU2fmuq19Fx92/vhzuvLmsgL+1jWSI9U
         VjqNvU9xbbpxQaJcs2rxluBTskaRa9u3/PmdETKy12QaZoX8rnu8JYf7KrbAlmmlDKD2
         nnOL3beUzMp+z8oaQEbwUEtW/XLreNnkhqcQrSNQjkL274CiJt/fBK8xoADNQXg3qNh+
         Jzog==
X-Forwarded-Encrypted: i=1; AJvYcCWExuVkhrWe7OfLybpr25yup9gPIkF680nwTddSKF88+3XjRkSLO3mctNi50+S6yEGpUJcZbHVzzA+YVsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeS0GK0Zytgea52Tho6qpe06HO8ZIOTci8jcl0pKg5mY66HkPR
	ZOeNnez7d+5w4LwSHpIgEfO8HxguF/OufOOXpKTanxokYSWoEHeV8YxAs8Mf/l4=
X-Gm-Gg: ASbGncu4StZRYg8mR0DGjdgdktHif0j5DgcBDkHR7+yjr671H1WsvWsV/q5IlB9wj6b
	1qDUqGc8LhMqyjiwvueO7alSpMLgwTK5YwhMg5Cov+AuSenBYt48YeiBca5Y5BR3JHcPAnM/EyQ
	hr8eCaYimWiShrK+YyoxnKnYHMbtxTuvxERBMSqaM6SMpPWdguI6Laj0Mcbuyp1rZAthAJtkBqE
	dtplp6V2UIg9N4nXnR1YRbxqF+zp3Ftmx4i3yzeqAlOSpOX/8cDUbzKAKCeutfXwhnMWiLnz6Y9
	IE/zRc1znPDx5rJpy6QnmkCRrocv2P2erdhw0uZpwNW6ic+bk3f0aGHCr7t6qsANudjOFak=
X-Google-Smtp-Source: AGHT+IFEbu/Es9QSrWtt2Yag3f1NkYdoImR5hqO/3iTeDk8yGy2fux53rC1a2Q7G+vsrvcqf91Iq6g==
X-Received: by 2002:a05:651c:b20:b0:307:af84:3e6 with SMTP id 38308e7fff4ca-309037abfb4mr33795161fa.6.1739546709373;
        Fri, 14 Feb 2025 07:25:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100effbasm5921531fa.29.2025.02.14.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:25:08 -0800 (PST)
Date: Fri, 14 Feb 2025 17:25:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/msm/dsi: Drop unnecessary -ENOMEM message
Message-ID: <ipmzsjejxpdtpknjbvhn3774nkkm722qtuwvhnv5njnl3afjei@p36q3euy5j37>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
 <20250214-drm-msm-cleanups-v2-4-1bec50f37dc1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-drm-msm-cleanups-v2-4-1bec50f37dc1@linaro.org>

On Fri, Feb 14, 2025 at 02:17:47PM +0100, Krzysztof Kozlowski wrote:
> Kernel core already prints detailed report about memory allocation
> failures, so drivers should not have their own error messages.
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

