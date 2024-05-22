Return-Path: <linux-kernel+bounces-185748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097E8CBA21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3989281998
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE974E26;
	Wed, 22 May 2024 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzeDVk3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC01103;
	Wed, 22 May 2024 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716350260; cv=none; b=ZJ6yyMU0xFnNUhrv63BvSag1yhBO2BH4ehWeBa+VhO3ZuMxVJpjj5ykv4dNXwMD6BWz0fjBucO1VBD8oRsqhxktl0f+e2ciJ6Rb8Gpqu0tz6fArq+I5F+5KtQA2vSC3lQOkUES0iYyOdVoAuQOp1fKywbqnZTNM5kVVk6P2dYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716350260; c=relaxed/simple;
	bh=a0m5ZolAVAaZbZQuEnj6RnJJAsiZSt0L4UXVzUod3Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0FenzxwEj8p1yvguozKAzvS6R5ake8eFJp0BOmM43DqvV5FrHo0PmTO7fhlcEubonbXCsr2I5Ff7gcridxPOW6KfcGYPmf7oluZQ50TtqkPPfqpkwYoaXo9PgY8yqsA1FMPPZwJ/arNSUJgvgVhygiwbCgFkAVQHJ9Q5VS5OqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzeDVk3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E29EC2BD11;
	Wed, 22 May 2024 03:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716350260;
	bh=a0m5ZolAVAaZbZQuEnj6RnJJAsiZSt0L4UXVzUod3Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzeDVk3+35GefszjCmGhsDU5jVwMz10kcAPHA25V9OtDQy8l0OuwaLjRAmgbb1irt
	 byghPd4DQLNSjGiicGEOsbEuiNVDxQgS9u60KM7GV9rJ7dXFcNZTYhEX/aNH2DXq2k
	 q5x8kqF969k2/zAwS5BNEQ4+mZ9+B1NNR0JIRS8w=
Date: Wed, 22 May 2024 05:57:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <2024052243-napping-coastal-3306@gregkh>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkzgZoxF_RD50PdW@tiehlicka>

On Tue, May 21, 2024 at 07:56:54PM +0200, Michal Hocko wrote:
> On Tue 21-05-24 19:03:58, Greg KH wrote:
> > On Tue, May 21, 2024 at 06:51:28PM +0200, Michal Hocko wrote:
> [...]
> > And really, in the end, if you have a "CVE and fix for CVE" in the same
> > release, applying both doesn't hurt anyone, so this is a "fail secure"
> > mode for everyone, right?
> 
> Look Greg, we have been through this discussion at several occasions and
> I do not want to repeat that again. Stable tree users probably do not
> care because they are getting all these patches, including regressions
> and patches they do not need or even want, anyway. They are getting what
> they are _paying_ for. Marking them CVE doesn't make any difference. But
> stable tree backporting model is simply not a good fit for _many_ users.

I understand you feel this way, but I can still disagree that it results
in a secure system for users.  But let's ignore that for now...

> Now, for $reasons, people _do_ care about CVEs and that is why there is
> an engineering cost on downstreams to review them. Exactly because
> applying all of them blindly is a _risk_. Exactly because the stable
> backporting model/policy and CVE assigning policy is simply incompatible
> with the stability/correctness/performance/$other requirements. 

That's your business decision, NOT mine.

> I completely do get why you do not care about that downstream
> engineering cost but generating bogus CVEs on top of a huge pile of
> dubious ones is less than useful, don't you think?

How is this a "bogus" CVE on their own?  Both issues involved here
classify as such, the only issue is that the fix/revert showed up in the
same release.  And yes, as such, it does not qualify under the CVE rules
as they want to see the bug in a release, and so our tools normally
catch this type of thing.

BUT if you have a model of "I cherry-pick what I want", you WILL miss
things like this that could be considered serious.  So note that by us
not classifying stuff like this as a CVE, YOU run the risk of missing
this and maybe ending up with a bug in your system (i.e. you took the
bug, but not the fix.)

That's your risk, yes, and your business decision to do so, the commits
here in question being marked as a CVE make your life easier, not
harder, so while I will go revoke these, realize this means that you now
need to do more work, not less, for the future.  Sorry about that.

> Seriously, we can disagree whether something is a security threat that
> is worth marking by a CVE. But making the CVE generation process mostly
> unattended script driven process without any _serious_ review in place
> is burning a lot of man power that could be used in a much more
> productive way. This is not the way how to convince people to use stable
> kernels.

To think that any of this is an "unattended script without any _serious_
review" is slandering all of the people who put in their free time to do
this work for you and the community.  This is ANYTHING BUT an unattended
script.  Personally I have "wasted" weeks, if not months, of development
time I could have spent in review of kernel patches, or writing kernel
fixes, in order to get this all working properly, having meetings, going
through "CVE CNA training", writing bash scripts, writing tests for bash
scripts, fixing bash scripts based on horrible data in free-form
changelog commits, and most importantly, reviewing 100+ commits a week
yet-again.

Then there is the other developers here doing this work, it's not just
me.  For every CVE you see assigned, it has been reviewed and agreed
apon by at LEAST 2 different independent people.  Usually 3.  That is
anything but "unattended".  If you wanted "unattended", I would just
crank out a CVE for every stable commit that is added to the tree, but
that's not what is happening.  We are manually reviewing every commit to
see if it matches up with the CVE vulnerability guidelines and
classifying it as such.  To tell people that the work they do is not
even happening is rude.

Also, this is work ostensibly that you are also already doing for your
day-job, right?  Surely you also are reviewing each and every commit
that ends up in the stable kernels at the very least to evaluate if they
are security or just bug fixes for your corporate offerings, right?  So
you already have this work done, why does it matter if a CVE is assigned
to a commit or not, you all already know if it is relevent or not for
your kernels before that assignment happens, so you can trivially just
match up the ids to see if perhaps you missed something or not, right?

So along those lines, why not help us out and provide us with a list of
commits that you feel _should_ be assigned CVEs, and an annotated list
of those that you feel _should not_ be assigned, like we are currently
doing today as part of our review process?  We already have external
people helping us out already, sending us patches for our review lists
and providing a fourth and fifth set of review eyes on things for where
we miss stuff, OR where we get things wrong (hey, we are human, we will
do both as this is NOT automated.)

I appreciate your reviews so far of "hey, this shouldn't really be a
CVE, right?"  That's a lot of help and is making things better, but to
insinuate that somehow we don't know what the hell we are doing, or that
we are doing nothing other than a simple "assign everything!" process
here is extremely insulting to me and to the other developers here
working on this.

So again, I welcome your help, and I understand your frustration that
somehow you feel we are now making you do more work than before, but if
that really is the case, then you really weren't actually looking at the
patch stream of fixes that you should have been looking at, and I doubt
that's something you want to admit to in public :)

thanks,

greg k-h

