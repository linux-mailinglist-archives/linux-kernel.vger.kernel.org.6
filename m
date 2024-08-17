Return-Path: <linux-kernel+bounces-290775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED195586C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195D51F21E00
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8DD26D;
	Sat, 17 Aug 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mvd6lB1C"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C08BF0;
	Sat, 17 Aug 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723906239; cv=none; b=acPZ65k5EVRxZMiq9Is/BSgCwQQdD9q3Sb6QKxBgdicF1y50B/xqeydaaCDsBG8vbEhjG+lZHBvLgRi/X8x0/AAw+sFbRL0RTaBLfUX2FuMSnjbcgYrWuE2qCcXEJC1rjvc6cD9hqgVPJKebYmmHLwBj7OLYdou/OdjrdIky92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723906239; c=relaxed/simple;
	bh=6yBcy4lJJzBxSA4g6nXwy9n6BzXuyue9HXFfTQs+cbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqjaVKVWpRiygSIJq9bSzZQA8W8XNMjajV7DQVRpnbpMYg22apBCFLFGxKmMe7Xsu88m0jE5wR1ibgTKX4xrEqlBmcj1j6e3A5UL8iLct9v+DFj/dqAOmFOTfwiAcSZZ01wonkZ01OPvSXU0Kf8Hz+Xas5kNORkviuehYrl0ijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mvd6lB1C; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E0BC40E022F;
	Sat, 17 Aug 2024 14:50:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h0eGy4_HbX0N; Sat, 17 Aug 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723906230; bh=imB95eQxH+pRXJZLXWFyXLQ/kzSmR1l7Mba7+siQprY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mvd6lB1CbzQmMv1NE4Uey0B88vOKk57WbfYLmYH4grb7LUOD3EWh2xY0oHOQiNiTi
	 nCP/PARhWXm1arO6jUwbh/DHXkKo1n4ujHBboHHcEoQ6yB1XpwgsYevdFl4d20uq7o
	 +clYDGuaayN3asncO6T0u6HQqh5xCy8LlKikIaGJpbzUSZSy/0JqaDGM6Z5JFQA0ra
	 42t1ipEVvWCOl3X8zre6ezYNoiASAcCOHdfoeOdWui20mxXZH3+reJrRzxtZ52R/Qy
	 8+Uosy1Ld1N23brQDiL9vf+HgwZrLDp860eFxqfnoYmtmSu+SMUaz7uWiBwS/k7rQn
	 eCFGbED7pxxjV1MryrXkibULXPtmz0uLynKMmQxydkEaW+mqiW04VWFKZfJmf6dtOO
	 WJsJhtlIc/TJ4qPaev/jk3iffiduvsBlBuNRDkq+waIomkBB6SebrxJY+Ra5U047RM
	 bU/eDWmMtFp9q5YX3kyCkp1UkjNbvvfPiOvlUe/UKCRrHLtLJO8eNtdF+F+HvbjZLo
	 yjVSGv+3I4/q0tZkpJdSFTzwddXrIpY+OUy/cFPTktbFfn+o8h1SeiSXWs+nWvvQ58
	 LMaH012B0IbW1SDBGjwodEiyikUwl1YP/NUUihugjgie5AmINv4HjGONunEp91dq44
	 TbENX0TVLuh+Y1IXPTzs8Aiw=
Received: from nazgul.tnic (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E31D40E0081;
	Sat, 17 Aug 2024 14:49:58 +0000 (UTC)
Date: Sat, 17 Aug 2024 16:50:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
	thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
	ebiggers@google.com, alexandre.chartre@oracle.com,
	perry.yuan@amd.com, tan.shaopeng@fujitsu.com, james.morse@arm.com,
	tony.luck@intel.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	peternewman@google.com, eranian@google.com
Subject: Re: [PATCH 1/7] x86/cpufeatures: Add support for L3 Smart Data Cache
 Injection Allocation Enforcement
Message-ID: <20240817145058.GCZsC40neU4wkPXeVR@fat_crate.local>
References: <cover.1723824984.git.babu.moger@amd.com>
 <8378af17a73455661845830b40864ec1cbc303ff.1723824984.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8378af17a73455661845830b40864ec1cbc303ff.1723824984.git.babu.moger@amd.com>

On Fri, Aug 16, 2024 at 11:16:18AM -0500, Babu Moger wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dd4682857c12..5ca39431d423 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -473,6 +473,7 @@
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
> +#define X86_FEATURE_SDCIAE		(21*32 + 6) /* "" L3 Smart Data Cache Injection Allocation Enforcement */

The "" is not needed anymore - feature flags are automatically NOT added
to /proc/cpuinfo.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

