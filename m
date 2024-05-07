Return-Path: <linux-kernel+bounces-171205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2B8BE115
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF745283700
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603E152534;
	Tue,  7 May 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEc7kltF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47C522E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081934; cv=none; b=imO0xfianQg0bA3enQL9CTb5ykBKc0wOn0fKks6KSxEazxkTFpc9Z3XTHz9ypoxBoyr9an8zTby+Rpzj6XyVcEoekH7UNVx2xLyv7EQcrIoeYdQJZ6RUT6CJJCf6bbg0Bycyvg9d4n0VepGRQIFRwzBMbiL+muvjjO5mjWgjDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081934; c=relaxed/simple;
	bh=td2oQgwwjmrILmAuHSGqy6pdwz/J82jjZsz0KVhdl0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7taRlnsR4PR66WVeEDL/cInIgNtRizyR7KPEdOnamoJ7avN4LkXvigG/xMnQnWxqQwNIjRVF9nGXAwEsYUJmK6/aDA4OYh/KueBfhH5EOW8gWhb2Bz/6/1L3XOb2NsH0Tt/cKsP+pwUWuK0x61hrUQosRs8HfvFvxKCRAeDXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEc7kltF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715081931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xka3buRHtm0QPVXUk36t3UR0bYtNteYd8XPxEHml5dM=;
	b=PEc7kltFbzdF2vKlzgQgAZ2EPNMpwr7+7mKIOPaWu7Ev2NuIOmT2xNdfdPBKJC5drxb6i2
	d2jcDe7lgaPfK4G54tZT5vk8AJi22mGLFO+4hmS1Uueq/3bLEVFiLdbp+vBae6dCN9KJnr
	h+u9riy0m68kVGuhLCoEMQxgvH4wIFc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-S_Qy_fzkMkqECrpfAn8ayw-1; Tue, 07 May 2024 07:38:48 -0400
X-MC-Unique: S_Qy_fzkMkqECrpfAn8ayw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41a38f6e371so12910805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715081927; x=1715686727;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xka3buRHtm0QPVXUk36t3UR0bYtNteYd8XPxEHml5dM=;
        b=naOF/mhcdAGe29Yb5A9jLG0E8ZESkY9LQ86RGFLVduyH1LNskKVJZm7Xk+X+Oz4J+A
         j+bTGVvNP2BPildUHBBj/d7yOq0uKSXH6rsPBbRANrEuK/Mku/yjp2pwLAKkn3o1tNvt
         LGfMxolb7ewAixGxfzNwMTYKQxFUWNg3gID6bG93e+rU2T9OaiE4j9nRgalWKfSRBAK8
         H65Gc9AyScJXNeeHurvR3E2+KGo32UhxZSm0+kULFZAl9yDfd8QXyKZ/tbFvpsjvLhf3
         zLjKr9CPN3UAEwCYbqWTiy+JSl4iyPZHX2lui5jDK2W2wjrUT9E7yU5pAM6ooARnnXwn
         WQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHrIHQE8djba24fgXkFbTKoFKwUHoh3So/fjnMW6juyBIRWLTntpLIYCb90d3231YjkYMTsZQDsT6aY2gT3CXKf+9ZyrDJ+aWNwojL
X-Gm-Message-State: AOJu0YylL6t1RL5m2963YDE7W5srFiyNulZj5m4ljFbGM1s6Cw9Rmfb4
	5Sw+w9ELr6v3NlYGguTOxYCVCY1PnPvbvKwPC86Z3yPszK40BtCp3hXceifmI0tF+Jp+ZYfwPxk
	LD843wNP7bbyr0LS3EF2HnQo2MKITtcCQwFxl2TsuzuOrVTIpDmb7gE4OhUcvGA==
X-Received: by 2002:a05:600c:3d92:b0:417:d4f5:6501 with SMTP id bi18-20020a05600c3d9200b00417d4f56501mr8815783wmb.27.1715081927034;
        Tue, 07 May 2024 04:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCYBgCN718QLX35mkKWcVx+Qd8Sed2xUapYoO2gwXpxxfocrMLtjdRHD/ege6eXvxkBZrNEQ==
X-Received: by 2002:a05:600c:3d92:b0:417:d4f5:6501 with SMTP id bi18-20020a05600c3d9200b00417d4f56501mr8815769wmb.27.1715081926621;
        Tue, 07 May 2024 04:38:46 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm23265977wms.34.2024.05.07.04.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:38:46 -0700 (PDT)
Message-ID: <d8373b6d-ec81-4010-8e01-cfc7d7e219a7@redhat.com>
Date: Tue, 7 May 2024 13:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] arm64/mm: generalize PMD_PRESENT_INVALID for all
 levels
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-2-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240503144604.151095-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.24 16:45, Ryan Roberts wrote:
> As preparation for the next patch, which frees up the PTE_PROT_NONE
> present pte and swap pte bit, generalize PMD_PRESENT_INVALID to
> PTE_PRESENT_INVALID. This will then be used to mark PROT_NONE ptes (and
> entries at any other level) in the next patch.
> 
> While we're at it, fix up the swap pte format comment to include
> PTE_PRESENT_INVALID. This is not new, it just wasn't previously
> documented.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/include/asm/pgtable-prot.h |  8 ++++----
>   arch/arm64/include/asm/pgtable.h      | 21 ++++++++++++---------
>   2 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index dd9ee67d1d87..cdbf51eef7a6 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -21,11 +21,11 @@
>   #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>   
>   /*
> - * This bit indicates that the entry is present i.e. pmd_page()
> - * still points to a valid huge page in memory even if the pmd
> - * has been invalidated.
> + * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
> + * interpreted according to the HW layout by SW but any attempted HW access to
> + * the address will result in a fault. pte_present() returns true.
>    */
> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
> +#define PTE_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */

Ah, so PTE_VALID == PMD_SECT_VALID. Would that also be a reasonable 
generalization independent of this? (or do we keep it as is because it's 
a HW def?)

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


