Return-Path: <linux-kernel+bounces-433903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D79F9E5E93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8972834E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775C022256F;
	Thu,  5 Dec 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxywfASl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8D2EB1F;
	Thu,  5 Dec 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425497; cv=none; b=MPYX7KLfPsHAj3Qj5z7pkTf0umGBdOCiHJncF1IGPc+zduT3yNmiH2H86Vq48T3/3mL16z/TlQpHRdbA8p3CEs7F+lhdMYq3E11+ggyw+uMNkzBqfel7Z0ZQtdKvUCHSkaE6QbYf7V3HCs+ntJmvt4T7glJno4ImF6JxAF0BSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425497; c=relaxed/simple;
	bh=fgwFdcRdSkhyc6HFD9jAVWx2sWUJE7R7QGrzlKL9/ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp1zfINBUl6or1SAuRU9XIRXVxcPgzsoTGBZt+PX+9jPRZzoHA16R1rbxXWKKBc2M4tgFLJe541NljKaqOjEwPuQYiufTajqfYh8CV466+8aI1maHljZulI0AGX/00LhinoPidsBBTE2loqBperRiOhXluwCAGjdwdldG+ID6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxywfASl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733425496; x=1764961496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fgwFdcRdSkhyc6HFD9jAVWx2sWUJE7R7QGrzlKL9/ns=;
  b=FxywfASlPfjP9LhWszMOrpdbuFe6W+UD3erVblik90zTNkU0Nvxs65Ph
   +vQAqe1k8g9OBHmNkgHIZ5KJwoY6I9BGEeEmCq+0e6NToPJs7ez5BJGU/
   hiS4cgcFasoJ6Y6H3g9L5DqyTAXhSVmUHHLIfoKM8vPYzMUQMqXFjVJTV
   pQiHBEhqvFIlLQAt9Dmf9xUYD7ElhP4MgmETpxl5zcc+BJ8wnyMS0BM3h
   1VRpk4E47ZU11cqotqwnKSs7pIgCnhrymsDhfqidyhfEgXsAOcjvXZs8J
   tG/pEfqMYsVv44xv9WW1f2ED5FqOKjkLHEoocKTReG8PaPmnS9ZmzTBo/
   A==;
X-CSE-ConnectionGUID: qcPnLY5MTAOjOeC81s9lQQ==
X-CSE-MsgGUID: QRcFPKnNRcq/sVJu0ZvwYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44428256"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44428256"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 11:04:55 -0800
X-CSE-ConnectionGUID: Ldk36ZduSpSoo5LdMD+ktw==
X-CSE-MsgGUID: XGkHXKC6Sc+APGybABDhAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94261062"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 11:04:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tJH9f-00000004BDc-04Ns;
	Thu, 05 Dec 2024 21:04:51 +0200
Date: Thu, 5 Dec 2024 21:04:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
Message-ID: <Z1H5UqN-egUs0GhJ@smile.fi.intel.com>
References: <cover.1733305665.git.ukleinek@kernel.org>
 <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
 <Z1FbOrGjaVsGKIXa@smile.fi.intel.com>
 <mfgqf5xpjnyud3qm4hwycbnz23mfik4pzry3h7fi2k6khokbgd@facrmygrrqnh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mfgqf5xpjnyud3qm4hwycbnz23mfik4pzry3h7fi2k6khokbgd@facrmygrrqnh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 05, 2024 at 11:55:54AM +0100, Uwe Kleine-König wrote:
> On Thu, Dec 05, 2024 at 09:50:18AM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 04, 2024 at 11:01:10AM +0100, Uwe Kleine-König wrote:
> > > Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> > > literal") the namespace has to be a string. Fix accordingly.
> > 
> > >  In addition to the macros EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(), that allow
> > >  exporting of kernel symbols to the kernel symbol table, variants of these are
> > >  available to export symbols into a certain namespace: EXPORT_SYMBOL_NS() and
> > > -EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace.
> > > -Please note that due to macro expansion that argument needs to be a
> > > -preprocessor symbol. E.g. to export the symbol ``usb_stor_suspend`` into the
> > > +EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace as a
> > > +C-string. E.g. to export the symbol ``usb_stor_suspend`` into the
> > 
> > But C-string is ambiguous. Is it now okay to use
> > 
> > static const char *p = "my constant C-string";
> > 
> > EXPORT_...(, p);
> 
> I didn't test that, but I guess that won't work. While you could argue
> that p isn't a C-string but a pointer, I agree that the wording isn't
> optimal.
> 
> So maybe make that:
> 
> 	... the namespace as a string constant.

...a string literal.

?

> ?

-- 
With Best Regards,
Andy Shevchenko



