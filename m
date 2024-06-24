Return-Path: <linux-kernel+bounces-227107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2198891486C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC7B23549
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434B13A24A;
	Mon, 24 Jun 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZn9KxIL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43D13B28F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228055; cv=none; b=mEqJUAd/4xqprwikWIscF6jIAkJuzTyGf+kFITxR6PFtB2fHhOd+oq8QSWk3sePAZKRV2VdunfeKLQt5BZkbDDi4FooTe68f9uVEQOUCeKjQaDyvW1rVLug3ShsN++oL3Yaz3o8AnTwdKtlJPvy6XNAWbWvRhsKffO3V5PJc/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228055; c=relaxed/simple;
	bh=LaJcfNfEkE5xFvXOrQDn6HmxI8zIWZaDy5jJkvJ8OtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tieOQFaWvrisiYO9rHWfHKIVMK4UZgeQY2WKqXLTawwWMxJxw18HGilDCkZBHDu9i5SrILnWTkuCS3oVqYeuadeS5xPp8uF/A7EiVVEftUGtaSB5Ss6JpLlLt3tmTpbj9IhkbH27FC9sDuEfV7c76XSV66bbO8o03aev7p/H4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZn9KxIL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyS9UuWlSuhl3v5J/At0OYlc0sWMnApISqtSSU2EeV8=;
	b=OZn9KxILXZnHNxJ/Jd2imTpaET3bNSPaJNOfU7x7/EsGpse14Dsjk7P5JyRWhkfLtL8abN
	v9NUMjnBd/wh34XbalYo6TMeoqUSDD87L2vUu02ziXsOVxAowwpzgMbp4pmKTISMIaNiMv
	+9FJ5K5zCHh6qurmTkEEIBX128wGgy0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-GvfwV5NLOAS8tA5rF9sgNA-1; Mon, 24 Jun 2024 07:20:45 -0400
X-MC-Unique: GvfwV5NLOAS8tA5rF9sgNA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57a524f1f7eso1231005a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228044; x=1719832844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyS9UuWlSuhl3v5J/At0OYlc0sWMnApISqtSSU2EeV8=;
        b=D4hf+zxdpSq3SuARtSWQGp6vDcvoDYN8+t7CAPptq35RrqtSPg/v47HymD9Q1kxVkJ
         8NLFHh1s+xeqTcPOeEK1YCLvVRoUFG3ZlWH7d+GgjQuR01WFtqWWWeDLvXZPQoLn48cP
         nDS1A6qGFhe2vKxRibUE0arOX2gM0jgSVVJj7Hb0AGRiaF0/h4HzoCrWj5JgRIMFgdaN
         ChQzBzyLlRDX6smdJ+rh8AAbhrWNdSKoqDrAh22fUuLthGblFdglCk7/f0swVzMoLcAt
         W/IzNin1BfoGFafAUTxoqM9CaU21Jsd7KcpJq4XVwql1ufmNqhASpkhFUaUaOsGjjZ7n
         RZHg==
X-Forwarded-Encrypted: i=1; AJvYcCXf35XGgFmUDETsFc9DsKKkbzxp+72H7fVhfRuAWmWX0wPaOLHFPUovedmLrmzt+qNlzzewMgT7URHYBa22BjSuzDbocuIUCDAAtqav
X-Gm-Message-State: AOJu0Yzb9NeOr+FYuFQXG1FamcN2qAZAH0QXxyUn7+VKTcuMIL+PMvqN
	4cvpLrNDRCQgSv9W0nBxYVyBn+7riLgUBHK2QyuR5jeAGU9CneFK8/wD7QSKBypsaJHITLRGJpV
	9Lp3OO3Wf2UBUwARyoGuEv8xEECCqNfNOd3wVI5JHG346VsTlnv1ygGF5KSjA4A==
X-Received: by 2002:a50:a6dd:0:b0:57d:2c9:6494 with SMTP id 4fb4d7f45d1cf-57d4bd67579mr2602884a12.10.1719228044386;
        Mon, 24 Jun 2024 04:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb+hCCh2C079aYaSOs5wClkvC6uFNqnHx93fwnd8yLsB1iy+iw2NHWkBjLsaFFhnIAlLPANw==
X-Received: by 2002:a50:a6dd:0:b0:57d:2c9:6494 with SMTP id 4fb4d7f45d1cf-57d4bd67579mr2602865a12.10.1719228043934;
        Mon, 24 Jun 2024 04:20:43 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30563031sm4584404a12.86.2024.06.24.04.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:20:43 -0700 (PDT)
Message-ID: <2b3e519e-10ab-4785-9a3a-6454b18c169d@redhat.com>
Date: Mon, 24 Jun 2024 13:20:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/mellanox: nvsw-sn2201: Add check for
 platform_device_add_resources
To: Chen Ni <nichen@iscas.ac.cn>, ilpo.jarvinen@linux.intel.com,
 vadimp@nvidia.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240605032745.2916183-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240605032745.2916183-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/5/24 5:27 AM, Chen Ni wrote:
> Add check for the return value of platform_device_add_resources() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/mellanox/nvsw-sn2201.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
> index 3ef655591424..abe7be602f84 100644
> --- a/drivers/platform/mellanox/nvsw-sn2201.c
> +++ b/drivers/platform/mellanox/nvsw-sn2201.c
> @@ -1198,6 +1198,7 @@ static int nvsw_sn2201_config_pre_init(struct nvsw_sn2201 *nvsw_sn2201)
>  static int nvsw_sn2201_probe(struct platform_device *pdev)
>  {
>  	struct nvsw_sn2201 *nvsw_sn2201;
> +	int ret;
>  
>  	nvsw_sn2201 = devm_kzalloc(&pdev->dev, sizeof(*nvsw_sn2201), GFP_KERNEL);
>  	if (!nvsw_sn2201)
> @@ -1205,8 +1206,10 @@ static int nvsw_sn2201_probe(struct platform_device *pdev)
>  
>  	nvsw_sn2201->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, nvsw_sn2201);
> -	platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
> +	ret = platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
>  				      ARRAY_SIZE(nvsw_sn2201_lpc_io_resources));
> +	if (ret)
> +		return ret;
>  
>  	nvsw_sn2201->main_mux_deferred_nr = NVSW_SN2201_MAIN_MUX_DEFER_NR;
>  	nvsw_sn2201->main_mux_devs = nvsw_sn2201_main_mux_brdinfo;


