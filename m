Return-Path: <linux-kernel+bounces-220682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D890E55A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F73DB21874
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9378C83;
	Wed, 19 Jun 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOLvKZJb"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53B6F308
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785019; cv=none; b=JdJo43RGbrOHX+9ie9CmDuWJGD3vT+Xa0l98t83jnzDMYwM9x5SYVJbZKMkVEpK+yy5W/yz1MLroyhjzvuOJBwWr3pJEHanQHkUTrP3muko3Fs08K9A+f87hbeo/vne8w2JzHdR7ZiH1y20+rUhKwe2G9vupJqt+tjoPIEDgmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785019; c=relaxed/simple;
	bh=B1YSxg53BtuU+5Ww8RPVWrXNHvaeTdVrQsJ++9uhYuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gCKe8suTNL13JADSkLQiWRh7Ovmt22yILecSwakTeSpZcdd0ztmhsBcZy/l68WvXbDQdAa7AIApFd0QlHmCsfcXpZ5Kyo5JPBlNrjBDuzoBGbmILCJDixqR/qgsCC4dJQ5RvRedErVcV5o0i8tEI45xAshcSPkaT8myYhuE/3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mOLvKZJb; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e02c4168e09so366838276.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718785017; x=1719389817; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=udL2a5wRT7zXBVRjusc0IQrqpRO1o5H9EI6N+/cMSLs=;
        b=mOLvKZJbCFp1a3Em4YCXSuWfG6ziEXQIBmSIKe4u7ywTCayY+rrWc0HtfMt1Bpa4HD
         qB5hekXXdujfm4dbf6R707nZck/alvS1kCojN+7DhjKRf+ArEl935XXdUJhwtXcDJm4N
         GI4M0TnQf7JlXcx4OTJFOjeI31OdzW/WeTnZ/sz1Kyvhdu6hSVbeuwFIAe8hwTpTeTRB
         JqWH8FQlVM0XuAYpisoYJ2ip6tZEjcNLTCA3+X0lSyfeg1WP7RQ/BCwTA2ZUJ2i4j7FA
         Fq4RnZVocHz151Xodqii+fwSoeckQPiJfPGo+0AMZmApG22hKk+QDV9uBe9xLq7eDNnO
         ExTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785017; x=1719389817;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udL2a5wRT7zXBVRjusc0IQrqpRO1o5H9EI6N+/cMSLs=;
        b=G76by5zLDDuOri+U6AGFU2P2YPaH7U2pCMxnpC/aAUcXJBnVIzopVUg9PBXHQgSE7l
         /Sxcnp1bNRyC5wWP5XKYEXNF0nek07XrQGqpQZVA8g2HGlTG5tkxi9gEqunXgUJZ8iiB
         qtK0CwI75uPHAP2ZQRHCiPfMIsR9U6DIgyo7IMf4kjmtv28oAilOAd1rnUhVF2n6ynma
         Fx9AHCwqSogUZhCtyIkSubp2gdU+IcTCBqbmB8ECxpxaBn42yas290KAqWqfUv2ygPIz
         KP15EPchggyvV6pNbEG60cygnGWRtKeltP/Ti5S8N8uSBnPLDxQFoyw8/7fQ0pf3U7Tr
         0Irg==
X-Forwarded-Encrypted: i=1; AJvYcCW5wFhtlH8RS4u+4o79VvZoEUTY33aIQTr8ht1g0FJOlu3iInA5XUyJj3vpL7+iayKytZsiy82hofAhPjwFUcuVmBqncPQ1lHu6hzSW
X-Gm-Message-State: AOJu0YxipQaBIbH9BQeTxB43WOrHuQdmsUVy05lPnVeLkkfdLfNYo/ty
	gwWKVh5yKvVykvUiqX4H0lxh3b8d2q4Iql+q9HQpDoAq0O+BjvDooLUxU9mLZA==
X-Google-Smtp-Source: AGHT+IEhzBkF7Z0jyehBxG1zsjaq93hFbMY8O6eFZLB79MPPLKfuY1+TVYAPvE7XdNBRVHtNtrQPiw==
X-Received: by 2002:a25:db94:0:b0:e02:92cf:4ea2 with SMTP id 3f1490d57ef6-e02be10a18amr2049102276.8.1718785016673;
        Wed, 19 Jun 2024 01:16:56 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02b87381ecsm407937276.32.2024.06.19.01.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:16:55 -0700 (PDT)
Date: Wed, 19 Jun 2024 01:16:42 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>
cc: hughd@google.com, willy@infradead.org, david@redhat.com, 
    wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com, 
    21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, 
    ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com, 
    p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for
 shmem
In-Reply-To: <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
Message-ID: <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com> <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org> <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Jun 2024, Baolin Wang wrote:
> On 2024/6/19 04:05, Andrew Morton wrote:
> > On Tue, 18 Jun 2024 14:54:12 +0800 Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> Shmem will support large folio allocation [1] [2] to get a better
> >> performance,
> >> however, the memory reclaim still splits the precious large folios when
> >> trying
> >> to swap-out shmem, which may lead to the memory fragmentation issue and can
> >> not
> >> take advantage of the large folio for shmeme.
> >>
> >> Moreover, the swap code already supports for swapping out large folio
> >> without
> >> split, and large folio swap-in[3] series is queued into mm-unstable branch.
> >> Hence this patch set also supports the large folio swap-out and swap-in for
> >> shmem.
> > 
> > I'll add this to mm-unstable for some exposure, but I wonder how much
> > testing it will have recieved by the time the next merge window opens?
> 
> Thanks Andrew. I am fine with this series going to 6.12 if you are concerned
> about insufficient testing (and let's also wait for Hugh's comments). Since we
> (Daniel and I) have some follow-up patches that will rely on this swap series,
> hope this series can be tested as extensively as possible to ensure its
> stability in the mm branch.

Thanks for giving it the exposure, Andrew, but please drop it from
mm-unstable until the next cycle. I'd been about to write to say I
wouldn't be trying it until next cycle, when your mm-commits came in:
so I thought I ought at least to give mm-everything-2024-06-18 a try.

Baolin may have fixed stuff, but he (or the interaction with other mm
work) has broken stuff too: I couldn't get as far with it as with the
previous version. Just "cp -a" of a kernel source tree into a tmpfs
huge=always size=<bigenough> failed with lots of ENOSPCs, and when
"rm -rf"ed lots of WARN_ON(inode->i_blocks) from shmem_evict_inode();
and on second attempt, then a VM_BUG_ON_FOLIO(!folio_contains) from
find_lock_entries().

Or maybe that VM_BUG_ON_FOLIO() was unrelated, but a symptom of the bug
I'm trying to chase even when this series is reverted: some kind of page
double usage, manifesting as miscellaneous "Bad page"s and VM_BUG_ONs,
mostly from page reclaim or from exit_mmap(). I'm still getting a feel
for it, maybe it occurs soon enough for a reliable bisection, maybe not.

(While writing, a run with mm-unstable cut off at 2a9964cc5d27,
drop KSM_KMEM_CACHE(), instead of reverting just Baolin's latest,
has not yet hit any problem: too early to tell but promising.)

And before 2024-06-18, I was working on mm-everything-2024-06-15 minus
Chris Li's mTHP swap series: which worked fairly well, until it locked
up with __try_to_reclaim_swap()'s filemap_get_folio() spinning around
on a page with 0 refcount, while a page table lock is held which one
by one the other CPUs come to want for reclaim. On two machines.

None of these problems seen on Stephen's last next-2024-06-13.
I had wanted to see if mm-everything-2024-06-18 fixed that lockup,
but with the new problems I cannot tell (or it could all be the same
problem: but if so, odd that it manifests consistently differently).

There are way too many mTHP shmem and swap patch series floating
around at the moment, in mm and in fs, for me to cope with:
everyone, please slow down and test more.

Hugh

p.s. I think Andrew Bresticker's do_set_pmd() fix has soaked
long enough, and deserves promotion to hotfix and Linus soon.

