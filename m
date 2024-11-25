Return-Path: <linux-kernel+bounces-420857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101589D83B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA636285532
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332771925A6;
	Mon, 25 Nov 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEtPNnXA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723854765;
	Mon, 25 Nov 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531594; cv=none; b=q8ZrJbRmdfi/1eIC5pfBdsPJHjC2k09ZqQbGcxsAReU+g6J58ATMPmEJXv38lQaqpmk7gOi7I6axu3akGeFosauJMSA4+4fgrh6bDxtPnmkLfFbf3Y/saHfmIJ0ka4Mg6aSGt0ai4fdMO3Ke99CgHL4GpRz+ALU/ilWh6gN5iTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531594; c=relaxed/simple;
	bh=7pL7utd2b3yKlneogLtRMMs1bk8tZH9UlAOre6wwcOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otM8Y+0Luqu1yjE5Joz2ix1zMMgoT6hfPSj2o0B9czK2uBbvBPUbtPjTVIkqUAyJEmAFti3rYymox4Z+eYcDoZ56q8GSoAZeusoMZVEMFbyiEPkRzoTsz6o+5pPhD/UNlY4CbgXv1WQlVDLnFna9vwdXGEtde69R36V8OK+ifr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEtPNnXA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732531593; x=1764067593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7pL7utd2b3yKlneogLtRMMs1bk8tZH9UlAOre6wwcOw=;
  b=LEtPNnXAQBLwrQJN+0dhMxQFuAyvPZCL84Q1C4R9nNNGCSu3G1Pr6I/v
   UfGNB696KbJ8cVaZA0Sb68Esj9/mRh2a9vKWLz3Jw8NCHTbgBp7ranbmb
   V0cfzeerPEO0TgoxzzbtrEwhra2gaCZRSdR3E9od8aX+0+LuTLC165bqs
   Bn1yPxIdTaxM6qMxxEWJJ2KKXLPcx5LhskC/iQSjikMsjtStAKFtHt0O+
   n8lM9hoKR+qU9GTdIwhmh9rooDjRGlIeOYF/l3DI9jrDjynQLzzcE/OAX
   QmoPKPbB4j/yu9fGIHSjojsn/ur3+G17yWRjCzeS3+BlIAOusdJtGoXaF
   g==;
X-CSE-ConnectionGUID: 6Kdu9ovUS/i+QOQZRiKaZQ==
X-CSE-MsgGUID: luCd+sz8R/WzEOCDUlOvow==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32758358"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32758358"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:46:32 -0800
X-CSE-ConnectionGUID: s9Mu0wmbQLeZWSt2JlCSpA==
X-CSE-MsgGUID: d8nGDvvSQ/qjz7+cYy/8jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="122176338"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:46:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFWbp-00000000ifO-3QKs;
	Mon, 25 Nov 2024 12:46:25 +0200
Date: Mon, 25 Nov 2024 12:46:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Cloud Hsu <cloudhsu@google.com>, Chris Koch <chrisko@google.com>
Subject: Re: [PATCH v1 1/1] x86/Documentation: Update algo in init_size
 description of boot protocol
Message-ID: <Z0RVgdhYu17lINZz@smile.fi.intel.com>
References: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com>
 <d2dfc0a4-d9dc-4dd2-a669-097dcf3491b5@infradead.org>
 <Z0Q5MIjy0yx6jyNq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Q5MIjy0yx6jyNq@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 25, 2024 at 09:45:36AM +0100, Ingo Molnar wrote:
> * Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 11/25/24 12:31 AM, Andy Shevchenko wrote:

...

> > > -	if (relocatable_kernel)
> > > -	runtime_start = align_up(load_address, kernel_alignment)
> > > -	else
> > > -	runtime_start = pref_address
> > > +    if ( relocatable_kernel ) {
> > > +      if ( load_address < pref_address )
> > 
> > What's up with the extra spaces around ( and ) ... and inconsistent with
> > the lines below?

I can remove them. This file has a lot of inconsistencies it seems...

> Also, even pseudocode should follow the kernel's coding style and use 
> tabs in particular - which it already does in (some...) other places of 
> this document, such as the 'Sample Boot Configuration' chapter.

The problem is that reStructuredText syntax requires that indentation.
I may follow the rules after the rST requirements, though.

-- 
With Best Regards,
Andy Shevchenko



