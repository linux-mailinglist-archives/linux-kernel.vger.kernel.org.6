Return-Path: <linux-kernel+bounces-248147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAAD92D8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333D51F265AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7206197A7F;
	Wed, 10 Jul 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7cl4TVu"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFA195B18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638910; cv=none; b=RBZstXLsG3hXuuAGZoAi6pMJkV/6Rs/CDKem725dsbK9LXsmvHWfdlsTAmoxc8JHiuLKD/7zf8QlIzPw64mdC9J87VVD5vPYeH4kGxYhv3gvl0VfDx0m0InvxmIBFn9V9wsCHTVRBIMmueID7HZHfxzIvYu/JTd9HFQ5aj608W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638910; c=relaxed/simple;
	bh=J4aNViHux4qP/o52knB7g/6ZzUmCLkg1Jd1N2W1AC0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sUYqgNhdPdOr87evKNWtIDswstNuQoyzmddHmaTWUInKBW7HxlCPePmJK8TNSBzKi124JfihQdDiLQxMTOa4aPh6W9uQdnK9QaM+E07BYNrh3Eo4ocE6AVHQOTPCqDipP35/74R9GH0VawtgTa3z+W8K6jqxrcSNFYmSrxBHDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7cl4TVu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6510c0c8e29so1181977b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720638908; x=1721243708; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpJH7O0IK+mWa36m8icY/tzE/YoR+c7Wf4G7xE5ZzLM=;
        b=f7cl4TVuaH3p1nmqJTgJ+SLmQnF79S1laeBdvuItvCVB+hHste0ENNXzHvb8fdCnZA
         FWj1c8OfdiHRMMVRoaMtvM4tnev9/i+lNzDYx8Hhddx0q7UJq+bKg4ymJRqXuPEa0wRo
         Hj10NQSRkJID5zPSfT0IAlQVGKIDBn7WKka1Wus7obB0ZNpbSjMZnkZrdVA5FShmaH0q
         fBZd+s23LsPXWKaFxvl7U21vAXJCkpAd+JPwfE4iKgoCvUW3MFIiWImABM7Y3xWCd8Cf
         YVslsfmBPueSnCsQEbj1W+++J43t817b79HU66uxcCkqlAZjvN9pHoI4//fYuI+v+W5n
         +C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638908; x=1721243708;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpJH7O0IK+mWa36m8icY/tzE/YoR+c7Wf4G7xE5ZzLM=;
        b=dFVlpmrOP+8UsXoFJfJ8mI83WLByyIh3EGnEpg4tMau/pwV51k7zpNjw5UeBdpwh0y
         R1e6yK7VVDamr+NaY5yiM+1FOUCb5LVfPBpQM8Z1gx2VXUux+sBzN2MLB0WhPX2ZWXxS
         BBFA0ElMcwuYDkB9fWiz3fzdeIpkYIOPL/Kc8dCpNJCx725BhVtJ85Qcj1EI5wIafo/f
         LKgNGEeJTRSdR1eVBHXlbKgA2u4dWBA8L7cdFd5b5Zi2jCEcFP7Qjq7vhNMv6CpF/6Yb
         dod+ChYfo3W7z6+PNjf61V0rlhkRriooN7JOpl2tp/eRVf4pIn3zQvA3QldjXWPo5vtM
         nrYA==
X-Forwarded-Encrypted: i=1; AJvYcCVI37p8Q75BhThsMOzfhfwbVUcWZSXwJDr+5wOYE0Opltc3O2S2c8tx4RxQD+LQ6mdi2F6wEIit/8hMSv/mfwnMb4JuJh/0ix007ysK
X-Gm-Message-State: AOJu0Yyewj0pYtqlt5tfmJvkRlPQ5/m5ntA8WpwmJr8h+8DeaaHtpb4r
	2b6H/Ak/VuI4vBD2HFZZoriL8BORj4eXhdlmR+kokpOgGk3YSzEQtALq3z8uiw==
X-Google-Smtp-Source: AGHT+IFWZTHBjlwLdnh07cjhHTC+j0sZPJwKS9lkD9EQ+SwBth2W8WJCPyjo5BJ/hREJijMn9wPueA==
X-Received: by 2002:a05:690c:ec5:b0:630:de2f:79b8 with SMTP id 00721157ae682-658eed5ebd3mr74295227b3.13.1720638907584;
        Wed, 10 Jul 2024 12:15:07 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e4d2d5d1sm8308867b3.55.2024.07.10.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:15:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 12:14:55 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usamaarif642@gmail.com>
cc: Hugh Dickins <hughd@google.com>, kernel test robot <oliver.sang@intel.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev, 
    lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
    Chengming Zhou <chengming.zhou@linux.dev>, 
    Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
    David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, 
    linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
In-Reply-To: <2fe63ea9-613a-4904-8b68-134442c43261@gmail.com>
Message-ID: <75bc4bf4-afe0-a1e0-36bb-1fad7ecee210@google.com>
References: <202407101031.c6c3c651-lkp@intel.com> <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com> <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com> <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com> <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
 <2fe63ea9-613a-4904-8b68-134442c43261@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jul 2024, Usama Arif wrote:
> On 10/07/2024 21:49, Hugh Dickins wrote:
> > It's a long time since I was active hereabouts, but the bot report
> > and your flurry of updates make me think that you should step back,
> > slow down, and look more carefully at the precedents here.
> > 
> > IIRC, the main problem is that parts of the swap_info_struct can
> > still be in use from before while you're wanting to set up new values.
> > Observe how alloc_swap_info() may return a fresh or an old allocation.
> > Observe how enable_swap_info() is called after getting swapon_mutex
> > late in swapon(), once past all possiblities of error.
> > 
> > I expect that your new zeromap needs to be taking the same care as is
> > taken with swap_map and cluster_info: to be safe, follow their example
> > in both swapon() and swapoff().
> > 
> > Hugh
> 
> Thanks, yeah sent too many in quick succession :). Will be more careful next time.
> 
> Both the 2nd and 3rd version are careful to solve the problem of using old allocation
> which you described.
> 
> The 2nd one takes care of it in the same way as swap_map.

It didn't look like that: it set "p->zeromap = zeromap" as soon as
zeromap had been allocated; whereas swap_map is only installed later
via enable_swap_info().

> 
> But I believe its unnecessary to do all that change in the 2nd version, when you can just
> set it to NULL after kvfree, which is a much smaller change and takes care of reusing old
> allocation equally well.

It's possible that there's a good reason why zeromap does not need the
same care as swap_map; and it's possible that things have changed down
the years and swap_map itself doesn't even need all that care.

But you haven't persuaded me: I repeat, step back, slow down,
think carefully about why the existing sequence is as it is
(and please don't respond without doing so).

Hugh

