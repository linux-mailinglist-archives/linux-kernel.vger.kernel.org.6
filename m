Return-Path: <linux-kernel+bounces-572705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9763A6CD97
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 01:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078413AE829
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 00:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC51FC0FA;
	Sun, 23 Mar 2025 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hClIcA9S"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E33194C96
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742691512; cv=none; b=Pb4K+VMwhoKS7I40byIrqTV68r5Nd539sZA7Z2UnYSdZAMNJrGwgcEVRunlH2PAdwUD0sD7UA1740wziXvFu93pBAqT77jXR5KOHKS8LHUKXVlOQILy0kjw+u7pGOk3pQFClrLextfqECDGv1h1YjZIJJrMsW4SiLu+gPYR8s40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742691512; c=relaxed/simple;
	bh=mAw2/DsVZbnbNFqZ/aVY8p4FFJUIIPE0GawzBjPSeS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAXUx6iqZYee9bHhjB4cDYGrdPnf9aPYnwgUIFlWGTs9YfnTokeiahjLS/AHcPTWRfhukBczEgk0eQSQophqi+IxLi50ead9zYeEWK3Da7NVZPe09IKozkJQQRpQtajlkjMEkbAr64gA4hq7ZKZBv4Eh55CR0cwtMjF5ynKAVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hClIcA9S; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ecf0e07957so2578466d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 17:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742691508; x=1743296308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeEPSpi+LouXy84gWofWuqLxs44DebxEJYRwtj0CHQ0=;
        b=hClIcA9Saoa958GnC550C3nXkxpQWxfwnQqLtpeVEkbPTqXGbgSCr8rxhrfQ656OpK
         UXWNrSo9Has+ko4vHju/EL7VsPs+yfxSZJj1ADNW9aVPaizGm1UG0Zq7/8ebI9UhWMzU
         mcqHoM01YF7j8kbatClHh/V4+fS46Ve+TWt+4JmwqTTz3CpQHEKYfLAaus2X5/rYVCfx
         1lRkYytfcRc28xKbfbusJ0X3Xo4yRJoMTMFgvUv47zjM6uJ/a/lVqdwKN/7uP3ZLmPez
         KfeJYOUSWWld9LGIhKnNO08WmoHcGaE0432bqtMqU1YBSiOV4YV2Oj+k82xXmel5JxQC
         1UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742691508; x=1743296308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeEPSpi+LouXy84gWofWuqLxs44DebxEJYRwtj0CHQ0=;
        b=fjCzxsFDVgluWjE2rLZIRIBepcJC1SJEVutaq5g5VkVG4GiWPAbAJS4AFgwuznt2x6
         Rl6TxpQ5wUWqPfnN4TjETs4k8/rp8wXVr4SccX8nrQLvUEVODUtn5dVLgyUF+qvlQg3E
         dn6Y8Ot+FhLFFyhPawGp9nKiA/f/duW1mC5UWql+rWUfAnPm/CH9UBpxkrso3Sxy/aom
         QrEvd0uXZt5+EdP4z6PjCVpn0wnm3kyOLWp3BNNOmcOSJT7iQLzSXgbTphCE+ysy5aKZ
         adg46jcqr8NWCboAWdGrousQU4Jz6k7shM1rCvqdQApenGaufrFPP+UdUWP2oo+w/j9D
         g0wA==
X-Forwarded-Encrypted: i=1; AJvYcCXhH/49Bwha4yAYYpGvR6C9oNWZsiUDNiIqZDR8xDsMXSAOypi6+uLGiWQsASpYtauJxITVUpNmxfF9KZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU35UTZcOJtwz5EtPHJAOcTk096Or/qHzntOKiak+LSfF3Njzi
	UQU+LwXA/GBVKZmc/vjJANqFStb/PElnKqdZcAf6n7Oypxv/Haw+HoZd/3DuIIw=
X-Gm-Gg: ASbGnctRDCVfm8ATJU+tfD9/54VkVXGU14+0fEh1jORNVKuF89CrppzW1nu4Qj91tJq
	7INtGaumREqm1Pi+U74dGS/yIZ0kvB2h+cZ1F9jMOJLLw0p3MmZHTX0wSbln3hA8/BnUDXKpQV0
	gbVMUY6XiuxLWIhUGwaVQ9fcI+N49oOry9FW30smHm3hY5goPXkwpkPRQtB0KlRlSIUz7kyH4Td
	+K1nzZaoftdqCzM8035lo4mVUpBfY7sqJXBoN6UDd5mcHtqK6Mjhjm4zjSL08OuLImWzVWvT8JS
	zNkJyEbHTpsDWWj8u1dTM7GG77uLKYyvUTr0aDa2x1Y=
X-Google-Smtp-Source: AGHT+IEEHlubSb2PqXumVDJJbARdcGgmHLjdwg+WVivkPmYNYOKDMb0d62YkgtAOTCepL4GbgJ3inA==
X-Received: by 2002:a05:6214:1d24:b0:6e6:61f1:458a with SMTP id 6a1803df08f44-6eb3f2c8664mr116957126d6.14.1742691507736;
        Sat, 22 Mar 2025 17:58:27 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef1f5d8sm26728796d6.45.2025.03.22.17.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 17:58:27 -0700 (PDT)
Date: Sat, 22 Mar 2025 20:58:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
Message-ID: <20250323005823.GB1894930@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-4-hannes@cmpxchg.org>
 <D8MVZ8L12HJN.1LN4G4H0ESLY6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8MVZ8L12HJN.1LN4G4H0ESLY6@google.com>

On Sat, Mar 22, 2025 at 04:05:52PM +0100, Brendan Jackman wrote:
> On Thu Mar 13, 2025 at 10:05 PM CET, Johannes Weiner wrote:
> > +	/* Reclaim/compaction failed to prevent the fallback */
> > +	if (defrag_mode) {
> > +		alloc_flags &= ALLOC_NOFRAGMENT;
> > +		goto retry;
> > +	}
> 
> I can't see where ALLOC_NOFRAGMENT gets cleared, is it supposed to be
> here (i.e. should this be ~ALLOC_NOFRAGMENT)?

Yes, it should be. Thanks for catching that.

Note that this happens right before OOM, and __alloc_pages_may_oom()
does another allocation attempt without the flag set. In fact, I was
briefly debating whether I need the explicit retry here at all, but
then decided it's clearer and more future proof than quietly relying
on that OOM attempt, which is really only there to check for racing
frees. But this is most likely what hid this during testing.

What might be more of an issue is retrying without ALLOC_CPUSET and
then potentially violating cgroup placement rules too readily -
e.g. OOM only does that for __GFP_NOFAIL.

---

From e81c2086ee8e4b9f2750b821e104d3b5174b81f2 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Sat, 22 Mar 2025 19:21:45 -0400
Subject: [PATCH] mm: page_alloc: fix defrag_mode's last allocation before OOM

Brendan points out that defrag_mode doesn't properly clear
ALLOC_NOFRAGMENT on its last-ditch attempt to allocate.

This is not necessarily a practical issue because it's followed by
__alloc_pages_may_oom(), which does its own attempt at the freelist
without ALLOC_NOFRAGMENT set. However, this is restricted to the high
watermark instead of the usual min mark (since it's merely to check
for racing frees). While this usually works - we just ran a full set
of reclaim/compaction, after all, and likely failed due to a lack of
pageblocks rather than watermarks - it's not as reliable as intended.

A more practical implication is retrying with the other flags cleared,
which means ALLOC_CPUSET is cleared, which can violate placement rules
defined by cgroup policy - OOM usually only does this for GFP_NOFAIL.

Reported-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c01998cb3a0..b9ee0c00eea5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4544,7 +4544,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	/* Reclaim/compaction failed to prevent the fallback */
 	if (defrag_mode) {
-		alloc_flags &= ALLOC_NOFRAGMENT;
+		alloc_flags &= ~ALLOC_NOFRAGMENT;
 		goto retry;
 	}
 
-- 
2.49.0


