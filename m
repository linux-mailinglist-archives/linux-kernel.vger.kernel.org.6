Return-Path: <linux-kernel+bounces-417143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0539D4F88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54F01F22426
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C271DBB38;
	Thu, 21 Nov 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SnFo5qCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1E1D7E4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202118; cv=none; b=QhOhs2Pux9oGE8Np5eLk1yWq4hbueFoyLdJYT8Euexw9dmAJ8rTN4/ujbrmSSYC4FxR8VQQIWDKeFSIcwTfnhioCYVFCHmmwZ+37Ingeyrm39yn82tZDZkIDtkoT6SI9L008JZPeqq4zKfq2Hq7NtxnekCvijVffu6o/QkoGqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202118; c=relaxed/simple;
	bh=gYLzfgpMs7WUUmf3SbJdgDeAc9BuCcn5Zu3MDy2dOQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE9VORCacUxbW6/CuQpIiVnoLDCzcRh11qwXeme+OoywBHQ2Hw7mbPggp47Q50KlyWAah5dl9xIfY+wgIhhGnowMtvOS7Dd5zrROH8HK75AjHptDf77oFyvTbfMCzJ8DLsWfOJaiuqzrBbZYn/BT6SL/POqc6HON15hpac8M0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SnFo5qCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A33C4CECC;
	Thu, 21 Nov 2024 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732202117;
	bh=gYLzfgpMs7WUUmf3SbJdgDeAc9BuCcn5Zu3MDy2dOQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnFo5qCjbHVsZcFRoCfS37u/l4Z857HVyH8l5ZcDH4F1mqWkToVXAR2zu68akrOm1
	 13iR1PM5EuvQoMw2pwjLdBkCvEw4seCZGPjK+h5zmV7YocS7zaGJYiShMSnrsjurF3
	 3JmsGmDjBGa/0ikqrKtnTxGexvD6gdFb5uh+1hoY=
Date: Thu, 21 Nov 2024 16:14:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, mingo@redhat.com, arnd@arndb.de,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
Message-ID: <2024112134-theater-jasmine-61f3@gregkh>
References: <20241120122858.22190-1-laoar.shao@gmail.com>
 <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>

On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
> On Thu, Nov 21, 2024 at 4:51 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 20.11.24 13:28, Yafang Shao wrote:
> > > When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
> > > kernel data for debugging purposes is prohibited. This configuration is
> > > always enabled on our production servers. However, there are times when we
> > > need to use the crash utility to modify kernel data to analyze complex
> > > issues.
> > >
> > > As suggested by Ingo, we can add a boot time knob of soft-enabling it.
> > > Therefore, a new parameter "strict_devmem=" is added. The reuslt are as
> > > follows,
> > >
> > > - Before this change
> > >    crash> wr panic_on_oops 0
> > >    wr: cannot write to /proc/kcore      <<<< failed
> > >
> > > - After this change
> > >    - default
> > >      crash> wr panic_on_oops 0
> > >      wr: cannot write to /proc/kcore    <<<< failed
> > >
> > >    - strict_devmem=off
> > >      crash> p panic_on_oops
> > >      panic_on_oops = $1 = 1
> > >      crash> wr panic_on_oops 0
> > >      crash> p panic_on_oops
> > >      panic_on_oops = $2 = 0            <<<< succeeded
> > >
> > >    - strict_devmem=invalid
> > >      [    0.230052] Invalid option string for strict_devmem: 'invalid'
> > >      crash> wr panic_on_oops 0
> > >      wr: cannot write to /proc/kcore  <<<< failed
> > >
> > > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >   .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
> > >   drivers/char/mem.c                            | 21 +++++++++++++++++++
> > >   2 files changed, 37 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 1518343bbe22..7fe0f66d0dfb 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -6563,6 +6563,22 @@
> > >                       them frequently to increase the rate of SLB faults
> > >                       on kernel addresses.
> > >
> > > +     strict_devmem=
> > > +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether strict devmem
> > > +                     is enabled for this boot. Strict devmem checking is used
> > > +                     to protect the userspace (root) access to all of memory,
> > > +                     including kernel and userspace memory. Accidental access
> > > +                     to this is obviously disastrous, but specific access can
> > > +                     be used by people debugging the kernel. Note that with
> > > +                     PAT support enabled, even in this case there are
> > > +                     restrictions on /dev/mem use due to the cache aliasing
> > > +                     requirements.
> > > +             on      If IO_STRICT_DEVMEM=n, the /dev/mem file only allows
> > > +                     userspace access to PCI space and the BIOS code and data
> > > +                     regions. This is sufficient for dosemu and X and all
> > > +                     common users of /dev/mem. (default)
> > > +             off     Disable strict devmem checks.
> > > +
> > >       sunrpc.min_resvport=
> > >       sunrpc.max_resvport=
> > >                       [NFS,SUNRPC]
> >
> > This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I don't
> > enjoy seeing devmem handling+config getting more complicated.
> 
> That poses a challenge. Perhaps we should also consider disabling
> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=off,
> but implementing such a change seems overly complex.
> 
> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
> kernel debugging. In an earlier version, I proposed making the
> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
> that it violates the principles of STRICT_DEVMEM.

I think that "primary goal" is the problem here.  We don't want to do
that, at all, for all the reasons why we implemented STRICT_DEVMEM and
for why people enable it.

Either you enable it because you want the protection and "security" it
provides, or you do not.  Don't try to work around it please.

> Do you have any suggestions on enabling write access to /dev/mem in
> debugging tools like the crash utility, while maintaining
> compatibility with the existing rules?

I think you just don't provide write access to /dev/mem for debugging
tools as it's a huge security hole that people realized and have plugged
up.  If you want to provide access to this for "debugging" then just
don't enable that option and live with the risk involved, I don't see
how you can have it both ways.

sorry,

greg k-h

