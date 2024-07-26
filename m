Return-Path: <linux-kernel+bounces-263561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288793D7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841DD1C21FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9D17D34F;
	Fri, 26 Jul 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiUp+ikJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F7282EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015316; cv=none; b=nBddrd+lvGZ9nCcIJOKXW9pPzzJumLFbQGBtrwnukjHEBVYcK0KW5VDSjDiX8qXsrU/VtkKfoys7JkerPnpmLFKzNm6pT51QwzJOsxtwdAHsqE1LRpv3WXzPbRqu1x4miyfVZKFMRPskjcIbAsiva30+ou1N7mHjcttYkv979V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015316; c=relaxed/simple;
	bh=bttdLIdoUtHr27DSHLNsOSnkrwZ/ML4vJ9j1Eg1TUoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InOiUkIIY4LfUl8oW85UlfWMqg8AlVsAp5E3aOYCrAT2+u0BSqszniShV30IYaDcxddr/GkZ/Jp1Zvxcgsw3nf9phqXmIuS49yIi7WHAy1YHsYva3HIogFOHbS40pNOEarNMSyP3nWX763jmNdzHE1a4L1V0nMTrHyl+fNeojJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiUp+ikJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722015313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8H9g215Jo9hIiTGrOT9Nw9jtPUYdggj31n76DH0L0Fk=;
	b=XiUp+ikJ+WgbIAqD9Jogw8Qrb5g3ewf584DludvGgPz3x72iB5FOLScQW199uBh5D8+9Xm
	zpuQygKdS7NdMHLqKdvCAFH8G8n87R38R5KaFpY+wB1lzj8W5o/OVzkvaBoZzZATny5OVW
	FIwZK/Rkhxan/TVCLWQDYSCsVN7fe0k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-z2GLdeOiNqW1Wv9cq17meg-1; Fri, 26 Jul 2024 13:35:12 -0400
X-MC-Unique: z2GLdeOiNqW1Wv9cq17meg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36835f6ebdcso1695285f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015311; x=1722620111;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H9g215Jo9hIiTGrOT9Nw9jtPUYdggj31n76DH0L0Fk=;
        b=dNZ6MMNGVKVPwsqe1ylrTAYfhwqUNRFB+ws7T4sXbtJB7jcZJtnFp7hE2vG+qbmsYV
         Nx0HqUxbQXzdD4uXK8Myx7acRDd5FujP2V0crY3EdvdC6mSNmiy2wwhF/zbfX91R58Q8
         x0l0dqc1qjjA/T6Um+GYh17pdNzTl675ZymYzzkZ1vDV6RaDQajWo+ee1n1pAyn89eay
         ZJ6ylJzBRUVhQrngLU4TYQvXBn09LktFX1r1PcEHS1jJonBGgj8pAo1SAQPb6RTwWzie
         PYHXeRfKmrobFr/OlO4fI6Aw+h2QQI/5/E6p6CmmQSV+4miT1iIywnJKWqESxqRpmadA
         nZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCVEv4u9ojShITwpLWBQcXhG9ju3m3f9WMPjmTNjmcKOLfHSdWbV9mA/3SHIm7C9dFye1SZx7sdzaGc7wX6hNbIsVJRzkK3KPmvRn/u2
X-Gm-Message-State: AOJu0YwRkzXSSx9DFZeB2W0dvT3PN1gmnNOqjsmcIVmnUQyFI66RE6QP
	GjAW/8E+tlJyathPWDLtL89tiYWvjaqOHV9faPCWMNkSDL3whAGPnkAM0eHNIVQM3nh2hyqMwdt
	nX3Ypy3oZ8Ci8NQBEhgczVP20crUSzbdqu2F2KX3ZwlfZb5A1R3N/beWEbUr0gg==
X-Received: by 2002:a5d:5501:0:b0:368:3895:67d6 with SMTP id ffacd0b85a97d-36b5cee1f55mr273282f8f.20.1722015311309;
        Fri, 26 Jul 2024 10:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmcLLXt+73ZRzaeVRyIDnhJ9PNOOv9hc4PVzigrj5pU0Oe75sBZvCZ28se3TjEY2QW5EBXiw==
X-Received: by 2002:a5d:5501:0:b0:368:3895:67d6 with SMTP id ffacd0b85a97d-36b5cee1f55mr273267f8f.20.1722015311011;
        Fri, 26 Jul 2024 10:35:11 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-427f940e62dsm130746555e9.39.2024.07.26.10.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:35:10 -0700 (PDT)
Message-ID: <5d4eafaf-5243-4831-abf1-59665c08fb46@redhat.com>
Date: Fri, 26 Jul 2024 19:35:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: Documentation: Fix title underline too short
 warning
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: corbet@lwn.net, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 chang.yu.56@protonmail.com
References: <ZqB3lofbzMQh5Q-5@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZqB3lofbzMQh5Q-5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 05:40, Chang Yu wrote:
> Fix "WARNING: Title underline too short" by extending title line to the
> proper length.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v2:
>   - Fix the format of the subject and the commit message.
> 
> 
>   Documentation/virt/kvm/api.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index fe722c5dada9..a510ce749c3c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6368,7 +6368,7 @@ a single guest_memfd file, but the bound ranges must not overlap).
>   See KVM_SET_USER_MEMORY_REGION2 for additional details.
>   
>   4.143 KVM_PRE_FAULT_MEMORY
> -------------------------
> +---------------------------
>   
>   :Capability: KVM_CAP_PRE_FAULT_MEMORY
>   :Architectures: none

Applied, thanks.

Paolo


