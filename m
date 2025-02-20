Return-Path: <linux-kernel+bounces-523442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF03A3D6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4352188BBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659BD1F03DA;
	Thu, 20 Feb 2025 10:34:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B31EB9FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047669; cv=none; b=QC6lPzEB9nSUUV2gzTGLL+KwEKb+4a5H4eKmTgqqJwW77UUCti4q2b2mio5BDzZzaHYG21ffhMBDtYPrtV/XsuuBAWKNdOSKLaCLGgjRdRruFEE6Sp58GkT7PHEnND87HKGrbwtoDf5TXIhLvKq8G133Mtapa81Q3OUKORn+Pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047669; c=relaxed/simple;
	bh=bx72gshVSZSBLUvOIXHVz32Dbgwl27M5jgn3UHgYsMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWRNv5BmOGHbRG+XXBARuvBvm2hquLxKyaitZWank42tHO0Uqbu34v42PdcgICJypmrbcan0VCGjKLKhPzDlN+Up4mfF/uLkGE4okOr4pgF8SY1QNkdyYjRcxcK7Yufke6eul+Y7ph8r0NnJhnzM9U4JB7Neel7Bq1rvdjUowSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1F91688;
	Thu, 20 Feb 2025 02:34:44 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988CE3F59E;
	Thu, 20 Feb 2025 02:34:23 -0800 (PST)
Date: Thu, 20 Feb 2025 10:34:20 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
	joey.gouly@arm.com, broonie@kernel.org, mark.rutland@arm.com,
	james.morse@arm.com, yangyicong@hisilicon.com, robin.murphy@arm.com,
	anshuman.khandual@arm.com, maz@kernel.org, liaochang1@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, baohua@kernel.org,
	ioworker0@gmail.com, oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250220103420.GC11745@mazurka.cambridge.arm.com>
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
 <bfe7fc8e-b22b-4ff6-92c1-7444a0d6c5c2@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfe7fc8e-b22b-4ff6-92c1-7444a0d6c5c2@os.amperecomputing.com>

On Wed, Feb 19, 2025 at 05:25:00PM -0800, Yang Shi wrote: 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index d561cf3b8ac7..8c337bd95ef7 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2176,6 +2176,31 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> >   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> >   }
> >   
> > +static bool has_bbml2_noconflict(const struct arm64_cpu_capabilities *entry,
> > +				 int scope)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2))
> > +		return false;
> > +
> > +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> > +	 * as possible. This list is therefore an allow-list of known-good
> > +	 * implementations that both support bbml2 and additionally, fulfil the
> > +	 * extra constraint of never generating TLB conflict aborts when using
> > +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> > +	 * kernel contexts difficult to prove safe against recursive aborts).
> > +	 */
> > +	static const struct midr_range supports_bbml2_without_abort_list[] = {
> > +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> > +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> > +		{}
> > +	};
> > +
> > +	if (!is_midr_in_range_list(read_cpuid_id(), supports_bbml2_without_abort_list))
> > +		return false;
> > +
> > +	return true;
> > +}
> Hi Miko,
> 
> Thanks for cc'ing me this series. I and Ryan discussed about how to 
> advertise BBML2 properly in my thread 
> (https://lore.kernel.org/linux-arm-kernel/4c44cf6e-98de-47bb-b430-2b1331114904@os.amperecomputing.com/). 
> IIUC, this may not work as expected.
> 
> The boot cpu initializes the boot_cpu_data, then the secondary cpus need 
> to update it, the "sanitized" register value will be generated. For 
> example, TLB range capability is determined by ISAR0_EL1. If all the 
> cpus have this feature, the "sanitized" register value will show true 
> otherwise it will show false.
> 
> BBML2 can be determined by MMFR2_EL1. If we can rely on it then system 
> feature does work. But the problem is some implementations may have 
> MMFR2_EL1 set, but they may not be able to handle TLB conflict. We can't 
> rely on it solely so we check MIDR in .matches callback instead of 
> MMFR2_EL1. But system feature .matches callback is just called once on 
> boot CPU because it is supposed to read the sanitized register value. So 
> you actually just checked the MIDR on boot CPU in .matches callback if I 
> read the code correctly.
> 
> I'm not quite familiar with cpufeature details, if I'm wrong please feel 
> free to correct me.
> 
> Yang

Hi Yang,

Thank you for taking the time to review this patch series.

Thank you also for the spot. I am very much not an expert on
cpufeatures, but I think you are correct. IIUC, currently the .matches
check would go through as long as the the boot CPU executing the
.matches function has the correct MIDR value, and as long as
CONFIG_ARM64_ENABLE_BBML2 is set.

If, as you point out, another CPU has a MIDR that is not on this list
and which was not checked (because .matches only executes on a single
boot CPU), then .matches should still go through (and we could run into
problems when said other CPU executes any BBML2 aware code).

Please let me know if I have understood what you are saying correctly.

From re-reading `include/asm/cpufeature.h`, making it a SCOPE_LOCAL_CPU
feature seems to be close to what we want. We want to have each CPU test
its cpuid against the allowed MIDR list, and the feature overall to
only be considered present if *all* boot cpus returned true (not as
SCOPE_LOCAL_CPU puts it "... detect if at least one matches.").

I will see if this can be hacked around with the current system, and if
not, we might have to extend the current cpucaps scopes / machinery like
you suggest in your patch series comments.

-- 
Kind regards,
Mikołaj Lenczewski

