Return-Path: <linux-kernel+bounces-250785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEDF92FCCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9611F232F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF5172BAA;
	Fri, 12 Jul 2024 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="N/z5Vvml"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDF171E66
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795427; cv=none; b=efgICoLrRSl8st1W1k9JdJ/t7rbPuJhyTYU2rZw2KoJAcHkTYavzPDxZ9QrTb5hgVz1+EX/ZTjo+DJ3tq6ksdg5eUmSeDEpGllhflIz3AldNAz4wnYDwM+C8wFGEtirpGimZuiZJVaFDDITtQGpU//qzXRER1uIDya0bp5dXojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795427; c=relaxed/simple;
	bh=m4x7cIKYi9K2bRrl+wEQc5BTywPzUjq2zs946U6vHeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByYeayb4W5GvFTu/UaT+FFyEQXqAg+xhYzwxQCMUy9yeDlXCxF5NX3ZEw/DabgFhae6sqGNsrH6l3qcIrtXgIi4aNMvxJUwIxNmEYhaeNRw8ump+Tm39hWWCbMtypBUOV55/d68fgxqw66QUoe8eDjiaQXddE4wvoySdc58ptRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=N/z5Vvml; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=DogGsreGZlacWKpAGSJpIB1wlRRqT/2GkqnxKuBXHqo=; b=N/z5Vvmlhs85Il9/7pdtp61ewx
	yRrto5KQLNMnayKJ1+6Pf+jbVXyZNe24SIX64SKnTzbNovs3HohNz+aRVucHgyIEUdvtlU4FPG6vQ
	iMeeBY+RavEiEQtw8hfX0fO92YZBF1DHGojaISOryL7wD0J0EFcj9ejjkz8AAtcjbC4MzhRop8fuP
	tx3qZ672TH5qzpNsIiChOqqd4rY4zQYh06GR6K9h5sCgHT2cXhTN3GgWmMFavyniatTX88PIYfFcS
	v/9c4bGiAtPBumcrBkTEeatF6gxs1caOgIhdYVKOO/vFNS1vyC3djOPP2uhg3EHrX4UXTBtTGZIZH
	f/ZtHbJg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <corsac@debian.org>)
	id 1sSHUX-00BSVo-Qi; Fri, 12 Jul 2024 14:43:21 +0000
Date: Fri, 12 Jul 2024 16:41:59 +0200
From: Yves-Alexis Perez <corsac@debian.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, jirislaby@kernel.org,
	surenb@google.com, riel@surriel.com, cl@linux.com,
	akpm@linux-foundation.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Message-ID: <ZpFAt6ha2KbFRoFn@corsac.net>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <2d7bd8b2b9736d4a7d0a26169978372b5e002a62.camel@debian.org>
 <CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com>
 <ZpBFjzIEpq6RIM8I@casper.infradead.org>
 <CAHbLzkpitWRK2q3JidRdyQxajz+MixiO1bX08btVu9Ch0i6Kxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkpitWRK2q3JidRdyQxajz+MixiO1bX08btVu9Ch0i6Kxw@mail.gmail.com>
X-Debian-User: corsac

On Thu, Jul 11, 2024 at 01:53:04PM -0700, Yang Shi wrote:
> On Thu, Jul 11, 2024 at 1:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jul 11, 2024 at 01:47:00PM -0700, Yang Shi wrote:
> > > +++ b/mm/huge_memory.c
> > > @@ -857,7 +857,8 @@ static unsigned long
> > > __thp_get_unmapped_area(struct file *filp,
> > >         loff_t off_align = round_up(off, size);
> > >         unsigned long len_pad, ret, off_sub;
> > >
> > > -       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > > +       if (IS_ENABLED(CONFIG_32BIT) || IS_ENABLED(CONFIG_X86_32) ||
> > > +           in_compat_syscall())
> >
> > Why not:
> >
> >         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
> 
> Nothing specific, just didn't think of it, sigh...
> 
> Thanks for the suggestion. Definitely preferable way.
> 
And I just did a quick test rebuilding a kernel with
!IS_ENABLED(CONFIG_64BIT) and running on an i386 Debian sid
installation.

I can confirm it seems to work as intended:

Before:
root@testvm:~# uname -a
Linux testvm 6.9.8-686-pae #1 SMP PREEMPT_DYNAMIC Debian 6.9.8-1 (2024-07-07) i686 GNU/Linux
root@testvm:~# for i in {0..9}; do cat /proc/self/maps |grep libc.so |head -n1; done
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c00000-b7c22000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6


After:

root@testvm:~# uname -a
Linux testvm 6.9.8+ #1 SMP PREEMPT_DYNAMIC Fri Jul 12 15:23:07 CEST 2024 i686 GNU/Linux
root@testvm:~# for i in {0..9}; do cat /proc/self/maps |grep libc.so |head -n1; done
b7cf3000-b7d15000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7d7a000-b7d9c000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7d8b000-b7dad000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7d4b000-b7d6d000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7d64000-b7d86000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7d15000-b7d37000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7c9e000-b7cc0000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7d68000-b7d8a000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7cf6000-b7d18000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6
b7ce6000-b7d08000 r--p 00000000 fe:00 933        /usr/lib/i386-linux-gnu/libc.so.6

So:
Tested-By: Yves-Alexis Perez <corsac@debian.org>

I didn't try on other 32b architectures though.

Regards,
-- 
Yves-Alexis Perez

