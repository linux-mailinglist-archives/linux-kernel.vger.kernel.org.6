Return-Path: <linux-kernel+bounces-194500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC18D3D32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE549B23B41
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA417DE18;
	Wed, 29 May 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a6US2YVd"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583B1B810
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002547; cv=none; b=bJCX6ee7Uk2kfIEJn/RB527Y6IDH83VRpBS18xNYDvzbsY2GNxZ7mDvt9PFFNcdsM0yzCvu2Gac92J78GnOwgQsC7HO0K00B/3Gkligc0r1E9q8QlFopHovk1NPiZueZA6p9bWqsdJgrlpZD16NL5gXkD/IEbpfY9JEqwrn1Y8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002547; c=relaxed/simple;
	bh=8sAXQPl1bUZJD0jxm7tbfpREHEJIbUabOFHca6tTZUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4+SqyImZBq/gCTjkq3+6z7T1B4y+egJx/sKZle674UZ9UuJmP695D9l4zhp2U/sC5YCyQdcyWidTZZtRjYBXViw1o8Y/Lpomvo8xGyUrdVoCX3bTL8lhtY0VC25bLqIZez0vePBjxt8oN02RAUtQG2Wl/fgjl6N40vEWN/9//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a6US2YVd; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717002541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCyl+E3MJ9UNj67UrMAAlRB5ugKBQHQxC1sMp2jyKYU=;
	b=a6US2YVdl7pQ30ccWBeJx7P8rObolUkRlZPTlrWaVFW9Za+sSLp7IPwgQud2q5KqOH5rCp
	ZtK/3TzaBlWaS4qYfsU2qINVjL6CTXJC3wmfXtuiKiqNOFlYFisWGLw2fQ6O6lIiqMu6u5
	PNMmDV3kyI3Gt9tQFWlfGYej0alrY1U=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: riel@surriel.com
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
Date: Wed, 29 May 2024 10:08:56 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>, 
	Michal Hocko <mhocko@kernel.org>, Facebook Kernel Team <kernel-team@fb.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: vmscan: reset sc->priority on retry
Message-ID: <3rtsgmhjxlaafdw7zeasyt4voa77mzpb32s6tsdz4pj4jglq4p@uuekegdnsolw>
References: <20240529154911.3008025-1-shakeel.butt@linux.dev>
 <ZldV3pNL6ArlgPyU@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldV3pNL6ArlgPyU@P9FQF9L96D>
X-Migadu-Flow: FLOW_OUT

On Wed, May 29, 2024 at 09:20:46AM GMT, Roman Gushchin wrote:
> On Wed, May 29, 2024 at 08:49:11AM -0700, Shakeel Butt wrote:
> > The commit 6be5e186fd65 ("mm: vmscan: restore incremental cgroup
> > iteration") added a retry reclaim heuristic to iterate all the cgroups
> > before returning an unsuccessful reclaim but missed to reset the
> > sc->priority. Let's fix it.
> > 
> > Reported-and-tested-by: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
> > Fixes: 6be5e186fd65 ("mm: vmscan: restore incremental cgroup iteration")
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Good catch!

Thanks.

> 
> > ---
> >  mm/vmscan.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b9170f767353..731b009a142b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6317,6 +6317,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
> >  	 * meaningful forward progress. Avoid false OOMs in this case.
> >  	 */
> >  	if (!sc->memcg_full_walk) {
> > +		sc->priority = initial_priority;
> >  		sc->memcg_full_walk = 1;
> >  		goto retry;
> >  	}
> > -- 
> > 2.43.0
> > 
> 
> I wonder if it makes sense to refactor things to be more robust like this:

Oh I like this as it will make sc->priority values explicit. I hope we
don't have any hidden dependency on do-while semantics for this code
path.

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d3ae6bf1b65c7..f150e79f736da 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6246,7 +6246,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>         if (!cgroup_reclaim(sc))
>                 __count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
> 
> -       do {
> +       for (sc->priority = initial_priority; sc->priority >= 0; sc->priority--) {
>                 if (!sc->proactive)
>                         vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
>                                         sc->priority);
> @@ -6265,7 +6265,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>                  */
>                 if (sc->priority < DEF_PRIORITY - 2)
>                         sc->may_writepage = 1;
> -       } while (--sc->priority >= 0);
> +       }
> 
>         last_pgdat = NULL;
>         for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
> @@ -6318,7 +6318,6 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>          * good, and retry with forcible deactivation if that fails.
>          */
>         if (sc->skipped_deactivate) {
> -               sc->priority = initial_priority;
>                 sc->force_deactivate = 1;
>                 sc->skipped_deactivate = 0;
>                 goto retry;
> @@ -6326,7 +6325,6 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
> 
>         /* Untapped cgroup reserves?  Don't OOM, retry. */
>         if (sc->memcg_low_skipped) {
> -               sc->priority = initial_priority;
>                 sc->force_deactivate = 0;
>                 sc->memcg_low_reclaim = 1;
>                 sc->memcg_low_skipped = 0;

