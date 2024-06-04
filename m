Return-Path: <linux-kernel+bounces-200591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9268FB22A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA095B2269F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1977D146006;
	Tue,  4 Jun 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="LjpPq2uU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836523236
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504178; cv=none; b=p7fBrgtBo4Er0MaTJZ64Or5mxUOT/3EJE9H5+FbFFFd/+nNsyWWAdtZp2SbcombzuLUuOs2z5z8E1TBWtHv3WrT9h3DFVOPsFjt7Z+ZBETUAhH7AST418bSey7T2xwtVw57oQrelwzS7Qgs7/e376GiOXcKzKeI6OtBiEhvUnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504178; c=relaxed/simple;
	bh=YTvUo4bDbUtRz8Mrx/G1Eu66sC8ptn9FqYJ/pB1Lfto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikEOwF0r9rcR8wlbM0KhHyXx/JxfdsrHrJ5gnoT/NRRIu4eQO+bTLMaYl93iF1NSGQ5yNtyieLyQepsir5fxQweuH1+AcpY7SyORAeDlYbGx9ELvLPQhkRkVtWvl5BFFWn+ykpQuHzmBfoX5m1VvE/TAkYcpBFpEV1WRnFalMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=LjpPq2uU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso1281742a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1717504172; x=1718108972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLHDgcmNggdNHf3EzeUOZpycgUaWBgXIJ5YvKPY39Kc=;
        b=LjpPq2uU8EotxVAYMi63bphVYnDTLz2EHrzwWw/hH54IX1OMCmm6Jw4mQDpqIChvLF
         vu5p5u+iwP3u6VABpTb7cmMaJ1WDXR7BB6jFa4+dTZ1R0LpHsZxDJtIkulk8/Xlk4XdQ
         /jCmdXmdonsfRLROmAhqRWsg5ppfV1tGVXIZOH6kOHlTa2QdVNZMwPstHhY93Tr70cpH
         Z86UzIj1U2Bq6FRdgfsJ3LVZr6G3byDNO8csUEK4bv788HkuOjWhjc/G9NnQqGcndo3A
         3pDv9JG74KFjvomyKbPe2PUtpXIPppqJ5lQw0NIZyyyxPf9/I6jcRe9dIcrfRkpXL055
         Tkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504172; x=1718108972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLHDgcmNggdNHf3EzeUOZpycgUaWBgXIJ5YvKPY39Kc=;
        b=k1aVgbNhfvrmRZCK7JPNzd1N0C1tHBzi+ZeqgufdbMQWfRt0M9qtqLPBBhLgtWrn+8
         HPLbHaR5fVCsEyH3nDbn4L0HiP0+EvSS6CeN7rn3OmraR67nOLjbb7fHO50G+tQYmaCv
         kQQNdw42V52dO5XSdPSSWgRJWCVrW1/hj6YV96OpMjzzVqMLJQr4x90X8LyAxnddNfhq
         H4pk2Un5tlL2KA3YbZTTePxbM+OdWGTv8AsVRSPb5U1glhC/s7fgKA5xnFTHPU13wimT
         +93qpLDwzc8Ai+4dFMzacLj7I/wf7l2vLvldwLhMjPTnmJV45QeARrTxKg+lZXQwt8Do
         iwQg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Fy+MCCCkN/Qra04gXjt3U91VdIYREXO9N31/ZRhjA5FFx6/1G3CSTJKbOLy+bl2cV1ytX1IG7pAaG26I+3RXXMXyCjmOqfxiiVvc
X-Gm-Message-State: AOJu0Ywp6oRF/zH8uRHYs5WzsZmgCKn8XhjfFDoBAQuIuomkf3K9BbDH
	Ktvd/yvYpnTxTy3fgwz/z1Ea5vx3m+E2DHNDE0AOnHI6vzYgfZ1AhVcCqLiW5Js=
X-Google-Smtp-Source: AGHT+IEMJjtJrcTRj85tPaJ4W9oFQCsw8xdnrniijkOBxiLJc3N5hYosRv1H29O7yEnJJ18jEBVoBw==
X-Received: by 2002:a50:d657:0:b0:57a:33a5:9b78 with SMTP id 4fb4d7f45d1cf-57a364496famr7231665a12.34.1717504172491;
        Tue, 04 Jun 2024 05:29:32 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:9fa1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb842asm7322606a12.36.2024.06.04.05.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:29:31 -0700 (PDT)
Date: Tue, 4 Jun 2024 08:29:27 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Byungchul Park <byungchul@sk.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, iamjoonsoo.kim@lge.com,
	rientjes@google.com
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <20240604122927.GA1992@cmpxchg.org>
References: <20240604072323.10886-1-byungchul@sk.com>
 <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604084533.GA68919@system.software.com>
 <8734ptccgi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240604091221.GA28034@system.software.com>
 <20240604102516.GB28034@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604102516.GB28034@system.software.com>

On Tue, Jun 04, 2024 at 07:25:16PM +0900, Byungchul Park wrote:
> On Tue, Jun 04, 2024 at 06:12:22PM +0900, Byungchul Park wrote:
> > On Tue, Jun 04, 2024 at 04:57:17PM +0800, Huang, Ying wrote:
> > > Byungchul Park <byungchul@sk.com> writes:
> > > 
> > > > On Tue, Jun 04, 2024 at 03:57:54PM +0800, Huang, Ying wrote:
> > > >> Byungchul Park <byungchul@sk.com> writes:
> > > >> 
> > > >> > Changes from v1:
> > > >> > 	1. Don't allow to resume kswapd if the system is under memory
> > > >> > 	   pressure that might affect direct reclaim by any chance, like
> > > >> > 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
> > > >> >
> > > >> > --->8---
> > > >> > From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> > > >> > From: Byungchul Park <byungchul@sk.com>
> > > >> > Date: Tue, 4 Jun 2024 15:27:56 +0900
> > > >> > Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
> > > >> >
> > > >> > A system should run with kswapd running in background when under memory
> > > >> > pressure, such as when the available memory level is below the low water
> > > >> > mark and there are reclaimable folios.
> > > >> >
> > > >> > However, the current code let the system run with kswapd stopped if
> > > >> > kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> > > >> > until direct reclaim will do for that, even if there are reclaimable
> > > >> > folios that can be reclaimed by kswapd.  This case was observed in the
> > > >> > following scenario:
> > > >> >
> > > >> >    CONFIG_NUMA_BALANCING enabled
> > > >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> > > >> >    numa node0 (500GB local DRAM, 128 CPUs)
> > > >> >    numa node1 (100GB CXL memory, no CPUs)
> > > >> >    swap off
> > > >> >
> > > >> >    1) Run a workload with big anon pages e.g. mmap(200GB).
> > > >> >    2) Continue adding the same workload to the system.
> > > >> >    3) The anon pages are placed in node0 by promotion/demotion.
> > > >> >    4) kswapd0 stops because of the unreclaimable anon pages in node0.
> > > >> >    5) Kill the memory hoggers to restore the system.
> > > >> >
> > > >> > After restoring the system at 5), the system starts to run without
> > > >> > kswapd.  Even worse, tiering mechanism is no longer able to work since
> > > >> > the mechanism relies on kswapd for demotion.
> > > >> 
> > > >> We have run into the situation that kswapd is kept in failure state for
> > > >> long in a multiple tiers system.  I think that your solution is too
> > > >
> > > > My solution just gives a chance for kswapd to work again even if
> > > > kswapd_failures >= MAX_RECLAIM_RETRIES, if there are potential
> > > > reclaimable folios.  That's it.
> > > >
> > > >> limited, because OOM killing may not happen, while the access pattern of
> > > >
> > > > I don't get this.  OOM will happen as is, through direct reclaim.
> > > 
> > > A system that fails to reclaim via kswapd may succeed to reclaim via
> > > direct reclaim, because more CPUs are used to scanning the page tables.
> > > 
> > > In a system with NUMA balancing based page promotion and page demotion
> > > enabled, page promotion will wake up kswapd, but kswapd may fail in some
> > > situations.  But page promotion will no trigger direct reclaim or OOM.
> > > 
> > > >> the workloads may change.  We have a preliminary and simple solution for
> > > >> this as follows,
> > > >> 
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866
> > > >
> > > > Whether tiering is involved or not, the same problem can arise if
> > > > kswapd gets stopped due to kswapd_failures >= MAX_RECLAIM_RETRIES.
> > > 
> > > Your description is about tiering too.  Can you describe a situation
> > 
> > I mentioned "tiering" while I described how to reproduce because I ran
> > into the situation while testing with tiering system but I don't think
> > it's the necessary condition.
> > 
> > Let me ask you back, why the logic to stop kswapd was considered in the
> > first place?  That's because the problem was already observed anyway
> 
> To be clear..
> 
> The problem, kswapd_failures >= MAX_RECLAIM_RETRIES, can happen whether
> tiering is involved not not.  Once kswapd stops, the system should run
> without kswapd even after recovered e.g. by killing the hoggers.  *Even
> worse*, tiering mechanism doesn't work in this situation.

But like Ying said, in other situations it's direct reclaim that kicks
in and clears the flag.

The failure-sleep and direct reclaim triggered recovery have been in
place since 2017. Both parties who observed an issue with it recently
did so in tiering scenarios. IMO a tiering-specific solution makes the
most sense.

