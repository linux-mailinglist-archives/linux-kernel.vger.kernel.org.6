Return-Path: <linux-kernel+bounces-188851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BA8CE7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340D81C20699
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421B12EBE7;
	Fri, 24 May 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cM4l69z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9612EBDD;
	Fri, 24 May 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564147; cv=none; b=F2/KyvTf/+hTubkXSR9QjKtBbdE8a6CrbqmpZTXa6QreaqEM67Ym8Hw08SFcGPAV9OaQyKKdNYXaO8q8D9XPMB0WYumIcoXqYmVgCH0P/sWEdKB8APMuQoBPZ9PDrtF+UC0huC5UmJ1sIQqDXDzZhMD2GZjn6zSWYCYxniETnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564147; c=relaxed/simple;
	bh=KJRMlqCqKSeCAg/9WK2lD6+u6yawgLpv3ewX/qdZ/8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB1fId69lD8A/ZvahXf9uu1xux575TxqLPFIVQw6Fp1V3gI/4ofdCLN94+Fg0UBlL4dEZQD56uo4iLItf77m5PGpGAW0YnyRMZin7k4/NyMKOdZ9P0PhVL8gTV17WXMMSzH+OBe4DiREB0f3U6k6B/6r+Xrax0fZ+T3e0u2sDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cM4l69z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4F5C2BBFC;
	Fri, 24 May 2024 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716564146;
	bh=KJRMlqCqKSeCAg/9WK2lD6+u6yawgLpv3ewX/qdZ/8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cM4l69z8Pri4jff3QA2Yg9o1yKRy1YBKslxPI09u6Tn4L7xN1Lwdh4vgH7e7kYgAZ
	 YZV+NdsVMmcEwCbZWoxSAV34t62+YaKYJTgLQN35fFotRferv8DJx27pU1HTTr1E47
	 +ZhKTtjtNwSY/ZcbEKgEYghuOdSgOfe5zkDa8RTM=
Date: Fri, 24 May 2024 17:22:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <2024052453-afar-tartly-3721@gregkh>
References: <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
 <2024052243-napping-coastal-3306@gregkh>
 <Zk790Afi1sfwgrZi@tiehlicka>
 <2024052309-scabby-favored-0973@gregkh>
 <ZlBnsEsr66mR-frf@tiehlicka>
 <2024052458-matrimony-making-b7f1@gregkh>
 <ZlCd6kD4w2mezWBj@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlCd6kD4w2mezWBj@tiehlicka>

On Fri, May 24, 2024 at 04:02:18PM +0200, Michal Hocko wrote:
> On Fri 24-05-24 13:47:00, Greg KH wrote:
> > On Fri, May 24, 2024 at 12:10:56PM +0200, Michal Hocko wrote:
> > > On Thu 23-05-24 15:49:59, Greg KH wrote:
> > > > On Thu, May 23, 2024 at 10:26:56AM +0200, Michal Hocko wrote:
> > > > > On Wed 22-05-24 05:57:38, Greg KH wrote:
> > > [...]
> > > > Because of asking, many others are starting to help out, you can too,
> > > > just submit patches against the cve/review/proposed/ directory with a
> > > > list of commits that you feel should have CVEs assigned for, or annotate
> > > > why you feel specific ones we have reviewed should NOT have a CVE
> > > > assigned, and our tools can handle them quite well as part of the
> > > > assignment process (see scripts/cve_review for a tool that some of us
> > > > use to create these files, that's not required, as not all of us use it,
> > > > but the output format is the key, and that's a simple list of commit
> > > > ids, personally I generate that from mboxes.)
> > > 
> > > Do I get it right that proposals shouldn't be sent via email to
> > > cve@kernel.org as suggested by the in tree documentation?
> > 
> > The documentation should say that you _SHOULD_ send proposals to
> > cve@kernel.org, did we get it wrong somehow?
> > 
> > > I do not mind
> > > the specific workflow but until now I have followed Documentation/process/cve.rst
> > > as authoritative source of the process. It would be really great if that
> > > matched the workflow.
> > 
> > I'm confused as to what in that document is incorrect, care to point it
> > out?
> 
> Maybe I've just misunderstood the part about sending patches against
> cve/review/proposed/. I was thinking about sending pull requests against
> vulns.git.

Yes, you can do that too, send it to same email address.  That's not
really documented, just ask us instead!  :)

> > And people want to word-smith the text all the time already, so we just
> > default to using the changelog text as that's the most "neutral" and
> > public information out there (i.e. we don't have to worry about any sort
> > of data-retention or classification laws as the information is already
> > public in kernel changelog text.)
> 
> This part I do not understand. What is wrong about a reasoning why
> something has been considered a CVE? E.g. something like 
> CVE assigned because a potential WARN_ON is fixed and that could panic
> with panic_on_warn. Fixed by <URL_TO_LINUS_TREE>
> 
> or
> CVE assigned because UAF is fixed and those can be generally used to
> construct more complex attacks. Fixed by <URL_TO_LINUS_TREE>
> 
> etc.

Doing the work to classify all of these in this manner isn't going to
happen by us, sorry, as it is not required by the CVE process, and
frankly, we are doing a load of work already here.  We are going to rely
on the text that is in the changelog.  Maybe over time you can work with
the kernel developers to write better changelogs to describe what you
are looking for?

We will rely on external parties to "classify" the CVEs if they wish to
as there is already a whole ecosystem that attempts to do this already,
with various success.  In the end, it's up to each integrator of Linux
to classify them themselves as everyone's use case is different
(remember, cow milking machines, super-mega-yaht-stabilizers, washing
machines, servers, watches, air-traffic-control systems, etc...)

thanks,

greg k-h

