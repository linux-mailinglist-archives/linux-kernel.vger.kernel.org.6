Return-Path: <linux-kernel+bounces-253838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2229327B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819B51F23A00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27EB19ADBE;
	Tue, 16 Jul 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9G0QIny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE09197A72;
	Tue, 16 Jul 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137308; cv=none; b=a2GHmYP5ryhmdETEyAOPqKXbgnPe9BUtxYpdkZwPg9s3UmYAQWjOKcCf3xDMBoDraGGvbSJQ/APUF7EEezXgDgYkBUysjohLCIaGOoEzFtoLlMpeg5TkRefDFYvYthsw+12wcnih2u0s3lfXmjFpOSyQ9QeqAZgjweacA5nudbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137308; c=relaxed/simple;
	bh=IWkCAz89d6Km4WiT5t373st9cdv3rsIIWAfS6Bz9G1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss7coxYvY3ydVMwWFvrafB1lrg9BO2WiR+jBpAkx4J53OcSOoSdM0QxlLoOSYOBqsAL7Dpi2j55/iPxHLuMKc/sqS4isgkKgYHEqcR9GkqTRaCn8VainO+vCFQifEF2wRuvdgnFv685PjKYvjx96xdXxFJOIG2opLHDulQwRyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9G0QIny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FE4C116B1;
	Tue, 16 Jul 2024 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721137307;
	bh=IWkCAz89d6Km4WiT5t373st9cdv3rsIIWAfS6Bz9G1c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=h9G0QInyiSRxryWTKGC+6E5jn9W/3fT2NydlGJ/i4rBX/rhqR2q/GxMqss9YUwFyh
	 w8kN9Cun2oZz0MYcaToDw50KvgCEKlp5j7gCkZO/uM3nz39MSGk3JqXyFEOCeJM4YC
	 igqCkhH/E+F6urAPDhmqnIS+d7KtvFWJjT2nx5eNvh3wVj5ueglVNqmaMzC4O7BOEo
	 xqAvU3HZG7CigS6aQAYBXBvjX/tT40Sb9CxZLqn1EgkbzXmUklNUqrBZZpGrVMnIQ8
	 Ysh739R5KWrF8vELIA4kNppRruTU7fwms10C44eVHbBdoJEk5QnY3C980357LpM2C0
	 W6wlqS921cdZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B75BCE0A70; Tue, 16 Jul 2024 06:41:47 -0700 (PDT)
Date: Tue, 16 Jul 2024 06:41:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [tip:timers/urgent] [timers/migration]  8cdb61838e:
 WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent
Message-ID: <75673424-69b3-4774-a647-d41a259f9a55@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202407101636.d9d4e8be-oliver.sang@intel.com>
 <68204aba-dc0a-47dc-902b-76d6553e17de@paulmck-laptop>
 <87ikx53i0g.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikx53i0g.fsf@somnus>

On Tue, Jul 16, 2024 at 09:36:47AM +0200, Anna-Maria Behnsen wrote:
> Hi Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Wed, Jul 10, 2024 at 04:37:00PM +0800, kernel test robot wrote:
> >> 
> >> 
> >> Hello,
> >> 
> >> kernel test robot noticed "WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent" on:
> >> 
> >> commit: 8cdb61838ee5c63556773ea2eed24deab6b15257 ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
> >> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/urgent
> >
> > For whatever it is worth, I am also seeing this on refscale runs on
> > recent -next.
> >
> > The reproducer is to clone perfbook [1] in your ~/git directory
> > (as in ~/git/perfboot), then run this from your Linux source tree,
> > preferably on a system with few CPUs:
> >
> > bash ~/git/perfbook/CodeSamples/defer/rcuscale.sh
> >
> > The output will have "FAIL" in it, which indicates that the corresponding
> > guest OS splatted.  If it would be useful, I would be happy to produce
> > a one-liner that runs the guest OS only once and leaves the console
> > output around.  Otherwise, I will continue being lazy.  ;-)
> 
> Thanks for the report. I found the root cause for it and I am working on
> a fix as the commit which triggers the warning also has another
> problem... And I already requested to drop the tip timers/urgent patches
> (at least my patches).
> 
> So, enjoy being lazy!

Glad that you are on it, thank you!

And yes, the option of being lazy seems to be increasingly attractive
as the years rush by...  ;-)

							Thanx, Paul

