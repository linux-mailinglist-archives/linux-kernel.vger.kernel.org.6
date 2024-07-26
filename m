Return-Path: <linux-kernel+bounces-263542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A4293D77C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71542830A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259117C7C9;
	Fri, 26 Jul 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xqC8vk6N"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9F11C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014323; cv=none; b=YKeo4XsuKn7PL8G608H1oj9/xTfAGeouBk7FG89HbXwllrH0TDPOrOqqfi1uTemdRra/IiRe6zFDJFHfRPMNuC62HNvQJgCj13WRlVCv/bkJZbjc7cgoBxIIVNKA+09VNs3hbZts3WjkRbETcoqGJBk2UI+yr7eQq9BO/HGzFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014323; c=relaxed/simple;
	bh=ZAmMKQhGyl3XVYw0caelDu5pNLL73OFbtHBXYGbhWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg64qot3Tytbkywz81LbHXmmu/xHrU4wyUvkEAzYF3e6L5bVhOR6ckc7M0ljQLW7qGgDLWR8tBZ6gcNmfgcUYm3Xb/SxVeEvdnuO/2ZNhCBFo1hbc3JaJb8Gio3WL7i6WdAoZ9ihCm7BE2/8Qv3+FhzyF/6xGoHC4JnRx2pH4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xqC8vk6N; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Jul 2024 10:18:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722014318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxH9k/ZdxavpXvNcMlt8l3fpPkI8Dw8TBK+Fgx//zY0=;
	b=xqC8vk6NBpFlPewvvHB0ZVk3Ew/8c7mGK9PL26TplWIca9ZXsrpGMVJda2Qq6U0rV6GiS6
	VuZA+52rNnEl4eZ/fv4fVGyh67/eCuFn0pfMZFHCUuX7JHk7WtKX5/Fl744LLCA1lO5HAQ
	3d4rZm/8K1cYCLpX5FhpU0P9uAo62pA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Greg Thelen <gthelen@google.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
Message-ID: <7zijk3p3uw6esihry6d3qqrsahhnxnvvw6aqb56ocgujrj7qwc@f7bileo5sl6x>
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
 <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr>
 <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com>
 <CABdmKX0XtaBCF-Dwv2rJBUTjj1NXOus9CL9k2ubaJRSGM35vTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0XtaBCF-Dwv2rJBUTjj1NXOus9CL9k2ubaJRSGM35vTg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 26, 2024 at 09:50:49AM GMT, T.J. Mercier wrote:
> On Fri, Jul 26, 2024 at 9:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
[...]
> >
> > Oh yeah we already charge the root's page counters hierarchically in
> > the upstream kernel, we just do not charge them if the origin of the
> > charge is the root itself.
> >
> > We also have workloads that iterate top-level memcgs to calculate the
> > total charged memory, so memory.children_usage for the root memcg
> > would help.
> >
> > As for memory.current, do you have any data about how much memory is
> > charged to the root itself?
> 
> Yeah I wonder if we'd be able to see any significant regressions for
> stuff that lives there today if we were to start charging it. I can
> try running a test with Android next week. I guess try_charge() is the
> main thing that would need to change to allow root charges?
> 

It would a bit more involved like allocating objcg for the root and
changing memcg_slab_post_alloc_hook() to use root memcg if account flags
are not present. There might some changes needed for list_lru and
reclaim but I have not looked deeper into it yet.

