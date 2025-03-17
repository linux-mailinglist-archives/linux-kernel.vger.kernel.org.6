Return-Path: <linux-kernel+bounces-564186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7EA64FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD459171B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1923A562;
	Mon, 17 Mar 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdCbHu94"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5E1C861C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215978; cv=none; b=Kg9iABhqMTtFZ9KDWktD7dBYdvj58aUaYfYF2mxidRxMNbDs+x7Q+8xWWBZ2xdimcTMAFP5U0xrVI4RT6XDcmIhzfVwlcrpSaRoFJxEg8U293fCTqdWyG4le7llgLsrV4bqs0FlMYB5wFKdEC96pdOO01xia1O+4jUK+TAXj8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215978; c=relaxed/simple;
	bh=xX2dfXbz/whGYXEP3FNbdkOtOCE7CtRILWO/R95E8jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHWLKRMI9WCWqGzTpuL/Q9qWW/cLRRkGYfoVyoUTvzk12XffNPEcYgYUQzdNKNouAHopSl7AhzejkLcqBo6WDoQSP/fGaS0M8zIuqa7YsLNIyuMfnwKloJluu2u8CSxWzXvOViEKWKlznS0ymuVCff7RxtYKOV2B4MplHQafQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdCbHu94; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742215977; x=1773751977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xX2dfXbz/whGYXEP3FNbdkOtOCE7CtRILWO/R95E8jM=;
  b=XdCbHu94QgcbMvpqebi8dlavUS0ZfUYTKiEbtTwIzKYZEhoclKBpD7hB
   bTrPv6RwNPn7GVRryGKR7bFiP9hq1ShFXRp/+hg96+d23JEfYIEOxmAEq
   mnGAfaLlEVVbJmvcGBff1q+8A33luMYNu96VgmzmMW/TYwhjl5hnkigt0
   +Mv1K7wdbXjNLGt7El5FhcCmcS4WiW/tiL/GjOpYpwkv+YHYoxugBxAfi
   5BSDsFVCz9lLoqn12xqpGcoyxqeB6vulRK3/eUOcvkAm+0K3knGoeRZ9/
   HCOBv3YA+ODre7G8DA94ccd3MRDM+JZf+L3Gk0bS3lRRqMLJHKW8v1Bun
   w==;
X-CSE-ConnectionGUID: xdmjoU7UT2aQgk7HUUV7Lw==
X-CSE-MsgGUID: PQlKTGrdRouH2eTNqrLQsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54687486"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="54687486"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 05:52:56 -0700
X-CSE-ConnectionGUID: 7f+Pg6nGTqiR10P+rZffJg==
X-CSE-MsgGUID: US+fvUVTS/+5gTDHMZv7hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="159082654"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 Mar 2025 05:52:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 350081E5; Mon, 17 Mar 2025 14:52:49 +0200 (EET)
Date: Mon, 17 Mar 2025 14:52:49 +0200
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"bhe@redhat.com" <bhe@redhat.com>, "seanjc@google.com" <seanjc@google.com>, 
	"x86@kernel.org" <x86@kernel.org>, "dyoung@redhat.com" <dyoung@redhat.com>, 
	"sagis@google.com" <sagis@google.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Message-ID: <gbxpvgmmzf354g3gccflrv5shtaque4rd3uklrgltlbnedip7y@hhwvyhxh46nk>
References: <cover.1741778537.git.kai.huang@intel.com>
 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>

On Thu, Mar 13, 2025 at 06:40:09PM +0000, Edgecombe, Rick P wrote:
> > Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
> > is supported by hardware.  Perform unconditional WBINVD to support TDX
> > instead of adding one more vendor-specific check.  Kexec is a slow path,
> > and the additional WBINVD is acceptable for the sake of simplicity and
> > maintainability.
> 
> Out of curiosity, do you know why this was not already needed for non-self snoop
> CPUs? Why can't there be other cache modes that get written back after the new
> kernel starts using the memory for something else?

KeyID is a hack. Memory controller is aware about KeyID, but not cache.
Cache considers KeyID as part of physical address. Two cache lines for the
same physical address with different KeyID are considered unrelated from
cache coherency PoV.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

