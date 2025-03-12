Return-Path: <linux-kernel+bounces-557578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A65A5DAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588F516F18F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A723E33A;
	Wed, 12 Mar 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4c+qIST"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1112397BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777197; cv=none; b=Bo0/3t8XKFcbFwyog1YlMp+/N4QXB2HPyZThHdwT6Ex3oXjS1uuBxyiRhQ6xhKXVn1fYhO4HtbjnplEFixt7g8Q9L9KNcSAJE4onHDhUBRwNbTKgbgrBi2Of7sQw18V83TldBxNAIKkckzmtkpwpcfvppgV3Z+rEjeNqxs3Xl7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777197; c=relaxed/simple;
	bh=Y30dj+yfY1TAUmuZSllCD/YTgtt7vGHlSUk0lu5Pfik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9BrXRRSc/3GlWdPkljssTe0+el7iS9B2Ldpt34sQWocBGllTnAG74ASliPvxsxEVrxOWQOEoa0lWXVR++lsD/BXK3ByD2qKtonQ1sitdEatYrSv8ZLuDBz0RF2NThkA/BzekYO2nelsI+Qj8X9PTOHtJ2GW/e4bbubkJiQw//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4c+qIST; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741777197; x=1773313197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y30dj+yfY1TAUmuZSllCD/YTgtt7vGHlSUk0lu5Pfik=;
  b=G4c+qISTouOGO1YvlS4b2+OC1Eb1amVuQfuPF81i+elfWKjKFCfThVkK
   4ag0aJPID521Iwyb7+i96UpJ+I1rBCYm0CHRfiuVuM/ObitwdACRBtLsC
   pO5B0e6EWzbhGEl0kw1ctSE+PQ10tAk/JFS6MKChyHQvXJAZDmuKeNPRz
   ymYEVHRsie8CsRYfBrZdZa4IAu2HUK4UTc8URLAnYCZsRykq66Ao/p+g+
   BZlFzoBNMnb04/eR1pglpOS+Aha0OObEZ8qd2ArC319LGZQPPpn4/p3EX
   9sGnt/XiojLmMCaDl/aHyL7rzRnCiJYkdbnd7XJMB/2JU0qedFY5MmBv6
   Q==;
X-CSE-ConnectionGUID: 2PRAMUjqQdCyWQe+23OHSg==
X-CSE-MsgGUID: 7W7OTdceTDOTnkU8+oMvyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42707586"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42707586"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 03:59:56 -0700
X-CSE-ConnectionGUID: K5TcZf6eQVSx7RfGzzz5rA==
X-CSE-MsgGUID: Hp6Dd4FIRwS75GV2Sx7hEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121089489"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 12 Mar 2025 03:59:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A6A5A1F2; Wed, 12 Mar 2025 12:59:50 +0200 (EET)
Date: Wed, 12 Mar 2025 12:59:50 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, Alexey Gladkov <legion@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, 
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, 
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <2eopafgnsx7pktqfqhu2nye44ib7ifz2cppqt7gunrltpxrnj6@i7jwe6jrun73>
References: <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
 <Z9CDjecpydOsRhUy@suse.de>
 <dzs3mxfvac2t7itqcv2vnz3cidspwvjinimkbn3ddygxunc2q3@akdoea7e2gon>
 <Z9FEcYssvcaZab1c@8bytes.org>
 <pskj4f5fitd5ytb7gq4negloioihl2rfbpfwa47fnw74gxmlvh@vpoijhxcee64>
 <Z9FO1CefzO89syGg@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9FO1CefzO89syGg@8bytes.org>

On Wed, Mar 12, 2025 at 10:07:32AM +0100, Joerg Roedel wrote:
> On Wed, Mar 12, 2025 at 10:48:37AM +0200, Kirill A. Shutemov wrote:
> > There might be a value to have consistent structure for host and guest
> > information in sysfs, even if they are presented in different places under
> > /sys. There's subset of information that is common for both guest and
> > host, like version.
> 
> I agree for the host side, but for the guest side I am less convinced.
> Any information exposed via sysfs on the guest side can not be trusted.
> The only trusted way to get this information in the guest is a
> successfully verified attestation report.
> 
> The same is true for exposing SEV_STATUS, btw. This can also only be
> trusted together with a verified attestation. But the difference is that
> SEV_STATUS is not part of the attestation report.
> 
> One might say that this does not matter much for debugging purposes, but
> the question stands whether it helps the security posture of the TEE to
> expose an untrusted interface which tooling then uses instead of the
> trusted variant.

I am not sure I understand your point.

In TDX case it is as trusted as the kernel itself. If the system is
attested, this info is going to accurate too as kernel gets information
from trusted TDX module.

But nobody suggested to use this information to judge the security of the
system.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

