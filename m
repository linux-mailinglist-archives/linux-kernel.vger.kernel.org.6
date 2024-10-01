Return-Path: <linux-kernel+bounces-346040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673998BEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F341F22483
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29E1C6F78;
	Tue,  1 Oct 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfh6PPOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA091C6F51;
	Tue,  1 Oct 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790842; cv=none; b=jN6XLOcMvBlUzSq4DPepM2h3LghDbiMZPnDecIBsKcVF87LhGYbMZzZPkmy25HOtOt58eJQwi2i3MOQkuSaulYGkV4r1l46tIjE8JH1BuQAd5Vl89ui0bd/UrKRY6pSR8bSrShjZGYHmV2Fb4VK9w6YY/7jWgEcqJIJRNPoz/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790842; c=relaxed/simple;
	bh=Ddiob5FTPQntSc9SG9DZFMRNCSLVz4cA7oPQ6B0QZ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQRQUltLgZCz1E7j0hCltPbJmJqBnDxmeYy0jf+Q2fvXFrdQYCEeXfMx2soRSx5tj0D487PM07csy7CCK6trTzyuo1rBW4cBiAkL0SpGcrSXo2Km2VdJ0iuVarH97q9P9ZkZ9o1saT7LziVdPYzS54FkserlNZT1xxHHrfNs1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfh6PPOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76208C4CEC6;
	Tue,  1 Oct 2024 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727790841;
	bh=Ddiob5FTPQntSc9SG9DZFMRNCSLVz4cA7oPQ6B0QZ+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfh6PPOhhnkXkw3pyvUxV33q7MxtUH4lCkuEADPOuKyLomdcl2YfPoNiEuc/HqYBE
	 4Q/kfkswvzPuGZEY1oFPhOxWno1XUP65lEz/ui6Unzcc0zSpiJEULMbmcM5BK/JA+W
	 NHvqnSJ5KrHMPGBvA9Yh3qiizTUDYYwT8qoinzfU=
Date: Tue, 1 Oct 2024 15:53:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: CVE-2024-46839: workqueue: Improve scalability of workqueue
 watchdog touch
Message-ID: <2024100142-trespass-likewise-015a@gregkh>
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

Ok, now rejected, thanks.

greg k-h

