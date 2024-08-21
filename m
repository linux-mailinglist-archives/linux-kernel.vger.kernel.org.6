Return-Path: <linux-kernel+bounces-295836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1D95A1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4FE1F26FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9501537D0;
	Wed, 21 Aug 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxvsjjSG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031571537DD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255023; cv=none; b=id4kdfV0L0EJyvgUkLWnFDBDAJd+G9aFRDbqTc19hQYk9feS/fV68jxr5mM2ZW0VPi/ruNzhwHKrifevFNg7gSW7/xxdkb9TzjxXDiaaogmDTczTIJF3sThR6a30vdcRgzhxXBz/ZPmZNSfYxTeBBT5iOyBtkCF7fLr0Vhb0tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255023; c=relaxed/simple;
	bh=QC2ayoHYMlUTm5CleMwtaB464LNdcjG+nZPAt67rWLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9phDGf9aIr+1r7MCUuFweCjimYzCzzpoDIRuqej4KjfVv59Q+lJIS5ht5Cc2p7avaFZep5e7VObHfe4QdkP/W5d0opd7XrxMsi/yynojHvXTLrfOIFqvQdWIYnVCSwy+53UZ4bBDxCnJbyAnqBXEKdM148yeRqedCPjZLtsGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxvsjjSG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255022; x=1755791022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QC2ayoHYMlUTm5CleMwtaB464LNdcjG+nZPAt67rWLY=;
  b=jxvsjjSG4C9HiDBb/nOHFz6IQG1xMXRAZMtoDoTIFs33jgIlQLcI/8+I
   06spwXnrrp/lLW+AqFmqMoTOyTNc8Eq6SnKvRyO3+GuAGEbZe602rTUrt
   VUMc+HFgImp48SDjNtLgVYI+ePadU8fVpuNLPzOJAG+rxEGmjH5bUhEf9
   eswj0vrXEWsw7mnq76P4t20ustVLgkRfM7APYd8WIzQRJah9XHuqnMM51
   EeCY8MXytOdSsnmb5W/eh1XLnhJ9PoCZAr7JcBRL8WOa+KN9A3dt0gVGa
   kTRHWlQPhwCOYRozzHJNiKj+Wc0ll1TuTHHaTHOx5N8KNy8yPziq/ngO+
   w==;
X-CSE-ConnectionGUID: MwhLlKNsQ1CsfeB2fLwGgw==
X-CSE-MsgGUID: cgRc9jopSzm5YF+rTJ4tng==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22506034"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22506034"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:43:41 -0700
X-CSE-ConnectionGUID: T2g6NdRQQnKbrp0/UZHS1A==
X-CSE-MsgGUID: Td9q+1Z1RY6SrUs78a4f2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65820145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:43:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgnUm-000000008C3-2111;
	Wed, 21 Aug 2024 18:43:36 +0300
Date: Wed, 21 Aug 2024 18:43:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the
 I3C Support List
Message-ID: <ZsYLKFCvLdMn5FM3@smile.fi.intel.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
 <9584ddb0-6e39-4d04-9242-a68eb4b86eba@amd.com>
 <ZsXyHfLJ8SJOW0RF@smile.fi.intel.com>
 <236aa6d9-bb5d-4854-86e3-5473f5ea6337@amd.com>
 <ZsYKGOLN3_2VU6Ld@smile.fi.intel.com>
 <ZsYK1P5nW5e1U1mJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsYK1P5nW5e1U1mJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 06:42:13PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 21, 2024 at 06:39:04PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 21, 2024 at 08:42:12PM +0530, Shyam Sundar S K wrote:
> > > On 8/21/2024 19:26, Andy Shevchenko wrote:
> > > > On Wed, Aug 21, 2024 at 07:07:45PM +0530, Shyam Sundar S K wrote:
> > > >> On 8/21/2024 19:05, Shyam Sundar S K wrote:

...

> > > >>> This update adds the AMDI5017 ACPI ID to the list of supported IDs.
> > 
> > s/This update adds/Add/
> > 
> > > > Please, provide a DSDT excerpt to show how it will look like in the ACPI
> > > > tables.
> > > 
> > >     Scope (_SB)
> > >     {
> > > 	...
> > > 
> > >         Name (HCID, "AMDI5017")
> > >         Device (I3CA)
> > >         {
> > >             Method (_HID, 0, Serialized)  // _HID: Hardware ID
> > >             {
> > >                 If ((I30M == Zero))
> > >                 {
> > >                     If (CondRefOf (HCIB))
> > >                     {
> > >                         Return (HCID) /* \_SB_.HCID */
> > >                     }
> > >                     Else
> > >                     {
> > >                         Return (I3ID) /* \_SB_.I3ID */
> > 
> > Do I understand correctly that I3ID is the old one (as per another path I have
> > seen last week or so), i.o.w. *not* a MIPI allocated one?
> > 
> > If it's the case, feel free to add
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > from ACPI ID perspective.
> 
> Regarding MIPI ID and using it as a _CID is kinda unsolved now, in any case
> _CID *requires* _HID to be present, and hence _HID has a priority in
> enumeration. It doesn't matter if it's absent now (it's even more flexible in

Just to be crystal clear

 "It doesn't matter if _CID is absent now..."

> case MIPI decides to use _another_ ID for _CID) as long as software uses
> _HID for enumeration.
> 
> > >                     }
> > >                 }
> > >                 Else
> > >                 {
> > >                     Return (I2ID) /* \_SB_.I2ID */
> > >                 }
> > >             }
> > > 	
> > > 	...
> > >     }

-- 
With Best Regards,
Andy Shevchenko



