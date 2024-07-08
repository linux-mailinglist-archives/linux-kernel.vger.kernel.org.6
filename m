Return-Path: <linux-kernel+bounces-244420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A792A40E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C1B1F217DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0C132121;
	Mon,  8 Jul 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S26sOscc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593C5381B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446678; cv=none; b=TyHvJMntRGDFtJ9npAPkVYi5ICG6/yv5txhMt5pZ9wkO4oaaBs02WGuVkVCTmquPcKc8mEy7uMiOm0gFmm7+tnSCefNpGPb+skE2FCdCZraJZRJQcmHj64kcqWCMH7OgiIvZvgvb1wlx7jXJNtGU8hkM0FCG35hBuSKXCLSEZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446678; c=relaxed/simple;
	bh=pWko05GGof4j2Z/fCXj05ykEWE4MVmDniId2gQhLqWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCsnqL+kSbFsq0ai1N7T3t7WZNg4a35J6vNPmkdWtzZm8UvQg2dh568pfAlPPBhdChp7Uecu9kDP/jxz4gTMl3MmsdTOQ3HaP9xTE2mCmNAfO2vA2FdmghB76qZJHT6Kqgg+P0GDXQCOYxnDT0noNuPLd6M5NQJe4WYRHObLb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S26sOscc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720446678; x=1751982678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pWko05GGof4j2Z/fCXj05ykEWE4MVmDniId2gQhLqWg=;
  b=S26sOscckzjEN++Yh39sGbdJi1NjTX90YUTxnGvQXzR8GExJJnMMLN4e
   QtzdRyAdK3sJtGOwkLD8N1aBtttzRZVX6Y0LG+ZEz93nUPoopihDNXlms
   b6pZgCpG+jE6idKeJ5rm6mw04iDqkRXyIQa7sCF9nZ51a6ipshdn9ghnz
   w6/sZtHceBYZEkj3Sr5dWiM5RfXFR8oYYpkKjFve+LT7S56amx+EwGIxr
   0LbPKgFuolOoCF5GHil+IqFXM5crvxNh+5bKwqSF/gXAgZ2pM/3JZAMA8
   5BUWZUpvpGCcRqZJD2pN3h7uCk7Mqh//tkj06hBD0xkP2F9gHpMh6cD69
   g==;
X-CSE-ConnectionGUID: FNRS86EqT0i3akdriFNvdQ==
X-CSE-MsgGUID: fxILOCybR46aobxAA6+vbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="20548791"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="20548791"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 06:51:17 -0700
X-CSE-ConnectionGUID: 6UCAwG2CSB+EgeDtur6MlQ==
X-CSE-MsgGUID: MjDdKtFgQe6Sv2NLZ2LUjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47281776"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jul 2024 06:51:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DFC8E1AC; Mon, 08 Jul 2024 16:51:12 +0300 (EEST)
Date: Mon, 8 Jul 2024 16:51:12 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dexuan Cui <decui@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <xa4zdohlxg2xeq3qjpaeycd5ixpkm3b4bjwm6mcoore6dfhiqt@xxbajpzq24je>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
 <SA1PR21MB131745AD18D9E91D2ACA1964BFDE2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5>
 <20240708133242.GCZovqepGsDSL72tjZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708133242.GCZovqepGsDSL72tjZ@fat_crate.local>

On Mon, Jul 08, 2024 at 03:32:42PM +0200, Borislav Petkov wrote:
> On Mon, Jul 08, 2024 at 03:34:34PM +0300, Kirill A. Shutemov wrote:
> > Borislav, could you drop the original patch from tip tree?
> 
> Long gone already.

Hm. I still see it in tip/x86/cc branch which is merged in tip/master.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

