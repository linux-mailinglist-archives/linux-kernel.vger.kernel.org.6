Return-Path: <linux-kernel+bounces-269877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546F99437F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8671C1C23CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61116D4E5;
	Wed, 31 Jul 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="enzRL0mX"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A816D4C0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461189; cv=none; b=UOwnVVrGU++vxbYKyOC2xw6ByoLyTe1LESlVNXzzwIHnvclM376tRg6l1lSoPRsHOheMqd/GB537xr2fWJgeX0o5xzp7EshwELgyjmrpR8lzAH7lQja1H27Jc1c27FpJ4HMzAuFmZxvGmlvhVx88u756rGhvC/KTW0Wz2JcAvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461189; c=relaxed/simple;
	bh=jssOBMtwefVTqQ5mDVZIxmCimLUmPAjHIr4iA1/JjvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvUHEmHsTjxga9PxbVyPA8ux0pkxP49WWvsBBXwidXO+QD3N6YJVMVhELMcVhFVYHmum1wKZ5YC73sxPOrx2wTZ2gosrRHlh1jLpy5UTP3NkL/HFRuftaV3PMe314D+AGVpKAD7mYHSs01wT6COVw+isFyC9p7o/JF9ODxw4pQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=enzRL0mX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7UantihI0biLHmzOvhvLs1/a48/spgItsd+twM2z2/0=; b=enzRL0mXkgpNjUgKm7+SDC5/21
	GWSPepLIkSm3kBuTH7M3LPA9T6ggrQrxYc5xDlYwFP5U4QuPX0Q8iodARXZThQ6TK23CCKA/IVW1T
	bBOxdMdDnVgI0VpGy28kVxWgjU6p00637GXIuUkV8bf+ZnHOeX/285W47STmomb3m6mDauTZstrpy
	AWe/MNx27kiWdpyoM8WkgCvvDbuo0t8+QnJMnUd93iGRMvlMJQXbj0/UJJrBY1rfZFP0qFO1qVGzS
	4oFIKXDKqpY/yfuAjK8kK1WOGvo0P8FItJRiP4K8wNHrmC7f/0xK8FAo75UWrNyxDPyzr4bpO3ct4
	AJ/v41WQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZGq0-00000005IQ2-2K6m;
	Wed, 31 Jul 2024 21:26:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 311C1300820; Wed, 31 Jul 2024 23:26:24 +0200 (CEST)
Date: Wed, 31 Jul 2024 23:26:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731212624.GZ40213@noisy.programming.kicks-ass.net>
References: <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
 <20240731165108.GH33588@noisy.programming.kicks-ass.net>
 <87bk2d5v83.ffs@tglx>
 <20240731212007.GW26599@noisy.programming.kicks-ass.net>
 <CAHk-=wjSs62k3p7sS3uR7TSTsZg1q8-=Vm0douhodk2R0FqP=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSs62k3p7sS3uR7TSTsZg1q8-=Vm0douhodk2R0FqP=Q@mail.gmail.com>

On Wed, Jul 31, 2024 at 02:23:02PM -0700, Linus Torvalds wrote:
> On Wed, 31 Jul 2024 at 14:20, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > The alternative is ripping that level thing out entirely, and simply
> > duplicate anything we find in the page-tables.
> 
> That looks clean to me, and don't we want to clone the minimal range
> anyway - even on x86-64?

x86_64 has everything PMD aligned. It *should* never encounter a PTE.

Also, this thing blindly clones the format the kernel page-tables have,
it will not split a PMD into multiple PTE entries just to clone a
smaller range. It is super simple.


