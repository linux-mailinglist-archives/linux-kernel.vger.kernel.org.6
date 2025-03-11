Return-Path: <linux-kernel+bounces-556946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046BAA5D141
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FA4189E03B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B751264A7F;
	Tue, 11 Mar 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZS52X85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0001EF368
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726580; cv=none; b=CAfysYrElA4WNHxugj/MHlqfziflntgvaSO/yEKmp1G1jazxygeVqYhC764xbafTM9gz6e2PaloeosTjgjuNmHhbJ0MABa+qTAIwroK9NHhhHEeBV3ETKcmYMud8HLieEjIUpctllgAqlBNb5vnjIdHhquSOyP0OEvP8noZ8VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726580; c=relaxed/simple;
	bh=o5UAXdx6olL6kpW4dejaSRN4uTcKi0Yeg/ER1IsfsUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6guhkhQINhobNk0FRyKWkncq3DvZGd3MhF+Ahb0sBwY5I26ITGqgUaXRjn9Uf5HwrKOtFZdN3gKi60H5okfUv6pcv70VjD27ouUfH1mEQqfsWjEM1Omqe8U7BJfhEYWLY/79Y674hk0Vksu0yp46OlTjbtNhqPngMjZMSFJGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZS52X85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5348C4CEE9;
	Tue, 11 Mar 2025 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726580;
	bh=o5UAXdx6olL6kpW4dejaSRN4uTcKi0Yeg/ER1IsfsUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZS52X85F+NGmllHkQyuICjUfciGdzqNkF4y3T/s2wAE0u6JK22WOwuelYpLCWnv/
	 hrtnJ7GEEybI93A3YQ+r6fs0FlUB3FLeKOrHJnvBh/QXbMYrnlHmICnZsJjDHETFf+
	 zRrPz7W2fjVVpcjpaVBK0Ox1Cr5Coz1iPkCm5SBXLjxrNmyDwPkFCC7rUyxg+8BSC3
	 OtbPwDq01r2o1Fc4YA9hPS4/RFUmIPzjZhhl/HWpbE3LCcgGPi470/dxLkzTwNMyPV
	 JrAWQULbeLC8cHk1Lqi/io7aMXrbB0HVry3msMJQRn4gWp6OJMgkMfeNsVP7Q+V2LD
	 fsmRyOUz2pSLw==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/9] mm/madvise: define and use madvise_behavior struct for madvise_do_behavior()
Date: Tue, 11 Mar 2025 13:56:17 -0700
Message-Id: <20250311205617.85289-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cb48d187-6fa5-41f5-9fc9-3f424f105785@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 12:17:40 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Mon, Mar 10, 2025 at 10:23:14AM -0700, SeongJae Park wrote:
> > To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
> > MADV_FREE, an mmu_gather object in addition to the behavior integer need
> > to be passed to the internal logics.  Using a struct can make it easy
> > without increasing the number of parameters of all code paths towards
> > the internal logic.  Define a struct for the purpose and use it on the
> > code path that starts from madvise_do_behavior() and ends on
> > madvise_dontneed_free().
> 
> Oh a helper struct! I like these!
> 
> Nitty but...
> 
> I wonder if we should just add the the mmu_gather field immediately even if
> it isn't used yet?

I will do so in the next spin.

> 
> Also I feel like this patch and 6 should be swapped around, as you are
> laying the groundwork here for patch 7 but then doing something unrelated
> in 6, unless I'm missing something.

I actually introduced patch 6 before this one initially.  But I started
thinking this patch could help not only tlb flushes batching but potential
future madvise behavior extensions, and ended up chaging the order in current
way.  I have no strong opinion and your suggestion also sounds nice to me.  I
will swap those in the next version unless someone makes voice.

> 
> Also maybe add a bit in commit msg about changing the madvise_walk_vmas()
> visitor type signature

I will do so, in the next version.

> (I wonder if that'd be better as a typedef tbh?)

Something like below?

    typedef void *madvise_walk_arg;

I think that could make the code easier to read.  But I feel the void pointer
is also not very bad for the current simple static functions use case, so I'd
like keep this as is if you don't mind.

Please let me know if I'm missing your point.

> 
> However, this change looks fine aside from nits (and you know, helper
> struct and I'm sold obviously ;) so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thank you! :)

> 
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/madvise.c | 36 ++++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 469c25690a0e..ba2a78795207 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -890,11 +890,16 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
> >  	return true;
> >  }
> >
> > +struct madvise_behavior {
> > +	int behavior;
> > +};
> > +
> >  static long madvise_dontneed_free(struct vm_area_struct *vma,
> >  				  struct vm_area_struct **prev,
> >  				  unsigned long start, unsigned long end,
> > -				  int behavior)
> > +				  struct madvise_behavior *madv_behavior)
> 
> Nitty, but not sure about the need for 'madv_' here. I think keeping this as
> 'behavior' is fine, as the type is very clear.

Agreed.  I wanted to reduce the name conflict causing diff lines, but I think
your suggestion is the right thing to do for long term.


Thanks,
SJ

[...]

