Return-Path: <linux-kernel+bounces-194353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB938D3AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF0D1C24151
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B55C1802D6;
	Wed, 29 May 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgNgboAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30FE17BB17
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996090; cv=none; b=nVzZl+GPZfjReIEN6hnvYHP7ZLPFdnp/UYRSQy0rOIhlTwgKUZoJjW3AVZ/Tu9iwdWgJBkffN7tpCAyucqhhuamjxfBS84G/3juzDGoTwTguRllP9rjT3+xW4j016RnbAVgaK7jlGMM1ZU8Ro+cS6cnlCmN4+iSrcMNE/0kaeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996090; c=relaxed/simple;
	bh=TvcuEg9n5sSq+m+PI5BmZfgamlWMCayUM1VGOKQGHuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWZXULJrucKJfgnxegZKh+4C8HfGk6uqOhqAxk2UE1HLzHs1KATQKglP9dCm58FX80bSMXdtszndfsftlL0vPHnFOHBsAGuPOx33FKZZnVDFMnUHip+mh1yubXc8g5qEjcvUdhYv4LNC5s1z3GemLyYat1RZefSazDDtOFvORN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgNgboAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F55C113CC;
	Wed, 29 May 2024 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716996090;
	bh=TvcuEg9n5sSq+m+PI5BmZfgamlWMCayUM1VGOKQGHuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgNgboAspZjEFliAH6Vtbh1m/WDWqbpBZrRCT0Wkv88OVnS57/o/x/+XOTXjvXTs+
	 eE01gsFT84ZHNM8qt11w7G0e6Mm9ilCA7KS40Pg9+w9ksCcazgfZ0VGh3zo9sLP+L4
	 K/LiuIjGXpf26zis349iv2FfyF7Fk/uw326MFqMbE8JeRBf05RGdsWM4n9DEZppwoS
	 kCAqnVeFzPpS/oUVt9hHXValY3EfL4oO0NZFRxLq0LOKA8C3YV3JHxGiCQgN/wg4MM
	 EyYgYEc9K9aXus0RIr/brTZrMo1LoivrFFUPTYSvsu0ui2vfq6C8KukR1Picns1Pru
	 ZoW8aUsDTanWw==
Date: Wed, 29 May 2024 16:21:23 +0100
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Jeff Xie <xiehuan09@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Zach O'Keefe <zokeefe@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in
 contpte_clear_young_dirty_ptes
Message-ID: <20240529152123.GA13782@willie-the-truck>
References: <20240524005444.135417-1-21cnbao@gmail.com>
 <ZlWVHC0e2OadjwIa@J2N7QTR9R3>
 <CAGsJ_4xMdyBxwwh1AQeFM5a_ZMV2=y68M9eEuJf-D6NtYP-8dA@mail.gmail.com>
 <ZldCwWqI0JVIqh_3@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZldCwWqI0JVIqh_3@J2N7QTR9R3.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, May 29, 2024 at 03:59:13PM +0100, Mark Rutland wrote:
> On Tue, May 28, 2024 at 08:39:55PM +1200, Barry Song wrote:
> > On Tue, May 28, 2024 at 8:26 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Fri, May 24, 2024 at 12:54:44PM +1200, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > We are passing a huge nr to __clear_young_dirty_ptes() right
> > > > now. While we should pass the number of pages, we are actually
> > > > passing CONT_PTE_SIZE. This is causing lots of crashes of
> > > > MADV_FREE, panic oops could vary everytime.
> > > >
> > > > Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch helper")
> > >
> > > I was seeing ths same thing on v6.10-rc1 (syzkaller splat and reproducer
> > > included at the end of the mail). The patch makes sense to me, and fixed the
> > > splat in testing, so:
> > >
> > > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Thanks!
> > 
> > > Since this only affects arm64 and is already in mainline, I assume the fix
> > > should go via the arm64 tree even though the broken commit went via mm.
> > 
> > Either mm or arm64 is fine with me, but I noticed that Andrew has already
> > included it in mm-hotfixes-unstable. If it works, we may want to stick with
> > that. :-)
> 
> Going via mm is also fine by me, I had just expected it'd be quicker to
> go via arm64 (and evidently I was wrong there!). :)

Sorry, I was fishing! I'm happy for it to land via -mm.

Will

