Return-Path: <linux-kernel+bounces-430248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43909E2E79
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB9616536B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47931209F4C;
	Tue,  3 Dec 2024 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PlREAQKy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EA1D7E21
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262916; cv=none; b=INEh3ixqEme19zTP72PstbLXKDjL1Aa8kaF7cP1UfhInP2c+gdIwjmCrEKL1I8mG4Cj6FnSsE4IBm80dUrBJ6OeEwHbba+p0qyrm8FZhTed+iotgjMyorjTx2+kJ/gp+qTg63hJne66ok5UOGiCg4MKg0n/yTqe+x3NhHKDBwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262916; c=relaxed/simple;
	bh=69EWHt5qqGt3tE3DmOdJxW6WjB+k1N5b59mvLspiTXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpNkTvzbIxKlIF+81fqMl3LRK7QEMM0XyeEuic6ClEExrZ5VJDLMTN5feTQS40TpBlVyjKX3I3t6TM5X9/WGhuvSWQL6bpHWtiymj1vytPLiOXiyGjXEBVZybQdu59hPfMeMhQ2TvMn+zskqFidow5xKaNOt6a3uz2YnQxNV63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PlREAQKy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7AE3B40E0277;
	Tue,  3 Dec 2024 21:55:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z_lidHZdY1S2; Tue,  3 Dec 2024 21:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733262907; bh=DuGfxudVK+IKNgCsnB0Bnn75mEtxEhzVoRX7+vO1xKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlREAQKym3om2Pdkpz6tPp7dGgBQONIGEPlgopJh7vlHzCQplu7vqPQYm+lC/MtlY
	 RL4pvTtO1/oqfrAS/A69j/nY6Qnl3zQmHHwIMjqZ6OflcfrtDdP24dN0ugHLhmzX1L
	 ALpocT1gcG3Y7lIhk00Ceqt7zrd3VEZK6Go/RbMtBRlo/PtIhAkanrxpoUHhVLhDjG
	 8S8KeIe6YaI8qct8aGtPF98BWmLtFmSixyNp13OtAn/5ioleKKWGl6q8vXze4YWjKK
	 tMUZiFdd8+2t0bd+Q9ODb7pIUgQ8riXl1VOWj0i4vL0FqbHp8RzhjbPYvdEE2J+yrh
	 rIOU/yNd/f3UARnrii/7j+il/bomyriDvxd1+b21ZbcDH+trNAfHwDkVEP2LrdMPzd
	 KEDQOvlOsOadEzezF+P4uqdfPbGWDQu1m8qqsmtlAPrUfqnd9ahfvi/K6D7iK+gm1+
	 9z2sCnTs8SrblOMUaNCExU3UXiVFOhrhrM0DYpV4e1RzAx/suwrApNznBwgzn5dxR7
	 bNTx/lQ1snUruM/6RfGjupt3zdHeUVFcjN0MhA6OBcsuMUReQx+M1oQL+ydQUoYD+U
	 sQ4MbKAsWvtQeaFgx2f//P2+EOFeGSrIrZmahpNc3aRVhB7ruD9gG3uxYC8sFNNUWc
	 CCv5kXtZeoM3w4EfdmFWKjH0=
Received: from zn.tnic (p200300eA9736a14f329c23FffEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a14f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD7CF40E016C;
	Tue,  3 Dec 2024 21:54:59 +0000 (UTC)
Date: Tue, 3 Dec 2024 22:54:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on
 systems with AMD preferred cores
Message-ID: <20241203215454.GJZ09-LmEWPZ502B7R@fat_crate.local>
References: <20241203201129.31957-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203201129.31957-1-mario.limonciello@amd.com>

On Tue, Dec 03, 2024 at 02:11:29PM -0600, Mario Limonciello wrote:
> For the scheduler to use and prefer AMD preferred core rankings set
> SD_ASYM_PACKING for x86_die_flags().
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Fix c23 compatibility issue reported by LKP
> ---
>  arch/x86/kernel/smpboot.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index b5a8f0891135b..6a38cf3feb1a9 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -62,6 +62,8 @@
>  #include <linux/mc146818rtc.h>
>  #include <linux/acpi.h>
>  
> +#include <acpi/cppc_acpi.h>
> +
>  #include <asm/acpi.h>
>  #include <asm/cacheinfo.h>
>  #include <asm/desc.h>
> @@ -501,6 +503,15 @@ static int x86_die_flags(void)
>  	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
>  		return x86_sched_itmt_flags();
>  
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {

You're going to call this on *every* AMD and on Hygon?

So that whole effort with X86_FEATURE_s was for nothing?

What's up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

