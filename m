Return-Path: <linux-kernel+bounces-397616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290879BDE13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521C41C22B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C5418FDAA;
	Wed,  6 Nov 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x29LmFiN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6413541B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 04:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868824; cv=none; b=DaTZzuADNUVe9j9H7nvRjMXh+HytVuZWaWFNrwNLONmGJHWBwBp+3QrMfBCyCxX3XYvxI4+uoNV1iKvP9lGb6ED0N//mhA/72Hmh+lWrHGCkaXyibwm+GHpRIu2CJT91F/le3ZHU8m4iNAu2D1/8sI6NZs5h2wcVDoGtWPRb+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868824; c=relaxed/simple;
	bh=4YVetbvTRgTI2jTk3FjP1rXgmZp21K8WyHb/v5VgJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/GOC0qtXEQq5HwPeVebF3Qst+Q3sCKZbcuSrnvsHZVpD9oGyU3IJZK8zcKJFuhnvgQ95Nq3tWqxTSUVgDUyJ6pMK1ojugdiVlBTP0kbq0+ipmTJ4VVSrkxwayVNEBqoEKCLSHSNCBaKHB3qQgxrxP+7GQIqJswGc4gLKLzXpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x29LmFiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060FDC4CECD;
	Wed,  6 Nov 2024 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730868823;
	bh=4YVetbvTRgTI2jTk3FjP1rXgmZp21K8WyHb/v5VgJN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x29LmFiNhHJaCCKcfLAaDCFl2j6Nkb8q9fR8KPtZ3chK2dwwFvCwVMlRfgatUarnY
	 ZixXOHz8ARxlw/UMvG3cu+BBHvHaTVyx/ADhdDchiV1kQbyL1RKnavaPYceXxniBNp
	 Hun0pYi3DPNS4wmVoglUITqdB5/0FxWg8XNnvUbU=
Date: Wed, 6 Nov 2024 05:52:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Francesco <francesco.dolcini@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize
 cycle detection logic
Message-ID: <2024110644-material-paternity-242f@gregkh>
References: <20241030171009.1853340-1-saravanak@google.com>
 <CAGETcx9MZbvg0ikfsWpJXYw=UzUjv3PerzN4RL1VFMjitBtYXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9MZbvg0ikfsWpJXYw=UzUjv3PerzN4RL1VFMjitBtYXw@mail.gmail.com>

On Tue, Nov 05, 2024 at 05:30:20PM -0800, Saravana Kannan wrote:
> On Wed, Oct 30, 2024 at 10:10 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > In attempting to optimize fw_devlink runtime, I introduced numerous cycle
> > detection bugs by foregoing cycle detection logic under specific
> > conditions. Each fix has further narrowed the conditions for optimization.
> >
> > It's time to give up on these optimization attempts and just run the cycle
> > detection logic every time fw_devlink tries to create a device link.
> >
> > The specific bug report that triggered this fix involved a supplier fwnode
> > that never gets a device created for it. Instead, the supplier fwnode is
> > represented by the device that corresponds to an ancestor fwnode.
> >
> > In this case, fw_devlink didn't do any cycle detection because the cycle
> > detection logic is only run when a device link is created between the
> > devices that correspond to the actual consumer and supplier fwnodes.
> >
> > With this change, fw_devlink will run cycle detection logic even when
> > creating SYNC_STATE_ONLY proxy device links from a device that is an
> > ancestor of a consumer fwnode.
> >
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com/
> > Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of overlapping cycles")
> > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 55 ++++++++++++++++++++-------------------------
> >  1 file changed, 24 insertions(+), 31 deletions(-)
> >
> > Tomi,
> >
> > Thanks for all the testing and debugging help! And do use
> > post-init-providers even with this patch to improve ordering
> > enforcement. I probably should change the cycle log from info to warn in
> > a separate patch :)
> >
> > Greg,
> >
> > I no longer have concerns about pulling this into 6.13. But we can give
> > a week or so to Geert/Francesco to do some additional testing.
> >
> > Geert/Francesco,
> 
> Heads up. Greg has pulled this into driver-core git's
> driver-core-testing branch. Which means in a week or two it'll get
> into the actual driver-core-next branch. So, if you want to do
> additional testing, you might want to jump on it soon.

It should now show up in the next linux-next release.

thanks,

greg k-h

