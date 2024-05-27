Return-Path: <linux-kernel+bounces-190176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863CE8CFA98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1415D1F213B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296FA3C463;
	Mon, 27 May 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPk5ff3e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F17381D5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796435; cv=none; b=rLd7DjNrzily6cdt+8Y/gxmKw1lJc7pAAQRkoincn93x/lortkriRFjbL7Mo25tTjV8RgWhU6FBYI9f1bnUPvaVfinMzHPlIq8f6lAudLs3H1QbOwRzpR5qOHilEyWKpcBGSCEV1LahmyC4r8/7+JJA055db0kpM7/ezhaKKL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796435; c=relaxed/simple;
	bh=fpYNTSg0sOLbnS+sAN/5LNQ/1717jIrVECRrIyAB/6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYQDBY9WWCuknLUEPLOyRATaCrkkNX3aNdBCTtHOogZas5l3Mr0I9vtUniuIH6WuzibZ/8/EEAmuXXnBmuyE1MwnDi2DkVbJ9XJJHVhIUFkdQDO6e/YoySj30WKk5qxKbeOUkIRH7uQ9Kx0KvNXjbypGU/Wja0pydqqt5h7uAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPk5ff3e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716796433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94Nn+gDWguFMQFL1W0OycJxi9V0LL/+VpNzMqcw5SdI=;
	b=ZPk5ff3eP4gDXiCNJI4RnQOpfQw3knBMQD3gtSpUhCBBrVviYFoWaAbmO8oLpBypITxq3b
	PQrwh8KuRgzSCovHhwEn0DaCFz3tErFAEClf7T8+D0dPIY36oYeo7c2pJKHbNMUmy5Nq3c
	a6cx7zRmVd2XPF9KuTw9H4YKOrQhQgI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-THHCDxFjOr-tAHPSWPAorg-1; Mon, 27 May 2024 03:53:50 -0400
X-MC-Unique: THHCDxFjOr-tAHPSWPAorg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e97c6f1a74so2932741fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796429; x=1717401229;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94Nn+gDWguFMQFL1W0OycJxi9V0LL/+VpNzMqcw5SdI=;
        b=mCzHsBp/ZtYs/SlXwxd8qnip4+TrFBFpy9nMkv45LvIwbIMmS8QMMYTjnVKmhm6Ewq
         BrDocPC51QxueXEwfNmU77CKfduiveGd+WvWlvI1M00z3WMqMe4buEWi6Vw1M9GHCq1B
         /FOhlWZQ8eq0L4EI4gJ+rpqsfWw968AIPPkNdMGGjCfJxVXCpKQXZyQVuFLDRDVpiH13
         XKYEIB9frRe1LFRiKcq9kii3DdXBrumsdCovqBDMhDh9KsnbMRa6v2mhYafSSpAuEYEu
         xt6rwLTfmEtKO7yzhyg0IcmGYe/aPO7+PyeraMa1zpAS05S0rGkdhxrT8n+rytHQe2gA
         RiOg==
X-Forwarded-Encrypted: i=1; AJvYcCWk/ORaYLYNoAnBQT7a6sNzKi4iLo+hN+bFK1wqdSMJjr7EZTw/56QWMLMlzqp4+FGKBvbAPSIld08+k/gu9YjOyHdbFofBqmpJOmfq
X-Gm-Message-State: AOJu0YwElOnz7DQFZ20AFuwqC2ZzU/qZ2UuC/0xB/TuUfmELCc+jLBSY
	1OtnxYm3QO6xWkTyUvZvr3NKI8AnZi1hDxUGNl73qdJ+9FYfrncKCdgU6VK105YyaN8cXBiB8Vk
	SqRD+ogYjFfBosZ+0SDnkEENu+oqRx5TaYQSziI77sXIR9UyrXETGJQbmwOLM2w==
X-Received: by 2002:a2e:9bc6:0:b0:2e9:7417:bb0a with SMTP id 38308e7fff4ca-2e97417bbe0mr18593031fa.3.1716796429006;
        Mon, 27 May 2024 00:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7UsmrWTRpKTMmDwSTymTCt/+SN36zCsBuKQO3VhRHcXruZ8UCSn/4VhRRIuJyyC4L2SEuhw==
X-Received: by 2002:a2e:9bc6:0:b0:2e9:7417:bb0a with SMTP id 38308e7fff4ca-2e97417bbe0mr18592911fa.3.1716796428423;
        Mon, 27 May 2024 00:53:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm132541905e9.4.2024.05.27.00.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:53:48 -0700 (PDT)
Message-ID: <8201bd1d-f617-491b-a10d-1fe689e9eb9b@redhat.com>
Date: Mon, 27 May 2024 09:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm,memory_hotplug: Remove un-taken lock
To: Brendan Jackman <jackmanb@google.com>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-1-6d53706c1ba8@google.com>
 <78e646af-e8b5-4596-8fbf-17b139cfdddd@redhat.com>
 <Zk4AwwX7x426KU7H@google.com>
 <0506ae4e-e17d-4c3c-aa3e-1cea04909e5a@redhat.com>
 <ZlCB5bFnafw_zE8Z@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <ZlCB5bFnafw_zE8Z@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 24.05.24 um 14:02 schrieb Brendan Jackman:
> On Wed, May 22, 2024 at 05:24:17PM +0200, David Hildenbrand wrote:
>> On 22.05.24 16:27, Brendan Jackman wrote:
>>> On Wed, May 22, 2024 at 04:09:41PM +0200, David Hildenbrand wrote:
> 
>>> By the way, some noob questions: am I OK with my assumption that it's
>>> fine for reader code to operate on zone spans that are both stale and
>>> "from the future"? thinking abstractly I guess that seeing a stale
>>> value when racing with offline_pages is roughly the same as seeing a
>>> value "from the future" when racing with online_pages?
>>
>> Right. PFN walkers should be using pfn_to_online_page(), where races are
>> possible but barely seen in practice.
>>
>> zone handlers like mm/compaction.c can likely deal with races, although it
>> might all be cleaner (and safer?) when using start+end. I recall it also
>> recalls on pfn_to_online_page().
>>
>> Regarding page_outside_zone_boundaries(), it should be fine if we can read
>> start+end atomically, that way we would not accidentally report "page
>> outside ..." when changing the start address. I think with your current
>> patch that might happen (although likely extremely hard to trigger) when
>> growing the zone at the start, reducing zone_start_pfn.
> 
> Thanks a lot, this is very helpful
> 
>>> Also, is it ever possible for pages to get removed and then added back
>>> and end up in a different zone than before?
>>
>> Yes. Changing between MOVABLE and NORMAL is possible and can easily be
>> triggered by offlining+re-onlining memory blocks.
> 
> So, even if we make it impossible to see a totally bogus zone span,
> you can observe a stale/futuristic span which currently contains pages
> from a different zone?

Yes. Note that zones/nodes can easily overlap, so a page being spanned by 
another zones is common and supported already.

> 
> That seems to imply you could look up a page page from a PFN within
> zone A's apparent span, lock zone A and assume you can safely modify
> the freelist the page is on, but actually that page is now in zone B.

That's why we obtain the zone/node always from the page itself (stored in page 
flags). This data can only change when offlining+reonlining memory (and 
pfn_to_online_page() would refuse to hand out the page while temporarily online).

There were discussions around using RCU to improve pfn_to_online_page() racing 
with memory offlining, but the motivation to do that has been rather small: we 
barely see such races in practice. Memory offlining+re-onlining simply takes too 
long.

> 
> So for example:
> 
> 1. compact_zone() sets cc->free_pfn based on zone_end_pfn
>    2. isolate_freepages() sets isolate_start_pfn = cc->free_pfn
>      3. isolate_freepages_block() looks up a page based on that PFN
>      3. ... then takes the cc->zone lock
>      4. ... then calls __isolate_free_page which removes the page from
>         whatever freelist it's on.
> 
> Is anything stopping part 4 from modifying a zone that wasn't locked
> in part 3?

Likely that overlapping zones already exist and are handled accordingly.

-- 
Thanks,

David / dhildenb


