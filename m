Return-Path: <linux-kernel+bounces-531946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9384CA44712
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE883AD397
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC3210185;
	Tue, 25 Feb 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAyOefY1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080118B463
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501906; cv=none; b=t/a+GlHUzQzgb9ChLLCGPTS2z1ChYlT+ZG8oc39Iz/qV0feC3ujYhAirtscFLm9BGSd9Q6RErbno+o2mZFoXiHWMP89teI7Rr34Li8pZrC0aN3TUN0Ycf+BLGst6BBUsMXuiqKwGXBRP4e8CCsOQ9cI3YBCnumwuO6yjHZS4jfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501906; c=relaxed/simple;
	bh=WIS//hmQqKL3SNEkU5ojpfzy+ylWFDXe5ZR5FumtPDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwULv627lcxB1Cw/Of0+6nLK2qiWjJrifuW1DUCIvurz5BoiCNcWK5JPhkz35TBj/QeYkuprW+/9nN91jdeZ0VRKAA02j/W2US1JJbAYL/z92tdSnGdLd8pxQ1CKt0tStGFJadnuA9+q/xrqCI1O1EHh7oCmdlmCyrwwtV327Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAyOefY1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740501903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zgtMS7lnc2iJ8NZz5qc7ro7UVfbncD2D53CMQ2PQPfk=;
	b=dAyOefY14Ybb8MTo7hHUZ3BFsSlsj1btjH7p11qW6WvUuQpdd6Sg3DjmzUFgHKTCdWEgiy
	edtx+G486P6eLR+G4u10lOxSPxyWtuGklz5+56dvmZYrrNiEVrrxZmd9mTwSVyk6O2BAiQ
	SrPLLVK8lDiLNIoYRwc0SctowEbs4v4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-RaXwUKumPraZFTMFq4XkYA-1; Tue, 25 Feb 2025 11:45:01 -0500
X-MC-Unique: RaXwUKumPraZFTMFq4XkYA-1
X-Mimecast-MFC-AGG-ID: RaXwUKumPraZFTMFq4XkYA_1740501901
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2c0aa6d6so3027562f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501900; x=1741106700;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zgtMS7lnc2iJ8NZz5qc7ro7UVfbncD2D53CMQ2PQPfk=;
        b=jYYTuHYbrtsIZR1UnYei1ankvGdn+FBE+HAjFqKpfVI4RK5SpZktQvBlOc72qeLBAd
         2YCBjg6NGd7xXbCYqKJ40ZfnxomkeEodHG82Rwn9eIX57DuoEyAEAhOO0/85+6Pf9Wum
         Bm8WFwiHZJh4Ap6DtPJsfsvmnQtOJdk3L442ILwl5hTOeSkflI7YtnP4JRfIub4dztcc
         duBIvxHAYZ/sOjsr6uKnZKelxU1LonLMH8Ghg8a6uEu0qbCtU7mFX5PBng5rDFKu0B7Q
         Iaycbthk3+pD65z+d3zLwD52KyZdP91TbfS6UzJqdg/SbPWkj4QdTbybRm4bNlzXjWhD
         rqAA==
X-Forwarded-Encrypted: i=1; AJvYcCU+b5igZmUnF0dKpL6Cf3Rj7pc2ALqhx6N0kBRnbtftHaHbUbL9PtMdqvTuyWM8sAzsK+0grWYACJdVHjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPm/6DJvGZeESZK/k1DAIJ2oxqT1AIWOSGJJ4/pFprCmNkD03
	4Ad+SFvwkD+cBoY5E2KaYQN+JBjdLsQ6YwL1rCWdlLFeWnCWytzXjrtP1OubECgbipSlXEY+MVF
	0Ysom1bmXm4DVMlbpvTltlv3STmiqDqlyIyqcPsDnCLS4gTLaPGGJeG9GqG3lmA==
X-Gm-Gg: ASbGncsTJV0XViHBJfU7IMNP8BmzfK/BQql69xCgUpJ/O9BOgmZZRO41N8Hb9cs9E7C
	M4nEFePUMqYTYB5j1DANvoruc2T85sHU60xalNnZq10sY2dntHjTOpT10JZp46LjP26bdBSk7m9
	6AuPKrNepzLU7vtD7cc89Z23LHZSp1ljkvhhG0z7BJm+FFSSkaIZXzDKvg06PBeG/Mnjm/fYjt7
	bXwe3BU4VKbE8FDBf1PA41znfdtQ1llYfjVHQjNySp4yn6jKiVVGWtGg47yUflGEgLYLq0olr5E
	NtvqbOtVLU5cCrWmjq6YV2Z2Z7x7pU9svOY/Athkw9BAjRBXpism0HGItqWm+0bXf0pIP3lXQUL
	v9yFnVmv5oX5OHGGxRfrYmuHBAy71XOHTQbhyHJd7mfM=
X-Received: by 2002:a5d:47cf:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-38f6f3dc975mr13459205f8f.16.1740501900575;
        Tue, 25 Feb 2025 08:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH/ppmqPuHv9x4JWuJwDh8X2zE6J0Qu0E5QL3bigRQ34cHTtjW/smUzdS4y56n8NeYTmt+rA==
X-Received: by 2002:a5d:47cf:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-38f6f3dc975mr13459183f8f.16.1740501900262;
        Tue, 25 Feb 2025 08:45:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86d1d5sm2894726f8f.39.2025.02.25.08.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:44:59 -0800 (PST)
Message-ID: <a196d780-c775-4f77-96f2-df3fe61af32f@redhat.com>
Date: Tue, 25 Feb 2025 17:44:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: page_owner: use new iteration API
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1740434344.git.luizcap@redhat.com>
 <badc717329c288c58b7abf7513603aa3042c008c.1740434344.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <badc717329c288c58b7abf7513603aa3042c008c.1740434344.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 22:59, Luiz Capitulino wrote:
> The page_ext_next() function assumes that page extension objects for a
> page order allocation always reside in the same memory section, which
> may not be true and could lead to crashes. Use the new page_ext
> iteration API instead.
> 
> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>   mm/page_owner.c | 61 +++++++++++++++++++++++--------------------------
>   1 file changed, 29 insertions(+), 32 deletions(-)
> 

[...]

>   void __reset_page_owner(struct page *page, unsigned short order)
> @@ -293,11 +297,11 @@ void __reset_page_owner(struct page *page, unsigned short order)
>   
>   	page_owner = get_page_owner(page_ext);
>   	alloc_handle = page_owner->handle;
> +	page_ext_put(page_ext);
>   
>   	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> -	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
> +	__update_page_owner_free_handle(page, handle, order, current->pid,
>   					current->tgid, free_ts_nsec);
> -	page_ext_put(page_ext);

I assume moving that is fine ...

but I'll not that ...

> -	for (i = 0; i < (1 << new_page_owner->order); i++) {
> +	rcu_read_lock();
> +	for_each_page_ext(&old->page, 1 << new_page_owner->order, page_ext, iter) {
> +		old_page_owner = get_page_owner(page_ext);
>   		old_page_owner->handle = migrate_handle;
> -		old_ext = page_ext_next(old_ext);
> -		old_page_owner = get_page_owner(old_ext);
>   	}
> +	rcu_read_unlock();
>   
>   	page_ext_put(new_ext);
>   	page_ext_put(old_ext);

... here you are not moving it?


In general, LGTM, only the remaining page_ext_put() are a bit confusing.

-- 
Cheers,

David / dhildenb


