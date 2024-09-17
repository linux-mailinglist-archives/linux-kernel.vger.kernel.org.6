Return-Path: <linux-kernel+bounces-332059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ABB97B4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77EE8B2269B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370D51917E6;
	Tue, 17 Sep 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mf0mxuNp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0713C3D5;
	Tue, 17 Sep 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606036; cv=none; b=LbQ2W4gIX3uhmkqCUNYrIvNac0YRn7BhVDm7YdvQzr+mqF+/K1YwboT8qb0BihfrkEfW6OYCa/j2kR315wptlEWxyKsde1RdFyk3GhQXJnIqwiCFP/pX2QvrE2D2EmfKUA0V8AN6MI1fvCsF0F52A0pgLeBk9tvTN+uuUElLrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606036; c=relaxed/simple;
	bh=xXJ1FrtXW+q9HIjEt0gOAJQgfOWwuPQ54KAxRTajXg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhkoQqwQNQwQx4pFAgU8ZeEGRwI38iDdMMU4lMizjb9t0JTzHdTyduH/K4IHRjVOeyA+ehD4cetI/QJumMU925fG8/tCnTgLL+gLjTIP3JJvb8qITwCFFPPHiWUJfl+/PdCSFoQyMd4Q84sNKItbd4GnVxWYeD+w0S5PHhuGygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mf0mxuNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92181C4CEC5;
	Tue, 17 Sep 2024 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726606036;
	bh=xXJ1FrtXW+q9HIjEt0gOAJQgfOWwuPQ54KAxRTajXg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mf0mxuNpuxhKXGDo2SGLRvbkgYhxd2A3BEXkWcR59dQHQbw3XQtdI0TzxSWDtnSSB
	 hfWf+NbJ6Dqh6Tlfu8Lcwy+zLnWcfgpXoP0J38gTaRig6Ww2+vj5/CymPh5gbVYxxr
	 FNPz3ddatQ0Hpnl/pKPjXhVXok7lE7Ulkr53XEaQ=
Date: Tue, 17 Sep 2024 22:47:14 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
	"dh10.jung@samsung.com" <dh10.jung@samsung.com>,
	"naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>,
	"rc93.raju@samsung.com" <rc93.raju@samsung.com>,
	"taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Message-ID: <2024091758-squeezing-banknote-2704@gregkh>
References: <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>
 <20240916224543.187-1-selvarasu.g@samsung.com>
 <20240916230032.ugw23x7gijamrf5x@synopsys.com>
 <2024091716-snide-mashing-2c21@gregkh>
 <20240917054703.w47rfo7x4lhzgccn@synopsys.com>
 <2024091758-devotion-clutter-29f6@gregkh>
 <da717b2e-e8dc-461f-bef7-d3d9e5df3632@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da717b2e-e8dc-461f-bef7-d3d9e5df3632@samsung.com>

On Tue, Sep 17, 2024 at 09:52:00PM +0530, Selvarasu Ganesan wrote:
> 
> On 9/17/2024 12:38 PM, gregkh@linuxfoundation.org wrote:
> > On Tue, Sep 17, 2024 at 05:47:05AM +0000, Thinh Nguyen wrote:
> >> On Tue, Sep 17, 2024, gregkh@linuxfoundation.org wrote:
> >>> On Mon, Sep 16, 2024 at 11:00:30PM +0000, Thinh Nguyen wrote:
> >>>> On Tue, Sep 17, 2024, Selvarasu Ganesan wrote:
> >>>>> This commit addresses an issue where events were being processed when
> >>>>> the controller was in a halted state. To fix this issue by stop
> >>>>> processing the events as the event count was considered stale or
> >>>>> invalid when the controller was halted.
> >>>>>
> >>>>> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
> >>>>> Cc: stable <stable@kernel.org>
> >>>> Checkpatch doesn't like that format. Fix the Cc stable tag to below:
> >>>>
> >>>> Cc: stable@kernel.org
> >>> What?  Why?  That should be fine, exactly what is the warning that this
> >>> gives?  That should be fine, as it's what my scripts put into patches
> >>> that I create :)
> >>>
> >> This is what checkpatch complains:
> >>
> >> WARNING:BAD_STABLE_ADDRESS_STYLE: Invalid email format for stable: 'stable <stable@kernel.org>', prefer 'stable@kernel.org'
> >> #23:
> >> Cc: stable <stable@kernel.org>
> >>
> >> total: 0 errors, 1 warnings, 0 checks, 72 lines checked
> > Ugh, that's wrong, whatever you want to do here is fine.
> >
> > Someone should send a patch for checkpatch...
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> However I already posted new version with address a typo mistake as 
> well. Kindly review the same.
> 
> https://lore.kernel.org/lkml/20240916231813.206-1-selvarasu.g@samsung.com/

It's the middle of the merge window, I'll look at it after -rc1 is out,
thanks.

greg k-h

