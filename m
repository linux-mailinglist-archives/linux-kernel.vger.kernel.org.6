Return-Path: <linux-kernel+bounces-319147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409096F888
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC66EB20EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CA11D318E;
	Fri,  6 Sep 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkQuaC+9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D31D2F65
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637422; cv=none; b=kdocdO2DTbiUpR45JM7bRY/BR+3wR5CUptbiQmK4OzltaH1OPVJo+5A989OBIek8D5ha8w63l24D3kBcodqJY26QMoYnWyfx9H3kHdFaPYuiITXNCIRqj7YCZADRo+X/z52TexoLNQybjTsQiyl76WhKcjosQ3/YgKjh6np5kQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637422; c=relaxed/simple;
	bh=5FDvh4fea6HWFs/qXnSsOsUIHGXCTXgCLjpn+Cc/8yM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGmksCTrhAqKIt3LG5XHVdDYBoOs5gKN3y3zkt1HedZUOhpN8nwDnKa3iHFdiTJYjY7XaboHwfWeesM7r7fLBG91Y3ySK4Skfks7fIQMxvWnP1k4DrG8E00hbom+iojYQXJ/Bd1sE6DDe6obVR9UDzoOOmLbiwFP1YrfSNW4nhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkQuaC+9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725637420; x=1757173420;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=5FDvh4fea6HWFs/qXnSsOsUIHGXCTXgCLjpn+Cc/8yM=;
  b=MkQuaC+9x8VvWotjGZx5d7ZtX6Z3yOn2SDQXxJimYY8Q+1y0feTcK0tX
   0egZ7vuLMhv0OaTQsiJY63fe+FphvfZqDn6QwXmGWF5V8owOO4PB1Z9wT
   o7FgsBw1QCJlcqVtfgRNj+B+7uKiM9XwkAVO1UF5625uEut+H43SmZaFy
   WhIPD4zrSPfKEVMA54x5czW3+exnKugCG9h4otPMMSbqLeU6/FxWRn4Rv
   aqOMBamUuvxypQ4Rycx5KcJRy0o0m9AgF8WFdb3l47uY250DrUgTQ8bcG
   wdoOq12hEKHxiyHzjzmle5No7uZW7pMMCByDLIGELwGTN0YGUpCwQDzBK
   A==;
X-CSE-ConnectionGUID: VffPyVbeQrKW4l6EGsxCFQ==
X-CSE-MsgGUID: RamcLHc9RWGnGTr5uGj63A==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24349664"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24349664"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:43:39 -0700
X-CSE-ConnectionGUID: L0dOF7V6Ts+sggY5gOybcg==
X-CSE-MsgGUID: vYswIGANTV+XEgUtmza+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="65960892"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:43:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smb7X-00000005qmn-0yUi;
	Fri, 06 Sep 2024 18:43:35 +0300
Date: Fri, 6 Sep 2024 18:43:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] maple_tree: Drop unused functions to fix the build
Message-ID: <ZtsjJoGKRxszp-m6@smile.fi.intel.com>
References: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
 <krsjmi43ziyojqicc4pxzwfwbffqrnk5npbuoq6l2cnq5eovkd@afofyteb5wo3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <krsjmi43ziyojqicc4pxzwfwbffqrnk5npbuoq6l2cnq5eovkd@afofyteb5wo3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 06, 2024 at 11:26:26AM -0400, Liam R. Howlett wrote:
> This exists to stop people from using the bits while the feature is in
> active development.  We had the same patch a few days (weeks?) ago.

This breaks build. Can you propose better solution, please?

> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240906 11:05]:
> > A few functions defined but not used. This, in particular,
> > prevents kernel builds with clang, `make W=1` and CONFIG_WERROR=y:
> > 
> > lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> >   351 | static inline void *mte_set_full(const struct maple_enode *node)
> >       |                     ^~~~~~~~~~~~
> > lib/maple_tree.c:356:21: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
> >   356 | static inline void *mte_clear_full(const struct maple_enode *node)
> >       |                     ^~~~~~~~~~~~~~
> > lib/maple_tree.c:361:20: error: unused function 'mte_has_null' [-Werror,-Wunused-function]
> >   361 | static inline bool mte_has_null(const struct maple_enode *node)
> >       |                    ^~~~~~~~~~~~
> > 
> > Fix this by dropping unused functions.
> > 
> > See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > inline functions for W=1 build").
> > 
> > Fixes: 6e7ba8b5e238 ("maple_tree: mte_set_full() and mte_clear_full() clang-analyzer clean up")
> > Fixes: 54a611b60590 ("Maple Tree: add new data structure")

-- 
With Best Regards,
Andy Shevchenko



