Return-Path: <linux-kernel+bounces-295558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE5959E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C88A2816CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA11A2840;
	Wed, 21 Aug 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePaW8LpA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F519ABD0;
	Wed, 21 Aug 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245950; cv=none; b=HgbGzzLU4NypG/E65ir566DKQdrFc2VaHJ/Z0vIZ8QMFZ4XkjslFoEACvYB2XghChdCVI2K008+N4vKjK3qXZNmQQWdS4SBAkKo0k1F3UcJnfE5XBh9u/wgsuEa9yijbtTqZWwzQqu/MOP24kCy8u9sILZGLAqTet8cpgz1iMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245950; c=relaxed/simple;
	bh=h14BmJbpo6ksiyNRHk1esFbG+6FjgxhMeO5buuYByyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODT4v/OVCztYKBofNKhKnK88IZNKhNreZ6cROcI8380xqoqnTZB4ALNEBHnZpsKBw6zsWPbT/8OF0P85BWYnhTMuhZHgb4C7dDKseSvJx52HQ2fq1zv0zpbsST4J42EWywbI4wWLFH8NYZTP8fMOoWYdZ5xjaUlXQeEn7cdFvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePaW8LpA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724245949; x=1755781949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h14BmJbpo6ksiyNRHk1esFbG+6FjgxhMeO5buuYByyY=;
  b=ePaW8LpAJpxL4xt2hbfRz2PWf579TGruDboU5alq9pqtLvhr5tBxuTZM
   OBDwEXxX/AlWx4CloLBh57GFVzmoxK7ToFfnKztW8L0mlsMojwmE3LfLh
   +s5BZkwfFQI3fhuZnTMm4D2YyCcrKpGKiHHY5KQFp+ZubJj7k3A0Uzw53
   CHdlns/MrvqAdXZmnz2hubt1vAGc/shL1mjoIQo3KCdNoDg25bE67jg7/
   z/2Pq+/u92Q9BFW2Yqb2cVkjsXIi5E/udncdGDEPJIsktR4ImEEmTWrW9
   3c2vUhAREh5H1PGPcRaoub4W7UOXvb/PqTNCUDBIZSKibVoCI3N+Wmmxu
   A==;
X-CSE-ConnectionGUID: dzBTQCFhQQ2/zaCprYR6ew==
X-CSE-MsgGUID: dw5hYSEpQhqKx3CcSbJ8hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="40116368"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="40116368"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:12:28 -0700
X-CSE-ConnectionGUID: SF45a6ecRHmJWgcDf5kKKQ==
X-CSE-MsgGUID: Vn6M/RcNTSieM6vMGiYziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61226122"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:12:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgl8R-0000000053z-0ypY;
	Wed, 21 Aug 2024 16:12:23 +0300
Date: Wed, 21 Aug 2024 16:12:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <ZsXntvP6eBB_092w@smile.fi.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
 <20240821122233.3761645-2-andriy.shevchenko@linux.intel.com>
 <1dde296b-045e-d56a-1734-a1333a84060b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dde296b-045e-d56a-1734-a1333a84060b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 03:38:15PM +0300, Ilpo Järvinen wrote:
> On Wed, 21 Aug 2024, Andy Shevchenko wrote:
> 
> > In the similar way, ignore 0 error code (AKA "success") in
> > dev_err_probe(). This helps to simplify a code such as
> > 
> >   if (ret < 0)
> >     return dev_err_probe(int3472->dev, ret, err_msg);
> > 
> >   return ret;
> > 
> > to
> > 
> >   return dev_err_probe(int3472->dev, ret, err_msg);

...

> This seems generally useful,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks!

> A nit, the code sequence that dev_err_probe() is documented to replace is 
> no longer matches with the behavior (the else would need if (err < 0) 
> added).

Okay, let's wait what Greg says about it, if he is okay with the proposal,
I'll amend documentation as well in v2.

-- 
With Best Regards,
Andy Shevchenko



