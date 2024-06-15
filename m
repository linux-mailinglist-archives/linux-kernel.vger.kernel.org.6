Return-Path: <linux-kernel+bounces-215675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634449095C3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056801F2242C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47401D53F;
	Sat, 15 Jun 2024 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hx7Duybr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546AD26D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718420362; cv=none; b=th4iHccpRZk/COdbxFbOGeGYYeD6Snm/dlX6HvV4ST/LVzNC8pg37R+gNK6mJnRfPrHwb1vb0pC+mWfQowuQO/cwVnGXCO/goX8jedr1ecYbmPwKfrYHimNcKJajJsencFREUOtgqCrxIbSsMjN8NJTy6rL3sNeSqE64gCVoY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718420362; c=relaxed/simple;
	bh=mkjvUJdS5vqjmt9WAxPq2GEHmcIbM2iUAlz3+HnWaMY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=meDiHebTnGjPzPAF9St/8lQChhigDSw52VUNd7tFpl60NHPcTvqb1MxAVS45VTCfV7ldbQLyu5K0hoWRll0bZtyuXPJPfguqge8cmX8m8PVZchIKX/LRRVSa0PvrWuCK9rikLJLNsuP5MZnCwfOJUxWaNX3ZZQ4AAxl4Qbu6ZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hx7Duybr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AD4C2BD10;
	Sat, 15 Jun 2024 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718420362;
	bh=mkjvUJdS5vqjmt9WAxPq2GEHmcIbM2iUAlz3+HnWaMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hx7Duybr78IeEsr/EImsxu6uIAwwA+fZXVTBNX+bBzb8Q2ioN/qZ9CLLDLhVYy14b
	 206BpUY4e94wgEIV7RPj5R7hhMB5+kIvC/h7akfAYKg0lpbAR5yqTvAqlkKDbYyiwz
	 +xq/GFmEmVU5K7t5GoxPq2YcHdlYz7gDfH19fAlM=
Date: Fri, 14 Jun 2024 19:59:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Huang, Ying" <ying.huang@intel.com>, Kalesh Singh
 <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
Message-Id: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
In-Reply-To: <CANeU7Q=Nd3Os7cm-Lu4h5fvkMdoHeYbtjkUja+sAMcJ2moMKrQ@mail.gmail.com>
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
	<20240614180606.5f3b6f4a6cd515df30b7a0e4@linux-foundation.org>
	<CANeU7Q=Nd3Os7cm-Lu4h5fvkMdoHeYbtjkUja+sAMcJ2moMKrQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote:

> > I'm having trouble understanding the overall impact of this on users.
> > We fail the mTHP swap allocation and fall back, but things continue to
> > operate OK?
> 
> Continue to operate OK in the sense that the mTHP will have to split
> into 4K pages before the swap out, aka the fall back. The swap out and
> swap in can continue to work as 4K pages, not as the mTHP. Due to the
> fallback, the mTHP based zsmalloc compression with 64K buffer will not
> happen. That is the effect of the fallback. But mTHP swap out and swap
> in is relatively new, it is not really a regression.

Sure, but it's pretty bad to merge a new feature only to have it
ineffective after a few hours use.

> >
> > > There is some test number in the V1 thread of this series:
> > > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org
> >
> > Well, please let's get the latest numbers into the latest patchset.
> > Along with a higher-level (and quantitative) description of the user impact.
> 
> I will need Barray's help to collect the number. I don't have the
> setup to reproduce his test result.
> Maybe a follow up commit message amendment for the test number when I get it?

Yep, I alter changelogs all the time.

> >
> > I'll add this into mm-unstable now for some exposure, but at this point
> > I'm not able to determine whether it should go in as a hotfix for
> > 6.10-rcX.
> 
> Maybe not need to be a hotfix. Not all Barry's mTHP swap out and swap
> in patch got merged yet.

OK, well please let's give appropriate consideration to what we should
add to 6.10-rcX in order to have this feature working well.

