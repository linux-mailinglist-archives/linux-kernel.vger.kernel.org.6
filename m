Return-Path: <linux-kernel+bounces-187175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051868CCE19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4041F21657
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009113CABE;
	Thu, 23 May 2024 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eQrOMy2/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3513CA8A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452292; cv=none; b=esHTv6GlJ2uOsq2wf8z3cQoG6rUFHgaztbRr0KhfpYFXBDQLwdk/7lnNGJz+CEeHEc0auz/ZGyvkEpB88H6M5SiZNyn9iPyUDp0joa6b57rzupWwjnWgnrWRGKVT1gPUDZjh0QpyQqA4H1C7rYqigQY1cQJCnEoZ7ubn3Cnotg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452292; c=relaxed/simple;
	bh=2KTk0vFDTtEskeGWDlVvZUG9LfaG410pCuPrRVCCZ7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kah6RJVzyd0PR8I2WJoFHwNI7OZ6zHORvSe9OXT2WOoCU/i9AsFALH8+piKZm2rXzwuUzUeiukeBVEJbA3Ss2FxOpCXmlz4Y+GfqmoJ8fbjsZG9wLdvytzjHojisxcGGGbxGThSvrTVLDKahyuyHo6fZU9K/zsWwbjOrOv7WjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eQrOMy2/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-574bf7ab218so11829091a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716452287; x=1717057087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21lU/wOObW9nHRj3Ls7LD5UYrlZfeNZ8c3JM7X95WyY=;
        b=eQrOMy2/E2lxM0Zp+aSbKFGDd/hxKIVYn1uSGJFnYDoQjKh434t6OBYAr/T04UoxYw
         vE53M6tbtpeIBeK7N7eYayHYI4u3IHi86iFpZN7b5N3WTdVuUgYgGWsXVxKOVONr0FrS
         wuCf7vIiG5V/NkH+67Qb4Z980V0t63onPU9+02gH3rtglQrpxMxs9IoBJRHwIBR8GUCU
         XKthEpZxDAvoKraJsUywebdFSas0crtA0oezv7AUofxdVP3aJ/lVKjkN8KnmoEqV5xNL
         NRsDNkWa9iqORkPkIy2KWMxARpdIgWnejGtgcFVaRkqgzKrUwQEpQAa8uuW3USnNGLAO
         jSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716452287; x=1717057087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21lU/wOObW9nHRj3Ls7LD5UYrlZfeNZ8c3JM7X95WyY=;
        b=F19NeYvD/ucudmH8I4kM0exZRmFx6PlJP501viGUTms263d1YJZIOpatlbpHLAPF7Y
         HtMqalMZgE0bDqzGtYkggiemJSJuXdgabZNCqp6BshACTtI52uNyCwYQb/UGkz+XpG73
         TjsXrB1I0Myz11/JGt5fMzvNAMMLaJABm0tqFC6VmT/QQvNg/Sib5sgea7tFsdMkzbon
         fEO3jLPCxQg+/W9Jd9kyWmdO0w0fJ5lcT+P0aLNrrSWsGQZGVHfv9x4IY9f5H3fSyTG0
         HjPGI4RUyHa6Vw9pJt7thd0uvDbaxE5g3NqxP2490aC5YRocnOuzrGfbqK5JFXTgid2N
         kZnw==
X-Forwarded-Encrypted: i=1; AJvYcCXzEEUWduZQ/89CXKlk728Hw8kcWB/ZxmEOyB+MozIDQZyBKZSSl5+Gl1VWySCXQzv5KhRgfxIEeG6BRW9R2/CpQPbO8SXx6P817XO9
X-Gm-Message-State: AOJu0YxvJ6avSi/0TQynCl/UplDmhppuUnXbWa9PTwAN/J17wPxvdUoE
	lqze3w5vnLkFH2GvYI15yZ7o/cKLX2QZN3U7L0xRGS3Slb2ZNMZxBVfRv56xFqY=
X-Google-Smtp-Source: AGHT+IHe+teHQABE5Mik2uPAaKR/j5ry4BDHhUfTX+msAC0v/2NUn5aVNWy8rF5dBb9ysWTD2wEmIQ==
X-Received: by 2002:a05:6402:35c2:b0:578:341f:86b8 with SMTP id 4fb4d7f45d1cf-578341f8744mr2826677a12.38.1716452287314;
        Thu, 23 May 2024 01:18:07 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5784898d04bsm451835a12.61.2024.05.23.01.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 01:18:07 -0700 (PDT)
Message-ID: <a218cac3-9d9d-4ac9-8ea3-0ea9822b2261@suse.com>
Date: Thu, 23 May 2024 10:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Check whether divisor is non-zero before division
To: Shichao Lai <shichaorai@gmail.com>, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 yue sun <samsun1006219@gmail.com>
References: <20240523072242.787164-1-shichaorai@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240523072242.787164-1-shichaorai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.05.24 09:22, Shichao Lai wrote:

Hi,

> Since uzonesize may be zero, so a judgement for non-zero is nessesary.
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
>   drivers/usb/storage/alauda.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..db075a8c03cb 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -947,6 +947,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
>   	sg = NULL;
>   
>   	while (sectors > 0) {
> +		if (!uzonesize)
> +			return USB_STOR_TRANSPORT_ERROR;

May I point out that uzonesize does not change in this function?
There is no need to retest within the loop.

>   		unsigned int zone = lba / uzonesize; /* integer division */
>   		unsigned int lba_offset = lba - (zone * uzonesize);
>   		unsigned int pages;

Secondly, alauda_write_lba() has the same issue.
You also need to check in alauda_write_data().

	Regards
		Oliver

