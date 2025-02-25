Return-Path: <linux-kernel+bounces-532422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E12AA44D91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6E91692E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296782185B8;
	Tue, 25 Feb 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhAXgbMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B655218596
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515125; cv=none; b=kJjPrQ32bCg6o+w25GeLa3Cdy8BxPek8ZlarvZmYXxSkaMbRTY9/MzsTppuytA9k+Gk86BMNYwm4uhfkCIWGVqDIQC4Oy9YWchAgksSpIPIIj60yhcbN8v9Get0BFp/9vZ/oWjls34SgFZ7EnXzsRKVcGY6kIJYV7mR8M1/UJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515125; c=relaxed/simple;
	bh=26zXTX2qkqMR5XC6w6a+GTaQlbF0/k5vATONaxaPGjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdzBJMeD4Dbd04EGA6UmeO4bEK95PPQaiQVxIMA6qc23FT2OqDsIW74aCbCObph6bmUJGxSvPfujtL/UWCT6u6n0lTE99+h75kgmsXfJwNoQKr2hs2Ie+yiW3OSWh3hS9xt6lr1dhWfLbvP8MDI6X8+LSCxe3+E8QG8JseADXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhAXgbMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC101C4CEE7;
	Tue, 25 Feb 2025 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740515125;
	bh=26zXTX2qkqMR5XC6w6a+GTaQlbF0/k5vATONaxaPGjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhAXgbMaFR2Pbn64J7z67DxEa3ESArtNY8s8PR1ntW+LkpUo2S6OCa/yl/2kH5dAa
	 9wYXLk4lrh+lx55/bOmFTNpOyE51ZdDFRF+2RpOWz2/rb1b03x3P7xMVK5TOiMLlXo
	 tI3L4M5p44qWEyvc/x17kYetKUB2BQFn8Cp+/ttMMp42w0VUxCLDkAD35vl7ZBWn33
	 +2PV26h+TzWoyRLY6yOY5j0LNjM0QU8VGPv/56gvVqtpPIZF9jarNCKif/PJiH1Xpm
	 8fGrK2AKJm3UVfQCuOvuenO1JuViVplt24vOlyzluM+Ed3ue3gijct9fXT9NWa6vcg
	 4cFnsexk8KNMg==
Date: Tue, 25 Feb 2025 21:25:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, kai.huang@intel.com,
	kirill.shutemov@linux.intel.com, mingo@redhat.com,
	pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
	linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH] x86/reboot: Don't corrupt memory on non-BIOS systems
Message-ID: <Z74nKGVfkhmYppCo@gmail.com>
References: <20250109204352.1720337-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109204352.1720337-1-romank@linux.microsoft.com>


* Roman Kisel <romank@linux.microsoft.com> wrote:

> native_machine_emergency_restart() writes unconditionally
> to the physical address of 0x472 to pass the warm reboot
> flags to BIOS. The BIOS reads this on booting to bypass memory
> test and do the warm boot. On the non-BIOS systems, other
> means have to be employed, and this write is a memory corruption.
> 
> Fix that by moving the offending write into the case where
> the machine is rebooted via BIOS.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/kernel/reboot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 615922838c51..6eec8653493f 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -637,9 +637,8 @@ static void native_machine_emergency_restart(void)
>  
>  	tboot_shutdown(TB_SHUTDOWN_REBOOT);
>  
> -	/* Tell the BIOS if we want cold or warm reboot */
> +	/* Tell the firmware if we want cold or warm reboot */
>  	mode = reboot_mode == REBOOT_WARM ? 0x1234 : 0;
> -	*((unsigned short *)__va(0x472)) = mode;
>  
>  	/*
>  	 * If an EFI capsule has been registered with the firmware then
> @@ -681,6 +680,7 @@ static void native_machine_emergency_restart(void)
>  			break;
>  
>  		case BOOT_BIOS:
> +			*((unsigned short *)__va(0x472)) = mode;
>  			machine_real_restart(MRR_BIOS);

If the value of 0x472 is only meaningful in the legacy 'BOOT_BIOS' 
case, then at minimum the whole block should be moved to that case, not 
just the setting.

Thanks,

	Ingo

