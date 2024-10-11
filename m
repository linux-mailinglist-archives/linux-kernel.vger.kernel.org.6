Return-Path: <linux-kernel+bounces-361630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFD99AAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68EC2842E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518401CEE8C;
	Fri, 11 Oct 2024 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Enz5CdD4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9E5228;
	Fri, 11 Oct 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668519; cv=none; b=K1HupolzSHwjMYmpG10ZytmiIWBHytsZzreHORqnm3VbK3E3D1Q6dCB88IeeMpT0Te3Z3tw3KZHGLeCZojJoGJ3IgKX2eviSrB9WR4O7VqOyQ+Vp6H1sEEDUFuLpgMJnz2hDOMqYn+FTTM+Mht3tYHRjjIu4LTw9hGcQmK6KpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668519; c=relaxed/simple;
	bh=luego56ywteqWoCTnjovxJDa0RzQP7LABRM5g25krqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHnSXul+DotzF/htTrDm6NTAkcqsuclINZcq3dP66ZCRYMr/RFz2g/yMebruC6OaG2vb+FzlKhwEFf4llko2K/IRXWOns0ACh5WUrjTXQZhVGY40oOu75N60XhrZ6ZB/zC4yAQLeJUFVTD5co2TF3yURJlvTYgc2pinKHPPwc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Enz5CdD4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728668518; x=1760204518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=luego56ywteqWoCTnjovxJDa0RzQP7LABRM5g25krqk=;
  b=Enz5CdD4bMFL2pnACdjI/tQ00Itwltk3Caf0oauI1rrLR+IYmbPcrZ6C
   dYbgKn5g8vhjzycAc+bTzP4zGsQ75KKX0bhUUdu2VP3Ce7gqg3jgqUHje
   RZ56tXIHFqj67Wo0ZeTX+KGC4BiYIJwEMLuCSovuHtOJtwXsoL+CmbdMW
   +FRqhJfjZHLV5stiWzaIE8VV78LiqXcswXP6/Zq6nIlxpvxgO1dAUVt4z
   kSosIEQ8fksHkZn1Fv8gWTvjP318HOe2iY94houjm5JyyiUlcY4xamhzr
   dgHXiKULebzQ0gOIuulwewCDJMtdieAfT8ZU/Y5oQoBFClUu5LVDlZ6Wx
   A==;
X-CSE-ConnectionGUID: MiXkZgleQpiscvKeu0iRRA==
X-CSE-MsgGUID: +0sMyy4vTdGSAyHYHVcONA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38655332"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="38655332"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:41:57 -0700
X-CSE-ConnectionGUID: 42uSfUlyQ5OCsBzUNe1hJw==
X-CSE-MsgGUID: d3WGbL5iSqCFdBOgNQmqGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77072164"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:41:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szJeC-00000001zg1-48wr;
	Fri, 11 Oct 2024 20:41:52 +0300
Date: Fri, 11 Oct 2024 20:41:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Gow <davidgow@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [rfc, PATCH v1 1/1] platform/x86: intel: Add 'intel' prefix to
 the modules automatically
Message-ID: <ZwljYE6Ck4Uu-aUI@smile.fi.intel.com>
References: <20241011172531.3407093-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011172531.3407093-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 08:24:09PM +0300, Andy Shevchenko wrote:
> Rework Makefile to add 'intel' prefix to the modules automatically.
> This removes a lot of boilerplate code in it and also makes robust
> against mistypos in the prefix.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Send as RFC because TBH I rather want to have something like this to be
> available on the level of Kbuild for any of the subdirectories in
> question. Also I haven't done any comprehensive build tests on this,
> let's see what CIs think about this...

(FWIW, I already fixed a few mistakes locally)

To elaborate more, what I want to achieve.

Assume we have

	obj-$(OPTION) = bar/

in the Kconfig and let's say bar/ contains

	obj-$(X) += zx.o
	obj-$(Y) += zy.o

What I want is to have something like

	bar-prefix = baz
	prefixed-obj-$(OPTION) = bar/

that results *automatically* _if_ I wrote originally something like

	baz-zx-y := zx.o
	obj-$(X) += baz-zx.o
	baz-zy-y := zy.o
	obj-$(Y) += baz-zy.o

without actually modifying the Makefile in bar/.

-- 
With Best Regards,
Andy Shevchenko



