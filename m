Return-Path: <linux-kernel+bounces-571394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA6A6BCA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A993B5827
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295713C695;
	Fri, 21 Mar 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uwh+Xj8K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA478F6B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566254; cv=none; b=E41MJ0ppDzXaslSRPg6QsvVIkiiLO+oxeyUpq6LCx8zjDE86IFNgTnnr1xnsP4CHihQbMpueSA62TmQTIwfFJPefbVgglH+F6NfZxDau6d71SlBtQNF7so5IkDP7E4azlA/izj+n5fpga9Q+TCZp6uALw5l9BGbdKy52LmYHycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566254; c=relaxed/simple;
	bh=Bn8WmnLE1Xfs2Q5++tSyH6lu/aVCwD+OhBnLFKqtyH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fixGbXYBTqPGoYXmgKKJo3D236IrW4AvwI0EUfLhTHUM+hev34xlw3nvdNi70+ZFCUYjEiLSUxIULOYQHTnRtw493fiHLq4pSkA/7Io1fYEQQsj+Vk7gDzTzEIqtGEvQVXnJJVnbvakjA0jor0vALw/diYwe2ylDX3KZ6TalQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uwh+Xj8K; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742566252; x=1774102252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bn8WmnLE1Xfs2Q5++tSyH6lu/aVCwD+OhBnLFKqtyH4=;
  b=Uwh+Xj8K4JWmsBp8BiRVuPvkWsZXVKVgk52hnT5bcIlr4CYtQEpnaZW6
   /8te1L6S2GrMc59OmmGjQtHxO2FanhR3pGLjhhFlktuapF0Q4akdFuQ3p
   P+1s4ibmvVFLLAKYuSRbCnVi22ri+cgju2/O7zVFp7pwcQ0wq2RRp6cMR
   i63uIcvqMqaCliFB+7SPDYPF6K20qauI9+spHbDmu0RozWVhgtBNFq26Q
   eTXw2NNTbzXw1ORXAJfVEOCPt3+QQdpg61h0TA82eEH3b097ESa6A2If7
   ri/gdJsB9LG43IxPJ/EoWMSK0D64aV8hIj9+C8y4qhL7RLMtfdfwjRkcf
   w==;
X-CSE-ConnectionGUID: XFYXAUVnT8esjafWQgPxsA==
X-CSE-MsgGUID: MrpsN40BRda3TKTGVZK0aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54828282"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54828282"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:10:52 -0700
X-CSE-ConnectionGUID: 4CujWF/QSief0PenwjJhzA==
X-CSE-MsgGUID: buMhY2yDQneSTS7+VVSABA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123389783"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:10:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvd5D-00000004XCN-0DCV;
	Fri, 21 Mar 2025 16:10:47 +0200
Date: Fri, 21 Mar 2025 16:10:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Kees Cook <kees@kernel.org>, "tamird@gmail.com" <tamird@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printf: add tests for generic FourCCs
Message-ID: <Z91zZs_mvgR8EDZx@smile.fi.intel.com>
References: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 14, 2025 at 03:45:01AM +0000, Aditya Garg wrote:
> From: Aditya Garg <gargaditya08@live.com>
> 
> Format specifiers for printing generic 32-bit FourCCs were recently added
> to vsprintf. They are going through the DRM tree alongwith the appletbdrm
> driver. Since the printf tests are being converted to kunit, this separate
> patch for the tests should make it easier to rebase when the merge window
> opens.

I am always for the additional test cases!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



