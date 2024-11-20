Return-Path: <linux-kernel+bounces-415800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E589D3CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900E51F227AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CAE1AA7A6;
	Wed, 20 Nov 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdExN8HH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA61A7262
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110380; cv=none; b=mNDNSfHMajoWrOoLQ4jYlyLu2rBBHVqhQYRHWcYhKx74Nr6YZWw2rl1vz8A4PI36qFMwMj3dAGFF0dyw92m+4t33Y07fVDfHZzQsNTPlAXodEXzAzCx9CI6is2UtFXT90XgWMHjdMdDn3/c5CeVjZMvHiJn939Jz5b+LwsPd9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110380; c=relaxed/simple;
	bh=4vqg4VuazgJsGpOh72wwxCJ9PCnIDe9vWowNOrd/uX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDetuJmpWLjp8mNvsYSSTaDp8/ghKZ7mPhKArCexyihGmsYmEEn00J1pCvm7ub5Tc1wH6Ga/M0YXoPzNLFpWT+WVLPcqxNmOBAQp4qQZWA7nyylellhcDN0lLRD/vhrdS5AZVU86Fy2slKP6exUWq+Wiw0UXPaa4E8EWFbZ2h9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdExN8HH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732110375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1Ri4tZOAJYW8pxNO/lLGuZP6CvXZw9/dNjDLAj8UJrY=;
	b=TdExN8HHro5k4uoyMjM9Z7duE/dDCgcSLBmlvhHceDRGIwBV4Cx2akNB8uaWMMbyNYxQpi
	7bT1mjssX2BtoBn9QgvOTF9Ywoxdc0Q9FgptmOXzzVAVVZYhABQNJK5/IzcupWBHOr6FsD
	sd+y2UWSIGe+v5qL+f42EU6jqGnZhI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-fKEX1J9VM8iB1nVU5NmpkQ-1; Wed, 20 Nov 2024 08:46:14 -0500
X-MC-Unique: fKEX1J9VM8iB1nVU5NmpkQ-1
X-Mimecast-MFC-AGG-ID: fKEX1J9VM8iB1nVU5NmpkQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431604a3b47so16034615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732110373; x=1732715173;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Ri4tZOAJYW8pxNO/lLGuZP6CvXZw9/dNjDLAj8UJrY=;
        b=TZ9idtjnsAbmJolRGJFxv3yqfGgsLEjo/4awte1Ey12vM45f+oQOThg3W9LDHUnJlj
         w8SIPwD1lZuGZfdzKaA0gB+Ry3mXoE5EMmtsw+nc9DOVDHZ9uhRyBZJnnA76dJhacmPr
         U1c5CWIo8qJv+SYma2L8Tx1L62NEMBR/Bf8fwlcyoAlrtzl90Yt985rrnDmMb2m3O+KX
         TEv0k/hDx9LiJd8NZNsmEB91khbqtLpIrINHaF03KbzDNrVyFm8Wxwg57X2P2rYKN3gX
         QMrX0lh+sp8YetOq2VPmP/o0adxbeiEO6rs5Y771D+SdrpeZmMdb+THW/zc7p8p4sS0h
         Ud8w==
X-Forwarded-Encrypted: i=1; AJvYcCV5Lpebp/KE0tF/69ctw7+tZ9fzehDu+JcCbwz5oQg2mxU44DwO8Mwiere5tTJSomz8nU/yMmTAUzexQDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCs2DLDne3zZXVnANfy9/MxUJRO6hqwtqgLjHYLC/r3dnThoVl
	0JAMc4URhzys69IBMTJkwW7+XUVlfDnXU79spSO8roid5AEqRllJk2jfkdwUmaXwnj7sq3IzyKW
	sX3Sc0Qd9ONmxKsEuhq4ZGCdjShFQKC3MGm0oQ0UzRrdwDk+nqR1NTDrA1rOftA==
X-Received: by 2002:a05:600c:3acf:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-433489b3175mr28483155e9.10.1732110373440;
        Wed, 20 Nov 2024 05:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL5FpbLSyV/3P5T72T2TQsBaP3zsjUQ/jI6Vn8ySj88Akn5ETssrgK561qvkmcpcXgwTclhA==
X-Received: by 2002:a05:600c:3acf:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-433489b3175mr28482955e9.10.1732110373061;
        Wed, 20 Nov 2024 05:46:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46426d7sm19481465e9.36.2024.11.20.05.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 05:46:11 -0800 (PST)
Message-ID: <01b0a528-bec0-41d7-80f6-8afe213bd56b@redhat.com>
Date: Wed, 20 Nov 2024 14:46:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] KVM: ioctl for populating guest_memfd
To: kalyazin@amazon.com, pbonzini@redhat.com, corbet@lwn.net,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jthoughton@google.com, brijesh.singh@amd.com, michael.roth@amd.com,
 graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
 nsaenz@amazon.es, xmarcalx@amazon.com,
 Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org
References: <20241024095429.54052-1-kalyazin@amazon.com>
 <08aeaf6e-dc89-413a-86a6-b9772c9b2faf@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <08aeaf6e-dc89-413a-86a6-b9772c9b2faf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 13:09, Nikita Kalyazin wrote:
> On 24/10/2024 10:54, Nikita Kalyazin wrote:
>> [2] proposes an alternative to
>> UserfaultFD for intercepting stage-2 faults, while this series
>> conceptually compliments it with the ability to populate guest memory
>> backed by guest_memfd for `KVM_X86_SW_PROTECTED_VM` VMs.
> 
> +David
> +Sean
> +mm

Hi!

> 
> While measuring memory population performance of guest_memfd using this
> series, I noticed that guest_memfd population takes longer than my
> baseline, which is filling anonymous private memory via UFFDIO_COPY.
> 
> I am using x86_64 for my measurements and 3 GiB memory region:
>    - anon/private UFFDIO_COPY:  940 ms
>    - guest_memfd:              1371 ms (+46%)
> 
> It turns out that the effect is observable not only for guest_memfd, but
> also for any type of shared memory, eg memfd or anonymous memory mapped
> as shared.
 > Below are measurements of a plain mmap(MAP_POPULATE) operation:>
> mmap(NULL, 3ll * (1 << 30), PROT_READ | PROT_WRITE, MAP_PRIVATE |
> MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
>    vs
> mmap(NULL, 3ll * (1 << 30), PROT_READ | PROT_WRITE, MAP_SHARED |
> MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> 
> Results:
>    - MAP_PRIVATE: 968 ms
>    - MAP_SHARED: 1646 ms

At least here it is expected to some degree: as soon as the page cache 
is involved map/unmap gets slower, because we are effectively 
maintaining two datastructures (page tables + page cache) instead of 
only a single one (page cache)

Can you make sure that THP/large folios don't interfere in your 
experiments (e.g., madvise(MADV_NOHUGEPAGE))?

> 
> I am seeing this effect on a range of kernels. The oldest I used was
> 5.10, the newest is the current kvm-next (for-linus-2590-gd96c77bd4eeb).
> 
> When profiling with perf, I observe the following hottest operations
> (kvm-next). Attaching full distributions at the end of the email.
> 
> MAP_PRIVATE:
> - 19.72% clear_page_erms, rep stos %al,%es:(%rdi)
> 
> MAP_SHARED:
> - 43.94% shmem_get_folio_gfp, lock orb $0x8,(%rdi), which is atomic
> setting of the PG_uptodate bit
> - 10.98% clear_page_erms, rep stos %al,%es:(%rdi)

Interesting.
> 
> Note that MAP_PRIVATE/do_anonymous_page calls __folio_mark_uptodate that
> sets the PG_uptodate bit regularly.
> , while MAP_SHARED/shmem_get_folio_gfp calls folio_mark_uptodate that
> sets the PG_uptodate bit atomically.
> 
> While this logic is intuitive, its performance effect is more
> significant that I would expect.

Yes. How much of the performance difference would remain if you hack out 
the atomic op just to play with it? I suspect there will still be some 
difference.

> 
> The questions are:
>    - Is this a well-known behaviour?
>    - Is there a way to mitigate that, ie make shared memory (including
> guest_memfd) population faster/comparable to private memory?

Likely. But your experiment measures above something different than what 
guest_memfd vs. anon does: guest_memfd doesn't update page tables, so I 
would assume guest_memfd will be faster than MAP_POPULATE.

How do you end up allocating memory for guest_memfd? Using simple 
fallocate()?

Note that we might improve allocation times with guest_memfd when 
allocating larger folios.

-- 
Cheers,

David / dhildenb


