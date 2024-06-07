Return-Path: <linux-kernel+bounces-205632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F878FFE4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022F91F27579
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F515B11E;
	Fri,  7 Jun 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+BjaVSZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955EF1527BF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750012; cv=none; b=Ld34Sq3UgTdH1ScBje6vC23OasPTSpkVcFhdu9/TBJsC/Wy8WDmjDE5o/aUihFl45FFQWzoaD+lLT0hh+ZVyWmKetudDKhk2HXcxZklgGjPwy0ARpRPevhfWbBUTaMpJcMov+Z2Z8Vz0XOCF30caHKRY1S81PnL5sd7ZImmHhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750012; c=relaxed/simple;
	bh=wHXkuYoyZFHOwJ2QFLFII8TzlnMf9BxnpzSxat8m2ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdsXEMr+yAMQuDxFdywsD+vfGNV5wKc6V3bScj9iCK4cO/QKUSpPHFgiz7dLxppkngjnzb28nBIaW0bqsiE5DN1xyajaxKI+cOzdPLhahDQDuEL0pWKCTeFrM/I5w3+3nnZVKJszwv64+P6Ce/gSVsYJOVlyxDePX692VdkfRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+BjaVSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717750009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9G908EUHZQO7xwQrAL392gNKVNYWE7yD+jfmTDynUcQ=;
	b=b+BjaVSZOQTncogGOU4TxbVmQeSo2P9EW0+2MXuxFOn02S3HPaAC9nXcedxn61f1m+e/jQ
	+OXzaXhYuX/9Xq0uYyacWY5LWy+yTVdqv2FksiRHmAaNIpcDvf4muR0vr7Hk4zvteU+UpZ
	S6IhBRGUtsvUSheaIZ5OZl7pP7cgNsc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-fli8eoF6Muy-FtxIAnqvAg-1; Fri, 07 Jun 2024 04:46:47 -0400
X-MC-Unique: fli8eoF6Muy-FtxIAnqvAg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dca0dc826so1284294f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750006; x=1718354806;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9G908EUHZQO7xwQrAL392gNKVNYWE7yD+jfmTDynUcQ=;
        b=ksml6ETcFuYco1NqsXVukVM6oniQWF7mw8REOFC8dzG3eVH8GEMv6NygjclnI/435Y
         JDnP5GDXy4McH5tPwlaRqNKbpyd37tNh7HznHDoai3DL3gAM2jix+6Pe5ZuGQ45vo46I
         S45VSa9hb3ieIRALxiQDkQVuewaNbmAPmTdrnJZp+LyX3U07IFL6kpNEVsoXVXPuERk0
         BDBqMPwplERhWUb82GwPWp9WPZi3kjlIK9yEhG/BHUPDGFAymYSJPqwH6+bv8muowXOX
         T9cxe2p9wdrFTiFyC9SYoWMswNPjAE9IAfg2ZJZISox3EukvS0O3prykPYAHM+zn30pL
         O1qg==
X-Forwarded-Encrypted: i=1; AJvYcCUZn/pYvgJZLB35yCMLG68axw14fnmJo7BcBrimkqduo8pF2N+mf4oKjATfl9i+SijZQAL4UyZe2vzTQchh0VKyNljng2RtSCRftfS9
X-Gm-Message-State: AOJu0YyrgX6hFPskaElRvVcRx1sMTB8EFnwDH5CowsdJKKmVpPgHrTYQ
	8Imz9URajhsRSlYCfTRKZ7nH3U2yokbi29C0SC/vAWKlldPMFB0EgidM8Z6y7687QAg5Q6mwo7n
	+czDufcPK/biXQ3ASSjdjPBnVuAp8Gj741c5Vm2JBuunp+2NdML6b4VoVv0WgAg==
X-Received: by 2002:a5d:51ce:0:b0:35f:d4b:1368 with SMTP id ffacd0b85a97d-35f0d4b1525mr46340f8f.15.1717750005991;
        Fri, 07 Jun 2024 01:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg0d2a/RQQtggUuTpTabIxQ3RXIDIBipSHymN3if6O/LiRJWp5s2rGBXZ/EghZCMjG9ddl6w==
X-Received: by 2002:a5d:51ce:0:b0:35f:d4b:1368 with SMTP id ffacd0b85a97d-35f0d4b1525mr46324f8f.15.1717750005472;
        Fri, 07 Jun 2024 01:46:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a? (p200300cbc71a220031c44d181bddfb7a.dip0.t-ipconnect.de. [2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc12e0sm3505157f8f.100.2024.06.07.01.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 01:46:45 -0700 (PDT)
Message-ID: <a04dd2d6-8526-488f-b46a-80c530891415@redhat.com>
Date: Fri, 7 Jun 2024 10:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: introduce pmd|pte_need_soft_dirty_wp helpers for
 softdirty write-protect
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, kasong@tencent.com, linux-kernel@vger.kernel.org,
 minchan@kernel.org, ryan.roberts@arm.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org
References: <20240606034016.82559-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240606034016.82559-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 05:40, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This patch introduces the pte_need_soft_dirty_wp and
> pmd_need_soft_dirty_wp helpers to determine if write protection is
> required for softdirty tracking. This can enhance code readability
> and improve its overall appearance.
> 
> These new helpers are utilized in gup, huge_memory, and protect,
> and are particularly applied in do_swap_page() to optimize a
> softdirty scenario where mkwrite can still be performed.

[...]

> +static inline bool pmd_need_soft_dirty_wp(struct vm_area_struct *vma, pmd_t pmd)
> +{
> +	return vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd);
> +}
> +
> +static inline bool pte_need_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte)
> +{
> +	return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
> +}
> +

Should these be "needs" ? I tend to like these names/semantics.


>   static inline void vma_iter_config(struct vma_iterator *vmi,
>   		unsigned long index, unsigned long last)
>   {
> diff --git a/mm/memory.c b/mm/memory.c
> index db9130488231..6307c43796aa 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4322,7 +4322,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (!folio_test_ksm(folio) &&
>   	    (exclusive || folio_ref_count(folio) == 1)) {
>   		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
> -		    !vma_soft_dirty_enabled(vma)) {
> +		    !pte_need_soft_dirty_wp(vma, pte)) {
>   			pte = pte_mkwrite(pte, vma);

I would move that into a separate patch, as it's not a simple conversion.

-- 
Cheers,

David / dhildenb


