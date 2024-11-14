Return-Path: <linux-kernel+bounces-408775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BA9C8366
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971DB2844AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7C1EABAE;
	Thu, 14 Nov 2024 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aK4WKTpN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E1139D1B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567438; cv=none; b=RfrG+lXDGyuGf7pSPBzqK/dyiMMpout1AUufJCYD7tj14Kn4GTvIMXwgfMO0Sv44prFrxCfJbuVjAzPRZXpZoaUSAzzKzqGohgeu/eknMLO++XvS4rlxt5br8UIdrabvtAERZMETGouP+3LbKaITXpKzkwNVi9KWkKJdADI5hV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567438; c=relaxed/simple;
	bh=F07BC/e4GITfj/eUVyXaRbIz+2T+mMFDxabhE93hmy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmERqzldntTz4u49w5bl4+tcFzYL3c4KCawkZVMr6SaNKd8AGt92l7kqhpl3xcVz+gFsxeAEocd54KAl5L68H/RZGTu3BKOdDFPUaCqVy7lVlp2k1bDBfdAgWjhAPMN3U0tbywbgSDzkmqCsj++MjvqnHjTe4x+Y0SocpDzESfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aK4WKTpN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731567437; x=1763103437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F07BC/e4GITfj/eUVyXaRbIz+2T+mMFDxabhE93hmy0=;
  b=aK4WKTpNRyFKRfo8bWqQhzwBdLL3uv+HLXXW9dZ39ic8GyijX7upu5OB
   2AuHw30QS9jeom2N2qDAcb3b2CjH+Mga5J957LbDUZbXK6+ZQel+Qpl9/
   GLhPsuUi12cBI4FYnwZCtIMnNzuRU2Hb82M09ghgM6OvltOBCR8glHGM7
   Mwx0ksdpGW8E2FLzBP1zJils33CmngKym1lU4amGkitSbM7DfztPShNkf
   flLqVKMcdkCcXrCcW5hiixKVcGpI/wq8S31vML3pW9joViNeHeCwGzdnE
   ibR47Bjvh2X43E37EhXsOhrTzTD7kLtsieoEoXTl7ulNU48b7T1QoUR7X
   w==;
X-CSE-ConnectionGUID: kjZ+jveBTsKptAXAHx3eAQ==
X-CSE-MsgGUID: 4HrXOW8ZSIGSYMMQt768mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31360769"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31360769"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 22:57:16 -0800
X-CSE-ConnectionGUID: FkS3sUyFTFSkACUS8hA7dA==
X-CSE-MsgGUID: kxpqT/18SISpJuxfOaGpPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88504135"
Received: from beginmax-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 22:57:15 -0800
Date: Wed, 13 Nov 2024 22:57:19 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Message-ID: <20241114064001.v6ogsiaptrh6oixc@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-12-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:31PM -0600, David Kaplan wrote:
>  static void __init spectre_v1_select_mitigation(void)
>  {
> -	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off()) {
> +	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
>  		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
> +}
> +
> +static void __init spectre_v1_apply_mitigation(void)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())

We probably don't need to repeat this check, is this okay:

	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_NONE)
>  		return;
> -	}
>  
>  	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {

