Return-Path: <linux-kernel+bounces-197836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF98D6FCB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D74D283137
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5072414F9ED;
	Sat,  1 Jun 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtOZCsNl"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34E6FB9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717245347; cv=none; b=AZg1OW/OaqOHKkg0a4DKWN4QsJW3TckAE9B6rh0V3M/9HGFNNRY5Qqu6bLGZwpFXOfsOVZ9pkRx3YsIDxW2bqQtjjLUUyTX0MhbRmFSMPp22U2kl15LLG0x3JB8k2FLKD/43apgmuQSlpfBnaxCrAIdnxwRHzZjt+KR/4LKL3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717245347; c=relaxed/simple;
	bh=l+w0MWiDm6oJtqFXx9Re3XnVhUTLF3ybfCko7EdhCnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFjSzTOOoTlTJ7aoAlt13ycq+cGAAqUXg/cU4TqYQULiC2hqq3tylRdnSFFKyUf2SljLXH4m8mPObBJ19/Oi+2TtesvAFd1jhAJKsMEGCTpGd6AkJfSvbnlrxpI2cWdjmfts1uFrWSXEyTWYhzDMmR2VyPd+WxtaIpu2sPKosVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtOZCsNl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a1d55a7c7so311464a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717245344; x=1717850144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BT5mj85tlRfrnhVxRHRVZyHIGnWChMArh0mXdC5TaDU=;
        b=OtOZCsNlqCGyIlr0N1UfXFexkNEOOV3HHptdjgToznGf3K2FM7yoWUZfVAsND4UywU
         4sZPsQFcCdg2R6lVf7gLxhzLnog8WzkWbgNjjlrHGN/449PbBZlUyCrRPKMiOqXan2Lm
         mNlfFXcmVWfw8C9OXvXZC0I+YDIz77PYgQcXIJFNGHY02x+M5MtjA0CZDQAhKD3RbcZ6
         SbydKGQucJ3nCi/9mAxvmPbbANhWFiszZj0ICKAl4e3HSUFcaxsTWTdDr/ceDZR2nkF5
         1i49Tr/caYH3TtEEeLYghgk+C9AigDkuvIxx7M1AJ9MLnStMDpoeg/Y2OmHoG6z/84if
         kCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717245344; x=1717850144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT5mj85tlRfrnhVxRHRVZyHIGnWChMArh0mXdC5TaDU=;
        b=MY6YtFrAuYyUBfGYoAhz3X6hXRlGzqPzJimpBhIrzPQSc7banUGOIyhuL0yx/nulrD
         MpgFHQHMBS90y5w03gtlPVr3WZMZcaflvBMoSMVnMrb+9Plv9dGWPZrk9fXTgCPi+qkK
         i/bePsagF/Xd+k00lOnhQ7/GXT7d8elOrgqn09lkhkDYPOjQTwHS27lge5XdsfTZPXXB
         44uqTEiAigoqXuifVQYhU8RfFZHogZtKlpbSX/aFsi1xB/ldQbd+djquoqOexeNot8kL
         YDwsGfpANtEoXYfvrcFE/3JS7SGEFMGOzUsZJqZ693LnQCoIGTqsFFsNMYEdR9P7GGjd
         eJxw==
X-Forwarded-Encrypted: i=1; AJvYcCVUvnk1m4TobRe9N5iKT3KITgP4qb6e2gBy8peOx/p4uHPud2lQXGQqk0Dis0mCTjutrgKMSL95BtBbID2aezRRrukENX4Rvceht37X
X-Gm-Message-State: AOJu0YxVPPB8Ewi91LGmVeTG7Zj3FrCFcGPZJ7gZvbosQ3LhENmLEONM
	JZEX5G3zAF1opbaOLC2OmlNUD2LSC9jzqXy8+EhMLiS7YGbN4UlH
X-Google-Smtp-Source: AGHT+IEpUvav2aw6H/1mjoliu/c1vSBEjWM0BfAwWeYkytbnsKtDu98JWv9RmyZFoyI6uPe7gIoimg==
X-Received: by 2002:a50:c354:0:b0:57a:2f92:2955 with SMTP id 4fb4d7f45d1cf-57a361cf32dmr2922617a12.0.1717245343633;
        Sat, 01 Jun 2024 05:35:43 -0700 (PDT)
Received: from [192.168.0.102] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a49deff15sm787593a12.94.2024.06.01.05.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 05:35:43 -0700 (PDT)
Message-ID: <c0f4d6ef-78e8-49a0-9544-7399a9eec9cb@gmail.com>
Date: Sat, 1 Jun 2024 14:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix spelling mistakes in odm.h
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org,
 ruanjinjie@huawei.com, bragathemanick0908@gmail.com, colin.i.king@gmail.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240601083153.96242-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240601083153.96242-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/24 10:31, Roshan Khatri wrote:
> This patch fixes misspelled words to increase code readability and
> searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8723bs/hal/odm.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
> index f5c804a1b9d5..010274ba8079 100644
> --- a/drivers/staging/rtl8723bs/hal/odm.h
> +++ b/drivers/staging/rtl8723bs/hal/odm.h
> @@ -76,7 +76,7 @@
>   
>   /* Remove DIG by Yuchen */
>   
> -/* Remoce BB power saving by Yuchn */
> +/* Remove BB power saving by Yuchn */
>   
>   /* Remove DIG by yuchen */
>   
> @@ -878,7 +878,7 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
>   	struct odm_mac_status_info *pMacInfo;
>   	/* MAC_INFO_88E		MacInfo; */
>   
> -	/*  Different Team independt structure?? */
> +	/*  Different Team independent structure?? */
>   
>   	/*  */
>   	/* TX_RTP_CMN		TX_retrpo; */

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

