Return-Path: <linux-kernel+bounces-547971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A45A53E45
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B4C7A955F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E2207673;
	Wed,  5 Mar 2025 23:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th+awcCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DF2066FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216412; cv=none; b=J1RVNqeBodlZpwe/pcFXJMdUvWNvuStnN1nIZjMaL16zd1YOCkoMjVJgod//EVHAPRjfDOIPl0+0hJnHde8b+1r5Ywh8IUjukeY6LdNQWWsbdQBNtkHF+JAofFjzoGprXU4LjTkzNEVikFB3NaSD71Ywqt7pge1chUBv5d9M7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216412; c=relaxed/simple;
	bh=nrs6zpmQViFjEJD8G+aklJVnKL0K+d4w0V904x6332Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMISx0xLfkyWoOAN/41rTzpWaKblaF5vPmGqx8LV+UedHlC1gVL6mL6uK/OLzDoandzwxrGDqTsVpu66a7TaEevHs5QH+V95B+QweBEdFAx3gUDuHFcxuZCU3Yd+M3BKcVDjr+pWVJNofTcg9ldxIUqxvyKRcqAtWtG0RURglis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th+awcCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7960C4CED1;
	Wed,  5 Mar 2025 23:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741216412;
	bh=nrs6zpmQViFjEJD8G+aklJVnKL0K+d4w0V904x6332Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Th+awcCSFo8y9tB/bPyc132kczNW/dq2JrKQQNV+PPnBmmxAT8cEmYJ3zD2m6FAWS
	 U5+wcSxAZ8Ghd4YojxFBO8Y2NoFHE/xecOuQ4jquGpFSy+9AsEd/I1T4sZdk6aMTPW
	 KI1NOj6Ol0T0AnkPaRII1L+Xd7dM79bL7QHW6bI5hU2vEd/RLl1P5+sQajIKnZ5t4n
	 i300NdTzdNgbkcsiftwWHluxE+gqva6vBxhhFz0oy6jof0KGvtBOToRohyNKsq24Rv
	 IsGOsLQ4aKrdMne2gKtKgF9KCuteLkiNzPl3vxS+VoiEWPG9xArpUg1uwtfBHHofry
	 gt9LbXpuW+J5Q==
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
Subject: Re: [RFC PATCH 01/16] mm/madvise: use is_memory_failure() from madvise_do_behavior()
Date: Wed,  5 Mar 2025 15:13:29 -0800
Message-Id: <20250305231329.136686-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <exnrnqek3ktgprxzuf27osu6olcnvjzwdlt23a3mm5y2qstl2t@x4ud2xoyguff>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 12:25:51 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 10:15:56AM -0800, SeongJae Park wrote:
> > To reduce redundant open-coded checks of CONFIG_MEMORY_FAILURE and
> > MADV_{HWPOISON,SOFT_OFFLINE} in madvise_[un]lock(), is_memory_failure()
> > has introduced.  madvise_do_behavior() is still doing the same
> > open-coded check, though.  Use is_memory_failure() instead.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/madvise.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 388dc289b5d1..dbc8fec05cc6 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1640,10 +1640,8 @@ static int madvise_do_behavior(struct mm_struct *mm,
> >  	unsigned long end;
> >  	int error;
> >  
> > -#ifdef CONFIG_MEMORY_FAILURE
> > -	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> > +	if (is_memory_failure(behavior))
> >  		return madvise_inject_error(behavior, start, start + len_in);
> 
> You might want to either define empty madvise_inject_error() for
> !CONFIG_MEMORY_FAILURE or keep CONFIG_MEMORY_FAILURE here.

Good catch.  I confirmed build fails when !CONFIG_MEMORY_FAILURE.  I will
define empty madvise_inject_error().

> 
> > -#endif
> >  	start = untagged_addr_remote(mm, start);
> >  	end = start + len;
> >  
> > -- 
> > 2.39.5

