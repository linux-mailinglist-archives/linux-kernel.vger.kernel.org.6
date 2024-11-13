Return-Path: <linux-kernel+bounces-408212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015129C7C10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A498B26C74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DAA202F93;
	Wed, 13 Nov 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqJtQ06a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F6A13D2B2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525456; cv=none; b=GLUlez/slCSz7aSLvChwJupTQ1EJKJUgWikEoen56uj+5a6hIrsI/0z1Om3mpwBtv5oNJajYfkXqBgdwXGdeOhVRYvaLCnMERHpx6U7P1ec45QjFcyP4bLXk1gZ6gxPsIApRzxtDUUmB2QinAQ/jMQzrODWhTZZeRX0AlzCDhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525456; c=relaxed/simple;
	bh=LDqZoBmYvA2s9t50N2mkpkVQEh2nVZuaspA/yTcGyM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcLCK5NhcowlU0a8bkXUdVGlYvxZJsEaIoIjzL8ttd1PFT8wqlm+BDWtJnVQWu05Skh3SYaVQYmEWlcHUBxM/n2NMhQ6LO+otzcNgQ0WRqurwWDAXG6i2O8rdj0aWw1propqhI+K6ds73/hdhQHlnTJ5uBxdf0s35SCz1RyWdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqJtQ06a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731525455; x=1763061455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LDqZoBmYvA2s9t50N2mkpkVQEh2nVZuaspA/yTcGyM0=;
  b=kqJtQ06aiLpMawwtq1iXRA1EC0O9F++MQTydEM0PL+u7Bbdx5RzfNg0r
   G9jUfj+R4fnwjus0/w8JRFFI9F8CWM4AD1ATHvjnNZAtUn8+xDC2TBw5P
   uMybJjlVfCewl5zhWozYDV31JcdjIsn/S0p27oWASCZ9bJ9GIjH+gtjl4
   02hxTiXJ1izNTI3VfS1UCmxfdBKHQsdV36GfyOa8Hro0J4nzXkghCOFvW
   FA8Pak2kWb43ToYaXTMdkRuI1soGrU42hDUukBAxHXTQy4OFLHd4K8b7c
   6aEEBGO93ooHb8auSNAtK565g3PodkieZPsQs9CC0gH1savIxl+PnAlMS
   g==;
X-CSE-ConnectionGUID: hHh/f7dhSgecSGbPuDwPJg==
X-CSE-MsgGUID: 2x+wCPliTyyIu9oliIGR3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31676741"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="31676741"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 11:17:34 -0800
X-CSE-ConnectionGUID: s/5fTNljRUuctSpqjcdlJA==
X-CSE-MsgGUID: WHYoqsw7QKWrgdkZ/7m2bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92011999"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 11:17:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tBIrp-0000000ESBN-0LF6;
	Wed, 13 Nov 2024 21:17:29 +0200
Date: Wed, 13 Nov 2024 21:17:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <ZzT7SPpBzOYxcjbH@smile.fi.intel.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 13, 2024 at 05:33:41PM +0100, Hans de Goede wrote:
> On 13-Nov-24 5:24 PM, Hans de Goede wrote:
> > On 13-Nov-24 4:42 PM, Daniel Walker (danielwa) wrote:

> >> I bisected an issue of a missing pci device to commit 2841631 the commit title
> >> in the subject line which was included in v6.1 stable branch.
> >>
> >> There was a later fix for a similar missing pci device commit 36c676e2 which
> >> appears to be for Goldmont/Apollo Lake. The hardware I'm using is
> >> Goldmont/Denverton. This fix did not appear to change the behavior I'm seeing.
> >>
> >> The pci device which is disappearing is a custom gpio device.
> >>
> >> I tested v6.12-rc5-next to see if any other changes had fixed the issue, but there was
> >> no change in behavior since commit 2841631 .
> >>
> >> When booting up the device is shown in the pci boot messages but the device
> >> doesn't end up making it to lspci once you get to a prompt.
> > 
> > Please give the attached patch a try, this will hopefully fix things.
> > 
> > Once I have confirmation that this fixes things I'll post it to the list.
> > 
> > Note this will not backport to the 6.1 stable branch cleanly due to
> > changes in the x86_cpu_id macros in mainline. Backporting it should
> > be trivial. Please send a backport to stable@vger.kernel.org yourself
> > once this has been merged upstream.
> > 
> > If you backport this, please also backport 36c676e2 first.
> 
> Never mind, self nack. This is correct for Gemini Lake which
> has its SPI at device.function 13.2 like Apollo Lake.
> 
> But looking at the dmesg Denverton actually has it at 1f.1
> aka 31.1 like most other Intel SoCs.
> 
> Which make me wonder why this does not work on Denverton.
> 
> It probably has something to do with these 2 messages:

> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window
> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned

As I tried to explain in the very first commit that brings the whole driver
into the kernel the P2SB mimics PCI device but actually doesn't provide all
PCI capabilities. The BAR address there is basically a protocol between
firmware and OS which gives the OS the first (most significant) byte of the
address space window of 16Mb that P2SB responds to in HW. So, I haven't
tested if the relocation actually works for this device, esp. if it goes
over 4G boundary.

That said, messing up with that address is most likely a problematic there.

> I'm guessing that this re-assignment is messing up
> the p2sb BAR caching, after which things go wrong.
> 
> Daniel, are you seeing similar messages with a working kernel ?

-- 
With Best Regards,
Andy Shevchenko



