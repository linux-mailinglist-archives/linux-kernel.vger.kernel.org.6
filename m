Return-Path: <linux-kernel+bounces-547621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9276CA50BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AA316B277
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B719225485B;
	Wed,  5 Mar 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQGxk0kl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82828254841
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203614; cv=none; b=HjQqs6DND7kY/L/cwX4ALuTjb9VzrGsYEpYcK62ydvTqYBxtoAwqF42cwNZCrVENleKYHNCtc0lbcLs2O5WkB8g3uprDhzSWA4hbp5I2wupjawq0xwxaIKr/9Lo5Z9ciPWBHE6vZVIE1npCPa17xNjYrjNkTlgNlbcXlMeaieAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203614; c=relaxed/simple;
	bh=K55gsgXXLlIPBE9Ws18BG9TSboZx6nl0CKmoB3Giga8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq/TINvdofaHs+7tWVxwi2ZgAD534BZJMxHt3j9Vf3QcgG6nFR4ncmPqXL8q2M7fZ/fYaDox9Qn61G5HUv2n5l+Mrl/y4f7hv+gWRtc0vWofLDXo5DPywspmSH5pcmRgRKfQTsT7YxYXxRWXQlYRsh72qDi/+cMBFHmtF/ouEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TQGxk0kl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pg7d9ElNjm0fw6qanqXBeOlregC/jYmyaWcL209zJNw=; b=TQGxk0kl+WJze9sn8H0W/qPrK+
	BEobAk1pDE0fSr304RIG/CToZf/wjYzA9vzDrJf6hB9Xn49RSkIJ0JqI9bll9Am9+C1Qa31eXB2hl
	QcXzu4hVqjauq/I+oox1HvfX2XP9NxzzgNBTYKWFhd+d0NK2IyzBMPO8IYxEWFQ/CDRMTl7XmXvG4
	IYVUII+sjoIG+kGkiWQ+wXXNRsWWJk1B93gLKQ2kTcv5rL9vbPtI58GCshMTAjfN4j31jKiwP47N1
	/1igMEGywLGQz5/nib8c7l5C2mIstdVEANtELiEgK8nUrjyy1bjPoMcilIFXR5zgs4pV0lS48e6sz
	YI2x14hg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpub7-00000000j0Y-0L1H;
	Wed, 05 Mar 2025 19:40:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8664E30049D; Wed,  5 Mar 2025 20:40:03 +0100 (CET)
Date: Wed, 5 Mar 2025 20:40:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250305194003.GA35526@noisy.programming.kicks-ass.net>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>

On Wed, Mar 05, 2025 at 07:04:08AM -1000, Linus Torvalds wrote:
> And honestly, none of that makes sense any more. You can't buy a UP
> machine any more, and the only UP case would be some silly minimal
> virtual environment, and if people really care about that minimal
> case, they should just compile the kernel without SMP support.
> Becxause UP has gone from being the default to being irrelevant. At
> least for x86-64.
> 
> So I think we should just get rid of LOCK_PREFIX_HERE and the
> smp_locks section entirely.
> 
> Which would probably obviate the need for your patch, since then the
> compiler wouldn't see it as some big instruction. But your patch isn't
> wrong, so this is absolutely not a NAK, more of a "we should go
> further".
> 
> Hmm?

I'm all for removing that.

On that note, a number of architectures have already made the next step
and that is mandate SMP=y.

The down-side of that it that it would make a definite dent in the
compile coverage for SMP=n code -- but perhaps we have enough robots to
get away with that.

