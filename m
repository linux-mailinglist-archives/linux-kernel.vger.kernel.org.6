Return-Path: <linux-kernel+bounces-231315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202E918DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9C81F2433F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C914190468;
	Wed, 26 Jun 2024 18:08:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00618FDAA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425326; cv=none; b=p9RCpeoyDebHCBGWMBlKTgbD3WHD0ywGYlPaM+LwIkJQrG2rqMEZ9xdPIsUWEXprd2EBv8Uab01xSRpXsN0oB5REKDnaP8P+yzELRwuCmIeBjAVTpTMpOcAHhmuFby4LFDLjHfR4v4j6HvikFQFNCM6c8AYBn7g02lKuTE+O1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425326; c=relaxed/simple;
	bh=glIEwNGddaHRWOFCSUuchcJljrhG4fYLjJ4bv8uPWVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJzdzch/bl/NAPPh1CdTnYMmtEjbOov17l7W1WkoTtROfEK8OFE3Fu0tUyw8aYyJ/4o0TCBVQIAsUYUsNvnMKn5x7z0LOepY1DbwBXUCmAhjYOyVQ+exffWPZOOG8SfWK88qeL2aaMOZgIuHavgznqwCppRCN3FGPwP1u23N2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139EC116B1;
	Wed, 26 Jun 2024 18:08:44 +0000 (UTC)
Date: Wed, 26 Jun 2024 19:08:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/lib: copy_page: s/stnp/stp
Message-ID: <ZnxZKih_riuFb1NF@arm.com>
References: <20240613001812.2141-1-jszhang@kernel.org>
 <ZnmzUa2D_wWXAlJl@arm.com>
 <ZnwAoWh-_bTxT-rT@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnwAoWh-_bTxT-rT@xhacker>

On Wed, Jun 26, 2024 at 07:50:57PM +0800, Jisheng Zhang wrote:
> On Mon, Jun 24, 2024 at 06:56:33PM +0100, Catalin Marinas wrote:
> > On Thu, Jun 13, 2024 at 08:18:12AM +0800, Jisheng Zhang wrote:
> > > stnp performs non-temporal store, give a hints to the memory system
> > > that caching is not useful for this data. But the scenario where
> > > copy_page() used may not have this implication, although I must admit
> > > there's such case where stnp helps performance(good). In this good
> > > case, we can rely on the HW write streaming mechanism in some
> > > implementations such as cortex-a55 to detect the case and take actions.
> > > 
> > > testing with https://github.com/apinski-cavium/copy_page_benchmark
> > > this patch can reduce the time by about 3% on cortex-a55 platforms.
[...]
> > It looks like it always copies to the same page, the stp may even
> > benefit from some caching of the data which we wouldn't need in a real
> > scenario.
> 
> Yep this is also my understanding where's the improvement from. And
> I must admit there's case where stnp helps performance. we can rely
> on the HW write streaming mechanism to detect and take actions.

Well, is that case realistic? Can you show any improvement with some
real-world uses? Most likely modern CPUs fall back to non-temporal
stores after a series of STPs but it depends on how soon they do it, how
much cache gets polluted. OTOH, page copying could be the result of a
CoW and we'd expect subsequent accesses from the user where some caching
may be beneficial.

So, hard to tell but we should make a decision based on a microbenchmark
that writes over the same page multiple times. If you have some
real-world tests that exercise this path (e.g. CoW, Android app startup)
and show an improvement, I'd be in favour of this. Otherwise, no.

Thanks.

-- 
Catalin

