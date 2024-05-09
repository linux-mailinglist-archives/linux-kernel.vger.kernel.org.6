Return-Path: <linux-kernel+bounces-174254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B608C0C26
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331A52819F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB165149C6D;
	Thu,  9 May 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6KniFDG"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439E13C9C0
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715241097; cv=none; b=hicJjckE4/byfSH5b8e6PoF3dt4r4jAXqy+jx2RpOcJNxyqLVWDrLJFyCfqncGf1xzZguzL3FNwyL7Od7mlKzffy85jx4Hu6hmOcmNH2sMFuOcVnqz820q8LR5qnZum1JfjFx/wdrhwjCGb11BRk3ESAwXq0OZgLV5aG2BB3C3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715241097; c=relaxed/simple;
	bh=Qpetu/YpQMTZ8pAa1jeqlxfiWUijO299LmcayGsUaX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j2wQiMbWGl3eLZYFA4L9xwm5MYyOK9fxVFkysU0mKc0EJglq55Z6g4s/uwxjwVQK4XiOIKfmUsTP2gLHFaoIcE6mMkR0hoIVRHpU9/2RRXakeIH/f8QqCQb58nFpAYmptRrvY6WkqgmvuL4Ij+R/8pUb8hIkfwjfMz+4gDw3E7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6KniFDG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a597394af62so10390466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715241094; x=1715845894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6xNzfhaoWFm6sJlVLBh3GSwTzYAxKnIt/VRGk/R2Mk=;
        b=b6KniFDGWuhfyMkL9MV5UD0YQ+Q1nKkm7nrWyK/4zHKPjTCeGKQ0oIMgB20Z5/gMmr
         m4/Wz1SQnn0jSdWJ76CRUEHi6Zbc/ZZiBPjmpOfUKtukCb6yO6ijqUkipQzx+3b1JjpG
         5p93q6XRI/L9wRwbKNY2pchKKYMmPmpZ5pQf0xiK6RTWQWNII90iX3583PifbK0HF2KW
         KA1u1vRjbwbqjewQT4FMXSQHd1b4GDMT8tGhA7bIfphoC8odg0VFvCJ5YVK088gWIBGd
         5zqS3EThNt2Sj7ItX7/hCTnOwj4NLtaUmfKXmmdLKvFBJsDNVYZC3M7C7yDnBoEzoL83
         NLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715241094; x=1715845894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6xNzfhaoWFm6sJlVLBh3GSwTzYAxKnIt/VRGk/R2Mk=;
        b=KZjFYlK1VFJu3W8UTA2WkdgIx0gMSRVXXSebsu1Q2MIBOlQCnp+Mk2XpsUZT1W691o
         6nDcJiPm22D4L+SL2ntiIqZMBWw1mPn6qxRofQxA/pBVrZzv7rQiJvtIRI0yNbe2qvby
         4yl8gY+ljxuY6kkP3sGT1xQYUaJppH6ziJeI4r5xXKegYysIodDrVHy9UiefJ2otiElA
         E1EL/cu/24MUq7LkNTnNXKHuNtXHwdrJnBbumgeXiVsGPAwoHotiD3T98sUUNe2NEQva
         dX2l+y0p3thP/IXSPJXCqetFi030a+Zl/KAM8uiZ9XCigDE3TJXR90uPDjtaKxgiOtCr
         9ldA==
X-Forwarded-Encrypted: i=1; AJvYcCVAJcyMvvgSkyythDWoyRwUoOjwZ60fnJi42O9nk9iqke/Rig+7NHSdghgKMZAD1Q6AKhb8uIjYmBUoLQlhj1wsjScApmKzKtjGTLlx
X-Gm-Message-State: AOJu0YyrkZq/4R6g4Qkqg6jmOY+tgATOOT860wAp6bHk6t8/JMmpQ772
	EjrWue2DwC5aD3PIRUvtcQRxhvEgRrFOb2z/UpHnNXYIgJ0ayB+c
X-Google-Smtp-Source: AGHT+IHFBKDCvOz55Wyv8QIEsf4C9hOee+D6I/ijudRZT079I4yTV8oRLt6pk1px/3473/B+DRXWwg==
X-Received: by 2002:a05:6402:3894:b0:572:543c:70eb with SMTP id 4fb4d7f45d1cf-5731da28059mr3237730a12.2.1715241093597;
        Thu, 09 May 2024 00:51:33 -0700 (PDT)
Received: from [192.168.0.103] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfc24sm448399a12.42.2024.05.09.00.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 00:51:33 -0700 (PDT)
Message-ID: <190dcc76-7753-4191-8578-482c2942583d@gmail.com>
Date: Thu, 9 May 2024 09:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8192e: remove the r8192E_dev.c's
 unnecessary brace
To: Chen shuo <1289151713@qq.com>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <tencent_1992979C468AF087A1909000C6D0D5E61207@qq.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <tencent_1992979C468AF087A1909000C6D0D5E61207@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 17:13, Chen shuo wrote:
> There is a unnecessary brace in r8192E_dev.c.Remove it to shorten
> code and improve readability.
> 
> Signed-off-by: Chen shuo <1289151713@qq.com>
> ---
> v2:Make "Subject" line more unique.
>     Add space after : and driver name in the subject.
> 
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index e3ed709a7674..1862a9899966 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -1640,9 +1640,8 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
>   	if (stats->Length < 24)
>   		stats->bHwError |= 1;
>   
> -	if (stats->bHwError) {
> +	if (stats->bHwError)
>   		return false;
> -	}
>   
>   	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
>   	stats->RxBufShift = (pdesc->Shift) & 0x03;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

