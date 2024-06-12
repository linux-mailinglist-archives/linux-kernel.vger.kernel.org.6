Return-Path: <linux-kernel+bounces-211764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD2A905688
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622BC1F2524D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7A181D1B;
	Wed, 12 Jun 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7r/Zs9H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551717F502
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205005; cv=none; b=IC0ocESZf+PpPMRyQFSlVrKNzK3PSqJ/lNujZ9GX+RhgI8Fn+BEUfY8Q4iUKYNwuP34gu19brfD3R4AZFySpaqDUYrA2nUf6I+LdMTUZx6LQzDy3hvg9Pamq6cGyEpnIw7/4tUyO5B1RJdF+Df6pLbFdIddOxqORO3DD2NDjhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205005; c=relaxed/simple;
	bh=ZuEtNZwwOHtkdd1OwgkAj9rzmJGCtDmVV3FUpnzB+QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEbPXEEeGn6qIsQORQOyt4mybY+M1zhBRwqb9gO+6kzhna1zVkY4aoOoXw8nxUOGo04FYeqc6xTOIh+L/FuEtHqqwLbh8JHAv3/SXMD2v9kaIkXmRam6iJMvn7dKt8M0tBb2TR4MyQoTaHdqRVp4Q38ok0tCMwj4kG1i7FgtitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7r/Zs9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB9C116B1;
	Wed, 12 Jun 2024 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718205005;
	bh=ZuEtNZwwOHtkdd1OwgkAj9rzmJGCtDmVV3FUpnzB+QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7r/Zs9HIew4lkEhYW3pw+95q83DX4q0OmpjzxrgLFwyKblFd3mnD3y5TVEILW2Yc
	 2HuukgnaTOBLnFu6Of+pE7zBQcB03dcii9IWgRiWEz+67YFKmV6plqDmc4uWNAtzwj
	 ZVw9Ffl2Y65cNuk5v6fToWCMr4JOojnRCWb2Bj0E=
Date: Wed, 12 Jun 2024 17:10:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v6 1/2] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <2024061248-scanning-backlight-da0f@gregkh>
References: <20240611174716.72660-1-jose.souza@intel.com>
 <49c2fbdc91d128c5249d50d016d97c8e5162f7b7.camel@sipsolutions.net>
 <Zmm2jC2nx6gZ2WOn@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmm2jC2nx6gZ2WOn@intel.com>

On Wed, Jun 12, 2024 at 10:54:04AM -0400, Rodrigo Vivi wrote:
> On Wed, Jun 12, 2024 at 02:02:37PM +0200, Johannes Berg wrote:
> > On Tue, 2024-06-11 at 10:47 -0700, José Roberto de Souza wrote:
> > > Add function to set a custom coredump timeout.
> > > 
> > > For Xe driver usage, current 5 minutes timeout may be too short for
> > > users to search and understand what needs to be done to capture
> > > coredump to report bugs.
> > > 
> > > We have plans to automate(distribute a udev script) it but at the end
> > > will be up to distros and users to pack it so having a option to
> > > increase the timeout is a safer option.
> > > 
> > > v2:
> > > - replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh)
> > > 
> > > v3:
> > > - make dev_coredumpm() static inline (Johannes)
> > > 
> > > v5:
> > > - rename DEVCOREDUMP_TIMEOUT -> DEVCD_TIMEOUT to avoid redefinition
> > > in include/net/bluetooth/coredump.h
> > > 
> > > v6:
> > > - fix definition of dev_coredumpm_timeout() when CONFIG_DEV_COREDUMP
> > > is disabled
> > 
> > Got to v6, heh.
> > 
> > I still don't think this is _right_, but I guess I'm OK with giving you
> > rope to hang yourself ;-)
> 
> I do see your point. But with the udev in place, 5 min or 1 hour it shouldn't
> matter right? But for users without the udev script then a long time is better
> to react and learn how to capture the very first GPU hang information.
> 
> > 
> > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Thank you
> 
> > 
> > Seems like you really should've CC'ed Greg though since these things
> > usually went through his tree, so if you want to take them through yours
> > he really should be at least aware ...
> 
> Indeed
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Greg, ack on getting it through drm?

Fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

