Return-Path: <linux-kernel+bounces-200611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E20748FB260
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442DFB2525F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A321D14658E;
	Tue,  4 Jun 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBmysDV9"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E78145FF6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504491; cv=none; b=gyM//uUbYrSY1uMK3JdA7wrOwiSVZsHCGAodPMnosnprfwc6oczt4ntstU3hCVfN9aISFHMd52oLqU0zaHunrqDobxHDKnSY0YVQRoGOiCLYx2B9A2vhDGG5AmW0i4CHzXy3v2lf5Ri/20iYx4oOoR1LkdcJRVVJmS443bHlhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504491; c=relaxed/simple;
	bh=D12OKosGzyIeqTc+4pWeca5gTMNF5feXU3hrQibnKMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+y5Hw7fV9HyDpINJT9+0+3gVIx7l5FgBDGeFj1KQgX5lay685vqw9DUaif9Ofxdw+M9fJEFlNN3BXPscNMWDmT4nriUn5Rc79LQjMBAIeZpS3fIQFpUetac3ENAsaGfSgNllNwd/CuUV6Z6osXLtozV00/pmQED5czXu+WiFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBmysDV9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b840cfecdso1176103e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717504488; x=1718109288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiCJzW0mABhhqOX0xPBmtvojGJknZUCeql9nyaZxqZo=;
        b=EBmysDV91P1oNLddtce2x3XQgSi5dWWBzLNYkElqo27PVedG4Vxs94kYb2rC9b/dRE
         n8GXEAnvVcmbHBXOqVWqmf/CCoCZ7Y4jGI1Sr5+3FqzNkhOHF6azvSO848Pso3J8IxcA
         4PJ7qrKsxZnbkcrgussNxR70+OGcD8EcPqFjnXfx8IWzet5N5lGIrhIZDeSeVebYLBIl
         t6O8n6oBYaAAUH0utbGrz45PSl8D7k3pBtBG778jJCpa7uiOhj413ufDIMBB2BtpMuKM
         HbFjWq2M8AOS38iwfl09Um7CTrE0r5A89t/OoQtf4pQ4I52vkeBazTyMwwX4LhNKfSub
         Gdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504488; x=1718109288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiCJzW0mABhhqOX0xPBmtvojGJknZUCeql9nyaZxqZo=;
        b=wLyxHFVFyqxqAEDrCVF2y8+m60NqEnzgsbW9CPQw0yoCYY5jiJ9FpR7eHD0CqeqWeS
         qgJOhc4QfgZ2Tw9WIBIjS+Vzxue1lPCrTp7JVrX+Y0W0Z6/jABqgouUoWdXvsXLnj9DN
         117KoFhOxmXStef+DHeWOr/Gt4W4FEDspJS3akdkBaOYdcFDZy9SS5hkOfkEa0PS0UtF
         95aDpVSwT9vuiR/PC9BBRc/Ddak+CxNYleLP7zfGM9oOFmoz/VVMuSal1uQKignduQTD
         IgizenlTjl3fAimdtqdbzJ6VZCri6ZSySpPz/Z5aMwXBycONKaA4Q43dMd7WXesKJLFE
         hKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXnCP23AjIqeIm+GJj04zHcpsMU4fKNaB6VOCqH9Sgalpsvw/C6Cu8Nk2lQutIyvJKfaS9jK0uFav8jl6Cw13sAt9DgP8TsgfLBIsN
X-Gm-Message-State: AOJu0Yym43PKBFqPgTVrU96+MUsS9w8UnbKN5yYGgyrSOg2H1MXKN9+g
	yXcRscL+iAGJP4kkBepUT1Kkj4uFHaynuqzpNsBCmYomPQAVhmWk7dIuI0J3EA8=
X-Google-Smtp-Source: AGHT+IFMlnLrkbtlCj/co4zLXjzRgVcjYZ1SkibwhwTsqzQ4YEGr3GUwA7ZNAwAXPr7PlXbkEBi8Aw==
X-Received: by 2002:a05:6512:3b25:b0:529:ac49:45d1 with SMTP id 2adb3069b0e04-52b896f1c02mr10925107e87.66.1717504488428;
        Tue, 04 Jun 2024 05:34:48 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a86a6a5d3sm609356a12.65.2024.06.04.05.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:34:48 -0700 (PDT)
Message-ID: <b49e8615-9230-450b-acf2-c2ccff4d9201@linaro.org>
Date: Tue, 4 Jun 2024 14:34:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, kernel-janitors@vger.kernel.org
References: <20240603-md-misc-fastrpc-v1-1-6e6d73d08315@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240603-md-misc-fastrpc-v1-1-6e6d73d08315@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2024 21:58, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/fastrpc.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by; Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/misc/fastrpc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 4c67e2c5a82e..e040cb5470c4 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2478,5 +2478,6 @@ static void fastrpc_exit(void)
>   }
>   module_exit(fastrpc_exit);
>   
> +MODULE_DESCRIPTION("Qualcomm FastRPC");
>   MODULE_LICENSE("GPL v2");
>   MODULE_IMPORT_NS(DMA_BUF);
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240603-md-misc-fastrpc-b644f497e68e
> 
> 

-- 
// Caleb (they/them)

