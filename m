Return-Path: <linux-kernel+bounces-290773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA176955868
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBFA1C20F09
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557CBA33;
	Sat, 17 Aug 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c42NRJ46"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922B944E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905766; cv=none; b=s04mVy5PU0+VJjt42YS5yjks7XuNWK6kq82+u8hlM5DCCH5c5gcnBnPLTfq17rEAqhNGz5GWcCZzcrdgxdmOSKsXlby+czFeO7Y52y1iPzVKXHlQaWm0UlQqZllNAAEYKGEV/34Lplku4dSbJBpFBu4c+gRxFWAOpx/k7YF8Xug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905766; c=relaxed/simple;
	bh=in8M3zm45MU0enM4bTUpLBUEz4fAvhsTjIqhfnbfRp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZOi3do1DYcTO7G9hUWQ3THI/ZFvjq9CAQ2SOhKR9DKmTIDNCNmD9YPDffSXPJb2zptrY+jh2LDA99oPdhXSR8GTmibt6sriWyWkDSzuKjuqRrvSuDT51u65Z1m2eWGn/GzoQ7+APM9EWC2v9yFkC+r5iz6AUx+lm7RwY236TGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c42NRJ46; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2F07440E022F;
	Sat, 17 Aug 2024 14:42:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hEdUfdCkq0D7; Sat, 17 Aug 2024 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723905758; bh=0iUNJgR4SdsRbF8nQcdR6MxyljvHC8WnM+Bg4yk3Xl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c42NRJ46r7zr7TuxnQ/9AJDwaqFNBNEV69uianMHfiR6pMzxJHwo83QB0f3KDooGm
	 or4C+jt3l41s8028ALOisE2wYw6qDE/KlWQ2XpnzC4EJ/tOJfuWYaS7O5+fKULVWig
	 j2ag8gnV7WxZCEwN7JD1JrgRoG399snZDeWr0u9dlRjkkIyeRvsYfmw/qv51EiZ8oO
	 sJ2dG4tEolkf/Bp0LuoJZpm82DxZjEd3VhSbmv1p1lDLoBSBv+EZmDWazUkTkxgkdx
	 cS/EPYAjAigXKPztY3m+fg2Cx9AOwDx5lwMBbG662BDG+GklYC78CiS+/MnIpjvI3i
	 OhoRrO9XYWVDU4I5567QXHGAggQh3/Dt8Bi9hftZ57rgyeqbxrHGayjt2wQ9id35vF
	 oTXe73ampx4vE57MxPtVsRvDu+pvHemf2yjVabtj/9LX0LvivN7jykDTkD25repAra
	 OuhVc9GKGEjt1SpJvmElxrazmls+tYcJNuEmLUREjv8PmdPx+oYaULAhrFoDtkG7aQ
	 jvzL4FruFuO3Zz9K2aNzxlff/xkSmhZnQGfLWU/meMTSNPKWdsfWgThY5B34sPdN7v
	 KOXVLe0DQVgm1yfCSwWj+oln0R1PdjbIDTvZALEORs6EQ+yw0P9B5SrBF1cRY0kV3L
	 nKUUi1Id6FR5Kxo53E4SomcA=
Received: from nazgul.tnic (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5EDA40E0081;
	Sat, 17 Aug 2024 14:42:27 +0000 (UTC)
Date: Sat, 17 Aug 2024 16:43:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	seanjc@google.com
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with
 the alternatives mechanism
Message-ID: <20240817144316.GAZsC3BOm7anUPdJGe@fat_crate.local>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>

On Sat, Aug 17, 2024 at 05:23:07PM +0300, Borislav Petkov wrote:
> >static __always_inline void wrmsr(u32 msr, u64 val)
> >{
> >	asm volatile("1: " ALTERNATIVE_2("wrmsr", WRMSRNS, X86_FEATURE_WRMSRNS,
> >					 "call asm_xen_write_msr", X86_FEATURE_XENPV)
> >		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
> >		     : : "c" (msr), "a" (val), "d" ((u32)(val >> 32)),
> >		     "D" (msr), "S" (val));
> >}
> >
> >
> >As the CALL instruction is 5-byte long, and we need to pad nop for both
> >WRMSR and WRMSRNS, what about not using segment prefix at all?
> 
> The alternatives macros can handle arbitrary insn sizes - no need for any padding.

What you cannot do is have a CALL insn in only one of the alternative
insn groups because the compiler is free to clobber callee regs and
those might be live where you place the alternative and thus will have
a nice lovely corruption.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

