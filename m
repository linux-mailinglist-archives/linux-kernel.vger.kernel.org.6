Return-Path: <linux-kernel+bounces-307507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842FD964E47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66C11C2153C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDC1B8E82;
	Thu, 29 Aug 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKipautK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C31B81C4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958002; cv=none; b=DpJP6p9dHEHJVXkO9+kTSoNdbxbDQL/y5W7dC3zwZUHi6fs5BGGLn2EwuPXr3tcWkmp7P5Rz9NGQcJ9e1Z9gLsH+NL1RonnKkFq60eVhiUSgHqpW6ZRQFKY8F+tJoqtCNE4tAPvobGcpGsuHToigbPblADv/1d2oivgNmokLXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958002; c=relaxed/simple;
	bh=jH0t4VZbwa/Xy2qTSEn80pEHMdwnC1wtRiFc89zs02Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaxG2y0wCYfnVxgMi6k5QIn3mHBAcOo4wsWXYfac/uZSMEXHKhvW5N156y58MDQ8ECtFYOOtR8sgdhqIKg7ROVgfKexRz6T/7t0nenuLY4USOoK9zEiBQfWCFKaUQTqsXfnTQkx/AAP73LW1i0a4pJhpcfFP4glyqKxUrdYUksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKipautK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a868b8bb0feso132556966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724957998; x=1725562798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMQTozCrsrYba54kkd5qEmVlAdSlAeyQmwu6GCVx6lg=;
        b=FKipautKHYyrd/CVM0Gn/QRi5vXK7oKhHoErWhc36KnGD8HaPtwYNAzHZm2OyGIADM
         PUfYWF8AZOudP7zzYgQW3BwtoIYuwTMG0Ue4sG1ulXh41lzLsweoEKD4CzIwIb+w+V/l
         DCzkeqMFjser3r1AkMEkVPYdGugEO5C1RK8/RHT7+Q8SsIjpuDYQK0wWCyrz8qanzy+J
         IvT8v1fbPT9Ngp6COYj90jHJBN2HkfdX5VYDDWBAYYQXkMcD9Pnqq+O0rRIMYkvX8IFn
         t4zcD+7snMJPQSDWpZGfDCK7xxmnuCGP+4irHdUrwCWNoIm3edIzD1s3jfJw3oI6kxpR
         CBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957998; x=1725562798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMQTozCrsrYba54kkd5qEmVlAdSlAeyQmwu6GCVx6lg=;
        b=lW18n7oeGqW1MzFILt+7+DXXe01Cs/3TC34nBvhWPVz0ItRfY+A01FH3zwkNtqarFk
         a7EpCHBC3T7xuQkniMiTAqWOI6UAE5KEQCIsVuuTJI3bakrp9JPMZ3K+zym8f3KY2j/F
         Owdhu50o3jDo6WRtsFfr+B7eZ3zSxuTXyAoK+5Y9iMU/ya8JvjJXYncBvGXJ9mVl55Wo
         ZXf6RmWmEHBxEAhGeXhk1MeVP0YEzR9AtMUXDyd1w8cyrzcu/Y7hHIooUpsXES4I41n2
         5YgnCMSSz2h5HILSbRbNaIMGVolOF2erB3k6Qk3/Lyc7VPKl0YpAzoL7iGMWuI8QGcQJ
         2WuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMdjexgLNYPS8KiDuAeAvkf33A5/DKvZRyOIiMeV6QIxzrbsNkg2W+ZjTehA4EDWbAgvRQbuVBQWFmwZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0NjgB5B58TLJHCvB5LbdCTEGXT/Qg6IHbhPqy09Scv1Bw/dz
	h4wWmoObnTuMmefO7pPArXbybL7uZLWsT8Psf9ltRh/4zOeF4HKH
X-Google-Smtp-Source: AGHT+IGryv3/DL550LtcMK74t04rhPGfTNrqI3KBHZ/MKYlkn4J+I8rKow4BgIPHqeCJcsUqn0Fsrw==
X-Received: by 2002:a17:907:d18:b0:a86:7a23:1284 with SMTP id a640c23a62f3a-a897fa74b89mr264958566b.48.1724957997171;
        Thu, 29 Aug 2024 11:59:57 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8508:ea23:888c:e220:647c? (p200300c78f2a8508ea23888ce220647c.dip0.t-ipconnect.de. [2003:c7:8f2a:8508:ea23:888c:e220:647c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892220e5sm107905166b.195.2024.08.29.11.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 11:59:56 -0700 (PDT)
Message-ID: <01183b3b-b8af-4451-8b52-e7acd0b4a9a5@gmail.com>
Date: Thu, 29 Aug 2024 20:59:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
To: Manisha Singh <masingh.linux@gmail.com>
Cc: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240828204552.26790-2-masingh.linux@gmail.com>
 <607b86cd-d89a-4072-af36-ce2ce5c1f7fe@gmail.com>
 <daecc634-4faf-4dcb-b03b-f57f24673a88@stanley.mountain>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <daecc634-4faf-4dcb-b03b-f57f24673a88@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 11:36, Dan Carpenter wrote:
> On Wed, Aug 28, 2024 at 11:08:31PM +0200, Philipp Hortmann wrote:
>>> diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
>>> index 6789a4c98564..6311ac15c581 100644
>>> --- a/drivers/staging/rtl8712/rtl871x_io.c
>>> +++ b/drivers/staging/rtl8712/rtl871x_io.c
>>> @@ -48,10 +48,10 @@ static uint _init_intf_hdl(struct _adapter *padapter,
>>>    	set_intf_funs = &(r8712_usb_set_intf_funs);
>>>    	set_intf_ops = &r8712_usb_set_intf_ops;
>>>    	init_intf_priv = &r8712_usb_init_intf_priv;
>>> -	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),
>>> -						    GFP_ATOMIC);
>>> +	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
>>>    	if (!pintf_priv)
>>>    		goto _init_intf_hdl_fail;
>>
>> By pushing the below statement after the "if (!pintf_priv)" you change the
>> logic. Is this really wanted? Why do you think it is better? I would avoid
>> this and it would be a separate patch anyhow.
>>
>>> +	pintf_hdl->pintfpriv = pintf_priv;
> 
> I liked moving it.  And I feel like it should be done in this patch, not as a
> separate patch.  But it should have some justification as you say.  The commit
> message could say something like:
> 
>      Checkpatch complains that we should avoid multiple assignments on the same
>      line for readability purposes.  Generally, we would allocate, check and then
>      assign.  It doesn't matter what is assigned to "pintf_hdl->pintfpriv" on the
>      error path.  For example, on subsequent error paths "pintf_hdl->pintfpriv"
>      is a freed pointer.  So this code is okay as-is and it's also okay to move
>      the pintf_hdl->pintfpriv = pintf_priv assignment after the NULL check.
> 
> (Notice how I sold this as one thing, moving the "pintf_hdl->pintfpriv"
> assignment, not silencing checkpatch and then moving it.  Notice how I avoided
> using the word "also".)
> 
> regards,
> dan carpenter
> 

Hi Manisha,

I like to give you an order of importance.
Greg is the maintainer. You need to fullfill his requirements as it is 
his decision to accept or reject your patches.

Dan is a very experienced developer. You are well advised to listen to him.

I am only a part time Hobbyist. I try to support Greg and Dan by 
responding to patches. Typically they will correct me when I am wrong.

Bye Philipp







