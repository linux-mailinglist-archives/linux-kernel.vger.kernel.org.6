Return-Path: <linux-kernel+bounces-317555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E889D96DFE8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC9E1F21550
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790E152787;
	Thu,  5 Sep 2024 16:35:53 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D98E17BD6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554153; cv=none; b=aEIHXjmDCRdIo3YmsZctvwnK8dQKQQRknZucHPwSXURzzjEiubXQuSYTI78AirvnC5IDuJeBF87EJWh5jp9GeAXrJnZe+PHRgTRN/fSQ+kw51jURQqdP+sfQDMh8VBE0wPBY3QChTO0H+Koq2tAi06AAB/9vmPK4+9yHtZLBZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554153; c=relaxed/simple;
	bh=hrCxjtcxM+Pkj0UDvqyYhC1fg0pSinXTpgirwjIWgF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKL9ZZy/3x8TgszvtySXjG8q0Xs142uSe5LSIDGzZ8URZaumbrSPLC002XCbhFXsNqMcCYmJVcnAJVEjVZWDDPckYZHqzP4i0LbgrMEdxsffmuQ3xbstB2EsenV07KcvfAsdQzszVt2H35cXuZ3N6zXSLEntLj4/O1/hmiH/eGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 485GZdLc011091;
	Thu, 5 Sep 2024 18:35:39 +0200
Date: Thu, 5 Sep 2024 18:35:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <Ztnd26IlnMwrywUO@1wt.eu>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
 <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de>
 <ZtlOGkADy7OkXY9u@1wt.eu>
 <ZtlQbpgpn9OQOPyI@1wt.eu>
 <bcdba244-aaf9-4a06-a4a6-c521d4cfa97e@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcdba244-aaf9-4a06-a4a6-c521d4cfa97e@t-8ch.de>

On Thu, Sep 05, 2024 at 05:57:22PM +0200, Thomas Weißschuh wrote:
> On 2024-09-05 08:32:14+0000, Willy Tarreau wrote:
> > On Thu, Sep 05, 2024 at 08:22:18AM +0200, Willy Tarreau wrote:
> > > > 
> > > > ./run-tests.sh -p -m user
> > > > 
> > > > These toolchains can then also be used for direct "make" invocations
> > > > through CROSS_COMPILE.
> > > 
> > > I really suspect an empty CC variable somewhere that could explain why
> > > only CROSS_COMPILE is used. I'll try to find time today to give it a
> > > try here as well, just in case I can reproduce the same issue.
> > 
> > In fact I'm getting it without any options:
> > 
> >   $ ./run-tests.sh
> >   realpath: /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory
> > 
> > It comes from here in test_arch():
> > 
> >         cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
> > 
> > Thus it's indeed related to the absence of the toolchain there. It's
> > just that the way the error is reported (due to set -e) is a bit harsh.
> 
> Ack. It should not occur with "-p" though.

Agreed, I was focusing on first experience for users essentially.

> > What about this ?
> > 
> >   $ ./run-tests.sh 
> >   No toolchain found in /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux.
> >   Did you install the toolchains or set the correct arch ? Rerun with -h for help.
> >   Aborting...
> > 
> > or anything similar, achieved by this patch (warning copy-paste, mangled
> > indents):
> > 
> > diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
> > index e7ecda4ae796..0f67e80051dc 100755
> > --- a/tools/testing/selftests/nolibc/run-tests.sh
> > +++ b/tools/testing/selftests/nolibc/run-tests.sh
> > @@ -143,6 +143,13 @@ test_arch() {
> >         arch=$1
> >         ct_arch=$(crosstool_arch "$arch")
> >         ct_abi=$(crosstool_abi "$1")
> > +
> > +       if [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
> > +               echo "No toolchain found in ${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}."
> > +               echo "Did you install the toolchains or set the correct arch ? Rerun with -h for help."
> > +               return 1
> > +       fi
> > +
> >         cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
> >         build_dir="${build_location}/${arch}"
> >         if [ "$werror" -ne 0 ]; then
> 
> Looks good.

OK thanks, I'll try to handle it this week-end if I'm not beaten to
it. If you or Shuah want to merge it before, feel free to, no offense
on my side!

Cheers,
Willy

