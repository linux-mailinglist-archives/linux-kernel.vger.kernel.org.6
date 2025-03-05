Return-Path: <linux-kernel+bounces-548003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3AFA53EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5838B16E579
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97612207A23;
	Wed,  5 Mar 2025 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp0K89Em"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAC4A06
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218996; cv=none; b=FLhfwrw8ZXaeg6pfD1OheD8Wd7tpukX78VZt0KYeO8gItgiTZ+Oi+6jbRJea1Zx/TUOWNsZNqVOdygKRp0nZZbdwZ8EulmLGmu8r65HtPE3TiqdYsL8rdy7a1ea9cGJNCFm3ZqgWl1/Otj8BNWwhNl3OE11vb48Bl5LGPToIStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218996; c=relaxed/simple;
	bh=Hzjlp30dCTBYdo66QorfE8yUiVB8YP6kBzBJxDX0R+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icnemr5PpWixNBKeVDzrI1l7xkr/+GOpljJmm+UM3l0V1mpV4YA8RraBP29NSfubQm0Telkg8Uvo1voyYSy0b51XlsTG+CdZVVfkB49jwnkgi0hx1WduQEYAq6r5lSDuhkbRw5rOA/cHvnUNaUztKJP1cLRbKV8jO2a36Ekds40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp0K89Em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D62C4CED1;
	Wed,  5 Mar 2025 23:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741218995;
	bh=Hzjlp30dCTBYdo66QorfE8yUiVB8YP6kBzBJxDX0R+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sp0K89EmUnXwOfMGrDv2rVmOfvJa34KCMUlf5QQdeNyCarMumtlKYuy73SpMyL5+D
	 nTG99D69EXqv2S0UY53v75I4CQxpOdKD2srh6pI5SQKuBuW5T3/Kw0AinZePl9IQ2W
	 2nV/z2whuFiDh7Zx8Hr3OkbmFSB8IlV17nu2pYMEMImG6AnBy095LbkmF0iZoEmBDT
	 0ULEJvXR1S8bNdW5tzg3gyaV0lpdorVRHwugWq+UVPdPKPL3en7sjTNCajT6l3M9GJ
	 fVwoFr2wfUnaTJTCfoPWTVTd342LAUO1HUddYQsGGZXSiZ1pFMZ2NC/INYoISYS/Vy
	 ay+SYFquH2kdw==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/16] mm/madvise: define and use madvise_behavior struct for madvise_do_behavior()
Date: Wed,  5 Mar 2025 15:56:32 -0800
Message-Id: <20250305235632.137169-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <wdre2a4y6xmkvn4pgoptaqc67b6t646hgypbyjbin23u32zd3h@qrrdupkncnea>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 13:40:17 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 01:02:15PM -0800, Shakeel Butt wrote:
> > On Wed, Mar 05, 2025 at 10:16:00AM -0800, SeongJae Park wrote:
> > > To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
> > > MADV_FREE, an mmu_gather object in addition to the behavior integer need
> > > to be passed to the internal logics.  Define a struct for passing such
> > > information together with the behavior value without increasing number
> > > of parameters of all code paths towards the internal logic.
> > > 
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  mm/madvise.c | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index c5e1a4d1df72..3346e593e07d 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1665,9 +1665,15 @@ static bool is_memory_populate(int behavior)
> > >  	}
> > >  }
> > >  
> > > +struct madvise_behavior {
> > > +	int behavior;
> > > +};
> > 
> > I think the patch 5 to 8 are just causing churn and will be much better
> > to be a single patch.

I agree.  I will do so in the next version.

> > Also why not make the above struct a general
> > madvise visit param struct which can be used by both
> > madvise_vma_anon_name() and madvise_vma_behavior()?

I was also thinking we can further extend the struct for more clean and
efficient code, so agree to your fundamental point.  I ended up desiring to
focus on tlb flushes batching at the moment, though.

However, what you are suggesting is bit different from what I was thinking.  To
me, madvise_walk_vmas() is for general purposes and hence the visit functions
should be able to recieve an argument of arbitrary types.  It is true that
there are only two visit functions, but they seems doing very different purpose
works to me, so having a same type argument doesn't seem very straightforward
to understand its usage, nor efficient to my humble viewpoint.

> 
> Something like following:
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c5e1a4d1df72..cbc3817366a6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -890,11 +890,17 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
>  	return true;
>  }
>  
> +struct madvise_walk_param {
> +	int behavior;
> +	struct anon_vma_name *anon_name;
> +};

Only madvise_vma_behavior() will use 'behavior' field.  And only
madvise_vma_anon_name() will use 'anon_name' field.  But I will have to assume
both function _might_ use both fields when reading the madvise_walk_vmas()
function code.  That doesn't make my humble code reading that simple and
straightforward.

Also populating and passing a data structure that has data that would not
really be used seems not very efficient to me.

[...]
> @@ -1666,8 +1674,10 @@ static bool is_memory_populate(int behavior)
>  }
>  
>  static int madvise_do_behavior(struct mm_struct *mm,
> -		unsigned long start, size_t len_in, int behavior)
> +		unsigned long start, size_t len_in,
> +		struct madvise_walk_param *arg)
>  {
> +	int behavior = arg->behavior;
>  	struct blk_plug plug;
>  	unsigned long end;
>  	int error;
> @@ -1681,7 +1691,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  	if (is_memory_populate(behavior))
>  		error = madvise_populate(mm, start, end, behavior);

'arg' is for madvise_walk_vmas() visit function, but we're using it as a
capsule for passing an information that will be used for madvise_do_behavior().
This also seems not very straightforward to my humble perspective.

I have no strong opinion and maybe my humble taste is too peculiar.  But, if
this is not a blocker for tlb flushes batcing, I'd like to suggest keep this
part as is for now, and revisit for more code cleanup later.  What do you
think, Shakeel?


Thanks,
SJ

