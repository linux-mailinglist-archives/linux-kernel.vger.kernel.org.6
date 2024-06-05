Return-Path: <linux-kernel+bounces-202152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F025C8FC864
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8561F2173E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987318FDDF;
	Wed,  5 Jun 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9Han7df"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92C163
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581378; cv=none; b=u2WW6TICt8FSGwTrJiWQFujUK4oaulo2+bWkKs3E6QxFswVXd861HEaNjj5EvdAJD2KeRe/HuTXLAWoEcqsDmedVoD5qISTp37y/ZyclnKcmW1qrWM7oxUc0d8mwICYXT1dYDFGdFuPqz4j9TIWtu3gArmKy4dIoaobxJRfvXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581378; c=relaxed/simple;
	bh=76e45Yd5YFBXQa5L5RFOsZ2Ag3o7wXNRL2BqGQwf3P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MCm2V8BRlHKi6SAhmDs8Rw0/2PuzwvZEJhJd+yNfKAoX1jIJo1BBMPApw4DqdObOF2K4lc53aZXRF7wyywjVdM4b6bRpi4u3X6rMuBwbdaxMMDAJuFYHy7OGLInQi4xcLMWz2+xQHxyLdXmSRoIa27CFKp43+3oPh22jz/7RLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9Han7df; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717581376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z2viHxXHDkCe8VRc8oJvrZ9ic8gNbbXWh6mn1w4MCjY=;
	b=P9Han7dfnZdBJ9PQaTW6ePW4cynaPyEaFq/V9ujAiqFn6lw3xruXxtLN5I1aLNr/SiU8iG
	c3OcajVHDsKNnb+SDv070mqFdHS24Il0nct/gqbppDQptodfrM1CnCm7b/tETbd/VmVtiX
	b+/e1bkDiddPYRe3gtJErq9vhsZlnYc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-zdjpFcvdPRq3q1tXFZa5yg-1; Wed, 05 Jun 2024 05:56:13 -0400
X-MC-Unique: zdjpFcvdPRq3q1tXFZa5yg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42159c0fbb0so562295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581372; x=1718186172;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2viHxXHDkCe8VRc8oJvrZ9ic8gNbbXWh6mn1w4MCjY=;
        b=YBfLu0wP5cvYaZJ8owGSiJtjtStEiN6a7aE0GaASQgMu71UXC21mH6J6GZ/tE25C4a
         U085cxvXBpm8VtkTI9QPAcyY+GuENxjfAEt3yXGzUQUyIKj8Kd1EFAHtvMJNdiOBwUOr
         3ZgPpLwfgh+4In/v8dBLuG7cnJmvFNQaPvGHXWHc1Lm0xb1lraKRz4lFhMsWJbmqfX5Y
         Zpj6SFfD5we0MA7CCZlnGpL1VQUA2JTANZg8ysYyqfz5ikTgBpbant6fn8XdkLyf4OY9
         kitRV+Vm0yPTGkkii10u/oMAw2EaVPBsFQ/rOPAOKnLFJ+ZFZ5rGeVsbIu54toRDtTCC
         yVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg4lzBrbRqJs22HKKeOXpyj5ce8LlQRWXwSOluaouAieoKEgAGYymm/59nCA0yNJnkOHWdbWNDzT0jT9mfBgNZCNQwHwfgQDzfg6If
X-Gm-Message-State: AOJu0YyOhTQPKJGT9RXGDNzom0IYMiLQBUJ3MA2/AFGXkcXWfgCaCy0g
	wVnqlO3KtDSOx7KpYk88gsmwL0uZFcTOyF1qYKgihGMKoqVsMovttipG4uCwAdKYOWXhXQ55pg9
	xlg/1srJIseBCGDjRiozm67d4ia3XB8uiTDjPn8Ur5isUfdU7rDSztaZLcw+bwg==
X-Received: by 2002:a05:600c:3b06:b0:421:4be2:cf0b with SMTP id 5b1f17b1804b1-42156337310mr19040435e9.15.1717581372524;
        Wed, 05 Jun 2024 02:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIhRmfrhV0qUxNzeUQPNzZe/v0qvBGS3g6tjGiUpJMv0D8t5/83iLNcpBxFmLqNmmSs+LTkQ==
X-Received: by 2002:a05:600c:3b06:b0:421:4be2:cf0b with SMTP id 5b1f17b1804b1-42156337310mr19040255e9.15.1717581372085;
        Wed, 05 Jun 2024 02:56:12 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23a9a.dip0.t-ipconnect.de. [79.242.58.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e56669a23sm9401101f8f.83.2024.06.05.02.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 02:56:11 -0700 (PDT)
Message-ID: <353d4f6c-ed3d-4afe-82ab-8c0b22a0178f@redhat.com>
Date: Wed, 5 Jun 2024 11:56:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] mm/ksm: add anonymous check in find_mergeable_vma
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 izik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 chrisw@sous-sol.org, hughd@google.com
References: <20240605095304.66389-1-alexs@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240605095304.66389-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 11:53, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> We do vma_set_anonyous in do_mmap(), and then vma_is_anonymous()
> checking workable, use it as a extra check since ksm only care anonymous
> pages.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> ---
>   mm/ksm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index f5138f43f0d2..088bce39cd33 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -742,7 +742,8 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>   	if (ksm_test_exit(mm))
>   		return NULL;
>   	vma = vma_lookup(mm, addr);
> -	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
> +	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma ||
> +			!vma_is_anonymous(vma))

Doesn't KSM also apply to COW'ed pages in !anon mappings? At least 
that's what I recall.

-- 
Cheers,

David / dhildenb


