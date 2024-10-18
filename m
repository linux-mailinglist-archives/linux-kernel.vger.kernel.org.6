Return-Path: <linux-kernel+bounces-371664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3529A3E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B440284B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABBC22331;
	Fri, 18 Oct 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGEBP3FC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA1EADC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254109; cv=none; b=Q1T43MunVabHf2wFUzn3iUpmeW34vGQdaDvLwATzJrIejrw09mMDs502HewaL+3eKJDuC03bSNNMbPST9n1mvI/c82gRNk5oxSFea7QqRk65GT9sLMvsuy8oriLX34CXKuhhHk0Y0EyLn9Kn8ZrJu7csI0Qz1NVC6OWceuxHle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254109; c=relaxed/simple;
	bh=Uv1d5K1klaFSKeuuhCGcrtsGP+uBJnKXAv1ai7A8dK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeZeNFEGvBTuf6P4kumdAYlQZereeG0dKAHw48iHN5clG2SZENiW0b9D6Yp0Kx42bkmPQQvztHkefh0l+Dn8VBVlNxk3mnBZWjm5D8g8S2VK4Yp9pTUr2vELslfJZffKXYo/jJ92EHU9bnKJhRaLv5iW+aWY///952Sot0CcdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGEBP3FC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254108; x=1760790108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uv1d5K1klaFSKeuuhCGcrtsGP+uBJnKXAv1ai7A8dK0=;
  b=CGEBP3FCPhbxZD6CNM8Pea2Hx+63wcO4/Kaeeb2gS+5IlBGGkE7dfMVA
   rlO/EUktp+4BA1LiXrWS4eZeBfxVuGj42Hc/PJUGXOVyzoX25UWL0kpzD
   bEB5OQ9Z6/PvqA6Eyja3P7MceIam/Z/SVZT5HW/qJWqEbgJU/W0NyMI/i
   P3YCZGJbuG2g2dSkeA8wqIHh7J4CM8HR9kvdm7A2juohpMcL8LZEFCWCT
   nrHQM1vVHEQGIg2NUltMlXQWiuHX12uyLYrEvK8SJaxF1mjUTs4YBpl6K
   hqcFMxl1wTWVaOEQms77bNpcLuW22hlno11KuTr9XuUy7NuGnstbL42Gl
   g==;
X-CSE-ConnectionGUID: Y5Oe0fzdTv+Zc/1pYtXu0g==
X-CSE-MsgGUID: UszwpCjMR3CrA/nInAz/Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28659208"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28659208"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:21:47 -0700
X-CSE-ConnectionGUID: 2AneYokkR8iQpnnn0XyHCQ==
X-CSE-MsgGUID: TB8hpo0kR9Sn1jG5bguG/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="82823777"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:21:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1lzA-00000004SPs-0tbc;
	Fri, 18 Oct 2024 15:21:40 +0300
Date: Fri, 18 Oct 2024 15:21:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
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
Message-ID: <ZxJS0_DUfgi4mHe1@smile.fi.intel.com>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
 <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
 <20241016192011.GY17263@noisy.programming.kicks-ass.net>
 <de705cdf-ccce-460f-846e-dfc63c63af1a@intel.com>
 <20241017181859.GB17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017181859.GB17263@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 17, 2024 at 08:18:59PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 16, 2024 at 12:44:18PM -0700, Dave Hansen wrote:
> 
> > Would anybody hate if we broke this up a bit, like:
> > 
> >         const typeof(var) _val = val;
> >         const int paoconst = __builtin_constant_p(val);
> >         const int paoinc   = paoconst && ((_val) == 1);
> >         const int paodec   = paoconst && ((_val) == (typeof(var))-1);
> > 
> > and then did
> > 
> > 	if (paoinc)
> > 		percpu_unary_op(size, qual, "inc", var);
> > 	...
> 
> I think that is an overall improvement. Proceed! :-)

Wouldn't typeof(var) be a regression? The val can be wider (in term of bits)
than var and cutting it like this might bring different result depending on
the signedness. TL;DR: Whatever is done, please add more (corner) test cases
to the percpu_test.c.

-- 
With Best Regards,
Andy Shevchenko



