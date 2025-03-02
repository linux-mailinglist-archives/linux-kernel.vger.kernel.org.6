Return-Path: <linux-kernel+bounces-540408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55089A4B045
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5B017AE10
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B71D63F2;
	Sun,  2 Mar 2025 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zs8748UP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CF1BD9E3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740899253; cv=none; b=qVm60ASlwb9D0qMH1HN4e0YUkz3U9Re2O4qRAi8ZJp2GuUD5mrib50yj8YO6cG/5mY+sOx8eke4EdbDfuysq+RnzTutxGF/Bs5oZEn3jsSz+WBw1W+a9e+M5263/1c9RVcDlbgvBca8XvKsaDzTHMOcKJrMOJn1qyWl+Zkp42us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740899253; c=relaxed/simple;
	bh=+3qEYLnSS9czAH8h44V1EoDDldIGHaoxlI5rRWPHjJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOCx//cKZXpwBZdFOm0ZLxQQsSwr1+aajevDfu/SNLEUHQEFTSX2wTI1XWyGKSZ6BctdWWljLAgO0syxMCfhfiGABNj60BD3nomnzCCH5kNyFyOH66ooJQ7uKPmV7yK88mI5Y3JJSPRtBVmXV7sit/oS4AGftTiUqHdDMMLV/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zs8748UP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0BD7140E0184;
	Sun,  2 Mar 2025 07:07:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zckmVIv14FMa; Sun,  2 Mar 2025 07:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740899239; bh=lLba2xpQGx6FAfKVazzHChORkszDX51lkuKQTDG7Akg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zs8748UPnshe6GtiTQWeuLHy5ng1We7LaExBf/jGuiyPyWPp62J5kkR3rlhZR/a2c
	 onxeX2pvvgNT14rN00u/x56bOWhCmtYeYfyiBgWsGAsARKNodblUAscQXIXr6tfVDz
	 CAxhWT9Dljs6SBVrSXkGFQoHZRvAKnNTpg+28WgUMcYXcjGhzxsh08rG0lxThDY6c6
	 LypqZxu57DHkcR4/aFYUtaPa9MGCtVkmai3NLg/MYfv1HcvGsUpJnQ5SbgS0nJYC6N
	 zayRGFJl9y6IRoE0E9fmn0kitxfp7D8tlfMcse12oHETgHqvzyiFjO//Ljlu2nBiou
	 jLA5NAkJ0MVYRGbmwokqay/PIxQa/dmr6JQ25N8hI8QEC8yXT+XM2g08//9vP2XjAq
	 7yR3LpXFE4aPhsvD0Ycy9+rI8l0LOi5gEfl/DGwlggQ7ddRMQtZKEo6Kte+uPKNF0V
	 rlnqkZEklDUP5z2aANHyHAWFfCRIKNJlleZeXeTmhQfShVmbeuUC9lBF71NG1+WY36
	 jOL6zlz0GfydCwNmiAR4XTN8TyjS49D+yC1exN+soSQb0dcbpb5Xfq8T6dmyzSVt6S
	 ckcXca2DFWHaralm8VLFFCEb3vkDzSpwreESDCwARigJ88lZQbS5AnctDNHt+OYZxe
	 86Kp84DGJWw3oA4R6jq6iI6g=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C62F240E0028;
	Sun,  2 Mar 2025 07:07:01 +0000 (UTC)
Date: Sun, 2 Mar 2025 08:06:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 07/13] x86/mm: add global ASID allocation helper
 functions
Message-ID: <20250302070654.GIZ8QDjih21cExg35g@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-8-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-8-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:42PM -0500, Rik van Riel wrote:
> Add functions to manage global ASID space. Multithreaded processes that
> are simultaneously active on 4 or more CPUs can get a global ASID,
> resulting in the same PCID being used for that process on every CPU.
> 
> This in turn will allow the kernel to use hardware-assisted TLB flushing
> through AMD INVLPGB or Intel RAR for these processes.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/include/asm/mmu.h         |  11 +++
>  arch/x86/include/asm/mmu_context.h |   2 +
>  arch/x86/include/asm/tlbflush.h    |  43 +++++++++
>  arch/x86/mm/tlb.c                  | 146 ++++++++++++++++++++++++++++-
>  4 files changed, 199 insertions(+), 3 deletions(-)

Some small touchups ontop:

--- /tmp/current.patch	2025-03-02 07:33:13.913105249 +0100
+++ /tmp/0001-x86-mm-Add-global-ASID-allocation-helper-functions.patch	2025-03-02 08:05:23.613262232 +0100
 diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
-index 3b496cdcb74b..edb5942d4829 100644
+index 3b496cdcb74b..7fbefea5fdae 100644
 --- a/arch/x86/include/asm/mmu.h
 +++ b/arch/x86/include/asm/mmu.h
@@ -35,6 +38,7 @@ index 3b496cdcb74b..edb5942d4829 100644
 +	 * hardware-assisted remote TLB invalidation like AMD INVLPGB.
 +	 */
 +	u16 global_asid;
++
 +	/* The process is transitioning to a new global ASID number. */
 +	bool asid_transition;
 +#endif
@@ -251,7 +255,12 @@ index 1cc25e83bd34..9b1652c02452 100644
 +	if (mm_global_asid(mm))
 +		return;
 +
-+	/* The last global ASID was consumed while waiting for the lock. */
++	/*
++	 * The last global ASID was consumed while waiting for the lock.
++	 *
++	 * If this fires, a more aggressive ASID reuse scheme might be
++	 * needed.
++	 */
 +	if (!global_asid_available) {
 +		VM_WARN_ONCE(1, "Ran out of global ASIDs\n");
 +		return;
@@ -284,5 +293,5 @@ index 1cc25e83bd34..9b1652c02452 100644
   * Given an ASID, flush the corresponding user ASID.  We can delay this
   * until the next time we switch to it.
 -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

