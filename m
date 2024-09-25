Return-Path: <linux-kernel+bounces-339633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD90986829
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46941C210B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E81614D430;
	Wed, 25 Sep 2024 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXKaa92M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD51D5AD5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298707; cv=none; b=mKHnCaE+EmqMupjVgy18lYTwsDJqVuAPcGwJna1ljhI1I+oPhz2xYYt2QfaEjI4xSB6XB7ngNukm1zWPcDm5MLygSHgZ8iNV0+TbQchp1OMFlx1AMse//Mw+YAdi3tS/mGlCan1X/wDVx8KHFjDikJqf6NcrnbdU3bCHrKKpyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298707; c=relaxed/simple;
	bh=WYQuFwzok3rg+YHdOtEOx563voWrz5vF/+BSsDdrK9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDgbu+AaKM3EwVjW0zAaleUViekvSL/wmVcaxzR6mxDTTFn1FWsiRhUSUKFTq2bMovSPMcYMizsS5m2loIaLdwmjf8y6odMuoEMuCFXUyZ37MZbggl0+TGvTY7zeToNTQJSLWGIngqAMOR73v2FMVYKOEFjB+XrDwpjTbcCuIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXKaa92M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727298706; x=1758834706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WYQuFwzok3rg+YHdOtEOx563voWrz5vF/+BSsDdrK9w=;
  b=YXKaa92MkCd25jORc9UdGHYQaWg0Hn8W0/pV+TD69NYpAyeGBki7Vwvj
   hINk9r95QM3WQ4afSBUmV4VUfnK1ASlaDcuWkO/+Ls18mczKxuEHQJemQ
   nRcydP8Ob/T5+/FPB5Inhtzj6RXYN0SAnzIjLEhIkBMtmZhkRkuAwvgKT
   Sxiv20+bdm4lA9iJRwql4bxT89r+UtxW81RGuCpLV+QM0ioW16FIUM7qr
   Mst4Nfrj/qcDre2WgPKGC6ACJaIg8tFVcIhKwBbK2yhOBUdsq8ekmkT7T
   DaAPYTTyYBwos5vCBl6DMqMxKykw7xT1+aXilgrv053t0hV1a+ZQ14Qsl
   g==;
X-CSE-ConnectionGUID: zTjXaNR2Qh+zMTuPBvQ3qg==
X-CSE-MsgGUID: FJaGSsiaRgm0sAKEmZAFHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37514332"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="37514332"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 14:11:45 -0700
X-CSE-ConnectionGUID: x7icb/xySOu2oihN2PnC5w==
X-CSE-MsgGUID: Vd2m/jYdTXy9SiUKkaq2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="75998554"
Received: from fecarpio-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.229])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 14:11:45 -0700
Date: Wed, 25 Sep 2024 14:11:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: Re: [PATCH v6 3/3] x86/bugs: Use stack segment selector for VERW
 operand
Message-ID: <20240925211138.ccc6zodo7h5x3mvx@desk>
References: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>
 <20240905-fix-dosemu-vm86-v6-3-7aff8e53cbbf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-fix-dosemu-vm86-v6-3-7aff8e53cbbf@linux.intel.com>

On Thu, Sep 05, 2024 at 09:00:57AM -0700, Pawan Gupta wrote:
> Robert Gill reported below #GP in 32-bit mode when dosemu software was
> executing vm86() system call:
> 
>   general protection fault: 0000 [#1] PREEMPT SMP
>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>   EIP: restore_all_switch_stack+0xbe/0xcf
>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>   Call Trace:
>    show_regs+0x70/0x78
>    die_addr+0x29/0x70
>    exc_general_protection+0x13c/0x348
>    exc_bounds+0x98/0x98
>    handle_exception+0x14d/0x14d
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
> 
> This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
> are enabled. This is because segment registers with an arbitrary user value
> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
> following behavior for VERW instruction:
> 
>   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> 	   FS, or GS segment limit.
> 
> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
> space. Use %ss selector to reference VERW operand. This ensures VERW will
> not #GP for an arbitrary user %ds.
> 
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> Cc: stable@vger.kernel.org # 5.10+
> Reported-by: Robert Gill <rtgill82@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index ff5f1ecc7d1e..aa5ed1a59cde 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -318,12 +318,14 @@
>  /*
>   * Macro to execute VERW instruction that mitigate transient data sampling
>   * attacks such as MDS. On affected systems a microcode update overloaded VERW
> - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %ss
> + * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
> + * 32-bit mode.
>   *
>   * Note: Only the memory operand variant of VERW clears the CPU buffers.
>   */
>  .macro CLEAR_CPU_BUFFERS
> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF

Kselftest ldt_gdt.c in 32-bit mode results in oops when using SS. Dave
suggested to use CS instead, as it can't be user controlled. Using CS is
also more intuitive because the operand for verw i.e. mds_verw_sel is in
code section. With this change no oops were observed running kselftests, I
will be sending the updated version soon.

