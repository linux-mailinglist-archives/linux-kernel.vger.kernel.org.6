Return-Path: <linux-kernel+bounces-567724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A3A68996
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C74F1889333
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854DB250BE5;
	Wed, 19 Mar 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeESyd7q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23220E718
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380131; cv=none; b=M8Gst7OgZIjEnjth1BMCjlbO0s+K06mnQ4nuOL/QIDiUQ0tHlt2OHf26FhNHPpK6yN4sVjWiAn7OzjYjnZFPGwvkzm+lo9bWTqww8i8QK9Ky59cIUxHQrjrzih+6Iay5zpQXw1m9f17buMJq6Vk6GHwL8ksE1xq98u0s4p2rHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380131; c=relaxed/simple;
	bh=rEgY89i+gJemWrJ8RHRvqVZiLIAsS0ZnPsEl0a5jOcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V4NuyW/k3FF4sK5vA5Q2qD5ai+Z6LvMTfJJpdzr7aODREd/IC6gl2cw1jg2ens1uY0fcxxi5f1YubBH9i/9PnzKtCUmA/zhMamXgGYg6Cs+Xno7aD9ksND23UvC6y36t6deWK55Stzdtbi2WgJkF6IHYWCEQHwVuTMDiqEFEZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeESyd7q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742380128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqT9EgtacH1pGzAa8bINKY6LuDFSP+bccvn9tGaRagA=;
	b=JeESyd7q/lA++orEdcHXXBf5V6Y44ID6APCo1vgRFoZEJV+udeor7sG38albvim491F+DK
	p4jF4f5F1VZ/ESHxIEdvqY9fgED2C9NYDiahuty0flVO3x497Aj/1M+Wf8HuCD2Qy/MU0a
	8xA1Nc1Rau4dFOG+xX371XuESc/XGUw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-ciDRAdjvMQe_nrcK0ExNKg-1; Wed, 19 Mar 2025 06:28:47 -0400
X-MC-Unique: ciDRAdjvMQe_nrcK0ExNKg-1
X-Mimecast-MFC-AGG-ID: ciDRAdjvMQe_nrcK0ExNKg_1742380126
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2255ae39f8fso13341125ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380126; x=1742984926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqT9EgtacH1pGzAa8bINKY6LuDFSP+bccvn9tGaRagA=;
        b=SLCZof/DQg0Q13slfMX4lrjESO6ViBQPEWSzwZ5AEOHqkqMUvByXGoeXPj3VwHxH1m
         Ev3LKuRCJ73rzahqxNOGClf961dmxb/ImANezkFMkttVbVxPrB3xomPi22ls1cvVIo16
         41ULJSNqfIrK6nVkfGWKxvButnck/DvoHxkrsFfhRcnNiof/y1hSUyYblIlWFi1SR0DX
         +0xtEeMoTXflWoI+qVEBY0lh6n6l5REvzCC3Rp9j+Izkk1c+L7HV9HNP4Z0jcFKtEiDT
         rkbZpAxl9rVJ9eXvIG9KzhtM8HFR+y/J1x3eAl95MmlhUg6TQgMGr1pDcM9yjD7wN3t+
         8pWA==
X-Forwarded-Encrypted: i=1; AJvYcCWGFLdqdZH6h5/6u+rd5bdmmSvrjgQAfl4n86JdAwPbwTjl4q4im+x50RgnjFrZdnsQTTlzIILmSM0yyGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhT7anPO40orBVUpe5E6WeHXXPlikxQwCM/WjC6V1z3WmKGnR
	GVOm5iRV2ZiNmNTONqP022mCbH1hSlCjLfX9qdZNSJAIfL/oDni7rbLda+mY/rVqSRpZwRrX7qZ
	WJRCkCooeN78EHZuM6bmOLkQPyq7+ebS9EBwCvDqR8awGBuTlKna6qY7ocE6zsw==
X-Gm-Gg: ASbGncuXipD7VHguY8SU4pLtL79nnqvT95mnPoimOd9z8jZDctu/C6oX5rhDHc5eU1d
	sB+mYH0yohcla8uOIWStqth1I5N9hv+NjRSw8PQw+N/keOKt8BZWoF7pbySPluZUAUfae6BFz2F
	C5xHvyU0Zq3mPZEqF1/geYa+9w15j2ipu7lk8oifZNNptp8yKcV9OePG/QigTIbPVYwm1iTuuLZ
	SRteswfHY3Su6xByKPp2jsfeHWM2fdnM0SUv+6hoTq/iT0FITVFLdCKb9Itwe7Kdnd5t4SsdzX9
	sCadowZyaIfz7uZiJw==
X-Received: by 2002:a17:902:d550:b0:223:5187:a886 with SMTP id d9443c01a7336-22648f0cba4mr43831015ad.22.1742380125921;
        Wed, 19 Mar 2025 03:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF115S9F7K8/VY/uIVVLVdYu52ScoDkva9X27jsROIn1MQLuwsTdtxucZqN9UFjhuGUvr6o3w==
X-Received: by 2002:a17:902:d550:b0:223:5187:a886 with SMTP id d9443c01a7336-22648f0cba4mr43830585ad.22.1742380125494;
        Wed, 19 Mar 2025 03:28:45 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe960sm109981735ad.200.2025.03.19.03.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:28:44 -0700 (PDT)
Message-ID: <28cb8360-7fb0-46f0-b05f-5114f1974cf3@redhat.com>
Date: Wed, 19 Mar 2025 20:28:38 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: psci: Fix refcount leak in psci_dt_init
To: Miaoqian Lin <linmq006@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Will Deacon <will@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318151712.28763-1-linmq006@gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250318151712.28763-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miaoqian,

On 3/19/25 1:17 AM, Miaoqian Lin wrote:
> Fix a reference counter leak in psci_dt_init() where of_node_put(np) was
> missing after of_find_matching_node_and_match() when np is unavailable.
> 
> Fixes: bff60792f994 ("arm64: psci: factor invocation code to drivers")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/firmware/psci/psci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

I'm wandering if the fix tag is correct enough because !of_device_is_available(np)
wasn't added by bff60792f994.

> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index a1ebbe9b73b1..38ca190d4a22 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -804,8 +804,10 @@ int __init psci_dt_init(void)
>   
>   	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
>   
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>   		return -ENODEV;
> +	}

The fix looks good to me. The duplicated of_node_put() can be avoided with
a 'out' tag added, something like below.

	if (!np || !of_device_is_available(np)) {
		ret = -ENODEV;
		goto out;
	}

	:

out:
	of_node_put(np);
	return ret;

>   
>   	init_fn = (psci_initcall_t)matched_np->data;
>   	ret = init_fn(np);

Thanks,
Gavin


