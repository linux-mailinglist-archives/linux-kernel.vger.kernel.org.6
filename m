Return-Path: <linux-kernel+bounces-234889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAA991CC13
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CFC283371
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FE3FE55;
	Sat, 29 Jun 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zy4Eb31d"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FC2BAE2
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719656430; cv=none; b=TzUiKRIGOT3HC4Rv+TGueL+NkYZnB5Z9F7EMge8+i+fMhG7DnLWoeGF3hXq7oRRvj9Nt/3vLB6h9MXO13gEonxT+6xYtAh2SzwIXjCq54Lht1jcPf3liUEBLTBbNAlrNWOZzuEjS5ushCYNzar2kY9WB8cI02RIcSzd9bTDrV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719656430; c=relaxed/simple;
	bh=/h+/KiD+8YcmKDbvUnLysSmi8xU0L8Gy+fezN8KWdh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwD5ZuVjXiuc3+A8w9+GgpjBpzIsBK4FzlZwN59GwwI96vq1awcpYzehULLrRHsaGseo/ktyRTX0W+QjFm7tgw/bS+tjyaqGYc5qySMaOnKjf4CabSeE/dLljkJVChViPwvJC75tqI4Zi12/yjx4geo6cQuCVVsqua3La2HnFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zy4Eb31d; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36733f09305so767509f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719656425; x=1720261225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHfc2Ok8Ex6+h+gzfv5bxVHv1mLg7+fEtcCdnzYL8h4=;
        b=Zy4Eb31dkSMFzyGMmGx347jowlXlbj5t69GaOXqsNkOG8duVD6WykKzeaZoDHbUj+4
         MMBmVn0p+zpexOpjO4u8gruy5VbUyUvmSk0KuWSS/fNMaFdhmcvuL3070c1FvwOQRC6R
         6kM1qsHFlKCAwy0wp9Y1KTz8PSszMTk8qVbowHWupPJe511aDTWN4hKcSHTD2PEDvF5e
         8suD8XEpgrsPc5+0UP+f9t9OgBWntK+9JPrMUskX7Qn/VCKRlt0/SZTiWOiI8iWoFUSQ
         FxU7URYU7TAZ5SMpTGeGF4RPWZW4GipdjUsF/E5qG7HqYaSTgiH/u26AstzcvGNUtB3B
         swdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719656425; x=1720261225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHfc2Ok8Ex6+h+gzfv5bxVHv1mLg7+fEtcCdnzYL8h4=;
        b=IL6Re+1gp53IELgXY/lEU0xv/0mHRdvyIzyupZZhoXeZkfiDT4fcmTk2I2QlZ5v5tE
         lDVJcpRtgQTtIQ12Y5sFU77WTtVb70RpOBmZ3qK5Q1H5BtbZzxHCRHbhw6aLFY1dIWU5
         tolVSUFfxGsvZ5a9BRuDcJK9M8k1O0He/QAPP1f+/aYEUn5685Nq4IamLuLzti3PUbZE
         HFIdXn9Cq2FhltaUIlOSlf9wkoSBr6dmprC5bXQAHKK//lMA13Q7q2n5N4ZbWpq6O4u+
         I5AmI667i+IH3brSPELjSLyehEI8cJX5FdIxnZfNJYakbqMLR/ZRLVN5oEseTyXbIk+y
         iZEA==
X-Forwarded-Encrypted: i=1; AJvYcCW7SF0Emcql1q35YEcJakhrjEX2n0IeHVen5mt1RlCI8DtrIa6xvckV66asMozu1FRttWltuMdZebr/uFMhFIUbocTZj8/2fCvdrDuJ
X-Gm-Message-State: AOJu0Yz5U6xRZ/yb9kpqvgtxG6cvKIrrqRlFE6Oji+IJldl5OPgClE25
	nVhFlgwT1TqpcgsQBEJl+w0B+ew8V46nKmFChprgYOJ723juyfB6ofcD+dzZuco=
X-Google-Smtp-Source: AGHT+IHf8b56QVpki6o1vkILYZt5x1CAglvQFemSTn8n4t2wrS7SaYvjI6qxpUZwzm4Bwxfh47BlPw==
X-Received: by 2002:a5d:64e8:0:b0:362:9313:e535 with SMTP id ffacd0b85a97d-3677571b64bmr500999f8f.48.1719656425365;
        Sat, 29 Jun 2024 03:20:25 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd707sm4554373f8f.1.2024.06.29.03.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 03:20:25 -0700 (PDT)
Message-ID: <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
Date: Sat, 29 Jun 2024 12:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
To: Ashish Kalra <Ashish.Kalra@amd.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de
Cc: x86@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
 rick.p.edgecombe@intel.com, mhklinux@outlook.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
 linux-coco@lists.linux.dev, jroedel@suse.de
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240628205229.193800-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.06.24 22:52, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> lookup_address_in_pgd_attr() at pte level it is simply returning
> pte_offset_kernel() and there does not seem to be a check for
> returning NULL if pte_none().
> 
> Fix lookup_address_in_pgd_attr() to add check for pte_none()
> after pte_offset_kernel() and return NULL if it is true.

Please have a look at the comment above lookup_address(). You should not
break the documented behavior without verifying that no caller is relying
on the current behavior. If this is fine, please update the comment.


Juergen

> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/mm/pat/set_memory.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 443a97e515c0..be8b5bf3bc3f 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -672,6 +672,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>   	p4d_t *p4d;
>   	pud_t *pud;
>   	pmd_t *pmd;
> +	pte_t *pte;
>   
>   	*level = PG_LEVEL_256T;
>   	*nx = false;
> @@ -717,7 +718,11 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>   	*nx |= pmd_flags(*pmd) & _PAGE_NX;
>   	*rw &= pmd_flags(*pmd) & _PAGE_RW;
>   
> -	return pte_offset_kernel(pmd, address);
> +	pte = pte_offset_kernel(pmd, address);
> +	if (pte_none(*pte))
> +		return NULL;
> +
> +	return pte;
>   }
>   
>   /*


