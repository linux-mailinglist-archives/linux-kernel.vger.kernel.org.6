Return-Path: <linux-kernel+bounces-444272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB99F03DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2407F2842B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FFB17B50E;
	Fri, 13 Dec 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GOvvxWUu"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25817109B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064944; cv=none; b=WIdHh2jDjaqLkYolgtOqkh1CXGIoSqpL+qcc//UajuNy98FMU+xWuTHIBsE0/1Y2hb1AICr8xtAKscTIvkQcynPn2uV1QiczuzViohbS2ut4clTucRsy8UVDynqvd3LsDLKcnJ5BZgLkJSAJ/6UtfDXkh7Mbz4NmoDDjUO7WMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064944; c=relaxed/simple;
	bh=SJ1Yf1GKc/E93rWNjfnaH+hsrxUijYC4eO6y54WT8Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBrd7j2bmWBMIt45hTrBSy+yqM/LxhSh2MJY6xpdqi5gO4DFdBMBoJq3WnIND7Rnic7QCUePF2/8dGPKXTOBbkfh+ijkozMLrlwER3+ikr+AzdonwmV7iwiriu8rDJOa0Pv0S/Mg/A/IFjK8uT6cA1F/QQSa7S7B/odcTzTBv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GOvvxWUu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so107129685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734064940; x=1734669740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=doqHV7X4srCESak8AqpW6ZG84XWySTc3Joa+0PJxz44=;
        b=GOvvxWUuRAyXCi7y/pMdkviVm1lolmpztjgFzpDF+WTT6nQHzlGg0FCpN92gxBnzyS
         28NvRzXDH1D45i4LNaJR1/LL43Luuyup4h6pRMvb+Lb+1aK8kTdfADISLl8AS/1XR0tk
         AjJ3Al8C4tHl72wF8eU3B2SblDOew/DOnrUdQQa6yG7Aq9yD/9x/AvT8HlGgt/ajZUav
         ZipX4N/fYJOxpQlSSgNzz4wvAk4Htu8OM1eGeqTcDwh8mzL2O1L1+aFBkEYbT+nEFYlC
         KwiVtNDAUq3Z/DKazyM+P4sDt07Us5rqtW9GCLydg5QP+zwALy672ueIDI4Tl0V3CNht
         p1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734064940; x=1734669740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doqHV7X4srCESak8AqpW6ZG84XWySTc3Joa+0PJxz44=;
        b=CEIG5NB68A/ttan4OquAQ/z1vVzL28ciLOIv9F+vn42KgtQrYrIRm/2/9AGcOMFroA
         RLE2BvUSGNu10a1mlen/og4vt22BahtrPTMrPmo8U6TqtjLb09EoqyVWXgSsLp+L3N8Q
         fV69jiqv5cMdwy6qJEe/sicavwAA2ozSH29SuxYF4aq4kBCOHB2yVuomojxDe1h1vZHE
         n1QRshm+F74FDtROG9SJgUxW2uHjgzP6MZn+k3vlEZaIwKVM/UQ/rOHxWoyqwqaMBwUw
         EEsCn+W4oBGOaNqTSheZWv2OH92V4aG6cvcehgjZYYmZMPlB6fRMcBstS8InHIIyUQoH
         s5yA==
X-Forwarded-Encrypted: i=1; AJvYcCUc9g0PeO9Gw2EV+8VPp5/znBMPNmObmuOqQkcowoIJoY6szWzFhaAP/DW10ZrTo0/iRnjRF1w4auoGljA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlw3JECxavp1umUsoYFfCUxAVa+Z1fPO/3IsGme8IU6GIVctkP
	KLBw6OCoPLLFsolPXULtkmVTgHLB4QrATj+NAeYQkfpLewwOM+Dv5aj47Eal6bA=
X-Gm-Gg: ASbGncvpL3SuL8noQWShEZv2rrH30i5SUYn+PUIWE1MqlWn8T21R2n7wDc2iZuOuy1F
	P8WTo8B5PZAcXcQHNJmmDx3dhjEuEKzreg6erU/Ed6Hifb7moe/QpVRBcZbk+FMf8BvSP232pxz
	eUTPAulkQOmo5Td08fehJ9Sir0R7Map5KQAJswgtHyUWWAkcrGae89SUebcgC9SRb1+i90HAOgG
	lVeJSLUX4y25m6rUTBvKBjj9xVadh3Pkld1Tf8EJ3UWu63BRXhEISw=
X-Google-Smtp-Source: AGHT+IGjJJYcn75s9DDI/soD8CkuZPWEEXQITEJPoftUx+AIzZnB5mh1pETTouvPCh12CwbWHR3H9Q==
X-Received: by 2002:a05:620a:1a95:b0:7b6:d6dd:8826 with SMTP id af79cd13be357-7b6fbf43a6bmr193238285a.55.1734064939930;
        Thu, 12 Dec 2024 20:42:19 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6e5ca6c65sm300162185a.125.2024.12.12.20.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:42:18 -0800 (PST)
Date: Thu, 12 Dec 2024 23:42:13 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <20241213044213.GA6910@cmpxchg.org>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z1uAi0syiPY7h6wt@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1uAi0syiPY7h6wt@google.com>

On Fri, Dec 13, 2024 at 12:32:11AM +0000, Roman Gushchin wrote:
> On Thu, Dec 12, 2024 at 01:30:12PM -0500, Johannes Weiner wrote:
> > On Thu, Dec 12, 2024 at 09:06:25AM -0800, Yosry Ahmed wrote:
> > > On Thu, Dec 12, 2024 at 8:58 AM Rik van Riel <riel@surriel.com> wrote:
> > > >
> > > > A task already in exit can get stuck trying to allocate pages, if its
> > > > cgroup is at the memory.max limit, the cgroup is using zswap, but
> > > > zswap writeback is enabled, and the remaining memory in the cgroup is
> > > > not compressible.
> > > >
> > > > This seems like an unlikely confluence of events, but it can happen
> > > > quite easily if a cgroup is OOM killed due to exceeding its memory.max
> > > > limit, and all the tasks in the cgroup are trying to exit simultaneously.
> > > >
> > > > When this happens, it can sometimes take hours for tasks to exit,
> > > > as they are all trying to squeeze things into zswap to bring the group's
> > > > memory consumption below memory.max.
> > > >
> > > > Allowing these exiting programs to push some memory from their own
> > > > cgroup into swap allows them to quickly bring the cgroup's memory
> > > > consumption below memory.max, and exit in seconds rather than hours.
> > > >
> > > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > > 
> > > Thanks for sending a v2.
> > > 
> > > I still think maybe this needs to be fixed on the memcg side, at least
> > > by not making exiting tasks try really hard to reclaim memory to the
> > > point where this becomes a problem. IIUC there could be other reasons
> > > why reclaim may take too long, but maybe not as pathological as this
> > > case to be fair. I will let the memcg maintainers chime in for this.
> > > 
> > > If there's a fundamental reason why this cannot be fixed on the memcg
> > > side, I don't object to this change.
> > > 
> > > Nhat, any objections on your end? I think your fleet workloads were
> > > the first users of this interface. Does this break their expectations?
> > 
> > Yes, I don't think we can do this, unfortunately :( There can be a
> > variety of reasons for why a user might want to prohibit disk swap for
> > a certain cgroup, and we can't assume it's okay to make exceptions.
> > 
> > There might also not *be* any disk swap to overflow into after Nhat's
> > virtual swap patches. Presumably zram would still have the issue too.
> > 
> > So I'm also inclined to think this needs a reclaim/memcg-side fix. We
> > have a somewhat tumultous history of policy in that space:
> > 
> > commit 7775face207922ea62a4e96b9cd45abfdc7b9840
> > Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date:   Tue Mar 5 15:46:47 2019 -0800
> > 
> >     memcg: killed threads should not invoke memcg OOM killer
> > 
> > allowed dying tasks to simply force all charges and move on. This
> > turned out to be too aggressive; there were instances of exiting,
> > uncontained memcg tasks causing global OOMs. This lead to that:
> > 
> > commit a4ebf1b6ca1e011289677239a2a361fde4a88076
> > Author: Vasily Averin <vasily.averin@linux.dev>
> > Date:   Fri Nov 5 13:38:09 2021 -0700
> > 
> >     memcg: prohibit unconditional exceeding the limit of dying tasks
> > 
> > which reverted the bypass rather thoroughly. Now NO dying tasks, *not
> > even OOM victims*, can force charges. I am not sure this is correct,
> > either:
> > 
> > If we return -ENOMEM to an OOM victim in a fault, the fault handler
> > will re-trigger OOM, which will find the existing OOM victim and do
> > nothing, then restart the fault. This is a memory deadlock. The page
> > allocator gives OOM victims access to reserves for that reason.
> > 
> > Actually, it looks even worse. For some reason we're not triggering
> > OOM from dying tasks:
> > 
> >         ret = task_is_dying() || out_of_memory(&oc);
> > 
> > Even though dying tasks are in no way privileged or allowed to exit
> > expediently. Why shouldn't they trigger the OOM killer like anybody
> > else trying to allocate memory?
> > 
> > As it stands, it seems we have dying tasks getting trapped in an
> > endless fault->reclaim cycle; with no access to the OOM killer and no
> > access to reserves. Presumably this is what's going on here?
> > 
> > I think we want something like this:
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 53db98d2c4a1..be6b6e72bde5 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1596,11 +1596,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	if (mem_cgroup_margin(memcg) >= (1 << order))
> >  		goto unlock;
> >  
> > -	/*
> > -	 * A few threads which were not waiting at mutex_lock_killable() can
> > -	 * fail to bail out. Therefore, check again after holding oom_lock.
> > -	 */
> > -	ret = task_is_dying() || out_of_memory(&oc);
> > +	ret = out_of_memory(&oc);
> 
> I like the idea, but at first glance it might reintroduce the problem
> fixed by 7775face2079 ("memcg: killed threads should not invoke memcg OOM killer").

The race and warning pointed out in the changelog might have been
sufficiently mitigated by this more recent commit:

commit 1378b37d03e8147c67fde60caf0474ea879163d8
Author: Yafang Shao <laoar.shao@gmail.com>
Date:   Thu Aug 6 23:22:08 2020 -0700

    memcg, oom: check memcg margin for parallel oom

If not, another possibility would be this:

	ret = tsk_is_oom_victim(task) || out_of_memory(&oc);

But we should probably first restore reliable forward progress on
dying tasks, then worry about the spurious printk later.

