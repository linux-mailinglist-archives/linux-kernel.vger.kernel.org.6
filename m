Return-Path: <linux-kernel+bounces-547318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A982A505C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E0C168900
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EF1A5BB2;
	Wed,  5 Mar 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UCiTlCjJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163111A841A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193732; cv=none; b=M8TZgDRe+Bk3/f7OrVGnMxKP1vUif3TDE0RNRHWTaRNPN7jP0v+bOg2LwruenWhmMSxJ3UrXBx5XlPcAGfptigwqlXOnmjYX1pTNjzPG1RG056HnawAyjjkf4HRHya6Rfg9+FyQeVuqjrUTkiJeX4qqyzkMjMxZkkbTmhwyuA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193732; c=relaxed/simple;
	bh=+ZHAoC5/XH+Kp4y7MRD85mxe9mA9Yvxiw8OiH60ZiM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn0xuaTJ5+e2fKVB1pXx7RW/KrzMZvBdIUwOQmBO2u3ygfcA6DNZC9+s+TFdYHjeMotuVYTeLpFj5LoizcXyfdkhkfv5QABdVubmVhcPh5whKqfevV3yYFJgYlPVql6w3+b9uWnfkh84Nc8agyI6//GaiPMi/7JhOCpA3aS64j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UCiTlCjJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C41040E01AD;
	Wed,  5 Mar 2025 16:55:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NaeKXCfs7a2D; Wed,  5 Mar 2025 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741193719; bh=yc9clRNUvycc1EqfX1lWh0ZXIWhaV7yOaVPNcOlRBno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCiTlCjJF74l7NxoelzD8jtCH+BmMG4rV8ojaWCOwUggrrZMkbB5PQMtNzdPmRlkk
	 c1B3HwpehlCz5X+86feMHuEi9KjoVejS6BgrGjuQ/N/4cCQnSfWL/uz0haMJEiHmYB
	 B1RxM2acNktNVKqslRI/lVULNPhxsh1CfgMOAU1eP1mxDxVpZJ6mvz0GBUWSJjSe2D
	 yaYxlzn06uoIZnO+AIQqZa9liRXv8zPPZcVgI9Dd8dZ87s5aRPpNzRZoCHMW5Q39E5
	 pWn7nqS1i9VjmthaYrXuCGgQWWZJdNYMMtM6nUNqy5iTFtSHqW2wZA3LYDQ8cHXXvz
	 vL2OYeLhfeGmzuoB52nSNlhD8NLCo6cr4+9NftZ7Wb0+CGSDPeSbj633viGQdXSAwh
	 ytxpU3UitopX+DRxRHnP+CO/oLxLSqHz3bPcIudMRgIkTIKXADNusfyX2y6rg80HTS
	 NeQr+0iBNzMPnlySBLF0mN79ShqzTHeykMKvh554qJTs4sc7RB+D8ObWH4vpIWHaDX
	 yRzWQRWL4rvLnt11rTwtS9Eo+AizbCwBs6uOhQFmWrLu09HRsIrwL3RducOmZ8UWqm
	 mUGmbAEXDw+is5gpiNAIxcBLG+TNa7S3jN90GukeuMErtQdLXVH5DZcWUyUrT8GDJU
	 mBXNJG08goAnGF7kfmHC9jkk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5051540E0215;
	Wed,  5 Mar 2025 16:55:08 +0000 (UTC)
Date: Wed, 5 Mar 2025 17:55:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Joerg Roedel <jroedel@suse.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305165502.GLZ8iB5kAtQmW6fu1F@fat_crate.local>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>

On Wed, Mar 05, 2025 at 08:40:29AM -0800, Dave Hansen wrote:
> TDX guests have CPUID to tell them that they're running that way.

And those CPUID leafs cannot be modified or intercepted or so by the
hypervisor?

> TDX hosts are much more arcane. You can't _actually_ know that it's a
> TDX host until you actually start making successful SEAMCALLs and the
> TDX module answers them. But we fudge it by just looking at
> MSR_IA32_MKTME_KEYID_PARTITIONING at boot and assuming that anything
> with that MSR will be able to be a TDX host.

Fun. :)

> We've just got X86_FEATUREs for hosts and guests:
> 
> 	#define X86_FEATURE_TDX_HOST_PLATFORM ( 7*32+ 7)
> 	#define X86_FEATURE_TDX_GUEST ( 8*32+22)
> 
> and that's it.

And there are no new ones coming down the pipe?

> Folks certainly _want_ something in sysfs to dump the TDX module version
> and so forth, but we've resisted the urge so far.

Perhaps now is the time do design something together...

I was thinking

/sys/guest/...

or something tied to the x86_platform gunk so that we can stick always some
info there about any platform arch/x86/ has detected and is running on...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

