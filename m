Return-Path: <linux-kernel+bounces-319655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47897002D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164121C21D15
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4849626;
	Sat,  7 Sep 2024 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktjy0Yig"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BA4084E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725687216; cv=none; b=FV/4+DV4ftPZkSqLjfZuuX1MdBcU/a3SKCBv92e92EjbA0Tm1lxwjbInaQgOZd2VrpicNIEJmqcTB85CqwOoEPLRQ5rL92/kgUIyuPU+6S5oeWg/yk1y8nKGBY99zDvOmBZrfIckGumutN5teWZuccQNzIsT+AKCEZ76IrbbxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725687216; c=relaxed/simple;
	bh=zantoeM69tUQKQTq7QtVcfoqoVWwS6/m4Cby2VdJdlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ8rnrEWQSJ+3CU6X7ypaua1t+v7G6WToWkb2v6UfF7vKSax027LV2TsGbFm1tu3qvsFArQz5ww+kG5Vw7J3pISkuGb3xGuGPGZz/W3y5XLRXW0or3n7/svb221XWSk3ADYiEnQLum7k2WpG+U0M0pk+apxP8qyKwU4aOckLHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktjy0Yig; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so4182021fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725687213; x=1726292013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMdYzbyGz4WlAzyMlzXjH9QYo1m21KCeU40Swdjo/50=;
        b=ktjy0YigcipWWw8NZ7jF04Khm+EN62VLhQZDEzg7A/UJP3uBMIE/kI/1pXNqpblSMo
         3MnfsfiysMV1aC7buG90QF4EFH23ktYd7AQf6Q9cG+wnPk6ch59MlOPgG36vso4gb/1y
         QgCJXNFTgj7gweQcxleeMvAUWLBOotWo4Rn7xx4imD5oz2tsYFUJjbWCcVwRrYkyd610
         z9+JS0F55srPxKk7lGnGxEfgZS2r69UZHIMAtmQ8tuVB9e0HJdEEytVm07KFyKhkEPSm
         fhgAAaBT8wZsSC79Wv52eKQdGRq8aI/lTcYOA6gZD7yn5a+6LiDkIFkiTeSU8jk2rsvM
         e81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725687213; x=1726292013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMdYzbyGz4WlAzyMlzXjH9QYo1m21KCeU40Swdjo/50=;
        b=K1qQxoNcD2xWoKjMMxLc8GNXWzpBlnC4l0IrBidMaXikxnFUSS8p/iiwORFChWC6r7
         mrXqzIpjspNfS1VwkTrwLO4Z2XtdMGX9TB9w7bU/sDE4uTP3FYKZhLjvZ1XfO+nvKiKb
         oG/KemvjBSMZKn3kMFxarTSAtG/Mtgft9sn6IOmHBhqQx5efy9CXpao5GvvuSoDQ7jxC
         cXr80SsrAr7eROaniVQb5vJbDnzImgS4Nbd53rzH+2FjeomSgIjQF9AhP7nmwT+Fb4Ol
         Q72wVqlBWCJQIwwHga4IUkTzd7HZJQvh71ne0YKJzf8fqiLRMbRj6ToZW2Ndmri0v/76
         qXpw==
X-Forwarded-Encrypted: i=1; AJvYcCXvqvKk8v2jCyTyZ+HKp50s+vm5rVsYzcHzuRpQvRnN9rsHiFxu+ZSHfn770HkYULqYBA7AmaCiRFFaPH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldBFtQtkp1d+yEsLDyGwjn6PYZ4VFssRuWf3Zuqpj5+xWGffs
	m593znScTs7IaB7cEjMBZ4hqtrBAJr1EpK8s/l7QDIAd45FwlTjQ
X-Google-Smtp-Source: AGHT+IG/jPYS5sRhAiOU1Ut2nosRbh1hUF6KcwbKLKt1k83KOZgeNvrJElJS48a61Zs79yLrzLokxg==
X-Received: by 2002:a05:6512:3ba1:b0:530:ae4a:58d0 with SMTP id 2adb3069b0e04-536587a40c6mr3414143e87.8.1725687212339;
        Fri, 06 Sep 2024 22:33:32 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8554:83ef:b48b:9bd4:f165? (p200300c78f2a855483efb48b9bd4f165.dip0.t-ipconnect.de. [2003:c7:8f2a:8554:83ef:b48b:9bd4:f165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25952761sm30294066b.59.2024.09.06.22.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 22:33:32 -0700 (PDT)
Message-ID: <34c89f36-915f-49da-bea1-c9b9ffaab905@gmail.com>
Date: Sat, 7 Sep 2024 07:33:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in
 rtw_xmit.h
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240906141024.10021-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240906141024.10021-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 16:10, Roshan Khatri wrote:
> This patch fixes spelling mistake to increase code readability
> and searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> index a3b4310caddf..544468f57692 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> @@ -15,7 +15,7 @@
>   
>   #define XMITBUF_ALIGN_SZ 512
>   
> -/*  xmit extension buff defination */
> +/*  xmit extension buff definition */
>   #define MAX_XMIT_EXTBUF_SZ	(1536)
>   #define NR_XMIT_EXTBUFF	(32)
>   

Hi Roshan,

please make a patch series out of this 4 emails. This makes handling 
easier for the maintainer and the reviewers.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

