Return-Path: <linux-kernel+bounces-566220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A10A67516
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAF016263E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBF20CCF1;
	Tue, 18 Mar 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxOEsZFe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A020C479
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304477; cv=none; b=TUUXG5c5txKcMeTqynJLVRiqD2BW1FaKbA/UFML+5bksOwFxEE4G0Esf0+Rq1gTwhIPGzb85mxLNgKBiqxSKrM1IXo8p/CWFxFgfa69c6iT1Aq34PWUh8wKCnhAOLoTuIUEETfSJUfGAsO9LUn/Wh+XRhARkQZTdRT8/Gj2Xex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304477; c=relaxed/simple;
	bh=OtmAMeL9CHMcB58JNBxma5MlcQ1Hf8kzWFTZ0slHlOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU6qPN5cYR/M6HO/v7mfRUHoEb6eGE7AfJfKXltNqSTfmk+QgdnPMoJO9Swu8mp3+hr0EUtOCgyuOdJkrOuIT2N/yu1XrlDs0CdNL2qd1ct6tXMLTunMKzKIphzRp+vmMKpPeUADY/RN1TfI/Q7vVvuWdMBoUH+PjpzbUJFaN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxOEsZFe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742304473; x=1773840473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OtmAMeL9CHMcB58JNBxma5MlcQ1Hf8kzWFTZ0slHlOQ=;
  b=NxOEsZFe4ipN3gsWaGfB/oKOiiwRyv0hlSrbOexFCWuBVb8BYZgh/thm
   JqN2Arxr9VoVWv0PPRkoe3JVSm9sqRt9XKLGrw1fl65uZ/VEuU8qVM4Z+
   BOja2Gx6K3VVaN2Vhwqxjm7EtY2GDSWOf7we/UtCRy9A8MbyduI1eDsu+
   EVydKnqBsKzbmbEMs1yLWAyuuuDNRgCRF3jZB4UOPcRbd58Jzy/RnEwix
   OyVFw436OWOmjy9T0OnQbS89WRtT3JhDJ6egRNe3mMlhwaYBv/JY8OPC1
   AHn4QYMreHGn2rQ5Dy1n77gmiRPWimdf4mzdf8M7+oQj0z4s42l9A5Qfs
   g==;
X-CSE-ConnectionGUID: S5KFL+NBSBGI/Wp2/tNUEQ==
X-CSE-MsgGUID: Yc09xfNpReqI7I42w20tjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43313276"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43313276"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:27:52 -0700
X-CSE-ConnectionGUID: drZAgBDvSCmBj8s4LxdH7A==
X-CSE-MsgGUID: YXLG3vhDSzmSEmdBQJ4++Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122203072"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 18 Mar 2025 06:27:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 768161D8; Tue, 18 Mar 2025 15:27:48 +0200 (EET)
Date: Tue, 18 Mar 2025 15:27:48 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com, 
	Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
Message-ID: <auno67lcikllqdlgdsad72hvsmym4lqxnaqaohmvtvf2boscxu@54ftt6342jxy>
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <guatjzjzipzjzvj4oou2gktxmzileawshxmxj22hsa5kmet5g4@2rhf7tzaiytw>
 <b6d132a7-b259-46f4-8bde-fc517bd9d294@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d132a7-b259-46f4-8bde-fc517bd9d294@suse.com>

On Tue, Mar 18, 2025 at 02:53:34PM +0200, Nikolay Borisov wrote:
> > I think we need to think wider. What about applying a subset of LOCKDOWN_*
> > in all coco guests by default. Many of them are relevant for the guest security.
> 
> How do you envision this to work, by introducing another
> CONFIG_LOCK_DOWN_KERNEL_FORCE_COCO or some such ? Will it be opt-in or
> mandatory?

I think cc_platform_has(CC_ATTR_xxx) should enabled some subset of
LOCKDOWN_*. No need in new config options.

> Should we decide to follow the lockdown route this means the owner of the
> coco guest will have the ability to disable it and a misbehaving userspace
> process will still be able to induce an EPT violation.

Sure. It can shoot itself in the foot.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

