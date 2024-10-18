Return-Path: <linux-kernel+bounces-371665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664119A3E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD4CB2259E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087B2837B;
	Fri, 18 Oct 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGxryCan"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12836748A;
	Fri, 18 Oct 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254166; cv=none; b=TMmky05ANJuplMiXJeHy0pRnnN3Y4d94vh9t1P+6fvgPOhbsEIWABUEee2vDZa0DrHNPdV/p0U/V22LBQNMaJZ6hZ9Ua9k/V9MqdoMD/SG1nzDFuwIpswleTB450pErhyb1gevECgiX98LwnROb74UxJWm4JBGEM59BsEin6LtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254166; c=relaxed/simple;
	bh=awYloGo+PANLFp0nhkTibOtcO7WmO6xuHo1JSv1VzMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFR6SQLRNdeOWh5B26za1zU4nf1wfijbR9dAgBMLFxjm3EgwBiOVw/vmXUjfm+mJTIOvEAnn09KDemvRGCDR7cEJIIyuAZFf2gLu2bhdtsBYoHTRi/FfUqEIvAeqqMGallA+o0rPQsCo1AEzKIw44GG5E5vnTceAeSMOJYgsxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGxryCan; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254165; x=1760790165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=awYloGo+PANLFp0nhkTibOtcO7WmO6xuHo1JSv1VzMM=;
  b=iGxryCanbh+HYavjw1KSN2sfi9hSHLD9ABfGYJ/prVzeQUlFHQ5g9DtJ
   OQAstT7WylIi5pF4r7ZbvbILDnlwAcHFNFdHaEZmbp1Tsd3K8BT60Y0rw
   0WOPuymmfYtaYTvjpmA44xZXkmy0hllTYD53adkCIAsnelavtuelKiVdx
   EV2ZVSXpNEHKrc9dFdaCabaxhN2zqzDgB6p/8LzlV9AtqEyPNk4Omoxn5
   IkS8L6wG4HbffptZfdO++oil5nJKEgiXkGPR0Rn2Qtvh2/UIX4wIOC1Ad
   KyaqaKMQvWNX5Q3ohcTycbOIivf2KJNV0XAqiFh9nQpjPHFAO6iPSajZl
   g==;
X-CSE-ConnectionGUID: EZaXW2e9QzeM6OLT3tWaJA==
X-CSE-MsgGUID: 6c//LsIERwCgCiCCVepQ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28938168"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28938168"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:22:44 -0700
X-CSE-ConnectionGUID: 1KhvwUMkS3CAcMIewNw5fQ==
X-CSE-MsgGUID: 8jNyaGBjQ7+Mj9pUI+sPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109590171"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:22:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1m06-00000004SR9-18Y9;
	Fri, 18 Oct 2024 15:22:38 +0300
Date: Fri, 18 Oct 2024 15:22:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> HI Gregory,
> 
> On 10/17/24 at 03:03pm, Gregory Price wrote:
> > walk_system_ram_res_rev() erroneously discards resource flags when
> > passing the information to the callback.
> > 
> > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > have these resources selected during kexec to store kexec buffers
> > if that memory happens to be at placed above normal system ram.
> 
> Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> memory carefully, wondering if res could be set as
> 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> 
> Anyway, the change in this patch is certainly better. Thanks.

Can we get more test cases in the respective module, please?

-- 
With Best Regards,
Andy Shevchenko



