Return-Path: <linux-kernel+bounces-319658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC02970030
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE06285A7A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08C85956;
	Sat,  7 Sep 2024 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ/WPnYH"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E712E1D9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725687252; cv=none; b=HWSaYqs7beNK2n1rOZlqkS4niBisWafXX/tVJnKtGHkk/nyQ82/Q6HZNQVDtuQHAPSUWkCfs/fiA4igJHAaeh8jOJzZITqLWwhPEcwkbWZNcMCH1YIN6+MdzSSEYdVLwMIopODLhZJt9SrYZ00AAoCr8Ys7ql6jQrRWwdWRoQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725687252; c=relaxed/simple;
	bh=5XyzXAL91oQWCEuilHowuUynFqW63PgqG/uzFnyZeFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hul7zXGn7EB0PjqK622LUUjCmpYQ1+oinQXQQ/VMIHMF4I9PT/eE/AR2s71S8rDp114Z8sNt46Be71zdYchENh7+EsYmbTSQuJbPLZsb/78VQYt+5zuerpqQCxNm/cuHqiR6/1QduSX/OEDAeTbaAYDiOuW5WoNjfVj3h6vGOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ/WPnYH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365c512b00so1054880e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725687249; x=1726292049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvBY4LoX3N4dasraPrjziJHHMR0N8my9Ke+wGInAkl4=;
        b=LZ/WPnYH8UsJdmql2xv15+WMzK4SnTN1CiudrdedAZwgsyhnlKZoa6T201CW4eD7ej
         CE40qOa5BVrXAHhfWR1PZHnXZ24+3Hme2RFQMlBFPQi/kNJO6gkVC1O8tuhCzAA1syKs
         U/2W5dLi1i72SIZbp3+icT0JT3tFtBWmyC0PDe9cbvfoyWv8MOhDoINyxNUtEm795wQ3
         2QwPUbniXfrLCLDSg1RnNbNEKePVWM5Jccu4DWBp5KaIIsJHrOw+YncIdBOTf3nCKkC1
         gIEzCVKlA9L6HhFoCSRaMwFKZi2fRLEcpuvnnHevPyugJR/XrnaoqWm5pjLZgFJMVQpq
         eZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725687249; x=1726292049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvBY4LoX3N4dasraPrjziJHHMR0N8my9Ke+wGInAkl4=;
        b=qPJo4iYuczKs8n5JWpoHIIOiwuz3yrz83B9YDO9h+bQasAcDUa/fQ2erlGdiHLrrpe
         srFMCkFf7xstQvOhxPm3FYQQRblg7BHL1NYzmPcLbP1kGITSoyzFFbLZrJjOqqbt4FjK
         nw45Rqq3WvwMFQ52sAw9Udid/yQnrcxBeN2pDd2hCfplIRfCVz6QA0p3b17pSWGPzqLU
         xGhT4k7x99jWjaHTI1R77VWrNfSRj5ghKKU1ZelcqtN2pDivk+narJhpL5w1RICQYI8a
         pmyemswj3mD9yBdLMHKhvTr/No3yld6kFR9BJxyz2u7LvgM6ynEU2rsAXH0wYDEXUvc5
         Chrw==
X-Forwarded-Encrypted: i=1; AJvYcCVlpK8wPMakQgSWFLnQvL2PTszFmtHj9w51jfnL+sJFlc75Gb+h90Wr4CwB+67qoEetyOnO32NkMAQQMB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYeqesMIvvQha+Srl4Hr352SGNfl7Uz5/Zhn1G7a77Z+cI0LCz
	StfKxhHv4VvOK0qCXGaBdcPyI0yY6/ATJICwzrQ0CpQAGGz8LTWj9chAM+Kh
X-Google-Smtp-Source: AGHT+IEvrJiGoTMnZxJ6cW5it3SdV4gboRdovc6g7VqrZBdxngTy08Xy6zRi0F7EOiPUJF7kEZHvKg==
X-Received: by 2002:a05:6512:3d1b:b0:52e:999b:7c01 with SMTP id 2adb3069b0e04-536587fcf4dmr3121011e87.48.1725687249078;
        Fri, 06 Sep 2024 22:34:09 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8554:83ef:b48b:9bd4:f165? (p200300c78f2a855483efb48b9bd4f165.dip0.t-ipconnect.de. [2003:c7:8f2a:8554:83ef:b48b:9bd4:f165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2595122asm30431966b.65.2024.09.06.22.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 22:34:08 -0700 (PDT)
Message-ID: <272d72a3-85f7-47cd-bebc-cf0f0160a84f@gmail.com>
Date: Sat, 7 Sep 2024 07:34:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: core: Fix spelling mistake in
 rtw_xmit.c
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240906141157.10167-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240906141157.10167-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 16:11, Roshan Khatri wrote:
> This patch fixes spelling mistake to increase code readability
> and searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index b1965ec0181f..755c1bc86a74 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -45,7 +45,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>   	init_completion(&pxmitpriv->terminate_xmitthread_comp);
>   
>   	/*
> -	 * Please insert all the queue initializaiton using _rtw_init_queue below
> +	 * Please insert all the queue initialization using _rtw_init_queue below
>   	 */
>   
>   	pxmitpriv->adapter = padapter;

Hi Roshan,

please make a patch series out of this 4 emails. This makes handling 
easier for the maintainer and the reviewers.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

