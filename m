Return-Path: <linux-kernel+bounces-395276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7A9BBB2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD631F21B37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F761C3054;
	Mon,  4 Nov 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZCt/igY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031DB1BD039
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740257; cv=none; b=kXnXAIU9OjQsJWHelQgS+jfSnqRZnHBd4GaDtgESD5PjXD754b4wmXFyhHRhNj/RKukDcPl5CPl9Ks4kmUTBU7JeXidHXxDjapYeZxWdSHWnmYfKCyiFhZQBOxL2R7iKkLgfi8IAArTYvHYP+UokUKgUEgovrOnLrogqDp5eRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740257; c=relaxed/simple;
	bh=W8vHKqBvPFEzf5KDg5QTRMxvBpSXM6CWfCgmcqc15cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7lNDqJXYGtA8o823ovkCnAlUXO78a0YlrUFej5RjJbNLD1CRsX2ufr0NXK9XODGufYFeaOGdsFkjwZLGD7TQgc26NAy0wktceh8A5kDeGLccAYfUEZe6qhjbggq0KGA+59/RjgRSbn4H1RKlNiD/Uz8X0Zt5Ae0K2r77KjcCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZCt/igY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730740255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pqWIJXisuoTHAxJhVcvZiX/nC4g7cGGR3MWuBqXh4nM=;
	b=AZCt/igYsYFNPPmFEaT1Ew5D/4noTS9awd3IOQVdtMEVKOQWuK2mZy1rrp4+T6tQZffP2O
	WfkUyYWi0lTf+yjB8WA0I89nghssic8TxVSeGY4DB7JnEjajss66TSoxNYWP36niRoBbzt
	gdRUMTNCDlo4LFZer/DjOhSr/HMiyj4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-LVlPV1fWPDyn-TfTyYVZhQ-1; Mon, 04 Nov 2024 12:10:53 -0500
X-MC-Unique: LVlPV1fWPDyn-TfTyYVZhQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb55e102b6so27323241fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740252; x=1731345052;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pqWIJXisuoTHAxJhVcvZiX/nC4g7cGGR3MWuBqXh4nM=;
        b=oVzauBzkv29AVWNfvbRtqkFFRYaXuxMR7JkpfsBgXh8eIAXdtmoLjujNReG455wWAp
         95dzkOVljI7jG4ypuaZbh84sm/BMxIsCdY/z72FS48xh+tVKMfv6B9h/plMXQyTlDDh7
         4I43w9FWBqoy57RF3tOjKlPwUwhe+y8991YWcjMcUME5sWtMEzciDNE0D/Aa1UtxH2zR
         bjsSTFfK+lZn0ZcaxlVcIWLuxijUvaKYroJqFb23I51DPkg0SPzPbqtUO4dy6wRloAjv
         7en44DACSONdCatF4VuOo5szp8ieDzvouMD6Tu1Q7tssYY4j5nBjuQ7MTXAr0XNKB227
         8Owg==
X-Forwarded-Encrypted: i=1; AJvYcCUUAAZ4p80ZiLZnD5VMWyRsEN2sgrgELRIHKaNRaM9kDtfCq2k3dWs9xnb0qdSFuLp7GgTtj+0o63XnPwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEp/YVWVOgd71RsVAZn9gZlRTQDybjQ9rHsWKWLH19UfM4LWZ
	rUrs/d9RKrLaC2+afd0gyjy2V853ljTIItNbAzkaXsWWFF4SZGSZvdVPxB29Qg3wRKgp1g3mtxO
	CHpJz9A2ks3KbzJdWwrJuJ7P63vLrBTtCmlHW/R5zMjUnCyX+FbPdwrGX7pChUA==
X-Received: by 2002:a05:6512:114f:b0:539:958a:8fb1 with SMTP id 2adb3069b0e04-53d65e1aeecmr5329801e87.60.1730740252131;
        Mon, 04 Nov 2024 09:10:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX/Ul0DxY66hacUplM99cMK0QO6jkceU7tnahbj186o0+rsIVo2nW3N7/4zvqsELkapLE7UQ==
X-Received: by 2002:a05:6512:114f:b0:539:958a:8fb1 with SMTP id 2adb3069b0e04-53d65e1aeecmr5329774e87.60.1730740251612;
        Mon, 04 Nov 2024 09:10:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:e500:e96a:8043:1211:8e6a? (p200300cbc72fe500e96a804312118e6a.dip0.t-ipconnect.de. [2003:cb:c72f:e500:e96a:8043:1211:8e6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947bf4sm194167225e9.27.2024.11.04.09.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 09:10:50 -0800 (PST)
Message-ID: <c9c5bea0-7542-4587-9d02-0dc25574c548@redhat.com>
Date: Mon, 4 Nov 2024 18:10:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Usama Arif <usamaarif642@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <c7a90ccf-c1b1-480c-9f2a-88ef37c3d89e@redhat.com>
 <20241104163402.GA810664@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241104163402.GA810664@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.24 17:34, Johannes Weiner wrote:
> On Mon, Nov 04, 2024 at 01:42:08PM +0100, David Hildenbrand wrote:
>> On 02.11.24 11:12, Barry Song wrote:
>>> @@ -1599,6 +1599,16 @@ The following nested keys are defined.
>>>    	  pglazyfreed (npn)
>>>    		Amount of reclaimed lazyfree pages
>>>    
>>> +	  swpin_zero
>>> +		Number of pages moved into memory with zero content, meaning no
>>> +		copy exists in the backend swapfile, allowing swap-in to avoid
>>> +		I/O read overhead.
>>> +
>>> +	  swpout_zero
>>> +		Number of pages moved out of memory with zero content, meaning no
>>> +		copy is needed in the backend swapfile, allowing swap-out to avoid
>>> +		I/O write overhead.
>>
>> Hm, can make it a bit clearer that this is a pure optimization and refer
>> to the other counters?
>>
>> swpin_zero
>> 	Portion of "pswpin" pages for which I/O was optimized out
>> 	because the page content was detected to be zero during swapout.
> 
> AFAICS the zeropages currently don't show up in pswpin/pswpout, so
> these are independent counters, not subsets.

Ah. now I understand the problem. The whole "move out of memory" "move 
into memory" here is quite confusing TBH. We're not moving anything, 
we're optimizing out the move completely ... yes, you could call it 
compression (below).

> 
> I'm leaning towards Barry's side on the fixes tag.

I think the documentation when to use the Fixes: tag is pretty clear.

Introducing new counters can hardly be considered a bugfix. Missing to 
adjust some counters that *existing tools* would know/use might be  IMO 
(below).

>  When zswap handled
> the same-filled pages, we would count them in zswpin/out. From a user
> POV, especially one using zswap, the behavior didn't change, but the
> counts giving insight into this (potentially significant) VM activity
> disappeared. This is arguably a regression.
 > >> swpout_zero
>> 	Portion of "pswout" pages for which I/O was optimized out
>> 	because the page content was detected to be zero.
> 
> Are we sure we want to commit to the "zero" in the name here? Until
> very recently, zswap optimized all same-filled pages. It's possible
> somebody might want to bring that back down the line.

Agreed.

> 
> In reference to the above, I'd actually prefer putting them back into
> zswpin/zswpout. Sure, they're not handled by zswap.c proper, but this
> is arguably just an implementation detail; from a user POV this is
> still just (a form of) compression in lieu of IO to the swap backend.
> 
> IMO there is no need for coming up with a separate category. Just add
> them to zswpin/zswpout and remove the CONFIG_ZSWAP guards from them?

Would work for me, although it might be a bit confusing if no zswap is 
configured. Maybe just needs to be documented.

-- 
Cheers,

David / dhildenb


