Return-Path: <linux-kernel+bounces-336076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45097EED4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DFD2818B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5A19E964;
	Mon, 23 Sep 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkDX8MuN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C027715
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107460; cv=none; b=g2qiVsXmFriKCqyhUz+vYEKk+wz3dNauFX9QDKt5WOG24kdfWItOH9Qp2SBWQb/HC8sQFpxLL87ncoki4CTNA8GGYaYFSs6Bv7cU0jWzOWr7tprIhSf24MUPEDo104dcBkhj6tNkPFqMQzEPKFPeYQNFlKJNV79oh2xYcBD9w4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107460; c=relaxed/simple;
	bh=BebgXKFLybrcvBjobhkzkwZmkOYGOroeZdWyDY3C0us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0mC22lkRTRrNlMKqzJ54WhWxZDxWpslbjprAIcpYNtE2tTgebTl+3pQM35ngViDsXRXe8idc7+bvSb+jzIusnB17SJxIdDllo33TOpqiHANnnhE8IbK7x2yZwWY//NJFZk+fNeVNafwVj5r21tETU6tSvuEUVXlB/69yC2AakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkDX8MuN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727107456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M4Yv6ssujOOYf7wZkaHpR6zpWkIfFno+eaNga0YzR4w=;
	b=SkDX8MuN3Wo/uHhr2R9DkDp57gHzuMxBQzIiQra8eQR0nY4+BKbGhkmzOP3WlXc+XWF39M
	bteKs0UX3hcKlohI/VFWr5KG/ompkGHw+Ej5KFqSvoP9YzdLSngQ2fyWn74eaulOBydtr/
	jOyTjD4BfaaQdt3C9AZlSjl24LgKcxE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-1RXIAX6mOuiZZPqL-2mWdw-1; Mon, 23 Sep 2024 12:04:14 -0400
X-MC-Unique: 1RXIAX6mOuiZZPqL-2mWdw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8d26b5857cso362831166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107453; x=1727712253;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4Yv6ssujOOYf7wZkaHpR6zpWkIfFno+eaNga0YzR4w=;
        b=rKtLVgeP7AEaNnkHYk+aD7z8o8HuHBzPFEY05SXIKPe5blMfHsA6WmzrTUEJTdS+Y3
         Pp090t+SyaFq8hPAwN7ZP56yNPRVO2UHx9ZTh5G1g1mFA1OHnB8upmdGZlhQzKT5CQM1
         fUvnRLfpgZvxgmlG3ZK21/gxu8J9NjflKra76x8PxrlATSe5jevZKsOPlRHLnN71g/mu
         6ERZnxMKgL4y4oDpM4I5Dc7+kpQJKb4EA4/3AoGnBBZi9Y4isXSgEnbLAt6t+hZt2smK
         ijnzF5A/oGr2IElf6ku0HM/XbdN7oEBgu/2Xp/F3pbPA+CRXNNJkqgvzhcRxdlE4KGxJ
         xyLg==
X-Forwarded-Encrypted: i=1; AJvYcCXaKnnjdUTom9H+1w3ZPISRUwAQepGDTcGgEf1AOBlyGevAJHqwb9F0viFstHsbf+R4vl5KfeL+R5EvJp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsQW2r4oltCcRPDa/MrRGoG6v3ssE2KiVJ6z65jf7NlMfBGoh
	GBnViy1BnqhAt4Djds1c57MfTGDTf1PUb66xaHuISSyTpZNU0Yd2t8tNdbQ1X9X4Rj1zHximbpY
	sEyetlRlehIyR8AGb5RzQ+jn3BvYOvVUW6DiiLne8GyVUPPJQVOfkqAy/qsZLUfDe1kgiy5WW
X-Received: by 2002:a17:907:e68d:b0:a8c:78a5:8fb7 with SMTP id a640c23a62f3a-a90d5813428mr1290279566b.45.1727107452737;
        Mon, 23 Sep 2024 09:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKP0F2a6CsyH+bf/FAODUc2vt2b5i0g+PaG7caVyp0Jgd/YNIDFGPVuYOExyWuD/RZ4ipxLw==
X-Received: by 2002:a17:907:e68d:b0:a8c:78a5:8fb7 with SMTP id a640c23a62f3a-a90d5813428mr1290276266b.45.1727107452302;
        Mon, 23 Sep 2024 09:04:12 -0700 (PDT)
Received: from [10.5.48.152] (90-181-218-29.rco.o2.cz. [90.181.218.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3901sm1259814566b.99.2024.09.23.09.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:04:11 -0700 (PDT)
Message-ID: <9985c614-5bd5-4969-a4c2-87015df27b18@redhat.com>
Date: Mon, 23 Sep 2024 18:04:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923053836.3270393-1-usama.anjum@collabora.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240923053836.3270393-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.24 07:38, Muhammad Usama Anjum wrote:
> grep -rnIF "#define __NR_userfaultfd"
> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
> __NR_userfaultfd 374
> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
> __NR_userfaultfd 323
> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
> __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> 
> The number is dependent on the architecture. The above data shows that:
> x86	374
> x86_64	323
> 
> The value of __NR_userfaultfd was changed to 282 when
> asm-generic/unistd.h was included. It makes the test to fail every time
> as the correct number of this syscall on x86_64 is 323. Fix the header
> to asm/unistd.h.
> 
> Fixes: a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


