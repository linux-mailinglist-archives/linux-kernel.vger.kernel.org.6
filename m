Return-Path: <linux-kernel+bounces-213011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6F9069CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4449D1C21934
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A41422D0;
	Thu, 13 Jun 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUzr1jN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60721422B7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273831; cv=none; b=hk/i3UVXD8U3wYSsixNurQ/EDNZlX27Smd+vJWdwk/JrAhG61JTUvL3FTgR/BDttPOfI+EdezJxt7Z7Xc3huQ/Ts0+wZS7Pwa/j1CpwBsBAKh5VjlA2pCK4733Eu/XESobqUSnnjkUubkrRT8hU7eqGEin5Po6Anl2e+KdnEjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273831; c=relaxed/simple;
	bh=/wheDLMlX0XENCAblFOAbpNGbkSATLpkAjgHm6mZvlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oymSucE+lSWbHCmPUH8iNQCtbvNWW61tVQg3wO+Ak/MRx2vi06STk/KPbvTKeeUz+iPODe3Ak/T1neBAB9wRnSdCWxO5/6/wjaiftOKfe1ywBe95mp7jSbcBJs1nrMfdiKm/OGYgd+ChewLRWN3wIvL6OYSAC/iBjaEYrP78/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUzr1jN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF12C2BBFC;
	Thu, 13 Jun 2024 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718273831;
	bh=/wheDLMlX0XENCAblFOAbpNGbkSATLpkAjgHm6mZvlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUzr1jN7GZPYuU13VQTxeENBnQRziC2NGxTdNl4BUakP26LxZ5Z2aj7pC6vVjhWUD
	 aHAd5Y3G1MrTEeMm/nV3Oejs8V2FP2thBz3S/3AhspOGOGFaa2oHJHLTdtB2ROzKSH
	 BB1rGV5ndEwwxe76WmkmLbKPePl96yaSoFcLuGEw=
Date: Thu, 13 Jun 2024 12:16:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>, Michal Hocko <mhocko@suse.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <2024061335-wistful-brownnose-28ea@gregkh>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
 <ZfsBpal_29lihveI@tiehlicka>
 <20240320154734.GU1522089@google.com>
 <Zmq8uSVv0X5f7xx+@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmq8uSVv0X5f7xx+@duo.ucw.cz>

On Thu, Jun 13, 2024 at 11:32:41AM +0200, Pavel Machek wrote:
> On Wed 2024-03-20 15:47:34, Lee Jones wrote:
> > On Wed, 20 Mar 2024, Michal Hocko wrote:
> > 
> > > On Thu 14-03-24 11:09:38, Lee Jones wrote:
> > > > On Fri, 08 Mar 2024, Michal Hocko wrote:
> > > > 
> > > > > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > > > > [...]
> > > > > >  Possible unsafe locking scenario:
> > > > > > 
> > > > > >        CPU0                    CPU1
> > > > > >        ----                    ----
> > > > > >   lock(&svms->lock);
> > > > > >                                lock(&mm->mmap_lock);
> > > > > >                                lock(&svms->lock);
> > > > > >   lock((work_completion)(&svm_bo->eviction_work));
> > > > > > 
> > > > > > I believe this cannot really lead to a deadlock in practice, because
> > > > > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> > > > > > refcount is non-0. That means it's impossible that svm_range_bo_release
> > > > > > is running concurrently. However, there is no good way to annotate this.
> > > > > 
> > > > > OK, so is this even a bug (not to mention a security/weakness)?
> > > > 
> > > > Looks like the patch fixes a warning which can crash some kernels.  So
> > > > the CVE appears to be fixing that, rather than the impossible deadlock.
> > > 
> > > Are you talking about lockdep warning or anything else?
> > 
> > Anything that triggers a BUG() or a WARN() (as per the splat in the
> > commit message).  Many in-field kernels are configured to panic on
> > BUG()s and WARN()s, thus triggering them are presently considered local
> > DoS and attract CVE status.
> 
> So... because it is possible to configure machine to reboot on
> warning, now every warning is a security issue?
> 
> Lockdep is for debugging, if someone uses it in production with panic
> on reboot, they are getting exactly what they are asking for.
> 
> Not a security problem.

And we agree, I don't know what you are arguing about here, please stop.

greg k-h

