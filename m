Return-Path: <linux-kernel+bounces-199542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B7B8D8858
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7FD1C21272
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876C137C27;
	Mon,  3 Jun 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoDRS478"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3612F382
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437660; cv=none; b=TWnXTsPD6LSaJepQZYX+WheSToAbd/4x/C59wgKnxjay3JADCPmF6ZnbSmxtnTX9Lm7C2NnNM7rVkpd4kKAK30/b8SabXLkneK9i2QPQkE+iXVEegnLRi0vNCJKtKPvsQhWf/esiHerWdc46EB4B/bqKe/kk5oQrhy1cwRcvEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437660; c=relaxed/simple;
	bh=eEHuQRBHitS6CxngH9Sdf0xHt3YJK1F2s+IPIuJPjo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmoC9l4bnMQIgKwd584f9hM95GeOII6UJWA1qb4isOSndM/1g0JdLyV3kgLFAaAGoaBAWdla69auyMsIOIM7RQ1oSDKA7aBDHjV+wrKm+In7pulMin2Io30zdhIjxCtW32vCaR3hZPHfyt+EwddOOOhlyMqFxGIqyY/2YFYm8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoDRS478; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717437657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZasDE2jJu2ABrTKfFNpMSIYkkpwo/Qvz1gLL+mMq4VM=;
	b=AoDRS478hLNeVdcfMQWdCD1zH6RyYrg45PNa6v1vIMubYL5oXfW/kxQp/0tWukjBf149Rw
	QshdgKPsVA2cCIj3iVmE4I4qBc7xBMPJCd7URVuGLdQrPj/e8G4Y2vVP2sZ2oQIbILh732
	iVpXByGKElrCdBF743MuZZ/KNQWHVW4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-gxOz6iD1NBG0al3X4vfd1Q-1; Mon, 03 Jun 2024 14:00:55 -0400
X-MC-Unique: gxOz6iD1NBG0al3X4vfd1Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4212983c8c7so22919955e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 11:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437654; x=1718042454;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZasDE2jJu2ABrTKfFNpMSIYkkpwo/Qvz1gLL+mMq4VM=;
        b=KSkmZAVOWiE6G1Ed5TEVZXNl2equB0U8HOPYr7wSEqGRQuBubvnUHeXdkoweWDlist
         ybZk292ASopg/Uh8ORoFvYYglmFX9TbUqb5ZBn76qLqk4XzTGc/LAVZVC5Yw0ghaMp2a
         oqQxkU5af1QINlXoHxagUXOUlfCP0Pd4RGa4nRsEaGSGXESv+VOoTbvTsLISQptsL/7C
         2f7y5cF5/dfym0xL4Jl/3D6tTmwureJ5m7XEL85jkXKOPMmI4oBoqFVmC7law5O2jbn2
         twdcOg4Kol+KE643Bb+04g330rYfKkyFiyK7cGUYTFwoHzy/kLel5SLPauOa8HF1EthW
         W0fA==
X-Forwarded-Encrypted: i=1; AJvYcCVBf1JpYou+d1kJn5GT60ZpEKUME0Zp82cszP+Ojg5qIjc+myYpxx1X+YhyBxLGs9xMACeiBuccOFGuBWqHMc4Dar2ktcpKYyjwbXuV
X-Gm-Message-State: AOJu0YypcGdkxzoPt1yNsq4c5fifAaRVK/g8OQFl0fUUcRw/mC3oa9Qb
	V45OZrNPmxZwl8wAiKMeqMcbyn0jRwy35+BorN6aoi+p5Xu4GOPR1/LxMgdK/VcqPMX0OT8zMKm
	sh0SBHPUZBnj3g038vFKz7yP2r2k7yZ/R0lxIUbrCYTXr+w/k6BNMVg2jWTdFug==
X-Received: by 2002:a05:600c:4f13:b0:421:2c02:977c with SMTP id 5b1f17b1804b1-421450bc5famr3848105e9.0.1717437654623;
        Mon, 03 Jun 2024 11:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG74J9I+80fnD9+lPuA4dutYKedJYMCoGGzbIvFnN8CZ2XDG0gszRIbrfiaDMGM240SUR+t8Q==
X-Received: by 2002:a05:600c:4f13:b0:421:2c02:977c with SMTP id 5b1f17b1804b1-421450bc5famr3847815e9.0.1717437654181;
        Mon, 03 Jun 2024 11:00:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:3d00:918f:ce94:4280:80f0? (p200300cbc7313d00918fce94428080f0.dip0.t-ipconnect.de. [2003:cb:c731:3d00:918f:ce94:4280:80f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b4asm127126435e9.6.2024.06.03.11.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 11:00:53 -0700 (PDT)
Message-ID: <24daabde-300e-4a28-9a1c-9e406b087195@redhat.com>
Date: Mon, 3 Jun 2024 20:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
To: Matthew Wilcox <willy@infradead.org>, Dave Hansen <dave.hansen@intel.com>
Cc: Byungchul Park <byungchul@sk.com>,
 Byungchul Park <lkml.byungchul.park@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 akpm@linux-foundation.org, ying.huang@intel.com, vernhao@tencent.com,
 mgorman@techsingularity.net, hughd@google.com, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
 <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
 <Zl320dWODSYw-PgV@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zl320dWODSYw-PgV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 19:01, Matthew Wilcox wrote:
> On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
>> Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
>>   Presumably some xa_value() that means a reader has to go do a
>> luf_flush() before going any farther.
> 
> I can allocate one for that.  We've got something like 1000 currently
> unused values which can't be mistaken for anything else.

I'm curious when to set that, though.

While migrating/reclaiming, when unmapping the folio from the page 
tables, the folio is still valid in the page cache. So at the point in 
time of unmapping from one process, we cannot simply replace the folio 
in the page cache by some other value -- I think.

Maybe it's all easier than I think.

-- 
Cheers,

David / dhildenb


