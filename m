Return-Path: <linux-kernel+bounces-548685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E723A547FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7EA3B22D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871B20468E;
	Thu,  6 Mar 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4FZlG2A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5013204C31
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257457; cv=none; b=NHjhk03Rw03RdLGD4YmiTkOQUqxMrUoxyoP16REu20zofMtTleZWNhGLaHV4a78zWCG7jdlc5t+EDk4yvn9NbOWGal/vVwEUYnvWrDGhfKiz7a82OofIzfgQAx4AEejEgDtvaZJvC6WE1+zmD6w5/Tyuuuszj8AhMPLyMW6AXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257457; c=relaxed/simple;
	bh=JJPVJ6pmf25iDWADk8kpgLM82yed2tP9+xavB158RRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu1JhonpvZUM/rE6FSO4aArjzvJpyj3o85eoG8PB73gaFhgPzvKjQa9jfu3v8dFaOG54wmh5EHTcVFbhGRcXFDuMwhKNIh+3n2xFzjNxnSXrC4xpSuRFpHfsm4n2Az74b9siKjiZC4ytcEAjQ5iYcKBw1eiHqvCWJ7GVjd2RN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4FZlG2A; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257456; x=1772793456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JJPVJ6pmf25iDWADk8kpgLM82yed2tP9+xavB158RRI=;
  b=m4FZlG2A6Ic4FgAb4cXgak7SNF3Al1yIxX6NTbDmGCE42azuVWJlgr2H
   FlaO/CrLqyOMzC2eFZvaOpUv4P6vWNVbN9MktpmxeO3Vl7t2qKULGqexv
   q2NhV36Wfy67oz8iO28kXpsOVRvLANB1KHoT4np0twoaRhqqI3jbfMucS
   mLmNjGiH1mobJ+/tGGbsaa1nNl9wWBp8LlpMG/3E4/RDtFqvvkVqDiUBS
   +rmwWf21nsQIQuzeO7Va3BIR4eRYy6MkZMHHzDV2AfI9YKmthbWOkcF/+
   szhkc5iYUr77uKsIW/rIVdNu+oTQ364nJMcbyTe08c3dKE/LaLrWZR6Zg
   A==;
X-CSE-ConnectionGUID: bTuvFVNjSEaaFiSlY0l6yw==
X-CSE-MsgGUID: uX4C+FcFRySyRaKeD92J0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41509392"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41509392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:37:34 -0800
X-CSE-ConnectionGUID: c+rR+hCgTf2Ya4rRw8Ylgw==
X-CSE-MsgGUID: i092fs6YQ4SmKrJu55ba+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="119173393"
Received: from agladkov-desk.ger.corp.intel.com (HELO agladkov-desk) ([10.125.110.41])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:37:31 -0800
Date: Thu, 6 Mar 2025 11:37:28 +0100
From: "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z8l66FFgPu5hWtuI@agladkov-desk>
References: <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8le_TWUJNebrfs7@8bytes.org>

On Thu, Mar 06, 2025 at 09:38:21AM +0100, Joerg Roedel wrote:
> On Thu, Mar 06, 2025 at 10:01:17AM +0200, Kirill A. Shutemov wrote:
> > Alexey looking into exposing TDX module version in sysfs for both guest
> > and host.
> > 
> > I think it would be useful for guest to make attributes and TD_CTLS
> > available via sysfs. So far, we only dump them in dmesg on boot (see
> > 564ea84c8c14).
> 
> Okay, do you have ideas already on where to put this information in
> SYSFS?

I was thinking to suggest something like that

/sys/firmware/coco/tdx/...
/sys/firmware/coco/sev/...

-- 
Rgrds, legion

---------------------------------------------------------------------
Intel Czech Tradings, Inc., organizacni slozka 
Registered Office: Prague 8, Pobrezni Street, No. 620/3, 
Postal Code 186 00, Czech Republic
Identification No: 60165898
Entered in the Commercial Register 
kept by the Municipal Court in Prague, Section A, Inset 8332

The above is a branch office of:

Intel Czech Tradings, Inc.
A Corporation registered in California, USA
Registered Office: 818 West 7th Street, Los Angeles, CA 90017, USA
Registered No: 1828841

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


