Return-Path: <linux-kernel+bounces-547774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CEAA50D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30482188FA43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F401FF617;
	Wed,  5 Mar 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdgTM/dv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6451FE469
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210008; cv=none; b=hjd+Ook2paKCMmxwekECAb4UQJy+2j8k/nuxLUyq8hqzueATrTCAoHwtwxodHZkeatpRxQ7+c1RLL0G0lFLRxiz3sdsInFP/J481C6phUui6X0BrcDB+ZSWxc4rgUoxjpvGNdJeLb0W0w7/682lZZMc/n54/3XDKwfwSIx9FGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210008; c=relaxed/simple;
	bh=UZNhOMP5jyU6Kz3RFHovwlVT9Qfj8M+BG1quj7BWcIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWN17l/0C6jHKQJMTMHHuO16wYHdeKyMn4PpeZ1GqCe2tmp4GPRU+i/5OCX5QQdRq7AVC3V3BV8220KHypA8B6qQKeUjXP1kXc9OY3AwFiOcMTGApKpYI539sR7fY5ScZwjE4sOSUGERInigOzHsMoOnfR/2yfmFXqQqb/I0eeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qdgTM/dv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SfzLK33+jv5P5a/bs1K/rCWW2t4jXUCVOjx4e9QI4FA=; b=qdgTM/dveovvHQLjQRBPb+JM/k
	YwUZIcy2xJmV7clJ+nkuKtqTODagkS3iojwDPfi6m6KUqztkLvO+1EvPueHQyYll4xTYYj0xJ4hwE
	2ngwB+OWNmX5sVhzFf9/esZ7kCEv/BhyyJyiKaskQHc1j4lrd7xKirhQ/i3+w0SSry88MGdfqikRB
	YjBJjeItWjDBTINfs9qtPZBahV0GBeDm8gtQtR6meSloxy4EP3s6ivUKfKF5RBXOkqzeEQsYFoU7y
	KOy5gltrpKmlpSPq3evTUCfuOmTJcQ1AOkfKal3kD4Zcg5immGVi76hwFW75RX+Ht3uGiETrir+UL
	+PDZArBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpwGE-00000006E1V-47NU;
	Wed, 05 Mar 2025 21:26:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4038E30049D; Wed,  5 Mar 2025 22:26:38 +0100 (CET)
Date: Wed, 5 Mar 2025 22:26:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250305212638.GC35526@noisy.programming.kicks-ass.net>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <20250305203633.GNZ8i10cVCCnhhULis@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305203633.GNZ8i10cVCCnhhULis@fat_crate.local>

On Wed, Mar 05, 2025 at 09:36:33PM +0100, Borislav Petkov wrote:
> On Wed, Mar 05, 2025 at 09:54:11AM +0100, Uros Bizjak wrote:
> > The -Os argument was to show the effect of the patch when the compiler
> > is instructed to take care of the overall size. Giving the compiler
> > -O2 and then looking at the overall size of the produced binary is
> > just wrong.
> 
> No one cares about -Os AFAICT. It might as well be non-existent. So the effect
> doesn't matter.

Well, more people would care if it didn't stand for -Ostupid I suppose.
That is, traditionally GCC made some very questionable choices with -Os,
quite horrendous code-gen.

