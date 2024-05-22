Return-Path: <linux-kernel+bounces-186427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD28CC40A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3451F24827
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0685FBB3;
	Wed, 22 May 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMgsTKHK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660F2374C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391464; cv=none; b=koSalutpcQPFQiiIdkWIH4xD/qGczvuuV1a0rFU/MyD+TxffdkN7T6qfm421I2UhCLWtE//XVq9QW06m/TFA8vLoTDPX3pnikgNwREO8aOg48BbDfBaDSJcMKVO4v9aLH6PLEPN0/QQzru95Bap02HzjZCyJXbFpW269r6VkUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391464; c=relaxed/simple;
	bh=P+lzOOlaGpgWda58lk3P3HWjglRcpbJ+OUHm6vUAfu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4vNlf4bl/zl544fjEQt+Eel0deA0J534aRznHqnr50Xb6TELKAF1c23CT5xy36UOl+Klsfbi5Csl66/HZC97PHaSdE6tzjdlNzc213E6cu43xEutciDbl+HPiNkKM/LfI+jf2E5VeXOFQdO/saSagvCVi3bo58vYU8Bky6Y6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMgsTKHK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716391462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m+mhkpTv+NJSzWYK8VRk2CSl69V/PbKP/qULxUSSVAU=;
	b=dMgsTKHKbKlvfjmWR/CF7zQvl0D6y2k9JPUZtHCzEy7bh94lSCv8nR8Qnwk6jvjClZB7F7
	RqVIyQPwRONdPM0AZc19RP3z9krun4YaCdQvu1fls6ypNYHg1NI0vtilbOypOIxUFC/hOo
	gjkwWSnXR1h1VWs0yz7VEZeN9NoqZVA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-7h-6jKsxNBS1_l9JppzR4A-1; Wed, 22 May 2024 11:24:20 -0400
X-MC-Unique: 7h-6jKsxNBS1_l9JppzR4A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354f44ebfe7so194194f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391459; x=1716996259;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+mhkpTv+NJSzWYK8VRk2CSl69V/PbKP/qULxUSSVAU=;
        b=kQjFoNO9drMMLTwMvjfyeaGZFQrjw+vG+BdkYH+MZcV+F5VTCBaaoeteGtBaEXdGfl
         wABKSe4rtY68W+e0fj0s3NFmtUzJOI1E/wl1I8+TiLRuGDBJNrZmaVySCgHyhYd/+2hp
         BNZQ7V3fk1xG74jSQgwDxtLy2N7EW6/zI765vGCfHgY7FLHmTfcYOTKBoZjpAxfsx2vn
         uPHwvhUPdQFTv3qv+Rs3MrPvfpHCWTQ4hkJymiMKvN+PcubOxArUCm/vxT0X0laj+shr
         IGQMt9MLQKnu/N1cnPk37SoII30rmWGyTLsxiOuLPrgeHLokvyf+TW6dNfJdjkxp+Moo
         S31g==
X-Forwarded-Encrypted: i=1; AJvYcCWoQtpeE/rd4UHeaBcv01x1L7oWMWpdHKPK6v2gQGZyh+Yx6rGk8H2Jbr8tmGS4GHfuAuNn2l36eThCONIZqfsIAj2LgrYbDvtP9en8
X-Gm-Message-State: AOJu0YwSWdqLly1CJ+Qj1HaYfnmi/6v2BTzWwfSRy+2uY5K8SnzXE4AC
	AWM8+Fl6rnZfq2QRLlGh1lJSR6HZ3LcycN7lkoKBtz1c1sRVqa4MciL0FXPfdE5VaNDFKFeo2oB
	JFj8YuBVaiFI6+0sHcygA7PaZ9+bNqQ7ZYctPSrRTLD7t9SGO27HYLYwmN2vuzQ==
X-Received: by 2002:a5d:5486:0:b0:34c:cca6:3d18 with SMTP id ffacd0b85a97d-354d8db5facmr1571197f8f.68.1716391459393;
        Wed, 22 May 2024 08:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGutS7FBmF017POZVizQtPXJkzsbPVaYLE7ujM0syhekzXALUfZPfC/MWF0Pm+CSU/Rv7OqXw==
X-Received: by 2002:a5d:5486:0:b0:34c:cca6:3d18 with SMTP id ffacd0b85a97d-354d8db5facmr1571177f8f.68.1716391458949;
        Wed, 22 May 2024 08:24:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d500:4044:6d4c:f060:f677? (p200300cbc709d50040446d4cf060f677.dip0.t-ipconnect.de. [2003:cb:c709:d500:4044:6d4c:f060:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bdc7sm34502308f8f.22.2024.05.22.08.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 08:24:18 -0700 (PDT)
Message-ID: <0506ae4e-e17d-4c3c-aa3e-1cea04909e5a@redhat.com>
Date: Wed, 22 May 2024 17:24:17 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zk4AwwX7x426KU7H@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.24 16:27, Brendan Jackman wrote:
> On Wed, May 22, 2024 at 04:09:41PM +0200, David Hildenbrand wrote:
>> On 21.05.24 14:57, Brendan Jackman wrote:
>> The old seqlock guaranteed that we would have obtained consistent values
>> here. start + spanned_pages defines a range. For example, growing a zone to
>> the beginning implies that both ranges must be changed.
>>
>> I do wonder if it might be better to instead have zone->zone_start_pfn and
>> zone->zone_end_pfn. That way, both can be changed individually, not
>> requiring adjustment of both to grow/shrink a zone at the beginning.
> 
> Thanks this is a good point.
> 
> So basically the fact that spanned_pages is "once or eventually"
> correct is certainly not enough because it only has meaning with
> reference to zone_start_pfn. I didn't realise this because of my
> spontaneous inspiration to believe that zone_start_pfn was fixed.

Right, it isn't.

> 
> By the way, some noob questions: am I OK with my assumption that it's
> fine for reader code to operate on zone spans that are both stale and
> "from the future"? thinking abstractly I guess that seeing a stale
> value when racing with offline_pages is roughly the same as seeing a
> value "from the future" when racing with online_pages?

Right. PFN walkers should be using pfn_to_online_page(), where races are 
possible but barely seen in practice.

zone handlers like mm/compaction.c can likely deal with races, although 
it might all be cleaner (and safer?) when using start+end. I recall it 
also recalls on pfn_to_online_page().

Regarding page_outside_zone_boundaries(), it should be fine if we can 
read start+end atomically, that way we would not accidentally report 
"page outside ..." when changing the start address. I think with your 
current patch that might happen (although likely extremely hard to 
trigger) when growing the zone at the start, reducing zone_start_pfn.

> 
> Also, is it ever possible for pages to get removed and then added back
> and end up in a different zone than before?

Yes. Changing between MOVABLE and NORMAL is possible and can easily be 
triggered by offlining+re-onlining memory blocks.

-- 
Cheers,

David / dhildenb


