Return-Path: <linux-kernel+bounces-390368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795DD9B78F3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39AB1F2501A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A99199FA5;
	Thu, 31 Oct 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjUbOvcQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29F14659B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371590; cv=none; b=fqswMnv1kCvREsHxJaWPqktDFkzPdH2FJWJQiec5282A5BcJb9h7oZTj3mNcvQhbeixFziXeAV8daXfxciIFhlOA00ieJavKDz2dTkEzg1m+FWGeNv/+dAAflJHU5fTzn55HYA/3wpxw3ED10vICVxRtzpLR8U6JQ5BeWV18mmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371590; c=relaxed/simple;
	bh=0t5nX2lEOyoZ5TIGfXAXcSS67NlNo26U/WpyNgHsobM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6C2dgpcYJdatk4+/BYRsnt0TZJviy72rMlYWNuZb4nC/Uj2paqTQ4wTtcpH9iYR0Kq3qtGlsGUiEs0dwSVpgMylMektvHlq8NWBxUuxJXBvZT9U54eXv6OAQd61MCn8aCEodGVGoHNk32aYslE6k5sgo31k4qmyUpCzE5VlEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjUbOvcQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730371586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/12baxoYTr2A/fkL+wrCyqw4E5vERnXsiTEdH8JVRp0=;
	b=FjUbOvcQC6ULmT4tdjugsi7+ztJFY4zQ49zs6Ycj/AeVlUcHarFsSPdoOvAOpB/JmYugGG
	hqzlg2YSM3kbZ57sgG3/tZR8U8qD6+ftzIv/bEaj0tn+4KphTxbNVkUVUXd8fR43FjQEZO
	+Id8TyTQtIDNz+vJUTJQLT/SQLIjtec=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-UWsas_crN9u1vmVLQg_3Nw-1; Thu, 31 Oct 2024 06:46:24 -0400
X-MC-Unique: UWsas_crN9u1vmVLQg_3Nw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d59ad50f3so364687f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371584; x=1730976384;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/12baxoYTr2A/fkL+wrCyqw4E5vERnXsiTEdH8JVRp0=;
        b=i+DbtTZoVTAjCs0Uj2O5Mc2jfSCHPhttJSGQXJTQxTSa/llXbGr2uSbp/G6weT9PQA
         38BVIWy9DgZYJcHSEBk3qYiM4iXtPryw1wD98ZWqWjtqAiLF51y4N78cVeANULEUv25s
         3XzINzdTLbktSfYBYYf3sC0UcWgy5/X8KcSb1bitWuXj6HMB5LbTPl8nLNvPTnLUr0V/
         LF3uYBIqBOillDzzkVnMh9Y8q7rXbctWC8PLsWoNF7xg9mhpHk8B0Yxw+FIHWbbiTWjo
         Y8AA9bFFWqv8ufBTMypbRXLYb/72OlYFMV4RgAHcNxp6qCs2h3rdYANIv1Imn22UvTiR
         aaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5DctcPs/5JFmstv6RGHDLpwhJkLCwUq4ESB37kvE/h2gvfe3EmZOV0km5KXzFxgUvu0OkPtc1qTG3Kzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeHKbp2F1c0z/rpQglrhWn3W2QRpdRqRPSiaN6yz3diy1i6dX
	MnKau70vbO6M0LEALTi3yhuQ3Tc+lKm9vOiKIvE6Q8KFM4lFeBSf07xAPy5BLdhFBb3XaYfErTh
	wsrpCFdsZmaUwXO+tjn3OFA63XvdVX5BPx0S4QlYvkdEiLkXvaQAyscZrHtj9Sg==
X-Received: by 2002:adf:e04d:0:b0:37d:523c:5ce2 with SMTP id ffacd0b85a97d-380610f7e4fmr13921200f8f.1.1730371583590;
        Thu, 31 Oct 2024 03:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe8FxFQDzKmgOJKJGfyFQ8Pk8lgquDCLSFp61Sa4Yxu7ZUtnhfTat9A6nO3u9gxsLkvcKk2A==
X-Received: by 2002:adf:e04d:0:b0:37d:523c:5ce2 with SMTP id ffacd0b85a97d-380610f7e4fmr13921179f8f.1.1730371583203;
        Thu, 31 Oct 2024 03:46:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b80sm1787899f8f.10.2024.10.31.03.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:46:22 -0700 (PDT)
Message-ID: <99a3cc07-bdc3-48e2-ab5c-6f4de1bd2e7b@redhat.com>
Date: Thu, 31 Oct 2024 11:46:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Daniel Gomez <d@kruces.com>,
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
 <7ca333ba-f9bc-4f78-8f5b-1035ca91c2d5@redhat.com>
 <0b7671fd-3fea-4086-8a85-fe063a62fa80@linux.alibaba.com>
 <d758a4f4-e0e6-4a78-beb4-e513de229310@redhat.com>
 <2782890e-09dc-46bd-ab86-1f8974c7eb7a@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2782890e-09dc-46bd-ab86-1f8974c7eb7a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> I am still worried about adding a new kconfig option, which might
>>> complicate the tmpfs controls further.
>>
>> Why exactly?
> 
> There will be more options to control huge pages allocation for tmpfs,
> which may confuse users and make life harder? Yes, we can add some
> documentation, but I'm still a bit cautious about this.

If it's just "changing the default from "huge=never" to "huge=X" I don't 
see a big problem here. Again, we already do that for anon THPs.

If we make more behavior depend on than (which I don't think we should 
be doing), I agree that it would be more controversial.

[..]

>>>
>>>> That should probably do as a first shot; I assume people will want more
>>>> control over which size to use, especially during page faults, but that
>>>> can likely be added later.
>>
>> I know, it puts you in a bad position because there are different
>> opinions floating around. But let's try to find something that is
>> reasonable and still acceptable. And let's hope that Hugh will voice an
>> opinion :D
> 
> Yes, I am also waiting to see if Hugh has any inputs :)

We keep saying that ... I have to find a way to summon him :)

> 
>>> After some discussions, I think the first step is to achieve two goals:
>>> 1) Try to make tmpfs use large folios like other file systems, that
>>> means we should avoid adding more complex control options (per Matthew).
>>> 2) Still need maintain compatibility with the 'huge=' mount option (per
>>> Kirill), as I also remembered we have customers who use
>>> 'huge=within_size' to allocate THPs for better performance.
>>
>>>
>>> Based on these considerations, my first step is to neither add a new
>>> 'huge=' option parameter nor introduce the mTHP interfaces control for
>>> tmpfs, but rather to change the default huge allocation behavior for
>>> tmpfs. That is to say, when 'huge=' option is not configured, we will
>>> allow the huge folios allocation based on the write size. As a result,
>>> the behavior of huge pages for tmpfs will change as follows:
>>   > > no 'huge=' set: can allocate any size huge folios based on write size
>>   > huge=never: no any size huge folios> huge=always: only PMD sized THP
>> allocation as before
>>   > huge=fadvise: like "always" but only with fadvise/madvise>
>> huge=within_size: like "fadvise" but respect i_size
>>
>> I don't like that:
>>
>> (a) there is no way to explicitly enable/name that new behavior.
> 
> But this is similar to other file systems that enable large folios
> (setting mapping_set_large_folios()), and I haven't seen any other file
> systems supporting large folios requiring a new Kconfig. Maybe tmpfs is
> a bit special?

I'm afraid I don't have the energy to explain once more why I think 
tmpfs is not just like any other file system in some cases.

And distributions are rather careful when it comes to something like 
this ...

> 
> If we all agree that tmpfs is a bit special when using huge pages, then
> fine, a Kconfig option might be needed.
> 
>> (b) "always" etc. are only concerned about PMDs.
> 
> Yes, currently maintain the same semantics as before, in case users
> still expect THPs.

Again, I don't think that is a reasonable approach to make PMD-sized 
ones special here. It will all get seriously confusing and inconsistent.

THPs are opportunistic after all, and page fault behavior will remain 
unchanged (PMD-sized) for now. And even if we support other sizes during 
page faults, we'd like start with the largest size (PMD-size) first, and 
it likely might just all work better than before.

Happy to learn where this really makes a difference.

Of course, if you change the default behavior (which you are planning), 
it's ... a changed default.

If there are reasons to have more tunables regarding the sizes to use, 
then it should not be limited to PMD-size.

 > >> So again, I suggest:
>>
>> huge=never: No THPs of any size
>> huge=always: THPs of any size
>> huge=fadvise: like "always" but only with fadvise/madvise
>> huge=within_size: like "fadvise" but respect i_size
>>
>> "huge=" default depends on a Kconfig option.
>>
>> With that we:
>>
>> (1) Maximize the cases where we will use large folios of any sizes
>>       (which Willy cares about).
>> (2) Have a way to disable them completely (which I care about).
>> (3) Allow distros to keep the default unchanged.
>>
>> Likely, for now we will only try allocating PMD-sized THPs during page
>> faults, and allocate different sizes only during write(). So the effect
>> for many use cases (VMs, DBs) that primarily mmap() tmpfs files will be
>> completely unchanged even with "huge=always".
>>
>> It will get more tricky once we change that behavior as well, but that's
>> something to likely figure out if it is a real problem at at different
>> day :)
>>
>>
>> I really preferred using the sysfs toggles (as discussed with Hugh in
>> the meeting back then), but I can also understand why we at least want
>> to try making tmpfs behave more like other file systems. But I'm a bit
>> more careful to not ignore the cases where it really isn't like any
>> other file system.
> 
> That's also my previous thought, but Matthew is strongly against that.
> Let's step by step.

Yes, I understand his view as well.

But I won't blindly agree to the "tmpfs is just like any other file 
system" opinion :)

 > >> If we start making PMD-sized THPs special in any non-configurable way,
>> then we are effectively off *worse* than allowing to configure them
>> properly. So if someone voices "but we want only PMD-sized" ones, the
>> next one will say "but we only want cont-pte sized-ones" and then we
>> should provide an option to control the actual sizes to use differently,
>> in some way. But let's see if that is even required.
> 
> Yes, I agree. So what I am thinking is, the 'huge=' option should be
> gradually deprecated in the future and eventually tmpfs can allocate any
> size large folios as default.

Let's be realistic, it won't get removed any time soon. ;)

So changing "huge=always" etc. semantics to reflect our new size 
options, and then try changing the default (with the option for 
people/distros to have the old default) is a reasonable approach, at 
least to me.

I'm trying to stay open-minded here, but the proposal I heard so far is 
not particularly appealing.

-- 
Cheers,

David / dhildenb


