Return-Path: <linux-kernel+bounces-244863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D492AA84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90E01C21BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEACB14B94E;
	Mon,  8 Jul 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxeJysLN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9D14AD10
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470290; cv=none; b=RqMy+wFHTDhwdbx7mUPvY4hJGsstAdCxNstXXcRcHH6wQLWe9jDlM+i/WRiQI2S1NpYs6sxjfHLH86EfZKXnHRxiw09bTqwkiTCblorXgzddZSOiaUHJQyB2rPipsppls6JJcNsDG6aEVGms5G5yVPPRrnqXYxIlBWZq+v+2YFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470290; c=relaxed/simple;
	bh=DppdVJ6HOkpwhGPmRQ7oC7TbNOWJTMIBSjLdDGj+7z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skzZJeV0fj2tb8Z4c8vBJ7Zt+Dz/fiGb1VuyaOeo3Nmo5619NCUx417vFDDDhMUhgivFPjWTC+FStgUTr97I1V18jAe+BunSPEFomwKEzTW92q9SwQl+HuAsW2Tf8Rm6xeOG5C9fMGh6IC1KkcFneSBP1EzyfKK/JsoINnl7dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxeJysLN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720470287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5lrPHwyauuV6pr43Cfd4z7YRagq9rK0f2SO3YfH1cf4=;
	b=DxeJysLN68PbT3rlUpLZphZ4YsKyEiCoJbiPrVd55k27LFMWWbGZl+kjoi75fFzJQppNA9
	mNhaC7ZBi2mZb+uYFsxXNe6WvMmj26pl+2fjPHWCm0IRtmugn5yu/wSlgpaOg5Yn1pr06v
	8bqLwV3RHoRJca2IJYnHEIdFv/nO660=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-36YMZNimP6yNUgNfph5W-w-1; Mon, 08 Jul 2024 16:24:46 -0400
X-MC-Unique: 36YMZNimP6yNUgNfph5W-w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee91034250so44494371fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720470284; x=1721075084;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5lrPHwyauuV6pr43Cfd4z7YRagq9rK0f2SO3YfH1cf4=;
        b=DolG8AIN4+NMmkyiEMKYwFp6VtQtStb19fxRcx3nKLbpDN20B9qI7KNfXO1oTbqN8K
         PngHatfnKVRDjCxdK+ckIjd1yhU4JKc9Nsu2dpn0z6c+09gxY7q9w711eUGvqUr1tpsr
         BV8x0q3HGR+S/LX4W7njBeVACa3Jwob7gjW1aWyExfliKfm1w94rK/AgSkPIOkModzjJ
         OzgJrIiY4wyWes7Q6ZOE1DTb/U55n6GFcmxggEh62lfaGvDWIZy/DApyBcZh2BgECMhH
         L92NPASAdP+50/VdyddMaLz1M7MIVE5P1C4ZSfjl8ONPL1xU6Qfr1YBgdL5V869CGvQZ
         kWhw==
X-Gm-Message-State: AOJu0YyqluTpPav8nj1SbAfKpytYKdXO1HaP/EmKjA3a1miQfvXwPuTy
	MNGfOncnt+N275jPDohHazZTdwVYf5vWswwi9kpRq4daBZ/cC9Ne05VgWQ9wUJDyftdRCfG2dmx
	+SAQOyBPemves+HM4bZDdY4i9uJxpK/28wbDhODEWlk2dJblYCY4br8UE4mY2+A==
X-Received: by 2002:a2e:b059:0:b0:2ec:403e:6314 with SMTP id 38308e7fff4ca-2eeb30b9a43mr4936201fa.3.1720470283976;
        Mon, 08 Jul 2024 13:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRrAzQbErbhkrGL4rkflQ5leI4Xw3w9Tf7aOOTOJIPQC+kFSRUnaVdwMlLofasln3E3v24tw==
X-Received: by 2002:a2e:b059:0:b0:2ec:403e:6314 with SMTP id 38308e7fff4ca-2eeb30b9a43mr4936001fa.3.1720470283472;
        Mon, 08 Jul 2024 13:24:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:2200:bad7:95bd:e25e:a9e? (p200300cbc7442200bad795bde25e0a9e.dip0.t-ipconnect.de. [2003:cb:c744:2200:bad7:95bd:e25e:a9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266c859e5bsm38403655e9.9.2024.07.08.13.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 13:24:43 -0700 (PDT)
Message-ID: <36883da6-a492-4f17-8b55-fa08ca33fa74@redhat.com>
Date: Mon, 8 Jul 2024 22:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
 x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <ZotE3-VwI0SJlM6w@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZotE3-VwI0SJlM6w@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 03:46, Jason A. Donenfeld wrote:
> Hi David,

Hi Jason,

just catching up on mails here. Most of the stuff is now clear from the 
other subthread.

[...]

>>> @@ -1851,7 +1858,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>    				 * discarded. Remap the page to page table.
>>>    				 */
>>>    				set_pte_at(mm, address, pvmw.pte, pteval);
>>> -				folio_set_swapbacked(folio);
>>> +				/* Unlike MADV_FREE mappings, VM_DROPPABLE ones
>>> +				 * never get swap backed on failure to drop. */
>>> +				if (!(vma->vm_flags & VM_DROPPABLE))
>>> +					folio_set_swapbacked(folio);
>>>    				ret = false;
>>>    				page_vma_mapped_walk_done(&pvmw);
>>>    				break;
>>
>> A note that in mm/mm-stable, "madvise_free_huge_pmd" exists to optimize
>> MADV_FREE on PMDs. I suspect we'd want to extend that one as well for
>> dropping support, but likely it would also only be a performance
>> improvmeent and not affect functonality if not handled.
> 
> That's for doing the freeing of PTEs after the fact, right? If the
> mapping was created, got filled with some data, and then sometime later
> it got MADV_FREE'd, which is the pattern people follow typically with
> MADV_FREE. If we do this as PROT_/MAP_, then that's not a case we need
> to worry about, if I understand this code correctly.

We essentially now have code to handle PMD-mapped THP: instead of first 
remapping them using PTEs to then unmap+discard via 512 PTEs (due to 
MADV_FREE being set on the folio), we can now simply unmap+discard a 
single PMD. So performance wise, this might be interesting for this 
mechanism as well (when used in combination with THP).

-- 
Cheers,

David / dhildenb


