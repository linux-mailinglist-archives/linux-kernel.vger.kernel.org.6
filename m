Return-Path: <linux-kernel+bounces-445331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303159F14B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624E0188E360
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAAF1E3775;
	Fri, 13 Dec 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxcGo0hH"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585192E62B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113398; cv=none; b=H7Jvddu7o60Ou36HP1rpeqr546yvJbyQ2uBCo85GPCsj673/sWpkQMzt8xEfqZHr/G26+24uYBCQ+9yD5/gPdPvabLJ44iUIjRepWsJuR0ICyzcVwABelA5SM/F7f5Kpge+zUz7/AToO2Q0oYIQ6chG9bVD/SJj5bK+qIfbJI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113398; c=relaxed/simple;
	bh=rI+WmsirSMICnjhz32U/bi7oSdfKxYzzvo5ltmVDgrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gginf+5QmB5i9nQ70G2IuWPFgYzsMCQPsKifX188+CWuABm2afc673HrCpjPuzFTi3LtffHC9qHs5bu0xr0OF8x5rKhZ7+Dqy753XXo/MvYrgrgwZ+2Xh5QPyQe1Zolne4QNZZ1Bst4fjZHFJwoy44f2U4xwyMSBrqk94RxnJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxcGo0hH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so1787225a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734113396; x=1734718196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6SE9LAsIjOb67rG53LUPLPNzXvBv31Ro3v0uqa0k4PQ=;
        b=jxcGo0hH3zQGOn5S6jBvZO35juq4qxm9H+GIAbGTmwAiCHEp/R37SL2t82xP+EzCtc
         +YFcUrTKg/SKE2QWsRvaF+M50+Y0f9ZMGeVsUuHGd78HbOhe+cYND3FYCuElrTZoHVdM
         UsgkdBQluDigQP4fT4mj7yDn9V8tkcyK4Wk81F3hk5QvzBhLYOgNUq5IiSvCe9sEwn7F
         h3ZAc/S5MKR6sxWfPvOakQOO+1t4q772BsD8Oe7501agD8LYEqqAKvIZk4CxgeJcO0m2
         95+MPv4Jp9+HkHvZxYml/r3Wg5ZX40kTZvJmiyecbVUQmj5cxgM6YDaf9re4M+UgPQyf
         Ukag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113396; x=1734718196;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SE9LAsIjOb67rG53LUPLPNzXvBv31Ro3v0uqa0k4PQ=;
        b=Hv0GMnUukVbxa++J6ydClEfaxXHZRjI7RnJleQrmJEfth/aJ2eDYFF0/0hV2pc9xqz
         Yk56KqRBJrr7WPsXTRlLx1RPqNB2DtprwJZYIvWuligZqoKhnNXLgvujYfrs8M4cqFys
         ZAUs2dkEsSoAvUgYqrP+vbCFDCcpjC9usnMS4raBzsCYAg513FULe9Lpswd5z8xR8+Ib
         kKQfABtZkWhmkjT2fF1yxhBwWxupNdHnf120s7jX1RjOIK5/AayUa5fxy7wnTbvmnCxN
         yEhHtaSmnDg0cbP65+aK7RWIMXAn3TdZMdpIuRLHRHZBpMeGTZBCAlpOj9F8jXxZloAz
         Aqww==
X-Forwarded-Encrypted: i=1; AJvYcCWnSHFnfcWFadWzuu6umxEXcdFzE607TymgDBKx5PWku5Mmnqhdi/4WVJSwpYXqywRCPWWYphH1GjV+4s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qnf1PqyEUnnQEwSSeTahBGCylw3FFyJVHrYBP8x9enLvOUhB
	t0ivf0zKiDwOhuphCVqKN/DOlS8CBwSjOva2eu+rw5rzy0EUdB3T
X-Gm-Gg: ASbGncutMstn1bAsfAFR0y20+CG/E1hdTc3vXu1ypHu6g8LByqQuTYQmq6TrYdZvLJs
	n5XBC81ikubVPbsbSJcnvAri5zZBpeeuAzT2nKt4wF/GdZ05THZeRmWDwWz66jPvgo/itTNDpIE
	4Wl3NQPd+FEL8v6eG7necZWBvX4BOh2JjHnHIY8Wcz2Po4hB1INBby8vOODDC0Vh+cK89eaGMGd
	6TCcHY3nZ6TXthNy0xrIXFv2WEMuG+MEk7LNwG+qI7te/ucJ6cO6ynkP1XjO5itFpY6E8VfJqlY
	enldATg/oTVDyukaRA0W12p8pA63Rg==
X-Google-Smtp-Source: AGHT+IEjfEIkzZLAz9ocfjuiWYJv8nUqykScLqXHgGdZuCGJY0SWHeS/YlJUTh9o2APljP2qHwzwgA==
X-Received: by 2002:a17:90b:2f0e:b0:2ee:535f:ac27 with SMTP id 98e67ed59e1d1-2f2902aea9cmr5639280a91.33.1734113396617;
        Fri, 13 Dec 2024 10:09:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434adesm71150a91.38.2024.12.13.10.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 10:09:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c49fdfd3-bd0c-48f9-897f-cf968f69bd86@roeck-us.net>
Date: Fri, 13 Dec 2024 10:09:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] staging: gpib: Fix i386 build issue
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
 geert@linux-m68k.org, arnd@kernel.org
References: <20241211164452.27464-1-dpenkler@gmail.com>
 <670d63a3-6b20-41a3-a4db-96b407b80202@roeck-us.net> <Z1wSIzBOZu4gUJhv@egonzo>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z1wSIzBOZu4gUJhv@egonzo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 02:53, Dave Penkler wrote:
> On Wed, Dec 11, 2024 at 11:42:36AM -0800, Guenter Roeck wrote:
>> On 12/11/24 08:44, Dave Penkler wrote:
>>> These drivers cast resource_type_t to void * causing the build to fail.
>>>
>>> With a 32 bit build and PHYS_ADDR_T_64BIT enabled the resource_size_t
>>> type is a 64bit unsigned int which cannot be cast to a 32 bit pointer.
>>>
>>> Disable these drivers if not 64BIT and PHYS_ADDR_T_64BIT are configured.
>>>
>>> Link: https://lore.kernel.org/linux-staging/2c6c7e9d-ca10-47a9-82a7-a2e26b1f51ef@roeck-us.net/
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
>>> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
>>> Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
>>> Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
>>> Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
>>> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Guenter
>>
> Hi Guenter,
> These nice patches from Arnd fix the i386 build issue without having applied
> my v6 patch:
> Link: https://lore.kernel.org/linux-staging/20241213064959.1045243-1-arnd@kernel.org/
> 
> I tested only
> make ARCH=i386 allmodconfig
> make ARCH=i386 M=drivers/staging/gpib
> 
> -Dave

I don't care how this is fixed. What I do care about it that we are close to -rc3, and my
test builds still fail.

Build results:
	total: 161 pass: 155 fail: 6
Failed builds:
	csky:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	openrisc:allmodconfig
	s390:allmodconfig
	xtensa:allmodconfig

all because of GPIB problems. Given that this is a staging driver, I am inclined to just
hard-disable GPIB completely in my test coverage. I'll do that after -rc3 is out.

Guenter


