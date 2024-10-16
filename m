Return-Path: <linux-kernel+bounces-368566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 947479A116B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DAAB21FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0820C03B;
	Wed, 16 Oct 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eChrfsz8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9ED185939
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102813; cv=none; b=OnVWtD95VQT5LkWO4lPyDZzSx8z6ski6GFtkK0n0/DIPxbxukkmylUjdQepOjXCGizJazw/6TIDPpCoA0WtKLOg/ymE5QYqMDsJYg2YiWY4G/wS5ssoxWoQkht98XAoBNgJBwns2aJlfYlvPP/LxmFfbyjKmG+dOi+YBRj/qhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102813; c=relaxed/simple;
	bh=asShdv9v8uS093w6wQHmJM/MPm08b8CD1idDYHcSA9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfFe/rzyhhySXouynFyHf24LO7hlTjtuS8zGQQXmDDz787ryLNVdTS0cxs+PsMe9IcmyDePOVy+9Fwk0jA3ZmvwZZgbFLcFaZN230O/rD4GQQO8EH8rbOOAoeAZvk+hcjbzviDrtIbphKZa/5HqHo8l2oyhfzPD5P7BP2l3clx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eChrfsz8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729102812; x=1760638812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asShdv9v8uS093w6wQHmJM/MPm08b8CD1idDYHcSA9M=;
  b=eChrfsz8g0W1iT0TFspMdvGCQwLbxJoPDaS1jJzwbI7BMVM4euxM6YVn
   QXQ3lcZ8oYZzS9zw1vNpYDymsvlcQhJgX8PJqqrJQ1HuaO22cWi2T3sNK
   wHmi7gcfkoNBJAvKcPXgPj4/HXUJQif4E5DIW3DnlzMr5cwFbtVBa35+Y
   dX9PWqcxPE3zqonNbpSY9370zUm/Bx3l/iiXPi5QfKsd5cWiUdvhjzF7Y
   O0kriNxcHdQpQlv2Mb+7MSDPRbplICzuqUB9aRAmxH1lfhTna8BkPRJa3
   eNSEPGoHEF25r7ROot0A5f0cfOowcG8pR5X0b5OVFtBoJYvZYdrGJMmPq
   A==;
X-CSE-ConnectionGUID: whwWw5B3R+2CuKYZ3Obj5g==
X-CSE-MsgGUID: VN6k9RAyQhCo+PGe/6nn3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28008340"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28008340"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:20:11 -0700
X-CSE-ConnectionGUID: 3niBpy1/R624DLq2Gby+eQ==
X-CSE-MsgGUID: GgC6IEmPTQi7O/UgQS9nvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78341263"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:20:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t18cu-00000003ruF-02Dx;
	Wed, 16 Oct 2024 21:20:04 +0300
Date: Wed, 16 Oct 2024 21:20:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when
 comparing in percpu_add_op()
Message-ID: <ZxAD0-kQJ0_lDxje@smile.fi.intel.com>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
 <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
 <ZxAAlEyvxzWpwQQ0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxAAlEyvxzWpwQQ0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 16, 2024 at 09:06:13PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 16, 2024 at 08:44:56AM -0700, Dave Hansen wrote:

...

> > This doesn't _look_ right.

See below.

...

> Maybe more readable, but wouldn't it be theoretically buggy for u64?
> I'm talking about the case when u64 == UINT_MAX, which will be true
> in your case and false in mine.
> 
> >         const int pao_ID__ = (__builtin_constant_p(val) &&
> >                               ((val) == 1 || (int)(val) == -1)) ?
> > 
> >                                 (int)(val) : 0;

This code _is_ buggy, thanks to my new test case.

[   66.161375] pcp -1 (0xffffffffffffffff) != expected 4294967295 (0xffffffff)

Hence, I'll send a v2 with the test case and updated Subject.

-- 
With Best Regards,
Andy Shevchenko



