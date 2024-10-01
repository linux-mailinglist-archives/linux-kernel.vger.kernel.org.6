Return-Path: <linux-kernel+bounces-345803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9398BB56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3527AB20E62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566611BFE10;
	Tue,  1 Oct 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsNVU3vX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B741BF804;
	Tue,  1 Oct 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782649; cv=none; b=N8D2XxVily/Uskb0vb5HkuQw3w6M3Hk98bkI3xCUZxD//SBdg2redqP26bBIH1AzEUC0vs5yeL9MG6KGu6uIqL6YYumeqYgbMBH+FJNC3wQsmwXpjUSptjVYWxvuZoSlgepP+ZkNIXBXK3EvfQ3IE9QEb8a0Jy/Bx9monpcXwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782649; c=relaxed/simple;
	bh=NmCsZSQdycc9Hjn7urA/BWrFvoQux13io2xxJuanCFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF2mCtfq+G4Aarogfdl4TZ9FDquZ0vc2kz+buADIfyr2uzqbsMmz9XDzmgP4a87hOJi9KUb9prlIzoRkg/Jk0zykIBG0COTa2PZBwXKic7n1iUWfFCzbRgGWRDctme1iBlEkNEre0wQ0O/leUAjaxeixLLmHNg6MgrnhppBJU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsNVU3vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ABDC4CEC6;
	Tue,  1 Oct 2024 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782649;
	bh=NmCsZSQdycc9Hjn7urA/BWrFvoQux13io2xxJuanCFQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NsNVU3vXd9qfpFtKP4E71wyoBhWpqo5wl4ie2uD7FSaKJwyLsuY/LH28AsAso5XfK
	 JSrtsBAXY5zSxZ2moG1+oIMPpGZ8Eyp66lltQfe3z2baw1gdAqkJ1ViW2FMj0ELoPV
	 psY8oCAt2ZCtsPhDfTgySP2dQmrknv0BLzGYa5DpK6zA9dfp1Ea9W3dVhN0hBWiI5s
	 TqepTLDRkE/9rNKU94sARMIO+cXL41JKVsaFr/N2otmqZCnKIKI2EZ9FIBux7oFc76
	 HZ4iYBEebb/cdbH3du7325F84hSxTFK9rqrKpgNtgQnNcPJoRxJm8AFwIbwUjW7+0A
	 uqhP0Gx1Fj0Ug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E78C2CE0F7B; Tue,  1 Oct 2024 04:37:28 -0700 (PDT)
Date: Tue, 1 Oct 2024 04:37:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>, Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: CVE-2024-46839: workqueue: Improve scalability of workqueue
 watchdog touch
Message-ID: <04899afa-8b72-4278-bc92-e5d6e48d8acb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2024092754-CVE-2024-46839-cfab@gregkh>
 <ZvusWymx4rGO55NG@pathway.suse.cz>
 <2024100116-shaky-iguana-7f54@gregkh>
 <Zvu75UxnAl-Ysvd9@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvu75UxnAl-Ysvd9@tiehlicka>

On Tue, Oct 01, 2024 at 11:07:49AM +0200, Michal Hocko wrote:
> On Tue 01-10-24 10:22:51, Greg KH wrote:
> > On Tue, Oct 01, 2024 at 10:02:02AM +0200, Petr Mladek wrote:
> > > On Fri 2024-09-27 14:40:07, Greg Kroah-Hartman wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > workqueue: Improve scalability of workqueue watchdog touch
> > > > 
> > > > On a ~2000 CPU powerpc system, hard lockups have been observed in the
> > > > workqueue code when stop_machine runs (in this case due to CPU hotplug).
> > > 
> > > I believe that this does not qualify as a security vulnerability.
> > > Any hotplug is a privileged operation.
> > 
> > Really?  I see that happen on many embedded systems all the time, they
> > add/remove CPUs while the device runs/sleeps constantly.
> 
> This is a powerpc specific fix. Other architectures are not affected.
>  
> > Now to be fair, right now an "embedded system" usually doesn't have 2000
> > cpus, but what's wrong with marking this real bugfix as a vulnerability
> > resolution?
> 
> Yes, this is indeed a scalability fix for huge systems with a lot of
> CPUs anybody owning those systems was simply not able to use memory
> hotplug without seeing those hard lockup messages. The system is not
> really locked up. The progress of the hotplug operation is just utterly
> slow. Calling this a vulnerability is a stretch IMHO. 
> 
> The only potential attack vector is to have machine configured to panic
> on hard lockups on those huge ppc systems and allow cpu hotremove to an
> adversary which in itsels seems like a very bad idea anyway because
> availability of such a system is then effectively compromised.

If the attacker can do CPU hotplug, then an effective (though admittedly
non-CVE) attack is to simply offline all but one of the CPUs.  Whatever
that system was doing with its 2,000 CPUs, it is unlikely to be doing
with only one of them.

And taking Michal's point further, if the load rises high enough, you
might get various types of lockups, and the system might be configured
to panic.  For example, the load resulting from dumping 2000 CPUs worth of
workload onto a single CPU could easily starve RCU's grace-period kthread
for the 21 seconds required to result in an RCU CPU stall warning.  And if
the system has sysctl_panic_on_rcu_stall set, then the system will panic.

But this really should be considered to be expected behavior given
privileged abuse rather than a vulnerability, correct?

							Thanx, Paul

