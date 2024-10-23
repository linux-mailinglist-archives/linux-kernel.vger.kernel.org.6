Return-Path: <linux-kernel+bounces-378163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7939ACC37
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677D7B238F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ECF1BE223;
	Wed, 23 Oct 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqyI0ShH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5351BD039
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693502; cv=none; b=RuGuDi0Y0i2tvFKdMTDniHsSR2TqoUafycH5VTaJA2U0GU019e/jdWzrkFDwMAtGL6/h8SU37oXwspNZNFOZtIz5ERcPZ5g7OqW6E6bQPWb8R6BiNb0NSE8wWzpCKSCO+3fc2gac5TZqKq+S0LtraIWmnVAUyNW5P0dMksQS2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693502; c=relaxed/simple;
	bh=SSzHZSLHISFuoqbjbDT/5aD+AUvvdJkkWZLs3kZ6uKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csgNoGBTw8VyKNe7csEcmP9zczSguzkkpNreMmSB/prvgmMmP3oiYsT65XdYwYXHJE2sN1oPg4sH8MbSKY3bMu5GCPZ4k5sERBNcKbnaOZN3TRZHG2E8KcAYfftFqISTAXE4knRDSkfTyCsgfdyZTcwPRX+jzUKh0AVWCAIEC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqyI0ShH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729693501; x=1761229501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SSzHZSLHISFuoqbjbDT/5aD+AUvvdJkkWZLs3kZ6uKQ=;
  b=CqyI0ShHrD/JtA7MGeKR6H6wdm2S1mTb0fh54wA9Fn4ljkjmwbhSmVnK
   EiSyBzHlhY20uuAIHN8SSOhjHd5bqp3XfpLeG/gTik61zalXildhMKndP
   CfATcVGpx6Kd9k9Fv1AOCUYNz2d6RtgwWIXOsBh0ElP5+aoJ7nm3LP5Kw
   +RyZ9gSbRCaMdmrEY+6gTFbMpBY3cGM2nGWtLTnTtr3A/bDROUUxdGNme
   eW0wNr9AKbV829KWT+2b0nFItfTeradUixSIkJxDdUQqnv9sAwm5IvCHj
   mpU+52ekH0wWXOF7m65Ip+7xdrZrow9WOtIGGPzORCeDTdTCFEp1XV3ws
   w==;
X-CSE-ConnectionGUID: zB16+xZcSXisO/iAxIs4hA==
X-CSE-MsgGUID: tYQ6m8TxR06kcIy04z3jsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29505016"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="29505016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:25:00 -0700
X-CSE-ConnectionGUID: LnS8vSTAQfyiJw0jqwzVoQ==
X-CSE-MsgGUID: wUeEaWojRf6UmnDhSNOvuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84802141"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:24:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t3cI8-00000006EZV-2aip;
	Wed, 23 Oct 2024 17:24:52 +0300
Date: Wed, 23 Oct 2024 17:24:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <ZxkHNDB6EcA7PouV@smile.fi.intel.com>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
 <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
 <20241016192011.GY17263@noisy.programming.kicks-ass.net>
 <de705cdf-ccce-460f-846e-dfc63c63af1a@intel.com>
 <20241017181859.GB17263@noisy.programming.kicks-ass.net>
 <c22fd9c5-6727-46c2-a811-784315edf7cb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c22fd9c5-6727-46c2-a811-784315edf7cb@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 22, 2024 at 12:53:01PM -0700, Dave Hansen wrote:
> On 10/17/24 11:18, Peter Zijlstra wrote:
> > On Wed, Oct 16, 2024 at 12:44:18PM -0700, Dave Hansen wrote:

...

> >> Would anybody hate if we broke this up a bit, like:
> >>
> >>         const typeof(var) _val = val;
> >>         const int paoconst = __builtin_constant_p(val);
> >>         const int paoinc   = paoconst && ((_val) == 1);
> >>         const int paodec   = paoconst && ((_val) == (typeof(var))-1);
> >>
> >> and then did
> >>
> >> 	if (paoinc)
> >> 		percpu_unary_op(size, qual, "inc", var);
> >> 	...
> > I think that is an overall improvement. Proceed! 🙂
> 
> I poked at this a bit:

Thanks for looking into this!

> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/?h=testme&id=30e0899c6ab7fe1134e4b96db963f0be89b1dd5a
> 
> I believe it functions fine.  But it surprised me with a few things.
> Here's one.  I assumed that doing an add((unsigned)-1) would be rare.
> It's not.  It's actually pretty common because this:
> 
> #define this_cpu_sub(pcp, val)  this_cpu_add(pcp, -(typeof(pcp))(val))
> 
> ends up causing problems when 'pcp' is an unsigned type.  For example,
> in this chain:
> 
> 	mem_cgroup_exit ->
> 	obj_cgroup_put ->
> 	percpu_ref_put ->
> 	percpu_ref_put_many(ref, 1) ->
> 	this_cpu_sub
> 
> the compiler can see the '1' constant.  It effectively expands to:
> 
> 	this_cpu_add(pcp, -(unsigned long)(1))
> 
> With the old code, gcc manages to generate a 'dec'.  Clang generates an
> 'add'.  With my hack above both compilers generate an 'add'.  This
> actually matters in some code that seems potentially rather performance
> sensitive:
> 
> add/remove: 0/0 grow/shrink: 219/9 up/down: 755/-141 (614)
> Function                                     old     new   delta
> flush_end_io                                 905    1070    +165
> x86_pmu_cancel_txn                           242     338     +96
> lru_add                                      554     594     +40
> mlock_folio_batch                           3264    3300     +36
> compaction_alloc                            3813    3838     +25
> tcp_leave_memory_pressure                     86     110     +24
> account_guest_time                           270     287     +17
> ...
> 
> So I think Peter's version was the best.  It shuts up clang and also
> preserves the existing (good) gcc 'sub' behavior.  I'll send it out for
> real in a bit, but I'm thinking of something like the attached patch.

I am fine as long as you keep the (added) test cases and maybe even extend
them. I dunno how you will go with the fact that Andrew applied my version
already.

...

> This can be quickly reproduced by setting CONFIG_WERROR=y and running:
> 
> 	make W=1 CC=clang-14 net/ipv4/tcp_output.o

Hint: You can use LLVM=-14 instead of CC=clang-14.

-- 
With Best Regards,
Andy Shevchenko



