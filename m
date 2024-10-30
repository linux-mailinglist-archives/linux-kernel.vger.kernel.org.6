Return-Path: <linux-kernel+bounces-388328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493A9B5DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D281C214D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5D1E1052;
	Wed, 30 Oct 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM+N4L0y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF571E1051
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277300; cv=none; b=DO0EDfTTkIZ2L5QD1bVi2MQ5tuYjlN/q72PW4RXxl9IWpdSUQAjVNgjtLuMT1MANzUrpKEOTk9c5Nga5f2XIExk/o1Ab6W7MuioYnfU9mcfnBWfclPq/0ZBRDR8xv/7SA0dTvZmiysEuMOS+v3B6Ti125hdUh+2CnMQ/f3zVowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277300; c=relaxed/simple;
	bh=zlos3ROi5kzEr1HCIe3QhChCav3Kh2ANxKv9HThCPcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwpMoLyeoEncIwUs1UqfhD1Sgp+NukL7QWxv0og8D47nWvDhtpuuY4dGg1fBFYZyeQ+ROP5yzaQcIC+jan+rTp3UCYT2ormoejYODxHnfxmb+/1JxFEhIK1NCDwt+mVqm3ceScDxYUy2yVE5TyLAYTV/7iUIh6wKfhuvdxwfYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GM+N4L0y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730277297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RDbKspYQEPtAp9PIc46oWA+G9yo3CZRa6RrJLEqMKK8=;
	b=GM+N4L0yaejNVSMeAxw258zFzBH1+rJ0DHdjbFrdGhyUgn6XuJAifXH8J16pU33qUnWuHm
	AVUOkQAj/mIlWLiq9+kdSc4uyjtsv8amZRlZ4E3yZjFzG6nCRBPNQGlSs8Yq1LDBn1vOdh
	Oegix0TjMBbZt5TOR8w8q3qBBoumg/Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-VcIKvQHfOAyF0vUZ5Cx42g-1; Wed, 30 Oct 2024 04:34:56 -0400
X-MC-Unique: VcIKvQHfOAyF0vUZ5Cx42g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb44181f04so41574011fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730277295; x=1730882095;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RDbKspYQEPtAp9PIc46oWA+G9yo3CZRa6RrJLEqMKK8=;
        b=fOyaerSiYA5mCvhbxyuBJQSzB7J7x6Y5UmrxGbbt1O8iMIdsh8cUuaOXm9Tyx9XFhP
         d7xvJMHl2+nLtkocM2qj2LVyABsYhiX4WoX4m5ay/r3ojQ32OvuXLfJgG+mnHUArKlNg
         vb7OOKa1xMweNISpL2VZbJbecfyfX2crIhId1Ps2BeZHl5WJ9U3k+Vlhu3sqBte6qhP3
         4etnQ9Zdh4y6g4v+CKFXmwZyKKVHxOX+pRIKZO7KhG19wk9IhyVGI5coB11wFqKCIDab
         RJU+lAiq7LRVj68z5GrBmzOmBQANTCML55jSqdOI7DbUBMiuJshUI9tQnwhUldYg0MiS
         jP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrSUxF638QfIluHg/YNMy/TP3DDExLogQHK6X8Scgb5+X3mbSVsDLS2rR672LLkQuN0bJwpEJSk0eI2JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMlMjydlQ80fQGIH7LNlEh/kx5Axrof8QL/71Gu1GnmJyx1DP
	Nek5uu85QB+vPNH/OZlh4WfSpVZOEPDtXl+HwLpCJ5WkuVsGIUfhB3fPDiHoFAz7Vjryz2es4ya
	+HJ1Ub3bN6bRPe93n+J++BRxu4SUYUVvx0sc+6TTO//hvLXNv0xVQUk+nCdFzvA==
X-Received: by 2002:a2e:b8c8:0:b0:2fb:6229:c597 with SMTP id 38308e7fff4ca-2fcbdf5fcf8mr69187091fa.4.1730277294593;
        Wed, 30 Oct 2024 01:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUqXHjWrf0yZc8HqI1EVnYphaEAFWk18vOTEaTr/lQjC8GHkjp05lhb0SF6NZzZNrXwD2/yQ==
X-Received: by 2002:a2e:b8c8:0:b0:2fb:6229:c597 with SMTP id 38308e7fff4ca-2fcbdf5fcf8mr69186921fa.4.1730277294132;
        Wed, 30 Oct 2024 01:34:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd990dc1sm14201265e9.40.2024.10.30.01.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 01:34:52 -0700 (PDT)
Message-ID: <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
Date: Wed, 30 Oct 2024 09:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dongwon Kim <dongwon.kim@intel.com>,
 Hugh Dickins <hughd@google.com>, Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 07:50, John Hubbard wrote:
> On 10/29/24 11:18 PM, Alistair Popple wrote:
>> John Hubbard <jhubbard@nvidia.com> writes:
>>> On 10/29/24 9:42 PM, Christoph Hellwig wrote:
>>>> On Tue, Oct 29, 2024 at 09:39:15PM -0700, John Hubbard wrote:
> ...
>>>> Because pinning down these amounts of memoryt is completely insane.
>>>> I don't mind the switch to kvmalloc, but we need to put in an upper
>>>> bound of what can be pinned.
>>>
>>> I'm wondering though, how it is that we decide how much of the user's
>>> system we prevent them from using? :)  People with hardware accelerators
>>> do not always have page fault capability, and yet these troublesome
>>> users insist on stacking their system full of DRAM and then pointing
>>> the accelerator to it.
>>>
>>> How would we choose a value? Memory sizes keep going up...
>>
>> The obvious answer is you let users decide. I did have a patch series to
>> do that via a cgroup[1]. However I dropped that series mostly because I
>> couldn't find any users of such a limit to provide feedback on how they
>> would use it or how they wanted it to work.
>>
> 
> Trawling through the discussion there, I see that Jason Gunthorpe mentioned:
> 
> "Things like VFIO & KVM use cases effectively pin 90% of all system memory"

The unusual thing is not the amount of system memory we are pinning but 
*how many* pages we try pinning in the single call.

If you stare at vfio_pin_pages_remote, we seem to be batching it.

long req_pages = min_t(long, npage, batch->capacity);

Which is

#define VFIO_BATCH_MAX_CAPACITY (PAGE_SIZE / sizeof(struct page *))


So you can fix this in your driver ;)


We should maybe try a similar limit internally: if you call 
pin_user_pages_remote() with a large number, we'll cap it at some magic 
value (similar to above). The caller will simply realize that not all 
pages were pinned and will retry.

See get_user_pages_remote(): "Returns either number of pages pinned 
(which may be less than the number requested), or an error. Details 
about the return value:"


Alternatively, I recall there was a way to avoid the temporary 
allocation ... let me hack up a prototype real quick.
-- 
Cheers,

David / dhildenb


