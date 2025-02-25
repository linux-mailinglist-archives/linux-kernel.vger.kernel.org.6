Return-Path: <linux-kernel+bounces-532187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EA3A449D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2807A915A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805219D071;
	Tue, 25 Feb 2025 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX0gXOLu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2984186E2F;
	Tue, 25 Feb 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507213; cv=none; b=gsjefDKM/i9Z2ZVW3jDfGZcqBhj7TlQ8PXH4jfTPwl4voAeiDX1Gzf/lHOpFL5ZYNZiUysLPcvCYdsEELr0twKfeddWGcRw0xhkKqto2Th+qeWgt2rcJcXa8c3CL4XiNtOCJyGNkjzo6RyYcXX+Z9QJ2QLHyenUoZB86KHDcaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507213; c=relaxed/simple;
	bh=ZzFdYCh6xQa9i+CIHhfThsw+bZbyS1sHK2XFoBGleJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1i78su5b9zhZNiQPrN6R2JfFCcz5EZ2NGeIv/nPqVyj/C1kFHK5mgQ73iuaqomB0r881EznavidkUoTlw+VKM7cF856FuNtB2KzzkRof8/zn2HFy3+lmpCgwsl4x0HZsssbBHavxJtMIHTPU4EeEARFJcM5UiI0X0uwHyy+RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX0gXOLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8443C4CEDD;
	Tue, 25 Feb 2025 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740507213;
	bh=ZzFdYCh6xQa9i+CIHhfThsw+bZbyS1sHK2XFoBGleJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX0gXOLu16KMgEi+jJS/ZVk5T0TCTc6Rug7i7SXZVL9p8e+RKbd7io01p3UTanoup
	 6gTMvwfuX9icu/76GogUCV7BOm0Cad6toxuwKbXKKJyEyf7bgaatYBaSNrkzi699lA
	 BIibaMDx6gu5dDqvJw108cajGjlnetzHcjZoPXm+fhMW9xTk+dlk4raOIFUAn31NWf
	 DrP5BBBXe3EZmV6s9qrup391M4BkXwAoaagKgI1QSqbfubmwI1xs68wQnpb95+cXdB
	 zGoWCCifjG3VSw6O6rfQV/6lFv9z4nsdEV5TvGWESj/v4rTyujw1sY6X9zH0dGdpNS
	 e91IDQMjN/vhg==
Date: Tue, 25 Feb 2025 10:13:31 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Weinan Liu <wnliu@google.com>
Cc: indu.bhagat@oracle.com, irogers@google.com, joe.lawrence@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-toolchains@vger.kernel.org, live-patching@vger.kernel.org,
	mark.rutland@arm.com, peterz@infradead.org, puranjay@kernel.org,
	roman.gushchin@linux.dev, rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH 0/8] unwind, arm64: add sframe unwinder for kernel
Message-ID: <20250225181331.frmfumf4b5ctfbsm@jpoimboe>
References: <20250210083017.280937-1-wnliu@google.com>
 <20250225010228.223482-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225010228.223482-1-wnliu@google.com>

On Tue, Feb 25, 2025 at 01:02:24AM +0000, Weinan Liu wrote:
> On Mon, Feb 10, 2025 at 12:30 AM Weinan Liu <wnliu@google.com> wrote:
> > I already have a WIP patch to add sframe support to the kernel module.
> > However, it is not yet working. I had trouble unwinding frames for the
> > kernel module using the current algorithm.
> >
> > Indu has likely identified the issue and will be addressing it from the
> > toolchain side.
> >
> > https://sourceware.org/bugzilla/show_bug.cgi?id=32666
> 
> 
> I have a working in progress patch that adds sframe support for kernel
> module.
> https://github.com/heuza/linux/tree/sframe_unwinder.rfc
> 
> According to the sframe table values I got during runtime testing, looks
> like the offsets are not correct .
> 
> When unwind symbols init_module(0xffff80007b155048) from the kernel 
> module(livepatch-sample.ko), the start_address of the FDE entries in the
> sframe table of the kernel modules appear incorrect.
> For instance, the first FDE's start_addr is reported as -20564. Adding
> this offset to the module's sframe section address (0xffff80007b15a040)
> yields 0xffff80007b154fec, which is not within the livepatch-sample.ko
> memory region(It should be larger than 0xffff80007b155000).

I assume kpatch create-diff-object needs to copy over a subset of the
.sframe section.  Similar to what kpatch_regenerate_orc_sections() does.

-- 
Josh

