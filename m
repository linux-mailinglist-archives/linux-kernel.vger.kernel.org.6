Return-Path: <linux-kernel+bounces-408632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E59C814A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52AD5B234B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BF1E47D8;
	Thu, 14 Nov 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4Gc5sci"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460217E107
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553423; cv=none; b=uCUi583SlgAXhG8LSUuwkY7rpKmJSDEuToeFgTKs+aYWE7EAsTOiJL1b5xfh86C2mDfT1RzlbfvFghvdnBgBza0PcVXNeyDOIYtkBqPsIpzKqtaG7gjuK4lkz4mrCLpKla1AkNrI//2Yq1toSudRyVwFgGBH40M6Y0EnvATiOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553423; c=relaxed/simple;
	bh=/GJ2almSKl+xML4JaAMfFaspoRRz6PbvLD0/3m7JpOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e81EKGgBCnbsuS+SOUSECiVYi5R3GZolHbjcYYEjAfjVgysek3FiRQm1uVRMEaLYq/FKaQO1Y65iAxemJNGjGX9DDPzni/9b2G+LFCmIcZGyJA8eV7uW0a5coVK/Fm3knW/c/PmokXYhSKQBcS8E0HJ8yGryOaMvV8rbGqpo0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4Gc5sci; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731553423; x=1763089423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/GJ2almSKl+xML4JaAMfFaspoRRz6PbvLD0/3m7JpOM=;
  b=X4Gc5sciRz72dkf2RFAorZ81rMeNwYc0807/+L9VQ1A54Zv4a8paTrQR
   JjZBkqH4RGuSxRobsqkwdq/9v6OOEfhxXUlyU5Gzn1fGdmPD+1relV2JL
   afBHURmcidukDeP2hpCxuk2HvxzRTUpGys2IYbKTvco4I4Rya8GBq2704
   Au4ANuz3Bdu5/tP1CHyML0YqtKeKo9AecDJEIbk6FCckfnaaVERf2hDpS
   9CROa5Am7XDuo1FHT79mQRXLozdqf32OSlXA+4tZC/NvIWPstzyYThoJ1
   nXH3O2TBeglW3hyHEbL0bD1hG6LmpIoA9NreOGDFWsMzYRzPODTLmPLOB
   w==;
X-CSE-ConnectionGUID: MfJXhPvLRg2ZNvBZiW/Umg==
X-CSE-MsgGUID: Tqh1+rrbR4KorvSx420keg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31246810"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31246810"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 19:03:42 -0800
X-CSE-ConnectionGUID: W2lpJQHqRAS+ro0hqp9k4w==
X-CSE-MsgGUID: kDSu+HVfQFu1idMxvGVcWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="93003284"
Received: from beginmax-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 19:03:42 -0800
Date: Wed, 13 Nov 2024 19:03:43 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/35] x86/bugs: Restructure mds mitigation
Message-ID: <20241114030343.ewjeiyisjycjlxpo@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-5-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-5-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:24PM -0600, David Kaplan wrote:
> @@ -277,12 +304,19 @@ enum rfds_mitigations {
>  static enum rfds_mitigations rfds_mitigation __ro_after_init =
>  	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO : RFDS_MITIGATION_OFF;
>  
> +/* Return TRUE if any VERW-based mitigation is enabled. */
> +static bool __init mitigate_any_verw(void)

s/mitigate_any_verw/verw_enabled/ ?

> +{
> +	return (mds_mitigation != MDS_MITIGATION_OFF ||
> +		taa_mitigation != TAA_MITIGATION_OFF ||

TAA_MITIGATION_TSX_DISABLED does not require VERW, this should be:

		taa_mitigation != TAA_MITIGATION_OFF ||
		taa_mitigation != TAA_MITIGATION_TSX_DISABLED ||

> +		mmio_mitigation != MMIO_MITIGATION_OFF ||
> +		rfds_mitigation != RFDS_MITIGATION_OFF);
> +}

