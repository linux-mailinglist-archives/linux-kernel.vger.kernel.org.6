Return-Path: <linux-kernel+bounces-319656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE81E97002E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9661F233E5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7349626;
	Sat,  7 Sep 2024 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fARYSiyB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CC446A1
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725687232; cv=none; b=Q4Duu7SiP75qErFUVBqlbsFpI4CAydOdAO9db3I2WUxCTgAZO+JA1V9ADKHbZ46Rb6vZDbtX9rZniZFahzmdLa54srermc4DCOVPYlQXVIUbRUwtbssqEAPvDR67q0XQW1FETRUS6mJPLUzj1YdHWGybebKI62yLNS+Ior5HCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725687232; c=relaxed/simple;
	bh=+H/I7whN0NNpqToF+5fYnih+o16BXEJ7heTUY/b5+T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nre8WShQwU1m4hW0vxVwavHvykWJGgZgLr4R4SLir2Zx9pnbqoa21dlCNgeX9tJAA7oyQVMKTXKQHG/182DZKt9s5Oz5RcCOIHeme+A3VHg9vJYU2jfyPy2mtdfx7afSAUp7xqPyy+lEIe9lAdho9iB8EfU1STr2nMPLlDfUlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fARYSiyB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so2836790a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725687229; x=1726292029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZM2s1Cg/60GKM8GyEK8yuEznjDVkHGQO4WsXgAoE8Tk=;
        b=fARYSiyBOm1werkioNmQdPwfSY5txAJ1x+UscII/CUIuoRdaMXRejr9OWgCzBO2rBK
         +QcAUoAImPeef9W0wjKwl0hAnX6QFh/Yj4wVEbGVKxf72gFvQcUBMOONHTUB+laY36gy
         N0rapWmwmoDTBUofD3XWuOH9NJ27FVgVVb6Zi3a+KxcstB/CgCYtzlv5GALU5R1DjbAQ
         3Pa99/ws098XqTUgohGcgnNL/HBip3IxOyfxM1YWOaMlD1zLUzPdi4MEg+uVGIBeOi5P
         cwO3E4wStPYi4T5WNGH14S3JZQdzxOFLVattigGkh57+NsWdEkU+n5qoYftnyc/EdjY9
         vPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725687229; x=1726292029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM2s1Cg/60GKM8GyEK8yuEznjDVkHGQO4WsXgAoE8Tk=;
        b=DDUEghBAX0mMip77SXLw5ZI45MreSbhelJ7OuL/A+2Y/+cuXMwaa1GJXGDkcN3zY/f
         CEApnhDfHy/rUClaCvgZvA+lNDVE5g3kkW5zfEvsGqVcz1wlaBN23YM5mgqZQcyK9l2N
         4BgfDjI5hMFbsG2emTEYgS4DeKgB1J+M/4ltRgcicJdh1j6TL0vjRyitPtnT+Tod8tbo
         gR/HkecGfXziD92f1FgDijHNZU/dYsit+/iWNHs7kywUPbQBK7qtUvIy8/OA74b58Spp
         lf1CNu64/UnEBaFqcLk9oNCVd3b2qSO8S8ZVDoTkhhmzf2+4SGKsdWA0nAxyiklCq7py
         Bfkg==
X-Forwarded-Encrypted: i=1; AJvYcCVzEXjqZwKsBv+Cmc6s8tzRrtopuPoexsoTAaFikwm74RMC40HwGPqSStKjs+Atzy7g18rgHjsAaexDYYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMY5DKZ8VUHizHm7dTiOg6vdy6isG0QISnWvXh3mQRNW2TntL
	N6c9mq+0F4cPwswZlg8xGA2M+1rCTyQOgfprJ6ut/NwNv5chTyyk
X-Google-Smtp-Source: AGHT+IG7GzWFmsfvVo1AaQt75WN4uxIiwobekgFNnbMDqyvyn1poRmtdtfnUTPFBzy/UFNfiQCgljQ==
X-Received: by 2002:a05:6402:43ce:b0:5bf:2577:4346 with SMTP id 4fb4d7f45d1cf-5c3dc79a821mr3416162a12.15.1725687228698;
        Fri, 06 Sep 2024 22:33:48 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8554:83ef:b48b:9bd4:f165? (p200300c78f2a855483efb48b9bd4f165.dip0.t-ipconnect.de. [2003:c7:8f2a:8554:83ef:b48b:9bd4:f165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76f8bsm257776a12.76.2024.09.06.22.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 22:33:48 -0700 (PDT)
Message-ID: <5aeb10e7-bf33-431b-9669-133cda54d5d3@gmail.com>
Date: Sat, 7 Sep 2024 07:33:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in
 rtw_io.h
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240906141104.10076-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240906141104.10076-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 16:11, Roshan Khatri wrote:
> This patch fixes spelling mistake to increase code readability
> and searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8723bs/include/rtw_io.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
> index be9741a056e5..0ee87be6dc4f 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_io.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_io.h
> @@ -13,7 +13,7 @@
>   	Otherwise, io_handler will free io_req
>   */
>   
> -/* below is for the intf_option bit defition... */
> +/* below is for the intf_option bit definition... */
>   
>   struct intf_priv;
>   struct intf_hdl;

Hi Roshan,

please make a patch series out of this 4 emails. This makes handling 
easier for the maintainer and the reviewers.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

