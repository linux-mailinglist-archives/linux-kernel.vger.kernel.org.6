Return-Path: <linux-kernel+bounces-539734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83872A4A7F3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF03B4C53
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84935958;
	Sat,  1 Mar 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rG3BgDwk"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC32BD11
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795621; cv=none; b=dDOf2iAHKAu5XK9wGvpcWQ7tzc3WxLopHeDb3mHSlbAPJD8f8aq9KpTN+eBmsBlvBacDStqGYAe+avs0AIZaIGewK2D4x7ICgu0m/IGXGfVuOjIDxS0zOL/zWi6RDBqufDeR87DCmC25ufhQw8c1zCJDFRIbLZfbaPMDwK2ojmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795621; c=relaxed/simple;
	bh=XhJHd6sBU+cpYoPZ2x0rmi50e7FzKiGpQKSbUCUCBdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e30q7WoiMMxEsEgZ6WGMGwS9GnGu6Sv75D1OBOJ6781FkhppFC+5fw9L8u1cvmg0/KZ1ibLl85+xBUW2yxrdSzJCjN+P8a24qeOY+EYEsh5tN003VTUS1ktzyY1V6uNnY4FIeDUjS3+BO1hDpKcVFmcl27thLAqDpEupQtYbCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rG3BgDwk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 1 Mar 2025 02:20:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740795615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdS0rjy+ZZ8LpvmYWlmO+BbMXR5SRGaF7Gms31jW3mc=;
	b=rG3BgDwko3U3irNwldXrTPsJ8q8i/z7JsnpgVC5kGGmX3ES01MDwpx/QCs/HSx+2pzlOMr
	O1MLj/yFqe/8u2intracwOG9MVWAnP9dLZM7zmAEmOYNFyjDmfzgaS9ChcpMinkyDRMXH/
	IGIOuUaa6GWZ4lhtAQ84yz4flvAUz4Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <Z8Ju2CQiAImCo9sQ@google.com>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <CAKEwX=MR7bhebu+7qnoUrADL0C2Uqi3Ta7Beo=s0Aim28BSDVw@mail.gmail.com>
 <Z8DfQahDy7ig643i@google.com>
 <CAKEwX=PurvxHEvyy6tTNxTXVvhUN3Fz=EURb5h0-u7H=pL8UYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PurvxHEvyy6tTNxTXVvhUN3Fz=EURb5h0-u7H=pL8UYA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 28, 2025 at 06:08:16PM -0800, Nhat Pham wrote:
> On Thu, Feb 27, 2025 at 1:55 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Thu, Feb 27, 2025 at 01:46:29PM -0800, Nhat Pham wrote:
> > > On Wed, Feb 26, 2025 at 5:19 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> > > >
> > > > On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > > > > Currently, we crash the kernel when a decompression failure occurs in
> > > > > zswap (either because of memory corruption, or a bug in the compression
> > > > > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > > > > process asking for the zswap entry on zswap load, and skip the corrupted
> > > > > entry in zswap writeback. The former is accomplished by returning true
> > > > > from zswap_load(), indicating that zswap owns the swapped out content,
> > > > > but without flagging the folio as up-to-date. The process trying to swap
> > > > > in the page will check for the uptodate folio flag and SIGBUS (see
> > > > > do_swap_page() in mm/memory.c for more details).
> > > >
> > > > We should call out the extra xarray walks and their perf impact (if
> > > > any).
> > >
> > > Lemme throw this in a quick and dirty test. I doubt there's any
> > > impact, but since I'm reworking this patch for a third version anyway
> > > might as well.
> >
> > It's likely everything is cache hot and the impact is minimal, but let's
> > do the due diligence.
> >
> 
> Yeah I ran some kernel building tests for 5 times, and found basically
> no difference:
> 
> With the new scheme:
> 
> real: mean: 125.1s, stdev: 0.12s
> 
> user: mean: 3265.23s, stdev: 9.62s
> 
> sys: mean: 2156.41s, stdev: 13.98s
> 
> 
> The old scheme:
> 
> real: mean: 125.78s, stdev: 0.45s
> 
> user: mean: 3287.18s, stdev: 5.95s
> 
> sys: mean: 2177.08s, stdev: 26.52s
> 
> 
> Honestly, eyeballing the results, the mean difference is probably
> smaller than between-run variance. :)

Thanks for checking, that's good. Let's include that in the commit
message too.

