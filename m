Return-Path: <linux-kernel+bounces-541857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF808A4C276
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42AF18932E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F51E212B17;
	Mon,  3 Mar 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYRIp/cl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDC282F1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010120; cv=none; b=dYEKy+6ZAKuona9iWWfO2qEs6R+a1KtNHani8EhIf4iizvFWBJu1qi5LZtGeaCbMn/lI+MLb2TK72LhqP6lOdWFU+saqLPo3IcXE5spu3f1FPnBuiZviy8KV842bMiQDx46H6yDuSwGtH+zhzC5iV2ndayYx1A6MaOohNBdM0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010120; c=relaxed/simple;
	bh=vdOoMJhwrJN7PIeceeGvIKRvNzjuzfjMVD10K4Ghn1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQaIjF6TS6w0wJ8RJ212SUgaZlqSba1sfET4mY240/rxJD+XyINvHZS4l3E97CR33a5t7sKiKyLUflVwBvL7JFDvMqqqtTzU5yzsuIhdCtXdLnqUg5n0PxlqMS+UWWHRj4mn+77rNwv1/ypKquWcdXfERdUmoWG5GwczygcgJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYRIp/cl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so77515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741010116; x=1741614916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+Nhg1GuXJKivFMPeLjLk1SXPuuwLJQbXpnkpy0/hFw=;
        b=xYRIp/clxVwShBwbS524C6qgUMe2DSOiOUYIaLnHD0Xqn1hEDfmBmX9DmzNeGqFilh
         Q44Tvv0injGYxbOGEF6RyvWd01fTWpi+RnOWEgoIN/kiwlaDMmXysyfGLatkcTcilq9t
         XEBECUkq/NRg5F6PhOfwjxRzzcEA+Ydgx6+elMnC48NmR15HuvwukfvMYVPaaevC/1Ww
         bWjBz5i23aH9bDiJ3jAyslxV5vy/QCBgEFs6seqpW6bMm2JfgjSNF5FAVcOkm7E6bwdx
         AjHVNqOFEoJecsr4HL//00kgpXEVRlDtpCyD8GtawUnCuCxpmAPkpDmoTxkoiE0YglQG
         +Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010116; x=1741614916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Nhg1GuXJKivFMPeLjLk1SXPuuwLJQbXpnkpy0/hFw=;
        b=uowuAdtmOjV5JlXpFrWvvcOkDTwnp+SMph5lVzfVgMSwru4+VKDP/aSq37bIDMX/M4
         fhPJ9UMVcZkQzgq4K+zZeZnq+9CvHA5gWYugUTXq56a9ZmlDcWllwxYpkkY3hNIFdldp
         ZM/JO4bH8uvbOaoS3H0vKeeRxIIt6V9sWKTbPEPH6JNRfslXWQXbSXLkFh86CZY1BD+G
         bPdq2T6j0bHhOfV1Prb+klepkLc338gXX0ejpWbBfkUhrVLzFP7VtAAJjSzIihyU7pRD
         M/TEBLHZc6g5Eyz8XlMQUqCqu9EDrxdgLl6My8Gwo4DUHNkrl7MRyBXcUX2Z2urUtwLx
         2olg==
X-Forwarded-Encrypted: i=1; AJvYcCVWRu1gVfYuf75hUmyxA+6b1m+wjonemt58c3CrmXZ40C0bCpB6oZi5O4/iJBeQwknhDy9fuBIIi4G6k4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPHoeAoqGNTLiUGhi35M5nNmLO4TduMJEycxk0Ljts2wV777J
	gnxI2zw7/G2p+SqSmvzAOisw6+FhWktqfcL2mUca1OzgAMp382zrkzfB9E6CWg==
X-Gm-Gg: ASbGnctua2O9BCZTOM0jfiCT+1Rd7pVWDPeE+2sO1NON2CDuHxzOAGbX8fJ+k5jU0MP
	9Mxt1yejz1SCk+8bWDeT7twHdpwB/I+wGEtgip4LDV/JT5CT3Xlr8iwjKSx6Bplmkbvama0TXyc
	kDVhjS43YBMXaK9oBTFpg8ZkO/FBGDiHj6bMexB/FHCz1F2PjPtUhNuLSciHuWszFbIN1fVm3vz
	p2uzHayWHoWj1IvPnqwxUo42qiAcOxoW+ZThA0nkuWAANLb9JJWdnGQnMX6xI2KFNX8q31M9cb9
	pYlGD+/KoE61jrLMmVcJ7eqVy/n3hrKYYNzseuKfqcNjR4CRYV4vR8w8drvDZ4AP5sBVWem929r
	XnyV3
X-Google-Smtp-Source: AGHT+IHAa7w6RixSNxrVTUkit3J59PlQoncx+lgIQm8IIFvB07cSe2Js5coLyQ9uGviuYVoLUWXybw==
X-Received: by 2002:a05:600c:6b72:b0:439:7fc2:c7ad with SMTP id 5b1f17b1804b1-43baff12452mr2552905e9.7.1741010116420;
        Mon, 03 Mar 2025 05:55:16 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm14873656f8f.60.2025.03.03.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:55:15 -0800 (PST)
Date: Mon, 3 Mar 2025 13:55:11 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: Add lockdep assertion for pageblock
 type change
Message-ID: <Z8W0v0LjuyH8ztTQ@google.com>
References: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
 <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>

On Mon, Mar 03, 2025 at 02:11:23PM +0100, David Hildenbrand wrote:
> On 03.03.25 13:13, Brendan Jackman wrote:
> > Since the migratetype hygiene patches [0], the locking here is
> > a bit more formalised.
> > 
> > For other stuff, it's pretty obvious that it would be protected by the
> > zone lock. But it didn't seem totally self-evident that it should
> > protect the pageblock type. So it seems particularly helpful to have it
> > written in the code.
> 
> [...]
> 
> > +
> >   u64 max_mem_size = U64_MAX;
> >   /* add this memory to iomem resource */
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 579789600a3c7bfb7b0d847d51af702a9d4b139a..1ed21179676d05c66f77f9dbebf88e36bbe402e9 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
> >   void set_pageblock_migratetype(struct page *page, int migratetype)
> >   {
> > +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
> > +		in_mem_hotplug() ||
> > +		lockdep_is_held(&page_zone(page)->lock));
> > +
> 
> I assume the call chain on the memory hotplug path is mostly
> 
> move_pfn_range_to_zone()->memmap_init_range()->set_pageblock_migratetype()
> 
> either when onlining a memory block, or from pagemap_range() while holding
> the hotplug lock.
> 
> But there is also the memmap_init_zone_device()->memmap_init_compound()->__init_zone_device_page()->set_pageblock_migratetype()
> one, called from pagemap_range() *without* holding the hotplug lock, and you
> assertion would be missing that.
> 
> I'm not too happy about that assertion in general.

Hmm, thanks for pointing that out. 

I guess if we really wanted the assertion the approach would be to
replace in_mem_hotplug() with some more fine-grained logic about the
state of the pageblock? But that seems like it would require rework
that isn't really justified.

So yeah I guess this synchronization isn't as ready as I thought for
such a straightforwad "you need one of these locks here" assertion.

My ulterior motive here is the series I'm working on where the
pageblock records the ASI mapping status, so maybe I can find a weaker
assertion that at least helps with that more specific logic.

