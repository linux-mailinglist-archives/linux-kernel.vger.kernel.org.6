Return-Path: <linux-kernel+bounces-307428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7A964D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990811F23285
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4731B81AE;
	Thu, 29 Aug 2024 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBWNYcF2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700514B086
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955050; cv=none; b=YWUSthFFfNGmAXHCiBZegX08APvJBj2fuOVAevMrFi7FnNtc2Y7rA/FSg6x/te1l4sON1XYbrtv2rY8fUv8UoNnm3AG5PA277TxUR2wJAuwgAdEs/90imdqINFtvFf53jLbTl+Mx2PAUtQzqqfwjsVyoiUcLG1DDdyXlSuHDjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955050; c=relaxed/simple;
	bh=vSKxJ++u4xJtuxTxpywMX3Pg61Yfik+zQcyDUxiVr8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRsHVUmZ3Hwc3hiiHEQ9gibhCn1wnTRx9ce81t4Pvs3j216XjliNFeDyelMLvqacOrB1t2f3GQ141TM+w6zeb3kDIvWzVxL+yqZVCndzqSrZk/d3LfnaHJKnKLmqzk6uhhRfas2N3ixOkMTQTSqZ+0G3OS9a2EWtXSrmZJUs2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBWNYcF2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724955048; x=1756491048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vSKxJ++u4xJtuxTxpywMX3Pg61Yfik+zQcyDUxiVr8E=;
  b=NBWNYcF2pKb3oAXDInEGUxFFkHzuuRjOMU1H6UrI607rlPNCRqMs+XZU
   QvRrNCBllRl+PsTpJBxFQsRX/j1fox67Q/bnfpkfmUghCY1E+PLQKe9gS
   DF8Ux2/gkOHGTJR+681gAe2YDrgC/DDHecFsftkIIXUHymbSoNEMX1cxk
   id5EoOw5cw86Ze9TogWXOZc6WtAGqOJvhXdINAfo/8Y/9HK9t/oSpUfoG
   huNZUPjAa5/qV5gTOSWYvYBqwooniNepiTn/wenURumFabCIFXXER4EhX
   Xv1XC2AR8EBLbtPLeJZfK9NAAfeVxGoU/qUG2fb6XYBhXoO1qaFVV64Fi
   A==;
X-CSE-ConnectionGUID: COoqP9DqQiKvVU1DUqkxdg==
X-CSE-MsgGUID: fZaxE8HUROuKGW2GvltfCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34185594"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34185594"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:10:47 -0700
X-CSE-ConnectionGUID: pJkcAG+DS6CfOpuFvtJcEQ==
X-CSE-MsgGUID: 7YB0f0vSS02HTmku9UBoHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68329336"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:10:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjjbV-000000036ZQ-48E7;
	Thu, 29 Aug 2024 21:10:41 +0300
Date: Thu, 29 Aug 2024 21:10:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
Message-ID: <ZtC5oXSzUuuIgLiQ@smile.fi.intel.com>
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
 <87cylrwahb.fsf@intel.com>
 <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 07:53:25PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2024 at 07:38:08PM +0300, Jani Nikula wrote:
> > On Thu, 29 Aug 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > With CONFIG_WERROR=y and `make W=1` build fails on my x86_64 machine.
> > > This is due to some unused functions. Hence these quick fixes.
> > 
> > Since when have we been getting the warnings for static inlines?
> 
> Do you want to see any additional information of my building environment?
> 
> Debian clang version 18.1.8 (9)

FWIW, clang-16 also behaves in the same way, Cc'ed to CLANG maintainers.

-- 
With Best Regards,
Andy Shevchenko



