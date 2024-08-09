Return-Path: <linux-kernel+bounces-280887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971894D07B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E81F22D5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA0194AF4;
	Fri,  9 Aug 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmRXpeZK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6E194AD8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207558; cv=none; b=KwKvNZN5kzwU/onMZTj0zchI9466pFnAlUqbRStZwvoKeAdmY03YWzVS1UjkyZAHL+Iy87jqn9lEfCIES9y5EHQn6qzduPBxbiOvKPiihXrJRrcd2SxwKYlDFUeWdt3tC5X3xBufo2e3jWqaw8AGl+c7hLJhNeqZXQMWrN57ts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207558; c=relaxed/simple;
	bh=j4BZ7WpxUEdse2ucvsDsXYMGQ7JlHLF9bU1XTB2JMq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7jaJ4CeTxWES5EVj5GPhZcaqEDpzhNb4pVxLWP9f8tK5cbER4uEkZAcQweGx+/EryuqVWA/CrHOmWXjCByIP85i/GJqKr4N6Pj642kB/18EIq+NuGWY6zFnu+yw9+J+IYLYTPYmh2fMdwgtPi3sza+w0/7mAGCvZhhZvDcKQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmRXpeZK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723207557; x=1754743557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j4BZ7WpxUEdse2ucvsDsXYMGQ7JlHLF9bU1XTB2JMq0=;
  b=BmRXpeZKLOOqaXGCWVUiBjzj+q2WI5JfJMN6emg84Qj7VA5dSRjbflAM
   gh8n1WcCiriaEnYjy6BMw8Nr5MJQP3VZSUQkXYNU5cDKRmB9oDfoK9Q+G
   lRMm/5OKbmh31uoHdJGXlFbTH4zxkmyL1M9mWbfDrLhfmJHdecIAx9TM6
   o+BfYSePIz0Q9iNhm0E4FFLMYfixMfGy8vZXzyvzjPeEVKWAhi0wZlHRh
   SSmiNQuEc4e5dsiNnIE71O9YL3Gyoeb4dlfW5E8WJbpx31K0tFWMKB8cg
   1czQzTPji6pCLVqP8RHPvYWZybTFrQEchGBB/9QXM/Xa7HUKl9PRsjG7R
   A==;
X-CSE-ConnectionGUID: c4xvbANdRe+OEINSPC1DFA==
X-CSE-MsgGUID: 6jBrI+q3TRWqg2UKmtlzDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21505788"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21505788"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:45:56 -0700
X-CSE-ConnectionGUID: SEz5XhzSR9Ge8Zj54q3Y6w==
X-CSE-MsgGUID: sH+kcbqoRnK6nvSrJEFlrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57439053"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:45:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scP0C-0000000DQ0R-1veG;
	Fri, 09 Aug 2024 15:45:52 +0300
Date: Fri, 9 Aug 2024 15:45:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Gordeev <alex@gordius.net>
Cc: linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH] pps: Update my email address.
Message-ID: <ZrYPgI5Ss7qgSuIf@smile.fi.intel.com>
References: <20240617131016.661879-1-alex@gordius.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617131016.661879-1-alex@gordius.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 17, 2024 at 03:10:11PM +0200, Alexander Gordeev wrote:
> The old email address at lvk.cs.msu.su doesn't exist anymore. I saw
> folks trying to reach me a few years ago, so I'd like to put my
> personal address here.

Consider updating the .mailmap if needed (meaning if you have an old address
in the Git history).

-- 
With Best Regards,
Andy Shevchenko



