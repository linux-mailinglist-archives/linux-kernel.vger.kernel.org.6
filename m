Return-Path: <linux-kernel+bounces-430855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720239E368E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A06C169273
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF319F101;
	Wed,  4 Dec 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uhn6yP1W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE719DFB4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304529; cv=none; b=LMdBUMPvxIHUnYS3aYCMgydLQn9z5qwoaZBeA4eRjPYg8b6XE2TY9RcgMBPQylRy6TyRtUgg7iW56YBXi314d8kSdFXdZcBsm3ADQG7WNLdPzY3vQTrHBBQzjej7/os1ZAg8D11SiVp1W58eGQyGKsiWkxaDgrbdhPUPcnFeWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304529; c=relaxed/simple;
	bh=Kd2C3DFdceuLHlCe20y7X3UXrTpVnCa7VKUm4hOdkwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3dC4/J3KMnsKfmNOGz8zrIwUF6P+wy9UmvZljM7az2GbJMdp+QYxv/JZrqyEaRgDkqAKetoAP6dJ6j5sH3gibVz8Azr0IoTDi4I3Gc9eiQ8u4tOLHqLJ5A6+tZVZ3FdMA75Hoi/w3YV6OtbWldgr00AqhSlVykWxI+fj2oXI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uhn6yP1W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733304525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AXkcsNssBDIkoyIUFa6gbYj8t92+fIKYw2rEYcDaoyk=;
	b=Uhn6yP1WRI8Nm8mrvC+qNexisDX3rxbhKySJ0xuzV1PnRnzso8holjU0cveGGyDotia4gL
	1nYOpTvfVE0O1t9+soZ8sNxxfO4SZMDzamRqWU9aGdluBpSQfRbXpUJvr/IS1xLKcKVtP4
	UQ/OTC92ukqoRlfSQ3ixApagqVTIGV4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-WGXh6ByeOO-xBdYBhbRrIg-1; Wed, 04 Dec 2024 04:28:43 -0500
X-MC-Unique: WGXh6ByeOO-xBdYBhbRrIg-1
X-Mimecast-MFC-AGG-ID: WGXh6ByeOO-xBdYBhbRrIg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a4ad4798so48496595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304522; x=1733909322;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AXkcsNssBDIkoyIUFa6gbYj8t92+fIKYw2rEYcDaoyk=;
        b=T4d+ZZ0JD7+YEF+IIF6XJCbwMBRl3FTlbCSBICrUn++33N9wOQQcnpynW5MjRjB8nj
         A5OL7m7CBGMenpg/0AM+s2o8PR5+HlGUd5eq1MFdjf7U5FtcyKmfKZ7BcM/kqm7rxpMo
         6UW85hB5tO1+xCdMMsyoM2+YnU3XEu06XSuO9NwkPLfSmu1n448U3lrzRIXrngdELXKs
         Escp905wFLRGoTLCq7JVqsjvXRFUaBKRqivQ6J/ELMcAQqqg/Wy1cPr73RFg7ge28u+C
         f3hE3RWU+BG57P7eyjWmlfNyNXZL606k8trewwOFOlHlumnCPWmhs5d5RQaX7/xhVXwu
         C/Sg==
X-Gm-Message-State: AOJu0YydP17e8gHhV6sz3wrOLunddMooxGn3dqRO+dV9SwK3u5XjYuHr
	NhJKlKHDnie2qnzEWP1XiSdKWAgZSZcFb1J/xts/nM8eERNrJllaju8//ikrIOs5411wjhUUzgu
	9/euLlztA4X6qF5FEliawdiAKRbNp7xzhtFdRJGWQxK6kwCE+OabvbMx55CtrIg==
X-Gm-Gg: ASbGncvrnmf5ZUKM+TknaQbzX8y6uA6o4pd9/uzD0J9gMch/Y7EbvWSyrj75iwEdC7e
	x40e8/o9StrJjBwcl+GMeyK94ULKEoKkPWLDepBbuOKJ3AEoJlTUU7ixGkIi3dJqNW1jAshrKOa
	CzPKcQt2DHkx0xGnL9+DZr9COPecZhMDQq0PnDiUP2XvVfhp0YZQIlCF5PP5/Jt3vPMAYDgMm7V
	F6JH3yY2N/C/DuKj2VsCCKd+FW6hll+xSAkACiINAx8Z1qirM2Q2pA0MKF1Si9afMcP1uhgI9RR
	/UCN/a1b9rWwhjoo7gUWNvMLB0Z2xD86dp/VSbzUHx1Cepr8CmlLT+ptlqtPdGVZILPIVAL2kbZ
	eDg==
X-Received: by 2002:a05:600c:3554:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-434d09b0020mr48636915e9.6.1733304522268;
        Wed, 04 Dec 2024 01:28:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEujwNpRBwluk2zpQ1Yet+Ecjg4bwyX/zVe4UezRqTVJMMizFZiaTPX/p8MoKgtkYxHhiPB0g==
X-Received: by 2002:a05:600c:3554:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-434d09b0020mr48636675e9.6.1733304521850;
        Wed, 04 Dec 2024 01:28:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5307400sm17785025e9.38.2024.12.04.01.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:28:41 -0800 (PST)
Message-ID: <cee06baa-8561-4be3-8f5c-ca453f58950b@redhat.com>
Date: Wed, 4 Dec 2024 10:28:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
To: Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
 <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
 <96c92857-4850-4f85-9474-ac193c5ea48c@redhat.com>
 <04c1d28e-bbea-4499-9a6d-770f9ca53ba9@suse.cz>
 <d736f1c0-343e-4031-88ba-3b33b73dbeba@redhat.com>
 <Z1AaC5Hj2RV_5FDD@localhost.localdomain>
 <15096b27-6f27-45fc-8a8b-de781a9c42a5@suse.cz>
 <Z1AdotZfAJG-zVZX@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z1AdotZfAJG-zVZX@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.24 10:15, Oscar Salvador wrote:
> On Wed, Dec 04, 2024 at 10:03:28AM +0100, Vlastimil Babka wrote:
>> On 12/4/24 09:59, Oscar Salvador wrote:
>>> On Tue, Dec 03, 2024 at 08:19:02PM +0100, David Hildenbrand wrote:
>>>> It was always set using "GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL",
>>>> and I removed the same flag combination in #2 from memory offline code, and
>>>> we do have the exact same thing in do_migrate_range() in
>>>> mm/memory_hotplug.c.
>>>>
>>>> We should investigate if__GFP_HARDWALL is the right thing to use here, and
>>>> if we can get rid of that by switching to GFP_KERNEL in all these places.
>>>
>>> Why would not we want __GFP_HARDWALL set?
>>> Without it, we could potentially migrate the page to a node which is not
>>> part of the cpuset of the task that originally allocated it, thus violating the
>>> policy? Is not that a problem?
>>
>> The task doing the alloc_contig_range() will likely not be the same task as
>> the one that originally allocated the page, so its policy would be
>> different, no? So even with __GFP_HARDWALL we might be already migrating
>> outside the original tasks's constraint? Am I missing something?
> 
> Yes, that is right, I thought we derive the policy from the old page
> somehow when migrating it, but reading the code does not seem to be the
> case.
> 
> Looking at prepare_alloc_pages(), if !ac->nodemask, which would be the
> case here, we would get the policy from the current task
> (alloc_contig_range()) when cpusets are enabled.
> 
> So yes, I am a bit puzzled why __GFP_HARDWALL was chosen in the first
> place.

I suspect because "GFP_USER" felt like the appropriate thing to do.

Before:

commit f90b1d2f1aaaa40c6519a32e69615edc25bb97d5
Author: Paul Jackson <pj@sgi.com>
Date:   Tue Sep 6 15:18:10 2005 -0700

     [PATCH] cpusets: new __GFP_HARDWALL flag

     Add another GFP flag: __GFP_HARDWALL.


GFP_USER  and GFP_KERNEL were the same thing. But memory 
offlining/alloc_contig were added later.

-- 
Cheers,

David / dhildenb


