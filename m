Return-Path: <linux-kernel+bounces-201418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F08FBE37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C581C23425
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39414BF91;
	Tue,  4 Jun 2024 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK3GY3A9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD813CABB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537569; cv=none; b=dD0NGQiq6Cr/S5yPCMVhcSI4pZmNK97vUh3AnyQpbyCDIq+8flCOCt1IQOONn9J5wweeCk2XgulYk+3SHT8v9vJaVTphEnMNY1mPLH+u+Xm7H3peZlmKQ9X7rsd28d1B1bqCU9KXuwojAuSELFsCiD7xKRkzGRBvWcSB2Nz/4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537569; c=relaxed/simple;
	bh=p50tzagc22lV4uZC19romum3y3Oh2dqEujTGg+i+WVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzgPS8e9ide/qVJG9kzDJAgh+ZB42LiCTdQMRaMk7zv6KaBtMyx/5DUeOT5S0JhhMmU26C9qCWy7VVNBR7LUMXhLh40KBjcIw+ZBTkS9AB9h2u+55eh6ALI+mieN2JPED1ClKNNF1pMi++5YcOPWG6ewm+P/UOP/E3y7lgqinAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GK3GY3A9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717537564; x=1749073564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p50tzagc22lV4uZC19romum3y3Oh2dqEujTGg+i+WVk=;
  b=GK3GY3A9ljZP639KHChSmTObyieFPHOs4a+cClnd89B3sEsTMePqhQtB
   iXLxjokI7/tN4tHdZwDhMyFMs3uWu/OLC32CULGCCrIlMl9hfmwgm3AcT
   KBNgbozPnwf8UJLlC7OXUa6tQ0NIaH0aoBHl3vOTVwujukjUAz0BN8dC1
   /dkWPYTG5QkSJe/e6wcHj6dYjEVSpnC6n3GsGYMK4VHdjiFi43PbAZKmO
   hcXwGWHFeU2GolUjs+C6Phu2VPt6JTpI3AETF/IUxrKvjGIwwhZJaf6u0
   kW2wJg0ZhDow3CDAtm3btF+FJBFLB99SL0R7Akf52NLGb1K86q5Yy3ywV
   w==;
X-CSE-ConnectionGUID: 0D+zsaT/QcOWEFY1mu4Cwg==
X-CSE-MsgGUID: /RexKBUJQL2rDMxpJtdUjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25520793"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="25520793"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:46:04 -0700
X-CSE-ConnectionGUID: jKhLV0Z0S1KeE73nPNNA3Q==
X-CSE-MsgGUID: C1zmRyItRESZP6ATtGXQ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41798995"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:46:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEbyg-0000000Dfi6-3nyw;
	Wed, 05 Jun 2024 00:45:58 +0300
Date: Wed, 5 Jun 2024 00:45:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resource: add a basic test for walk_iomem_res_desc
Message-ID: <Zl-LFtGP3z4rR-7S@smile.fi.intel.com>
References: <20240604213200.672279-1-olvaffe@gmail.com>
 <Zl-JUkLoxqraKciw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl-JUkLoxqraKciw@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 12:38:27AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 04, 2024 at 02:31:46PM -0700, Chia-I Wu wrote:

...

> > +	res[2] = (struct resource){
> > +		.start = offset,
> > +		.end = offset + SZ_1K - 1,
> > +		.name = "NESTED",
> > +	};
> 
> We have respective macros. Use them.

And use explicitly hardocded start in all of them instead of coding += for
offset variable. For the test cases is better when data is hardcoded, esp.
when it's an expected result (just to mention, here it seems an input data).

-- 
With Best Regards,
Andy Shevchenko



