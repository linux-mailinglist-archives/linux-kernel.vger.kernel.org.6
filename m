Return-Path: <linux-kernel+bounces-221947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E6190FAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419D41C20E62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6D18E11;
	Thu, 20 Jun 2024 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jl/hVcXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929A182AE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847239; cv=none; b=gadWiERqZ15lFGDdeaYvMntsuGOgJFGGCEijnXSr6M2fEnIjSIE8DUI5w+9AeOOaZLaInw/hTdiLu9AGmwTYO3Tf8mE/aTeBEpYFhBGa9ltlodfv2ctEH9R9L/R5Sk3528RPRgs0CKsKz86WLxJdXFJ6o9riDVZIkH/DQ/DlWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847239; c=relaxed/simple;
	bh=Ehy3lm5mhs1TTZK3YUqvQ9iGlAo7Hoxuggu0HtqdSMs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q5JbsBYtupHTl4plqvtsMpzWJs64lzMYv0mwPCv2AvDeGxfrDhdW8zXhMT64Hkio4yaD9MArzuZm5RvK1Mos/ob3L1I/O37j7ywSi8a1xW6BGPgOvothm7g0TUmaqQCCY23lMYWPpjbS6VUFJsGVZAXo3kVxJL64FKdGd41DfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jl/hVcXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42164C2BBFC;
	Thu, 20 Jun 2024 01:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718847238;
	bh=Ehy3lm5mhs1TTZK3YUqvQ9iGlAo7Hoxuggu0HtqdSMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jl/hVcXl6P595oLGK+xr71dKVq4p0qictftrZaaavAWkjAsh8MjQ17YZI14x/zxXk
	 Mkc0Qck11qXCC2rlaS3g1cYbkVvhkdY0KdjumEJdPx81NtgzWjtomWDym5RK7lkHIO
	 uI18VViBC4owKXW3AXPRstY67KEu6HlemJiwZXtg=
Date: Wed, 19 Jun 2024 18:33:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@rivosinc.com>
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for
 shmem
Message-Id: <20240619183357.2ee5a818f8de1d4773be2ff6@linux-foundation.org>
In-Reply-To: <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
	<20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
	<475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
	<2683b71d-aebd-5527-348c-18c0e021b653@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 01:16:42 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> On Wed, 19 Jun 2024, Baolin Wang wrote:
> > On 2024/6/19 04:05, Andrew Morton wrote:
> > > On Tue, 18 Jun 2024 14:54:12 +0800 Baolin Wang
> > > <baolin.wang@linux.alibaba.com> wrote:
> > > 
> > >> Shmem will support large folio allocation [1] [2] to get a better
> > >> performance,
> > >> however, the memory reclaim still splits the precious large folios when
> > >> trying
> > >> to swap-out shmem, which may lead to the memory fragmentation issue and can
> > >> not
> > >> take advantage of the large folio for shmeme.
> > >>
> > >> Moreover, the swap code already supports for swapping out large folio
> > >> without
> > >> split, and large folio swap-in[3] series is queued into mm-unstable branch.
> > >> Hence this patch set also supports the large folio swap-out and swap-in for
> > >> shmem.
> > > 
> > > I'll add this to mm-unstable for some exposure, but I wonder how much
> > > testing it will have recieved by the time the next merge window opens?
> > 
> > Thanks Andrew. I am fine with this series going to 6.12 if you are concerned
> > about insufficient testing (and let's also wait for Hugh's comments). Since we
> > (Daniel and I) have some follow-up patches that will rely on this swap series,
> > hope this series can be tested as extensively as possible to ensure its
> > stability in the mm branch.
> 
> Thanks for giving it the exposure, Andrew, but please drop it from
> mm-unstable until the next cycle.

Thanks, dropped.

> p.s. I think Andrew Bresticker's do_set_pmd() fix has soaked
> long enough, and deserves promotion to hotfix and Linus soon.

Oh, OK, done.

And it's cc:stable.  I didn't get any sens of urgency for this one -
what is your thinking here?

