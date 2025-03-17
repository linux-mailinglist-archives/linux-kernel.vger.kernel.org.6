Return-Path: <linux-kernel+bounces-564092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C677DA64DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DEC189702E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6323C380;
	Mon, 17 Mar 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQSthsj8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34134238169
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212775; cv=none; b=jIifBX7qok9l1r3KU4+alp9umj17NtICwp65vU72Zr26Cc9YQ12jvUBfyvdMmzGHrTIk4k7QPiAWc1MkPDDEjAa2Ps7x6A0E4Py424nuxFFYJ1FmbOvWlw0ZbK7+bf8zqHnqAVaqNwZF+QbvfQ/2tE7C2BJdWbw7aHLazXZ8jMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212775; c=relaxed/simple;
	bh=XFwYDEKcjNARc420Br7HZrIehcMEHv2O4FnRcaIVt6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMz6za5Q/GGcCX1ErTcu7vNNZGrUYH7PyofjmWN+FFVCVbMo3oAHY+wtt8tdz+pXlHXLu/EVa//ecPvum1CSt/QAjmw/ePGrzBWB+SpBXtc4VT/vM33chHtNMgXrcq0aWLk/tWclJCkokoAy65p8rw5YKbCkZnNZZmyVcBHbYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQSthsj8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742212774; x=1773748774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XFwYDEKcjNARc420Br7HZrIehcMEHv2O4FnRcaIVt6I=;
  b=dQSthsj8Qw3nI8qGD88atycdhCyRtzu/QKr8w6mRBARi/kRw0pQLzJ+L
   lFM/ICxCP4Sus9cSPW+LC096a20aZIsFddNjSkYLpjjclVCX+CQjbGveF
   lLX5zeQbg/YGhGKKLHeOK9TF6XVTVUaUb8H9Eq5UOzCKtrHwy50gjREkr
   vjcSgJIWjYfScpFPQz5kx/iV6rZco6ISaXq1NvSOsssCZ82w4f+1/mKZW
   PT38cEDSFL8sxlwSz2StD6lefaHQoIVmrJfxZIKurESX2yGuc6kMzsk77
   BMigkOk6EP1iC73v4XKwb0C3pigPdIEWq1Nt30qGHMItshv7DQ9Fcn3LG
   w==;
X-CSE-ConnectionGUID: SLXmxTwJT82kvkLuvKmJ1w==
X-CSE-MsgGUID: 3vIjHC/TQD2ADB329KF8dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="46069367"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="46069367"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 04:59:33 -0700
X-CSE-ConnectionGUID: 49VgUIGlTg6X23qk61NTDA==
X-CSE-MsgGUID: FidGX7h5QvKWATo2WsUIXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122655091"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Mar 2025 04:59:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 405B41FC; Mon, 17 Mar 2025 13:59:27 +0200 (EET)
Date: Mon, 17 Mar 2025 13:59:27 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Huang, Kai" <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <mfkjehhth2pwwzcueircxl57afmip5kwqlajopnjuwunztmqvn@vx6k62dgdxkq>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
 <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
 <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>
 <uchg74rtpcpwlkxgqww2n6nh23p4ouaswqc737xy7y6rqzowtb@pbf4whogx2s4>
 <0c6cab4ea4e898a62ecb0b047959f09011d3c85f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c6cab4ea4e898a62ecb0b047959f09011d3c85f.camel@infradead.org>

On Mon, Mar 17, 2025 at 11:32:42AM +0000, David Woodhouse wrote:
> > And we don't want MCE to be enabled during kexec for !TDX_GUEST:
> > 
> > https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com/
> 
> Actually now I've added proper exception handling in relocate_kernel
> perhaps we could rethink that. But that's for the future.

There still going to be a gap once the new kernel is started until it gets
proper exception handling in place.

> > I think we should patch AND instruction to include X86_CR4_MCE on
> > TDX_GUEST:
> > ...
> > -	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
> > -	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
> > +	ALTERNATIVE __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d), \
> > +		    __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57 | X86_CR4_MCE), %r13d), X86_FEATURE_TDX_GUEST
> 
> Yeah... although the reason I'm looking at this is because I want to
> kill the ALTERNATIVE so that I can move the relocate_kernel() function
> into a data section:
> https://lore.kernel.org/all/20241218212326.44qff3i5n6cxuu5d@jpoimboe/
> 
> So I think I'll do it like this instead:

Looks good to me. Thanks for the cleanup you are doing!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

