Return-Path: <linux-kernel+bounces-384572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A89B2BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6BD282A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7691CC88B;
	Mon, 28 Oct 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iah17rPK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E811B4C23
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108932; cv=none; b=X5Wn77cJqSxYRXCogWD/S6E5pl8x/Ak3FSBHVEYtksrglHoslJFP2/1flphRVy9NK9P+j0+cMeIdhPbBOXy4rB844+KOfJVHvAt+8td6ne1zbCKk+5L1tik47CviTbCIqTDNT3WgpKCuH/pt4f3DmH01JoBL0IqQ5bwDbVhTHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108932; c=relaxed/simple;
	bh=FQj3S1PJRVwAsgeE2gJ/qqEKLhrs9AAygGNJaqvKB7I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=exSsb56hvolcnaWAkmFzvaCRN/OE+kAXvYQBJqmdxHU58RVutN1FSJGHgKKhFP9AU9LXnZqY1NnaeX2i+po151k+gDQHE5q4eiIDy+NDHiXiVPa7GbXUcrYlsVjJ3noVc7mIRJsuVTQInSR5+45kQHn5VNRki+3v1FLuu6K9XxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iah17rPK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730108929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b5zLY75SeOz+vX8IBwgnxl+5DpkitlpkKm4uVYKjbxE=;
	b=Iah17rPK14HMkXTqgYiCvcLaLOFIztj2rlbyqjhG8+sEyZYKmxcrLhIV5/sqzCDZgTioH+
	6cb87AFqsSeYS6wjIrUNIDbeeQX5xEqeMpNMc6/cXcHZ99mAYDZAJxfoIYI6EGpCzeSDaE
	s4UIxFBmj5ELs7GEqi05M/0uTBbkhCE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-zQjqgT11NOuMJHuOfpM3EA-1; Mon, 28 Oct 2024 05:48:47 -0400
X-MC-Unique: zQjqgT11NOuMJHuOfpM3EA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4cf04be1so1979040f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730108926; x=1730713726;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b5zLY75SeOz+vX8IBwgnxl+5DpkitlpkKm4uVYKjbxE=;
        b=m0XRDrTV1ky/JdBMaFt/3NqR53gZK/G/sHkMGY92/9rsKkQngZX470HdvrFRGCfi4u
         vwZ+M0Ji+2aCR4dlUVVCJp792aLtxaBJoQFpNRfQHoPtG6NBJT7y4z8K8v5VmQFY9pad
         bva8+XqRVN2d0QyQcCEqfFlucLv+Iu2+FhQ+vxBsOIrvjV+pLulvJHi9DuGeaFPjJ39H
         IvcbxJE9mopOUeVpDRJDKEm45y0QstK8rb2pFobVlqJGGkUABkpq1+liLiVhPuZj7PnM
         9ldl8T9ymLYJzOdhYTHlhm9Kl4JlLkZsO0ZYJ6DtFhUiYHVXgdrLMGztVV9b7M86qePD
         8Ebg==
X-Forwarded-Encrypted: i=1; AJvYcCUfzIFwghD2ZfMa4D8Nz5YI3AdAvWe+87Y+FlYB9JhsUFOXMJj1txJcB6eX2eItwocDSYkfCHdJWIyPTHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPjWhOfXlWeEpHEer64PJSn7SyLJnQiQFkSpMpcMkwqBT63bG
	dYcm+9yVvSMjDDhBMe2XhjhO7kwYXR5aKD+eVIL6CoAir2pfiRe2tQqIdACIzDJ5HFyN/F+Aeth
	zaPMdhDV+bVlzp0zR511cvNVC2/auI8vXjdF8ptJvTY1VfT3sWe6aw94ifs74pw==
X-Received: by 2002:adf:a1cc:0:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-380611433f5mr5483869f8f.20.1730108926665;
        Mon, 28 Oct 2024 02:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOt2n+dP8wK3WpU/VMjWv2ws7V43qjZ5csjHr+yOUQkp8x86ZkMd987pqwf747f7iip4oIzA==
X-Received: by 2002:adf:a1cc:0:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-380611433f5mr5483853f8f.20.1730108926218;
        Mon, 28 Oct 2024 02:48:46 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47946sm9029551f8f.47.2024.10.28.02.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 02:48:45 -0700 (PDT)
Message-ID: <7ca333ba-f9bc-4f78-8f5b-1035ca91c2d5@redhat.com>
Date: Mon, 28 Oct 2024 10:48:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
From: David Hildenbrand <david@redhat.com>
To: Daniel Gomez <d@kruces.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
 <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
 <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
 <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
 <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.10.24 22:21, David Hildenbrand wrote:
> Sorry for the late reply!
> 
>>>>>> IMHO, as I discussed with Kirill, we still need maintain compatibility
>>>>>> with the 'huge=' mount option. This means that if 'huge=never' is set
>>>>>> for tmpfs, huge page allocation will still be prohibited (which can
>>>>>> address Hugh's request?). However, if 'huge=' is not set, we can
>>>>>> allocate large folios based on the write size.
>>
>> So, in order to make tmpfs behave like other filesystems, we need to
>> allocate large folios by default. Not setting 'huge=' is the same as
>> setting it to 'huge=never' as per documentation. But 'huge=' is meant to
>> control THP, not large folios, so it should not have a conflict here, or
>> else, what case are you thinking?
> 
> I think we really have to move away from "huge/thp == PMD", that's a
> historical artifact. Everything else will simply be inconsistent and
> confusing in the future -- and I don't see any real need for that. For
> anonymous memory and anon shmem we managed the transition. (there is a
> longer writeup from me about this topic, so I won't go into detail).
> 
> 
> I think I raised this in the past, but tmpfs/shmem is just like any
> other file system .. except it sometimes really isn't and behaves much
> more like (swappable) anonymous memory. (or mlocked files)
> 
> There are many systems out there that run without swap enabled, or with
> extremely minimal swap (IIRC until recently kubernetes was completely
> incompatible with swapping). Swap can even be disabled today for shmem
> using a mount option.
> 
> That's a big difference to all other file systems where you are
> guaranteed to have backend storage where you can simply evict under
> memory pressure (might temporarily fail, of course).
> 
> I *think* that's the reason why we have the "huge=" parameter that also
> controls the THP allocations during page faults (IOW possible memory
> over-allocation). Maybe also because it was a new feature, and we only
> had a single THP size.
> 
> There is, of course also the "fallocate() might not free up memory if
> there is an unexpected reference on the page because splitting it will
> fail" problem, that even exists when not over-allocating memory in the
> first place ...
> 
> 
> So ...I don't think tmpfs behaves like other file system in some cases.
> And I don't think ignoring these points is a good idea.
> 
> Fortunately I don't maintain that code :)
> 
> 
> If we don't want to go with the shmem_enabled toggles, we should
> probably still extend the documentation to cover "all THP sizes", like
> we did elsewhere.
> 
> huge=never: no THPs of any size
> huge=always: THPs of any size (fault/write/etc)
> huge=fadvise: like "always" but only with fadvise/madvise
> huge=within_size: like "fadvise" but respect i_size

Thinking some more about that over the weekend, this is likely the way 
to go, paired with conditionally changing the default to 
always/within_size. I suggest a kconfig option for that.

That should probably do as a first shot; I assume people will want more 
control over which size to use, especially during page faults, but that 
can likely be added later.

-- 
Cheers,

David / dhildenb


