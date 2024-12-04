Return-Path: <linux-kernel+bounces-431822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932279E41C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B57284C53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13A227BB3;
	Wed,  4 Dec 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mNUb00zM"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBF227BB8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331965; cv=none; b=TUFyEzGL9C5L6frZIGjeBCoxTwIYae6yKjWvCX3CWCUIdbuIjFMcxms/v1jpOW9CUPQLooXSl+HP0/mVL4T/aOQvyaq0Sr46q8kE2gI6WHTQZxGAGPyEVS6OINJqsMqFKenK2x2jjPhIHLxdr5Y1m/1z5/rYnXD4X0bvW/Z3Yws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331965; c=relaxed/simple;
	bh=AoTckwQB4XbKtAP8rqnU2ismAgxj2gHD9zXwJ51Zm90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCss316DQPR10QVhxwYjztwuo+UreVKqqfXITO4Z44rCOFvla5gu1ON2Rj7jrfBUBkH03LRtOBzjjb+GQzxoLJZQdnZvLVo8GiV07RkbDNkyLoLvBWqUC5ToiiJVwNfuHQJqlNBVG1j8PoFe8/y8p+9CywJD0vG8lQbIjnJaKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mNUb00zM; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Dec 2024 09:05:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733331959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oKz/iIFSJt8QV4dTWE8NqIm8tqA1k/wjDtf1ROk5ho=;
	b=mNUb00zMmPKJLU9WWW6DAtG2KbV2BqOuUIIQutxjmnUHKd7oRf4XaK1YklQJLb1egmpyt7
	llDzMq7U9GygeDGRAavdF4005NxaQLKaAuheduXysjWnX2aYiT1pc4oWetukFMp7OnqmEe
	BK9EOgl3yvbgGJccBwl7j9uRm/wPfe8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
Message-ID: <tvywr2jdciwljtdx3wlyxgw6ocdkfoqt6hmuchhrqyk66lfsr7@gkz2rfl2u4y2>
References: <20241202184154.19321-1-ryncsn@gmail.com>
 <20241202184154.19321-2-ryncsn@gmail.com>
 <CAJD7tkYemGu0iqt+ZW9t5zr21PbHkFBRnc=EixiwoNbq0xq5Ew@mail.gmail.com>
 <CAMgjq7Aeh9LCtSkG_RMrZjO_tvGryYA-QuvU9k1ahOzEv8LkgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7Aeh9LCtSkG_RMrZjO_tvGryYA-QuvU9k1ahOzEv8LkgQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 04:25:57PM +0800, Kairui Song wrote:
> On Tue, Dec 3, 2024 at 3:11 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Dec 2, 2024 at 10:42 AM Kairui Song <ryncsn@gmail.com> wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
> > > which is already checked by the caller here. Skip it by calling
> > > __mem_cgroup_uncharge_swap() directly.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/memcontrol.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 7b3503d12aaf..d3d1eb506eee 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -4615,7 +4615,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> > >                  * let's not wait for it.  The page already received a
> > >                  * memory+swap charge, drop the swap entry duplicate.
> > >                  */
> > > -               mem_cgroup_uncharge_swap(entry, nr_pages);
> > > +               __mem_cgroup_uncharge_swap(entry, nr_pages);
> >
> > Would it be better to instead remove the mem_cgroup_disabled() check
> > here and have a single check in this path?
> 
> Good suggestion, and the kernel test bot just reported
> __mem_cgroup_uncharge_swap is undefined with !CONFIG_SWAP, so better
> to fix it by removing the check instead.
> 

This sounds reasonable.

