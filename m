Return-Path: <linux-kernel+bounces-310832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD59681CA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CE1B20BA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763F5186607;
	Mon,  2 Sep 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWS2HCVQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A6152E12
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265696; cv=none; b=NjZJYewzmw8YD0BRSCNUGoFFXgpjkQcUKeOn8MMPx+5aGDBB1TtdoMTCX2utR35s5giYymkh62XC8CfYV6xTnzm5zutaDjZFvOa6j5SfN8JLExZU/BiWChpuKva3f7qmciLT/kxkxcBlA/c8gAzQyScxWFTu+PWSKIUPjgfvgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265696; c=relaxed/simple;
	bh=DYSBPcOtKIOt23SoN4rcguGH6srPkSaQ8dPaje/1vFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rQVE2P9TYZaks564YQ3jSP25Wedlv1JS2oRJFxEnUPLmTYRrFiVHAxe6BunFAF0FMKG1skVRgiRC0dN08Z6rYpPP3vSThbVdO45akhzZ3xyScN0xRMlBAK3tRPKG/jPegQIo4YQliIOfzLxlYPXt7hVgc7P93chFQRcFBvp5AiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWS2HCVQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725265695; x=1756801695;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DYSBPcOtKIOt23SoN4rcguGH6srPkSaQ8dPaje/1vFQ=;
  b=mWS2HCVQ/PGpZwt4Dp+IbgVrwaV/xQXx7XQlsobHTqsc7/ACVgA9WQIg
   +VuJvNvggFC896z54eMMzB7VbvazGSLMIiMM9seECD3d1OJnn5fu4x0Y2
   NMSK9Z1o1qrrjZM9V2Jc6wjHFKw/Ri4wxE8u697Y8MLg4xV72MLJDhKl1
   EFojMyKUu14JR3RX5SO4kOYLEl/WYGQwpmFV2KhvEbPepWByqvYE/kw0N
   tzWJSpn8QhovzZ69wIzIUvwOd1G+sAxSiHMIbPEnk8I7+C787XtUtqQqx
   vTfJlXYr8O1AS7WebZqd8GnI7dMFob89alKnen3gbTnP0zimY06XiifM1
   Q==;
X-CSE-ConnectionGUID: 1FHJXvMXR2Oz6qAW4Vl1qQ==
X-CSE-MsgGUID: cPj8kIIMSYuS/ZC/gmd1/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="49239298"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="49239298"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 01:28:14 -0700
X-CSE-ConnectionGUID: NnCR8tGQR5uk4wKIhAbeGA==
X-CSE-MsgGUID: n5lNv2IZRpi6epXfQTS9xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64168831"
Received: from ltuz-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 01:28:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
In-Reply-To: <87a5gvw4y9.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
 <87cylrwahb.fsf@intel.com> <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
 <ZtC5oXSzUuuIgLiQ@smile.fi.intel.com>
 <20240829182255.GA1468662@thelio-3990X> <87a5gvw4y9.fsf@intel.com>
Date: Mon, 02 Sep 2024 11:27:57 +0300
Message-ID: <87frqiv4s2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 29 Aug 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> The TL;DR is,
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> on the series.

Both pushed to drm-intel-next, thanks for the patches and discussion.

I amended the commit message about clang, config options and commit
6863f5643dd7 ("kbuild: allow Clang to find unused static inline
functions for W=1 build") while pushing.

BR,
Jani.

-- 
Jani Nikula, Intel

