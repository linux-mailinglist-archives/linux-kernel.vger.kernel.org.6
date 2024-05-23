Return-Path: <linux-kernel+bounces-187481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F228CD25E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CA31C21082
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2101487DB;
	Thu, 23 May 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvy4Ocf6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FD13B7AB
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467927; cv=none; b=Cx8ZxFlYkS36lNe0v7TqnlOIgZtp0iQ8AEPX/k2gk8lAz72D9+ygVheP+rGgifu5n1iM6ZX7ac+9fle5lld4OOZMUtMhrZ0yBmLwdC9x31EGQVMZN+UybVkJVn2YR9wC/HUpYtAA6CEQvLHnU0XRYM/aU5qwHEF2wSjLNmevc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467927; c=relaxed/simple;
	bh=m00Q3ogbphRbhlXUK4PkU1xACqq/hZrQhWigS4xsD7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6dkJmse71yYoyeifQ3ccGvEDooZjK22EzzJJYC1jH78LAnD+mGEavXnjm8raD89TaMnU4rwNpobM/T4GZCZBSJ3ECqB5rlM0ZRHR+zddV8VycOctGam6pL8fDSa5Vs0nwPvdDoDtJaR6zkLoBdh6r0qwS8nNznzumcEEu5Wcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yvy4Ocf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ECEC2BD10;
	Thu, 23 May 2024 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716467926;
	bh=m00Q3ogbphRbhlXUK4PkU1xACqq/hZrQhWigS4xsD7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yvy4Ocf6rkI7K5TOcE8CiQ99FdXJqCnLKq3ijRr7nMDPtbT2LMkffHL6Emc0w6T3Y
	 h9ZHet2yJlfPLdazLAI5NIT5hcwa4eNt0/wX6NIBqWOdK986cYIUP79aCJu21lzRAV
	 Dz/omRVcYG18yk+nI5ezmNwUQzk2bNo3t+kJN2x8=
Date: Thu, 23 May 2024 14:38:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
Message-ID: <2024052327-cider-finance-d040@gregkh>
References: <2024051738-CVE-2024-35802-959d@gregkh>
 <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
 <2024052334-cable-serotonin-fa2b@gregkh>
 <5ea91ae6-091d-4378-950b-833561eef48c@suse.com>
 <2024052310-undermost-cramp-5d81@gregkh>
 <d6981cc9-ea89-47fb-9084-267eba05c7a1@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6981cc9-ea89-47fb-9084-267eba05c7a1@suse.com>

On Thu, May 23, 2024 at 03:21:05PM +0300, Nikolay Borisov wrote:
> 
> 
> On 23.05.24 г. 15:17 ч., Greg Kroah-Hartman wrote:
> > On Thu, May 23, 2024 at 03:01:56PM +0300, Nikolay Borisov wrote:
> > > 
> > > 
> > > On 23.05.24 г. 14:21 ч., Greg Kroah-Hartman wrote:
> > > > Isn't crashing SEV guests a problem with "availability"?  That term
> > > > comes from the CVE definition of what we need to mark as a CVE, which is
> > > > why this one was picked.
> > > 
> > > But availability has never been one of the tenets of CoCo, in fact in
> > > sev-snp/tdx the VMM is explicitly considered outside of the TCB so
> > > availability cannot be guaranteed.
> > 
> > This has nothing to do with CoCo (but really, ability of the host to
> > crash the guest seems like it should be as I would assume that CoCo
> > guests would want to be able to be run...)
> > 
> > Official CVE definition of vulnerability from cve.org:
> > 	An instance of one or more weaknesses in a Product that can be
> > 	exploited, causing a negative impact to confidentiality, integrity, or
> 
> I don't see how this is exactly "explotaible" i.e if a guest is run and it
> crashes during bootup it simply won't run. Can this be considered active
> exploitation of an issue?

Isn't preventing a guest from running something that causes a lack of
avaiability?  Again, that's why we picked this commit, it keeps the
system from working properly as expected.

thanks,

greg k-h

