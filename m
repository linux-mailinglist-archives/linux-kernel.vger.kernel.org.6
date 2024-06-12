Return-Path: <linux-kernel+bounces-211076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B035904CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3541B23D80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8AF169ACF;
	Wed, 12 Jun 2024 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAtkH9f4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09892167270;
	Wed, 12 Jun 2024 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177296; cv=none; b=iElQ3+4syZPYOngv423kyTgWXo/YVLI7IJR/KSg6AwvS0IhpkkqQEPMiYxzo6a/rSwZI2gqQgVbIe33B4pe9aR/QhUqSzPfFACOgUw4mfOuSdzSoSU4NavkhyyHPiaJ3fDc8QVhrufh98w8/oKV13r2+WXkUz1LdlXTNr/d0rWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177296; c=relaxed/simple;
	bh=OINFqR0m9qTBB2evRLkOh/KF43W/Ig7Ub6ACgHyZnCw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GuNXjjRjMReN8PUg5bUI9OtgK+ajSm7BBDQ7MF8iqXU6u/0ghZcbEjXUn3b+/HISWSPITS03Ziqc0sYWWmq+q2Uo0tS0Nv436pfIAVuez+/Q9O026YstILXRK802XX0KQA0e2uMa8lUF4X9/9mDiniW4nXh11hdcLtdceWf0pyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAtkH9f4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718177295; x=1749713295;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OINFqR0m9qTBB2evRLkOh/KF43W/Ig7Ub6ACgHyZnCw=;
  b=ZAtkH9f4XLCatNKGB6E1KtwqdqUSTDoDv1fQFauWUNYMBlASyvgnzdeu
   K23rusFCzLC6xXTpcKFH6y2a312jW3am7BnF19Nz3X+KNYU9amn1GA306
   WO4p2H0Sgeh9x1UH7offnjnQDBNaYSNWWlAW1LypZaoZNhR1Nc6lydEWv
   G5pmoO1CvC6Yuj5iC8gVuoTRGP1Uqg1nfFVVL58JPbS6rGOOqOvzm05Vh
   GXLDPpaLxUnkhv+XPduteItRmAKZhpi0cEcVKuy5HlTOwdxu+QO4w8s60
   ZGN4yXaLKIhNJBeLd8vQnwxUoqFjXO7+FveJ75IZgu7ygg3jbw6w03x4h
   Q==;
X-CSE-ConnectionGUID: ekdBCSkPRk+9li5Nfmak0Q==
X-CSE-MsgGUID: H49Uyl6iQuOZ0a1XyeKSOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14649308"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14649308"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:28:14 -0700
X-CSE-ConnectionGUID: fq3kvE2WR7uapVrS4pFk4g==
X-CSE-MsgGUID: 8hrHmmwDRzO2V+ClaDy/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39806557"
Received: from unknown (HELO localhost) ([10.245.247.204])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:28:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 12 Jun 2024 10:28:06 +0300 (EEST)
To: Shravan Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
In-Reply-To: <DM4PR12MB5136EAD83A50869388E96FF3C0C72@DM4PR12MB5136.namprd12.prod.outlook.com>
Message-ID: <370b5e44-cf92-21af-8c01-dbb208bf323f@linux.intel.com>
References: <cover.1716205838.git.shravankr@nvidia.com> <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com> <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com> <DM4PR12MB513695D2BE98AA46A95B4C60C0FF2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <33f25d4f-386c-6df6-344d-8b7aa011e69c@linux.intel.com> <DM4PR12MB5136EAD83A50869388E96FF3C0C72@DM4PR12MB5136.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Jun 2024, Shravan Ramani wrote:

> > > When 2 32-bit counters are coupled to form a 64-bit counter using this setting,
> > > one counter will hold the lower 32 bits while the other will hold the upper 32.
> > > So the other counter (or syses corresponding to it) also needs to be accessed.
> > >
> > > > For 64-bit counter, I suppose the userspace is expected to read the full
> > > > counter from two sysfs files and combine the value (your documentation
> > > > doesn't explain this)? That seems non-optimal, why cannot kernel just
> > > > return the full combined 64-value directly in kernel?
> > > 
> > > I will add more clear comments for this.
> > > While it is true that the driver could combine the 2 fields and present a
> > > 64-bit value via one of the sysfs, the reason for the current approach is that
> > > there are other interfaces which expose the same counters for our platform
> > > and there are tools that are expected to work on top of both interfaces for
> > > the purpose of collecting performance stats.
> >
> > > The other interfaces follow this
> > > approach of having lower and upper 32-bits separately in each counter, and
> > > the tools expect the same. Hence the driver follows this approach to keep
> > > things consistent across the BlueField platform.
> >
> > Hi,
> >
> > I went to look through the existing arrays in mlxbf-pmc.c but did not find
> > any entries that would have clearly indicated the counters being hi/lo
> > parts of the same counter. There were a few 0/1 ones which could be the
> > same counter although I suspect even they are not parts of the same
> > counter but two separate entities called 0 and 1 having the same counter.
> >
> > Could you please elaborate further what you meant with the note about
> > other interfaces above so I can better assess the claim?
> 
> When combining 2 counters using the "use_odd_counter" setting, the mechanism
> of joining them or assigning upper or lower 32 bits to a counter is handled in HW
> and not by the driver. For example, if bit0 of "use_odd_counter" is set, counter0
> and counter1 (which were originally separate counters) automatically become
> the lower and upper bits of one 64-bit value. The user needs to read both these
> sysfs separately to get the full 64-bit value. The driver does not do any special
> handling for such cases, merely provides access to both counter0 and counter1.

I know all this by now, but we're discussion here is whether kernel should 
do "special handling". Although, it's not really correct to depict 
representing 64-bit counter in its entirety as "special handling".

I think the kernel should combine the 64-bit halved and you argumented 
it shouldn't. When I went to confirm the claim your argument was based 
on, I couldn't find on what basis the claim was made.

> Since the events supported by the blocks are quite HW centric and low-level in
> nature, the driver is generally used alongside various tools which work on top of
> this driver to collect telemetry info and provide more readable statistics to the
> end-user. Similar to this driver, there are other FW interfaces providing access to
> these counters (same and other additional ones as well that belong to other HW
> blocks). For the sake of consistency and to allow the tools to be compatible with
> all interfaces, the counter data needs to be accessible in the same way, ie, as 32-bit
> upper and lower values in counter0 and counter1 sysfs as in the above case.

This does nothing to answer my question. Where in the kernel, there's an 
example where a 64-bit counter for BlueField platform is presented as 2 
32-bit counters? If there isn't any examples in the kernel, your statement 
about consistency within the platform doesn't hold water, quoted (again) 
here for clarity what I'm refering to:

"The other interfaces follow this approach of having lower and upper 
32-bits separately in each counter, and the tools expect the same.
Hence the driver follows this approach to keep things consistent across 
the BlueField platform."

Where I can find those "other interfaces" that already follow this 
convention?

-- 
 i.


