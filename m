Return-Path: <linux-kernel+bounces-412681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43289D0DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C68F1F21068
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612F1922F8;
	Mon, 18 Nov 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3c7qERs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF49149E0E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924343; cv=none; b=NA2xHkX5KOwJrJOYdySnZ4wjBnMWZp/t0cvc7pLxgceZpWwox+b7sGaN/Y52O9gDwvOB29CguMEmXQp3l8vU8Y3rM0xAVsAM5bqYwItytlql3HUKsGd9jKtQMljBu04BGRo4xaxPnOaYsqkNfmF7CCtOlzui/StrIjjiDjPqtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924343; c=relaxed/simple;
	bh=+IjAqM/JtXedokZUJdxLuGPUD4vJBzAILgt9ldTPKv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKrjKXw36w/ZyjkEaw91IrRmJ5uuRTHs2puZS5GhdKpgcw/jvfg7zE/BSsynYn44OArDbLxrDZP9CiBDiLQbnl7p9ge+sygsRLEc27HzATIkKNSEJcrb/+O4crThnH4XjiX88pMiabedJg+OYTZIHnv+yNtjFr5F61xVH5fSTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3c7qERs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731924341; x=1763460341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IjAqM/JtXedokZUJdxLuGPUD4vJBzAILgt9ldTPKv8=;
  b=d3c7qERsDYuZrnghIRITfqHBALrMdKULkYcywe9cUIONchgTgEzWWHUt
   os9XcBKBAoDjL6SIoyBqL76vQbg0fbeKLlCh/OleNbHTD+oxFj+OzKowc
   vzxE2ZalfV5YsiNPGHl5X11CGe4GwaSSqs3nW3bnrT2tRu3DrLg1DaiW6
   gm2FmUl/aZXMCEJnxaWJ+65HXD/+158I4juvSgSE67QpffT3LO4rklEKc
   doac2sds9SX9KHGRaDOSxHNRx+upDw0SPg76UO7Kqvyz7PK85bng5eCoj
   9H3OwkWe2WO9eEiEn7c1RI233gLIIL3WstZMP3tSoM3MydXyPgLjRpfPq
   g==;
X-CSE-ConnectionGUID: jOsWdENgSHS8iP1VrezRrg==
X-CSE-MsgGUID: wV+ybaTDSC+5Z6r0BW/k8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42503875"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42503875"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 02:05:40 -0800
X-CSE-ConnectionGUID: GLB+QisCRjGS46NNE1GXzw==
X-CSE-MsgGUID: QGVM8EdMTI6dh2eTFLLbvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="94125549"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 02:05:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tCydT-0000000Fxjn-2gYd;
	Mon, 18 Nov 2024 12:05:35 +0200
Date: Mon, 18 Nov 2024 12:05:35 +0200
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
Message-ID: <ZzsRb4yXszugcLf8@smile.fi.intel.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <ZzT7SPpBzOYxcjbH@smile.fi.intel.com>
 <30cb9109-baa0-4080-8fb0-fe535932377b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30cb9109-baa0-4080-8fb0-fe535932377b@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 16, 2024 at 12:34:54PM +0100, Hans de Goede wrote:
> On 13-Nov-24 8:17 PM, Andy Shevchenko wrote:
> > On Wed, Nov 13, 2024 at 05:33:41PM +0100, Hans de Goede wrote:

...

> > That said, messing up with that address is most likely a problematic there.
> 
> The relocation also happens in the provided working dmesg. I agree that
> the relocation is weird, but that does not appear to be the issue.

Hmm... I'm then wondering why we can't just unhide the device once at the early
boot (via [x86 specific] PCI quirk) and live with that... My most worries were
about relocation, but currently reading the documentations I see that this
shouldn't be a problem as the lowest 3 bytes define the target address on the
backbone anyway. I.o.w. it shouldn't matter what is written in the bits 63..24.

And FTR, I haven't found any specifics for Denverton, it's just an early
generation of P2SB RTL, but documentation says it should work as the others
on a basic levels (like what we expect from it in the Linux kernel).

> At least it was not an issue before we switched to caching the bar
> returned by p2sb_bar() early on so that p2sb_bar() does not need
> to take looks.

Anyway, it's easy to check just by caching the initial value of 0xfd000000
and see if it helps.

Another point here is the power management. Is there any PM handling during
the resource (re-)assignment? It might put the whole piece to D3hot and make
it not working. But I'm purely speculating here...

-- 
With Best Regards,
Andy Shevchenko



