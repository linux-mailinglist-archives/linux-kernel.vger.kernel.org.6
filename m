Return-Path: <linux-kernel+bounces-240846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C6692739B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337F61C23813
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AAA1AB8E5;
	Thu,  4 Jul 2024 10:03:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC818637
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087433; cv=none; b=EcKpaGAisXE1IrvsPryTJcf+v5BTXS9+hT/H4gfu5X4NLNNxzrzsCWvjYNO64ERwkx5gjoCvIGEc6i8AULcjA8iy/pacXe2erB+jrpwrxt1q37w3IK5kCx9J5B9k2f+WPRa2c7DQhECIgfJhrcJ+9tiBIBjdWcTek6v63+8qhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087433; c=relaxed/simple;
	bh=BqlpIIIYSQoeUdSwfhLix4qHTiPRRJNuEP8fTva0WdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCv9Fr14QI2cg3ar2NgKbfLgoe86+xqkqUE4fjTmiiRXXc/N3iU503SWDAxC+xGgoRwUFzNrz3bxRI+ANniYsiZhbkQZoEmnGfj7x/W6HYQ9rhlQAEl/hUGT1PDpShHcJKx8rFazNgKtZX6rxccmfpn9XPgzRl6qSAwJhrcqWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCE8C3277B;
	Thu,  4 Jul 2024 10:03:51 +0000 (UTC)
Date: Thu, 4 Jul 2024 11:03:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <ZoZzhf9gGQxADLFM@arm.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>

On Tue, Jul 02, 2024 at 03:21:41PM -0700, Yang Shi wrote:
> On 7/1/24 12:43 PM, Catalin Marinas wrote:
> > I don't follow OpenJDK development but I heard that updates are dragging
> > quite a lot. I can't tell whether people have picked up the
> > atomic_add(0) feature and whether, by the time a kernel patch would make
> > it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.
> 
> As Christopher said there may be similar use of atomic in other
> applications, so I don't worry too much about dead code problem IMHO.
> OpenJDK is just the usecase that we know. There may be unknown unknowns. And
> the distros typically backport patches from mainline kernel to their kernel
> so there should be combos like old kernel + backported patch + old OpenJDK.

That's a somewhat valid argument I heard internally as well. People tend
to change or patch kernel versions more often than OpenJDK versions
because of the risk of breaking their Java stack. But, arguably, one can
backport the madvise() OpenJDK change since it seems to have other
benefits on x86 as well.

> AFAICT, the users do expect similar behavior as x86 (one fault instead of
> two faults). Actually we noticed this problem due to a customer report.

It's not a correctness problem, only a performance one. Big part of that
could be mitigated by some adjustment to how THP pages are allocated on
a write fault (though we'd still have an unnecessary read fault and some
TLBI). See Ryan's sub-thread.

> > There's a point (c) as well on the overhead of reading the faulting
> > instruction. I hope that's negligible but I haven't measured it.
> 
> I think I showed benchmark data requested by Anshuman in the earlier email
> discussion.

Do you mean this:

https://lore.kernel.org/r/328c4c86-96c8-4896-8b6d-94f2facdac9a@os.amperecomputing.com

I haven't figured out what the +24% case is in there, it seems pretty
large.

What you haven't benchmarked (I think) is the case where the instruction
is in an exec-only mapping. The subsequent instruction read will fault
and it adds to the overhead. Currently exec-only mappings are not
widespread but I heard some people planning to move in this direction as
a default build configuration.

It could be worked around with a new flavour of get_user() that uses the
non-T LDR instruction and the user mapping is readable by the kernel
(that's the case with EPAN, prior to PIE and I think we can change this
for PIE configurations as well). But it adds to the complexity of this
patch when the kernel already offers a MADV_POPULATE_WRITE solution.

-- 
Catalin

