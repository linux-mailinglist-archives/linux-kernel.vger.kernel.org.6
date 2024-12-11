Return-Path: <linux-kernel+bounces-442244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB799ED9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495261602C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405531DC9AB;
	Wed, 11 Dec 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpiqIEXe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108F195
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956240; cv=none; b=Yox90vv7Z6dtrGnd/TZ4+EX3IwH5s0SioJWzk7Xc/4tB59QhWXI5I1CSnS596X0sIFK7gCFzKLrNk9+7DVfM1i6cNDmRzC+5yAWQrdXaRGak/f111qi4diY0XphsnOE+TaBe8UhvC3JLo4pkLC/m7Bd8AUBtiVDHsAH/TF1rqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956240; c=relaxed/simple;
	bh=kEy+7GpAxC5wlzuKPjY6924MZlPCO9+PNji5bLINRCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6jqKVsof0wN0Z7Rr9sOSde3kR06v0TTqZTOySCQ0JFkVBqoobOP6CJ3OVksHRvyKi9D9AyElkFjOkkPF7otcaIORxPLmANwU98k1QB57LerAUXi0NISwzTwoxDDvOiKBerFgv6sGWSlWoT3XQjAHxpZbfQZ3QnLCFTsGgxEYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpiqIEXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A6DC4CED2;
	Wed, 11 Dec 2024 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956240;
	bh=kEy+7GpAxC5wlzuKPjY6924MZlPCO9+PNji5bLINRCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpiqIEXeP61+yi8xk+xvq8O/4IW17T3EiQMXvmR0iweqVq3EpuYWBjEOKXoWNtBYc
	 2B6GIMb14hXxHPefgWSoF0BKNVGWOgQdDmUo0+/DmO1pS9HL9VM7nB/SspU7eJvY22
	 wXmqnpFgpte4CmRG0OObBgSMpDCJUoGmaKB3muFb3tB3ZlbsGct+q6hDHwOCkA42CG
	 djP3hbT6Of8YDgkqVyMdVEHdKumP7iVDb8dkcjhhaZuKABkZirycvCMJWBfyWVKIvZ
	 MnfmcTYYm9XLFUd1NNRAg5SkPuA4r5+Mabtjn4wMl3mqsT2ur0c89x1b7uqBaHQ9Mu
	 KATp9Z1uY+rlA==
Date: Wed, 11 Dec 2024 22:30:35 +0000
From: Will Deacon <will@kernel.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, cl@gentwo.org, scott@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Message-ID: <20241211223034.GA17836@willie-the-truck>
References: <20241118181711.962576-1-yang@os.amperecomputing.com>
 <20241210113151.GC14735@willie-the-truck>
 <414b3388-c2e5-45ae-9f1d-c35310fdbf8b@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414b3388-c2e5-45ae-9f1d-c35310fdbf8b@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey,

On Tue, Dec 10, 2024 at 11:33:16AM -0800, Yang Shi wrote:
> On 12/10/24 3:31 AM, Will Deacon wrote:
> > On Mon, Nov 18, 2024 at 10:16:07AM -0800, Yang Shi wrote:
> > > When rodata=full kernel linear mapping is mapped by PTE due to arm's
> > > break-before-make rule.
> > > 
> > > This resulted in a couple of problems:
> > >    - performance degradation
> > >    - more TLB pressure
> > >    - memory waste for kernel page table
> > > 
> > > There are some workarounds to mitigate the problems, for example, using
> > > rodata=on, but this compromises the security measurement.
> > > 
> > > With FEAT_BBM level 2 support, splitting large block page table to
> > > smaller ones doesn't need to make the page table entry invalid anymore.
> > > This allows kernel split large block mapping on the fly.
> > I think you can still get TLB conflict aborts in this case, so this
> > doesn't work. Hopefully the architecture can strengthen this in the
> > future to give you what you need.
> 
> Thanks for responding. This is a little bit surprising. I thought FEAT_BBM
> level 2 can handle the TLB conflict gracefully. At least its description
> made me assume so. And Catalin also mentioned FEAT_BBM level 2 can be used
> to split vmemmap page table in HVO patch discussion
> (https://lore.kernel.org/all/Zo68DP6siXfb6ZBR@arm.com/).
> 
> It sounds a little bit contradicting if the TLB conflict still can happen
> with FEAT_BBM level 2. It makes the benefit of FEAT_BBM level 2 much less
> than expected.

You can read the Arm ARM just as badly as I can :)

 | I_HYQMB
 |
 | If any level is supported and the TLB entries are not invalidated after
 | the writes that modified the translation table entries are completed,
 | then a TLB conflict abort can be generated because in a TLB there might
 | be multiple translation table entries that all translate the same IA.

Note *any level*.

Furthermore:

 | R_FWRMB
 |
 | If all of the following apply, then a TLB conflict abort is reported
 | to EL2:
 | * Level 1 or level 2 is supported.
 | * Stage 2 translations are enabled in the current translation regime.
 | * A TLB conflict abort is generated due to changing the block size or
 |   Contiguous bit.

I think this series is trying to handle some of this:

https://lore.kernel.org/r/20241211154611.40395-1-miko.lenczewski@arm.com

> Is it out of question to handle the TLB conflict aborts? IIUC we should just
> need flush TLB then resume, and it doesn't require to hold any locks as
> well.

See my reply here:

https://lore.kernel.org/r/20241211210243.GA17155@willie-the-truck

> And I chatted with our architects, I was told the TLB conflict abort doesn't
> happen on AmpereOne. Maybe this is why I didn't see the problem when I
> tested the patches.

I'm actually open to having an MIDR-based lookup for this if its your own
micro-architecture.

Will

