Return-Path: <linux-kernel+bounces-343524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8565989C04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C14281844
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3EC16EC1B;
	Mon, 30 Sep 2024 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BX8zSG5D"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304E15C15E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682969; cv=none; b=A/wvlbnu35PG2XyXwuB749ZdrovIMu2O19nvjoEU+cyvgBr0XroEorreiwLTkhtk3nmaXYUpZvpXBfyXcZHBLyrtFBlpKEhG5eNJpZu/ihXY4pRBJ1y9V9MrNcFUqcrrBef8cXiBOt6V3csEWNVUXw2Pt/qK1f8+r98+qqGFTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682969; c=relaxed/simple;
	bh=4d3Nrn7kHnwAuohhWQbfqcBFUdTsxwQdsnUZb3HL1Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDhhMfxF9q7pUYHg+DlQamd/O0HopgCw8869O9DuZyTdPiIrntK7Af3yJX8aYmhwVWuqVmqu1iy7xXM5bYxg6yX4hvagmMDWe+tHQkiaQYJREzSSTjdHNiWWv7rDZ1+LwOtvw4XQt/SGBkj20AdCVO8YN7WchlKF8IMPAxmzbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BX8zSG5D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3QpbLeFDR73JBt/QbGjJCGion5xSl4JCYvl/xSSks2w=; b=BX8zSG5DG+9ImPjBOG1e6A7c3Z
	hd6C36l9/U7lWWpzWUBk+EHtC5BpRieYbTZvWiUR94Y4klua1+XKTMRbeiyOGQvWjg+ynimvJ+tSC
	/eKkWL3Ci/P44G2OI+DbV/buvxBLwIrF0rWJaL3eK5HxmcYXM9S4pIC6+3zWwxWMPm/GOfA5e0rNz
	lndSqxFkIUvfF286QAQGMCu1ynFyf7cQE506N5oYN7sRAu0l7DtqKcdOGFMxxcA868ar91NI6LPgh
	icKmdaxc0tk/dm8GwU0isgYci9uXHkWu5q7kbiLNcYFVjNUTgnme0h+XFyWHXdV4+ALpGM7NomxKm
	HzxhqPog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svBGD-0000000GiZC-0zTZ;
	Mon, 30 Sep 2024 07:56:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D052300754; Mon, 30 Sep 2024 09:56:00 +0200 (CEST)
Date: Mon, 30 Sep 2024 09:56:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Yury Norov <yury.norov@gmail.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about num_possible_cpus() and cpu_possible_mask
Message-ID: <20240930075600.GC5594@noisy.programming.kicks-ass.net>
References: <SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Sep 25, 2024 at 04:04:33AM +0000, Michael Kelley wrote:
> Question:  Is there any intention to guarantee that the cpu_possible_mask is
> "dense", in that all bit positions 0 thru (nr_cpu_ids - 1) are set, with no
> "holes"? If that were true, then num_possible_cpus() would be equal to
> nr_cpu_ids.

I think we've historically had machines where there were holes in. And I
think we're wanting to have holes in for modern hybrid x86 that have HT,
although I'm not entirely sure where those patches are atm.

Thomas, didn't we have a patch that renumbers CPUs for hybrid crud sich
that HT is always the low bit and we end up with holes because the atoms
don't have HT on?

Or was that on my plate and it got lost in the giant todo pile?

> x86 always sets up cpu_possible_mask as dense, as does ARM64 with ACPI.
> But it appears there are errors cases on ARM64 with DeviceTree where this
> is not the case. I haven't looked at other architectures.
> 
> There's evidence both ways:
> 1) A somewhat recent report[1] on SPARC where cpu_possible_mask
>    isn't dense, and there's code assuming that it is dense. This report
>    got me thinking about the question.
>   
> 2) setup_nr_cpu_ids() in kernel/smp.c is coded to *not* assume it is dense
> 
> 3) But there are several places throughout the kernel that do something like
>    the following, which assumes they are dense:
> 
> 	array = kcalloc(num_possible_cpus(), sizeof(<some struct>), GFP_KERNEL);
> 	....
> 	index into "array" with smp_processor_id()

I would consider this pattern broken.

> On balance, I'm assuming that there's no requirement for cpu_possible_mask
> to be dense, and code like #3 above is technically wrong. It should be
> using nr_cpu_ids instead of num_possible_cpus(), which is also faster.
> We get away with it 99.99% of the time because all (or almost all?)
> architectures populate cpu_possible_mask as dense.
> 
> There are 6 places in Hyper-V specific code that do #3. And it works because
> Hyper-V code only runs on x86 and ARM64 where cpu_possible_mask is
> always dense. But in the interest of correctness and robustness against
> future changes, I'm planning to fix the Hyper-V code.
> 
> There are also a few other places throughout the kernel with the same
> problem, and I may look at fixing those as well.
> 
> Or maybe my assumptions are off-base. Any thoughts or guidance before
> I start submitting patches?

You're on the right track, should not assume the mask is dense.

