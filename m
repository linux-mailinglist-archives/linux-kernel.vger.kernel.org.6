Return-Path: <linux-kernel+bounces-321198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3C9715BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BAE28297B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD61B4C4D;
	Mon,  9 Sep 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCbD5EXW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DB13D53E;
	Mon,  9 Sep 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879388; cv=none; b=JnrDoF0I6+arugR5eSvnzqrXfbaBt+I+dcvemNa9N/3tY7VwwPwSgp0ka+PSTZUSni0wY7aOl6W5g8Fgx29zhhpBqxYCsCO3wT6Mzc/vMN9+091Fvu3TraUervi2/QdcBwGfXqNCuHQ5A59P8jm/akhIr9qQZaRK6fLRt6sEHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879388; c=relaxed/simple;
	bh=c/bDx71bLVyRfv5navU3Ek/BOIYCeWQ8co8Smtaway8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB/2htT4ktMQ08XSAGhTV3p377F1SY5T4UWrkmelo3s++fxYpu3QEq8OLxyo4DpgNZi7/ssxqjrYy20BMYGZ9DTYIMMCVd3hJ/gUeOGhVQSs+5acOyayfl0awu6vh6tnAjtfj7hOHaM/B9gRHQXyV3019dbxrhdVff87y1YIVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CCbD5EXW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ewHE0AbY/FuLNz/wbi0i4ea1GwIaCq/CzYyaTShAYBU=; b=CCbD5EXWpbBEILG8ywBisRYXP9
	GWmJqxJlLfM6SJ5keww7rA0hqya64aDeusIg2FCj+DSlewtW9WRt9xi8ihH0dGG1pUW1hXFzipXoi
	6yQ4qj2fOf5soUhtiGHRcSpm9t/X11u0yT/m+hORTO57/izeP5Dk5aw7tKmA95azqHSaeXpOKKcCC
	FMbY7UAS9RFNBxjA8Nx83tt8BWNPMSecVibAr3ZZGVQl6npCvbZ8JxRJz/O8hRcTgVxEsa4Qv+jAk
	YWLsKjIVCB8/yGxIsvWJN5Lhw+2SUixNG/hzd4mOXOKsceMaDbzMZ6v+s/n/9YsTlLidba98jZaK5
	dZWRFIKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snc4E-0000000Boy0-2ydr;
	Mon, 09 Sep 2024 10:56:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A4BA30047C; Mon,  9 Sep 2024 12:56:23 +0200 (CEST)
Date: Mon, 9 Sep 2024 12:56:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:locking/urgent] [jump_label]  de752774f3:
 kernel_BUG_at_arch/x86/kernel/jump_label.c
Message-ID: <20240909105623.GH4928@noisy.programming.kicks-ass.net>
References: <202409082005.393050e2-oliver.sang@intel.com>
 <20240909091531.GA4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909091531.GA4723@noisy.programming.kicks-ass.net>

On Mon, Sep 09, 2024 at 11:15:31AM +0200, Peter Zijlstra wrote:
> On Sun, Sep 08, 2024 at 09:06:55PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/jump_label.c" on:
> > 
> > commit: de752774f38bb766941ed1bf910ba5a9f6cc6bf7 ("jump_label: Fix static_key_slow_dec() yet again")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent
> > 
> > in testcase: boot
> > 
> > compiler: clang-18
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240908/202409082005.393050e2-oliver.sang@intel.com
> 
> So the whole thing actually boots and works on my real machine, so I had
> to resort to using this qemu nonsense, as such I did as instructed in
> the reproduce file.
> 
> I build the thing using clang-17 (for some reason debian is shitting
> itself trying to install clang-18 on this machine and I don't want to
> spend the day fighting that).
> 
> Except, once I do:
> 
>   bin/lkp qemu -k /usr/src/linux-2.6/tmp-build/arch/x86/boot/bzImage -m /usr/src/linux-2.6/tmp-build/mod/modules.cgz job-script
> 
> The whole thing grinds to a halt like so:

Since I'm not able to reproduce, could you please run the thing against:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent

and see what that does?

