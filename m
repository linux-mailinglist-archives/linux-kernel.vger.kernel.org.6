Return-Path: <linux-kernel+bounces-543637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A3A4D7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF121886A59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA0D1F8BAA;
	Tue,  4 Mar 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANeC4WE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929218FC6B;
	Tue,  4 Mar 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079969; cv=none; b=WZudYTuKH9r56BzktmnyIHKdskSP+qFFYosMryRl41ThlJcmsLAqpVEjj061t8NBOe0+ST5mX1Qn2wipz0NtV80CnC1ae4lZz0x4saBDqhxosvJsKuotLmE04MEGrDsn6OQSyqrMm81o4E5Jn8AiJNfN3CKGhiklU0Xof5NJ0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079969; c=relaxed/simple;
	bh=0fl48Uf2nzn+BQtUMFHVRC5uSqFoI1ocVXeZcDYLq+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILia0rHnc0D6kLTAB2sXwsQpS+yuoxsgyLYfhapcja6iht0BMuI4i9w5QtzM+7OWg2aXMVxAA9LDXq65l/aOqsPXi0AORnjhU1PPbyrzlkgjEvtDeQlyCTN8p9uDzRNjXAziMNRvc+w7xIizpwSeSQqjrzOnHXE2MkxxG/tvpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANeC4WE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE66C4CEE5;
	Tue,  4 Mar 2025 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741079969;
	bh=0fl48Uf2nzn+BQtUMFHVRC5uSqFoI1ocVXeZcDYLq+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANeC4WE6Z3mc1bAMPK+9Xx0m+p6Tr5mWd42YsQ0jFX2e7yQQfMki+ufrAbvU9En0D
	 TCR4un/wvCjMPkf2H68vxgJk3mHzlmgPFj38Dm6mI9I4KSjvZ/XcQsBfuIdhhUq0Pg
	 H4OenVmMdJGm3axuepEjCnNTCLlh7hDMmFjR9uTJo0TqPUdj/pMIM1nRO39GIGvB/k
	 aZcsAr//OsvrNIWYsk18WUoB8T4Rf29/HDTivVnOgmf/dNfBwc37kemFbhEnXX1bLT
	 i99ZqjGfTKgX4ubRvJ8aCwbu86HNKddQ8vSOmVcN7th9IrRSSbVbzXIa5qB6+MWGAd
	 GtQ0VSb1H1sBQ==
Date: Tue, 4 Mar 2025 10:19:24 +0100
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
Message-ID: <Z8bFnGSxmNSFQDSQ@gmail.com>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> Hi,
> 
> As part of the onging x86-cpuid work [*], we've found that the handling
> of leaf 0x2 and leaf 0x4 code paths is difficult to work with in its
> current state.  This was mostly due to the organic growth of the x86/cpu
> and x86/cacheinfo logic since its very early Linux days.
> 
> This series cleans up and refactors these code paths in preparation for
> the new x86-cpuid model.

Nice!

> Summary:
> 
> - Patches 1 to 3 are independent bugfixes that were discovered during
>   this refactoring work.

I've applied these three to tip:x86/urgent. I added Cc: stable to all 3 
commits, because while these are old bugs, the first one had Cc: stable 
and if we do it for one it's justified for all of them AFAICS. Arguably 
our cacheinfo output in procps was inaccurate at times, and possibly 
these bugs were part of the problem.

> - Patches 4 to 10 are x86/cpu refactorings for code size and
>   readability.

I've applied patches 4 to 9 to tip:x86/cpu (with x86/urgent merged in 
due to dependencies and to give a singular topical base branch in the 
x86 tree), they look good and obvious. (I added the build fix to 05/40)

I've left 10 to 40 for further review by others too.

Thanks,

	Ingo

