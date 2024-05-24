Return-Path: <linux-kernel+bounces-188659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246458CE504
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FCA1C2149F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6585937;
	Fri, 24 May 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBozcTGO"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319B839FC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552178; cv=none; b=qAuh8gTvO5FMBCUdo7IEV6VpXiY2EYTS4DktyUp5FSv8AwTirJJbiNy0mUcqN3Pa1c5clQlJDecHgOGgq+9NSANi/aO7Ky1Nw3PPeED3+zr39QWzLz3ZrrmrfgzCYXlaaOWI2rkS4YXQPCvdkwWlUVAIOJgqdt4gcXgNRTtbox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552178; c=relaxed/simple;
	bh=6FLeUIl5aTYaCyanbXBSdAUyvPTtp/HPDKql8A7n4AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcqtnmX9gkXxRgY7T8fIiJukHywMgvb8yq31Q64i7RInc6v/ZA3MAOaafJ8jmSbMzjAuzf3N9JQ/SnWVnzPLmRRdGmayYM/++TxTIl+k2ugPHux5mI3SjPv3p5lUA5FltTn0RJM5D6EQTZwu6PU5m7cOeIeNoqN8ZhQ/5+OmASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBozcTGO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-420107286ecso72165e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716552175; x=1717156975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLDLdXYwwkToVr8Cvp+hiWbFyJwd77OjF46C3hbvTe4=;
        b=cBozcTGOpsEdizG7Kep+0Aga4dLE8YbCiKoaFbdqhcM+wCSuxgdbSyxMs3saQicX/B
         og1Um1dnBSWvLEP3w70cYMFt0bq4EvOAT71efGTPMdcFbV8GoPbUWQnOjoUo3LcNYOaD
         0rJbee7XoVhljWZU07zo/QUvmiFra56SP/SA9IU3cZvXIVd+Iqrl5kf+N7KHQ7QzMId5
         FAbSRCRkss6J/Fb3QSL7ZXmqK7FRg6ze0TCoD3g2YzjBPaqiHnjd79fXbZqL6iogsl6q
         cotm8sh6AOHg2xC3Eec0LHf+eJxZ0Fs3Q6RqrduwdpkiqIgthRqN7Ab5knbFh4wLcz1v
         VYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716552175; x=1717156975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLDLdXYwwkToVr8Cvp+hiWbFyJwd77OjF46C3hbvTe4=;
        b=p5UidNWU83sXZXS+witOy9aSE7iKzUPMkYsLVQr+CV3ntghF5D1jR8XPfq0krQ4Vgd
         BiflAf2MLDWqgyw5utC6u5S8ArEJzmGoD9kctNtis0NwBdub1P2y5m27wpUKnFRBFylI
         6nsSN5bjDPbE0xbUnhXlXvP+fEeDYoDJLOL+JNbKVMZmlGpZbo8GrrouUlagLTNeG8cD
         McpusBGpyxWIifAlw3jhcn2uxu7ddu0LWMUq7tXkD36GXHMARXbQ0hVp3zX4VHFSAMqy
         M/v9m2h8W71/vb+xVfrWw0dydodY3QXZWwzpe2HeHZHX6V9Tudw6ZLCQHKv6hoYOBJA5
         Fzdw==
X-Forwarded-Encrypted: i=1; AJvYcCVvPiH+nNSZ0oAYawGwfCrf4aXkyf56JoR2hunjuDgpcI1+RzyInEbBlFdXeXUt5gMul6DoN1e45MLvMhs1e2e9KQkcYSZh+arVgq55
X-Gm-Message-State: AOJu0YwzzW7bc092uB7r6GcdiaopgBoaeB2n8Kt0cx7DMBVgaSVyWF+B
	FNPRbG/nEsHMz7rHy6PJfnr/7t8TreD90W9VcitnP8qO56Y+NZ0KVwqbZicJ2g==
X-Google-Smtp-Source: AGHT+IHBz2OtaFxzTtLCx3Q8o844GxjnoTVVIQiqS0otNnrBXZRKPB+Oi84Q3A4D/WxrbMUNsob+Bw==
X-Received: by 2002:a05:600c:1e04:b0:41b:4c6a:de7a with SMTP id 5b1f17b1804b1-42108dc191amr1284895e9.3.1716552174495;
        Fri, 24 May 2024 05:02:54 -0700 (PDT)
Received: from google.com (49.240.189.35.bc.googleusercontent.com. [35.189.240.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08abd8sm1451216f8f.32.2024.05.24.05.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 05:02:53 -0700 (PDT)
Date: Fri, 24 May 2024 12:02:45 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm,memory_hotplug: Remove un-taken lock
Message-ID: <ZlCB5bFnafw_zE8Z@google.com>
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-1-6d53706c1ba8@google.com>
 <78e646af-e8b5-4596-8fbf-17b139cfdddd@redhat.com>
 <Zk4AwwX7x426KU7H@google.com>
 <0506ae4e-e17d-4c3c-aa3e-1cea04909e5a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0506ae4e-e17d-4c3c-aa3e-1cea04909e5a@redhat.com>

On Wed, May 22, 2024 at 05:24:17PM +0200, David Hildenbrand wrote:
> On 22.05.24 16:27, Brendan Jackman wrote:
> > On Wed, May 22, 2024 at 04:09:41PM +0200, David Hildenbrand wrote:

> > By the way, some noob questions: am I OK with my assumption that it's
> > fine for reader code to operate on zone spans that are both stale and
> > "from the future"? thinking abstractly I guess that seeing a stale
> > value when racing with offline_pages is roughly the same as seeing a
> > value "from the future" when racing with online_pages?
> 
> Right. PFN walkers should be using pfn_to_online_page(), where races are
> possible but barely seen in practice.
> 
> zone handlers like mm/compaction.c can likely deal with races, although it
> might all be cleaner (and safer?) when using start+end. I recall it also
> recalls on pfn_to_online_page().
> 
> Regarding page_outside_zone_boundaries(), it should be fine if we can read
> start+end atomically, that way we would not accidentally report "page
> outside ..." when changing the start address. I think with your current
> patch that might happen (although likely extremely hard to trigger) when
> growing the zone at the start, reducing zone_start_pfn.

Thanks a lot, this is very helpful

> > Also, is it ever possible for pages to get removed and then added back
> > and end up in a different zone than before?
> 
> Yes. Changing between MOVABLE and NORMAL is possible and can easily be
> triggered by offlining+re-onlining memory blocks.

So, even if we make it impossible to see a totally bogus zone span,
you can observe a stale/futuristic span which currently contains pages
from a different zone?

That seems to imply you could look up a page page from a PFN within
zone A's apparent span, lock zone A and assume you can safely modify
the freelist the page is on, but actually that page is now in zone B.

So for example:

1. compact_zone() sets cc->free_pfn based on zone_end_pfn
  2. isolate_freepages() sets isolate_start_pfn = cc->free_pfn
    3. isolate_freepages_block() looks up a page based on that PFN
    3. ... then takes the cc->zone lock
    4. ... then calls __isolate_free_page which removes the page from
       whatever freelist it's on.

Is anything stopping part 4 from modifying a zone that wasn't locked
in part 3?

