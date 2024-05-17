Return-Path: <linux-kernel+bounces-182369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C58C8A70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0646EB2124D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D312F5A3;
	Fri, 17 May 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9c6d75I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668D13D8A4
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965325; cv=none; b=MpetDO8nj9Yql4nztwiVhIUwW3ao8PTYVPj45yZ8y7FCRsVcF8VdsSDrTjQn8xgzyP/8BYP/a2tb9btN3iQoy/8jTX2pmFr2vKTcZvoJrfHkJ9aOVElhp5cmKRA5vu19Af05lxnxan3vxNcgk0fzvwgtTB1CASzkXvBke18Mu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965325; c=relaxed/simple;
	bh=H+EvpBf6pswp2gX6gZhZ68YxCyQ5fSrs1cR8Pzgu4w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT8uKa4HN2G8EYXNwG74BwP4IgBV7RSwspulDSAfaDSYytDQ+uUrn/s+QvbnbfzfzHU3kHXHiNzfz+VkNoVxEGpTAY4pAS3tR81Z32dyVtASiWEN3Sl2ddxNnKzf5tegoJM2ygaQCuObaGG5dTAjgIfo3TqGz1vbQbFCCj9b0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9c6d75I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715965324; x=1747501324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+EvpBf6pswp2gX6gZhZ68YxCyQ5fSrs1cR8Pzgu4w8=;
  b=X9c6d75IxmoQ1XIeN20JqkvSToRoMydYmaYx4xWmXKwJZ517FcXSflUV
   ZHwJe3u50XxM5wWtts7OM7Wdtiz2q/6p5q1T4QbltbvIecIoQPJK6iLu0
   krLb+04JgGZYBYx7zSCfSe5BAcEofA5ukvwTwYQN/vuVlDOkLSdaPKizO
   0ooS8xCu8US+sMUGDFMsB3smF+f3a4GbXL42A24QzW0D8Upm1q0W6AlZU
   yqAOcUfcjzsuqy+fiOmEwsHfgHAJ4ntQCLArTqn5Pq+fvv/35O2Ecjgh5
   Y+Xx983rph+2Vn83QBwTj9OJuSRcEXQn3/aK8l1kEzJLTQQNVZFIABQ3o
   w==;
X-CSE-ConnectionGUID: ExDfi3jmRUedNYR248VFbw==
X-CSE-MsgGUID: s6i0ZON7TQyO6mPv28zYLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12370872"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12370872"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 10:02:02 -0700
X-CSE-ConnectionGUID: LWtIx8EoQ0+ZMpm8SJlxAw==
X-CSE-MsgGUID: L497DCLgQlGVvKyVJNK1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36268568"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 17 May 2024 10:02:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0314D1F1; Fri, 17 May 2024 20:01:58 +0300 (EEST)
Date: Fri, 17 May 2024 20:01:58 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Message-ID: <go4cg77ig4lwdic7irxoodatzgrpx2xrmcurzsdlligcrw2i4e@cnrbbjxdtjso>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <Zkd28IN8KvyD4GIX@google.com>
 <551d2539-91b4-41e1-97e6-701921e83db7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551d2539-91b4-41e1-97e6-701921e83db7@intel.com>

On Fri, May 17, 2024 at 09:34:56AM -0700, Dave Hansen wrote:
> On 5/17/24 09:12, Sean Christopherson wrote:
> >> There's a feature in TDX module 1.5 that prevents RBP modification across
> >> TDH.VP.ENTER SEAMCALL. See NO_RBP_MOD in TDX Module 1.5 ABI spec.
> > LOL, "feature".  How was clobbering RBP not treated as a bug?  I'm party joking,
> > but also quite serious. 
> 
> I'm on the same page.  It would have been far simpler for all involved
> to retroactively say that modifying RBP is against the rules and any
> module that does it is buggy. Get a new module if yours is buggy.
> 
> I _believe_ the intent was to support guest/host combinations that used
> RBP for whatever reason.  But I'm not sure such a combination exists or
> ever existed in practice.

There's a bug in EDK2. It specifies RBP in mask of registers to pass to
VMM. NO_RBP_MOD breaks it :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

