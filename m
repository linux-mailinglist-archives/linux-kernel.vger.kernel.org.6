Return-Path: <linux-kernel+bounces-213112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021B7906BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7761F23226
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62239143C60;
	Thu, 13 Jun 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy/JgZiA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BB143C51
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279064; cv=none; b=mWpcI/aOIg6ersW3TIzEkq0yEP5XrxAV0AjFGks8mjYA6zZ+8XD9ARmH31qln+0w/v0V/ReEv7Iu9WIcgGzXopJ7OzdheatopW++QS6nHRGHV03jIfYOS1vnT5aGs55+IJo2F97W4K7pKF1XNthQytSYtsyIiZqeaQ2ysyfxsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279064; c=relaxed/simple;
	bh=CJaBd2s3Dq0cWvdxftsetDuzthTx2fYfrrCKX/uQt4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2QWDr+06+cXp2t60+R4V++nWBHgjBRuDOI80NxtixcRl39GmETpDw0SV9CV3kSYZhW15aL/fot1ZUe4XEQaG0Oxii3qQdSYt76NWi/3TplVBWmcVjkOOpKs7jNoM/jz7gidR/BxaVNrVJ+SPwzZ2YyeXmY2gaGxMBrB5THqgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy/JgZiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E656CC2BBFC;
	Thu, 13 Jun 2024 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718279064;
	bh=CJaBd2s3Dq0cWvdxftsetDuzthTx2fYfrrCKX/uQt4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vy/JgZiA9hLKZeOQSaWLZqpCTsMXOez7AWCU0tW3y2NC1s9CFpICD46QgRjb/ob9T
	 CgL+H+FSvyRNnmD+J9S5hUDFlRTB1hyf3jOCKFjrFEEZqeUwOW1gb4zdMAb70XjFnJ
	 acghkkGRzVkOfbnJxhgZBs3eKiswNd+mvvxRIxqFc5cWBh4GD6vBL/Go3pro7CpoB8
	 NAjkDHC4SX0CBXy5GNf2aIzB+9yXiHjcd7W+rWFvNEccA7+lBs8etxbBM386LrfLo1
	 ti0BdTUVBosnJccplm5LXlhCMARrcNEPEPDEA6SVkNVvTx0Ect+jRQP4UzlJxXfcjw
	 quoBqeRQkHigA==
Date: Thu, 13 Jun 2024 12:44:20 +0100
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <20240613114420.GM1504919@google.com>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
 <ZfsBpal_29lihveI@tiehlicka>
 <20240320154734.GU1522089@google.com>
 <Zmq8uSVv0X5f7xx+@duo.ucw.cz>
 <2024061335-wistful-brownnose-28ea@gregkh>
 <ZmrMo6qFbt9/3xoh@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmrMo6qFbt9/3xoh@duo.ucw.cz>

On Thu, 13 Jun 2024, Pavel Machek wrote:

> On Thu 2024-06-13 12:16:50, Greg Kroah-Hartman wrote:
> > On Thu, Jun 13, 2024 at 11:32:41AM +0200, Pavel Machek wrote:
> > > On Wed 2024-03-20 15:47:34, Lee Jones wrote:
> > > > On Wed, 20 Mar 2024, Michal Hocko wrote:
> > > > 
> > > > > On Thu 14-03-24 11:09:38, Lee Jones wrote:
> > > > > > On Fri, 08 Mar 2024, Michal Hocko wrote:
> > > > > > 
> > > > > > > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > > > > > > [...]
> > > > > > > >  Possible unsafe locking scenario:
> > > > > > > > 
> > > > > > > >        CPU0                    CPU1
> > > > > > > >        ----                    ----
> > > > > > > >   lock(&svms->lock);
> > > > > > > >                                lock(&mm->mmap_lock);
> > > > > > > >                                lock(&svms->lock);
> > > > > > > >   lock((work_completion)(&svm_bo->eviction_work));
> > > > > > > > 
> > > > > > > > I believe this cannot really lead to a deadlock in practice, because
> > > > > > > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> > > > > > > > refcount is non-0. That means it's impossible that svm_range_bo_release
> > > > > > > > is running concurrently. However, there is no good way to annotate this.
> > > > > > > 
> > > > > > > OK, so is this even a bug (not to mention a security/weakness)?
> > > > > > 
> > > > > > Looks like the patch fixes a warning which can crash some kernels.  So
> > > > > > the CVE appears to be fixing that, rather than the impossible deadlock.
> > > > > 
> > > > > Are you talking about lockdep warning or anything else?
> > > > 
> > > > Anything that triggers a BUG() or a WARN() (as per the splat in the
> > > > commit message).  Many in-field kernels are configured to panic on
> > > > BUG()s and WARN()s, thus triggering them are presently considered local
> > > > DoS and attract CVE status.
> > > 
> > > So... because it is possible to configure machine to reboot on
> > > warning, now every warning is a security issue?
> > > 
> > > Lockdep is for debugging, if someone uses it in production with panic
> > > on reboot, they are getting exactly what they are asking for.
> > > 
> > > Not a security problem.
> > 
> > And we agree, I don't know what you are arguing about here, please stop.
> 
> So you agree that WARN triggering randomly is not a security problem?
> 
> Following communication did not say so.
> 
> "The splat in the circular lockdep detection code appears to be generated
> using some stacked pr_warn() calls, rather than a WARN()."

We agree that the lockdep detection is a debugging feature AND that even
though the splat looks like a WARN(), it does not behave like one.
Therefore it does not constitute a security issue.

However, yes, we believe that if an attacker can trip a WARN() and
reboot a victim's machine on demand then this is equivalent to a local
DoS attack and merits CVE status.

-- 
Lee Jones [李琼斯]

