Return-Path: <linux-kernel+bounces-572850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D752A6CF5C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6D63AE1AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41CFDDC3;
	Sun, 23 Mar 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpfYjFWC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FAC2D1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742734390; cv=none; b=c40AyECX/8T7EohGS6XLx1B4NwVaeIePE7kxVqLNduTSXSM2mYe9TFTKeFGZf+eQnkZgumaP86PeDQKtuue0RBw7zvwe9WXDUTSG9j2/Cp8cUokWiK5V5Fqm4s+TcmGzEXZnFqvzDyCXr67RKcBug2tdsGmOxo1SNZ89cUX59zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742734390; c=relaxed/simple;
	bh=wi2qYg5XAhq01rv98NLSKder2Z/YABcPBu1MjVDXtg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PT3lLIy+EAED//PliVtgpS7nGKNs0GsV0L8GGTfcj2UohaFzi3CuRJTL8/XrLWQeDVZMxbn8idt4C+vroZ/f8VnoytOGCRXyW/mnIRHSvUYvM+vqaOQ7HlaV3X83/S3yOVLrrCh4ABSTPL/gFg9BhjqrD5nqKX4wALkFrnbo0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpfYjFWC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742734385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eSIceRe9krqWj293/6URxE7hkGbYapwA2HEzmy0enNI=;
	b=hpfYjFWCrxRgQUKyNgzG8Q8OEerfSpZXm6FjspCcDlBAUh4Zij7WKCLkA8N5TRj2GCdMoF
	QKA1yT6gKz3tJ8ij/zf1mbpxAkASFU16kbyTRmU69TblT1i3nneXCOWf1dV2RS0dp0v9zT
	qte4Ry2qAMIToSAR8296MzZQniFXctM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-n9WlLCDiOPGvsP0wUjESIw-1; Sun, 23 Mar 2025 08:53:04 -0400
X-MC-Unique: n9WlLCDiOPGvsP0wUjESIw-1
X-Mimecast-MFC-AGG-ID: n9WlLCDiOPGvsP0wUjESIw_1742734384
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47689b30d3aso26461221cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742734384; x=1743339184;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eSIceRe9krqWj293/6URxE7hkGbYapwA2HEzmy0enNI=;
        b=qyPuu6GkykdrIjGQ6L1Md/VPLIeyOVxsNaKFZErE/rl0kQwmNZJ9cVN22Cthy1iCXh
         qTPsKgdEeww/rEWjG8xbqoES7sYMl2y3/f9hvUy6X6V7Vld+v2OOLWfYB130tU6B24Jx
         /Q0dGruqF4iEZN03TcraAq3JjRv1ET3pWf9qeiqJiu5OAikr4k4bQ+xvOIeZGJqb4y3y
         4LB+cXf0WFQMI5hpE5IVSbLUdgqazdnODxGCAVp1/PqM7qxJSxXbIXgqeWlpyi167tpx
         B7EjSVxELE1XbED47gt//B7TnAVPOVBWx0QMmwvTsMN0C89RREHsJlRXuPAaOfP2PB0Z
         Y3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXmt3oUHNjl7JPyUFv62mXPzSxtCcJZcp+0UAvUGzSXD0A4FMJTvj9Piu6GusxwyZh4DITQydYzuUt4r0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeJDOVfi50YDjmZ1sx3LsUqzSzS276etzGr3mvaIDaRdr+8+F
	HfJjFLD6ZaJ/gmr7FMo+wrcMDX4Ig4OFAV4hoe+g9mxRvKc+Y5x51oIJfaGVT/YfYWZzp1q/iSF
	I/K73xR80/GHg0PpkRyu4ono0bOTy+WToQG8qa8coIhtWMhAMSslKF9haD+sZLw==
X-Gm-Gg: ASbGncu1ee7dNtOpaHUbFNhP7Q1C9TUQM5Qw8osrCtaVrZ98KXoke7FYTiKjtLJt1fe
	eD7Kr0IAdQLKgIh/GSAoqffNPeQbbnx44byfUJxj5usn471j5eZ56SJAUIA4LhceemaCVsyuPdr
	gIvMw8hbN84D64okME8bGKmBfe9WZXF7CZVfPNYrvr1k4Jyp16cbY/v6ypYP7mP9kgksr9C8j3r
	b56I68jxyU/QaifROYUARVispI3Cy3Ie0sNITY1iRNCnpEe5TAnRHxj/eDxKDHj/mwWfRB+U66C
	8mcxOoxbs+tt
X-Received: by 2002:a05:622a:4009:b0:476:8cad:72d9 with SMTP id d75a77b69052e-4771de3f530mr160971031cf.33.1742734383769;
        Sun, 23 Mar 2025 05:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCTuJh0gU8l7pZMW/mXxQ1EnUT/iVT8CUW6CIPAN/Z6JIHP2aHH9JskTgzY+HgJkPQRJJ++w==
X-Received: by 2002:a05:622a:4009:b0:476:8cad:72d9 with SMTP id d75a77b69052e-4771de3f530mr160970821cf.33.1742734383459;
        Sun, 23 Mar 2025 05:53:03 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18d541sm33433681cf.36.2025.03.23.05.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 05:53:02 -0700 (PDT)
Message-ID: <01803b0f-47ff-429c-a6af-33fee39b957b@redhat.com>
Date: Sun, 23 Mar 2025 13:53:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via
 MREMAP_RELOCATE_ANON
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
 <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
 <182bf1ce-1b67-4243-854b-4d0c26aae563@redhat.com>
 <21f89b73-aaae-4674-aea2-aefc7a4847d9@redhat.com>
 <9f81bfe4-4cc7-4754-b92f-db3a4e549f86@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9f81bfe4-4cc7-4754-b92f-db3a4e549f86@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.03.25 08:21, Lorenzo Stoakes wrote:
> On Sat, Mar 22, 2025 at 07:17:05AM +0100, David Hildenbrand wrote:
>> On 22.03.25 06:33, David Hildenbrand wrote:
>>> On 22.03.25 01:14, Jann Horn wrote:
>>>> On Fri, Mar 21, 2025 at 10:54 PM Lorenzo Stoakes
>>>> <lorenzo.stoakes@oracle.com> wrote:
>>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>>> index 0865387531ed..bb67562a0114 100644
>>>>> --- a/mm/mremap.c
>>>>> +++ b/mm/mremap.c
>>>> [...]
>>>>> +/*
>>>>> + * If the folio mapped at the specified pte entry can have its index and mapping
>>>>> + * relocated, then do so.
>>>>> + *
>>>>> + * Returns the number of pages we have traversed, or 0 if the operation failed.
>>>>> + */
>>>>> +static unsigned long relocate_anon(struct pagetable_move_control *pmc,
>>>>> +               unsigned long old_addr, unsigned long new_addr, pte_t pte,
>>>>> +               bool undo)
>>>>> +{
>>>>> +       struct page *page;
>>>>> +       struct folio *folio;
>>>>> +       struct vm_area_struct *old, *new;
>>>>> +       pgoff_t new_index;
>>>>> +       unsigned long ret = 1;
>>>>> +
>>>>> +       old = pmc->old;
>>>>> +       new = pmc->new;
>>>>> +
>>>>> +       /* Ensure we have truly got an anon folio. */
>>>>> +       page = vm_normal_page(old, old_addr, pte);
>>>>> +       if (!page)
>>>>> +               return ret;
>>>>> +       folio = page_folio(page);
>>>>> +       folio_lock(folio);
>>>>> +
>>>>> +       /* no-op. */
>>>>> +       if (!folio_test_anon(folio) || folio_test_ksm(folio))
>>>>> +               goto out;
>>>>> +
>>>>> +       /*
>>>>> +        * This should not happen as we explicitly disallow this, but check
>>>>> +        * anyway.
>>>>> +        */
>>>>> +       if (folio_test_large(folio)) {
>>>>> +               ret = 0;
>>>>> +               goto out;
>>>>> +       }
>>>>
>>>> Do I understand correctly that you assume here that the page is
>>>> exclusively mapped? Maybe we could at least
>>>> WARN_ON(folio_mapcount(folio) != 1) or something like that?
>>>>
>>>> (I was also wondering if the PageAnonExclusive bit is somehow
>>>> relevant, but we should probably not look at or touch that here,
>>>> unless we want to think about cases where we _used to_ have a child
>>>> from which the page may have been GUP'd...)
>>>
>>> UFFDIO_MOVE implements something similar. Right now we keep it simple:
>>>
>>> 	if (folio_test_large(src_folio) ||
>>> 	    folio_maybe_dma_pinned(src_folio) ||
>>> 	    !PageAnonExclusive(&src_folio->page)) {
>>> 		err = -EBUSY;
>>> 		goto out;
>>> 	}
>>>
>>> Whereby we
>>>
>>> a) Make sure we cover all PTEs (-> small folio, single PTE). Large
>>> PTE-mapped folios are split.
>>>
>>> b) Make sure there are no GUP pins (maybe not required here?)
>>>
>>> c) The folio is exclusive to this process
>>
>> On additional note as my memory comes back: if PAE is set, there cannot be
>> other (inactive) mappings from the swapcache. So whenever we use folio lock
>> + mapcount data, the possibility of the swapcache (having inactive mappings
>> from other processes etc.) must be considered.
> 
> Ack, do you have a feel for how such a check would work?

Likely under folio lock

if (folio_test_swapcache(folio) && !folio_free_swap(folio)) {
	/* unable to move. */
	folio_unlock(folio)
	return -ENOTGOINGTOHAPPEN;
}

-- 
Cheers,

David / dhildenb


