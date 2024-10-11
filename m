Return-Path: <linux-kernel+bounces-361215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E599A520
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE728891F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DA218D7C;
	Fri, 11 Oct 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UVbD2dBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA321859C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653661; cv=none; b=ku5IVmaUfeyhCu8n3w1buOFIVPcN6uI8SJmOwrjvueqcQTE4Sy6pLknh5eSYso8sXxmmc/9HpHfOefg45MwL6tBxhitwvZJvSC7t4V3tkunajnGQvaLNbPn420l1DiBJZz6BbL7QlbVvXOn8qNd79fBodkI10vXC5+oruN9ALW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653661; c=relaxed/simple;
	bh=SxrLesODmkswIjjB/qxYC4oLzkPodTCN2rjjtDDGMJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYPvMe2yBaaalG/UjMGzzjdcmg7h2KPPPhshCWYGiCJbdCi2zzC3oDoIzs8bOqrhDAZLNISNpfhPYu4ufj/Y40kw2OKztg8tcQfYwRHx8hzUjCYqhxmFbvSRaQWxBwX9Y01Rxcmpf48YY9mU+Jzf24aqTRuFMapAg9SPG57l8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UVbD2dBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B9C4CEC3;
	Fri, 11 Oct 2024 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728653661;
	bh=SxrLesODmkswIjjB/qxYC4oLzkPodTCN2rjjtDDGMJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVbD2dBVK7IGtChZ47a802qeo1AdmTsGxu6im0TLzNzB46Q8+UjlTUmRamve4Eh0n
	 qvsOIAb7oFLOyXAvMne3dgYpfH5ziBan6HiHdRwILMgitpF7pn73PwiNM76RL93LB3
	 e1fukpVNHepTTtdZI1LDdsJui2nqgVQuCDtbpN6I=
Date: Fri, 11 Oct 2024 15:34:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-38630: watchdog: cpu5wdt.c: Fix use-after-free bug
 caused by cpu5wdt_trigger
Message-ID: <2024101130-underfoot-hungrily-f432@gregkh>
References: <2024062141-CVE-2024-38630-3640@gregkh>
 <efc8ab85e02b95ab4db09eb9142f62129a51f08c.camel@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efc8ab85e02b95ab4db09eb9142f62129a51f08c.camel@suse.de>

On Fri, Oct 11, 2024 at 12:16:40PM +0200, Jean Delvare wrote:
> Hi all,
> 
> On Fri, 2024-06-21 at 12:19 +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
> > 
> > When the cpu5wdt module is removing, the origin code uses del_timer() to
> > de-activate the timer. If the timer handler is running, del_timer() could
> > not stop it and will return directly. If the port region is released by
> > release_region() and then the timer handler cpu5wdt_trigger() calls outb()
> > to write into the region that is released, the use-after-free bug will
> > happen.
> > 
> > Change del_timer() to timer_shutdown_sync() in order that the timer handler
> > could be finished before the port region is released.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-38630 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> >         Issue introduced in 3.8 with commit e09d9c3e9f85 and fixed in 6.6.33 with commit 9b1c063ffc07
> >         Issue introduced in 3.8 with commit e09d9c3e9f85 and fixed in 6.9.4 with commit f19686d61650
> >         Issue introduced in 3.8 with commit e09d9c3e9f85 and fixed in 6.10-rc1 with commit 573601521277
> 
> For the record, this is incorrect. The Fixes tag is misleading. The
> commit being "fixed" was adding a missing del_timer() call, so the
> situation was even worst before that, as the race window on module
> removal was even larger.
> 
> The bug is present since kernel v2.5.61 when the cpu5wdt driver was
> added to the kernel tree.

So should I change the "vulnerable" commit to be the root of git, commit
1da177e4c3f4 ("Linux-2.6.12-rc2"), instead?

thanks,

greg k-h

