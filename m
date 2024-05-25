Return-Path: <linux-kernel+bounces-189365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7D8CEF17
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C50281BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E84EB39;
	Sat, 25 May 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f1D1ROxh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292E4AEDD;
	Sat, 25 May 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716643730; cv=none; b=WRMHhShi/XF/JYpS7JsBFLHihR7pK5cofbWHM/yoKyqgyi52J7M63Csp4F56QYJncEqExMRSpwD9UKMIjvildvroZvwx2AP1B8OTZMU51MP2MnDWgJL/kk4ii3fn9hLzCY0BAhi6wHGDUV7SBKDyn7NZYSk7EVIzVaEiLqdN4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716643730; c=relaxed/simple;
	bh=XlLrP6tdf0od3KFy5Clz03uLomMef757C+aHlRwveds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s93V8Hm5CHjGl/1vual4CwxpnF5V9yrI6BdaazS8VZsWbwxnwK1O9absOVJvebEKxk8hhFw4EruezWW29+EpILxOcvAhvq6Nvjhyqayq4gRdM0bzIcxuFg440tbY9htI6tSd2G0rOyKJKDJJSF282kvy7oYtTk0aT1+wbv7Voco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f1D1ROxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0156BC2BD11;
	Sat, 25 May 2024 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716643730;
	bh=XlLrP6tdf0od3KFy5Clz03uLomMef757C+aHlRwveds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1D1ROxhHfupUbo66/cA3oXIKgGwUfEBpPIi4svG9FQmc+/LskeIf42Shb95RUk7B
	 Rgqo/FWQPiRjwWsTbJKSrLqsmlZ/DIDljNh2H/1jGW6jZ6ghB7x4EHaWl4TeauXApS
	 VpezuNi3J/DN4ZCnf96vNvgP0LHcBLoZiaaTYemY=
Date: Sat, 25 May 2024 15:28:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Davide Benini <davide.benini@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-27429: netrom: Fix a data-race around
 sysctl_netrom_obsolescence_count_initialiser
Message-ID: <2024052540-shallot-hypnosis-1653@gregkh>
References: <2024051722-CVE-2024-27429-878c@gregkh>
 <ZkxdqOUek_MHqIMn@tiehlicka>
 <2024052105-pulsate-reborn-119a@gregkh>
 <ZkzGL_vXciG7ipm5@tiehlicka>
 <2024052219-storewide-arrogance-8d54@gregkh>
 <5f3cccea-eff5-40f7-a868-743ca837e84d@suse.com>
 <ZlB5l40ahqW8PGlC@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlB5l40ahqW8PGlC@tiehlicka>

On Fri, May 24, 2024 at 01:27:19PM +0200, Michal Hocko wrote:
> On Wed 22-05-24 12:21:54, Davide Benini wrote:
> > On 22/05/24 07:11, Greg Kroah-Hartman wrote:
> > > On Tue, May 21, 2024 at 06:05:03PM +0200, Michal Hocko wrote:
> > > > On Tue 21-05-24 16:40:24, Greg KH wrote:
> > > > > On Tue, May 21, 2024 at 10:39:04AM +0200, Michal Hocko wrote:
> > > > > > This and couple of others are all having the same pattern. Adding
> > > > > > READ_ONCE for an integer value with a claim that this might race with
> > > > > > sysctl updates. While the claim about the race is correct I fail to see
> > > > > > how this could have any security consequences. Even if a partial write
> > > > > > was observed which sounds _more_ than theoretical these all are merely
> > > > > > timeouts and delays.
> > > > > > 
> > > > > > Is there anything I am missing?
> > > > > 
> > > > > Nope, you are right, our fault, I'll go revoke this now.
> > > > 
> > > > please also revoke all others touching the same function.
> > > 
> > > I don't see any other CVEs that reference that function, but I do see
> > > some that reference the same type of issue in the same file:
> > > 	CVE-2024-27420
> > > 	CVE-2024-27421
> > > 	CVE-2024-27430
> > > are those what you are referring to?  If not, which ones do you think
> > > also should be revoked?
> > 
> > It seems all the CVEs in the range [CVE-2024-27420, CVE-2024-27430] are of the same kind.
> > Shouldn't all be revoked?
> 
> Yes all these
> bc76645ebdd0 ("netrom: Fix a data-race around sysctl_netrom_link_fails_count")
> b5dffcb8f71b ("netrom: Fix a data-race around sysctl_netrom_routing_control")
> f99b494b4043 ("netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout")
> a2e706841488 ("netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size")
> 43547d869943 ("netrom: Fix a data-race around sysctl_netrom_transport_busy_delay")
> 806f462ba902 ("netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay")
> e799299aafed ("netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries")
> 60a7a152abd4 ("netrom: Fix a data-race around sysctl_netrom_transport_timeout")
> 119cae5ea3f9 ("netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser")
> cfd9f4a740f7 ("netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser")
> 958d6145a6d9 ("netrom: Fix a data-race around sysctl_netrom_default_path_quality")

All now revoked, thanks.

greg k-h

