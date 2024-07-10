Return-Path: <linux-kernel+bounces-248247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7C592DA93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53D51F24615
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C512C465;
	Wed, 10 Jul 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwPKPkkX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715F2B9DD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645953; cv=none; b=Zq6rJSQ86M77gdlTjocPn54nZNgcFawFrnsrtFg3cqa1bCc/47w8PH1Oxd20t0q7niKUnGx1+Vb+Om9y5nGq3fcedSGxir7YF1n6CyRlWHvjOh+JZOPtwfy8Fqe9vRnVj99MojOfEei/atpSwN/N9cvdWYEPRAfJz8GmOk7tCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645953; c=relaxed/simple;
	bh=6EeH1cJP/4uBnJzT45MjbNsMaiqVa1P7qj5lwBSrZ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEjTDYks1Kish7p4rxenMA5IINONXL+Zsl/QM/ykpcrsF3kHESemNdq+UllTNSW0K7NuyuigVFD4y4KheMh8CEbPgenRZ58sBUl4zwkUg8n1KjkThkV1ji9JFHhUiIHrBsgwYUOrbsIBQLixrQY9dsA8cHwxylKAdMl3LdqcZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwPKPkkX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720645951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EDkAtSJPc4fDTZHD3QI6mFYT1Fgs+3upA6c38pBIcU0=;
	b=OwPKPkkXkwfabCFUrwa5w6hxQfnlB3SACuI/eOCKuaFoC65pvKnwoQgNRvQ4M5ygd+eC5s
	J7RpGJqSO5i4szOHlbo3jIbPGWW+Z71XajHzSgmK6uUTSqzvCFyMVneJ1G7NrNsqJk4zIk
	vEbjeRy4uDgnmMhdxkmZmoSWBTsHWvg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-TNyO2UYCOKyUCij-cwGV6Q-1; Wed, 10 Jul 2024 17:12:29 -0400
X-MC-Unique: TNyO2UYCOKyUCij-cwGV6Q-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fb269ff96bso1143015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720645948; x=1721250748;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EDkAtSJPc4fDTZHD3QI6mFYT1Fgs+3upA6c38pBIcU0=;
        b=jVv+npd6zQ0rEAuBYb84jhdO5NbBwBwAuD/L/k2eZPlUp1yyywNuVxhYj3sC37A7s2
         tApSSLi+D5uFnDyu7xzCAvEX9Wys4GjYzXLa47dxPHMiuarhIzMCx6ixn2Xg+oOewK0K
         1xrywCkhTtuTmoPzNQNUgSBdPLkHdVNNziqG+R+ZCbcgrmeZ5xywtt73D3ojuD6ifKNc
         6YvN7dR3FlufxvRroAPZVpN72jK123WKuJNmEvM8V1X4PlL5yNVg067egTitr7Dvl4x5
         KHDg7b9C422/PHK0Lbw//8CQoVqQsRpr8v70sXa0QhBbd9bQ73JnZoEg6qrkSTsg5JKg
         oRNA==
X-Forwarded-Encrypted: i=1; AJvYcCXBuGcnkkQeZMkyrtqAw49R767+jslqg61flFydmVUX3voqhxWr8bbjmo6wyC6Ab/7x2EVcwTPh+ZWDA3lm9nxUdeDFlFO7RsS2UOro
X-Gm-Message-State: AOJu0Yzj1wVmRe0F2VBrr07mW7UlTyGZmCTLNR++xZpEKmPpIzfFgQLi
	o0dHBtpaLOcuflH3uqlwsoIl/DuHhpCjI6n2pgARiZWpSr050WtWeQeQit0hmfY/hygNTUPXbtM
	DVyD/cHXddwz5ZU61zr/NEymNVKV6MoRMzU0wh+LoxwXihJAgP1T5p6KJOsqK+g==
X-Received: by 2002:a17:903:1210:b0:1fb:5681:5f0 with SMTP id d9443c01a7336-1fbb6ce132bmr51939805ad.23.1720645948360;
        Wed, 10 Jul 2024 14:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeparPAWlZOWUmpNdjWGb6HKjLI7St8Hnre9nS98aWNojEhnwQSTtD7BSAWWEvfEHQAzFkeA==
X-Received: by 2002:a17:903:1210:b0:1fb:5681:5f0 with SMTP id d9443c01a7336-1fbb6ce132bmr51939575ad.23.1720645947899;
        Wed, 10 Jul 2024 14:12:27 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf38dsm38026225ad.263.2024.07.10.14.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 14:12:27 -0700 (PDT)
Message-ID: <f21d8157-a5e9-4acb-93fc-d040e9b585c8@redhat.com>
Date: Wed, 10 Jul 2024 23:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] kvm: gmem: Allow restricted userspace mappings
To: Patrick Roy <roypat@amazon.co.uk>, Fuad Tabba <tabba@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, akpm@linux-foundation.org,
 dwmw@amazon.co.uk, rppt@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 willy@infradead.org, graf@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dmatlack@google.com, chao.p.peng@linux.intel.com,
 xmarcalx@amazon.co.uk, James Gowans <jgowans@amazon.com>
References: <20240709132041.3625501-1-roypat@amazon.co.uk>
 <20240709132041.3625501-9-roypat@amazon.co.uk>
 <CA+EHjTynVpsqsudSVRgOBdNSP_XjdgKQkY_LwdqvPkpJAnAYKg@mail.gmail.com>
 <47ce1b10-e031-4ac1-b88f-9d4194533745@redhat.com>
 <f7106744-2add-4346-b3b6-49239de34b7f@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f7106744-2add-4346-b3b6-49239de34b7f@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.07.24 11:51, Patrick Roy wrote:
> 
> 
> On 7/9/24 22:13, David Hildenbrand wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> On 09.07.24 16:48, Fuad Tabba wrote:
>>> Hi Patrick,
>>>
>>> On Tue, Jul 9, 2024 at 2:21 PM Patrick Roy <roypat@amazon.co.uk> wrote:
>>>>
>>>> Allow mapping guest_memfd into userspace. Since AS_INACCESSIBLE is set
>>>> on the underlying address_space struct, no GUP of guest_memfd will be
>>>> possible.
>>>
>>> This patch allows mapping guest_memfd() unconditionally. Even if it's
>>> not guppable, there are other reasons why you wouldn't want to allow
>>> this. Maybe a config flag to gate it? e.g.,
>>
>>
>> As discussed with Jason, maybe not the direction we want to take with
>> guest_memfd.
>> If it's private memory, it shall not be mapped. Also not via magic
>> config options.
>>
>> We'll likely discuss some of that in the meeting MM tomorrow I guess
>> (having both shared and private memory in guest_memfd).
> 
> Oh, nice. I'm assuming you mean this meeting:
> https://lore.kernel.org/linux-mm/197a2f19-c71c-fbde-a62a-213dede1f4fd@google.com/T/?
> Would it be okay if I also attend? I see it also mentions huge pages,
> which is another thing we are interested in, actually :)

Hi,

sorry for the late reply. Yes, you could have joined .... too late. 
There will be a summary posted soon. So far the agreement is that we're 
planning on allowing shared memory as part guest_memfd, and will allow 
that to get mapped and pinned. Private memory is not going to get mapped 
and pinned.

If we have to disallow pinning of shared memory on top for some use 
cases (i.e., no directmap), I assume that could be added.

> 
>> Note that just from staring at this commit, I don't understand the
>> motivation *why* we would want to do that.
> 
> Fair - I admittedly didn't get into that as much as I probably should
> have. In our usecase, we do not have anything that pKVM would (I think)
> call "guest-private" memory. I think our memory can be better described
> as guest-owned, but always shared with the VMM (e.g. userspace), but
> ideally never shared with the host kernel. This model lets us do a lot
> of simplifying assumptions: Things like I/O can be handled in userspace
> without the guest explicitly sharing I/O buffers (which is not exactly
> what we would want long-term anyway, as sharing in the guest_memfd
> context means sharing with the host kernel), we can easily do VM
> snapshotting without needing things like TDX's TDH.EXPORT.MEM APIs, etc.

Okay, so essentially you would want to use guest_memfd to only contain 
shard memory and disallow any pinning like for secretmem.

If so, I wonder if it wouldn't be better to simply add KVM support to 
consume *real* secretmem memory? IIRC so far there was only demand to 
probably remove the directmap of private memory in guest_memfd, not of 
shared memory.

-- 
Cheers,

David / dhildenb


