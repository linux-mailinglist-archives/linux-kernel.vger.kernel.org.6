Return-Path: <linux-kernel+bounces-535720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C5A47665
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B5A1888BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC2D21C9F4;
	Thu, 27 Feb 2025 07:18:57 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67C189BB0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640737; cv=none; b=f8byjh8v7dzRx4c1grXEBjn1akrNUhufnnNLSio2AjKvF5TnREPMSeHsBlQM0D7jg0fjlhZnJvSbR/TWtY5j3kL1lVXJfUwfNl4oG71EvOf3ziChxM00ypchju7mjzpfLDjvXmVUazq1D2Ezz9ZwX8ywpZsSdoYYnYVSIkVz08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640737; c=relaxed/simple;
	bh=VIP/tA+0gkM1g/bBuzM+N6UsjKn8Y3R/wOwMCFFITUY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3e2nuwP9HgRJbXZS0SmDRt0wwmLBqNQSRE0c2SOuYplARv29QqvEAbPHUdqde4kqJvSNhk/McOXRhrLv1OAFk2uwc/jxIyQVmtdfEfioZoAVHeOyXIDEC3zILFCMYZQm5QXi+zCRCpvMGrhUWIs+TT0MdanTM0+gBGW0Tmf2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 14e8d78e-f4db-11ef-83b3-005056bdf889;
	Thu, 27 Feb 2025 09:18:46 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Feb 2025 09:18:45 +0200
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lee@kernel.org,
	giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] pps: generators: tio: split pps_gen_tio.h
Message-ID: <Z8AR1Qq0F_e8PjBl@surfacebook.localdomain>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-2-raag.jadav@intel.com>
 <Z78M5iTHgdHnqbz2@smile.fi.intel.com>
 <Z7_zW3rlWtZZ7BiM@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7_zW3rlWtZZ7BiM@black.fi.intel.com>

Thu, Feb 27, 2025 at 07:08:43AM +0200, Raag Jadav kirjoitti:
> On Wed, Feb 26, 2025 at 02:45:26PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 26, 2025 at 11:45:24AM +0530, Raag Jadav wrote:

...

> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/hrtimer.h>
> > > +#include <linux/pps_gen_kernel.h>
> > > +#include <linux/spinlock_types.h>
> > 
> > This missing time.h and types.h.
> 
> Aren't they guaranteed by hrtimer.h and spinlock_types.h?

Nope, why? HR timer is only for HR timer specific definitions and APIs, how
does they are related?

time.h due to NSEC_PER_USEC (or what was there?) and types.h due to u32.

-- 
With Best Regards,
Andy Shevchenko



