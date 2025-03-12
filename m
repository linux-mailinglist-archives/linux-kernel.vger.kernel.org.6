Return-Path: <linux-kernel+bounces-557411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31972A5D895
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D999175E28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A700235C1E;
	Wed, 12 Mar 2025 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOmrNRpd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54152156F3C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769324; cv=none; b=uc0rcAjMbwqR1+AezcFUyKaz44pX3g8dg/BaQqfNEnPfuzZO4HYSug/9rD82yLliV+ZwNP81LYhzStsVfE4VC4USAweN3uowd/kMM61FEpy4mYa7uSXtJCZW71wM2MbYRrZUKttdFWsEWFJ+ihM3gbSB9vTV5xQb1Zl9yGKYea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769324; c=relaxed/simple;
	bh=dUI2+b8kroHenbBGmP2/PHT6etj2wTgaGdov78xGIp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3VHh3o+vnZDWpmgUOk9nY9gMq5i33rz16M46KguJL79FkdnmUmc6i3GIl1uE0n5ev+oUN4S+TQzmmgnrwczKbeO0PypUj1TTQnQ2+OnPAV0OPCkA1uic2dWJhz0FY83sFk2XDDHLsCls//zEABbBsFmXDOcrfRzRiXruqTrBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOmrNRpd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741769323; x=1773305323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dUI2+b8kroHenbBGmP2/PHT6etj2wTgaGdov78xGIp8=;
  b=BOmrNRpd/Heesmxf1N6bIzlYZzYk7NWSAIgyIcm09T+THYVEF6IbGbrs
   PZ61YjVb5vWBts4G5//NF1H0igaYOhm6XO8zGoAc5GTcDIjD/AIii4qG8
   03yOp3jz9dP4tVWWYov66YbyuWYz/qirSdy22+qpOs1wNa8GSfkMrqHc+
   RaQHeTcF+cXVhfnyuuZ5RUOEAFGx9OCDt1Ob4yxAXPbKuivtOMYMhDdy7
   I1vF4jsYzw2k3I0Ufb6VQWKbDWuu3A69UZgd/nKtIb/GbLVoQDvLJZu74
   4RUrjXES5GZhI5lzDO9kWbn6P0d9ODBLnyZ7ub6teN9tuMDqmKauQiaxZ
   w==;
X-CSE-ConnectionGUID: UrcpYmF4SNGaHqlLDcoSrw==
X-CSE-MsgGUID: e7Cq68GcSGKz2ggbuDrxxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42093513"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42093513"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 01:48:43 -0700
X-CSE-ConnectionGUID: TJKaiYnlQI6vIAHAibURCQ==
X-CSE-MsgGUID: ZwijWdCrRG6KAMoeWfMNQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120524401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 12 Mar 2025 01:48:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 684801F2; Wed, 12 Mar 2025 10:48:37 +0200 (EET)
Date: Wed, 12 Mar 2025 10:48:37 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, Alexey Gladkov <legion@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, 
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, 
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <pskj4f5fitd5ytb7gq4negloioihl2rfbpfwa47fnw74gxmlvh@vpoijhxcee64>
References: <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
 <Z9CDjecpydOsRhUy@suse.de>
 <dzs3mxfvac2t7itqcv2vnz3cidspwvjinimkbn3ddygxunc2q3@akdoea7e2gon>
 <Z9FEcYssvcaZab1c@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9FEcYssvcaZab1c@8bytes.org>

On Wed, Mar 12, 2025 at 09:23:13AM +0100, Joerg Roedel wrote:
> On Wed, Mar 12, 2025 at 09:19:30AM +0200, Kirill A. Shutemov wrote:
> > TDX module information (version, supported features, etc) is crucial for
> > bug reporting. I think it makes sense to present it in sysfs.
> 
> The SEV side presents this information via dmesg and /dev/sev, we
> can also talk about a place in sysfs for it. But the place to present
> host-side information is a separate discussion.

There might be a value to have consistent structure for host and guest
information in sysfs, even if they are presented in different places under
/sys. There's subset of information that is common for both guest and
host, like version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

