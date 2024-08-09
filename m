Return-Path: <linux-kernel+bounces-281219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDADE94D475
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32C11C20EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397D1990C4;
	Fri,  9 Aug 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dquab2Fx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C52F26
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220414; cv=none; b=N9JWbltWe1APrAzc1jfvZfH4e/w1+wm0e/c3w7EH2l0B/MsamgXtELneshdSlLk1gRH8I+ad0UoLAMPzMyA6PcZk4dy4tlH2s2M/r0pxag+X8XzQC+8ERw314zbMfdjr3sjPNQWImCyEUsADYPTR+uHXzqDfmaVzr4jN/g7flOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220414; c=relaxed/simple;
	bh=Yc/lu1hQq+6Q9dS52dkHNBiA42cV0GK0dZQdz+si7Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8X/r3kmuUyOI8cP2Q/gAD2f15q7uuoqXSTE4Wdvbb4fZ7AlVEaCUXWg1b8sAkkq1e49fKt+x8dUTNX3SVqRT5pTegUWpoUhd5axC12BNCCZHYaYG06T/nMMeaSBbYW2HRVN3y7wTKu/B3SO+0b+QyMO7KsCYsosx1si0pZVBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dquab2Fx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723220411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zm5EAdsOXCZvMyPDQvIBSQFNRt+tuy0GlLgmv3TFe5I=;
	b=dquab2FxtGtEQoUMEWIvVzOKQUO/OPwpjEJ+WQ9oW3cH6kvhOct6OC1+FEW9fFhm2x2Wwo
	FNLJlsz6Yk59kd63MWJACX8R8wrLQMTNQqIa10NTP6KJwGYAj9WgHyvsQZdPrIZxeD2zFb
	D+TMMqM6jrOH3twtLbT/3p3lHziOqKc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-epLt2QPrO0y_1FkIUhFAQQ-1; Fri, 09 Aug 2024 12:20:10 -0400
X-MC-Unique: epLt2QPrO0y_1FkIUhFAQQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3687f5a2480so1159837f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220409; x=1723825209;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zm5EAdsOXCZvMyPDQvIBSQFNRt+tuy0GlLgmv3TFe5I=;
        b=T57n9b9Bztm4yjACpYIya2k7eTuBbMwcbgtHX8pBcmPb223ctnUlHzz2g4vET2Bg1v
         Xv7CrdJMLdKRyytmUeL5HrxmKuRYuiDJBaKZltOg/TeCipYQUS3UyRBxEGWMuWPXj9DK
         5AsinQpaQqW96b4zAS732oZPQEd3Kt3Tfh19MWVa3I16WMgyd7jIpH0Qntv2WTFgz76t
         MLD5nD8+O31b04MVLU5Og38evp/n3UjKOX1KuR7WqB5es1xXDg+uGocduP5qLURFsz18
         ti+6bkZ+KpTUorCprhUPqBET/w90jFFA99ruIOaNKyLV91wCzsKXZdOzB3V0LIoYHpZ/
         9DRw==
X-Forwarded-Encrypted: i=1; AJvYcCWEbsr+MP7Pin2lVsU2Va/x3ACXs4/f7BK9oSSw+12HGoNOKdzk+U4LXEFQR1y9m87Fic1RuwWCLsxdb4b4l50NwqYo4obAbFvNxWDS
X-Gm-Message-State: AOJu0YwmHc/FC9oocEZiCpCtpPNxQiJPcBxS2MLJRYe3CL90TkO4jE+7
	rrA6dQenJxw/x3SGgp3t2VyQr9xy19+3wNwnNmivCBBwxLXMtyLVSCY+2ROKN26T/8cRG2BAi0C
	Urp3AN/KUCcfY2aN5texcE50BmVofNfF6zjf5ToCnZ1VeIr5c4lE03OZbhPQJ0Q==
X-Received: by 2002:a5d:694c:0:b0:367:94a7:12cb with SMTP id ffacd0b85a97d-36d5fe77778mr1563521f8f.43.1723220409025;
        Fri, 09 Aug 2024 09:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG199tNHrasXyWylAho8FwcYUzg97ydDg4FbqU1Td01GP7GqR4CztpyDD4hV0dMDBM1OiMjuA==
X-Received: by 2002:a5d:694c:0:b0:367:94a7:12cb with SMTP id ffacd0b85a97d-36d5fe77778mr1563481f8f.43.1723220408476;
        Fri, 09 Aug 2024 09:20:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27209a69sm5763536f8f.79.2024.08.09.09.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:20:08 -0700 (PDT)
Message-ID: <b103edb7-c41b-4a5b-9d9f-9690c5b25eb7@redhat.com>
Date: Fri, 9 Aug 2024 18:20:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] mm/pagewalk: Check pfnmap early for
 folio_walk_start()
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Oscar Salvador <osalvador@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-7-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240809160909.1023470-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 18:08, Peter Xu wrote:
> Pfnmaps can always be identified with special bits in the ptes/pmds/puds.
> However that's unnecessary if the vma is stable, and when it's mapped under
> VM_PFNMAP | VM_IO.
> 
> Instead of adding similar checks in all the levels for huge pfnmaps, let
> folio_walk_start() fail even earlier for these mappings.  It's also
> something gup-slow already does, so make them match.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/pagewalk.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index cd79fb3b89e5..fd3965efe773 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -727,6 +727,11 @@ struct folio *folio_walk_start(struct folio_walk *fw,
>   	p4d_t *p4dp;
>   
>   	mmap_assert_locked(vma->vm_mm);
> +
> +	/* It has no folio backing the mappings at all.. */
> +	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
> +		return NULL;
> +

That is in general not what we want, and we still have some places that 
wrongly hard-code that behavior.

In a MAP_PRIVATE mapping you might have anon pages that we can happily walk.

vm_normal_page() / vm_normal_page_pmd() [and as commented as a TODO, 
vm_normal_page_pud()] should be able to identify PFN maps and reject 
them, no?

-- 
Cheers,

David / dhildenb


