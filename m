Return-Path: <linux-kernel+bounces-295834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302B95A1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B81E1F26FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343711B5303;
	Wed, 21 Aug 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0I0mq7V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180431B3B39
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254939; cv=none; b=BYBWRcLnCMYxTK27s91yQjd4K3JIo789OVh6ieek5xzLWBzJlKhgHhuC9yRAMGBymrJhrLXtnCYz9I5jfpQ2Sp6YGMQ9d5tLuj5bJUP3DJG594l5Ycm6UsXeF/b51og9z7X8rR0TU2Ke3Un2mOJSsqgQ/eYYNJys++aIJJlYQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254939; c=relaxed/simple;
	bh=5HNsShXLMkfgPjD1JIyF6BszZjPotlrn/B9b0UL22AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVFN/v0eMpIvdmYai06veKkGKrdj+7ie8PIoclbYB9bhYpHYOSqhs18XADnQ1f3BaF4ZiKFpXhlAsLQrrVk6iEF7heb0WNf5XNxsa6o6FYxQarmfDGIKmuMNkDaCpC7P0IrDeOKf2W0f88aCtcD2oj0M+2uIbCAWYphbLkD2pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0I0mq7V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724254937; x=1755790937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HNsShXLMkfgPjD1JIyF6BszZjPotlrn/B9b0UL22AE=;
  b=S0I0mq7VlGJD/jK7yhQxcMSJ2JKnB57ZvAPP3ZY/bFOUA2tkq3KBEBTD
   8o4HiLBPYsWNdig5LU2QdX7zjvksDRstoVSfS7JhHz262cI+KmdoI9WUL
   7IsRBquOP+YNJceqvFytWyWqMURnkNHudenecQ80zZCc34DeZjMsKmHv1
   0aCfIMy2XhZ2j/pLBZsp93BpowfXOve6nr+om1+BbDjaVjO8KK0l69cly
   jOf0ppBAjWBKRlJ2yPgqzlAyi7+A0kG6Cbr75BrIH+npAfE59mrlIMPTt
   3blWgnx0C0zOUybNut5EiUMmDr9Ulq/BdWaAL5mHSLg2LTqPja7i16vRc
   Q==;
X-CSE-ConnectionGUID: U0TKevGURviSqUJvkZOiOQ==
X-CSE-MsgGUID: GOvB35MCQceVDsz/CwG7tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22429926"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22429926"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:42:16 -0700
X-CSE-ConnectionGUID: Jpy8QNnmQduNWlIAy0UE+A==
X-CSE-MsgGUID: jPd31TVuStmXPhrLtOfnNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61878949"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:42:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgnTR-000000008AO-0I9O;
	Wed, 21 Aug 2024 18:42:13 +0300
Date: Wed, 21 Aug 2024 18:42:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the
 I3C Support List
Message-ID: <ZsYK1P5nW5e1U1mJ@smile.fi.intel.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
 <9584ddb0-6e39-4d04-9242-a68eb4b86eba@amd.com>
 <ZsXyHfLJ8SJOW0RF@smile.fi.intel.com>
 <236aa6d9-bb5d-4854-86e3-5473f5ea6337@amd.com>
 <ZsYKGOLN3_2VU6Ld@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsYKGOLN3_2VU6Ld@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 06:39:04PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 21, 2024 at 08:42:12PM +0530, Shyam Sundar S K wrote:
> > On 8/21/2024 19:26, Andy Shevchenko wrote:
> > > On Wed, Aug 21, 2024 at 07:07:45PM +0530, Shyam Sundar S K wrote:
> > >> On 8/21/2024 19:05, Shyam Sundar S K wrote:

...

> > >>> This update adds the AMDI5017 ACPI ID to the list of supported IDs.
> 
> s/This update adds/Add/
> 
> > > Please, provide a DSDT excerpt to show how it will look like in the ACPI
> > > tables.
> > 
> >     Scope (_SB)
> >     {
> > 	...
> > 
> >         Name (HCID, "AMDI5017")
> >         Device (I3CA)
> >         {
> >             Method (_HID, 0, Serialized)  // _HID: Hardware ID
> >             {
> >                 If ((I30M == Zero))
> >                 {
> >                     If (CondRefOf (HCIB))
> >                     {
> >                         Return (HCID) /* \_SB_.HCID */
> >                     }
> >                     Else
> >                     {
> >                         Return (I3ID) /* \_SB_.I3ID */
> 
> Do I understand correctly that I3ID is the old one (as per another path I have
> seen last week or so), i.o.w. *not* a MIPI allocated one?
> 
> If it's the case, feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> from ACPI ID perspective.

Regarding MIPI ID and using it as a _CID is kinda unsolved now, in any case
_CID *requires* _HID to be present, and hence _HID has a priority in
enumeration. It doesn't matter if it's absent now (it's even more flexible in
case MIPI decides to use _another_ ID for _CID) as long as software uses
_HID for enumeration.

> >                     }
> >                 }
> >                 Else
> >                 {
> >                     Return (I2ID) /* \_SB_.I2ID */
> >                 }
> >             }
> > 	
> > 	...
> >     }

-- 
With Best Regards,
Andy Shevchenko



