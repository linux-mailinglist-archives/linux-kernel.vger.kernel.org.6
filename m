Return-Path: <linux-kernel+bounces-432029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340329E43F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E283F2845EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7E318873F;
	Wed,  4 Dec 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvhzbIPV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28818B483
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338918; cv=none; b=X2R1TEGnupgDWQWuJcvFbX9b278ymVDUuaE3lIbIC0zUTBKi+Sih9zEb6naaLnbopWLolNUyyGfRoL4reM+HBQHWZUAYcmxRf0gGIiY9H+PIwgUT01urwUeCQTFxqx57dZirxbHuR8mi2joV3qVswyZAF3RL+WxgbWP4fHZWT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338918; c=relaxed/simple;
	bh=j4unjepeonfpnfAZH1TtC6EVfqyggipE9lXEtesLRxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIV1KBN66gwjFzDIIKtFz192OTYOoFoAL9SpZiVljhemH77zmLNik/lBSzyaPGePTI985Gc13dW3QNHENsahop8pmLJlH3VnMRfUhqKfRgl/AJ0B7fV5MupEmB2ZDaU4J5/wDonGsNB0+iZx5Ah59TKdogSMkE29xajoMZlan7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvhzbIPV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733338915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jDNQe5Mrz6/m+GS3duTlzU4njkkiyjT5dDsTVRSITuU=;
	b=AvhzbIPVoTC/FqrT0wHyIe+/fmKPW7+1Gs6NYvatkIFwQLasYP6AoUqwbrRTwFqXpv1EUt
	0/mTfufy5j5YH39MGl0YRO2O4xMnc1T295BoZaMBGDjBsNmsy0ZmIdpMhmaTUhPD//fd35
	6XE9DWkAqkS/yUGBEHXwsYxWyA+/z+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-32gLy2Z1O8yCU79RdIwCYw-1; Wed, 04 Dec 2024 14:01:54 -0500
X-MC-Unique: 32gLy2Z1O8yCU79RdIwCYw-1
X-Mimecast-MFC-AGG-ID: 32gLy2Z1O8yCU79RdIwCYw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e03f54d0so51856f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338913; x=1733943713;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jDNQe5Mrz6/m+GS3duTlzU4njkkiyjT5dDsTVRSITuU=;
        b=i6SEGxZXYxi4ADT1aFrNrEORsEkv3ky0TMb9fPpoUm2XApI9uDlGejD2hPMYtNu8n6
         cxlS0EOxemUniFr66WHDWKGfzWUFyM+3Zsft9znHGFHa+0x4dKoyXOtE4gXOXDkVuWQN
         gTS6s+IR+TJ+tFv/1uW/TJqUTOOG+nUMKgHeIJjRtSNMz7YscEkCovCefI04L3DMvS8l
         dxXkG47dtU3nDoYFR69A2Xr4m6HKn7Xa7w6ZMc5Ecuvf46v7Yh3f2auzx+AWBjKSNrVm
         p/ZjLSIGT0dLx1Lag1RSejEln1g/+wCZY0JIqXVcS6vNmRpxiJSiUyCRkFiFYsXMhwbA
         fm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXK1YmeY+MXTseXXveQjiGa1QgCUFfht28F71y/jUhziLwi46mg3v9R+FYISP4zbSUI5ulTGYDN3KjjW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8fWqM4l9rPlFnPb2QfDHNnwBSjHYfkVHGT2dBGCLtDbA/U9A
	gIkC7+fJoOvwa8anSya938joEwSgRV+m8Lu70uI6H3H14wKMg6Qj6/ENILXwjp2OO/bCcf8UMa4
	6S9RyOL7cp7QBIrK4e9KJHSiXoNiZQHkQxzSNXouIauAMc2rKRuxQl+JdYQ9bIg==
X-Gm-Gg: ASbGncuyhgR+IysBguOFMNRzRVqvWReISDB60T1okQlmSxdXBeurcwt81dunrgk8AZz
	ODJzenRJxaS59x5CDkm51+L1mo2qQAUFoGhyyS4ISfq0e6f6l0m/WUxKtlwXFVbBTdBWCvYL4Hw
	R46z8BQursbMInvLniHb+dBxTmTWE5lVkBJ1vwEEd+k7WdyN5wH/Yk4bnIfjpdWqzW3aDP5fZOu
	wK24ZYD6HF9to15Zd6al+NPuS4PtMLK9dx/r+kacHh+KsMy4lhDJ+3lIiQLJRNm4vCt2aZrwtVe
	KXSeNk24eUStc+BAbfbVq7xfaN5weHqGtjGkZOdrmvy+B8KlG3w+JI848YJtjZrz+VXyRG+etoA
	Fxg==
X-Received: by 2002:a05:6000:2a9:b0:385:e303:8dc6 with SMTP id ffacd0b85a97d-38607ad00d3mr5067253f8f.26.1733338912216;
        Wed, 04 Dec 2024 11:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlQ+DJpjM1x7pOZdxEIJvFPhbZv9NZNPfZ8t3v02NjzYBYrdFZHAMqMyzuonePX+a2ZI+UvQ==
X-Received: by 2002:a05:6000:2a9:b0:385:e303:8dc6 with SMTP id ffacd0b85a97d-38607ad00d3mr5067046f8f.26.1733338910384;
        Wed, 04 Dec 2024 11:01:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b66ecsm33099575e9.39.2024.12.04.11.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:01:49 -0800 (PST)
Message-ID: <0dc516ab-b2b0-414d-868e-880bd13b5cdd@redhat.com>
Date: Wed, 4 Dec 2024 20:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
To: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Eric Hagberg <ehagberg@janestreet.com>
References: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.24 19:26, Guillaume Morin wrote:

Patch prefix should likely be "mm/hugetlb: ..."

> FOLL_FORCE|FOLL_WRITE has never been properly supported for hugetlb
> mappings.  Since 1d8d14641fd94, we explicitly reject it. However

"Since commit 1d8d14641fd9 ("mm/hugetlb: support write-faults in shared 
mappings") ..."

> running software on hugetlb mappings is a useful optimization.
> Multiple tools allow to use that such as Intel iodlr or
> libhugetlbfs.

It would be better to link to the actual request where people ran into 
that when using PTRACE_POKETEXT

That hugetlb is getting used is rather obvious :)

> 
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eric Hagberg <ehagberg@janestreet.com>
> Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
> ---

[...]

>   		delayacct_wpcopy_end();
>   		return 0;
> @@ -5943,7 +5944,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>   	spin_lock(vmf->ptl);
>   	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
>   	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
> -		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
> +		const bool writable = !unshare && (vma->vm_flags & VM_WRITE);
> +		pte_t newpte = make_huge_pte(vma, &new_folio->page, writable);
>   
>   		/* Break COW or unshare */
>   		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);

After rebasing to [1] this hunk here can likely be dropped. 
make_huge_pte() will perform the VM_WRITE check.


[1] https://lkml.kernel.org/r/20241204153100.1967364-1-david@redhat.com


-- 
Cheers,

David / dhildenb


