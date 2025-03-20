Return-Path: <linux-kernel+bounces-569426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B1A6A2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC3C880AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3222257E;
	Thu, 20 Mar 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hs8qLtk2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157E821D5A1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463533; cv=none; b=Ei7zmA63Cre6Pohmq2taj0xSbu8O3UAXcu16w5PVkogO/kB6FUJ6raOzPenlrM8K9GCb4LmRzR5sVcv4ahyQhKtiViE5Zpn86pFeAlbE1g0P5T0qCqiGaMYho2E+KqUEwSD5kw3T1OBvdJ5yDwzpuHqHQ8GBkS4EGUJT1P2TBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463533; c=relaxed/simple;
	bh=XxhDtK+NPjrUigmQEObn5NVqHG9KWOcga5qM3iqOX/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFJxBd/bvc8sGhhW/no5o8IVMoraZUDfQJAFQ7YZ5/n9S+Cpn5bEm7ztGlbhTHCNvwojCme8uUR94p6eRi6M0Cko2oXfb4yaFwsFHZS+uEWVYpx9atUJfgNNv0dRNqr6f38OzeLc9Af9Cug221A6V4STvZzMqlDGxYPUp0FMago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hs8qLtk2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742463532; x=1773999532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XxhDtK+NPjrUigmQEObn5NVqHG9KWOcga5qM3iqOX/k=;
  b=hs8qLtk2etejV/wehYUtt63WBgqav6sJqM1Rcpwnquvva6fjpew5SpVe
   2lmDQZGvPyZCXaZ8Kkh8qIEDCvU1lOCzHHUj6P3wUI+eJjzEiTpnkWeMG
   HfqodtUKRsn7rYiy2bAff8ziFB0g3h7ECMhHiEXx8ZsgrhL4vh0UzWViP
   ZZL5MNwptRfDC+YeP6ANAOfq09ZnMjUbP0Plhmc/D8KXbj2A6PEjWOHqc
   Tell+zFIbTQVXiUJPDJ6LhxD8ToCW5QRyhSpCRemezrnXfRk7Uv+vE1iK
   XF1a1uZllDN1Wx9GlM6BE8emmRZWVO3MlhYDE4KrKk55ahFayoOm0Eg04
   w==;
X-CSE-ConnectionGUID: kOL8lJSPTQ6Tyo6LTikiPA==
X-CSE-MsgGUID: iBXH9o8kQC2c4RiyfXwJ9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47341107"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="47341107"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 02:38:50 -0700
X-CSE-ConnectionGUID: KT0aoQBlQDqdQcJOlWaX2g==
X-CSE-MsgGUID: AIYXmeVVQbu8OR1s90H7Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="127879555"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 20 Mar 2025 02:38:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 856FE1E0; Thu, 20 Mar 2025 11:38:46 +0200 (EET)
Date: Thu, 20 Mar 2025 11:38:46 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com, 
	Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
Message-ID: <h46ki6cfmrflbw4fhebsb646cpzba6iqq6cozq4prveqhowdtj@ifwsk64zo73k>
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <guatjzjzipzjzvj4oou2gktxmzileawshxmxj22hsa5kmet5g4@2rhf7tzaiytw>
 <b6d132a7-b259-46f4-8bde-fc517bd9d294@suse.com>
 <auno67lcikllqdlgdsad72hvsmym4lqxnaqaohmvtvf2boscxu@54ftt6342jxy>
 <d0891544-98b9-447a-a382-bfc078865243@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0891544-98b9-447a-a382-bfc078865243@suse.com>

On Tue, Mar 18, 2025 at 04:21:21PM +0200, Nikolay Borisov wrote:
> 
> 
> On 18.03.25 г. 15:27 ч., Kirill A. Shutemov wrote:
> > On Tue, Mar 18, 2025 at 02:53:34PM +0200, Nikolay Borisov wrote:
> > > > I think we need to think wider. What about applying a subset of LOCKDOWN_*
> > > > in all coco guests by default. Many of them are relevant for the guest security.
> > > 
> > > How do you envision this to work, by introducing another
> > > CONFIG_LOCK_DOWN_KERNEL_FORCE_COCO or some such ? Will it be opt-in or
> > > mandatory?
> > 
> > I think cc_platform_has(CC_ATTR_xxx) should enabled some subset of
> > LOCKDOWN_*. No need in new config options.
> 
> Care to suggest which ones should be included? The way lockdown works at the
> moment is that it only supports 2 levels (check lock_kernel_down() and
> lockdown_is_locked_down()) at which you can lockdown - INTEGRITY_MAX and
> CONFIDENTIALITY_MAX,  where each level includes everything below it. So by
> choosing integrity max you get:
> 
>     19         LOCKDOWN_MODULE_SIGNATURE,
> 
>     18         LOCKDOWN_DEV_MEM,
> 
>     17         LOCKDOWN_EFI_TEST,
> 
>     16         LOCKDOWN_KEXEC,
> 
>     15         LOCKDOWN_HIBERNATION,
> 
>     14         LOCKDOWN_PCI_ACCESS,
> 
>     13         LOCKDOWN_IOPORT,
> 
>     12         LOCKDOWN_MSR,
> 
>     11         LOCKDOWN_ACPI_TABLES,
> 
>     10         LOCKDOWN_DEVICE_TREE,
> 
>      9         LOCKDOWN_PCMCIA_CIS,
> 
>      8         LOCKDOWN_TIOCSSERIAL,
> 
>      7         LOCKDOWN_MODULE_PARAMETERS,
> 
>      6         LOCKDOWN_MMIOTRACE,
> 
>      5         LOCKDOWN_DEBUGFS,
> 
>      4         LOCKDOWN_XMON_WR,
> 
>      3         LOCKDOWN_BPF_WRITE_USER,
> 
>      2         LOCKDOWN_DBG_WRITE_KERNEL,
> 
>      1         LOCKDOWN_RTAS_ERROR_INJECTION,
> 
> Given this if we for example choose to lockdown the kernel for DEV_MEM,
> we'll also get the MODULE_SIGNATURE lockdown as well. I find this somewhat
> inflexible as we might have to rejuggle the current ordering.

Urgh.. I thought we track the lockdown level for each feature separately,
but it is lockdown depth instead :/

Maybe it is worth reworking internals to have bitmap of lockdown features?
It will allow us to pick and choose features to lockdown.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

