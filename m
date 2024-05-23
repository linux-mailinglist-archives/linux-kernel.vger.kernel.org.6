Return-Path: <linux-kernel+bounces-187458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D088CD222
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234C01C21205
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075913BACC;
	Thu, 23 May 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgdBCXcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223C1E481
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466657; cv=none; b=U8X578eHn7IgVIBlrtRJCM/wWS/pCtAYUuUx0JWucWoQAWCnU0fK1JxV+ddT4NOmiAGo+av+w4C/dQpHbgxa2RAk3oVc2wpGWA+dmoNVeBphJ1Z95yqcojc03YJoerEwrmkqFsjhR/zDkBT4Wjy63hbEvlyhueZKPxlgBYvyIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466657; c=relaxed/simple;
	bh=kShS9kQyOqyj0DwymZCMdDwTAoPZdXCOAqKVdAJhs7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/FkAfoMet6LhwbTuBnbHLKE29VJmubcF+JhohIB8Xf+HJSvKXzHIYEtUEGSjGzm/d6K4bSCWCUmzezUJJmyNtz9srNkn5oyQFOnjONGYHtvmA5SIBHKTkgKOwY+0dI2/rJyfnvyFUoHhnaBLkVRXH6p3rICDHrjW+zUMJ7HMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgdBCXcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B40C2BD10;
	Thu, 23 May 2024 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716466656;
	bh=kShS9kQyOqyj0DwymZCMdDwTAoPZdXCOAqKVdAJhs7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgdBCXcD0rL5hM44PRnaWIAKiTB/01ku8nPMGsVjdAf9DooW9QgEREPI0cQzJ9WmF
	 uR1oFOjJmUbpnPcrgFD0645cjomv+s2w0oHGu2tVk5gv+sJusRv+ZHdVn16ukVpM/T
	 /3G2F5OhW3QuHJwDQTy5olTQ/kdP4Uw2xxcoFfFM=
Date: Thu, 23 May 2024 14:17:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
Message-ID: <2024052310-undermost-cramp-5d81@gregkh>
References: <2024051738-CVE-2024-35802-959d@gregkh>
 <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
 <2024052334-cable-serotonin-fa2b@gregkh>
 <5ea91ae6-091d-4378-950b-833561eef48c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea91ae6-091d-4378-950b-833561eef48c@suse.com>

On Thu, May 23, 2024 at 03:01:56PM +0300, Nikolay Borisov wrote:
> 
> 
> On 23.05.24 г. 14:21 ч., Greg Kroah-Hartman wrote:
> > Isn't crashing SEV guests a problem with "availability"?  That term
> > comes from the CVE definition of what we need to mark as a CVE, which is
> > why this one was picked.
> 
> But availability has never been one of the tenets of CoCo, in fact in
> sev-snp/tdx the VMM is explicitly considered outside of the TCB so
> availability cannot be guaranteed.

This has nothing to do with CoCo (but really, ability of the host to
crash the guest seems like it should be as I would assume that CoCo
guests would want to be able to be run...)

Official CVE definition of vulnerability from cve.org:
	An instance of one or more weaknesses in a Product that can be
	exploited, causing a negative impact to confidentiality, integrity, or
	availability; a set of conditions or behaviors that allows the
	violation of an explicit or implicit security policy.

I think "able to crash SEV guests" is a direct weakness that has to do
with availability here which is why I marked it as such (as did other
reviewers.)  Now if CoCo wants to claim it as part of their security
implicit or explicit security policy, all the better :)

thanks,

greg k-h

