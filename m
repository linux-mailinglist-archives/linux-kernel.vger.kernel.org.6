Return-Path: <linux-kernel+bounces-444736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7E9F0BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6E282DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766651DF277;
	Fri, 13 Dec 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7or+9SF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29082F43;
	Fri, 13 Dec 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091416; cv=none; b=tNDUMXv9JDpMkE9gUUyo1NMyT4bH9wBUAJPD/aYDK9gfE5iHGl6xYjhfrQgpJmmkMKbCSSM6fBtLJV8EmVY0z1bw8zq5ZogviIbx0fEfCVqBgunQSmK+w5GNiCqs33ZrFadUiDtLNVgMsFOeuQ8kz1ij57fSrpfMW/f8CkU4Gvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091416; c=relaxed/simple;
	bh=VPZDE1tgAW6IVz8bUTCuSCddzOXCEvfQpDQW8nTJwek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnlpR4LjUrpXEiIwEkqIwq/3Hfn5jXdgjFcEbu6B+kHM1X7eBAgH/1ok14/mstsgz/c5ePdGGvCIcWoPRiqNxyrv1Uo/l895VCVf5ns8UDz9a8heLhFcV+0fy3STj0xfmmn/G2Bu18OfyniHFzS+96QbspAnUo3O4goh5F6Cs1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7or+9SF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734091415; x=1765627415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPZDE1tgAW6IVz8bUTCuSCddzOXCEvfQpDQW8nTJwek=;
  b=Z7or+9SFxzXQPWj3jFifhKFpzlgj2uuDcn3xmNMsAvo0t0Rk+rZNsCkb
   XpPRFXXpAozdS4ZfSjRqdcBUK3f+gcgwahlwIGQjZD0Ig2z/LAw+miuh3
   JsqAQUF0sRgmDVtsHCTEXqClTPFHVekURNDpJgRET7u3UtWpvAxgvHo+M
   RteoSTVn1SKNJ7nZcgEIMjeCOylNo1L2OVCx9sBL+VYe5L7mar28OGlW1
   SJ5Nl8dYP3pMxa2Bi1E2er57YthIHtnT+LXQn2qYR3unEIgM+QVy32Ma+
   uQ8VKe0cyY2o/2b5Gw6u5Ha683zI+otGAmPjO4D+PQ66jHCoFtV0TZVU7
   w==;
X-CSE-ConnectionGUID: 6InHQJTLRuutgZ3BzPnagw==
X-CSE-MsgGUID: JaGZ9XQcR8eLCNyJn3ebYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="33841247"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="33841247"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:03:33 -0800
X-CSE-ConnectionGUID: DLfubhzLTCa6B+kD96UcHw==
X-CSE-MsgGUID: qq2JYVQESz6EeEenepO6Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="96419492"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 13 Dec 2024 04:03:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B93D22E3; Fri, 13 Dec 2024 14:03:29 +0200 (EET)
Date: Fri, 13 Dec 2024 14:03:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241213120329.GA2788819@black.fi.intel.com>
References: <20241105141627.5e5199b3@kf-ir16>
 <20241106060635.GJ275077@black.fi.intel.com>
 <20241106110134.1871a7f6@kf-ir16>
 <20241107094543.GL275077@black.fi.intel.com>
 <20241111082223.GP275077@black.fi.intel.com>
 <20241112164447.4d81dc3a@kfocus.org>
 <20241114115136.GB3187799@black.fi.intel.com>
 <20241114104125.00a02eb1@kf-ir16>
 <20241115132022.GC3187799@black.fi.intel.com>
 <20241212161257.4110bdff@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212161257.4110bdff@kf-ir16>

Hi Aaron,

On Thu, Dec 12, 2024 at 04:12:57PM -0600, Aaron Rainbolt wrote:
> On Fri, 15 Nov 2024 15:20:22 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > On Thu, Nov 14, 2024 at 10:41:25AM -0600, Aaron Rainbolt wrote:
> > > This is production hardware (specifically Clevo's X370SNW1-G and
> > > X370SNV1-G laptops), available for purchase from Sager, XOTICPC,
> > > Schenker, likely many other resellers, and our own website
> > > at https://kfocus.org/spec/spec-m2.html (with a tool that allows users
> > > to work around the bug). The firmware is baked into the hardware
> > > provided to us by our ODM, and for the sake of stability we do not
> > > modify any firmware on the machines with the exception of applying
> > > BIOS updates provided to us directly by the ODM. They appear to get
> > > their firmware directly from Clevo.  
> > 
> > Okay thanks.
> > 
> > > We have requested an updated BIOS from the ODM. If one is
> > > available, we will upgrade and run the tests again.  
> > 
> > Yes, I hope you can get the firmwares. The one you have now is not
> > "production quality" firmare so you should not really have that there
> > in the first place and Clevo should definitely provide you an
> > upgrade. Note this is separate from the BIOS. But your BIOS has issue
> > too regarding the USB4 power contract that is required by Microsoft
> > so I would expect that you should get that one upgraded too.
> > 
> > The patch I shared earlier should deal with all the other cases except
> > that weird one where we do not seem to get unplugs (and the resource
> > is available) which is not how the firmware is expected to work. I was
> > planning to submit it upstream after some more validation on our end,
> > probably afer v6.13-rc1 is released. I'll CC you.
> > 
> > If/when you get the new firmare I would definitely appreciate if your
> > folks could give it a try.
> 
> Hi Mika:
> 
> Just to catch you up: 
> We find the most recent patch from this thread to be a good improvement.
> 
> We tested it on our hardware with USB-C attached displays. In
> particular, it allows us to enable displays that do not time out while
> using with Thunderbolt. Without the patch, enabling the Thunderbolt
> kernel module would disable all attached USB-C displays in 15 seconds.
> 
> The patch does not resolve the hot plugging issue on our hardware, but
> we have a work-around for that (lspci -k or reloading the thunderbolt
> module). We have not been able to acquire new firmware yet, so this is
> likely the issue.
> 
> The test results are attached if you are interested.

Thanks for testing!

You probably noticed, I sent out a formal patch here:

https://lore.kernel.org/linux-usb/20241211103529.2302706-1-mika.westerberg@linux.intel.com/

You are Cc'd. I wonder if I can add your Tested-by tag to it?

