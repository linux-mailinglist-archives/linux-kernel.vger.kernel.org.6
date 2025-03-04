Return-Path: <linux-kernel+bounces-543712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58DA4D8DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFD21894AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DFA1F4CAD;
	Tue,  4 Mar 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqk66UaT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052C91F4CB0;
	Tue,  4 Mar 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081126; cv=none; b=ldAuKV6qXu0B+pFdjMQCdtuRnMTdI49xR7VyNU+i1yUIaYgp6j/cDbtiHCaUoQ/Dz3ZlEsIsu43l1Tcg7PIzBiYhimnx5BhuVuq4wzkhSTT3/l/YooQUUnhlZ1yVjLvYNVxYCtXMRZ/XUCIfhzXF0b2gHHZeZp82kIyNVHR3hh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081126; c=relaxed/simple;
	bh=DxC5NX0qWkhP9h80/Tv+PBiCLpLWGT+XhaKhTj0h8l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnmIEq8c0kfTX2/yqeW5N8bQmjbKLwdU0OIMcVQzBlTf92A5azDz07l1Uq4IqMzayFNPjCeQR1fi5+vrYW3buv3Oy+caSfMvLTAdA2nHfVEt3VFDKSbAIKdEvgWCcORpBvQDOHfRoqAo91SWjJcC7R6gQo5Ozt9pEvnRyZFQzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqk66UaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77CAC4CEE5;
	Tue,  4 Mar 2025 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081125;
	bh=DxC5NX0qWkhP9h80/Tv+PBiCLpLWGT+XhaKhTj0h8l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hqk66UaTNES3O1K1u8NheKtEMELgpbdbSqTktxWl5WVd1MOcLOxp49iaGxv2DOs2Q
	 rQ8TgasbILnevTrX+UN3YX+nNDy5OSERpRBtvU/x2nhwc+jBfWbXu3UYM7tLj08CIL
	 tgjbDccILQ+3ZMTRlAOV4N4LdE4nrX8ORvcfJWWc+tDMcjRCBpXdZRJoQjf8QnLOr6
	 Nykl6ixKY9WX/xQhWdkPuo7nGkRxlVz2ZF+9g4CSxozlwYujJvanJbWkxdqbSQ2uia
	 C6uqmyY/qU25vfJqi5Pie05nYcug8YlkdR7qpf43mYvZyeMrKU7FCA6qy2VTZiqpVK
	 fTBhlnEve09cQ==
Date: Tue, 4 Mar 2025 10:38:25 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/40] x86: Leaf 0x2 and leaf 0x4 refactorings
Message-ID: <Z8bKEaEWAbE4F1gk@gmail.com>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <Z8bFnGSxmNSFQDSQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8bFnGSxmNSFQDSQ@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > Summary:
> > 
> > - Patches 1 to 3 are independent bugfixes that were discovered during
> >   this refactoring work.
> 
> I've applied these three to tip:x86/urgent. I added Cc: stable to all 3 
> commits, because while these are old bugs, the first one had Cc: stable 
> and if we do it for one it's justified for all of them AFAICS. Arguably 
> our cacheinfo output in procps was inaccurate at times, and possibly 
> these bugs were part of the problem.
> 
> > - Patches 4 to 10 are x86/cpu refactorings for code size and
> >   readability.
> 
> I've applied patches 4 to 9 to tip:x86/cpu (with x86/urgent merged in 
> due to dependencies and to give a singular topical base branch in the 
> x86 tree), they look good and obvious. (I added the build fix to 05/40)
> 
> I've left 10 to 40 for further review by others too.

While going through the rest I also picked up these patches as easy 
preparatory commits in tip:x86/cpu, there was no reason to have them 
later in the series:

  29517791c478 x86/cacheinfo: Remove the P4 trace leftovers for real
  d61b5118f719 x86/cacheinfo: Remove unnecessary headers and reorder the rest
  0d22030c49bf <linux/sizes.h>: Cover all possible x86 CPU cache sizes

Thanks,

	Ingo

