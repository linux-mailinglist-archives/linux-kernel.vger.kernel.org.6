Return-Path: <linux-kernel+bounces-241220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A111927861
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA591F251F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF4E1AED35;
	Thu,  4 Jul 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEJuLrVk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872421DA22
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103422; cv=none; b=Uz0G4EYwNlLwyNkFnX5TWQsulVLqFEQKT8wfIZMWb/jvqYzEkrzzgjBD1Oea5OzMj22wVWV+Ev8TJh5iP/EIHk4Nn2b0cGYVF9nCVzpZHTW2g4VmUFG0SYS0nOsrBDfbsKISqtnROVKtcjyjG05XSnVDlyvcZhY2uKjuX3jV0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103422; c=relaxed/simple;
	bh=rxkoVLANAgsiRg1BdlHYZ9ggrSz46s9m15oRQWmwMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RurjokVT9ag7dOwSjMmA7ZlIk7YImQUzojaUv7T2N0xViuBkqLfBHy7EAp1DvFjod9cZb8X55wnMLRP7HqDDJdASroUtGW4AxsRWvZfcId4y5QwRpi/qAvwSbHk+YW/4CxOUpdJXboEFEJqpMZ8R9EIJWwVMfkhz/ISfqlq3pg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEJuLrVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720103419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w/AAPZgMjlC+NouAvQxaat3L1IUvbO4yc2zitpvelSI=;
	b=iEJuLrVk8yN1I43ak2F+1nTz4dlcrRSc6E4nqvq5VLb9aEHNJJ6io7jx4utRYmtMnrDnyA
	tPnxJKr6FQzRkUQWdURyWJ+SGXgnUE+QkipaYr40yZppIkBxxPgaDIHfm0028Fs5HOyhcd
	D+wq4ewrGALhW/xcWjFSTD4fmU179tg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-AF2siz_MPaqraf0t0EXHbA-1; Thu, 04 Jul 2024 10:30:18 -0400
X-MC-Unique: AF2siz_MPaqraf0t0EXHbA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-444f87a6c3cso1709161cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103417; x=1720708217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/AAPZgMjlC+NouAvQxaat3L1IUvbO4yc2zitpvelSI=;
        b=RyU8KqyDyHzZruuB342gDsE8beaKFCFz1r/WmQrTPjyyWyk3vH+M+oCXJATLk/o7gN
         injxw142NUDwSDTE57FbPXl3Isccniy3WzrWfRpEBNOA/od66aEg7nUPEf7ot5A/A7xx
         zU3lTaN+ItEwCjFrD4k4ufUnKBdhqYdHfNsjSyGs10jvWKjNIRUJL5czjXG47XI9FCEN
         iXfW40XcSeeZcIApiYnhnpJGJKjuD+BRlyIXlseAc7OFuCG5crM2ehVwrMzZwtmOgjm/
         UFSEHgwjI3NCtFotvZMOqBIBZy+E1sWbpW/fscN5fguZdqjEbXzRiHOi7wW3c+sjkmx7
         T6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXlkwcaCXrn9kbNeY8s0viUAca7DKJTz0eotiDeGoRWdScecRiJAePKYVWpK0utlkf6KN3/ziRBNXaYWV3ivEmw8ROvZOGgRJqr+J0
X-Gm-Message-State: AOJu0YyeoHmyh9jtrLwzOb1sq+0FmOvZGbF5P5Q/Zds6ttITGz0EbY1h
	bRpTzWsRxdykcwJIdFEf8B1JOD43u/9vMDrPPg2hgTeUriZ32N24Dy+2NqnU3reTHfhYIydc7+y
	xHZx5hmywwQJTRPllaFU8KOQMjACCfXo+/ww/iCf/Gm9XbmzL44K2D9FlYX1tkA==
X-Received: by 2002:a05:620a:5373:b0:79d:6273:9993 with SMTP id af79cd13be357-79eee26ee8dmr156438285a.6.1720103417642;
        Thu, 04 Jul 2024 07:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj0u2XdT5CTZX+Koii9wFhsrVmpQ6ohxOQzjPcSeWjkjtqMUBPFWDoI8rAxzOAQLrY6Nq4MQ==
X-Received: by 2002:a05:620a:5373:b0:79d:6273:9993 with SMTP id af79cd13be357-79eee26ee8dmr156435385a.6.1720103417282;
        Thu, 04 Jul 2024 07:30:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d693060b2sm679117385a.104.2024.07.04.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:30:16 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:30:14 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
Message-ID: <Zoax9nwi5qmgTQR4@x1n>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>

Hey, David,

On Thu, Jul 04, 2024 at 12:44:38PM +0200, David Hildenbrand wrote:
> There are roughly two categories of page table walkers we have:
> 
> 1) We actually only want to walk present folios (to be precise, page
>    ranges of folios). We should look into moving away from the walk the
>    page walker API where possible, and have something better that
>    directly gives us the folio (page ranges). Any PTE batching would be
>    done internally.
> 
> 2) We want to deal with non-present folios as well (swp entries and all
>    kinds of other stuff). We should maybe implement our custom page
>    table walker and move away from walk_page_range(). We are not walking
>    "pages" after all but everything else included :)
> 
> Then, there is a subset of 1) where we only want to walk to a single address
> (a single folio). I'm working on that right now to get rid of follow_page()
> and some (IIRC 3: KSM an daemon) walk_page_range() users. Hugetlb will still
> remain a bit special, but I'm afraid we cannot hide that completely.

Maybe you are talking about the generic concept of "page table walker", not
walk_page_range() explicitly?

I'd agree if it's about the generic concept. For example, follow_page()
definitely is tailored for getting the page/folio.  But just to mention
Oscar's series is only working on the page_walk API itself.  What I see so
far is most of the walk_page API users aren't described above - most of
them do not fall into category 1) at all, if any. And they either need to
fetch something from the pgtable where having the folio isn't enough, or
modify the pgtable for different reasons.

A generic pgtable walker looks still wanted at some point, but it can be
too involved to be introduced together with this "remove hugetlb_entry"
effort.

To me, that future work is not yet about "get the folio, ignore the
pgtable", but about how to abstract different layers of pgtables, so the
caller may get a generic concept of "one pgtable entry" with the level/size
information attached, and process it at a single place / hook, and perhaps
hopefully even work with a device pgtable, as long as it's a radix tree.

[Adding Jason into the loop too. PS: Oscar, please consider copying Jason
 for the works too; Jason provided great lots of useful discussions in the
 past on relevant topics]

Thanks,

-- 
Peter Xu


