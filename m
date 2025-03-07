Return-Path: <linux-kernel+bounces-551114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD79A56860
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A077A6DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05F219A89;
	Fri,  7 Mar 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeCfxHi8"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756AB217670
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352337; cv=none; b=ESVEVY1H9Dy+qX7HQpTsSPQkjZCqphe+HcHkYJ+5q+fQHBNcAE77QD+Pi4iPXgSCXVa1zEQR2UILbLKmLJqEEEb6Kbmn3E/U790JPMBNoKGWjiH0z26t5567ik1JO14+m3qnez4bSXVAiSZBivZr2ykQHjJyRXuHyCLb1gxDyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352337; c=relaxed/simple;
	bh=JyqdUpI+O2H5+nIXtCzwJtTX7mMZjbicNV19pUrQVsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0d9bJe8DMhQ3znSFz5729fyqVig5rLrU7nslxmBRss50smAnOWQbWE8yeChHdrWMhBRxuLNdj7/zqzkzSaiJwym/V6HT2M1aXd9zqImTiGyGiPQwhpeQ85VXyO8gIXk0EwnXzer6aMjBIuJGbqJZTGgyjk3xl1qnIvYr6B5wEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeCfxHi8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bd87f7c2eso10315095e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 04:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741352333; x=1741957133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YomAr+jLWfyA0js2DUztzDdpoJnP9vpapwzHnnzJhTM=;
        b=HeCfxHi8xKl7bBXvFFSnZWO7jLQ0Ds7ZL/RfF0u/rn4M4SphLHW6k+s3g0f+hpZvyh
         80bTflFqyCdCWoQLnCeGjaY/6703i24UZmQYHWliFoPsHid7+754p2gBigF4+6qjvlrC
         Hf61tM/fjBG6gS/kzaqGczhRpAwKOndxPLgnZrqxsZxVFOVmX4LdL5EAgvfgFTRkmIrT
         fxONFegsUQk76OlJErJuvk8AtIkLByyxmZmafYpwrp40VcM0d5WCrTbY8llS9yI5anTy
         XOwaQ9d4QH0WBvVPdUPtVuHDFkq18nf7mPy/cRKPbumKNbGI9UtYyED8RQ035FUrCmHn
         eF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741352333; x=1741957133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YomAr+jLWfyA0js2DUztzDdpoJnP9vpapwzHnnzJhTM=;
        b=na7tM5AChP/MIXl7X/4/aja2mxjAmI05YifiKmvm9KWupda+WxVuy0FwtKNoW9UiN6
         MFiYuwUhNabKo20itj0KxPs5AzAU7qxN+KEWML9tl1PT9pc7fDwM4JlvxP6Bf6wE/9lK
         fPA7HA06sCu3HoA3Up1DO08WPKt+i6KeymnDKXKJL51UvvDcg4q1Jea6lAOPICIanW/8
         evAlrCbHSmsJmYyNLC9opyMcUumqxBv79gcylrU5sox0JpqOuJZ6UUdzeQ7BgfB2NaN8
         hxRuJ9LLzkpq5/rPHBaR8PRJFdSYieruXdRXc0r+XqPvdhxihBO1D0UczjuZFhPSKitS
         N2aA==
X-Forwarded-Encrypted: i=1; AJvYcCUl+K2zASKpso9VR15p/vKuBY3R3AAVfpxdes76KumXJDFLLVZsrP0n6j9ncX0kmLS5jJsC+nTI6lUU4Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7jWO6lyiih1RxQoXtKLYi0bq87u883mgcaiLoWLV8JYQsvVD
	7YJRKVfBQpfpXZSnmMScytVRr0cqDO/ESJgd5HFqSmUO7IyAgUx4
X-Gm-Gg: ASbGncvwb1sUY0xtYVKfcsa17aSla7IMMXiRyLHcbO6vaDcOkW188SUGW/Nd+5O+V8s
	hxJch222uyHeKUPq0/f34pACEXhzUrO7JnOneRAKodulhGIh2kQx7fyLtcjNVmb7jLgK150Q5gl
	GPvAagxeJR5kiLecBaswa7TiS1h0qK+hJGoCkG9fPp252INhGM8N9A6Tuf7/iO9fSrUSoCJvnDG
	Kt1W5hnLN0q0oyB0WICgr67jdpoqD1DBDVjN/b4eqfJCQarGbiLTRj6mAzRf4aUMqc9ehU9kFbP
	wbQbb83GSFSK/hXdPnjE5HSxajoy7qYwCqdDy0vXiAuDYkbmnwGM0MWhiotnu9SUl1Wl607A5EK
	R+o7s8YvWG5wXBg==
X-Google-Smtp-Source: AGHT+IHMt8TRlwPSb4W92+vucsZxD3dN6Z2G83XFOb+e9H+0srYcaupVFJUs2dMUm7RWODeqky3+lg==
X-Received: by 2002:a05:600c:19d0:b0:439:8a8c:d3ca with SMTP id 5b1f17b1804b1-43c5cf3cea3mr22038715e9.29.1741352332403;
        Fri, 07 Mar 2025 04:58:52 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdfdsm5426950f8f.34.2025.03.07.04.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 04:58:52 -0800 (PST)
Message-ID: <ee3989a0-e03b-4947-acef-7174fef9d36b@gmail.com>
Date: Fri, 7 Mar 2025 13:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sti: fix inconsistent indenting warning
To: Charles Han <hanchunchao@inspur.com>, alain.volmat@foss.st.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250305101641.2399-1-hanchunchao@inspur.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20250305101641.2399-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/03/2025 à 11:16, Charles Han a écrit :
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/sti/sti_hda.c:696 sti_hda_bind() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Hi,

Acked-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Thanks,
Raphaël
> ---
>   drivers/gpu/drm/sti/sti_hda.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> index 14fdc00d2ba0..6c9a49146f44 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -693,7 +693,7 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>   
>   	connector->hda = hda;
>   
> -		bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
> +	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
>   	if (!bridge)
>   		return -ENOMEM;
>   


