Return-Path: <linux-kernel+bounces-385186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469609B33A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782991C22AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B51DDC07;
	Mon, 28 Oct 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWDExHd3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326701DD87D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126126; cv=none; b=CxWJ+3DdgmGTuj8kl5PjKq5lkNrurFHTrDkjg9Co2EdZNqqzQR6iEar0HOFzh/QpTpwv0T3qFLIDWKsHaGhiZM/CRD+gsz8o7lmrZihibxVzADnog78NqjKMgeofTu8Cz4ME0q1jQoAU5N4Iy+TgGsd3Y9pFv2gqJ0gBvVW6fKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126126; c=relaxed/simple;
	bh=FtrrQnO5dxhRGvDxtYkgewZI0NY2yKQJ3RdlOX8eFCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+jI+uO0N+60PBgW8e1Dms+WnFf3Y7yzSgCSSB9Beo+dgtPLluLZKujmp9Wzo5htfAMPv683mNGl1W2u049qlIHpXL9liy887XrEowd0PEgfTL2pWP4Ocud+HIXvYS4cOUxh3uKgVb/VvQ/3UXb/bod0yaEnp6FEQBiv5rs/bMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWDExHd3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730126124; x=1761662124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FtrrQnO5dxhRGvDxtYkgewZI0NY2yKQJ3RdlOX8eFCg=;
  b=BWDExHd3RT6pYIvNzd6quixKawukk1z+J9em2x3KWlIHm4Tb7Zi7FuGG
   CI8W3/narj+YsFolKj4i4Vas5zXYtRy/sHPH3Qawup8+BqPSvQ9fi1Kqv
   7/U1/30e2J2RcJDmngOj8NQ8Bk8Mw6Dfr7pIGmNRC9VYHg8x7S3yAmo59
   eT4qWVgrAhgluJYkM57GtI470zaeMlI+iRS+mT1uZL6iQ+qKECJ2OEdlB
   0ikzCcDhH0jVK/WHs83xaXhlfB7bDDfQEMiPLPWuaNctlfSv8H+YBD5F3
   lbShd/SdSvhKS/BmmeANzZpLO0nnQIzFSFIgCDzhWmeUEskKOacBOFXA6
   A==;
X-CSE-ConnectionGUID: 6Nx2k/LdSlOLCcfmpktM4w==
X-CSE-MsgGUID: bV8WXpatS3SF6exrfY+sIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="32584488"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32584488"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:35:17 -0700
X-CSE-ConnectionGUID: ozkoEPzbTCW1vELRE3JqjA==
X-CSE-MsgGUID: 2mqvzgnwSuahcIAsYHWMQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="86207811"
Received: from rvedam-mobl.amr.corp.intel.com (HELO desk) ([10.125.149.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:35:17 -0700
Date: Mon, 28 Oct 2024 07:34:53 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: bp@alien8.de, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/bugs: spectre user default must depend on
 MITIGATION_SPECTRE_V2
Message-ID: <20241028143453.govo3bnbayc7rqjj@desk>
References: <20241015105107.496105-1-leitao@debian.org>
 <20241015105107.496105-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015105107.496105-3-leitao@debian.org>

On Tue, Oct 15, 2024 at 03:51:06AM -0700, Breno Leitao wrote:
> @@ -1277,9 +1277,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
>  static enum spectre_v2_user_cmd __init
>  spectre_v2_parse_user_cmdline(void)
>  {
> +	enum spectre_v2_user_cmd mode;
>  	char arg[20];
>  	int ret, i;
>  
> +	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
> +		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
> +
>  	switch (spectre_v2_cmd) {
>  	case SPECTRE_V2_CMD_NONE:
>  		return SPECTRE_V2_USER_CMD_NONE;
> @@ -1292,7 +1296,7 @@ spectre_v2_parse_user_cmdline(void)
>  	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
>  				  arg, sizeof(arg));
>  	if (ret < 0)
> -		return SPECTRE_V2_USER_CMD_AUTO;
> +		return mode;

This doesn't look right to me, spectre_v2=eibrs|retpoline... will override
CONFIG_MITIGATION_SPECTRE_V2=n and enable the kernel mitigation, but the
user mitigation will stay disabled. If this is the intention it should be
clearly documented that enabling kernel mitigation does not enable user
mitigation. And an explicit spectre_v2_user= is required to enable user
mitigation.

