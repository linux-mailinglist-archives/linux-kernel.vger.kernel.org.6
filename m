Return-Path: <linux-kernel+bounces-185243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B08CB296
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50018282C43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96638147C73;
	Tue, 21 May 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1JLOmnY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F67580B;
	Tue, 21 May 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311041; cv=none; b=d6B+WwDx6nVxazQExfVg2hKIk5ZDmt1u6IOJWksA5ThPcodfTkXGu+KL6KkMoEpCFuSemgxX+8mPlvEWypxwRbHdFo0YfkxMhvNgMtuAzPhCl08gB546GYrCVnG16sD9elUUv3xTLS2wkNMQBPsQGiGsr+oqBAEm8onFKPCBwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311041; c=relaxed/simple;
	bh=sy+zngLduVk/xSbOMKhxP9EvqCxa5wNnOSt1AdPU2Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChO1VP4i3EbrK0Kdfdr1V+K2pFA4Mh0nq5nyLp6QRzP6Smt/SYb3GntPTZguY0UeU1DW3Dg6k03egpUR60CUYAn+fdpjAO8uTHs2GPEtnMktv83xWqgEpSQ88YfBaQowMTdvDfvhNigDOTS8PMY6aQ1U0i7hN9AK0WRPyhR6zrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1JLOmnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C0AC2BD11;
	Tue, 21 May 2024 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716311041;
	bh=sy+zngLduVk/xSbOMKhxP9EvqCxa5wNnOSt1AdPU2Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1JLOmnYQIdJ5YgYx0ZHcplDYP6E9DaG7Tz7EyQ84guhggSqhD2bexGlhnRAA5Yfx
	 NwGurZbRv1IDchbtuEnANW+eECUbWziknS9SFNQcOFp+y3RsdjkyNmhM6QScBMRJ54
	 vvFWQF1Lq66WmPb4YUatN+y32MDyXzCrM/83PVnA=
Date: Tue, 21 May 2024 19:03:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <2024052110-grasp-liking-22c0@gregkh>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkzREEA5_N_xfqED@tiehlicka>

On Tue, May 21, 2024 at 06:51:28PM +0200, Michal Hocko wrote:
> On Tue 21-05-24 16:39:51, Greg KH wrote:
> > On Tue, May 21, 2024 at 10:28:41AM +0200, Michal Hocko wrote:
> > > CVE-2024-35881 to revert f341055b10bd ("drm/amd/display: Send DTBCLK
> > > disable message on first commit") by 3a6a32b31a11 ("Revert
> > > "drm/amd/display: Send DTBCLK disable message on first commit"") has
> > > been filed as well.
> > > 
> > > Is this really intentional? Should both be rejected?
> > 
> > I don't think so as we had releases with the original commit in it,
> 
> I do not think so. Looking at stable kernel branches:
> $ git describe-ver 0dab75b433ed2480d57ae4f8f725186a46223e42
> v6.8.5~88
> $ git describe-ver d6d5622f64f3e07620683d61c880f57965fe1b48
> v6.8.5~239

Ah, missed that, sorry, was thinking about a different set of reverts
recently assigned.

> Both of them were released in 6.9-rc1 in Linus tree. I do not see them
> in any other stable trees. Neither of them is even marked for stable and
> they seemed to be merged only because of (stable tree) 7ea8a0e12088eb0c
> which has Stable-dep-of: f341055b10bd ("drm/amd/display: Send DTBCLK
> disable message on first commit"). Btw note that 7ea8a0e12088eb0c is not
> marked for stable, nor I see anybody requesting that on lore.
> Stable rulez!
> 
> Let's put aside whether f341055b10bd should get a CVE, we have clearly a
> different view on that but looking at the vulns.git tree both CVEs have
> been assigned together
> $ git log ./2024/CVE-2024-35906.sha1 ./2024/CVE-2024-35881.sha1
> commit a6191f0053349c3234f690316d6511e97927f28f
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Sun May 19 10:35:32 2024 +0200
> 
>     some 6.8.5 cves assigned
> 
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> which to me indicates that both CVEs were assigned by a script
> without a proper review which is really unfortunate.

Note, we have checks for many of these things, where we have an affected
kernel and a fix in the same release, and we do NOT assign a CVE for
those types of things.  This is the first time that I know of where we
have had this happen where the bug and revert was in the same release,
hard part here was that the revert didn't have a Fixes: tag, if it did,
we would have caught it.

> Please keep in mind that there are actual consumers of these CVEs and
> you are burning their time evaluating these noops. A waste of time, if
> you ask me, and not something that could be just neglected considering
> how many CVEs you are producing.

We will have a small % of issues that we miss and mess up like this,
that's just because we are all human.  Your help in reviewing these is
greatly appreciated.  Right now I still feel we are not catching all
that we should be catching to mark as a CVE, so we are open for anyone
to help us out with reviews.  Luckily we have a few more people helping
now as well, which is great.

And really, in the end, if you have a "CVE and fix for CVE" in the same
release, applying both doesn't hurt anyone, so this is a "fail secure"
mode for everyone, right?

thanks,

greg k-h

