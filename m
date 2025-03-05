Return-Path: <linux-kernel+bounces-547042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC9A50246
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71D73B4348
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6724C68B;
	Wed,  5 Mar 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNaiNb52"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B724C69D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185269; cv=none; b=OM8eIXrhxWAKCPRzvUtcFXYYSADA2OZwkb0kMVUkSY+hHghlFui3Lz6z0690G71QBZYds92BztmcTYm4GnNcB6g9MMvzsQ1B75YlUQJ0zrt9Ig5nDiRl/rIkdlA3cfmxmoIYmQzIRXCs8stfL1/hcCMaIaRI+ywD3HlEH5OKCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185269; c=relaxed/simple;
	bh=Q20ygQOXxZfWxH1QwL6EtkQDkXQTKlkx9YZgOavk7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEO5HVlDXIC2hs5og2/00gAPqCYsetsvFJlSjf59zcO5Re6xZgW07nUP6TtRAsNonpgsfEucULd/HWgnf4QcikZ68r1/ms/wu8YG7aQlS/3JFkptKvLyWzcrmv7bq5T8RIFdZn0Zg9rNb2PyWwoOPC51vjq6T+EPy8lTJeZAZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNaiNb52; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741185268; x=1772721268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q20ygQOXxZfWxH1QwL6EtkQDkXQTKlkx9YZgOavk7ng=;
  b=kNaiNb52ELgCM1QguObpfPTUAQTEJfxbLXGmG1ztRFksfcDjGyWgCmcw
   zWNY859jkzUHQlNinwgVeJX7/mU6ttB3m9hC6pMdXb4mRq/XtRjpHGI7/
   ce1Aetp+5U4MWiBfxr2qN4mpvNpRkkcr0A7mKwHgTzhc1sq11vuDvBT1Z
   yFDhhWNJM95CBG2BTx3TTkEiSMM7I6MNwca++trZDcToMB1yLG5Vd99hu
   cXqoNLue6vHUBtmkDNhRWi+6XQMvQ1ouCWs9R9bFxO27t0MaVY/svew3K
   OM5wcUpdvRQbRFc4DCk5X7B+Wz+f1xCa2XKAH/TxNgberCt2PJHVQM4KJ
   g==;
X-CSE-ConnectionGUID: mZodHfgHTYSmXfmtRkL/rg==
X-CSE-MsgGUID: 2Lx5qp16Qie0QzdDtTQrSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42058787"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42058787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:34:27 -0800
X-CSE-ConnectionGUID: 1SlVJIArRA+WKeKR7nzDPA==
X-CSE-MsgGUID: dR5c/5nSRISnK44rdgG4Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119625346"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:34:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpppE-0000000HRAs-2Xou;
	Wed, 05 Mar 2025 16:34:20 +0200
Date: Wed, 5 Mar 2025 16:34:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 1/8] bits: fix typo 'unsigned __init128' -> 'unsigned
 __int128'
Message-ID: <Z8hg7J1jqlFF1Uka@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-1-1873dcdf6723@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fixed-type-genmasks-v4-1-1873dcdf6723@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 10:00:13PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> "int" was misspelled as "init" in GENMASK_U128() comments. Fix the typo.

Please, fix it everywhere:

$ git grep -lw __init128
include/linux/bits.h
include/uapi/linux/const.h
tools/include/linux/bits.h
tools/include/uapi/linux/const.h

-- 
With Best Regards,
Andy Shevchenko



