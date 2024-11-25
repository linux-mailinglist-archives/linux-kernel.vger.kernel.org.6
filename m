Return-Path: <linux-kernel+bounces-420867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D89D84C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5ECB3AC84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0E197512;
	Mon, 25 Nov 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtU6m7yF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CE196C9B;
	Mon, 25 Nov 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531851; cv=none; b=kuGFQtPLLH7hCIJGOB4GkDRfrEEdcmvZ6Fkl+j6z8NgQqRl2bGtuwgD7HHj3TXS4JxpxGRtFwc2Rf1DIgMxM8vh0GdfEmcCtNwTiTpvSuKwZK1FEGUmsgWbyG3ue2kVS5hqyvjSzkxSuGVkSwHpMOYilkujgrxnHJfUbvgJXaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531851; c=relaxed/simple;
	bh=Wbhswxh37Wsna+ix6qPk9ORg48ErC/7MoQ3F/8voSKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt/KeZI+hV8RBvbfhw/yT0uvG8CXdpi53evuLzl6XARGol7Drd/p+XzGYGoTzWN2ZJBdN3FO226/IBGa6yAOvGaSqDeHSQuENPxLjFlZ+9+y/H4vohGZjsTm9IYOvcvbhLFDiJNZfDdqbynjudG61KGsH9UuXf0iXBEAyM5AIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtU6m7yF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732531850; x=1764067850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wbhswxh37Wsna+ix6qPk9ORg48ErC/7MoQ3F/8voSKY=;
  b=LtU6m7yFiCUM/0qe3iYS0EqZwR19PFOqkoy2UaNUGB5sfHp1g2eu0t6/
   jZ+FhfwJkeWGaDucd64O+T4sK7r6uK6VbgcdWTinEMk13R/ofXkw8zcnn
   btMu7ePRNlszVOH5481RF+VwIe5JOGzLchZUhN3kV6k+Iz9T5TcGfrSTn
   /Gz41Hwnr9BgEcaKMcDJ39I2JJTtSCRXKoLmMtS84jeTIvpoZCq6RIXfc
   MZp5c7YOAyqkydNiyPvKcn0fg8hMMEwxhM/R6rBysUAMSe4WHRJuOInki
   f7V/F/pb1hNaFqcr+BIPMKzjcLRXez54+LtvXKBxDFlvdvN5TVzMkF50E
   g==;
X-CSE-ConnectionGUID: oKwSd+wZQ2W7FnfMMXQx1g==
X-CSE-MsgGUID: DKd2mCeSSXidgzx5O26ZNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32881419"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32881419"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:50:49 -0800
X-CSE-ConnectionGUID: eu7W6qbbRPiqV/jKpZ1QQw==
X-CSE-MsgGUID: 2jMbpPspRtiqi5Jn2t9yHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91185077"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:50:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFWfy-00000000ikZ-0tV6;
	Mon, 25 Nov 2024 12:50:42 +0200
Date: Mon, 25 Nov 2024 12:50:41 +0200
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
Message-ID: <Z0RWgYk24V-Fewlr@smile.fi.intel.com>
References: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com>
 <d2dfc0a4-d9dc-4dd2-a669-097dcf3491b5@infradead.org>
 <Z0Q5MIjy0yx6jyNq@gmail.com>
 <Z0RVgdhYu17lINZz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0RVgdhYu17lINZz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 25, 2024 at 12:46:25PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 25, 2024 at 09:45:36AM +0100, Ingo Molnar wrote:
> > * Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 11/25/24 12:31 AM, Andy Shevchenko wrote:

...

> > > > -	if (relocatable_kernel)
> > > > -	runtime_start = align_up(load_address, kernel_alignment)
> > > > -	else
> > > > -	runtime_start = pref_address
> > > > +    if ( relocatable_kernel ) {
> > > > +      if ( load_address < pref_address )
> > > 
> > > What's up with the extra spaces around ( and ) ... and inconsistent with
> > > the lines below?
> 
> I can remove them. This file has a lot of inconsistencies it seems...
> 
> > Also, even pseudocode should follow the kernel's coding style and use 
> > tabs in particular - which it already does in (some...) other places of 
> > this document, such as the 'Sample Boot Configuration' chapter.
> 
> The problem is that reStructuredText syntax requires that indentation.
> I may follow the rules after the rST requirements, though.

v2 has just been sent:
https://lore.kernel.org/r/20241125105005.1616154-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



