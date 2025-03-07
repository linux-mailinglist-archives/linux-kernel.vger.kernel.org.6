Return-Path: <linux-kernel+bounces-551682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E37A56F68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0D9188A4D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD724110D;
	Fri,  7 Mar 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lsm8S7ZZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF74217718
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369448; cv=none; b=pWC9SrnyBd80yMsKPUGDzLkO+MSzD4jqLoUd4GS5k+IYJn/xvj/bD5DUXIZPO2ZI1BCnyyG24M19aViDvYF2MfQzf7DKXgRbyBlxOuiPwmLJabniNq3ytMRK7kR9vAkvks2Onhmar1T1SQfut35LmDRSlEJLZPTXNzjwFmhePfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369448; c=relaxed/simple;
	bh=1srF4LgWxxJj/Y9eDyJgZvB55VhLx8r7xdOwjT1Oc+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5uIsK/W0EulFUqweNNNVW0uL7+qGf7Dnmr7V9HDFry49u7efWd2NHnM8LN3cjplrQ7uXcj8iMBd+MpMTSNWPkHL45a2vnH0MIKi/k4bIUP3xhdFcVLeOUqEeQP+mD07jgDXbsrq9syA+gWkTOn9mmTyYBIqlSe/2Iq5BXxaOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lsm8S7ZZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741369447; x=1772905447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1srF4LgWxxJj/Y9eDyJgZvB55VhLx8r7xdOwjT1Oc+E=;
  b=Lsm8S7ZZnuwxX+Rjv6Pd4i+QbqiVFpy6evV7h2hzx95j83QQcXajKX2L
   LJGbm8QAn9KZfozVMP8EHPyPBLbamHkySiE+hCjn3a5pnAF9re14e1oW7
   07MRott77niGlygPmCE2ZI8AxycjB0a9Q7q9sEdaHLAnHz9H+GRsut0Ck
   6S3bbhN9AnA/fkv3/G2s7iIPKwjGIh29HnsFo+QSYltaqeWbALppI3vm/
   zdOctp/ij1t0kp6UjLiJ8OkEYhIWvLXwleYBtVO+zcuBHSwtJL1W+tRxd
   dVfcme9X0CBpiie306DLTbTiJ3MGUTAYePhMdAqSkjG0+A1VU1U+mR1DB
   A==;
X-CSE-ConnectionGUID: h3tHp35/QnS2hLVU8Kz5dg==
X-CSE-MsgGUID: Ca4Mbd8mSQSENjKzhl400g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42461795"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42461795"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:44:07 -0800
X-CSE-ConnectionGUID: HwCCIbF9QDS6ezXMH8jalw==
X-CSE-MsgGUID: QfApuOshQTisfw2kd/i7wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124472094"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:44:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbjp-00000000TVy-36Lu;
	Fri, 07 Mar 2025 19:43:57 +0200
Date: Fri, 7 Mar 2025 19:43:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: mailhol.vincent@wanadoo.fr, Lucas De Marchi <lucas.demarchi@intel.com>,
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 0/7] bits: Fixed-type GENMASK_U*() and BIT_U*()
Message-ID: <Z8swXUGf9rtTHw1o@smile.fi.intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <Z8sqSpKZzfolKm8Q@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sqSpKZzfolKm8Q@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 12:18:02PM -0500, Yury Norov wrote:
> No rush, please allow your reviewers a week or two before submitting
> a new iteration unless you want to disregard the previous version for
> some reason, of course. This will not get into the upcoming merge
> window, anyways.
> 
> So, what should I do? Go through the v5 and all discussions in there,
> or just jump on this?

There is also question to you. Are we going to leave with U128 variants or is
it subject to remove? If the latter, can you issue a formal patch?

-- 
With Best Regards,
Andy Shevchenko



