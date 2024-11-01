Return-Path: <linux-kernel+bounces-392994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2929B9A88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893C51C2155B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8881E32BD;
	Fri,  1 Nov 2024 22:01:36 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3DC19B3E3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498496; cv=none; b=Fv2qv4JIhOTG2cjgVQi4Z4HTfgKXZK4Up1C4W5SCyFLZIrOAyqRvv45ociT+tvTLQo/KZCqnJ/quwcvTrZ1owODhgftnSUKsS6i+tlf9a/OS6Wl8sFZ3Uw1+upZgvn+iTcUNnDb5Zl7L93ykBaQ5gE860bEn3F+OQMVsD8v+BxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498496; c=relaxed/simple;
	bh=cqRBkSL3AVZTnppxdG/2m1GSpxOwnBGrbyNue0klnuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM1bA3MKYvf8x1N4sQvZj0WvKFd3NQVReSMA/EJNGV29/S5o0gSQIz4cnYDr68R2OVqHnf8MlrOddr4HX4VU4TohSz/cAtD4SHhCm2nqDBN1SwboP/q3DbdPONcBug/aSV771emRLRjMge3uCJFHKQzPXcM/QVsojSYZJpteNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4A1M1S3P015470;
	Fri, 1 Nov 2024 23:01:28 +0100
Date: Fri, 1 Nov 2024 23:01:28 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.13
Message-ID: <20241101220128.GA15188@1wt.eu>
References: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>
 <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>
 <f9d51d6b-f38e-48bb-be5a-97217fb503c1@paulmck-laptop>
 <ce65b110-259a-4edf-a84b-4015c6160f52@t-8ch.de>
 <20241101213314.GC15112@1wt.eu>
 <49905050-8bea-498a-9a69-bbf7e00f30c8@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49905050-8bea-498a-9a69-bbf7e00f30c8@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Nov 01, 2024 at 09:40:34PM +0000, Thomas Weißschuh wrote:
> > Maybe we could just enclose the test with:
> > 
> > #if !defined(__GLIBC__) || __GLIBC__ > 2 || __GLIBC_MINOR__ >= 40
> >  ...
> > #endif
> 
> This will mess up the test case numbers.
> The test is actually only running on nolibc anyways, so we could also
> stub out strlcat() with a dummy inline function.

OK.

> > > For better architecture coverage I would recommend ./run-tests.sh over
> > > "make run/user". Speaking about this I remember the discussion from the
> > > 6.12 PR where Willy proposed an improved run-tests.sh error message.
> > > It seems he didn't push it as a commit, so let's add keep it in mind for
> > > next cycle.
> > 
> > Oups, I vaguely remember proposing a trivial patch in an e-mail a while
> > ago but I don't even remember what it was about. My mind is totally taken
> > by the upcoming haproxy release these days :-/
> 
> It's at https://lore.kernel.org/lkml/ZtlQbpgpn9OQOPyI@1wt.eu/
> No worries, I'll pick it up after 6.13-rc1.

Ah, I found it, it reminded me something, because usually I forget about
patches once I commit them! I had pushed it to the next branch by then:

  commit 6fc1d365c7394790cf7073a4acfcbf7fe4e8eff9 (HEAD -> 20240908-nolibc-next, korg-nolibc-git/next)
  Author: Willy Tarreau <w@1wt.eu>
  Date:   Sun Sep 8 12:00:12 2024 +0200

    selftests/nolibc: run-tests.sh: detect missing toolchain
    
    The script tries to resolve the path to the current toolchain using
    realpath, which fails in case it's not installed, and since it's run
    under -e, it doesn't have the opportunity to display a help message.
    Let's detect the absence of the required toolchain before running that
    command and provide a friendlier message when this happens.
    
    Link: https://lore.kernel.org/all/ZtlQbpgpn9OQOPyI@1wt.eu/
    Signed-off-by: Willy Tarreau <w@1wt.eu>

Seems like we messed up with a forced push to next at some point :-)

I rebased it on the current next and pushed it again:

    648da1b274cf85fff5fe60914ae6a402013f456c

Cheers,
Willy

