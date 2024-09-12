Return-Path: <linux-kernel+bounces-326403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0A9767EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E659E1F24D19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BDE1A262F;
	Thu, 12 Sep 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TAw3fGrQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A519F42D;
	Thu, 12 Sep 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140555; cv=none; b=kzOs65iGKI8W9llbUy6WsdOoZFejyECIfaomUYxjDznwOYJQi6QbC4sNbmIcX8RGaybrARA026AYiTPaUIjhHQF6/3G3Be62fUp/ZsWICWExF9YZSqLgoxog5+di6kf2g3tOJtfcX2NnQLBXEXOruxbhlS1t60syWZIwcOxHje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140555; c=relaxed/simple;
	bh=L3EHIFaSQ4HJpGeXuD9ttU4eQeZncfI6SbhIYxVZWbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NusnQTvXVh5yPBL9IVWqwj2lvN4/5h+OBjtwg9ZsfluJzDHzj8o1bg+jk6r2CaCwcTtIj4zI10XaH7sim5Uv5gvD+Z9uuiK0Jhg0byoUYxr2sdKVc/j+gJymwhtmKIEf5e7XWp5HoZxfrtrkup6t6lNWkpG10zD+hudivuEjGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TAw3fGrQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 77B7640E028C;
	Thu, 12 Sep 2024 11:29:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I7lr-nqY1IsI; Thu, 12 Sep 2024 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726140546; bh=1KAiXTCLdlbsO4DwIB12FiFyS/+Xq7DQxKpXfxeW/5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAw3fGrQsHtibueWU8gw0VCrWZF9wxv/+yroJ404LmcBsZEqnaXe6Lf7beS4a+NgA
	 CE9fgEsF3pwqcK/j2LNuMNoLJNHFrM6T4Xxcqr5Rk5n+W8UVa2Za44BBjeq+iOi23T
	 HWHXlFkx2YndxWJDjzBgZrks5/5StHAS6KzEajmU8EdNol5P2FklTQvls6K9zKCvFe
	 LFI0uOedllrRzb7UtZjHFvNOuSDjigL7D+C3QInMTljKUa7nZBdfa3Bvyvc15Yd8KA
	 c9wGNt1kZFGiyYrXzQSLPRGHnvVbUulzHr5wP01bYusu8uQiegCR6v4uD3yDcSkwgr
	 bZwKZvowXaTtgpjWL42WJZuB2OpFQPw7kOqFLK01KVy6sFLi/CIGSGZZ3AMJxsebKj
	 LCndvzsl//NKf6S4rAGKnlVF9WbPJ2d1VL+TO+z0mKePZ730EdZBzNA8agEl5Y/YZa
	 mouQhAmKYKsMhTe3UP92Dz3zeB9fZV2oNOcdO9kz35zbTpqgS/uHfAHTIj0g1xXGIE
	 ueAPaKKxHPl/qe+gO5AE+pbBV+CftE2W6ZTKXDmwbhrH+3zZDhasSzODTAxUKVnkAU
	 5ssR/aQqQeNr+e8yKQv3iQxEbxuqOd6AATV/osX7FlRtsrtz53H2FU5twmrGJDgYp/
	 OM7mdhOwrEJmfQpc7c4MFuZw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21EBC40E0289;
	Thu, 12 Sep 2024 11:28:54 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:28:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20240912112847.GGZuLQb4Z2Vvor5-JM@fat_crate.local>
References: <20240905143056.48216-1-papaluri@amd.com>
 <20240905143056.48216-2-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905143056.48216-2-papaluri@amd.com>

On Thu, Sep 05, 2024 at 09:30:55AM -0500, Pavan Kumar Paluri wrote:
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 98726c2b04f8..d3e7f97e2a4a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -8,6 +8,9 @@
>  #ifndef __ASM_X86_SEV_COMMON_H
>  #define __ASM_X86_SEV_COMMON_H
>  
> +#include <asm/cache.h>


> +#include <asm/pgtable_types.h>

What is that include for?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

