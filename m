Return-Path: <linux-kernel+bounces-237304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F6191EF08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F5A1C21888
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DB55C1A;
	Tue,  2 Jul 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EMbOhh6J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F112942A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901956; cv=none; b=Kx/MmUkQHWoKPzocYBykOHN/DpguQr4aWyLFgWEfdeK3jQW9Rn383lEMV45qr1+M0Z2c0ANLWP73vnRtKYQQTy5G9Z64Z2MLlBHfM/DkD8bbVIPMCfgJbuE7F4EENiX1HKH5AUiNBTeCecOVdYr5u943qtciMyIeQ9Jy73gX6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901956; c=relaxed/simple;
	bh=KPqqP8MQu0/WBOUyr3oCveLpStOsZ9S5NJpNq5Qp25A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Jj8AzEDZk5Rmw2hKBEtL+KFpd5+aG0J+qxDzNnm2r4zzOKgzNsflknkzwYAyJzIAVOEKn174vdJOAP+YjvyjLVL1IyofyLpAKi5W7rIa53/GM/3N47Q36vcl7juD1hElmN4aPYLQ98Lz37l91ygc2a0X6zrrR7yMJeC1VnygIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EMbOhh6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3166C116B1;
	Tue,  2 Jul 2024 06:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719901956;
	bh=KPqqP8MQu0/WBOUyr3oCveLpStOsZ9S5NJpNq5Qp25A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EMbOhh6J1cqeWrM9y+kbMkuu2LBcAYWiWyeg6V5mY9SO7pDNOgPRUlVp/ZLf8rxht
	 XTNoBQGvA49wJLy3PsW7RKpob+kTgZ5i46A9V1DdAewwmZZV1vsbCm+V5dnj7WDDPb
	 4oU/HDbBH6uz1fkDufWOrOac2bDPO4UG2UXsbzAk=
Date: Mon, 1 Jul 2024 23:32:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, David
 Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/vmscan: drop checking if _deferred_list is empty
 before using TTU_SYNC
Message-Id: <20240701233235.a1ae705c72ba6f81531c21fd@linux-foundation.org>
In-Reply-To: <CAGsJ_4y9yjFgccoja63Yw=SOv96d2+8sc4_9s7xfJ8mHh2BkOg@mail.gmail.com>
References: <20240629234155.53524-1-21cnbao@gmail.com>
	<bfdf6970-48cc-477a-b726-5e0da242da93@arm.com>
	<CAGsJ_4y9yjFgccoja63Yw=SOv96d2+8sc4_9s7xfJ8mHh2BkOg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2024 21:35:41 +1200 Barry Song <21cnbao@gmail.com> wrote:

> > > +++ b/mm/vmscan.c
> > > @@ -1291,7 +1291,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> > >                        * try_to_unmap acquire PTL from the first PTE,
> > >                        * eliminating the influence of temporary PTE values.
> > >                        */
> > > -                     if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
> > > +                     if (folio_test_large(folio))
> >
> > As it stands, the list_empty() technically needs a data_race() annotation. I
> > think your original patch went into v6.10-rc1? If so, perhaps it makes sense to
> > try to get this into the next rc?
> 
> Either way is fine. Hi Andrew, if you include it for the next RC, could you
> please add this tag?
> 
> Fixes: 73bc32875ee9 ("mm: hold PTL from the first PTE while reclaiming
> a large folio")

Nope!  That invites people to backport this change into kernels which
don't contain Ryan's 5ed890ce5147 ("mm: vmscan: avoid split during
shrink_folio_list()").

I'll simply queue this in the normal fashion.

> And an additional changelog:
> 
> Additionally, the list_empty() technically requires a data_race() annotation.

Done, thanks.

