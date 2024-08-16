Return-Path: <linux-kernel+bounces-290047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40657954ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C9C28256D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC81BE874;
	Fri, 16 Aug 2024 16:30:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D511817;
	Fri, 16 Aug 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825800; cv=none; b=CpkO1Vaol3JuOhk84RWN9fAhE5hd/hkvxlTjhDUq6Nb3tYVYGPjXXbZCplRlNEUj+KsNDsKEJLh5Nh+eCjvJ9JqJ8Fr4IW3rBToMtlkpNtNwGw6OCAibPjqgrEQga2mZHdjAwRYtEWC+ylcPyeBc5Uj/Z9u8hWSOqjTsB0Ko19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825800; c=relaxed/simple;
	bh=kjZsKS7JXvySP+eDaJOzL4gYsRiQrwJoBsiiOL6/uOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIqR6FBiZM3m3YBqMrhQfwADvz4HNvEYvWw15Qsbhgq1CNxJQYONWdPZ5SPiSCL2rMbq3VazUzVXSWMksq3GuHlB+rzm645ArJb7yi6FpfPURVGnWNPAPmWaf3PoOZ7lQLhwIu1V0IJYmA23KZ5NTDObvOu1onpHxTpc9NaZ0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAD231515;
	Fri, 16 Aug 2024 09:30:22 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4E073F58B;
	Fri, 16 Aug 2024 09:29:52 -0700 (PDT)
Message-ID: <4cce2fc9-2b42-4e10-b923-387611077d6b@arm.com>
Date: Fri, 16 Aug 2024 17:29:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/22] x86/resctrl: Introduce MBM counters bitmap
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, corbet@lwn.net,
 fenghua.yu@intel.com, reinette.chatre@intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 06/08/2024 23:00, Babu Moger wrote:
> Hardware provides a set of counters when mbm_cntr_assignable feature is
> supported. These counters are used for assigning the events in resctrl
> group when the feature is enabled.
> 
> Introduce mbm_cntrs_free_map bitmap to track available and free counters
> and set of routines to allocate and free the counters.


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ab4fab3b7cf1..c818965e36c9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -185,6 +185,37 @@ bool closid_allocated(unsigned int closid)
>  	return !test_bit(closid, &closid_free_map);
>  }
>  
> +/*
> + * Counter bitmap for tracking the available counters.
> + * ABMC feature provides set of hardware counters for enabling events.
> + * Each event takes one hardware counter. Kernel needs to keep track
> + * of number of available counters.
> + */
> +static DECLARE_BITMAP(mbm_cntrs_free_map, 64);

Please make this resctrl limit of '64' a define in linux/resctrl.h so the arch code knows
what the limit is!

MPAM platforms may have more than this - and really bad things happen if mbm_cntrs_init()
passes bitmap_fill() a value greater than 64.

Even better - could we dynamically allocate this bitmap using the size advertised by the
architecture code?


Thanks,

James

