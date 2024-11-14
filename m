Return-Path: <linux-kernel+bounces-408729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A04C9C82D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE211F23608
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782F1E7C2A;
	Thu, 14 Nov 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci4KE7OI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46A143744
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563712; cv=none; b=i8xKFvrEwkE9O46iqGSSPTndkZrY1c1ApfzZXkNHQIWwt10X6WZH4n/5sxVaaeovXPvlt2ktvjQ/+MhcHxtxAIhuHvV43ZXRnnksz+p4MbE7QwCUscr43Ob5cAfm8dxkMyJj334SJcc9gewDmm69kfJwsKn3Etx/cWC4Na/aYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563712; c=relaxed/simple;
	bh=qgthtfupzA0jwag50c81Q/ScMvrFdTBeX/f7k+7uh0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5LLuhjC4MaP+4cPEcdlDDPjKInRT/9A49BCP6FraNbZIP6gnMY1hsDBF2bB+FitVJzZ/hAADwlSIxRbaepbM8NwGes7XW3zplNFrwlxhd6rr+kRs23tLdlJ9LPI0tiJwN0ZCgX4OVmGEmlA4s2OU3eNjW6t4t2x3OehtTxrj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci4KE7OI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731563711; x=1763099711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qgthtfupzA0jwag50c81Q/ScMvrFdTBeX/f7k+7uh0c=;
  b=Ci4KE7OIJNHMyGm7rLoJS2bRNw5K0A4fF/sye+VFndtsY3lTTaarMkuX
   B4Z9MQ2Bd/e0KngONP1O3Fe3Hc/ggTy27hxalZ9w0PFX9d+4XtUh6x4ZA
   BkDR3an1tBtFHQr7D7Ul9jIASSRuFUFSOFIlFsBIJYEjeJoOOXyI2VAGj
   7ZmLssyHWQy7Q4FDDp/4y8174zEj54W7NMuDnLqFJjF0blzC9zsMkN412
   nG5gLtflWfDpJa+Rpz/MsneHpCLzjF5ybvfMIlvejfQsJonU4tkGAqZsF
   9tHphzGMJsHX51omm0Q8hL1NhtaoxYA2O1/B877cWlaQBGPNOurcSXaAZ
   A==;
X-CSE-ConnectionGUID: KLYNXxAUQvOSkuCvQsvIHQ==
X-CSE-MsgGUID: dOKnAljKRrCywtvKsMb7uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42043993"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42043993"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 21:55:10 -0800
X-CSE-ConnectionGUID: DGKPpZxIT5i0L04D4D+4ug==
X-CSE-MsgGUID: 2cW0pyJ3SS6e1gPW0YMtjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93023095"
Received: from beginmax-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 21:55:10 -0800
Date: Wed, 13 Nov 2024 21:55:14 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/35] x86/bugs: Restructure rfds mitigation
Message-ID: <20241114052657.b75tvi4w4cvbzfxi@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-8-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-8-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:27PM -0600, David Kaplan wrote:
> +static void __init rfds_update_mitigation(void)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_RFDS))
> +		return;
> +
> +	if (mitigate_any_verw())
> +		rfds_mitigation = RFDS_MITIGATION_VERW;

Ditto as TAA and MMIO.

> +	pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
> +}

