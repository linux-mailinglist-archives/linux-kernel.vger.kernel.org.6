Return-Path: <linux-kernel+bounces-564868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB0A65C16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219A2880927
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545461C07DA;
	Mon, 17 Mar 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DX+gdALY"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035141527B4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235078; cv=none; b=ZimNzuPjgJXijGnE4VlE/Nv5/0CAKmtkh5GVzO3d43DXDylpZZwk9pV6qIXiTx3hWpxafrN6tleM7VtNLorwzUAJwMHD1+iA7JX6BlW6vK7jmXjTT8YNPRvTEalQwedyFRm/glOW4OJhQ2ntgWAYOzXDghQFz6hJ82U2v4yuoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235078; c=relaxed/simple;
	bh=fmalzuctL20OkHQ1hWbUbLtduL/OfiKDgTuRLL/W6VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llR+Zmm65TxtZ+N5oBgnIVdnPqrdCIRRqkLIDDf4U2ZQnme7GUrVoyoqeWG/qd4rWqpHJY6+8y1Zr6jugppP+Apu8nM4o/a+23N8aiXyWy23kRN9/5pF4CQkVgf1cSjl3Jz39wMJ/J5NE2/j6q9ZB2Vcw1CqfXhzuk5/1zZfdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DX+gdALY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 17 Mar 2025 11:11:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742235071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7003ixVEAkzMyKIkqmqniYWXO52f73tAfAAJHDgPVrY=;
	b=DX+gdALYkMPQFfqZil3cgU8zFwGRrpmD5vnZatCf5Pmc/IgE8XQkUHv6XCfYGwyqcsx2bd
	3zB2QVuQwiFWbZvDjXCapRHUA7QRGNiqSAE+HNw54UxOB+CZwGLaI0Jr+0tHscjyGj8t0Z
	fYRwS6SQTREE8mo35ICHd8As3Cvs27Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/9] memcg: cleanup per-cpu stock
Message-ID: <rlqqda3ybocvnmhvcqjtuohabjviib6lowrtt2yxmpayf4xfly@gavpf2o55qlc>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
 <tk35wbak4rp4cpz7khnkpwz7ortta26otktb67c5pmt3yan34z@qgyjxc44rvmp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tk35wbak4rp4cpz7khnkpwz7ortta26otktb67c5pmt3yan34z@qgyjxc44rvmp>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 16, 2025 at 08:59:20AM -0700, Alexei Starovoitov wrote:
> On Sat, Mar 15, 2025 at 08:57:59PM -0700, Andrew Morton wrote:
> > On Sat, 15 Mar 2025 10:49:21 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > 
> > > This is a cleanup series which is trying to simplify the memcg per-cpu
> > > stock code, particularly it tries to remove unnecessary dependencies on
> > > local_lock of per-cpu memcg stock. The eight patch from Vlastimil
> > > optimizes the charge path by combining the charging and accounting.
> > > 
> > > This series is based on next-20250314 plus two following patches:
> > > 
> > > Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> > > Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> > 
> > Unfortunately the bpf tree has been making changes in the same area of
> > memcontrol.c.  01d37228d331 ("memcg: Use trylock to access memcg
> > stock_lock.")
> > 
> > Sigh.  We're at -rc7 and I don't think it's worth working around that
> > for a cleanup series.  So I'm inclined to just defer this series until
> > the next -rc cycle.
> > 
> > If BPF merges reasonably early in the next merge window then please
> > promptly send this along and I should be able to squeak it into
> > 6.15-rc1.
> 
> Ohh. I didn't realize that try_alloc changes are causing so much trouble.
> Sorry about that.
> 
> Andrew,
> 
> could you please instead take bpf-next.git try_alloc_pages branch
> into your tree and resolve two trivial conflicts:
> 1. https://lore.kernel.org/bpf/20250311120422.1d9a8f80@canb.auug.org.au/
> 2. https://lore.kernel.org/bpf/20250312145247.380c2aa5@canb.auug.org.au/
> There are 7 commits there.
> You can also squash Vlastimil's fix
> "Fix the flipped condition in gfpflags_allow_spinning" into 
> "Introduce try_alloc_pages" patch or keep everything as-is.
> 
> I'll drop it from bpf-next right after.
> 
> Then Shakeel can rebase/resend his set without conflicts and everything
> will be nicely ready for the merge window.

Thanks Alexei.

Andrew, if you decide to take try_alloc_pages branch into mm-tree, then
this series should apply cleanly as it is based on next-20250314 which
already have all the try_alloc_pages patches and the conflict
resolutions.

