Return-Path: <linux-kernel+bounces-364137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3E99CB89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14ED51F22B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003F1A76BC;
	Mon, 14 Oct 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MrlqxTs0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73F4A3E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912294; cv=none; b=dH8TVbcz9DBI8xMiYP6XFDux+n6fTQrgc1Jn+zqviR79caUHPNIjUfesMfhEzxHlWFZPf8rjM0KVJeziXcqEuCbZegqtz7Tv+XXDadFzlsEVt6QEA/QARuxkugtN54OuytX+WSEbe8sev2MAIQNOcLwjdaokT8Hgba2/6JBde44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912294; c=relaxed/simple;
	bh=P3434jjoYDLOru+6xv29EKjoEYA2tZQNbtyGYyCmSdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hshZsHXqPh92hiVdEDaPXqmqfiKgbDl5MXCBjkAoSm1hcPNd8iVpbXoEMqXyDxf3WkMt4iOsegglI7JKTAVqupEFpzAZv7wKhbeenJA5Ksz4Ke5APFUuupc1KOeemSjkwgh/QxZCPROBesPWokaKXeYT6p3RPRXJfE3WEuGYTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MrlqxTs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E2C4CEC3;
	Mon, 14 Oct 2024 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728912293;
	bh=P3434jjoYDLOru+6xv29EKjoEYA2tZQNbtyGYyCmSdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrlqxTs0Sdj57/prtWrlmsR88D0ncAIcdBMvfJUs+3MDt4uKF5fw+RQRlLj59r1ZX
	 3BZYsHReScDj43h6DWoqbdDxgh9EVQx6QVsp6qAgJi1GpKJAb6QMl1e9noY3jdV7nq
	 J942JCNrl5YmsTyDzsKBTH/Ex3oaRmQ4k2SmU9K4=
Date: Mon, 14 Oct 2024 15:24:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Weil, Oren jer" <oren.jer.weil@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
Message-ID: <2024101439-vagrancy-cubicle-77e0@gregkh>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
 <2024101343-proposal-gatherer-8c43@gregkh>
 <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101335-turbulent-smelting-00f2@gregkh>
 <CY5PR11MB636626DB1AB4507D847E21CEED442@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB636626DB1AB4507D847E21CEED442@CY5PR11MB6366.namprd11.prod.outlook.com>

On Mon, Oct 14, 2024 at 01:15:49PM +0000, Usyskin, Alexander wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Sunday, October 13, 2024 6:08 PM
> > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > 
> > On Sun, Oct 13, 2024 at 02:22:27PM +0000, Usyskin, Alexander wrote:
> > > > -----Original Message-----
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Sunday, October 13, 2024 3:14 PM
> > > > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > > > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > > > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > > > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > > >
> > > > On Sun, Oct 13, 2024 at 02:53:14PM +0300, Alexander Usyskin wrote:
> > > > > Read buffer is allocated according to max message size,
> > > > > reported by the firmware and may reach 64K in systems
> > > > > with pxp client.
> > > > > Contiguous 64k allocation may fail under memory pressure.
> > > > > Read buffer is used as in-driver message storage and
> > > > > not required to be contiguous.
> > > > > Use kvmalloc to allow kernel to allocate non-contiguous
> > > > > memory in this case.
> > > > >
> > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > > ---
> > > > >  drivers/misc/mei/client.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > What about this thread:
> > > > 	https://lore.kernel.org/all/20240813084542.2921300-1-
> > > > rohiagar@chromium.org/
> 
> [1] https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/

Yes, it's a problem, I don't understand.

> > > >
> > > > No attribution for the reporter?  Does it solve their problem?
> > > >
> > > This patch is a result from non-public bug report on ChromeOS.
> > 
> > Then make that bug report public as it was discussed in public already :)
> > 
> Unfortunately, it is not my call.
> For now, I'll anchor this on [1]
> 
> > > > Also, where is this memory pressure coming from, what is the root cause
> > > > and what commit does this fix?  Stable backports needed?  Anything else?
> > > >
> > > The ChromeOS is extremely short on memory by design and can trigger
> > > this situation very easily.
> > 
> > So normal allocations are failing?  That feels wrong, what caused this?
> 
> 64K is order 4 allocation and may fail according to [1].

And what changed to cause this to suddenly be 64k?  And why can't we
allocate 64k at this point in time now?

> > > I do not think that this patch fixes any commit - the problematic code exists
> > > from the earliest versions of this driver.
> > > As this problem reproduced only on ChromeOS I believe that no need
> > > in wide backport, the ChromeOS can cherry-pick the patch.
> > > From your experience, is this the right strategy?
> > 
> > No.
> 
> Sure, I'll use
> Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
> where the first time such buffer allocated and add stable here in v2.

So the problem has been there for years?  Why is it just now showing up?

thanks,

greg k-h

