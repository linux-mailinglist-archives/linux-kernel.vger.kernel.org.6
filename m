Return-Path: <linux-kernel+bounces-322654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B31972BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627FB1C2475F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A2C17E8F7;
	Tue, 10 Sep 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrY8+fbl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAE184543
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956162; cv=none; b=D/jG17rXOnD2uxwPsH7jQQFQoSXCngSBNWc1i95H6qUhwFNZ65/EqnabwY/ZAhROFtqphKR10WPAHUwdP2i8fGBFXsmgLa6UNBa24CuYDAzuQx9lw/UM0sZs0gTcqyGEITgxpduGytZ8rCe8WqH/FfwkXXvAvnGO+W7lZFFLAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956162; c=relaxed/simple;
	bh=iI9ZBYfUiYL+1l+qZb2XVZ21QSU93RVyyGS3heg4cgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy1EbtFN+bwKbtE6vtKvIoB0Mf7RQ7pXqJTNgtBsTrJcBTI5YnuJN506WEDddCBj5/soKeYACY5hJPmZa365CAKwwewZYUW4r05owKhJS+G0j5XO0v0gGmDpfnpYVAE9RF5OWlIG+Vi9x82xVX87GA5UXCQejFieFsr/g9amthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrY8+fbl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725956160; x=1757492160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iI9ZBYfUiYL+1l+qZb2XVZ21QSU93RVyyGS3heg4cgY=;
  b=CrY8+fblYtzkP+05i92XfI9gqAwmF7JZivSUHyz9fUsLFFq3e6JsYCyx
   HIL1Pv2w3jWhvzdQ6ulWPR4mHtnNsIPcKRkcJzWFxo46KhcqruMCJuWxY
   3bjUGe0iDxs+x4UZ1ZzObVRJBC6CBwHKOqXyyqpCmdyS6oTjCghFJT0iZ
   tKVjmJW9HSt+3ZQrfhf8tl+uScOyyqAgCvlR7ZNQyeHKhCWmTlOzrplLu
   y/gf3GjAwrddZgRjnoB7Kh41Wxd/oJ8/idg9h1DcGndPGjXfFghpkcmvc
   fMK8p52TxaeumoSBMrkREadCkF4caeYU5dTHc6cDWggm7j3p2iP92N4o3
   g==;
X-CSE-ConnectionGUID: L9XQEP8PRC2z6UMmR1k74Q==
X-CSE-MsgGUID: MyLQFfUrQnSmVw6SrtonkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28467623"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="28467623"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 01:16:00 -0700
X-CSE-ConnectionGUID: JutF6gmnQZ6e6HJhPwUA2w==
X-CSE-MsgGUID: ttpprLqtTs6688dhZnrYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="97765737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 01:15:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snw2U-000000077IW-22mj;
	Tue, 10 Sep 2024 11:15:54 +0300
Date: Tue, 10 Sep 2024 11:15:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] locking/rwsem: Move is_rwsem_reader_owned() and
 rwsem_owner() under CONFIG_DEBUG_RWSEMS
Message-ID: <ZuAAOmjTGYEFQJPC@smile.fi.intel.com>
References: <20240909182905.161156-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909182905.161156-1-longman@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 09, 2024 at 02:29:05PM -0400, Waiman Long wrote:
> Both is_rwsem_reader_owned() and rwsem_owner() are currently only used when
> CONFIG_DEBUG_RWSEMS is defined. This causes a compilation error with clang
> when `make W=1` and CONFIG_WERROR=y:
> 
> kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
>   187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
>       |                    ^~~~~~~~~~~~~~~~~~~~~
> kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
>   271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
>       |                                   ^~~~~~~~~~~
> 
> Fix this by moving these two functions under the CONFIG_DEBUG_RWSEMS define.

At least this solves my issue,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



