Return-Path: <linux-kernel+bounces-320763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4911970FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7CF281034
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0221AF4D1;
	Mon,  9 Sep 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8CMAvtc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E9171E5A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867329; cv=none; b=TS+hNsNg6wlP/ABaPUEZm/pDXVUI2HJp+c/33lwYB45z0LutawyZPwFvy00+8yTyGpUBF8pa/0kydQgTNt5G5m51PElWhwDyYfgBarfHNtTW0yrHIElVRZAznqRImT3RiMHqfMiQpuqkrhDOAB5ithS4hyEBz39yGZz4q5we3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867329; c=relaxed/simple;
	bh=IAbjWFWsgGT75Dueeq4crLIvbfv02TRNsKfDqxBdgBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3+ZCpn7Q8XkSVXz4EAWnrbshrKtcth1ncZFFkJhZzwWt/JaNE8moeJzvQJacsAppZBFshWxyqZsu0OJcUUUQXCA9W0Gl4C+kupjjiN2/BGB9aSuVbwpBi+84+TV/c0JEVdJxPrGtpy+d8XPgT3RkHA+s/eurvdbpEioRP4mhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N8CMAvtc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7929fd64so474732466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725867326; x=1726472126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JSyWMbLAIiVLQsXdks3HCLYLCsP3mSrbhpF0vqvBOCg=;
        b=N8CMAvtcmKUJfKBZj28kghADw6NeFfgy8e2VWqhDb+syFAswIRIZmGBA39eO1kiypy
         NujC8Hc4npDRpTcnl6wUIH6YqHRf1wKbaGN34JJ5Oid/CTlxsotIFuXAtDTehud5K7yB
         T6W2E2R8G59ZBW7GctB621jjLaOmRWHZtoDEIpXor0k/g9LszLG27mSnT0n0g9DI79AU
         4z0cTBCnaUS75Skidcc+4FWDg/oW1sVdCEkBcGUrb1gY633IicnsP5ADkwjr8sw1XnJW
         fE3hmNhnPWzdoKxn/TBMcFhGuDTiZ3+dcUB4p/apuLQ2CX9yuZLfH+D+O2P+6WBsJWwF
         RgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725867326; x=1726472126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSyWMbLAIiVLQsXdks3HCLYLCsP3mSrbhpF0vqvBOCg=;
        b=a4iLDSa0JYP51bc9tPtxjJIL0+64Q7TKA+DgiJ6l//lg0oOQWzHiwHVv0cFRfIkwSx
         gSuql+lLfKFldoazydspb32HvT/2b4m+nxwV+0McWqOzuz0K2kSJEKJLdfvRnCAM28Oj
         5jOw2rMglQ14EKLkVPTMgix+nwwhLuAb3l3zBDkfC/bsg2CsNnHIAEVH84+JcGDTraLG
         AT0wYo3qYJPz6QL+0E5DieWWOwsjABiyX74VyKLks8X+XQyj0J4GIP7eJq5lLzPSkMBt
         7/YZGHOk8jFDZaRNnAEklmFyQ22+uLrQ382VPNRkK59G4vTFMvEyWflNx1Q+FtCVBJ/c
         y6fw==
X-Forwarded-Encrypted: i=1; AJvYcCWmHRlrxjU4tF+UhldCAHcAIlpBr9y/F4SM7i6fBWw3d11g6Nx1P5oUjodr6sCHnhzShA2zDXlfbmDE7l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8AMe+VSOoGA5rdzfkZcQpWLQMvlh45lPav45GhUgpp1u9Mor
	CrScubPc3wS4iEgWA7rDkc/mGF9VZI1MBKdlobRV1lv7dQy7lBeaMxUVOyIPuoI=
X-Google-Smtp-Source: AGHT+IEiPJXGsX5J1tk213MU20LHOyQWs711l73TpOnftb+1B1+yCMOVrh07U1XusjImbewemB7MXg==
X-Received: by 2002:a17:907:98c:b0:a86:ac91:a571 with SMTP id a640c23a62f3a-a8a88867469mr791091866b.56.1725867325770;
        Mon, 09 Sep 2024 00:35:25 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25950cc6sm299397466b.54.2024.09.09.00.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 00:35:25 -0700 (PDT)
Message-ID: <ad9ee29c-b96a-4861-a7cd-b8649a3d1f3a@linaro.org>
Date: Mon, 9 Sep 2024 08:35:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: fix flash probing
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>
References: <20240909072854.812206-1-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240909072854.812206-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/24 8:28 AM, Michael Walle wrote:
> Fix flash probing by name. Flash entries without a name are allowed
> since commit 15eb8303bb42 ("mtd: spi-nor: mark the flash name as
> obsolete"). But it was just until recently that a flash entry without a
> name was actually introduced. This triggers a bug in the legacy probe by
> name path. Skip entries without a name to fix it.
> 
> Fixes: 2095e7da8049 ("mtd: spi-nor: spansion: Add support for S28HS256T")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/r/66c8ebb0-1324-4ad9-9926-8d4eb7e1e63a@nvidia.com/
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index d8e551fd2e2a..101ee5b0ddeb 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3281,7 +3281,8 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
>  
>  	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
>  		for (j = 0; j < manufacturers[i]->nparts; j++) {
> -			if (!strcmp(name, manufacturers[i]->parts[j].name)) {
> +			if (manufacturers[i]->parts[j].name &&
> +			    !strcmp(name, manufacturers[i]->parts[j].name)) {
>  				nor->manufacturer = manufacturers[i];
>  				return &manufacturers[i]->parts[j];
>  			}

