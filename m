Return-Path: <linux-kernel+bounces-267083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C828940C27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD801C2426F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31C619409A;
	Tue, 30 Jul 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLiM+lz3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17189193092
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329245; cv=none; b=FJuUxQhO2CNRuM9stZccuXfnZh9EF61g/I/v3kUwBJb+pStFuvQJq9NJ35oFDwit5i9uYqnq9M/3vA2ftOoJZfhz7hJqBScyrzNXz048rKUlKWZrfwfTGZ0+IBb/nYf54fGjM3q44lcDmiekC7rzFO8sYuh0EUtxhEnMKCQ2vVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329245; c=relaxed/simple;
	bh=S5DAsQ9ph9ormZyq+s22JdGzO1HyrgtPXPLHlYNPLXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGL6Fju2bzUMQ3N3hNFAXIoMnT0uEW/+DdlZ6qL5Xs3O1Zx7jHKQ0ZqKSaprLAu8QvU2nyoSK4JRMuxgb6dW12jBEkh2s8/AXss9LDpmZMHLOqYsmXJa6JqDHzN1MIZzYKm5qZyWIrccjHZgWC4FkK0RTM8tzmpn0lzf8FZyM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLiM+lz3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722329242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BoagRk+gSe5xue+rd2621fYhA6FVlq9e/Frmy4c0XII=;
	b=GLiM+lz3WVc6tteww53HqIC+adzuodHp3gqz9/GAjOFoBR02WgzBZZsCMmYCVoReoJh2d5
	zV1AN2AY4Tg+CsazDYKUV925ooHXjWdeOtXY2v1F7BTp3mkUeg1+ftwVHgFEMcbqb1pnFk
	zBAFkySaYkXvWjEQf/Tn7fEKfymsAiw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-RH2XNbPyMnuGvg_YswdLjg-1; Tue, 30 Jul 2024 04:47:21 -0400
X-MC-Unique: RH2XNbPyMnuGvg_YswdLjg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef1ba2a5e6so45320061fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329240; x=1722934040;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BoagRk+gSe5xue+rd2621fYhA6FVlq9e/Frmy4c0XII=;
        b=eOd1IAx9fTxcCmSPAsGcEufqiOVysxCLIgmBXxqQcuHHyALQcWPBjlZAJRs+1xILRt
         l++yNe1Uectc3gcYf10FYD/NpJ0a7LAulkLlJIDUWKDLYT5G9F4Z27hzMZerOS4o8nWQ
         F8uON79Q5Mq7gGBLFP4S7ghlOtn5UgdpppmmO4U7r9HTrTqiB3B+tuJbuWLm2Z8sVtz1
         XhaVMz4Yg+pF9tDNsbtcq5HtNeNu+X/4sxrZPnGXroQ/I5ngQkn+/plyvcLu9mryl+94
         d7EIe4CWsCRvdrPZULqeY5HeMPSGcheFVFbckBtI1eW9qqRTiegmNhNt8W/qZoPvL5WO
         38VA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8tbdu5Dq9eswa0jeC7E/nAs2C1WNZreS9aQZ2p/YjeG7vtxEhn0Knsw4TXkIkGGnaNexNLjUIUJy/VpA3D+ii9Lsdn1s61kueKmS
X-Gm-Message-State: AOJu0YzVSvzT+1dpZypqv9MUDspK/CLiHjxKz6vMI7tys6KB1CHdo1B9
	C4+dZ6u8ulgp3uI1Y3kqJXiwUUkCv72aCqsh4eFmBCBW3VQJezGDzqaQpaTCnRIUT8d8qRqlnI+
	YFDN0x2qAE41TIM0G1phjF1yBv51fzyTHPaR0WySC84/Phpdwo/2VQ7fD+g1rig==
X-Received: by 2002:a2e:a4ac:0:b0:2ef:392e:e4f with SMTP id 38308e7fff4ca-2f12ee2f0e1mr52206321fa.47.1722329239643;
        Tue, 30 Jul 2024 01:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp78HIdgJdyE0H3uqbbJxnRLg6C1y31kOyGCMPQ69rbANTg7A1Z8vi9tPcoxyWbTF4SzUYjQ==
X-Received: by 2002:a2e:a4ac:0:b0:2ef:392e:e4f with SMTP id 38308e7fff4ca-2f12ee2f0e1mr52206131fa.47.1722329239002;
        Tue, 30 Jul 2024 01:47:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42808f684d0sm183470695e9.6.2024.07.30.01.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:47:18 -0700 (PDT)
Message-ID: <f61235d6-5d33-4853-a498-72db2fb13b10@redhat.com>
Date: Tue, 30 Jul 2024 10:47:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox
 <willy@infradead.org>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, hannes@cmpxchg.org,
 hughd@google.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
 nphamcs@gmail.com, senozhatsky@chromium.org, shakeel.butt@linux.dev,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 xiang@kernel.org, yosryahmed@google.com
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org>
 <f0c7f061-6284-4fe5-8cbf-93281070895b@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f0c7f061-6284-4fe5-8cbf-93281070895b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.24 10:36, Ryan Roberts wrote:
> On 29/07/2024 04:52, Matthew Wilcox wrote:
>> On Fri, Jul 26, 2024 at 09:46:18PM +1200, Barry Song wrote:
>>> A user space interface can be implemented to select different swap-in
>>> order policies, similar to the mTHP allocation order policy. We need
>>> a distinct policy because the performance characteristics of memory
>>> allocation differ significantly from those of swap-in. For example,
>>> SSD read speeds can be much slower than memory allocation. With
>>> policy selection, I believe we can implement mTHP swap-in for
>>> non-SWAP_SYNCHRONOUS scenarios as well. However, users need to understand
>>> the implications of their choices. I think that it's better to start
>>> with at least always never. I believe that we will add auto in the
>>> future to tune automatically, which can be used as default finally.
>>
>> I strongly disagree.  Use the same sysctl as the other anonymous memory
>> allocations.
> 
> I vaguely recall arguing in the past that just because the user has requested 2M
> THP that doesn't mean its the right thing to do for performance to swap-in the
> whole 2M in one go. That's potentially a pretty huge latency, depending on where
> the backend is, and it could be a waste of IO if the application never touches
> most of the 2M. Although the fact that the application hinted for a 2M THP in
> the first place hopefully means that they are storing objects that need to be
> accessed at similar times. Today it will be swapped in page-by-page then
> eventually collapsed by khugepaged.
> 
> But I think those arguments become weaker as the THP size gets smaller. 16K/64K
> swap-in will likely yield significant performance improvements, and I think
> Barry has numbers for this?
> 
> So I guess we have a few options:
> 
>   - Just use the same sysfs interface as for anon allocation, And see if anyone
> reports performance regressions. Investigate one of the options below if an
> issue is raised. That's the simplest and cleanest approach, I think.
> 
>   - New sysfs interface as Barry has implemented; nobody really wants more
> controls if it can be helped.
> 
>   - Hardcode a size limit (e.g. 64K); I've tried this in a few different contexts
> and never got any traction.
> 
>   - Secret option 4: Can we allocate a full-size folio but only choose to swap-in
> to it bit-by-bit? You would need a way to mark which pages of the folio are
> valid (e.g. per-page flag) but guess that's a non-starter given the strategy to
> remove per-page flags?

Maybe we could allocate for folios in the swapcache a bitmap to store 
that information (folio->private).

But I am not convinced that is the right thing to do.

If we know some basic properties of the backend, can't we automatically 
make a pretty good decision regarding the folio size to use? E.g., slow 
disk, avoid 2M ...

Avoiding sysctls if possible here would really be preferable...

-- 
Cheers,

David / dhildenb


