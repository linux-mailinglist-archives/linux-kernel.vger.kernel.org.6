Return-Path: <linux-kernel+bounces-390201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591FF9B76DD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA39E1F24BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6690A192D60;
	Thu, 31 Oct 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWFwRYjw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113A16E886
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364824; cv=none; b=MRCeIQAN60PUqIub9A6woqZNzYF55m4LV9l5dGCkGzcU1qWiO1K6Sxy7hpXoY6RHqKvRP/AkBktQ1hZ/5HK0udtoV9cHg5EDV/uaYVnkC3PSJHPPvXi17Sxop+THn8XCGVCtvLQeebmXrDUC2UIb/n3DIocYfvethTugg55UtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364824; c=relaxed/simple;
	bh=XsoMslqV22p9h+7CGlyZU6vjy3icU1d7l4S1wbB/IZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2djbqfwkVhECfJ+/ARep7g1xfH2PkAFT0cyNQd9C5nE/4lBkSVOPg5wVQuoyzZtBqsGW9GUr1M8I11VBZGjRTdkhrQooVFt0L+a7zcyotD9Yl/lyaGT2gEO6Mz74FR9Kt0HKosTwR/7wFqzgsMbK0f+sqj1tirj5PAjUo1E0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWFwRYjw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730364820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Lg0h0TNAjwILajmVYZWfY8RHcFnEvZOoaJgUcHscYU=;
	b=TWFwRYjwxy9yhlgrW5XqjajgHADYN4qkfwEqjojVw1L25fIOYRICwBF5C7JK4dCGQa+DPh
	dEmbQm+rsHpz6owrQer6JdYviZxFj0u79ny5NAjX7N9zdpgKc5T6NzfYoerrsuBA+dMF0f
	S3c2lyDxxbzcJSLI1JpCyXiVImBrEOY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-ZnmPRMNSOHCIfMnn9PM8Qg-1; Thu, 31 Oct 2024 04:53:39 -0400
X-MC-Unique: ZnmPRMNSOHCIfMnn9PM8Qg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4cf04bcfso322449f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364818; x=1730969618;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Lg0h0TNAjwILajmVYZWfY8RHcFnEvZOoaJgUcHscYU=;
        b=VghtG8m4AB7lf/N9wFVL+MsC34x+oa2++kj0oMSlYhBsf9turSwj7sf13n52OrKfq+
         d/0Ql/EvJVm5/YYY9YIEH1M0RXGP8seaWGOY69PAxjjgRCySZIfET8RSkxLBk3GvVYNs
         u55DKmUBkLFCKKDwZWKLWeWadYoRp7xtAKpLadVVlWYgCMxVArJfd2fHck5eD5Qlq2sz
         sJdj00ahXQKX17irJ0Ol3TWaHHgbH3jWft2dGvBRnIqEjbSCZz0C4grfzOproiK7VoJG
         5mDCP6OCg+jKXr9yV9ixDmqaANVVbS1IrygsCFFUZZL3JbM2C6ytfMSjWXhWgqRTrAyc
         ZumA==
X-Forwarded-Encrypted: i=1; AJvYcCVsCVuQxD2jDf3io60YnmtOJStw3bbGHryKgwWO2qt7qtOnDZQe/8nGa2NLv1fmbZ4OWmy5d5rasaC9xWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYzDI7TN+lqy/x7OGprq/2UYXoA3pPvirLTKCoBAenxpEyenP
	/7XKdm8LmbSSpACmIep7ThlRtwIhZYUx0YiBatPwa9ZxL/kd8EzO0Wca8N+0TwC0JEzcT8R3Rf9
	DR8xpPlNODJJBVQqrlunaL7xKYplZ7MpGeFNVfYJzEFM+7Oe8soxAar3Kw5mbXxxlnOiTLw==
X-Received: by 2002:a5d:4386:0:b0:374:ba23:4b3f with SMTP id ffacd0b85a97d-380610f81d8mr12611609f8f.9.1730364817923;
        Thu, 31 Oct 2024 01:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq40kvmbP3tMuVK3n60w+kqPUjugrFhFfbRB1MBIxc23nKupWD0owOti+3YiE99oEXNudv+w==
X-Received: by 2002:a5d:4386:0:b0:374:ba23:4b3f with SMTP id ffacd0b85a97d-380610f81d8mr12611579f8f.9.1730364817493;
        Thu, 31 Oct 2024 01:53:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d20sm1459459f8f.7.2024.10.31.01.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 01:53:36 -0700 (PDT)
Message-ID: <d758a4f4-e0e6-4a78-beb4-e513de229310@redhat.com>
Date: Thu, 31 Oct 2024 09:53:34 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0b7671fd-3fea-4086-8a85-fe063a62fa80@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>
>>> If we don't want to go with the shmem_enabled toggles, we should
>>> probably still extend the documentation to cover "all THP sizes", like
>>> we did elsewhere.
>>>
>>> huge=never: no THPs of any size
>>> huge=always: THPs of any size (fault/write/etc)
>>> huge=fadvise: like "always" but only with fadvise/madvise
>>> huge=within_size: like "fadvise" but respect i_size
>>
>> Thinking some more about that over the weekend, this is likely the way
>> to go, paired with conditionally changing the default to
>> always/within_size. I suggest a kconfig option for that.
> 
> I am still worried about adding a new kconfig option, which might
> complicate the tmpfs controls further.

Why exactly?

If we are changing a default similar to 
CONFIG_TRANSPARENT_HUGEPAGE_NEVER -> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS, 
it would make perfectly sense to give people building a kernel control 
over that.

If we want to support this feature in a distro kernel like RHEL we'll 
have to leave the default unmodified. Otherwise I see no way (excluding 
downstream-only hacks) to backport this into distro kernels.

> 
>> That should probably do as a first shot; I assume people will want more
>> control over which size to use, especially during page faults, but that
>> can likely be added later.

I know, it puts you in a bad position because there are different 
opinions floating around. But let's try to find something that is 
reasonable and still acceptable. And let's hope that Hugh will voice an 
opinion :D

> 
> After some discussions, I think the first step is to achieve two goals:
> 1) Try to make tmpfs use large folios like other file systems, that
> means we should avoid adding more complex control options (per Matthew).
> 2) Still need maintain compatibility with the 'huge=' mount option (per
> Kirill), as I also remembered we have customers who use
> 'huge=within_size' to allocate THPs for better performance.

> 
> Based on these considerations, my first step is to neither add a new
> 'huge=' option parameter nor introduce the mTHP interfaces control for
> tmpfs, but rather to change the default huge allocation behavior for
> tmpfs. That is to say, when 'huge=' option is not configured, we will
> allow the huge folios allocation based on the write size. As a result,
> the behavior of huge pages for tmpfs will change as follows:
 > > no 'huge=' set: can allocate any size huge folios based on write size
 > huge=never: no any size huge folios> huge=always: only PMD sized THP 
allocation as before
 > huge=fadvise: like "always" but only with fadvise/madvise> 
huge=within_size: like "fadvise" but respect i_size

I don't like that:

(a) there is no way to explicitly enable/name that new behavior.
(b) "always" etc. are only concerned about PMDs.


So again, I suggest:

huge=never: No THPs of any size
huge=always: THPs of any size
huge=fadvise: like "always" but only with fadvise/madvise 
huge=within_size: like "fadvise" but respect i_size

"huge=" default depends on a Kconfig option.

With that we:

(1) Maximize the cases where we will use large folios of any sizes
     (which Willy cares about).
(2) Have a way to disable them completely (which I care about).
(3) Allow distros to keep the default unchanged.

Likely, for now we will only try allocating PMD-sized THPs during page 
faults, and allocate different sizes only during write(). So the effect 
for many use cases (VMs, DBs) that primarily mmap() tmpfs files will be 
completely unchanged even with "huge=always".

It will get more tricky once we change that behavior as well, but that's 
something to likely figure out if it is a real problem at at different 
day :)


I really preferred using the sysfs toggles (as discussed with Hugh in 
the meeting back then), but I can also understand why we at least want 
to try making tmpfs behave more like other file systems. But I'm a bit 
more careful to not ignore the cases where it really isn't like any 
other file system.

If we start making PMD-sized THPs special in any non-configurable way, 
then we are effectively off *worse* than allowing to configure them 
properly. So if someone voices "but we want only PMD-sized" ones, the 
next one will say "but we only want cont-pte sized-ones" and then we 
should provide an option to control the actual sizes to use differently, 
in some way. But let's see if that is even required.

-- 
Cheers,

David / dhildenb


