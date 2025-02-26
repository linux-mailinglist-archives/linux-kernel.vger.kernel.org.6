Return-Path: <linux-kernel+bounces-535028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D1A46DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE83E3ABDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB20E25B665;
	Wed, 26 Feb 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCOOzT8h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D22253FD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606719; cv=none; b=tJ0AVljTwBjCBlz0w2AaRQ8Vmc8kb++fFA/LvydxwxDUo5nfFjhia5cFlpuwXc/mRhyjzcWXVkVlWCBUDIECG9MChCm2d2635LOpUD+VPjEySsNJky2pCoeULisz/WiK+MU4IOoX84Ce0U5xvan4niEarwaC7B9TLTDZ7xesVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606719; c=relaxed/simple;
	bh=inVDDmFStf/N1n/AonqfkHis0VLiuoeKFqDkgpsNKyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHd8wMiME0WOJjFSy9La+SKcbfrFOw0fLzszRHOb5KK/RSZ0idxzNTidTYaezsmWq1S6PUosPvhh7L0sY4FYQfWHG80GY2MJWeZ6qHl1DmWYISBWUMy5l7BkZWJSt8y4HwAmEwL9BJLHZMcngDY93J9vq7co+RHvzWH7MZubs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCOOzT8h; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740606717; x=1772142717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=inVDDmFStf/N1n/AonqfkHis0VLiuoeKFqDkgpsNKyY=;
  b=GCOOzT8hQb3APNqbFAY5rcKzHKKASPQQxyI2Nkr9pQwdxH2VTyYROFJj
   q8J0f005V74396ONIoVQkJ6UCrsX6Vc/ZOVfcv/t8Cdoj/6rjA2I3TDU9
   Jcu7ML720dZ0Pp4iOArBxXLoLR3xJWaklUm1bMWcavTYEuHQ5nB8yG4zN
   VzQdM6oec63x9HbpbaM1FqmXVNGKI18weBE1oQ25cWmtKbH48bZdinhCc
   W6Pc+2EyEKq2oGGnk3CkXQb18ajwXCwc7qV7TDGWpepZXzuNFeXdpJV7I
   07qq8cCFXe8rbFjlVd2E4FnpL9SOPDTLx6w97eRBGn2DbHB4tBJE7yq3x
   w==;
X-CSE-ConnectionGUID: E4i59MxsRYWjqD8i+VI2rw==
X-CSE-MsgGUID: ze6QZ619Tl2cCSv8Ak/iRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41400879"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41400879"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:51:56 -0800
X-CSE-ConnectionGUID: JOWRx7OzRb+8yKaf+yAxaA==
X-CSE-MsgGUID: KaO5cxuiSKmUjdXyDscQkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154010177"
Received: from unknown (HELO desk) ([10.125.145.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:51:56 -0800
Date: Wed, 26 Feb 2025 13:51:47 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250226215147.233kxx2z7v7rnu5k@desk>
References: <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <20250226210129.GHZ7-BKYvxN_I3f_B2@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226210129.GHZ7-BKYvxN_I3f_B2@fat_crate.local>

On Wed, Feb 26, 2025 at 10:01:29PM +0100, Borislav Petkov wrote:
> On Wed, Feb 26, 2025 at 12:14:53PM -0800, Pawan Gupta wrote:
> > This is a bit ambiguous, mitigations=off,guest_host could be interpreted as
> > disabling guest->host and enabling all others. Using attack vectors with
> > both =on and =off seems unnecessary.
> 
> No, you'll have
> 
> mitigations=[global],[separate_vector(s)]
> 
> so global can be "on", "off", "auto" and the separate vector enables only that
> specific one.

I got that part, what I meant was allowing to use =off,<enabled vectors>
seems unnecessary when the same can be achieved by =on,<disabled vectors>.

