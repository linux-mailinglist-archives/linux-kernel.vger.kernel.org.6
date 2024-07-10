Return-Path: <linux-kernel+bounces-248295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9CB92DB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A2B2428E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920D145334;
	Wed, 10 Jul 2024 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEL/ZJk6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401212CD88
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648572; cv=none; b=P9JGTsROHSD8SLXbXMTPcG6YVrhMHjt+4HPW6d/PMOdbakrnvCA7eP2A/hbWbEiI2lycAa89Ex0oioRyahCApO5TyWIMabH0+EH7to6fVxF9SfBFzwK0hRv1itwsoIsd3AUv8h3HLuYZw/kbI2SF0oxkUANpLS7qrMkxzdVrC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648572; c=relaxed/simple;
	bh=Zao1lpvL9ZxIhVYC8MxmdXm+OmoQIui9EewX6GeMZMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUkvVqpmuFjh09IyL7cKmf3CYmTdLDEFKk53XPPlYDRsbmVl8Sc8q0uMloPVmiPVYBZRyHaB+zHNFlicZX9CsmF8q2MqHDR2e6aS1b2t4tkT5vHPOCJWHNLKMSaiabl1ZXpb0lHjycm4zZTNai4dQnugmGnQXFDhhJIox3KbWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEL/ZJk6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720648569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=71Tkz/2J9BizJqdEFpDwx1AHmdjksGbKgVAOKJOYGcM=;
	b=BEL/ZJk63Olx6pcsZ5LBxPW9OtEUygbDzKKzlexOH9Csk8oQeMpQF4L6wRfpSSYdls/6av
	lIs9nwVCQ206WpcmYCCgNbBFbXvXgN9xVbFhbLGAtMwMDjbvy+wTWcJSTSJvSlBw+YPjK3
	YJYh+Zmdzqp2nKq6K1yHyLJUDgcVa98=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-VkjAEyRwNheO-X8esy4n-g-1; Wed, 10 Jul 2024 17:56:07 -0400
X-MC-Unique: VkjAEyRwNheO-X8esy4n-g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb3b398923so1063405ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720648566; x=1721253366;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=71Tkz/2J9BizJqdEFpDwx1AHmdjksGbKgVAOKJOYGcM=;
        b=W3sdNeVUg+2DJF+VK46J6mxMBPSIa5gJ76ZVzF8o50uImCwFOHxKTMzOaWO6NelSk1
         3AOp6EYQ3JSoldDdV8JlX11/1EcRvUORiYVkC0qxMTHg/E3NxAOo4Rr5Qp81LK2LDEtR
         d/bgnh0BnngKnfJpFk/SepL8bylLjUHN0f2ZWQRUFTVYYKqNoXTP7spXcITfhg/5tab3
         KavZIBUpmm1YDvqR6IVKTVTVPk2O5atdpHg9uNUdjrMx/rALzLc/Tx2zgFWzw/gjzyk5
         MZiv4ONG1txW8BPtvkilHP94ARXvf0EdUA9x77YaLGaU5cyY23peXvny9IlsrVfx3WVD
         P4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUNmnXJ4kbxXdz0Ee0FZl2k16Iiw0ThgTPSNpQARt2sryH0uAaofLY2MyNyb/fx6jqWHI3HL0Bd8HFj4QF/n2v39dawG3+1JkHChLyT
X-Gm-Message-State: AOJu0YzwtdVQXaYdjwALYPpBic1uAGtkBg3symEh1q5bxiG6oskXl3Cl
	5gW/6+SpJ0YAWgYtnkhYAJrssxCf6OvhNZV45fBG5E2HaMksXC5ZPwLtMvXfaMTgTWn6OMTz1Dk
	9B7ZKcET9U0Hb2XYzrBRgjrpPI2w4rM+oXV3RjDK+n7k8BSQ0AYjvEfrHi3ZUcg==
X-Received: by 2002:a17:902:d481:b0:1fb:4f9f:4937 with SMTP id d9443c01a7336-1fbb6d5b3f3mr54774445ad.39.1720648566336;
        Wed, 10 Jul 2024 14:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcoVN63OYjq6PqEhpFruaTCa5cNYaYwZe7oZR2UDUHzPf7D3EgcX+rmCrCUssudFRZRwTaAg==
X-Received: by 2002:a17:902:d481:b0:1fb:4f9f:4937 with SMTP id d9443c01a7336-1fbb6d5b3f3mr54774135ad.39.1720648565933;
        Wed, 10 Jul 2024 14:56:05 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2be97sm38150205ad.102.2024.07.10.14.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 14:56:05 -0700 (PDT)
Message-ID: <3affa4a0-c930-45d3-927c-c81b38920c53@redhat.com>
Date: Wed, 10 Jul 2024 23:56:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] kvm: gmem: Allow restricted userspace mappings
To: Sean Christopherson <seanjc@google.com>
Cc: Patrick Roy <roypat@amazon.co.uk>, Fuad Tabba <tabba@google.com>,
 pbonzini@redhat.com, akpm@linux-foundation.org, dwmw@amazon.co.uk,
 rppt@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 willy@infradead.org, graf@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dmatlack@google.com, chao.p.peng@linux.intel.com,
 xmarcalx@amazon.co.uk, James Gowans <jgowans@amazon.com>
References: <20240709132041.3625501-1-roypat@amazon.co.uk>
 <20240709132041.3625501-9-roypat@amazon.co.uk>
 <CA+EHjTynVpsqsudSVRgOBdNSP_XjdgKQkY_LwdqvPkpJAnAYKg@mail.gmail.com>
 <47ce1b10-e031-4ac1-b88f-9d4194533745@redhat.com>
 <f7106744-2add-4346-b3b6-49239de34b7f@amazon.co.uk>
 <f21d8157-a5e9-4acb-93fc-d040e9b585c8@redhat.com>
 <Zo8C1Rz1eR96gQ1E@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zo8C1Rz1eR96gQ1E@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 23:53, Sean Christopherson wrote:
> On Wed, Jul 10, 2024, David Hildenbrand wrote:
>> On 10.07.24 11:51, Patrick Roy wrote:
>>> On 7/9/24 22:13, David Hildenbrand wrote:
>>>> Note that just from staring at this commit, I don't understand the
>>>> motivation *why* we would want to do that.
>>>
>>> Fair - I admittedly didn't get into that as much as I probably should
>>> have. In our usecase, we do not have anything that pKVM would (I think)
>>> call "guest-private" memory. I think our memory can be better described
>>> as guest-owned, but always shared with the VMM (e.g. userspace), but
>>> ideally never shared with the host kernel. This model lets us do a lot
>>> of simplifying assumptions: Things like I/O can be handled in userspace
>>> without the guest explicitly sharing I/O buffers (which is not exactly
>>> what we would want long-term anyway, as sharing in the guest_memfd
>>> context means sharing with the host kernel), we can easily do VM
>>> snapshotting without needing things like TDX's TDH.EXPORT.MEM APIs, etc.
>>
>> Okay, so essentially you would want to use guest_memfd to only contain shard
>> memory and disallow any pinning like for secretmem.
>>
>> If so, I wonder if it wouldn't be better to simply add KVM support to
>> consume *real* secretmem memory? IIRC so far there was only demand to
>> probably remove the directmap of private memory in guest_memfd, not of
>> shared memory.
> 
> It's also desirable to remove shared memory from the directmap, e.g. to prevent
> using the directmap in a cross-VM attack.
> 
> I don't think we want to allow KVM to consume secretmem.  That would require
> letting KVM gup() secretmem, which AIUI defeats the entire purpose of secretmem,
> and I don't think KVM should be special.

I would mean consuming secretmem via the fd, *not* via page tables / gup.

But if we also want to have the option of directmap modifications for 
shared memory in guest_memfd, we could make that indeed a guest_memfd 
feature.

-- 
Cheers,

David / dhildenb


