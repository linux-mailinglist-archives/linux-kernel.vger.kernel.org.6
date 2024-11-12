Return-Path: <linux-kernel+bounces-405736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE09C5667
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC11F219F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BB216DE2;
	Tue, 12 Nov 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpFueb/F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB31214436
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409831; cv=none; b=Q1D2nnuSvfBifQEhU6Z1qociwoQ9tHDh2pHVBialAW5RSznY20XiLhBOLbZGzg+UonadU+Kb0u+s7pyur5Pk6gKUwrx/NhbGW4T1lDETvRsylifyG7AzKXxU8DgLHmVvtq0AKuEeSRSBvz6T+pBqbRbzMbrmCYNJ7GsSg8QaTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409831; c=relaxed/simple;
	bh=JgWrCTXz86cjF0ahpur6UVM4IKYvXBrSsKiOXqEnnX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obAKjZsATWCK01NK+6eN8TmzQ9cSCMzQvVRjbkDNz/RFbMIMuZdjag6r5wB320zKYwVS1ht1PNjmNF2dnmaXvIh4jL1xH29kCuqMiBGIg1iFOjPXp2/wffyndlnImDnMUqZu7om/90XmNZcQFICXstOOgFU5z8GSPVArZc1U3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpFueb/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731409828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MginGWETi2H3aRboKWAqgKyTMFlHOXDBT6vgmNx/v4g=;
	b=TpFueb/FuZJsTpV+ICKMvKbSsJpIccqIKZTSjkUJzp5fQcEDGscNRnNxLwrhIllO7v0Uop
	1ridL1MQZWMg15iibl/RF7u8o8BGgaELIc05fzJzw3Z527Sf7WInjsnLZuIR017hkr8jeL
	GTqDXF4wvyQGQ80niMfhGtQSo+MrzNQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-MVNF75n0Mo2W-hUfgyXc9w-1; Tue, 12 Nov 2024 06:10:27 -0500
X-MC-Unique: MVNF75n0Mo2W-hUfgyXc9w-1
X-Mimecast-MFC-AGG-ID: MVNF75n0Mo2W-hUfgyXc9w
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d5116f0a6so3088965f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409826; x=1732014626;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MginGWETi2H3aRboKWAqgKyTMFlHOXDBT6vgmNx/v4g=;
        b=HDFIb69gHuZfOu/gMJFB+CsfInug6Dzqyv7V32YTjIMgzjsUET2TA2JQNd20Kypml6
         stYYCYTjBHi38gzz6PI32dVfomhRRgeePz5qiG3mPwwDLqezsQJNWfzoBSgXDU0fFRfH
         aLU/7fg4VKgmGiQJmOOhpp8qgWw6KMiKWIGtIsUGvErC6MmZm6B05CstsNexQmGFsD2W
         DdUvN971CguApuDd0EnRdWE75gAv+2pQtg9wci7s9OtaCF2mHTQIloHQ0qSL7DO6Hr5+
         JzqYavZnmFKYSyCe1ipbzsHYDKwS/BOYblH691wYLeEjvyk5caosTY946JwbgfRogeA/
         ZlQA==
X-Gm-Message-State: AOJu0Yx/KAWVg2R2VA+yeLNdfxF4Ap/A2WJfDLGP2O2S4X7EKSUyD0/B
	pkGa6p5EYgC4bAKLNl7zRggs4fLA0olSpXfyI1zGsogM9cGBdWyFpGL3H9ApXyXPX57WLYvD1+0
	PD5jTCZIXF1lXKSWFRn2H3caoCE3GoBWkYvMfJBIMvQgEBOPP0E96W1MCOYLEow==
X-Received: by 2002:a5d:648f:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-381f186d11amr14002792f8f.34.1731409826256;
        Tue, 12 Nov 2024 03:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOsohEx/JDBmfWzlps27AmO7dmgLiD/4MM2L9pB/atzh4nhI9pEMbwBztz+lIu3iHRMoK+IA==
X-Received: by 2002:a5d:648f:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-381f186d11amr14002765f8f.34.1731409825862;
        Tue, 12 Nov 2024 03:10:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99a0efsm15178034f8f.58.2024.11.12.03.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:10:23 -0800 (PST)
Message-ID: <b0949317-9be5-49e4-9390-2ff1ca1b1ed9@redhat.com>
Date: Tue, 12 Nov 2024 12:10:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] binder: concurrent page installation
To: Carlos Llamas <cmllamas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 Barry Song <v-songbaohua@oppo.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>
References: <20241108191057.3288442-1-cmllamas@google.com>
 <20241108191057.3288442-3-cmllamas@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241108191057.3288442-3-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.24 20:10, Carlos Llamas wrote:
> Allow multiple callers to install pages simultaneously by downgrading
> the mmap_sem to non-exclusive mode. Races to the same PTE are handled
> using get_user_pages_remote() to retrieve the already installed page.
> This method significantly reduces contention in the mmap semaphore.
> 
> To ensure safety, vma_lookup() is used (instead of alloc->vma) to avoid
> operating on an isolated VMA. In addition, zap_page_range_single() is
> called under the alloc->mutex to avoid racing with the shrinker.
> 
> Many thanks to Barry Song who posted a similar approach [1].
> 
> Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   drivers/android/binder_alloc.c | 64 +++++++++++++++++++++-------------
>   1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 7241bf4a3ff2..2ab520c285b3 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -221,26 +221,14 @@ static int binder_install_single_page(struct binder_alloc *alloc,
>   				      struct binder_lru_page *lru_page,
>   				      unsigned long addr)
>   {
> +	struct vm_area_struct *vma;
>   	struct page *page;
> -	int ret = 0;
> +	long npages;
> +	int ret;
>   
>   	if (!mmget_not_zero(alloc->mm))
>   		return -ESRCH;
>   
> -	/*
> -	 * Protected with mmap_sem in write mode as multiple tasks
> -	 * might race to install the same page.
> -	 */
> -	mmap_write_lock(alloc->mm);
> -	if (binder_get_installed_page(lru_page))
> -		goto out;
> -
> -	if (!alloc->vma) {
> -		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> -		ret = -ESRCH;
> -		goto out;
> -	}
> -
>   	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
>   	if (!page) {
>   		pr_err("%d: failed to allocate page\n", alloc->pid);
> @@ -248,19 +236,47 @@ static int binder_install_single_page(struct binder_alloc *alloc,
>   		goto out;
>   	}
>   
> -	ret = vm_insert_page(alloc->vma, addr, page);
> -	if (ret) {
> +	mmap_read_lock(alloc->mm);
> +	vma = vma_lookup(alloc->mm, addr);
> +	if (!vma || vma != alloc->vma) {
> +		__free_page(page);
> +		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> +		ret = -ESRCH;
> +		goto unlock;
> +	}
> +
> +	ret = vm_insert_page(vma, addr, page);
> +	switch (ret) {
> +	case -EBUSY:
> +		/*
> +		 * EBUSY is ok. Someone installed the pte first but the
> +		 * lru_page->page_ptr has not been updated yet. Discard
> +		 * our page and look up the one already installed.
> +		 */
> +		ret = 0;
> +		__free_page(page);
> +		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);

This will trigger a page fault if we don't find what we expect (are 
races with e.g., MADV_DONTNEED possible?), is that really desired or not 
a problem?

-- 
Cheers,

David / dhildenb


