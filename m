Return-Path: <linux-kernel+bounces-538766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD601A49CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F5518937FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C41EF36F;
	Fri, 28 Feb 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oab45PpM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D931EF38E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755433; cv=none; b=F8L5FxKD/OuKzwmwDQuCDp/ggswlAPhVduJcwjF+c6U+Un5Px5qvYXxYnasKBDMwMexa1XbE6BBdn4g2sGRLkq40CnOPb3luPEfl6Da+GJJW8I9zm4iF4ursugu6g2BZdH4CCGUxQEZQgupKxERiw2OnR3TGDBWYxNjYLADc4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755433; c=relaxed/simple;
	bh=G5xsR3gIyg8PJo91HeYDwsMXXifwnMAFdBUkJ3xpFHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXkEp7Ef+0fFT5RohIs9yqA3syyvCfALyFrQQkVBVUDhabIuneOuUlm0KFE/5N1wUKwlFxRuGuT9lvVPkGq6VC5yP98pqeyr+r4+GD0QmMRcbtwIuKrwj+kHv4IrgH5DpxKVyKlumFKB/n8b7ZXJl4v8R8kl8d92SPKKFOtvigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oab45PpM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740755430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dvx9qQz4GnaSBoRlMmw91nrFxOFgnJaVYqTrUqROV6M=;
	b=Oab45PpMF8i9fx3O5o39dDzEnLNStq9M3lvyC//QEJE26Iy+CCEfjskjK9lMNDgec8Xobb
	tp135Gfux1NkyYwgqpq5LxrrWik33WZwDsUMDYlZqwmGho17SSSW1UzMUPz7rB2MNfaxkQ
	4ygUQPFgUhUu9PjEOc4CsHOOiZ4DhQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-jSwZn70-MsG8OLvI2dQ3oA-1; Fri, 28 Feb 2025 10:10:28 -0500
X-MC-Unique: jSwZn70-MsG8OLvI2dQ3oA-1
X-Mimecast-MFC-AGG-ID: jSwZn70-MsG8OLvI2dQ3oA_1740755427
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso14359555e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755427; x=1741360227;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dvx9qQz4GnaSBoRlMmw91nrFxOFgnJaVYqTrUqROV6M=;
        b=w1xZ/reid7bQUSy1Af0Xmg3iZiDcRwPKZr7KVUkKfjhLjEpvUJx5ghRYGx3yD1bZON
         w7n+yGED5/thuB4sB0Pkxc8xk38D80NB7HokroFSgaap8LUsDIc0d/WZKPdjk/P3a4Zx
         +Sexp7FbyfX2k95Sumglw4Lf83RSaSLjPLdqoz6DpA75GCYm6nbGrii5fuGTztHbKln8
         tb9wQa2iL4B26HuqwmASiOZxZRinfO7C68RMGYJeSxxjTtSOzYpzuqeH3wz0Bp1aHcrE
         e5dKsC4LpjIx8d6Z+vbi+QzibdntnBhoja5TOxYWRr7EgI4lAaJ/IrSHojEClSG59nsM
         6GPw==
X-Forwarded-Encrypted: i=1; AJvYcCWb+c1fd7BR2S9gRYwvkzt9Be3ozQuMndg3V9s39KvRux82urijKF8g33ha0WsXAzoMdPMZvPmM+0wNiGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOm5zJuCzqAmY8gKVA1+85m8WP0ilF47wD6QAg9IDEmRvv77R5
	cWjAiNmXRW8UPtjCoARI8xrO863ACHD1+o3d7Q2bd6/WL2wHZjoeguS5ns+KU60OVxALmUn6Vck
	ijpKz3Uxu7uhaBbL32KdVLHdXIJTrx5EwcY8wuTaajgqpdbQ9Nxjbcg/kxS25Cw==
X-Gm-Gg: ASbGncuOSNk+JwrtUVpOofoWr8ab5Dex9U3CiayB/KnDtO+h7LtzdmyYshUPdGTStin
	8unZxFMmsNFXiK8hf1lK7lQrodO4eIjHpHuYoe7tRU+4w1j/hc9XdSJVxdUdX1r34AwfRGblCWf
	pg8ecy7I41tE7yiEYftRe1gMfmESQdOd2vzoVU5UL5Cmd6vRVJqwy2ocNq5yak6U9lTQJTFd2yk
	LmZNFWCRMIKGmiQe0VqYo36Lo9ey6oYWUZvRxRUGNtyuisgOBQc5rr/0UQiI/FnsEEdIiZkiZ73
	9E63/Dug2esbE412ddyjly8X
X-Received: by 2002:a05:600c:1c8c:b0:439:9ba1:5f7e with SMTP id 5b1f17b1804b1-43ba675a843mr27994515e9.21.1740755427318;
        Fri, 28 Feb 2025 07:10:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhElXmidTHxVjMfp8VISIfFlJylL6DZvjAZbDgiaZYHS0IRFcw2o8LBRbUv0Fo8Xl7IgaUAQ==
X-Received: by 2002:a05:600c:1c8c:b0:439:9ba1:5f7e with SMTP id 5b1f17b1804b1-43ba675a843mr27991585e9.21.1740755423972;
        Fri, 28 Feb 2025 07:10:23 -0800 (PST)
Received: from ?IPV6:2a02:8070:4688:86a0::a40b? ([2a02:8070:4688:86a0::a40b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f8034sm63278725e9.4.2025.02.28.07.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:10:23 -0800 (PST)
Message-ID: <e110e00f-9032-43ec-808e-45a912065fb0@redhat.com>
Date: Fri, 28 Feb 2025 16:10:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
 <Z8HPN5sAgInM4dN2@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8HPN5sAgInM4dN2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.25 15:59, Sean Christopherson wrote:
> On Fri, Feb 28, 2025, David Hildenbrand wrote:
>> On 28.02.25 06:17, Linus Torvalds wrote:
>>> On Thu, 27 Feb 2025 at 19:03, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> I'd be fine with SKSM replacing KSM entirely. However, I don't
>>>> think we should try to re-implement the existing KSM userspace ABIs
>>>> over SKSM.
>>>
>>> No, absolutely. The only point (for me) for your new synchronous one
>>> would be if it replaced the kernel thread async scanning, which would
>>> make the old user space interface basically pointless.
>>>
>>> But I don't actually know who uses KSM right now. My reaction really
>>> comes from a "it's not nice code in the kernel", not from any actual
>>> knowledge of the users.
>>>
>>> Maybe it works really well in some cloud VM environment, and we're
>>> stuck with it forever.
>>
>> Exactly that; and besides the VM use-case, lately people stated using it in
>> the context of interpreters (IIRC inside Meta) quite successfully as well.
> 
> Does Red Hat (or any other KVM supporters) actually recommend using KSM for VMs
> in cloud environments?

Private clouds yes, that's where it is most commonly used for. I would 
assume that nobody for

For example, there is some older documentation here:

https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/virtualization_administration_guide/chap-ksm#chap-KSM

which touches on the security aspects:

"The page deduplication technology (used also by the KSM implementation) 
may introduce side channels that could potentially be used to leak 
information across multiple guests. In case this is a concern, KSM can 
be disabled on a per-guest basis."

> 
> The security implications of scanning guest memory and having co-tenant VMs share
> mappings (should) make it a complete non-starter for any scenario where VMs and/or
> their workloads are owned by third parties.

Jep.

> 
> I can imagine there might be first-party use cases, but I would expect many/most
> of those to be able to explicitly share mappings, which would provide far, far
> better power and performance characteristics.

Note that KSM can be very efficient when you have multiple VMs running 
the same kernel,executable,libraries etc. If my memory doesn't trick me, 
that's precisely for what it was originally invented, and how it is 
getting used today in the context of VMs.

For example, QEMU will mark all guest memory is mergeable using MADV, to 
limit the deduplicaton to guest RAM only.

-- 
Cheers,

David / dhildenb


