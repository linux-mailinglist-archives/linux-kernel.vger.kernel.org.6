Return-Path: <linux-kernel+bounces-241222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821E927864
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0981C234FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DC11B0122;
	Thu,  4 Jul 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gg5OXixf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752971B0123
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103453; cv=none; b=HJkAKuEfLv13eqwi1+cELTxeo+4IPkycn8sx4FYcMSKdOQzPumj4nQ8VQ2mw7xWUpdRt8p5lEA9Vrj+JZ3x5lISY3IsXrpJ06OZbuNgIxQ+CtyDIIjkL4gBpKma295rtLCfL7EEx+dV+Ohw9mtnJ/qIrkXZ+8pEbdqb/XiWkJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103453; c=relaxed/simple;
	bh=el5kjnJ2pJQrRm1foJdMBWWDZ/wQBCkI2BmKTWmW2No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNIjMOY57QeKyiocKKwhJRDd7uLbqN7gUlu4a3BZKxbKsvJpumLdgIzunAmO6N4z4gbhCWkFjqh3zdbcRJMwy79b6RCGvJLDmVwPschbPxIqkUOTU/hnqEAC5SkVkCZyPngkyHs0u0LCtH51VDkCaf7ivMQ2dQkG0Dqn/70qzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gg5OXixf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720103452; x=1751639452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=el5kjnJ2pJQrRm1foJdMBWWDZ/wQBCkI2BmKTWmW2No=;
  b=Gg5OXixfDFI8CfS1ca+ygfmo21r63VW41BVg3B4VEgQCJDzzCAtZrNvR
   Y88PCrMTa/C3mJo0PYgW7LPelD0MMOD7h5P77Bj95EwwDSVbVZwoXC4e3
   /KpoBMjdKSN6ivb9c0GTFQfIsdOJtc4/zJLNFYLaNKi4ixcXl75vEmCQq
   Lq4RHxYu3IJibEkNu+x3iJ14RWrB4nW5Q0Qu1x/AhPgd0mZxjz+qNQAbq
   oksGSUVC8LPfM6+G2arhmrpAJyRUvmwATXkcMH1UMuUMsdPWaqVLxV5cU
   u5nn0zO0GPteyEPdq6t8gBHY9YMYcctBnPhTxSEj4X9FSVtL/gpydOcK7
   w==;
X-CSE-ConnectionGUID: NFGyJwXmQ0O6l3zk2tw9Jg==
X-CSE-MsgGUID: cvxICcLcRz2ezKxzn9z1Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17522768"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17522768"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:28:36 -0700
X-CSE-ConnectionGUID: vom8gVcIRMGFBQ/Ef1J3dQ==
X-CSE-MsgGUID: P2N5QGHFThWwq+PD+b5qcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46690844"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2024 07:28:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C876D22B; Thu, 04 Jul 2024 17:28:31 +0300 (EEST)
Date: Thu, 4 Jul 2024 17:28:31 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>

On Wed, Jul 03, 2024 at 07:16:47PM +0000, Dexuan Cui wrote:
> > -----Original Message-----
> > From: Borislav Petkov <bp@alien8.de>
> > Sent: Saturday, June 29, 2024 12:41 PM
> > To: Dexuan Cui <decui@microsoft.com>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>; Dave Hansen
> > <dave.hansen@linux.intel.com>; Thomas Gleixner <tglx@linutronix.de>;
> > Ingo Molnar <mingo@redhat.com>; x86@kernel.org; H. Peter Anvin
> > <hpa@zytor.com>; Michael Kelley <mikelley@microsoft.com>;
> > Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>; Kai Huang
> > <kai.huang@intel.com>; Rick Edgecombe <rick.p.edgecombe@intel.com>;
> > linux-coco@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
> > 
> > On Sat, Jun 29, 2024 at 07:27:57PM +0000, Dexuan Cui wrote:
> > > It would be great to add e1b8ac3aae58 to the branch x86/tdx.
> > 
> > Sure we will, once it is properly tested. This very thread says otherwise.
> > --
> > Regards/Gruss,
> >     Boris.
> 
> Hi Kirill, Dave,
> Do you think if it's a good idea if I post a new patch that combines
>     e1b8ac3aae58 ("x86/tdx: Support vmalloc() for tdx_enc_status_changed()")
> and
>     your patch "[PATCH] x86/tdx: Fix crash on kexec"?

Yeah, IIUC, that's what Borislav wanted. After proper testing.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

