Return-Path: <linux-kernel+bounces-549029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDEA54C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581FD3A67EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A020B7F8;
	Thu,  6 Mar 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbWuBODS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED820E6ED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268168; cv=none; b=Ncee/43tpcrED5UOhCfuKF2+8mK7kl+YTow602VrPgqWQ04EC1Cdqv84G/lEypjCG9F7eOTyJZPkN1Wc5+spofSegUSjL+NdM/jK80CNmDUuEcaArKk1OzKFBySLjMumvmLKbvozgM3fIEFotmXUnpWZ4QUWbsUJk0aWBn/Oe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268168; c=relaxed/simple;
	bh=Iu9c4SCfXOrtwqrHON4466GUQ3W94KlIZG7iDD6It1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrDfzfKGWNuRpR9rcvh3fybhtS48Kv2V/JlSxAqT/d3MhlxqoiQdwjL8RVqlvIfLL2gzWj3r1KvX93X4sCWq+pCmBjJGfB8WIyeYefT8LcD4XZaZNk0gKgIi9ndm7JNBQcCjD5lhcHbmceaMRJJz2BBrYaqm63SBuwBSfB/yiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbWuBODS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741268167; x=1772804167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iu9c4SCfXOrtwqrHON4466GUQ3W94KlIZG7iDD6It1k=;
  b=UbWuBODSKaTdOdSUMSg3wtrlGPawJ6enW2jZhfzMdWuNt+aX6LQYCAs6
   x2v9PiFj1ZH3ZBr/Klc71TT6zMAj0tvOvUyrK6Z8Ac1019p7irK7ETK+5
   yuF8dggElfgqacHDLCHvgPUrAKCkhMekcX249VjwmLBVEQ4SizZQtvujc
   f+s2r5OYpMierrhS5MY6NN13pBlg2GfnCF2PlAYD5/wiUIj5xRBYugD2S
   WkeeSOLH+gKa4226KefTPOUkA+C1fjMywasZBLUOrYPa5oLhkmQG5ub7k
   zQmPrvJZNyK3yOWKk5h59WLfmvO4+wkC521OeaR9O1DjY2nhdYs/y6jvk
   w==;
X-CSE-ConnectionGUID: uIc0wNd4RKm2jOqfpV9geQ==
X-CSE-MsgGUID: fwOJY2k3Qw2HB6fkJ4719A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42472415"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42472415"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:36:06 -0800
X-CSE-ConnectionGUID: CQDVKGfQRuyDmW/qOjIDog==
X-CSE-MsgGUID: BDbMVIdyQAy2FxIIhp1uiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="118757907"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 06 Mar 2025 05:36:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2AA041FC; Thu, 06 Mar 2025 15:36:02 +0200 (EET)
Date: Thu, 6 Mar 2025 15:36:02 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, 
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, 
	Larry.Dewey@amd.com, "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <efbnludlccxde7bwt64faajkmadufyolcetl5at3anmvy5mi36@5q6zdzmwtvae>
References: <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <20250306103119.GAZ8l5d-brstBbLDEH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306103119.GAZ8l5d-brstBbLDEH@fat_crate.local>

On Thu, Mar 06, 2025 at 11:31:19AM +0100, Borislav Petkov wrote:
> On Thu, Mar 06, 2025 at 09:38:21AM +0100, Joerg Roedel wrote:
> > On Thu, Mar 06, 2025 at 10:01:17AM +0200, Kirill A. Shutemov wrote:
> > > Alexey looking into exposing TDX module version in sysfs for both guest
> > > and host.
> > > 
> > > I think it would be useful for guest to make attributes and TD_CTLS
> > > available via sysfs. So far, we only dump them in dmesg on boot (see
> > > 564ea84c8c14).
> > 
> > Okay, do you have ideas already on where to put this information in
> > SYSFS?
> 
> Right, I was thinking about it: sysfs does a one-datum-per-file thing and that
> would go nuts very quickly.

I think we should be pretty use to one-datum-per-file thing by now.
I don't see why coco case is special.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

