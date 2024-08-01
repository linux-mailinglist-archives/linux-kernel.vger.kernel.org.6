Return-Path: <linux-kernel+bounces-271568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4357945025
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796E028A506
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355BB1B4C4D;
	Thu,  1 Aug 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqvPLTJr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99513958C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528438; cv=none; b=LBEl93OrzUNPhOapenZhIjFBC+FFNh9yi3I+N7+Ct77pd/GbkTFnckIgTyTDLwAgLbz1RettksQn5eq3juQWbsOCnLu3JAwVp2EYw0iEMWMJ2hCNMJVYip46bjZMbh8HpFvU/zUAQMmz7sAeTrSGNhFRb7Z3vfz2imrAz8Tfz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528438; c=relaxed/simple;
	bh=n32j8Vh6XeMuHISnOVA6FqF7JXmRX5sMXwD65DQ1OFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN2lfbXK5RIeLUYgrFavYAL/WVSYXavwwKVzKiVHwq7Op2Ah+l2Xwehsw4hxSrNTf41gLp3Tzs3arS8V6rulP5u9A8phRjSDoAbkDRkgLLPqrpE1HOpMsWWNQkhI4MzViKn5+XQ2IF3T+QaTEm40Hu5cdJys1zuM3bhBQJXT+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqvPLTJr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722528435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jfgAWh3KxxRWgzDt61596NApFPizVzq8q6tnOLG4Lk=;
	b=JqvPLTJrDOXANfQgCeViYCWiBfqnWbnWj5Z6aq0tzTsuJ41wDoP3flu99QDxuPtlkNrpBh
	NsfTuxR3JB2Kh0rXK2rv9sagNSAKzJ40H6q7YeWQSm6VLkz8CA/6YKMeeeXGaVQHswDr+u
	F6e3W6nPQ+BcIQWxtyn7TyxW8Ya+2Ok=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-IkeGJpJCNICJyz8KJXKUcg-1; Thu, 01 Aug 2024 12:07:13 -0400
X-MC-Unique: IkeGJpJCNICJyz8KJXKUcg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b79fbc7ed2so14700016d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528432; x=1723133232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jfgAWh3KxxRWgzDt61596NApFPizVzq8q6tnOLG4Lk=;
        b=a6UzzsjOYUWIgcXQs1J095EYsXFuv5NYcxJCWAlXKDfnA2oxlMScFPIXjV1WJXJhzI
         qlyyQ/PsONCpA6G7E+1sdJXP2kYtk3ydtZbk4YONSqICfXG5qX7iNXYfYszOKR0Qhbog
         +p026akI897XCqL4xGsqo0US4Hka/D/uQZX57JKIGUvOL2VA9Hs92w1xJYmBT1azSokB
         mo4wsZVc0fIV0UsVoEBM6eZ1Z9sic7c4UcxNh9QcSgrvbPNk2odhTYV1/ML6qiWAeEN4
         IRu7YTjUDNkuUfD2OWMJADnjEjJwLRBkXeE3lCHX2h+8CyQrIAz+tSkPhYfms6d5dmqG
         9qmg==
X-Gm-Message-State: AOJu0Yxc1gaznemO6GWK7I/8or+dXTwfjTS1+HT+lY1vYIZYfquTh/Fx
	CZrDjXmiEjkH1kmSBKUDNbcOH/sMe/XvzmdeNGC8rk9CGfxD7rh+CqHZOQgBW1biyMbvWqABwSH
	dz7YNrTjnp0tOM3sfCRmRXyFOczTCYcSQTt63YFoo2qRNpJx9zIASvgQlfULcQw==
X-Received: by 2002:a05:620a:28d0:b0:79f:2cb:868d with SMTP id af79cd13be357-7a34ef456c4mr34831085a.4.1722528432546;
        Thu, 01 Aug 2024 09:07:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV3oryN9fC3noWm2U5lGXdwP/vpqahkhLTD//4fU+IWDrX6KSbFmIMVqsVRMfKJJHRzCDlMg==
X-Received: by 2002:a05:620a:28d0:b0:79f:2cb:868d with SMTP id af79cd13be357-7a34ef456c4mr34829185a.4.1722528432174;
        Thu, 01 Aug 2024 09:07:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6e714fsm2895485a.33.2024.08.01.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:07:11 -0700 (PDT)
Date: Thu, 1 Aug 2024 12:07:09 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-ID: <ZquyrTTUgvFF65ov@x1n>
References: <20240731122103.382509-1-david@redhat.com>
 <541f6c23-77ad-4d46-a8ed-fb18c9b635b3@redhat.com>
 <ZquTHvK0Rc0xBA4y@x1n>
 <934885c5-512b-41bf-8501-b568ece34e18@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <934885c5-512b-41bf-8501-b568ece34e18@redhat.com>

On Thu, Aug 01, 2024 at 05:35:20PM +0200, David Hildenbrand wrote:
> Hi Peter,

[...]

> > > +	else if (size >= PUD_SIZE)
> > > +		return pud_lockptr(mm, (pud_t *) pte);
> > > +	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
> > 
> > I thought this HIGHPTE can also be dropped? Because in HIGHPTE it should
> > never have lower-than-PMD huge pages or we're in trouble.  That's why I
> > kept one WARN_ON() in my pesudo code but only before trying to take the pte
> > lockptr.
> 
> Then the compiler won't optimize out the ptep_lockptr() call and we'll run
> into a build error. And I think the HIGHPTE builderror serves good purpose.
> 
> In file included from <command-line>:
> In function 'ptep_lockptr',
>     inlined from 'huge_pte_lockptr' at ./include/linux/hugetlb.h:974:9,
>     inlined from 'huge_pte_lock' at ./include/linux/hugetlb.h:1248:8,
>     inlined from 'pagemap_scan_hugetlb_entry' at fs/proc/task_mmu.c:2581:8:
> ././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_256' declared with attribute error: BUILD_BUG_ON failed: IS_ENABLED(CONFIG_HIGHPTE)
>   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> ././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
>   491 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> ././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
>   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>       |         ^~~~~~~~~~~~~~~~
> ./include/linux/mm.h:2874:9: note: in expansion of macro 'BUILD_BUG_ON'
>  2874 |         BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));

Ahh.. this is in "ifdef USE_SPLIT_PTE_PTLOCKS" section.  I'm thinking maybe
we should drop this BUILD_BUG_ON - it says "HIGHPTE shouldn't co-exist with
USE_SPLIT_PTE_PTLOCKS", but I think it can?

Said that, I think I can also understand your point, where you see
ptep_lockptr() a hugetlb-only function, in that case the BUILD_BUG_ON would
make sense in hugetlb world.

So.. per my previous nitpick suggestion, IIUC we'll need to drop this
BUILD_BUG_ON, just to say "USE_SPLIT_PTE_PTLOCKS can work with HIGHPTE" and
perhaps slightly more readable; we'll rely on the WARN_ON to guard HIGHPTE
won't use pte lock.

Either way works for me, thanks!

-- 
Peter Xu


