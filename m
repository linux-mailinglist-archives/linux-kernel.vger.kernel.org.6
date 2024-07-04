Return-Path: <linux-kernel+bounces-240466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD95926E09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F5B1C21470
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AC28689;
	Thu,  4 Jul 2024 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N+EjkFUc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD1224D7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720063723; cv=none; b=rG1m1RQ7xywLhJfz31HgKpGSfONAUa0WF0r+MIwb8AwZwaGtoB2SlHUH+v87duPoFU1CyN4KHmFvEginbXh8tYqVNruySVEtKbHkMunpZfEp9XYNgOTy0lGCay+cbW/SuSZRR3fFLtIga7fPyE3tHRxE3226M22rkmXWO5J9tKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720063723; c=relaxed/simple;
	bh=5fXgIYSCBeWnApcXJyPKIVtz9r/QMZkA/T0lGQu2Wdc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rvhh8xhMGGylg6c3t7xk7SeD4eRU6yGcShEtcckl7JgumL4HZIKbtVZgAAKgu0mNJ3JhTvCokunkYo9awBJvXzmwSadA1YMXQvypx3axumeUSXcGLudbcu+lBzD384HeBY0cwywyEH2Cp/iPDV0krXKKHTagrFnOIRUWiOYmhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N+EjkFUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BCEC3277B;
	Thu,  4 Jul 2024 03:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720063723;
	bh=5fXgIYSCBeWnApcXJyPKIVtz9r/QMZkA/T0lGQu2Wdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N+EjkFUc93iGPNLFFxaHJuGjS0cjYqXzi7rjARm20vooFV3VijeSswcXpG3J8QPKq
	 DJFXv85U6dAlm2eUgRQmmzm4BDt/lfg6t9N/TCrgwAyRkKlF9JF8Ho/gPORQmpZezs
	 6Rmj2SvbwNPQXS5ROyRZqs9bHWFon8imyjemTGO4=
Date: Wed, 3 Jul 2024 20:28:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham
 <nphamcs@gmail.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
 <ziy@nvidia.com>, Barry Song <baohua@kernel.org>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, David Hildenbrand <david@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Message-Id: <20240703202842.e9e50fbeba1ea0cd3a4605f1@linux-foundation.org>
In-Reply-To: <825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
	<20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org>
	<825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 20:21:22 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> On Wed, 3 Jul 2024, Andrew Morton wrote:
> > On Tue, 2 Jul 2024 00:40:55 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > 
> > > Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
> > > flags when freeing, yet the flags shown are not bad: PG_locked had been
> > > set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
> > > deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
> > > symptoms implying double free by deferred split and large folio migration.
> > > 
> > > 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
> > > folio migration") was right to fix the memcg-dependent locking broken in
> > > 85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
> > > but missed a subtlety of deferred_split_scan(): it moves folios to its own
> > > local list to work on them without split_queue_lock, during which time
> > > folio->_deferred_list is not empty, but even the "right" lock does nothing
> > > to secure the folio and the list it is on.
> > > 
> > > Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
> > > folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
> > > while the old folio's reference count is temporarily frozen to 0 - adding
> > > such a freeze in the !mapping case too (originally, folio lock and
> > > unmapping and no swap cache left an anon folio unreachable, so no freezing
> > > was needed there: but the deferred split queue offers a way to reach it).
> > 
> > There's a conflict when applying Kefeng's "mm: refactor
> > folio_undo_large_rmappable()"
> > (https://lkml.kernel.org/r/20240521130315.46072-1-wangkefeng.wang@huawei.com)
> > on top of this hotfix.
> 
> Yes, anticipated in my "below the --- line" comments:
> sorry for giving you this nuisance.

np

> And perhaps a conflict with another one of Kefeng's, which deletes a hunk
> in mm/migrate.c just above where I add a hunk: and that's indeed how it
> should end up, hunk deleted by Kefeng, hunk added by me.

Sorted, I hope.

> > 
> > --- mm/memcontrol.c~mm-refactor-folio_undo_large_rmappable
> > +++ mm/memcontrol.c
> > @@ -7832,8 +7832,7 @@ void mem_cgroup_migrate(struct folio *ol
> >  	 * In addition, the old folio is about to be freed after migration, so
> >  	 * removing from the split queue a bit earlier seems reasonable.
> >  	 */
> > -	if (folio_test_large(old) && folio_test_large_rmappable(old))
> > -		folio_undo_large_rmappable(old);
> > +	folio_undo_large_rmappable(old);
> >  	old->memcg_data = 0;
> >  }
> > 
> > I'm resolving this by simply dropping the above hunk.  So Kefeng's
> > patch is now as below.  Please check.
> 
> Checked, and that is correct, thank you Andrew.

great.

> Correct, but not quite
> complete: because I'm sure that if Kefeng had written his patch after
> mine, he would have made the equivalent change in mm/migrate.c:
> 
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -443,8 +443,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	}
>  
>  	/* Take off deferred split queue while frozen and memcg set */
> -	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
> -		folio_undo_large_rmappable(folio);
> +	folio_undo_large_rmappable(folio);
>  
>  	/*
>  	 * Now we know that no one else is looking at the folio:
> 
> But there's no harm done if you push out a tree without that additional
> mod: we can add it as a fixup afterwards, it's no more than a cleanup.

OK, someone please send that along?  I'll queue it as a -fix so a
single line of changelog is all that I shall retain (but more is
welcome!  People can follow the Link:)

> (I'm on the lookout for an mm.git update, hope to give it a try when it
> appears.)

12 seconds ago.

