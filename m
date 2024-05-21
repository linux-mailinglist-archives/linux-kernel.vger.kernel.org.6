Return-Path: <linux-kernel+bounces-184715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A658CAAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD9D1F22842
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374360BBE;
	Tue, 21 May 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJhNsSbU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288959147
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284209; cv=none; b=JXtZTqYdNgHB714F281SZLExzVeM3tARIQsDGOqbZBxhXuyeKMAE5RQQxphWUrekpamFYKta6T7r5vADA39ITRR7U1bopdqndaXW+WZSEzY4vdUMNDNr1hBZ884VYED+E/Iks4/mLWDlr4+YA7I/u5t1LzVajjMu6G9zoRhb7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284209; c=relaxed/simple;
	bh=nZV4Bdhi0UXpPrlCugfS65h5i2WJHqRguxSZO2cZnFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h50SYDpUnM9j1kXoKmQuN8kDGBXMHzTjJZft2yh1sUrcouNlhsuiAnqMYVX6rhp3WUxikvwW6XNio6yJ9Xu2EK9GbGwA1Kk76+gHr6fLLuopIh4ADiddNFuaSNL72dQ5O8fyH4puaqMZc/l8ULqeMJR4/wXE70tDVU09PtiqcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJhNsSbU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716284206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8TotQymrkTXKJP2dbOeE/8/7QYh8IcgEOhwgpcYLit4=;
	b=iJhNsSbUBPVNk+phls8nV9qAgCkSkAwzcZ+Yh7Gz1KUmOYHmTjiO5cnOsVOb4yEQh/xgVA
	UwJLgbRaV3gsMXNN+M+32an2ShAzPWfYCryBM8FWYRlYcPUpLL0gVohFqGfTarfS9EurOK
	ry8GT6EHDiLDSctcEQwzTrd/wWPYnvo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688--mvbC2zdN8W4UWxMEDd-7Q-1; Tue, 21 May 2024 05:36:45 -0400
X-MC-Unique: -mvbC2zdN8W4UWxMEDd-7Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34d9deebf38so7836486f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284204; x=1716889004;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8TotQymrkTXKJP2dbOeE/8/7QYh8IcgEOhwgpcYLit4=;
        b=C9h1FHAhC5wp5wwazaezaHW8Ghssq3Sz5wC96TKPdLYLl/fePMEOI8TOPJA1dPogEw
         UqFGavI7qnBVY/NhZ2vyhh7+wOYhLZZ8SUeyCc6z1vRm+dwk8pPnO80we+Sahz2yvhY0
         QqkvSc+3bReVqdQBQZYyt1wFQtQT5TmBk+HzA0XFonTtoRo7LPg2Ac0fMkE0PPTI+X1C
         8gYN6PZRKXUe2ldCIafnt0nlITBV22XTce6YnhwvQAMlyHWmNiMgc7Ck+nCPuYcALobS
         /3up6P18GYqfRjD+ygmqoW1cWM9gMArVCXUOJMuqQyT5JkFuGR/qPAN7izKGOUXhfp7f
         r7dQ==
X-Gm-Message-State: AOJu0Yzmr4efHoAckD3CdQOJEwe0QkPfG3AuhLZT37oGX0iAPN6e80Xa
	F0+DVlRPgMUFJfveKN+A4rOpj+1ywdcX95fFs39dnefPRb8+0QKp2fE+F83XX+eAsOn0Z1bSXNs
	3HRuiSmaNbB/oqfYTv36vBjIkcvTmpDUCsCr2u+A59d9ZqokrVf2GvxAQ7FGJqQ==
X-Received: by 2002:adf:f590:0:b0:34c:b86a:794c with SMTP id ffacd0b85a97d-3504a96b845mr29768820f8f.70.1716284204284;
        Tue, 21 May 2024 02:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkrfOPTQeHBK0L612NDmEfoV6h/sGmyVuwJjpTZyriwnIAr0c/urZ2Tu2jhH0ROmfzvFkapg==
X-Received: by 2002:adf:f590:0:b0:34c:b86a:794c with SMTP id ffacd0b85a97d-3504a96b845mr29768805f8f.70.1716284203881;
        Tue, 21 May 2024 02:36:43 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd09sm31289718f8f.14.2024.05.21.02.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:36:43 -0700 (PDT)
Message-ID: <4650b888-d90f-40e3-8c53-c9949e539959@redhat.com>
Date: Tue, 21 May 2024 11:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm: Refactor update_mmu_tlb()
To: Bang Li <libang.li@antgroup.com>, akpm@linux-foundation.org,
 chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 ryan.roberts@arm.com, ioworker0@gmail.com, libang.linux@gmail.com
References: <20240518074914.52170-1-libang.li@antgroup.com>
 <20240518074914.52170-3-libang.li@antgroup.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240518074914.52170-3-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.05.24 09:49, Bang Li wrote:
> Remove update_mmu_tlb() from those architectures and define
> generically via update_mmu_tlb_range(), removing the ability
> for arches to override it.

I'd suggest something like

"mm: implement update_mmu_tlb() using update_mmu_tlb_range()

Let's make update_mmu_tlb() simply a generic wrapper around 
update_mmu_tlb_range(). Only the latter can now be overridden by the 
architecture. We can now remove __HAVE_ARCH_UPDATE_MMU_TLB as well.
"

[...]

> +#ifndef update_mmu_tlb_range
> +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
> +				unsigned long address, pte_t *ptep, unsigned int nr)
> +{
> +}
> +#endif

With that in patch #1

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


