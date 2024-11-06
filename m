Return-Path: <linux-kernel+bounces-397645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAF9BDE7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D393B23087
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB49191F86;
	Wed,  6 Nov 2024 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VudVv6p5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D736D;
	Wed,  6 Nov 2024 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873202; cv=none; b=GMvvWKPvG5NsKOYDYJ7PV3QzJSAzDTVqPU1q6iO6gABo4MQJIouDAnIb07MP2vycu/ePk840QpSfVTXiwcxT2PBqInmlwbs0b8+KvKDbmwIi0zz3ugr/nQPT0zv175CbogkkF/6/Gm5Z48X46MUxWrfPRnyImZ/4Fr42pUDq4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873202; c=relaxed/simple;
	bh=shvgXzW8dVMGYFd5CIjINKxCEvqPGZwVOe3y2HPRXGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3aeWjE1kbONsOr0FldYLBHbG/gOCxX9mXuXDhv3Mx9hhHOD8XT8CHKUwG2dgXCT96bVBPdYt2zmqQhmkdmTZ8Eep2QNviUfM4CfzOYtNZEMSEe7a8dmbbrK8WJmg0s5VlhQyDJByOXSyIlRd5CLcVFKVtTbn47AfGN6d6d8e1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VudVv6p5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730873201; x=1762409201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=shvgXzW8dVMGYFd5CIjINKxCEvqPGZwVOe3y2HPRXGY=;
  b=VudVv6p5aDh4ib9WAVw5Vw/y0SwDNmfQLyWBIxjTALJ0i4j24EJlOr1s
   YbwkSTZs67/UQZkDn2eb0hq4zffekjbeWoIwQvlAEyGxaGFoGQhgcEBO+
   lQ7Vmfp8OTvMNUcfpGXuqixVE/z/ZZcIEWZbSw21/BobLWyjFlbxOWJuW
   IAyhxH6snWl6Ptn/YSsgs1scuQiRfqTQH123iBBU06YMwgcD4EkW2gKYw
   dUB95Vxlezolfa7I8My3OUy3UECi9yT70LuIo7sb0SqaI1PW35IXyZSdM
   hnKWtvYhQIkxk22bNye+AKdRNLHHpK9mQT1mdT9crjC9vkOlKUSqmijgt
   Q==;
X-CSE-ConnectionGUID: AQQBocEgRN2zlgWiXnujow==
X-CSE-MsgGUID: Gu6uFhxnR6O6LFzGdQibfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53218730"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53218730"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 22:06:39 -0800
X-CSE-ConnectionGUID: 4uVEvHwzRYmonJF/SS6/pA==
X-CSE-MsgGUID: KDN4O9z8TT6g6yxRowNChQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="115165065"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 05 Nov 2024 22:06:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 720C71BD; Wed, 06 Nov 2024 08:06:35 +0200 (EET)
Date: Wed, 6 Nov 2024 08:06:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241106060635.GJ275077@black.fi.intel.com>
References: <20241011183751.7d27c59c@kf-ir16>
 <20241023062737.GG275077@black.fi.intel.com>
 <20241023073931.GH275077@black.fi.intel.com>
 <20241023174413.451710ea@kf-ir16>
 <20241024154341.GK275077@black.fi.intel.com>
 <20241031095542.587e8aa6@kf-ir16>
 <20241101072155.GW275077@black.fi.intel.com>
 <20241101181334.25724aff@kf-ir16>
 <20241104060159.GY275077@black.fi.intel.com>
 <20241105141627.5e5199b3@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105141627.5e5199b3@kf-ir16>

Hi Aaron,

On Tue, Nov 05, 2024 at 02:16:36PM -0600, Aaron Rainbolt wrote:
> On Mon, 4 Nov 2024 08:01:59 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> ...snip...
> 
> > Okay, thanks again for testing!
> > 
> > It means disabling adapter 16 in DROM is actually intentional as that
> > is not connected to the dGPU and so makes sense.
> > 
> > > * Boot the system up, nothing connected.
> > > * Wait for Barlow Ridge to enter runtime suspend. This takes ~15
> > >   seconds so waiting for > 15 seconds should be enough.
> > > * Plug in USB-C monitor to the USB-C port of the Barlow Ridge.
> > >   Screen shows in log, screen wakes, but then no signal is
> > > received, and no image ever appears. Screen then sleeps after its
> > > timeout.
> > > * Run lspci -k to wake up the monitors. Once this is run, the
> > > display shows correctly and is stable. Adding another USB-C display
> > > after this also works correctly: It is recognized and lights up in
> > > seconds to show the desktop background, and remains stable.
> > > 
> > > Notice that pre-6.5 kernels work fine with Barlow Ridge, which
> > > implies that new code is causing this. It may be new support code
> > > for tbt capability (and therefore pretty much required). But
> > > regardless, it's still new code. With the current patch, we can run
> > > a udev rule that enables hot plugging that likely always work, or
> > > (worst case) at least empowers the customer to refresh monitors by
> > > clicking a button.  
> > 
> > We definitely want to fix this properly so there is no need for anyone
> > to run 'lspci' or similar hacks but because I'm unable to reproduce
> > this with my reference Barlow Ridge setup, I need some help from you.
> > 
> > You say with v6.5 it works? That's interesting because we only added
> > this redrive mode workaround for v6.9 and without that the domain
> > surely will not be kept powered but maybe I'm missing something.
> 
> 6.5 is *broken*. 6.1 works correctly, but that's probably because it
> doesn't have Thunderbolt support for Barlow Ridge chips at all. I
> suspect this is because the chip is just acting as a USB-C controller,
> and that works just fine without the Thunderbolt driver.

Exactly so while it "works" for this particular case all other cases
will not pass.

> > I wonder if your test team could provide log from v6.5 as well
> > following the same steps, no need to run 'lspci' just do:
> > 
> >   1. Boot the system up, nothing connected.
> >   2. Wait for ~15 seconds for the domain to enter runtime suspend.
> >   3. Plug in USB-C monitor to the USB-C port of Barlow Ridge.
> >   4. Verify that it wakes up and, there is picture on the screen.
> >   5. Wait for ~15 seconds.
> > 
> > Expectation: After step 5 the monitor still displays picture.
> > 
> > If this works as above then I'm really surprised but if that's the
> > case then we can maybe think of another approach of dealing with the
> > redrive mode.
> 
> We'd be happy to run this testing on the 6.1 kernel if it would be
> helpful. Will that work, or is 6.1 too old?

Unfortunately that does not help here. I need to figure something else
how to detect the redrive case with this firmware but first, does this
work in Windows? I mean if you install Windows to this same system does
it work as expected?

