Return-Path: <linux-kernel+bounces-386836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C59B4876
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12811F237C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CD20512A;
	Tue, 29 Oct 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LJSlwFyM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE67464;
	Tue, 29 Oct 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201973; cv=none; b=k3t/Zp3YvCvpiQD9yRnALFcYeAeS7W+Dkm3HEXvbfpG4rQY8bHcwdALgYFIE5Xyq9rmdZB6MXYX6UMLIHCqzazbU/EEoAU0UbIJIVxZvM8/Mo2sc/AiLPqm6oIE1pBzKbSgOOJMWFQY9BAp6Gos5z7v8wb2gb5apGeoT364Ju18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201973; c=relaxed/simple;
	bh=NkNFfbji0OME9gPCeQIakGoXEIkxCxgpbxmctKafQAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg5dvMoqYBIUconUjTfTS2/efdEnyeAUVDq2cvLir92Lg7flinal/K/3NkXtprmtgPUvWHZEMYkwIegKUXC/cGVqvHppYz4Ut5QNl3OJDpR3aktKyoDREB7KevWtAvaCo0OqxpdFPgVDJTf8Dld39fBQcT8PYziYG+HZMJEcruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LJSlwFyM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5EE140E0191;
	Tue, 29 Oct 2024 11:39:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bxg2LzqxNo7C; Tue, 29 Oct 2024 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730201964; bh=0iZNTIQ41wXmMKTJ9iFXjkQg26CA/6aBHQN6CHwVF1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJSlwFyM18+RZszvDzcL2dKyJClz15WhcDZcVJreE+I1hNdOhwGLjKI5nNBgjmdL2
	 L2UOZFPHzUAm+7g85IV9wljr3rn5o0dTfB1JKujBQQrLMjsp1olGdaxDbGk7l6ArJy
	 D87II4rFCH8ROQsnevp9OgN0wyoJx5xWIkuluwTrMF37hjZyU1Yvgfg12V08592Jk+
	 /FQUZTVXdciZ+bAySL0C/PF18QNRt7SaumlNYuoPmM2YZAjYb0iRI7Q/Q7eziaiSMk
	 Mn9KIPnsjdrdpxbLqkdw/tqpCqhGj57Xvo9WgRtch14kzuSNTLbXgaWZ+yH0RzVOeJ
	 YpJktNhlvPifhXVomcQ50te2O2KgeJPc+nY2CVjzjZd0tWx5cvizcJxSR4uc/czDCl
	 2g7hHpwiz25eWVP7TeTWFylYBaOrb3Q7QbPQgHxxtjCEmW9hyL2cyLemJBBwauOkKo
	 MkjO+CodGzDq2N34aznrZxlXgx6zZ1LYDsl55Y9SQIF+1MyYS+GTTwiJyBY6tdhQu8
	 Cn6LWlTIpPQLWtmOGvEoswm5j5EG80T+QfP3lG5U8WIcdACPvkLWTy4/W1K7M7ry0q
	 14u/Z9rG5cR4WMI5W/w0lE4Re7DGK0zgr3RDi1k9qIqLJtGR8AcpkRlBP9UsPSxUnU
	 JnAFn6CXd5Rhz+0I3C+gNnp8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3F0640E0192;
	Tue, 29 Oct 2024 11:39:12 +0000 (UTC)
Date: Tue, 29 Oct 2024 12:39:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	hpa@zytor.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 1/2] x86/bugs: Check VERW mitigations for consistency
Message-ID: <20241029113911.GVZyDJX3rg8kh_4kYb@fat_crate.local>
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <3ed45a10e2f7fbecce31d9964b1da1372e8cb838.1730158506.git.daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ed45a10e2f7fbecce31d9964b1da1372e8cb838.1730158506.git.daniel.sneddon@linux.intel.com>

On Mon, Oct 28, 2024 at 04:50:34PM -0700, Daniel Sneddon wrote:
> There are currently 4 mitigations that use VERW: MDS, TAA,
> MMIO Stale Data, and Register File Data Sampling. Because
> all 4 use the same mitigation path, if any one of them is
> enabled, they're all enabled. Normally, this is what is
> wanted. However, if a user wants to disable the mitigation,
> this can cause problems. If the user misses disabling even
> one of these mitigations, then none of them will be
> disabled. This can cause confusion as the user expects to
> regain the performance lost to the mitigation but isn't
> seeing any improvement. Since there are already 4 knobs for
> controlling it, adding a 5th knob that controls all 4
> mitigations together would just overcomplicate things.
> Instead, let the user know their mitigations are out of sync
> when at least one of these mitigations is disabled but not
> all 4.

Please split this commit message into smaller chunks for better readability.
For example:

    There are currently 4 mitigations that use VERW: MDS, TAA, MMIO Stale Data,
    and Register File Data Sampling. Because all 4 use the same mitigation path,
    if any one of them is enabled, they're all enabled.
    
    Normally, this is what is wanted. However, if a user wants to disable the
    mitigation, this can cause problems. If the user misses disabling even one of
    these mitigations, then none of them will be disabled.
    
    This can cause confusion as the user expects to regain the performance lost to
    the mitigation but isn't seeing any improvement. Since there are already
    4 knobs for controlling it, adding a 5th knob that controls all 4 mitigations
    together would just overcomplicate things.
    
    Instead, let the user know their mitigations are out of sync when at least one
    of these mitigations is disabled but not all 4.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

