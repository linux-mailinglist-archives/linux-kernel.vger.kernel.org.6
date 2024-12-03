Return-Path: <linux-kernel+bounces-429427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FCC9E1BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C911678F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68A1E631B;
	Tue,  3 Dec 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME5ci1Tb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509B1E5714
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228240; cv=none; b=SDSj8ZJCurubK5eDSP5Se+9c9CrTNEo2RNFUkDzXcBsKgXP07Gt2uXhAhNTENE45IC2UnneIJH5DyAr6kUQHK2J5XYK57FrweunExbvqJBFdHYkLpFic1h9Z5nJ76AC6IEOJWZglPQBzMuFwEVYPh/G/TmI+0WG7Lk4/6QCV/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228240; c=relaxed/simple;
	bh=/d+HmGa+axS4citlYcWm3U5UKQejQhUI12NYgVgMXqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj9pQWTff8N/PAD48Nmvq6h+/xmgl4V5lkAiWMwIfjcPmSO5B2Jw8COenk4BF1XLA70MLAkjw95xjKIdwRPsDizPlrOmisJjKSJYrVfpwpcvg9y8NIWlMyo0S9yWy3Vzpoh983LQ0EBZy91zMTjBzMl9EVuo5CsSnp+gh6qxhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME5ci1Tb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733228236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CnbcPTT+2MccxAn73hSdR/jbj4ubVELTR4TJVlLa3Po=;
	b=ME5ci1Tb7WSgUErNAM1hislP1Zy1FdbsMTbPymw2ur4S06msMFsNcaMSgAYmbi/P3NtCfK
	dvJttDPRkjtFBzdH/SKeFD1Tj6ZN3N2h7RXrzdrmEVF0f9UwXJaguDIrmzduvu41YJIKaZ
	PA3xLE1y0xFz+NcjdB3RvrXflSlxsdQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-_VupRd4xObmPM0gP9lj5QQ-1; Tue, 03 Dec 2024 07:17:14 -0500
X-MC-Unique: _VupRd4xObmPM0gP9lj5QQ-1
X-Mimecast-MFC-AGG-ID: _VupRd4xObmPM0gP9lj5QQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e03ee802so1689395f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228233; x=1733833033;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnbcPTT+2MccxAn73hSdR/jbj4ubVELTR4TJVlLa3Po=;
        b=lwiLjiHC0hdQUiRsdOQhY957DYsKhXJQVB6pJy3XaoCx6kmDOrnAo9G3U4651L9ud9
         SNveUQDht2jP5UKOMmZE0DKPXZo22rC6PFm/Mwj1ZJWmhT7O0tEQnc4arXc0TzwyJNgU
         nMOeyOR72iYzvoci5kXtq33W6TZBjo/pDL1ROqSThIVAuvIO4ZhIFII27GWbVSWieyBF
         EAvO25Ha9qaa4Nc+8ZHa+/gGp5Z0eYV3kXAsKUwNfl0025ivW7+aTklAea8FmOWpFjS/
         HIyEtarsGR08+83V3jXYsdyNlCIboc4dnbkdV+9hcUBh4sT668TMvNepJpYmOqSQXDQX
         SurQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV2KaufXpAkzaWhN68e8VqVnI6vV3EXabTHtB123yPMQg1WWcZeso/YrvlN0kj9MGfXX6Lh7wkLKf2vv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfFRl62lqjtLWMCkbdgYKM3I3yhRxlZUkvsjZEA0rWMSGZFQs+
	FNpyq1Fhec7S4nc4pjz/5IRsdQ/QS+D6XKsJWybqBUR5jIMMSMRvZbt8/rx7mMDybVQIz4ymxvu
	0Cj0sI+xj8nGCLi/+oUK2ZXHJISLWzE5wT+QwW+R9o648lz6Ew1U4ftqYGzDSJA==
X-Gm-Gg: ASbGnctTPFKP2A2dR2pakbam6cJ+MXrfs2nt3KlMp94VFY/ssAoNao05V0s80wTCeyb
	4nUFByjh/pGCJ449yv0oF/UUw4a7YkG6yGm0Ucm6XU5IrU9PH6SK7oSywuJKUqYOruPpmD6JJRy
	UtCWP2g7Z8d6ffA0A0+GfNRwtiEattxXJdiMKNk0TCx66k15NRbLRleFa7mkN8pUFuShbsXSOoG
	fPd8hJy5oiqalueI0We2vn8x8xohX2dBmU9U/0s4tlM5nGY1JNYHeDQeb9N4kQPBTq7CUvNVWaf
	fvU3x5LoFvA4XFN688jCO6a3NLQGPNJvDtuAIt+Az1nwAN6gbTGoArgaaK4d9oEv9saGC9ZEeBm
	4qg==
X-Received: by 2002:a05:6000:1787:b0:385:db11:badf with SMTP id ffacd0b85a97d-385fd3e9c98mr2101214f8f.22.1733228233433;
        Tue, 03 Dec 2024 04:17:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6KVq1ZgR0AI2fRYygOJHD0vOuByj5FG81/vtLdLa58+Qyq56d5fCHqfizVfsfgOX5Ag2aHg==
X-Received: by 2002:a05:6000:1787:b0:385:db11:badf with SMTP id ffacd0b85a97d-385fd3e9c98mr2101192f8f.22.1733228233113;
        Tue, 03 Dec 2024 04:17:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7? (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7150esm186078105e9.42.2024.12.03.04.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 04:17:12 -0800 (PST)
Message-ID: <ecb1c40c-45fe-4f8f-8831-5d2cb31f4c8e@redhat.com>
Date: Tue, 3 Dec 2024 13:17:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Michal Hocko <mhocko@suse.com>, Frank van der Linden <fvdl@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>,
 Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
 <Z070YE81kJ-OnSX8@tiehlicka>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z070YE81kJ-OnSX8@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.12.24 13:06, Michal Hocko wrote:
> On Mon 02-12-24 14:50:49, Frank van der Linden wrote:
>> On Mon, Dec 2, 2024 at 1:58 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>>> Any games with "background zeroing" are notoriously crappy and I would
>>> argue one should exhaust other avenues before going there -- at the end
>>> of the day the cost of zeroing will have to get paid.
>>
>> I understand that the concept of background prezeroing has been, and
>> will be, met with some resistance. But, do you have any specific
>> concerns with the patch I posted? It's pretty well isolated from the
>> rest of the code, and optional.
> 
> The biggest concern I have is that the overhead is payed by everybody on
> the system - it is considered to be a system overhead regardless only
> part of the workload benefits from hugetlb pages. In other words the
> workload using those pages is not accounted for the use completely.
> 
> If the startup latency is a real problem is there a way to workaround
> that in the userspace by preallocating hugetlb pages ahead of time
> before those VMs are launched and hand over already pre-allocated pages?

In QEMU we support parallel preallocation, and even NUMA-aware 
preallocation, to reduce VM startup times with hugetlb.

We discussed improvements as referred to by Mateusz to further speed up 
preallocation, but for now parallel+NUMA-aware preallocation seems to do 
the trick.

-- 
Cheers,

David / dhildenb


