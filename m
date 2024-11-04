Return-Path: <linux-kernel+bounces-394804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD09BB424
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6E5281159
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFAB1B4F1C;
	Mon,  4 Nov 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmQkt9HR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF6188700
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721880; cv=none; b=Raa+/8bg4WedYTNvlzm0siZ1pLqnvFXiY6WhCUCnaOjORUfBHEZ87Cyw37ojNgNiMahndX9KKVH8VZ6Vt0ODFJjnFbG6b97suC1Qykd9+x9VFunv7GyVZh4zip+sbynB5NlyvgN1EcTa+ZWaoqE8pL23rrQyMbRX4qL3v282FMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721880; c=relaxed/simple;
	bh=bKsxPbLJOjhXS5dwvRb7gDQwbg3TLOfgDt0fz6KwnIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs7hUMLTy/hmLAfRxIbQLMHvDA4akc+7tWIb8G34jOL5Ip8uthCLiOly/Va117u0XakDyho+5n2eI3t+2PY8BY01JVPPpL0469kXBA25oOu8ZwqdL0cO6PiXRRhq4UkmGWZNArOTu1Q7ZbUIMJ1jGISBrS8soSHOr5gqT39eK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmQkt9HR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730721878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRhG8emybav1jveE3I6lnpbMlJJQ1NkRHJ/vqZ/lKwM=;
	b=SmQkt9HRWRmAberA/0yCSY2iTfJvjyAeJhjcC3VAuBgsb0IcKEj8gHpdwTJJDXIfSWlyLj
	L8N9297LKrDIqw8Txt507TKqc1k3QifeMWDGznNOEWKH3Ib+g7Xv+jAUz2jVsCVAEkHmGP
	GZ0ApdhrBWY6WyYT6r5wk9Vvnl4977U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-tCqyMiv8OVeXfOo9UCCM6w-1; Mon, 04 Nov 2024 07:04:36 -0500
X-MC-Unique: tCqyMiv8OVeXfOo9UCCM6w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c9338a16cdso5479584a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730721876; x=1731326676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRhG8emybav1jveE3I6lnpbMlJJQ1NkRHJ/vqZ/lKwM=;
        b=aBVMG4hO6pqRdfcE91AKQQ1MY/KR35XyGiL279+Ly8ZBWIvpr7VPsW0xOcyPKqiZQh
         ICHP2vOICCvcyFkOf8Mj40N1ETre9DQzZ64Aiff/3lCB3KaQ/b4PW79KAsaHmqquZQbt
         jds4sJF5f5QILtH2xWKqCv62StH9Amg6JKMpaANl6vQvBB9Xg7hd5zBNmh6C9eHHtEKV
         KfEU6EM+pZP5RpKe1GGNbnynw+eSE0DasQaUYU1weCKi91EeEOCWLaSrlgAqYKN7Gwj3
         qjSDayQUx3fLwmjKzr7KxDtSMk+R1jbdnn8g9ETVUaJY3hVKM87Td4+wi07yQ31M7BNc
         SFKA==
X-Forwarded-Encrypted: i=1; AJvYcCUclfwMzWfwvzQDW4JepybIfyNfUAJ1cRqHS0Az1OTOWwaCceY/Xh3jkxW8tEAUj35l3wVxoimzBRezLaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKh8pKFDaoXRdmvM1rLe8I/AIoDoHga9gcdhNgFZCiv7dguopq
	h6vXJQamNCXq9fHp3jOml94dBMgRVFSvzg4rylcBpBP2wtZQxWC3ezl1jIOEytMSKpwb2ULxQHl
	LumbT7i6lThP7iDBjG+DptmzV62uzL+0BNyfNlgi5wE7Xk0mO714BWSd0pUIFpg==
X-Received: by 2002:aa7:d490:0:b0:5c5:c2a7:d535 with SMTP id 4fb4d7f45d1cf-5ceabf49e20mr12028246a12.16.1730721875622;
        Mon, 04 Nov 2024 04:04:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm/rpK0+UAygyYv+wvXZBfqWjdissJMQdbMV9lkyNEypi5FgacHmiCaOjPUnh7ECYxzDnZTA==
X-Received: by 2002:aa7:d490:0:b0:5c5:c2a7:d535 with SMTP id 4fb4d7f45d1cf-5ceabf49e20mr12028221a12.16.1730721875230;
        Mon, 04 Nov 2024 04:04:35 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac77051csm4161402a12.32.2024.11.04.04.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:04:34 -0800 (PST)
Message-ID: <24dadaaf-54ec-4f3a-9c6a-9aea755d0150@redhat.com>
Date: Mon, 4 Nov 2024 13:04:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: atomisp: Add check for rgby_data memory
 allocation failure
To: Li Huafei <lihuafei1@huawei.com>, mchehab@kernel.org, alan@linux.intel.com
Cc: andy@kernel.org, sakari.ailus@linux.intel.com,
 gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241104145051.3088231-1-lihuafei1@huawei.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241104145051.3088231-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4-Nov-24 3:50 PM, Li Huafei wrote:
> In ia_css_3a_statistics_allocate(), there is no check on the allocation
> result of the rgby_data memory. If rgby_data is not successfully
> allocated, it may trigger the assert(host_stats->rgby_data) assertion in
> ia_css_s3a_hmem_decode(). Adding a check to fix this potential issue.
> 
> Fixes: a49d25364dfb ("staging/atomisp: Add support for the Intel IPU v2")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Thank you for your patch(es).

I have merged this/these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this/these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans




> ---
> Changes in v2:
>  - Corrects the "Fixes" tag.
> ---
>  drivers/staging/media/atomisp/pci/sh_css_params.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
> index 232744973ab8..b1feb6f6ebe8 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_params.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
> @@ -4181,6 +4181,8 @@ ia_css_3a_statistics_allocate(const struct ia_css_3a_grid_info *grid)
>  		goto err;
>  	/* No weighted histogram, no structure, treat the histogram data as a byte dump in a byte array */
>  	me->rgby_data = kvmalloc(sizeof_hmem(HMEM0_ID), GFP_KERNEL);
> +	if (!me->rgby_data)
> +		goto err;
>  
>  	IA_CSS_LEAVE("return=%p", me);
>  	return me;


