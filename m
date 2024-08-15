Return-Path: <linux-kernel+bounces-287893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD705952DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA1F1C237C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0B1714D5;
	Thu, 15 Aug 2024 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4rGX2IU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAC146A6D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723341; cv=none; b=EOHb4b1Ci+5rLCZLGgWVwIuJnI8Y2XYC6xarQbLlnOxCyzpuiJOqoaQxuuluiVDDlTOayVOWmMIyd7yNQm8aqGwhxmlNyfuT0u8iP1nQjTvhy+FiSnYPsF+JbAhG1zDsb51PHWS3FBhMyxuMg6W1N3lNIPOTBZa5m9JMEmcm/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723341; c=relaxed/simple;
	bh=7w2WAn9we+FD6ex2wl3Xn3ZqIPU69CfzpP3JIvlQ1uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxRck86abGEYb/kAULjZljAv4YxBKpjnAEE0+kqzAVLxiR6yVgO6OTiy1sKBfuQhwo4pYb8coR3NLnC9VM3ehMhL2tdfzrgLr8FwCKwSa3BeiiRr+KJ6ZpM4u25/pKshnx5m1z+4p8dW7Y4TuQf+UYXcIU8qc/B7cvY0Fb4lK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4rGX2IU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723723340; x=1755259340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7w2WAn9we+FD6ex2wl3Xn3ZqIPU69CfzpP3JIvlQ1uA=;
  b=R4rGX2IU9Yb+bhITEoT4etGR92+rIdkymOTyot/SddcoQ6DaOCghRdPh
   B7SP6R7VQp9oG5/kd8pKuge7g4qRC9Etl+HqnT6XInIiCsZFJvZnKj+ht
   STrXJ2tLXdmuPnDu17Lm5bSA2cE7cCcn5asawS5oTtXCLeK8sgwm8h4x9
   orbcPXu7yIaEcJZ1CZb70ePaXpwsZAGT25FsrseA5xyC83efVciAIypdw
   7Hn0/Syo/+bd0wjDzcZu+L5Ury+DnF4VLIozF+71Rjv5ICIT7ANZdbuNU
   QXrvyDjkQhTN/mlQbGZjkNM6sr5ZnV98DY6qyD7Si3kdAai95I57NyOJY
   A==;
X-CSE-ConnectionGUID: e4aylezPTFK2T//GReR2Qg==
X-CSE-MsgGUID: LThtqvN3Ss+OsnMPX8lCYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22108620"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22108620"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:02:20 -0700
X-CSE-ConnectionGUID: 7EqQnAK0TomwmR2fczP8uA==
X-CSE-MsgGUID: lRRRWmGbRk6GO2DkjkO1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="82533379"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:02:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1seZBD-0000000FXmp-2vKJ;
	Thu, 15 Aug 2024 15:02:11 +0300
Date: Thu, 15 Aug 2024 15:02:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Baojun Xu <baojun.xu@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, robh+dt@kernel.org,
	lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
	v-hampiholi@ti.com, v-po@ti.com, niranjan.hy@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v11] ALSA: hda/tas2781: Add tas2781 hda SPI driver
Message-ID: <Zr3uQ7jdtxqF1FlB@smile.fi.intel.com>
References: <20240727085048.1092-1-baojun.xu@ti.com>
 <87ikw25f11.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikw25f11.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 15, 2024 at 11:08:58AM +0200, Takashi Iwai wrote:
> On Sat, 27 Jul 2024 10:50:48 +0200,
> Baojun Xu wrote:
> > 
> > This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
> > It use ACPI node descript about parameters of TAS2781 on SPI, it like:
> >     Scope (_SB.PC00.SPI0)
> >     {
> >         Device (GSPK)
> >         {
> >             Name (_HID, "TXNW2781")  // _HID: Hardware ID
> >             Method (_CRS, 0, NotSerialized)
> >             {
> >                 Name (RBUF, ResourceTemplate ()
> >                 {
> >                     SpiSerialBusV2 (...)
> >                     SpiSerialBusV2 (...)
> >                 }
> >             }
> >         }
> >     }
> > 
> > And in platform/x86/serial-multi-instantiate.c, those spi devices will be
> > added into system as a single SPI device, so TAS2781 SPI driver will
> > probe twice for every single SPI device. And driver will also parser
> > mono DSP firmware binary and RCA binary for itself.
> > The code support Realtek as the primary codec.
> > In patch version-10, add multi devices firmware binary support,
> > to compatble with windows driver, they can share same firmware binary.

> Now it's v11, and I'd love to move this forward finally, instead of
> hanging forever.
> 
> The HD-audio part looks more or less OK, but I'd need acks for the
> ACPI and serial-multi-instance parts below.
> 
> Put ACPI and serial-multi-instance maintainers to Cc.
> Rafael, Hans, let me know if that looks OK to take.

FWIW, the ACPI ID part is legit, if the requirement to include it to those
tables, it looks good.

-- 
With Best Regards,
Andy Shevchenko



