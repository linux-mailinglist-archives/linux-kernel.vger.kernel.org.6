Return-Path: <linux-kernel+bounces-320396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F89709AA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B954A1C20B13
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06B178CDE;
	Sun,  8 Sep 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzEPOMts"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2EF9EC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827011; cv=none; b=nacVmK6UswvbOAnrqtNC101XXpZy8Vm3aP+AexCvJsp5e+zxnlN21TFzAMMD4kJenlIHeOSM7GMMxd73tCar8PGeZkx4rYA22a7OHnKW9nSEa9VXoBxvxiqqlF34lQPgzkJcnMGs+8I+K4JBR3RYdkwr9TJ169428lb9HHUI5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827011; c=relaxed/simple;
	bh=OHtWfwUaF50Ny0pvmLDQc/9y6kZO6VoQqfX9NhsF7+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtPcjjpWVv6T6+vU+/KeuqTPR9EfjkcIQORRJ+uKhzYoaQFoBZCnILnuqpbTzoMPVKT7+HeODAC3cMk7O3u91Qlq8bfkbm/GTMIklRpVz3lkcnFlr/GU67eLVt8bWG2NIKI0gMOt2fsXw1VFA3bPXUvwQOo/T2eNFZ011dNpX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzEPOMts; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so13310975e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725827008; x=1726431808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Gbw2QftCty789XpEBkAu/XA+jqNLKKmw4apI0xAyYw=;
        b=LzEPOMtsMookNteiCH1HsDxGC5/m1OmprSA9fOxskIkNRezgl6jVD3j5r9gP6+GCtP
         FHIMwmZf7URCFpGQkKez9C6vz8w6p/HLuPedYqcEDyZ5TxCalMVasIDLFu6xsspVzcog
         8lnnP7/JQSUkiKsqcy/iQoR/BiWzDHwplKlKfN0ZRjsZxDUaWgTFdY6KaSOmkKZ+hjR6
         AYDrbCZGpzGHdx/MqjebIGGM18majoJvaZRa5sq/yQfJFe7RmW7IpUuOlI4HgMW9Eeck
         l4KMEbzL/igYJLi1NtPYwXhF5A/7/YBHsiHuGuITTvlbgwe72RBuwZlWkdVEwDxihCp/
         QuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725827008; x=1726431808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gbw2QftCty789XpEBkAu/XA+jqNLKKmw4apI0xAyYw=;
        b=MOFP5UHD6aHbWSsBfn2J/KxxTW1Alsl8UIZ9YpVg61pWiVHfXUPAyW8Dqesfsc+EHP
         QRl7gOxwmMg/WFRdRNheMsZUEL0XfxtV+7uTdAIs5lBwf8GlUMyHYW+/AIMuw4D/sdwb
         C9oBJEh9xW7eBf+gAWL+eClp1uSYPnhx61p9tAqE3kvVfSmK8+YgqFG0IDEAd8l8c6cn
         qVbVdTr4byR7DpdzhLlFxtfuG+YSjv0z6u1bm8085U/3Ifl0ahBQnlsFt9QSZQufJIAL
         vFMv+QrO/GaTbRMk310D+0NaGHcqHFxXz1lWWA68Hw6nnRnhmmAccMvItkL1mVPAKv8e
         frKw==
X-Forwarded-Encrypted: i=1; AJvYcCVq4KfcY3lq22RIbsU1Oa2boCOoMhYvZNXg2MgSQ4g0U32A6kNpL4HeL4XJww4ZoyBy60d3L1mwCsVKSOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLBvyLffiNNsfaTri+QOkWRxKWn79rqUSnJnrhxZClO3iyEEo
	jVy830bHojEG7H3fm4cDR9qnxcuO53CTF8QMbgPjeZ+1GKUtAAQT
X-Google-Smtp-Source: AGHT+IGiKY0np5iJu0VN+kmjERwrlW1fDWrBjIby/EH07L+o5BaSSXyXVWMc9DgB/LPc2CvOCorCYQ==
X-Received: by 2002:a05:600c:1e1e:b0:42c:b187:bdeb with SMTP id 5b1f17b1804b1-42cb187c004mr24814035e9.29.1725827007909;
        Sun, 08 Sep 2024 13:23:27 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8576:4416:5fef:fc17:c89e? (p200300c78f2a857644165feffc17c89e.dip0.t-ipconnect.de. [2003:c7:8f2a:8576:4416:5fef:fc17:c89e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb45c81sm54816085e9.28.2024.09.08.13.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 13:23:27 -0700 (PDT)
Message-ID: <4176c4f5-7da4-4f0a-a632-d2a46b8d3035@gmail.com>
Date: Sun, 8 Sep 2024 22:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] staging: rtl8723bs: fix use of tab wherever possible
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
 <20240908101110.1028931-2-sayyad.abid16@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240908101110.1028931-2-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 12:11, Sayyad Abid wrote:
> This patch fixes the coding style issue by fixing the use of space
> instead of tabs on line.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>

Hi Sayyad,

please make your "Subject" line more unique. Consider that we may end up 
with having dozen of commits like yours, all of them referring to 
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

Please also improve the Subject Lines of the other patches.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

> 
> ---
>   drivers/staging/rtl8723bs/include/rtw_security.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
> index 98afbd3054a4..487d69460cec 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> @@ -75,8 +75,8 @@ struct {
>   };
>   
>   union Keytype {
> -        u8   skey[16];
> -        u32    lkey[4];
> +	u8   skey[16];
> +	u32    lkey[4];
>   };
>   
>   


