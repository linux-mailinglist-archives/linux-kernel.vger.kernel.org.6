Return-Path: <linux-kernel+bounces-289411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A29545EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A5D1F21C52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A915B10B;
	Fri, 16 Aug 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5I32cn7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812920E3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801339; cv=none; b=oP+0IuysSSyltp9GOZnzpxAA/WH508uiwj/FdiExiRFo0cTg2PH9sGspcsz7zoodmRlxLN4JUwbLzSdbaL2MfKY6+D8l6aiSm92y2DObKbu5/bHikJgOw2iCVRWVwaaPyQu9PryhamPPQIQ9xgjvXBlKxwmJwhqyguB184fm734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801339; c=relaxed/simple;
	bh=CZZdEV6I7a5s3CfarmffbXJLz/hQqaPJ0Il5QE56wBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEj0UMhvg2j3XAYVVQqotzlB15zjzfm6oaECK+Hjw4Jaak1H7P4hMo6CbMUBS8JacibP/g+Uga0edGCo1moH86TnGEa/30LKeqiFYN3OuMroYiEYQzDCpLIclZb8Cd39Sp5vlwDX11lOF0I6bUqsq2ZQvP/LREzcFEghbOql4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5I32cn7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723801336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iDbGni+AICH8WcFwiNsWuPFYBceEDQ7R5rTDBHM9GH0=;
	b=Z5I32cn7OVw5TBRiA4Fft1WhHi6eKEICRiNyotpmKuvlyH+cQAbLrtlejOccTVHIK56ORN
	oeEWpt5gR/ip0oBoHL4Ry+vGJgX/cZ9h6Edn+xwkgaxqw/7wiAt6azwi9cAW9+Y0Tb4m2u
	WaqxB3wM2CYi9w3NPiIRyLbN6dfk4Sk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-h98MRho3NbuURbNxruUtyQ-1; Fri, 16 Aug 2024 05:42:15 -0400
X-MC-Unique: h98MRho3NbuURbNxruUtyQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52eff5a4faaso1902879e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801333; x=1724406133;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDbGni+AICH8WcFwiNsWuPFYBceEDQ7R5rTDBHM9GH0=;
        b=WZ01bcEmv+i0bjdgiw9N19KBl3UtIguVMkwbNx1DhCm5HlMBWHpqk8XNapNoOZa1lf
         KGHPlDZIumsqz7orfT6JxnSVTDkNg6DdztAxfzgxS2mH2kix3votwoAsy5swGeZB0DZu
         1gI8iNjvmEKZsHwr657SivhVkKdGg524wBwAZdzeU9PvXrHhjnU1s+vTU2EiLdsMcjo+
         5Ezty6oL3owOHvNN0I9APscxZoqg+kTCc0GaN94Bt0h5ptDtRLkkrEg/y1JRWk0Zb4x8
         FWT2hOeMkl2bgwdRehpE8KZ88aQtEpfPFOhQUYFy9tYc8phwjAUESoLv/5md9bsvU57N
         zStA==
X-Forwarded-Encrypted: i=1; AJvYcCWnDTHnmaDr6YFdISKWlbpSO1oF7z6Ye9YAdF2z37/iaORwkEWIyTPCJU6YH5gaA07VuR69EbQ3kGRae4tr0AEsmcXGOs5k93rxJsFr
X-Gm-Message-State: AOJu0Yy6HpyHI5WvEIa0D0BxYItcgXhc4QM/A+CPlXdmgNJ6PdGK7nom
	BsvOWSXWAeHTM6I2jkZn1+7JtkpLhJgAY3R8IpSuA6ZJ08YE2Rddeu8n6uZ6KBhpkPMbpzlK+Q1
	zE7N3Nb0txnJRP/HgvbWJLNOGl1Jy/ZUcbyLjoG79h5mXJ2PiPNb2w1cdudur6B6/j8RuXo+h
X-Received: by 2002:a05:6512:398a:b0:530:daeb:c1d4 with SMTP id 2adb3069b0e04-5331c695a78mr1622752e87.12.1723801333425;
        Fri, 16 Aug 2024 02:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtn2lUxMzuo7TtIrcRyAOSd0mCAR9RHZwhUlwpakmJeIkWkzTCjHEQwewDmJgujP2Zvct9Mw==
X-Received: by 2002:a05:6512:398a:b0:530:daeb:c1d4 with SMTP id 2adb3069b0e04-5331c695a78mr1622737e87.12.1723801332888;
        Fri, 16 Aug 2024 02:42:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897128sm3241100f8f.81.2024.08.16.02.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:42:12 -0700 (PDT)
Message-ID: <3962fe91-4af1-4a85-80a9-b89826d31274@redhat.com>
Date: Fri, 16 Aug 2024 11:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/kaslr: Expose and use the end of the physical memory address
 space
To: Thomas Gleixner <tglx@linutronix.de>, Alistair Popple <apopple@nvidia.com>
Cc: x86@kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 max8rr8@gmail.com, linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linuxfoundation.org>,
 Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx> <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal> <87sev8rfyx.ffs@tglx>
 <87le10p3ak.ffs@tglx> <87ed6soy3z.ffs@tglx>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87ed6soy3z.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> MAX_PHYSMEM_BITS cannot be changed for that because the randomization
> does not align with address bit boundaries and there are other places
> which actually require to know the maximum number of address bits.  All
> remaining usage sites of MAX_PHYSMEM_BITS have been analyzed and found
> to be correct.
> 

Hi Thomas,

> Cure this by exposing the end of the direct map via PHYSMEM_END and use
> that for the memory hot-plug and resource management related places
> instead of relying on MAX_PHYSMEM_BITS. In the KASLR case PHYSMEM_END
> maps to a variable which is initialized by the KASLR initialization and
> otherwise it is based on MAX_PHYSMEM_BITS as before.

Skimming this patch, I got confused why physmem_end is introduced.

I can see a single modification of physmem_end:

	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);


Which is exactly the same as

	#ifndef PHYSMEM_END
	# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
	#endif

And that left me confused why that is required. So we can catch the 
transition "physmem_end == 0" -> "physmem_end != 0"?


I'm probably missing something important, so sorry for the (likely) 
stupid question.


Apart from that, nothing jumped at me.

-- 
Cheers,

David / dhildenb


