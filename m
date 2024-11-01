Return-Path: <linux-kernel+bounces-392970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DF9B9A43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1071F232F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325511E22F7;
	Fri,  1 Nov 2024 21:33:41 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1858487BE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496820; cv=none; b=L//HBD7RaobBEzqOXB8J5xdTjUyIOHltJ4hHv0AtMjVaT1FmrwgrEsJ+fXeBbvEZW+oE7Kuop930rEwH3AnQRsNkPTiwmJbEkxY/ohpd101jfAeImzy+QEG0LytC1p0a9oQ93pkba14QtILN1iQyHfhAc0XZzl56jUCPpdNe6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496820; c=relaxed/simple;
	bh=ahh1QkzmajI7TV43rlC7Ds/3TLnQqST0EKbsrUaIwdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvM5WMZSLzkQWQ2YgPkRIMi6KfUMchAaeFOk5tNW6wbrulwKZ8GWv8ip+KTf7du25iMmClCkZZAL3JK7X6rxJH4/9VqhBfJKzlDYbfxMeX19YUeJYK1JBcRHb2cXpmmV+Skid61zxG8dUaEeH17DbKrw1DUYRz1eFRPTuCxrBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4A1LXEDf015158;
	Fri, 1 Nov 2024 22:33:14 +0100
Date: Fri, 1 Nov 2024 22:33:14 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.13
Message-ID: <20241101213314.GC15112@1wt.eu>
References: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>
 <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>
 <f9d51d6b-f38e-48bb-be5a-97217fb503c1@paulmck-laptop>
 <ce65b110-259a-4edf-a84b-4015c6160f52@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce65b110-259a-4edf-a84b-4015c6160f52@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas, hi Paul,

On Fri, Nov 01, 2024 at 09:23:48PM +0000, Thomas Weißschuh wrote:
> Hi Paul,
> 
> On 2024-11-01 13:22:17-0700, Paul E. McKenney wrote:
> > On Fri, Nov 01, 2024 at 02:22:13PM +0000, Thomas Weißschuh wrote:
> > > (resend to add missing Cc: LKML)
> > > 
> > > 
> > > Hi Paul,
> > > 
> > > The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> > > 
> > >   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20241101-for-6.13-1
> > > 
> > > for you to fetch changes up to ad0558f3883130954ca724697f2d19aef93967b3:
> > > 
> > >   selftests/nolibc: start qemu with 1 GiB of memory (2024-10-07 21:57:45 +0200)
> > 
> > Thank you!  I have pulled this into -rcu at signed tag nolibc.2024.11.01a,
> > which copies from your signed tag.
> 
> Thanks!
> 
> > The usual "make run" and "make user" worked fine, but "make libc-test"
> > gave me the build errors shown below.  Is there some setup step that
> > I omitted?  Or is this not really a necessary test?
> 
> That test does not actually test nolibc but the nolibc test suite.
> It uses your system libc and makes sure that the nolibc test
> expectations match the behaviour of a "real" libc.
> The missing strlcat() function was added to glibc only in 2.38, so I
> guess you have an older version.
> On my glibc 2.40 "make libc-test" works and the test itself succeeds.
> 
> I'll see if there is a reasonable to make libc-test work on older glibc.
> But it shouldn't impact this cycle.

Maybe we could just enclose the test with:

#if !defined(__GLIBC__) || __GLIBC__ > 2 || __GLIBC_MINOR__ >= 40
 ...
#endif

The real libc test is indeed not critical but it's important that we try
to keep it working reasonably well over the long term as it reminds us
not to diverge too much.

> For better architecture coverage I would recommend ./run-tests.sh over
> "make run/user". Speaking about this I remember the discussion from the
> 6.12 PR where Willy proposed an improved run-tests.sh error message.
> It seems he didn't push it as a commit, so let's add keep it in mind for
> next cycle.

Oups, I vaguely remember proposing a trivial patch in an e-mail a while
ago but I don't even remember what it was about. My mind is totally taken
by the upcoming haproxy release these days :-/

Cheers,
Willy

