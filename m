Return-Path: <linux-kernel+bounces-416743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AB9D497F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E04CB21C23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9391CD1F3;
	Thu, 21 Nov 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2sBlZPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18801CD1E3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179869; cv=none; b=SyZvzgfjTvqX0h7JZ2J2XgwTvX9rb6C3ogZRurCAgTvl2Wo2Xyk4eLu+4mb7hz9VYULrjtXn+SJObcRGL82xTrbMvljTE7dbmVnhF08PgTKm9He3jh99ICOlEzDnPl7Xgl/URHbqzlqBBNyOdjh2O4KBsJ4Q5k0yu8QN4ThEW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179869; c=relaxed/simple;
	bh=19hsQRPevIOPjnveFzXCQHNJzpM4et3eqclq4guKlCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwxL8RhTRhqnRTXh8zeKygJFljKlVPJWHSey6Ir6k5lcJdaZGagdEu4s2SbYORbWmMU3E3XnKpsV2x9o4qVaac0IV3VCtRplIL5lzTkd8K7tcWjGtekjmNZsPFOiZINauD9/X+x54IcSRfs7HNC647I/Wday7XLWI+TC1AWqI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2sBlZPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5DDC4CECC;
	Thu, 21 Nov 2024 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732179869;
	bh=19hsQRPevIOPjnveFzXCQHNJzpM4et3eqclq4guKlCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2sBlZPbMfieuc6zCYlNDOBwjEOdOsHRfXd8mQLvqnwVY3yXs0CLBHeU+jdxXadxE
	 PNeKDKaN1donarQa2F9HB53YYwadPCLTYywe5Bh400llm+b5Yc6aEcgqCnOYgY4Xf8
	 HoSMWz455kKnIS9phB8vsVO2Vml54O1Cj0WcW/dobnCBQ5wAYLpWcwSN38o2ex7HH/
	 SaXsgpHVE0V7LXCGptVR8dQrWSFX6ld0bZFQoFpFt08+4ZGVDWgHrxAKegXC7TvaV2
	 zPhx0/OkvaWfkeF3WDOQBUhf4tiz3W4W6wPSPGat3HXz+I1XLlipC8tMZmfeBSfYNg
	 Ig56Ws3nmuFyQ==
Date: Thu, 21 Nov 2024 10:04:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, kan.liang@linux.intel.com
Subject: Re: [RFC][PATCH 2/4] x86/cpu: Replace 'x86_cpu_desc' use with
 'x86_cpu_id'
Message-ID: <Zz73mGclo4np8tVt@gmail.com>
References: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
 <20241120202411.2E4C9595@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120202411.2E4C9595@davehans-spike.ostc.intel.com>


* Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The 'x86_cpu_desc' and 'x86_cpu_id' structures are very similar.
> Reduce duplicate infrastructure by moving the few users of
> 'x86_cpu_id' to the much more common variant.
> 
> The existing X86_MATCH_VFM_STEPPINGS() helper matches ranges of
> steppings. Introduce a new helper to match a single stepping to make
> the macro use a bit less verbose.
> 
> I'm a _bit_ nervous about this because
> 
> 	X86_MATCH_VFM_STEPPING(INTEL_SANDYBRIDGE_X,  7, 0x0000070c),
> and
> 	X86_MATCH_VFM_STEPPINGS(INTEL_SANDYBRIDGE_X, 7, 0x0000070c),
> 
> look very similar but the second one is buggy. Any suggestions for
> making this more foolproof would be appreciated.

> +static const struct x86_cpu_id isolation_ucodes[] = {
> +	X86_MATCH_VFM_STEPPING(INTEL_HASWELL,		 3, 0x0000001f),
> +	X86_MATCH_VFM_STEPPING(INTEL_HASWELL_L,		 1, 0x0000001e),
> +	X86_MATCH_VFM_STEPPING(INTEL_HASWELL_G,		 1, 0x00000015),
> +	X86_MATCH_VFM_STEPPING(INTEL_HASWELL_X,		 2, 0x00000037),

>  /**
> + * X86_MATCH_VFM_STEPPING - Match encoded vendor/family/model/stepping
> + * @vfm:	Encoded 8-bits each for vendor, family, model
> + * @stepping:	A single integer stepping
> + * @data:	Driver specific data or NULL. The internal storage
> + *		format is unsigned long. The supplied value, pointer
> + *		etc. is cast to unsigned long internally.
> + *
> + * feature is set to wildcard
> + */
> +#define X86_MATCH_VFM_STEPPING(vfm, stepping, data)	\
> +	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
> +		VFM_VENDOR(vfm),			\
> +		VFM_FAMILY(vfm),			\
> +		VFM_MODEL(vfm),				\
> +		X86_STEPPINGS(stepping, stepping), 	\
> +		X86_FEATURE_ANY, data)

Yeah, this mixed with X86_MATCH_VFM_STEPPINGS() indeed looks fragile:

/**
 * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
 * @vfm:        Encoded 8-bits each for vendor, family, model
 * @steppings:  Bitmask of steppings to match
 * @data:       Driver specific data or NULL. The internal storage
 *              format is unsigned long. The supplied value, pointer
 *              etc. is cast to unsigned long internally.
 *
 * feature is set to wildcard
 */
#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)   \
        X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE( \
                VFM_VENDOR(vfm),                        \
                VFM_FAMILY(vfm),                        \
                VFM_MODEL(vfm),                         \
                steppings, X86_FEATURE_ANY, data)

I'd solve this by unifying on a single min-max range-interface:

	X86_MATCH_VFM_STEPPINGS(vfm, stepping_min, stepping_max, data)

which simply passes GENMASK(stepping_min, stepping_max) to .steppings 
field.

Note how almost all existing uses of X86_MATCH_VFM_STEPPINGS() already 
open-codes this:

arch/x86/include/asm/cpu_device_id.h: * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
arch/x86/include/asm/cpu_device_id.h:#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)	\
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
arch/x86/kernel/apic/apic.c:	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
arch/x86/kernel/cpu/common.c:	X86_MATCH_VFM_STEPPINGS(vfm, steppings, issues)
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_D,	X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
drivers/edac/i10nm_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
drivers/edac/skx_base.c:	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),

So I'd start by a patch that changes X86_MATCH_VFM_STEPPINGS() and 
converts these usecases, and then your patch can just use the expanded 
parameters of X86_MATCH_VFM_STEPPINGS() with the same min-max value:

	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL,		 3, 3, 0x0000001f),

That tiny bit of verbosity is far better than the fragility of the 
proposed interface, IMHO.

Also, sometimes single-stepping ranges will expand as quirks/features 
expand in scope, so this is the more natural interface anyway.

... or you can define a trivial single-stepping wrapper:

	X86_MATCH_VFM_STEPPING(vfm, stepping, data) \
		X86_MATCH_VFM_STEPPINGS(vfm, stepping, stepping, data)

Note how this is not nearly as fragile, as typoing the interface would 
result in a build failure, not a silently broken kernel.

Thanks,

	Ingo

