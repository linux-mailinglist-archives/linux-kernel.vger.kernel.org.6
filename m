Return-Path: <linux-kernel+bounces-539101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BBA4A0D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE84189A288
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EAC1F09B3;
	Fri, 28 Feb 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1sNo9Wi"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED251BD9CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765065; cv=none; b=Swb15WLCj2bAfhJHRvcUh1nVp2XDXpZTEPaTnnYSC36TUQY75RAT2Vx12Cxo+PsEpCHmblTTxwrbJRBUhRseVr28z6fEsNKYmQueZ7h3txxmwSFSH+vBJqJOu51Gw6jPEk1RnH93+wKQ84HTGmAa0ymd9MocAQGGXoJ5UuEd2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765065; c=relaxed/simple;
	bh=Rd7/uBItQJX+8uapYTk/rpUyTGiqOA264qrStMAcZuw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GIQMWQpw3XAjPU/GKEMiUvIyHr4Q+VupprxLeEolK41ikASZcZ8CF8ILxyuNyKDjRCOWwBU9cZMz5nfrehoVt8Ke9GRJPMRG1eUpleD/w2aTtPcvifLz1VRvzGl7v9pHCP+KT1aRdnzFfAvfmUiVYKbL8Sz9ONSbS4S/5o/lLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1sNo9Wi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe916ba298so4992542a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740765062; x=1741369862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6NyvctiqOUa3n9gcjc6FONh/SC/E+DJ6Q+NnNJwCpW4=;
        b=a1sNo9WiWO+bqlyVxiCRpS3rccz4kWWfd/j+SZI8YqvSgY/8VLU4vAZ86j0IOodZ55
         BXYyGYjAfj2MOIH6QhofNpJ/0DrM9FRTit09dAwW1L5HoYSPtCjUG/EP9dILn57gurXX
         mLYAwrucb24vxGX8LnPLXDMO/b4pAXYrmbLBJJQq9PKc/x3ewtwH+34p0cu4zsVltO40
         K81ChmwAMWjw4K5zobCA25BkWpGzmfIHMQu/+EuRNnbGgA2vbOXEEY5BBM3H8G7WxPkP
         +lUfH7ck4+uh00H0c1wZTY/RMb4HIOs1lV84hbC/XCtG7lyAicFgZCPrcGxI5HZ4+Zzq
         KszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765062; x=1741369862;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NyvctiqOUa3n9gcjc6FONh/SC/E+DJ6Q+NnNJwCpW4=;
        b=bUGPPrGqhFrQr8J3j8jjvAIvnNUq44QH1OJeo74G3j/qqYEsizoafb9bsommYAtXQq
         3vGe/yesxGqq+AiivgtUQ9oCFegIyq2lLOKQIGhfSN9l4k2LsQxhuJ5MPQGCfA3xEt8Y
         W/UsTll5t43ufvCLXMfwSvUrQeZfzwT4SotnpX5Io6FChR4a/6v2YwBjRKSJsGQcicjb
         7g4ZqsiAME9RHs/i5W9CfEQzmMmGzxm2K7n4tauFqxN74gYVBNMBZhRkUIYIVc5k60A/
         do4g9yAS5VzNQ5W+mGNt2f+R7u6f0rdMIpnzVT9gIxHwkhlPG6V0DLGVicOUkXl6qif9
         4fSg==
X-Forwarded-Encrypted: i=1; AJvYcCXa6t5Yuy+zsn8gFut7sP0NuTjfNKkfXVhAtUWcxJWuUaY3wK4I6EY6To3CWKnDwCxLRszSLyIlJwqI8zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTn/pfGhCP7L68ARKZnMVGqMVxJXm+4l7Qf5QXVwVKeJ91Jqg
	G4kQ44HJJ+i01Cs5QGhdz3gtnru7ay3E6XtbkswOtgvL2NJ7VUUjFaPu7OZbvOXUcm2kWRVeEJl
	+uBkQjAjAYFROMllJyGSZbw==
X-Google-Smtp-Source: AGHT+IFcKOkFii9o7crCwA/34cEMAOGG0lMrGvepv/XtLz3NB8cMI+uVglV3v5h1Vekl5o+ofsDoALDBoCUPhMpdGg==
X-Received: from pjbrr3.prod.google.com ([2002:a17:90b:2b43:b0:2fc:1eb0:5743])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4990:b0:2ee:f80c:687c with SMTP id 98e67ed59e1d1-2febac07e18mr6481041a91.31.1740765061874;
 Fri, 28 Feb 2025 09:51:01 -0800 (PST)
Date: Fri, 28 Feb 2025 17:51:00 +0000
In-Reply-To: <503c4ba7-c667-444a-b396-e85c46469f0a@suse.cz> (message from
 Vlastimil Babka on Fri, 28 Feb 2025 15:17:11 +0100)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz8qpqlzzv.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH v6 1/5] mm/filemap: add mempolicy support to the filemap layer
From: Ackerley Tng <ackerleytng@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: shivankg@amd.com, akpm@linux-foundation.org, willy@infradead.org, 
	pbonzini@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	chao.gao@intel.com, seanjc@google.com, david@redhat.com, bharata@amd.com, 
	nikunj@amd.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, tabba@google.com
Content-Type: text/plain; charset="UTF-8"

Vlastimil Babka <vbabka@suse.cz> writes:

> On 2/26/25 09:25, Shivank Garg wrote:
>> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> 
>> Add NUMA mempolicy support to the filemap allocation path by introducing
>> new APIs that take a mempolicy argument:
>> - filemap_grab_folio_mpol()
>> - filemap_alloc_folio_mpol()
>> - __filemap_get_folio_mpol()
>> 
>> These APIs allow callers to specify a NUMA policy during page cache
>> allocations, enabling fine-grained control over memory placement. This is
>> particularly needed by KVM when using guest-memfd memory backends, where
>> the guest memory needs to be allocated according to the NUMA policy
>> specified by VMM.
>> 
>> The existing non-mempolicy APIs remain unchanged and continue to use the
>> default allocation behavior.
>> 
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>
> <snip>
>
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -1001,11 +1001,17 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>>  EXPORT_SYMBOL_GPL(filemap_add_folio);
>>  
>>  #ifdef CONFIG_NUMA
>> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>> +struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
>> +		struct mempolicy *mpol)
>>  {
>>  	int n;
>>  	struct folio *folio;
>>  
>> +	if (mpol)
>> +		return folio_alloc_mpol_noprof(gfp, order, mpol,
>> +					       NO_INTERLEAVE_INDEX,

Could we pass in the interleave index instead of hard-coding it?

>> +					       numa_node_id());
>> +
>>  	if (cpuset_do_page_mem_spread()) {
>>  		unsigned int cpuset_mems_cookie;
>>  		do {
>> @@ -1018,6 +1024,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>>  	}
>>  	return folio_alloc_noprof(gfp, order);
>>  }
>> +EXPORT_SYMBOL(filemap_alloc_folio_mpol_noprof);
>> +
>> +struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>> +{
>> +	return filemap_alloc_folio_mpol_noprof(gfp, order, NULL);
>> +}
>>  EXPORT_SYMBOL(filemap_alloc_folio_noprof);
>>  #endif
>
> Here it seems to me:
>
> - filemap_alloc_folio_noprof() could stay unchanged
> - filemap_alloc_folio_mpol_noprof() would
>   - call folio_alloc_mpol_noprof() if (mpol)
>   - call filemap_alloc_folio_noprof() otherwise
>
> The code would be a bit more clearly structured that way?
>

I feel that the original proposal makes it clearer that for all filemap
folio allocations, if mpol is defined, anything to do with cpuset's page
spread is overridden. Just a slight preference though. I do also agree
that having filemap_alloc_folio_mpol_noprof() call
filemap_alloc_folio_noprof() would result in fewer changes.

>> @@ -1881,11 +1893,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>>  }
>>  
>>  /**
>> - * __filemap_get_folio - Find and get a reference to a folio.
>> + * __filemap_get_folio_mpol - Find and get a reference to a folio.
>>   * @mapping: The address_space to search.
>>   * @index: The page index.
>>   * @fgp_flags: %FGP flags modify how the folio is returned.
>>   * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
>> + * @mpol: The mempolicy to apply when allocating a new folio.
>>   *
>>   * Looks up the page cache entry at @mapping & @index.
>>   *
>> @@ -1896,8 +1909,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>>   *
>>   * Return: The found folio or an ERR_PTR() otherwise.
>>   */
>> -struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>> -		fgf_t fgp_flags, gfp_t gfp)
>> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
>> +		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
>>  {
>>  	struct folio *folio;
>>  
>> @@ -1967,7 +1980,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>  			err = -ENOMEM;
>>  			if (order > min_order)
>>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>> -			folio = filemap_alloc_folio(alloc_gfp, order);
>> +			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
>>  			if (!folio)
>>  				continue;
>>  
>> @@ -2003,6 +2016,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>  		folio_clear_dropbehind(folio);
>>  	return folio;
>>  }
>> +EXPORT_SYMBOL(__filemap_get_folio_mpol);
>> +
>> +struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>> +		fgf_t fgp_flags, gfp_t gfp)
>> +{
>> +	return __filemap_get_folio_mpol(mapping, index, fgp_flags, gfp, NULL);
>> +}
>>  EXPORT_SYMBOL(__filemap_get_folio);
>>  
>>  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,

