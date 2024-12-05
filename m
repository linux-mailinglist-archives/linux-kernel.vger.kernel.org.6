Return-Path: <linux-kernel+bounces-432698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244389E4EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0CF2815B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879021BD9E9;
	Thu,  5 Dec 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mcb2M+43"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937BE1917EE;
	Thu,  5 Dec 2024 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385025; cv=none; b=olT/tiunkVYXk2PH1THC+LwL8PgDMtMxe97Cs0IwVho/iL5IfSbYk8KAlGoKwvZP0DyzGrnoXbI2983K+uyaluqiqEJ9yiAr4RK0IX8BSobk/KiaczZbd2q1oan7Z8O6qfkhZ3AyozHnbEAndgQmXt0a2wNcvdLNzgieKuZ6VZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385025; c=relaxed/simple;
	bh=bPh4ih7OpJ8m0rn8A+XBCM2qTFax+ED9i3CtQUAzxYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deyQyCr71FzIIIgaL0kTqulLAK2XeUBmCWX03nexO+GMF3EHU8IpZkZ6Tf5UJwWCIETtOjWBA+X2YwdDi7fsjJZ+c6Z5f+F1nFhVoEX9LvQT1e9+V5/fAR2AQj48zgGUKqNgGddUkVyu1kdTvnIX2XKuw2ipA1OxexiPhO5JUZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mcb2M+43; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733385024; x=1764921024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bPh4ih7OpJ8m0rn8A+XBCM2qTFax+ED9i3CtQUAzxYo=;
  b=Mcb2M+43CwI0z9/2LsefKvxU2ue5FUa6Q09MdZlaTj/g8krRseugIx6V
   0JgfNMvgBH1ZzSZ1sORckuxIIBu9BEuoSHCJwO6Ra+PwgEr0adYSWv/q6
   Has+A92lTaNMWpcTXRnA4r3kJ/rCz+xdiafPgC9r3leiU6qir3KHFrzHM
   vOUgFQAnlVroq4i2x6wvg86BxVY7fohC2Mv3L++2mTmdJDMRTKx4DsBL0
   jJkaiKe9DKCXCAubmJEq6Oz4pG5RlQx7JrOkTu2AnquX3yzXo1J16ZbxG
   yeJDVSg2F8NZaUL6CNpQWyyzoHef1z0+QdR/F5IoBjy8tKqf5ckIpAR65
   w==;
X-CSE-ConnectionGUID: 7fgzuQKfRP6z04V84Abd2A==
X-CSE-MsgGUID: cSXfSqKKR4KPpKVfNbpo5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33564718"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="33564718"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 23:50:23 -0800
X-CSE-ConnectionGUID: FKXDgk1gT42DZ1tiE5pKaQ==
X-CSE-MsgGUID: HF6mZtFfQViQbnNiZ+19Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="124938594"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 23:50:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tJ6cs-00000004173-22ns;
	Thu, 05 Dec 2024 09:50:18 +0200
Date: Thu, 5 Dec 2024 09:50:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
Message-ID: <Z1FbOrGjaVsGKIXa@smile.fi.intel.com>
References: <cover.1733305665.git.ukleinek@kernel.org>
 <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 11:01:10AM +0100, Uwe Kleine-König wrote:
> Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> literal") the namespace has to be a string. Fix accordingly.

>  In addition to the macros EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(), that allow
>  exporting of kernel symbols to the kernel symbol table, variants of these are
>  available to export symbols into a certain namespace: EXPORT_SYMBOL_NS() and
> -EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace.
> -Please note that due to macro expansion that argument needs to be a
> -preprocessor symbol. E.g. to export the symbol ``usb_stor_suspend`` into the
> +EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace as a
> +C-string. E.g. to export the symbol ``usb_stor_suspend`` into the

But C-string is ambiguous. Is it now okay to use

static const char *p = "my constant C-string";

EXPORT_...(, p);

?

>  namespace ``USB_STORAGE``, use::

-- 
With Best Regards,
Andy Shevchenko



