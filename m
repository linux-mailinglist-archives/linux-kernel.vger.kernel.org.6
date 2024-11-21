Return-Path: <linux-kernel+bounces-416720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF99D4931
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7056B1F21FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE671C7B64;
	Thu, 21 Nov 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJu90qSZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014AAD2C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179115; cv=none; b=GnKfQVyGi6m8HBm3mx47XkRcOqPENgabuWYgQCvQ+BCwWKsbhf5CQi4AYSFAvOTw3EIZUm1JTfHqt5gQ/NAfvfFjxZ8OI/2+iT5WfgCIvDcONLYWrRqHOLbxFz3hULctSgE+zlACzGwExZgiuVBVsFjn/w730q/9K1yJv2g0on0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179115; c=relaxed/simple;
	bh=xuykmp5Rtya8w8XouSXZ6DtumaHK80WETFnSUa4Ql6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e68P0gn5pz8lJPHttNlB7LR+96Vw60oymNBxKurVUDD6WTcMWcpyAmeOnMgKuLSxlWe8zazPSEIsvSprHKnpTYThP12Wu3C63KYcEEj5xXiXX7a5NE50QoLB9qOegLXLsWMMAvudiwUym42LBLj9o1GSt8Q9ylPRUnVfH2QxEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJu90qSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xGBV1boYIhkn/7JRFJ9Qkf08AqRy52yUrDB65GzyYAY=;
	b=VJu90qSZIBLNCEd+HK5RlT5kIguJTvOGSTXKE/YZIkXeZ5Rvv5HS9Q3UYtwQJgALHgR6wS
	uJebIeVyruQymBVBLwG9UWN0AJPULTHstfqojc1hvg/4THIeytEq0sGraYEC42D8yn8y5I
	mjcT+mfEQPmuc5WwS+FV6q7Ca0u3DWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-a8JI4TlqNrWr_uQidmqOKw-1; Thu, 21 Nov 2024 03:51:50 -0500
X-MC-Unique: a8JI4TlqNrWr_uQidmqOKw-1
X-Mimecast-MFC-AGG-ID: a8JI4TlqNrWr_uQidmqOKw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38242a78f3eso373955f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179109; x=1732783909;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGBV1boYIhkn/7JRFJ9Qkf08AqRy52yUrDB65GzyYAY=;
        b=jSLNHD3B+IGnMRpAuGdvt01kbD+VQiKzQsibWLeFkhHWRGKMMf38ZMX63sKihWLKdl
         TBRdrNQhpufZL97e4X4ImGq2vkxYe2EYesOmti4ODpbT70gqTUP0nO+RxDEsbvFpMlcm
         zbZMgSxU/FIbObJf9Co0sUuKKaxoxVYHbN8wUmMudyvK186j3Mtpf3fxWqXWbXqyyF7j
         ONNUFV8dYruL+vIMcvMBlKwelEU3iMS12Gdrth2OTcaxZ/sXYNd0glHpAfkKy2uqO2Kt
         k8++GXyUtUByjVNf3buEh8jHKL72rbvAD4gAk4D+VLsCUdNe+Dim5iDmsmvao585X4jW
         OCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4DfaNpBqV00MrXbbewvZHFhujMbJVhkB0xsA2TSPYza6gVo76xR4bs4MdemGObycRzmdUXhe4RGLN8kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eADMOsSjfBdVNZ3iPQFsX5EbKCh1jJRV5gWIVlk9YqDPLjmD
	CWOVwc8NlccXpYbvHcLx4HRfvc3MrwUwBZUEt1oAfgIzA9/znbMLm9NlKHb/oAczhXDN57Sl47I
	OnhBhOwVUuaL8p/YRUJcz7jhvZKbw0jAgcrrh99nmItoDrM5wV3VOKsoUDQm5zw==
X-Gm-Gg: ASbGncsPlRceLWt3OWahGo+2QMtor0SdjTDxYi3VsWGsU+u39a0jnKREx6skXyQkZEO
	CyPl3NOcET4AzENNKku9Rj6S/nQNDMK92Qjcjgi/5Wtrp7PAR+eG0SLjOuNloyBhelZtAz+qCoh
	dsA8VoX4CbeTdItShrNrKQ4ve5xSBbZ+XxtFvKEyz9CXQXqDR2EEtOfooKztuszKcj87RZaQEgJ
	ULZl0i7DOKSl9+JO8/UweYtU9xEymjxhfXo9nVEhl1Hqu8KqihuIg0BiDlZPJtlLanNmMqAV+uH
	FfheZ80M4wHLSzGHqsAuyyaiH9f/3Km2VdQS0K0RvThsJlAHvOZBbaUvL1DRpwJVR8coesW9jn4
	=
X-Received: by 2002:a5d:584a:0:b0:382:4378:4652 with SMTP id ffacd0b85a97d-38254b21a6dmr4742508f8f.45.1732179109528;
        Thu, 21 Nov 2024 00:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETUEWNUJCrStJ1mePOH9N36BBEg9cFPoP6QOw493nFF2tjHeCKP7KUt2gJPwtzy9WtPueGNA==
X-Received: by 2002:a5d:584a:0:b0:382:4378:4652 with SMTP id ffacd0b85a97d-38254b21a6dmr4742491f8f.45.1732179109222;
        Thu, 21 Nov 2024 00:51:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549111d1sm4254299f8f.62.2024.11.21.00.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:51:48 -0800 (PST)
Message-ID: <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
Date: Thu, 21 Nov 2024 09:51:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>
References: <20241120122858.22190-1-laoar.shao@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241120122858.22190-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 13:28, Yafang Shao wrote:
> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
> kernel data for debugging purposes is prohibited. This configuration is
> always enabled on our production servers. However, there are times when we
> need to use the crash utility to modify kernel data to analyze complex
> issues.
> 
> As suggested by Ingo, we can add a boot time knob of soft-enabling it.
> Therefore, a new parameter "strict_devmem=" is added. The reuslt are as
> follows,
> 
> - Before this change
>    crash> wr panic_on_oops 0
>    wr: cannot write to /proc/kcore      <<<< failed
> 
> - After this change
>    - default
>      crash> wr panic_on_oops 0
>      wr: cannot write to /proc/kcore    <<<< failed
> 
>    - strict_devmem=off
>      crash> p panic_on_oops
>      panic_on_oops = $1 = 1
>      crash> wr panic_on_oops 0
>      crash> p panic_on_oops
>      panic_on_oops = $2 = 0            <<<< succeeded
> 
>    - strict_devmem=invalid
>      [    0.230052] Invalid option string for strict_devmem: 'invalid'
>      crash> wr panic_on_oops 0
>      wr: cannot write to /proc/kcore  <<<< failed
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
>   drivers/char/mem.c                            | 21 +++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1518343bbe22..7fe0f66d0dfb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6563,6 +6563,22 @@
>   			them frequently to increase the rate of SLB faults
>   			on kernel addresses.
>   
> +	strict_devmem=
> +			[KNL] Under CONFIG_STRICT_DEVMEM, whether strict devmem
> +			is enabled for this boot. Strict devmem checking is used
> +			to protect the userspace (root) access to all of memory,
> +			including kernel and userspace memory. Accidental access
> +			to this is obviously disastrous, but specific access can
> +			be used by people debugging the kernel. Note that with
> +			PAT support enabled, even in this case there are
> +			restrictions on /dev/mem use due to the cache aliasing
> +			requirements.
> +		on	If IO_STRICT_DEVMEM=n, the /dev/mem file only allows
> +			userspace access to PCI space and the BIOS code and data
> +			regions. This is sufficient for dosemu and X and all
> +			common users of /dev/mem. (default)
> +		off	Disable strict devmem checks.
> +
>   	sunrpc.min_resvport=
>   	sunrpc.max_resvport=
>   			[NFS,SUNRPC]

This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I don't 
enjoy seeing devmem handling+config getting more complicated.

-- 
Cheers,

David / dhildenb


