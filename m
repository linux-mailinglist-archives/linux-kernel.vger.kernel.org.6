Return-Path: <linux-kernel+bounces-392307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CFE9B922A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1FB214CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045E1A01C5;
	Fri,  1 Nov 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4kMwnht"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C615B984;
	Fri,  1 Nov 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468303; cv=none; b=U56enbwihq1NNOec9q400i95Ao/fwr6Ssr4PYDw/BcsWg8/ZyPLjofON7MBEqs93Zg/2AdFGJDYmZXLGZQmdliaWNfAA+dA5XenAdLVT7loekB6cNh5FBG4hD6atT0dSqfZ/g+nuUbW/uVlub44OwlaFvPGmy12W8g38AYK/K/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468303; c=relaxed/simple;
	bh=7iVhs36L4kjopcpycbaXdF0gKqCmuaVVNyhJLlw/dpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH5KqmhcTZvhJJGuX02ZEzyMniDGov5Ny6xg9pTrcqhhKbzi3szZKRX3abtgcYsL73F9CHrcW+6KSl0udpRhrKTzQsu9bLCPeoFamheHZW5C58HVIN4ezwIH+ISrBmWKZsKhH84l4sIIQBohOVbNBkkhaTcENB3VLu648zyeASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4kMwnht; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so19248591fa.3;
        Fri, 01 Nov 2024 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730468299; x=1731073099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hc8bwNP6FEzXbY2UCs1v+hwxnKsEGZwCErUPzqiabao=;
        b=Y4kMwnhtJ0oxoqa8gOGhzWdp/nzWvz40G/dz3uaJ2aG8q57Jd6a+pnZcq+BB2j6BdW
         f3WSNIVlXpyXkISeAmCqxlshfKa9Mv5TqMnxz5ibcxeC8KOuhsfdV65NUgrtVhX4hNz7
         b3/dj4DCgI+UuYPuX6B3wDdLYQAS65PdX4Z1sskuPfOhZymhvhnuiFjkUaVh8BUhOuMe
         kCSRa49LXg4zEv2bpEGkMMSrrZ27mqR/2+An1ZPQ8BkzmHrYWdR8LR/I1XlLqeLpVECi
         68V3W7YZFclMd8eItaZgIsNDceY94CsIrIs0y8xctgpGca32x/ufIgZnc7JkdnjOucxu
         pCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468299; x=1731073099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc8bwNP6FEzXbY2UCs1v+hwxnKsEGZwCErUPzqiabao=;
        b=Q5HbKGr7lh5MSE+UyZn6KFicLpQFNXZ40bq8f7YLM6yAuNdcPWSWSyXaMxKOdM7ZZa
         v03eXOBOiJmUZY0Z29V8spPl8ts0pUjPknAEVCYMZJWP3VSRt1knX00yGoT5MJG5DqYg
         w8ku8JN8UYtX/VvngoVvZhJD4b1NDsNDFPyHMkImJIOfItEmIstFPwA/jVppzbEcm2c2
         /txkzay5bOs/ONrAa8FAGZADE+6mGJZS2C8lvdWaQDBeffdfPLJiA5yLFeTONY/t4FPL
         jrzXmjryWjzbDsyewgC1pfI/CSxnigiiKCmfVxArqD0hJlH19ZGeGasbhPFabu95WIjY
         Z1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVIs1HcQnJEeBzQ8vHkoHW+YLI+NiXSVQBQ68NC8sGH9eCa+DIe3y6jyUWee9vhQvAClDkYFCiDl+qAEfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyj8mcl4mygi6je2yD4QBDH9j4cgAtWArjZCwemft4lHj8GzSg
	OcZelEk0+6wzYZsAHXkZbFxocbK/zkEqzmi/c2WvZ+luYkpIvWc6
X-Google-Smtp-Source: AGHT+IGe+YqPMG2ELX5Etn1+nK3xWnTit/IwmK2PSJ5L5om9zWiQS7kStt/a35pvW356nfnh3NPURA==
X-Received: by 2002:a05:651c:1987:b0:2fb:6465:3198 with SMTP id 38308e7fff4ca-2fdec4ca375mr39400961fa.5.1730468298840;
        Fri, 01 Nov 2024 06:38:18 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c3b1asm5681181fa.120.2024.11.01.06.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 06:38:17 -0700 (PDT)
Message-ID: <fe25c0a4-7e1b-45f3-b413-c52d033c7906@gmail.com>
Date: Fri, 1 Nov 2024 15:38:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
To: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, dakr@redhat.com,
 linux-kernel@vger.kernel.org, airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com>
 <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
 <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com>
 <ZxkPC-dLRBqBKZ5J@Boquns-Mac-mini.local>
 <CAH5fLggEGMVspJoO6CE-gTa3-OHfkUnS=L1X-VNC8Cp57GYVkA@mail.gmail.com>
 <Zxk7Tf-jhSse51AS@Boquns-Mac-mini.local>
 <CAH5fLgh1zXRA1dHBEtiNxWW8kNMtO47bBnaFLVhpzgxsnS1ysw@mail.gmail.com>
 <CAH5fLgjLouU9ZRabJtP9qK6RWNLHZvW6dtUqbCkzFqZO+9skTQ@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgjLouU9ZRabJtP9qK6RWNLHZvW6dtUqbCkzFqZO+9skTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alice, Boqun:

On 24/10/2024 10:33, Alice Ryhl wrote:
>>>>>>>
>>>>>>> Please rename this function to from_raw to match the name used by
>>>>>>> other similar functions.
>>>>>>>
>>>>>>> Also, I don't love this wording. We don't really want to guarantee
>>>>>>> that it is unique. For example, pages have one primary owner, but
>>>>>>> there can be others who also have refcounts to the page, so it's not
>>>>>>> really unique. I think you just want to say that `ptr` must point at a
>>>>>
>>>>> But then when `Owned<Page>` dropped, it will call __free_pages() which
>>>>> invalidate any other existing users. Do you assume that the users will
>>>>> use pointers anyway, so it's their unsafe responsiblity to guarantee
>>>>> that they don't use an invalid pointer?
>>>>>
>>>>> Also I assume you mean the others have refcounts to the page *before* an
>>>>> `Owned<Page>` is created, right? Because if we really have a use case
>>>>> where we want to have multiple users of a page after `Owned<Page>`
>>>>> created, we should better provide a `Owned<Page>` to `ARef<Page>`
>>>>> function.
>>>>
>>>> The __free_pages function just decrements a refcount. If there are
>>>> other references to it, it's not actually freed.
>>>>
>>>
>>> Then why don't we use page_put() there? ;-) And instead of
>>> `Owned<Page>`, we can wrap the kernel::page as `ARef<Page>`, no?
>>
>> I don't think there's a function called page_put?
> 
> Sorry I confused myself. It's because it's called put_page.
> 

How do I proceed with this? Should we use the page's reference count to 
decide when to free the allocation and use put_page() instead of 
__free_pages() in Page::Drop?.

In that case, there would be no need for `Ownable`, right? As we could 
just return ARef<Page> in both vmalloc_to_page() case and in 
Page::alloc_page(), letting the kernel handle ownership internally.

Regards,
Abdiel



