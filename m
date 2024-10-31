Return-Path: <linux-kernel+bounces-391302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450DF9B84EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E381C2110E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643681CCB4D;
	Thu, 31 Oct 2024 21:07:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF61BBBC1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408842; cv=none; b=p3TLJN427N8fcIu4uA36tg20HlAVjdnhYPJbEdMi0SJn/OV/5dyoS1NDdN51a1+aA88BvzQ8isptATlDzo5HSUtvhpKN/wNN5ij0E9luOQQAa4s5uYIQQm4ZHCUdEwNXkB7ATSYfZKOdMwQerIGNM82Gmxc9ZnjrxJU5bcPfjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408842; c=relaxed/simple;
	bh=ysVUBEhNxkkwofBiqyQdNguVHvWDcdtpLag6qbJrOmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNcai+wT91NARzGZ60QlLIeEShdCpVanSaN9nPYJo5eR5A7tGmQ/hSWM5y8I9gaywOrM61vdm7Ek3TqDClr/I6St9LmIxe0vvD/kPw1sERhYYXDeRZZ180tEbCtESt3LLDYE+5SiWZF1aTd31v0WDtQ5DwvWkFU/1mHGxMefSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3477C4CEC3;
	Thu, 31 Oct 2024 21:07:18 +0000 (UTC)
Date: Thu, 31 Oct 2024 21:07:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <ZyPxhF34JjT3Ky9K@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014105514.3206191-1-ryan.roberts@arm.com>

Hi Ryan,

On Mon, Oct 14, 2024 at 11:55:11AM +0100, Ryan Roberts wrote:
> This RFC series implements support for boot-time page size selection within the
> arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), but to date, page
> size has been selected at compile-time, meaning the size is baked into a given
> kernel image. As use of larger-than-4K page sizes become more prevalent this
> starts to present a problem for distributions. Boot-time page size selection
> enables the creation of a single kernel image, which can be told which page size
> to use on the kernel command line.

That's great work, something I wasn't expecting to even build, let alone
run ;). I only looked briefly through the patches, there's probably room
for optimisation of micro-benchmarks like fork(), maybe using something
like runtime constants. The advantage for deployment and easy testing of
different configurations is pretty clear (distros mainly, not sure how
relevant it is for Android if apps can't move beyond 4K pages).

However, as a maintainer, my main concern is having to chase build
failures in obscure drivers that have not been tested/developed on
arm64. If people primarily test on x86, they wouldn't notice that
PAGE_SIZE/PAGE_SHIFT are no longer constants. Not looking forward to
trying to sort out allmodconfig builds every kernel release, especially
if they turn up in subsystems I have no clue about (like most stuff
outside arch/arm64).

So, first of all, I'd like to understand the overall maintainability
impact better. I assume you tested mostly defconfig. If you run an
allmodconfig build with make -k, how many build failures do you get with
this patchset? Similarly for some distro configs.

Do we have any better way to detect this other than actual compilation
on arm64? Can we hack something around COMPILE_TEST like redefine
PAGE_SIZE (for modules only) to a variable so that we have a better
chance of detecting build failures when modules are only tested on other
architectures?

At the moment, I'm not entirely convinced of the benefits vs. long term
maintainability. Even if we don't end up merging the dynamic PAGE_SIZE
support, parts of this series are needed for supporting 128-bit ptes on
arm64, hopefully dynamically as well.

Thanks.

-- 
Catalin

