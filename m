Return-Path: <linux-kernel+bounces-547730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22371A50CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC13AD4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C525523E;
	Wed,  5 Mar 2025 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zi9CWjHW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1C24E4B4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207872; cv=none; b=E0T96rrgkKbINkVKgLTWCIMSDdn9pFLp0/xsS7D1/4pvSgnLC7YkZ8DsGem8xkeLOGnHaMmoO2uIRsQhgWsbgE1Z4bhD02hRWKUK82I6euVK/zGAx4qFG8J0P8eehBQaAjRCAgWzTCO3yvRRTwhQ0g363AjxwKSqck2sdKBJcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207872; c=relaxed/simple;
	bh=2UPD4fl38N/nwlwseUvqmubw1Wm+DVOh9gqY4Pt0mHA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dcd7o6brHaxr5BZd0+gLOYfKekBKBunP3K4mT6y+Vrhs76dt0Z/hEhUbSiknmb4n2PZE+9gWuaNoa/paZU1LnicnE0TKZ2ixSUrgA0Ao3ihZimIHOirXwfFn3R7uKAmopk15oG+dHVOPnJGtd+9bAYju42K5YsMjjqYEma7pisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zi9CWjHW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240b4de12bso2086815ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741207870; x=1741812670; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhfWjnxi423UGUnC8mciMuHBQ1z3/MYrVutTlINTcRs=;
        b=zi9CWjHW2t7EyqYXf0J9R+hjwK67BIbPqVQ+p7WDkf4W6JUK7rpw3YddrrHyVRFabU
         QJS6kdgb/jnygRiOQB/IcSFFdwP7WFDv+JN+L0SVTa0Oqi9ueb1SyWvGE96nPMimJbl8
         jjRHN1K/cdMftK09GN/YjF36uunKq4reWHhDmcFM1XP9hqR3RSax+T14DqNSQ2pqPJOZ
         GGQxN7PjTma5DoaT1Akmdy2O9letn4XGE4D2sDaoGMwX5MkC8X/E51Bm44HtohXkzlP6
         EAhiAK6f8oQedeUQ2LPg6aWr3xVbg47/bs5IN2NmHWXfS/5aJdWhe7lVvQqE/nCR4chx
         8nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741207870; x=1741812670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhfWjnxi423UGUnC8mciMuHBQ1z3/MYrVutTlINTcRs=;
        b=d3haUw6TmdeekUDc49ROlFwpa/Tc9Pk3TJ20dGYTMV5CTHMYRfJJuzA/AaErQ6keJA
         61Gv8QPLBdWtZ3jqn+u60CpbgL6+Z77lWq8hVcPM7guNNH6QWXUDkWiN5Um/6CoF68ou
         oFBbt2ubup9RLSJJQ2tpiqUqJXtfFx0qQxw1ItoCj70EFVWp1g7ppJEgmtZNPg0mpWkw
         OJKELK52cocMj5GqSF/2Ci1VVGzCWBoFGb4TChUz/uE4XVuEQXSRjAuIScCBiufz3Oj9
         z+LY8Ne5yP+ND3X1C+EjV4diCE+TYNQTVHuVTzTAPU2NYw8sXDTowummDdUKXIa7VYCo
         jUaA==
X-Forwarded-Encrypted: i=1; AJvYcCUPPpcTYlJ5/hHWiapa6JM0fLe1F4Jm3KZbpWxUYVqnWgbF3mMtzS+4ZEL8Clo9iHjWShikytWb92+HcFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HC3adFu103C1v0GJlmSbZZiz5uYHuOlJQriZUHXHlK+dzv+m
	QhAAlrngauayrnUsfblJh07SPasKOJQKop2vxQm3X/NZ2JrPFWo6VNkL347e7g==
X-Gm-Gg: ASbGncs2BfwJzWdhe47E6xvRxDk0yt3UGJ5ilq84FW+L06by+WU8+XtRC4hdXrweFTL
	MnkmTFqv7zr/lnCFG7EdoMeRXLXRoDLmn3fiSHHPmd5Au2Gtc5PMQI0L7nTsEJsTWW5o8KOXQ3f
	2kRQx1wjCeZE+Q0yMFEd25WeZpIvz8xhs60EzSSpPCrtY/b2DjVo9evmegHHxkmQa9t9b6Hn/qE
	pMLVJ1rUJ61PuMFup5RJ4/qpuVOTPZQ8xBZHrhXClT9Kit43pqWn5fRDma9XnbnxpmDTgd03q1W
	BNZLrteTr5CgAagL7hkMT15YBsdyclkku0mZUHsp4PAFuy2dTMJdhDUAJ9Vs9daxtKMRILctUq/
	DPJ0qSG0os6n1zaw5e6grzknVKkiX
X-Google-Smtp-Source: AGHT+IE32bLw2wlU1GnZf/65XqA6smz9VmkaRVDH9Oh8jcxy1XpzYMw+ZpyVO6VEHxvdny06qkBlLw==
X-Received: by 2002:a05:6a20:9c9b:b0:1f3:290b:7be with SMTP id adf61e73a8af0-1f3495aaff7mr8642792637.41.1741207869678;
        Wed, 05 Mar 2025 12:51:09 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec5csm13872238b3a.144.2025.03.05.12.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:51:07 -0800 (PST)
Date: Wed, 5 Mar 2025 12:50:58 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, 
    John Hubbard <jhubbard@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
In-Reply-To: <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
Message-ID: <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com> <20250226210032.2044041-3-ziy@nvidia.com> <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com> <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Mar 2025, Zi Yan wrote:
> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
> >
> > I think (might be wrong, I'm in a rush) my mods are all to this
> > "add two new (not yet used) functions for folio_split()" patch:
> > please merge them in if you agree.
> >
> > 1. From source inspection, it looks like a folio_set_order() was missed.
> 
> Actually no. folio_set_order(folio, new_order) is called multiple times
> in the for loop above. It is duplicated but not missing.

I was about to disagree with you, when at last I saw that, yes,
it is doing that on "folio" at the time of setting up "new_folio".

That is confusing: in all other respects, that loop is reading folio
to set up new_folio.  Do you have a reason for doing it there?

The transient "nested folio" situation is anomalous either way.
I'd certainly prefer it to be done at the point where you
ClearPageCompound when !new_order; but if you think there's an issue
with racing isolate_migratepages_block() or something like that, which
your current placement handles better, then please add a line of comment
both where you do it and where I expected to find it - thanks.

(Historically, there was quite a lot of difficulty in getting the order
of events in __split_huge_page_tail() to be safe: I wonder whether we
shall see a crop of new weird bugs from these changes. I note that your
loops advance forwards, whereas the old ones went backwards: but I don't
have anything to say you're wrong.  I think it's mainly a matter of how
the first tail or two gets handled: which might be why you want to
folio_set_order(folio, new_order) at the earliest opportunity.)

> 
> >
> > 2. Why is swapcache only checked when folio_test_anon? I can see that
> >    you've just copied that over from the old __split_huge_page(), but
> >    it seems wrong to me here and there - I guess a relic from before
> >    shmem could swap out a huge page.
> 
> Yes, it is a relic, but it is still right before I change another relic
> in __folio_split() or split_huge_page_to_list_to_order() from mainline,
> if (!mapping) { ret = -EBUSY; goto out; }. It excludes the shmem in swap
> cache case. I probably will leave it as is in my next folio_split() version
> to avoid adding more potential bugs, but will come back later in another
> patch.

I agree.  The "Truncated ?" check.  Good.  But I do prefer that you use
that part of my patch, referring to mapping and swap_cache instead of anon,
rather than rely on that accident of what's done at the higher level.

Thanks,
Hugh

