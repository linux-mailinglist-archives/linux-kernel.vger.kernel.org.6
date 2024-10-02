Return-Path: <linux-kernel+bounces-348330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106998E605
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EF21F23BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B71991BD;
	Wed,  2 Oct 2024 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jvc28QXi"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B02F22
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907504; cv=none; b=qDPCFU+McI01Txaf56iINnJvrTt5YW4lTRM/VCwTuV1TDE9cAsas8MwtDOPv/Yxq5qeZR7BOqEaEneIx09ACaLPXnB2CA7gj/UwaI+W/RaMP2a+ZCplChLDCgtpkSRdCkLAd9ARFt8TUW1Dv4+XFG2T/iUuWbA8YMuMOdM0gKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907504; c=relaxed/simple;
	bh=8uPfWG19yF3aqQFsnZan4s+bbE6R/wlH9vxN4ljOZHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te/Ko/Q8C3Pwx7/NYApfb2MjnEXkjYRmiLjiraj8aJhTzP3A0F6pfDEFfhKUQv4Rkb6LJCZAyrYtf2QWjKYzmskOYGkat+79SdYgymb2AaAoMLQK7zk/42PcGjNne/HYcom0NjBrICmRZPFcwDa8AA7bBJlhmMetKHY7zUaPmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jvc28QXi; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-831e62bfa98so13504839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727907501; x=1728512301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TBiC3q4b6RD/UIruMuT+TcjVgJIbtpp7M65coVbxT4=;
        b=Jvc28QXisEyegtcHat7vK0oYyoAw4H90AvK/68iADoX8JgbOunqAKUgmh3Fy5AHw10
         KrfpgDkG2qDXA6cbhwQ3aKZ0BKJT+ANf6GiNv0gAJ1xLbmWUeudkg/vqSNLFxyHGLyR5
         xK3TKnYS895UFm8psslw95bunmDJvQO5Lodx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907501; x=1728512301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TBiC3q4b6RD/UIruMuT+TcjVgJIbtpp7M65coVbxT4=;
        b=WPFaJFlHFG1nHn3srDvuxRID4YTR6XAV6h1x5EUcSPDW56/cpbRg8RmZaHRZaw8DZC
         JG3pfTkBT6CgB1GNzQu5QkKLslXKQxuLVzr5qJnvZ4Rb/rhlNKA5gQtetBtV2TUw2y1K
         HnjCYLNNMnJKQi/IiaQGqdDOnuIdgOVL0Dkj1odL0l1GOEKmVNfw2c+UaFMf71+iVc79
         o4DunHwSMhTWz9PIM+povvHlw4PkJUA+7O+lWPqadeIkOspzLL+HSmcGCNs+uAGAWOhN
         +jRFL/bBoBsz2iNH177CzMtIOpI6jfUmnU81lW/rld3nn9UWYFYkzivSQfHJRMd8jzKI
         6JeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTUcDSyM51AM7qdYsw/ZR0tpn67ucW1rqgncKfZiNr0le7Rys4scrEg3CAsTk6WtwjapF5+ZFqmfdI0dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOh9gV8nG6GvB2abhYxQIOjR62/ep1KoKY415aSSIc6/OZKnC3
	ykgIWixQfF8wXvjQE3zBoMQ2RbwpxsQrHH8G1fGk5rD0TTXDsLCunVHZncCcvIk=
X-Google-Smtp-Source: AGHT+IEi4wRMzDqdGUEXEyTO3MQ7pCS5rfjx+lNwgmbv85uzhSg1zpHPPXkArmrG0qOpWYWAo83a8w==
X-Received: by 2002:a05:6e02:1386:b0:3a0:92e5:af68 with SMTP id e9e14a558f8ab-3a36594a26emr43209945ab.15.1727907500818;
        Wed, 02 Oct 2024 15:18:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a370901108sm10395ab.31.2024.10.02.15.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 15:18:20 -0700 (PDT)
Message-ID: <2d4550f1-7097-4b97-94c4-b1c8a50e6946@linuxfoundation.org>
Date: Wed, 2 Oct 2024 16:18:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: nubus: Fix use of assignment in if condition
 in nubus_add_board() in nubus.c
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-m68k@lists.linux-m68k.org
Cc: fthain@linux-m68k.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002132820.402583-1-sayyad.abid16@gmail.com>
 <20241002132820.402583-3-sayyad.abid16@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002132820.402583-3-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 07:28, Sayyad Abid wrote:
> This change help improve code readabaility by
> shifting the assignment statement just above the if statment,
> which was earlier inside the condition.
> This makes the code clear and easy to read.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> ---
>   drivers/nubus/nubus.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
> index 08cf585cb471..77da1d14a1db 100644
> --- a/drivers/nubus/nubus.c
> +++ b/drivers/nubus/nubus.c
> @@ -735,7 +735,8 @@ static void __init nubus_add_board(int slot, int bytelanes)
>   	nubus_rewind(&rp, FORMAT_BLOCK_SIZE, bytelanes);
> 
>   	/* Actually we should probably panic if this fails */
> -	if ((board = kzalloc(sizeof(*board), GFP_ATOMIC)) == NULL)
> +	board = kzalloc(sizeof(*board), GFP_ATOMIC)
> +	if (board == NULL)
>   		return;

The code is consistent with coding guidelines. There is no
need to change it.

>   	board->fblock = rp;
> 
> --
> 2.39.5
> 

thanks,
-- Shuah

