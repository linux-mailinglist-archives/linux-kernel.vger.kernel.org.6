Return-Path: <linux-kernel+bounces-408680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A449C8213
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DAF284ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E196A1AF0DC;
	Thu, 14 Nov 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWKJaVTy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DC1632F3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559418; cv=none; b=GJyQnagJFKAkeSpvK2A1m4Cs8GL+40EjWoOltedNXA7RmZBjhAg8TfO41h0CctsEKL2mlxH1GPHNtmLIvnHbZI1vqMuUGJ7aiH/9tBwpsVZxQx8bZT+ZzcC1+55u6nDyTbiF2Dxfv1symhid+TZjLuVbuEyU1gKrZIz8xAEZYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559418; c=relaxed/simple;
	bh=jQvulJKrcd3quR6CtZ9K1mvmgor3N5vltAqUmQ9VOoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2nEIr+JXDzw3Kq3xD8awx0tPxxSZ66eCsNykt51cdDqQhVANy0iAzjaFX+bIjD49nfOzWhPLQzkjN68juKyCirZegsJxjaaAwisJMeDstkwkF9p1/BnaVAfAwgMxjjZP9GktRWtpHCHQ2om9FDpOftsJ9EYKkQs1uSBM8VuTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWKJaVTy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731559417; x=1763095417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQvulJKrcd3quR6CtZ9K1mvmgor3N5vltAqUmQ9VOoE=;
  b=bWKJaVTywtPcltZ3zKmpHqf5HkJ7taEYbIOU01SOZd8mkGy8hknPJQuy
   OkZ8PsAMFoy6uV8UQx9fvg9EvuGDLyti1w/dFpnTVQ+Jj881Uxv+yAoQn
   hIPUQ+W5BN26PHyPY1oYGSOLil2LdZc76t9B2szxS/w6Lz49z11En1UWR
   g8BbKXdeRdH2GqtTHl5u9OCg1GRXu9DAWlFXundlB9tZdF5nZtE1FFOyR
   axBTtlqQiIz97F6RYvyskY5dLcugPwsD075uixHaN0mczFw0qNfwBNlLg
   w/nlRcCfsyrUZ+Y8FvnfJ7LEQO56VWcheYcgN+VVus3YA8l7TNka7rba4
   g==;
X-CSE-ConnectionGUID: zYCJkoRvTE25WqBXWPAzSA==
X-CSE-MsgGUID: YCmOliYXTnmYNCKT+XsmYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31582484"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31582484"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 20:43:36 -0800
X-CSE-ConnectionGUID: PP00uHFZQZWU+J+KvSB5+w==
X-CSE-MsgGUID: +TZ/zIaSQhKs4AzM5CFTsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="92548497"
Received: from beginmax-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 20:43:34 -0800
Date: Wed, 13 Nov 2024 20:43:17 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/35] x86/bugs: Restructure taa mitigation
Message-ID: <20241114044317.22i2vlekf7zimt4d@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-6-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-6-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:25PM -0600, David Kaplan wrote:
> +static void __init taa_update_mitigation(void)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_TAA))
> +		return;
> +
> +	if (mitigate_any_verw())
> +		taa_mitigation = TAA_MITIGATION_VERW;

This isn't right, TAA_MITIGATION_UCODE_NEEDED can never get set
irrespective of microcode.

The UCODE_NEEDED checks in taa_select_mitigation() actually belongs here.

