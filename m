Return-Path: <linux-kernel+bounces-521737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36172A3C1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E224F189A312
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7E31F30C0;
	Wed, 19 Feb 2025 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caUpztk5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012B1EEA34
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973819; cv=none; b=EnXjIbjWlF1bgy9GP7WPvm6a+EID2LfxzXVn1czw+nCBMejVg+Vhy7mAl/vcDNviaMTtCIvHFtysWAbjuAmWcUtzv2ppKwWWtZ3jErIaDgiJK3XvK1Zqq9dPS3dVmnhrx12gUIJD/G3KehaBN3bGh1ZsD9Q4rPnYhRroCif/WEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973819; c=relaxed/simple;
	bh=QmbQLkkDdQ72D1Tjn3A14Gl1CAEBwtZyNkBzH5iXLzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr8J/sgYz8Oa1gzJK0M0dSuTS5qnXvi9S2+5gQgiT3v2S4WU4/dblItG+LCZbKRM35kz2t0ABn+yDOAwWAtq65ODwac39ZF8q43jJqKGJkKLuMxI4NTPyfztmfZyaraAi5eRPpaCFJfCqufsNWdqKL+oA9/yELtQOPJh+NHUl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caUpztk5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739973817; x=1771509817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QmbQLkkDdQ72D1Tjn3A14Gl1CAEBwtZyNkBzH5iXLzU=;
  b=caUpztk5bMOmYWO/ObiA2YFU1k+OCzM5EdGB9Ep6UeAuK61d4EfqQSuW
   nK2PhZtyUZ0blbr/XydXdJfOpYOCt5a6um9n0ab+hkCCD5eY3EE8MUqxQ
   pOKbsgz9TbTMEi14wOco+66pkL0ae3RoGPNleYpzTwcB4Di11YDPBaE7v
   DeedHdhIdUsjwTswsv21u4qGykF9cf9WlTDN6aAzE/qKuHsghOOdc6/yo
   y2pQxjF2D2Otf1F4mlqxhqXaoikXppBydL8C+G0m+YDlWmmuibjCw0+V9
   dDuRXBmTz5gH/1TPUm7OF276pUSllulUt4IPSDyy51ck+PoxWpi4R60Gc
   Q==;
X-CSE-ConnectionGUID: mVcGvILNTjy0otc3FZokZw==
X-CSE-MsgGUID: s1lkdqONT1i2nsIF7I8dLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44477502"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44477502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:03:26 -0800
X-CSE-ConnectionGUID: 8Ea9qZleTLapvJoMw6xpQA==
X-CSE-MsgGUID: KjvrAP6aQgCFGCMW5B3nLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114572569"
Received: from opintica-mobl1 (HELO himmelriiki) ([10.245.245.206])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:03:22 -0800
Date: Wed, 19 Feb 2025 16:03:13 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
Message-ID: <Z7XkoQ1cJNw8dn3I@himmelriiki>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <Z7Sd6FuDDMgExEna@himmelriiki>
 <465d712c-b638-4884-88c8-1a88c506efdf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465d712c-b638-4884-88c8-1a88c506efdf@intel.com>

On Tue, Feb 18, 2025 at 10:04:19PM -0600, Xing, Cedric wrote:
> On 2/18/2025 8:49 AM, Mikko Ylinen wrote:
> > On Thu, Feb 13, 2025 at 03:50:19PM -0600, Xing, Cedric wrote:
> > > On 2/13/2025 10:58 AM, Dave Hansen wrote:
> > > > On 2/13/25 08:21, Xing, Cedric wrote:
> > > > > On 2/12/2025 10:50 PM, Dave Hansen wrote:
> > > > > > On 2/12/25 18:23, Cedric Xing wrote:
> > > > > > > NOTE: This patch series introduces the Measurement Register (MR) ABI,
> > > > > > > and
> > > > > > > is a continuation of the RFC series on the same topic [1].
> > > > > > 
> > > > > > Could you please explain how the benefits of this series are helpful to
> > > > > > end users?
> > > > > 
> > > > > This series exposes MRs as sysfs attributes, allowing end users to
> > > > > access them effortlessly without needing to write any code. This
> > > > > simplifies the process of debugging and diagnosing measurement-related
> > > > > issues. Additionally, it makes the CC architecture more intuitive for
> > > > > newcomers.
> > > > 
> > > > Wait a sec, so there's already ABI for manipulating these? This just
> > > > adds a parallel sysfs interface to the existing ABI?
> > > > 
> > > No, this is new. There's no existing ABI for accessing measurement registers
> > > from within a TVM (TEE VM). Currently, on TDX for example, reading TDX
> > > measurement registers (MRs) must be done by getting a TD quote. And there's
> > > no way to extend any RTMRs. Therefore, it would be much easier end users to
> > 
> > TD reports *are* available through the tdx_guest ioctl so there's overlap
> > with the suggested reportdata/report0 entries at least. Since configfs-tsm
> > provides the generic transport for TVM reports, the best option to make report0
> > available is through configfs-tsm reports.
> > 
> Given the purpose of TSM, I once thought this TDX_CMD_GET_REPORT0 ioctl of
> /dev/tdx_guest had been deprecated but I was wrong.
> 
> However, unlocked_ioctl is the only fops remaining on /dev/tdx_guest and
> TDX_CMD_GET_REPORT0 is the only command supported. It might soon be time to
> deprecate this interface.

Once an alternative is available but it's still in use because of this 
use case (i.e., read registers from a TD report). AFAUI, SEV has its
reports available through configfs-tsm reports so it'd be a good fit here too.

Obviously, if the registers get exposed through this series, the use case
can be covered but full TD report is still good to keep available.

> 
> > The use case on MRCONFIGID mentioned later in this thread does not depend
> > on this series. It's easy for the user-space to interprete the full report
> > to find MRCONFIGID or any other register value (the same is true for HOSTDATA
> > on SNP).
> > 
> Yes, parsing the full report will always be an option. But reading static
> MRs like MRCONDFIGID or HOSTDATA from sysfs attributes will be way more
> convenient.
> 
> Additionally, this sysfs interface is more friendly to newcomers, as
> everyone can tell what MRs are available from the directory tree structure,
> rather than studying processor manuals.
> 
> > The question here is whether there's any real benefit for the kernel to
> > expose the provider specific report details through sysfs or could we focus on
> > the RTMR extend capability only.
> > 
> Again, parsing the full report is always an alternative for reading any MRs
> from the underlying arch. But it's much more convenient to read them from
> files, which I believe is a REAL benefit.
> 
> Or can we flip the question around and ask: is there any real benefit NOT to
> allow reading MRs as files and force users and applications to go through an
> arch specific IOCTL interface?

FWIW, I'm not thinking about IOCTLs here but configfs-tsm reports: a
single read gives you all registers as specified by the report without
having to add anything to the kernel ABI.

-- 
Regards, Mikko

