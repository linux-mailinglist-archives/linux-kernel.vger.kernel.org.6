Return-Path: <linux-kernel+bounces-270924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F594471D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758761F26D62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B616EB5B;
	Thu,  1 Aug 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N5zaQu2B"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F919157469
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502494; cv=none; b=RwadJ2mAgIlE1D6puMrkyj5hZS36Mb0Kcb1kX8lsAa9dGYy+2GMhtb7Jzyq2XetNNfXlcO6mKo1TCHzZPazcDWMFzVsB4Mz4OWXadZZLEBhW7LzCYqstn9hFQviQcNgdrmgAZdOIZI6kLNn6LdwIhKgMoWjpPtOXC/ntwQqgtts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502494; c=relaxed/simple;
	bh=ELV8yhQ3TxrJXNL7GNabK8kZ9yHlPm2Vud4wYk8Bk2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtPXNrmc7cAbGU4jiSQ2sBCIIO7Cc5+8C2339pI1DUihhQ4xCBlbsUn6MjVrACvQdg+vh2OhT9bObGDYzGDwnAAM13GOrYIj0HZfVPpWjrjTrM8TbLJnnRyrpnW/KZnEN1LjlglE9J27978MjlXtDqg+MM5gMX2Lhi8ExF1ixgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N5zaQu2B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xRMLmj9qlDqy9loOkVGrrbLQIpp1pJzJMWgVhDvT3VA=; b=N5zaQu2BTClhZyvu1Q1xMWnrHU
	W394OdHVO4mens/WLCTFtnYvWKOJFHtPSZXREX5ij1a8w28OgrRH2cok/QDWONE3agmOIUHq73pMb
	LVDmXaggGRDNQeIncVjCH+Iz82Te7qU1Vb+Q04pXZJTN3m0+AhJArlS5ZdD6W3gZ+DFlJjOc3X4YR
	JmzVo1r4c5WVQbExhS+NIZ0G+S93XYUwHYYrv1ae9mpUmK2vkyOdoPHH176Gyu6tRjTvci1EHsQ9l
	W2VXADEj78TbGkGvGi5+n/k1qlgkLVX/eJlLBc+AdKUgmoF0yr8svZfkEvA9ZeHJMVVYtV1wy8FP7
	sKZp3G4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZRaD-00000005Pu9-2mCc;
	Thu, 01 Aug 2024 08:54:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4FA1E30074E; Thu,  1 Aug 2024 10:54:49 +0200 (CEST)
Date: Thu, 1 Aug 2024 10:54:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240801085449.GM33588@noisy.programming.kicks-ass.net>
References: <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
 <20240731165108.GH33588@noisy.programming.kicks-ass.net>
 <87bk2d5v83.ffs@tglx>
 <20240731212007.GW26599@noisy.programming.kicks-ass.net>
 <d01798a0-5817-4645-8c8c-d61dcf668c25@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01798a0-5817-4645-8c8c-d61dcf668c25@roeck-us.net>

On Wed, Jul 31, 2024 at 03:22:53PM -0700, Guenter Roeck wrote:
> On 7/31/24 14:20, Peter Zijlstra wrote:
> > On Wed, Jul 31, 2024 at 07:26:04PM +0200, Thomas Gleixner wrote:
> > > On Wed, Jul 31 2024 at 18:51, Peter Zijlstra wrote:
> > > > On Wed, Jul 31, 2024 at 06:31:05PM +0200, Peter Zijlstra wrote:
> > > > Thomas, this all still relies on the full text section being PMD mapped,
> > > > and since we don't have ALIGN_ENTRY_TEXT_END and _etext has PAGE_SIZE
> > > > alignment, can't have a PAGE mapped tail which then doesn't get cloned?
> > > > 
> > > > Do we want to make pto_clone_entry_text() use PTI_LEVEL_KERNEL_IMAGE
> > > > such that it will clone whatever it has?
> > > 
> > > Yes, I think so.
> > 
> > The alternative is ripping that level thing out entirely, and simply
> > duplicate anything we find in the page-tables.
> > 
> 
> The patch below (on top of the previous one, because otherwise it doesn't
> apply) causes qemu to bail out hard, with
> 
> ...
> [    3.658327] sr 2:0:0:0: Attached scsi generic sg0 type 5
> [    3.858040] sched_clock: Marking stable (3834034034, 23728553)->(3865222956, -7460369)
> [    3.861469] registered taskstats version 1
> [    3.861584] Loading compiled-in X.509 certificates
> [    4.082031] Btrfs loaded, zoned=no, fsverity=no
> [    4.096034] cryptomgr_test (69) used greatest stack depth: 6136 bytes left
> 
> No backtrace or other message, it just exits immediately.

Ha, I hadn't even compiled the thing :-) I was just wondering alound and
in patch form if the whole level thing was worth having in the first
place.

If it lives, I'll make sure to test it.

Thanks!

