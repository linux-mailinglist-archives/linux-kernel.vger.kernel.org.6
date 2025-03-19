Return-Path: <linux-kernel+bounces-568425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A2A69537
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DB2881659
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AA1E0DB5;
	Wed, 19 Mar 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo2sQHxf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879381DF738
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402525; cv=none; b=pn6NNJX+enJ2J+a8XBG7d/s8mnfRH9arT2iWIL4FRS8+bwLuYIfegRmnO5d2NAKgzRf7rGWcU24HGcKp5VO0llKmEsPeGm/fxN+tRAs8eNmXu98ByPm+chLLoRwCcqrZV1Xgk3r3RrLmP8pLL9YUPe3uh59tnffPUgqDS8C7j+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402525; c=relaxed/simple;
	bh=YGurIX7ie8jX+exltAZFqUn0uiN28uBJB9wEEK4O4kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c00jOHOI1V19g55lqxsmhh+ZODuj3028sKaGClBodDk3DN8boCE0FHl1NClUdBjuREOOWsvn9RVexz77IXJMz6lM2b+OSMR/X6zAeziH8GJJ7rug0S57nxSu+zDXvtdJv6qgMn2lTMQ2Jpq6itzNxG6Wr+yQdC68AJOngzcHXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo2sQHxf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742402523; x=1773938523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YGurIX7ie8jX+exltAZFqUn0uiN28uBJB9wEEK4O4kA=;
  b=Fo2sQHxfVEZ3/+jI/q+5SOhVl4OFoBFwBYrQS2zBKPsoHpRtgitQBnhn
   ZSGx/8qsKN88z7+s1mKvpTG7A2192w7U8oRpVbpijXybZZRq27RMIdkSd
   aXsY+FkJOkvvybWdhy7RimEJ5jFJEXgz99iFCAnc9z1ek/kLLXkLq/qzD
   gr3bZF4605A1D/Z6j0NgYQI0aPtBnV8i8UgrZPd9xjY2SytT0MoG1myPw
   21TW5ZhynAB6iVTO3lfPcdyHcHMz6k/YizX22fd5TaLdPy6m7nOl8I2LM
   HtoeeQVmHN4IQkDaxLndjldSyLupcNPFiTvACHjL3Ud9atVvbSD4luPVN
   A==;
X-CSE-ConnectionGUID: s7aJb/FCRHuniNrzKHruuQ==
X-CSE-MsgGUID: kO/lfipRRVOqPSdUHYcExQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43474403"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43474403"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:41:16 -0700
X-CSE-ConnectionGUID: cI8lT+PNT0ulPmll5xG+qw==
X-CSE-MsgGUID: pq3IBz+WSHyiDWTEaJTa2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122519629"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.19]) ([10.125.110.19])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:41:16 -0700
Message-ID: <eb2e3b02-cf5e-4848-8f1d-9f3af8f9c96b@intel.com>
Date: Wed, 19 Mar 2025 09:41:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>,
 "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
 "dyoung@redhat.com" <dyoung@redhat.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "bhe@redhat.com" <bhe@redhat.com>, "Yamahata, Isaku"
 <isaku.yamahata@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "sagis@google.com" <sagis@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "x86@kernel.org" <x86@kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
 <gbxpvgmmzf354g3gccflrv5shtaque4rd3uklrgltlbnedip7y@hhwvyhxh46nk>
 <c7cec9118a23220986c1894f18cafb3aa5b9fc1f.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <c7cec9118a23220986c1894f18cafb3aa5b9fc1f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 14:59, Edgecombe, Rick P wrote:
> Sure, but non-selfsnoop CPUs can have trouble when PAT aliases cachetypes, I
> guess. This came up in KVM recently.
> 
> So if new kernel maps the same memory with a different memtype I thought it
> might be a similar problem.
Yeah, both the KeyIDs and memtypes mismatches are places that normal
cache coherency breaks. They break it in different ways for sure, but
it's still broken in a way that software has to work around.

As for kexec vs. PAT memtypes, there are only even theoretical issues on
old hardware.  They _theoretically_ need a WBINVD at kexec. But there
might be enough other things happening during kexec (including other
WBINVD's) to keep us from getting bitten in practice.

I'm not going to lose any sleep over it though.

