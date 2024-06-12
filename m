Return-Path: <linux-kernel+bounces-211292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A066C904F91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DDD282696
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07E42052;
	Wed, 12 Jun 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F24CDxpc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6615BB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185603; cv=none; b=Nd2YHXKGEuZzzP5py4TlfdbMXteh1dFB+nRc6ft1jPz0+JkE2PxI/PXTdDm7SrL1j/13shMfRb29JOKIgYM5B7kQGme6cHlx6NAZTa2OhSVpN0anty8z9AUMPIy8/CAAYVy9TwsVY4DtpSpHMq22+I7rLCE0CcajNFNms1WP5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185603; c=relaxed/simple;
	bh=a7lwZ0mHtGz7Gcc9Okj6FYzGI4uiz2b1f7BH+B8VXes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r71a5EeQt8mSA0MmZTZCQdaEJ2hHGkrcxYC2HprZNDRU+QmemTWs92KXOc+1dP8Z/Rmh0dW27hmtp//C/0BYVLAPxwnI7rY+ATasQ0EfO65Rj2SEOeqATmwz920Z8FqfPllW3P5g3N0xZJ04cFPkbFTenQC/Vl0plF3tnzbdTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F24CDxpc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718185603; x=1749721603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a7lwZ0mHtGz7Gcc9Okj6FYzGI4uiz2b1f7BH+B8VXes=;
  b=F24CDxpc2eeiBbtDgy3bX5uvdXfwWG5b+xxMgM5jjdY2py6gC1xmKQ/3
   kWH9ycIKlusMaWJSqxfNgGwkp5wvKQ6jKxQwh9VWNuUAHYyylpg/6sDOs
   3yXLxhXYIuwvmw76/Equzi1qV8kTw0zxX3pheUkGfzpTeHr1OYA/GohdQ
   cMBkQGTaJC0b6pk+aRRsgjtwk/VEowEmBsvdgxmidKhh+ZdiURT/91Ipx
   a7XtsYM7XlNXMMJ5dOys5ObncP06GvfjJ+zr9IZ2cdmOAsXjlrGaoyY6f
   rjJBA+CiUcfgqt7pNuocn+zaDzXZF6YQPcIluOEMwSpvKMFKcmNO4iv0O
   Q==;
X-CSE-ConnectionGUID: YLdxmD0qTN+2LTVupKaHzQ==
X-CSE-MsgGUID: ATAjoUuHTAOWI6KwQRYNaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="17863439"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="17863439"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:46:42 -0700
X-CSE-ConnectionGUID: v+BjPlcWSS25zn6ybtEtbQ==
X-CSE-MsgGUID: QJvE9afARvSRiV7EDcgmRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40204411"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 12 Jun 2024 02:46:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B1C44193; Wed, 12 Jun 2024 12:46:37 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:46:37 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Chris Oo <cho@microsoft.com>, Dave Hansen <dave.hansen@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, John Starks <John.Starks@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Message-ID: <vunn4hhfwkmxgspbxthy2w2vf67m7662r2dj324td3t6qkiegw@zp5dbgfgqmoh>
References: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>
 <4df2ebee-40c0-4ea3-8909-13b90f049ff1@intel.com>
 <fa788a95-1814-4782-8a36-f9dce7a04b66@intel.com>
 <DS0PR21MB3863B0D93D5F6D8CBE83931BA5C72@DS0PR21MB3863.namprd21.prod.outlook.com>
 <31ead5ce-fb38-4c0d-9bf9-606b59d6da09@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ead5ce-fb38-4c0d-9bf9-606b59d6da09@linux.microsoft.com>

On Tue, Jun 11, 2024 at 07:25:27PM +0200, Jeremi Piotrowski wrote:
> Is there a reason we can't fix the handler to do the #VE->mmio emulation
> for userspace too, so that this scenario works just like outside of a
> CVM?

We are looking into it. It requires some groundwork to properly understand
risks of wider attack surface. I think we will get there, but it will take time.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

