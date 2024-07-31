Return-Path: <linux-kernel+bounces-269146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC78942E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BB92882C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66541B143B;
	Wed, 31 Jul 2024 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+jhbPlx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF01AE877
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428560; cv=none; b=uwhY++nXlpWZs4N2DWDdINUGi84MI03yUXtwjSKoMICoE8Zo6n4K6JOs/KCh+2W+GWcqSEQuFt3yqntVYIhuc9eosyurFO0xvDWm/3WS9MCY27h5HRcYPfYfiJWs6pGKuTCeYaIxambotixqAXyhpHGhYsaLdWPif03YEQu5Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428560; c=relaxed/simple;
	bh=EnfHCYFIHMmHWtZSgMmDdw/34IF1JehxkN2M3mSSt3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzNEzBnGKleNsrsoPobKQxYbl4G9hjwYUMo7MVMUbGJPns9hsdv/Rb8WVAGZSxgWiK4el8T0269dSRK/1lAxgWgCNB4buG33bVvK/7BIW1DnVdA/SOyWrGGkpjl3820CL4zYzDEmo7Ira3XLutWSfxbvo//eWK2MgaoOt4+gwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+jhbPlx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722428558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u8D0BMiT6IoVXQx1H4dU2A0Q04EQIo67aTwTXMI8Aso=;
	b=i+jhbPlx7B4M6yUC8ejdemUeOwF3TLHbIL6akp1akhhlWImfXIly+QBIoBp9U+KZDSoaNg
	TTOCpj5et31uq9yJnFzwHyr3rbM9+M5ffQXAGttoM4TZQmelmx5EcQADqVB4TtgNqC9gxJ
	VL1i9HsR82rsGcruux+pm2OrFPSbqLU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-fFe8ZsjxO2WK48wEliQURg-1; Wed, 31 Jul 2024 08:22:36 -0400
X-MC-Unique: fFe8ZsjxO2WK48wEliQURg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so38239745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722428555; x=1723033355;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8D0BMiT6IoVXQx1H4dU2A0Q04EQIo67aTwTXMI8Aso=;
        b=UUrnFiewmBcoFk5hzayjwMpxUeoGdBsgW89Kb7ajOYQSK/bRLKubgi9lcu9pTjmzb4
         qkgGorSwnDKIQLHKffAhui7iWrus8jrZpX5vNRY1IlEa0WEVVcl4RtnRazkrbLwBNa3Y
         uXnCj+cAkTN+wmmQOOVbbujHzS51czOcincSt6dyR2Z8NIvouVP2dDjswvTdgr3GSHdz
         PS/D1i572+atFFMX2/NDSGlyuYUqP8Lc7YOreN9kD0ybDRatf7GyZqAJirSg1YAAo12R
         RXltc/U6EFKnEeWgO8c+OoYifBrMnw7HJV8EjvYXkgLo8HVSiDeEIt9mvDim+Zt2De9K
         SANQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWl3BaMs2seL4wJYlLMxeQgM3Jl+Rikdm3lL9wlu5cyt06LrFkGbhISy8VYLl7D4H9ivVoTAa6UZ2s+wCXQLmHHre8wY8uALZSZg0W
X-Gm-Message-State: AOJu0YzAj0tq+9NnZHFqaRgPbzAUzpPIA88GtbjMTyQ/l5nrYtyaEcNS
	kdlhshHx4tZwaGqNDI3hGJwN9dbWyvCJtk/Xvy/vQPn/XHQ5fgwUXisIMjn+izXVlyzIHdeC1g0
	+H8k1E/womJ2oBvLYLyiDyRib5TOUthdIlHkdpNMMwVtRZM1NvFUWdqAFaJ2Syg==
X-Received: by 2002:a5d:4708:0:b0:367:340e:d6e6 with SMTP id ffacd0b85a97d-36b5d0acf1emr9501349f8f.41.1722428555470;
        Wed, 31 Jul 2024 05:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW+UTLIN0RxJ1X5ueyznLa5GLDh3jxBCM48XxXY8PyrBp6tsVe90U3Ukmdxw7GxNL3q6QZ2A==
X-Received: by 2002:a5d:4708:0:b0:367:340e:d6e6 with SMTP id ffacd0b85a97d-36b5d0acf1emr9501327f8f.41.1722428555011;
        Wed, 31 Jul 2024 05:22:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:5f00:9b61:28a2:eea1:fa49? (p200300cbc70b5f009b6128a2eea1fa49.dip0.t-ipconnect.de. [2003:cb:c70b:5f00:9b61:28a2:eea1:fa49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3686227csm16968300f8f.99.2024.07.31.05.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 05:22:34 -0700 (PDT)
Message-ID: <644488b6-e838-48bb-98df-d979e01a51d6@redhat.com>
Date: Wed, 31 Jul 2024 14:22:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] mm/x86: Make pud_leaf() only cares about PSE bit
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Matthew Wilcox <willy@infradead.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Oscar Salvador <osalvador@suse.de>, Mel Gorman
 <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huang Ying <ying.huang@intel.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Hugh Dickins <hughd@google.com>, x86@kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ingo Molnar <mingo@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-6-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240715192142.3241557-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.24 21:21, Peter Xu wrote:
> An entry should be reported as PUD leaf even if it's PROT_NONE, in which
> case PRESENT bit isn't there. I hit bad pud without this when testing dax
> 1G on zapping a PROT_NONE PUD.
> 

Subject s/cares/care/

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   arch/x86/include/asm/pgtable.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 65b8e5bb902c..25fc6d809572 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1073,8 +1073,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>   #define pud_leaf pud_leaf
>   static inline bool pud_leaf(pud_t pud)
>   {
> -	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
> -		(_PAGE_PSE | _PAGE_PRESENT);
> +	return pud_val(pud) & _PAGE_PSE;
>   }
>   
>   static inline int pud_bad(pud_t pud)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


