Return-Path: <linux-kernel+bounces-290098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667AA954F62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56C0284DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5991BF32F;
	Fri, 16 Aug 2024 16:56:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF736156F5D;
	Fri, 16 Aug 2024 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827395; cv=none; b=cTEKoddVV0fILzuDSkin3NliABSEqBvIS6Ueimi1VUobdzWmVCuT3pdvx0+tXYrOEFHQl8Y98nfVb2tuHSqWlpSRYq/RmFcj0gQnUSi3r3DR1sxQ/y37ky2gN3gTJX17Gajh1Ial6OUv7IKtQeJSJvAJQCh/819mzpOOqDqAlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827395; c=relaxed/simple;
	bh=+r716j9gWgZfblbYystj+AGcbT2tnI1NEMZZ3++bdNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZ5ql78aJYrgKVA/O5Lz5T/7lbzi6weD/qAL4Xj10UPm0vYVm2sc7e64wvUjytAVtUV1LXOEClr3rTNsPLZq/Ahg9k/aiSH+OrBCFdw+VtJu70te/+RxGKyQrOqSrMy00XHXg331FUQsytv/6gGTRWEHoMZlx2mt3IFEj1/tZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B5813D5;
	Fri, 16 Aug 2024 09:56:58 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9093F58B;
	Fri, 16 Aug 2024 09:56:26 -0700 (PDT)
Message-ID: <b07218ed-057e-4eaa-b04c-15f7b80cee90@arm.com>
Date: Fri, 16 Aug 2024 17:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/22] x86/resctrl: Introduce the interface to display
 monitor mode
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
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
 mingo@redhat.com, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <c8503402c5dcb17012b2010f6accf00db245dec4.1722981659.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <c8503402c5dcb17012b2010f6accf00db245dec4.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 06/08/2024 23:00, Babu Moger wrote:
> The mbm_mode displays list of monitor modes supported.
> 
> The mbm_cntr_assign is one of the currently supported modes. It is also
> called ABMC (Assignable Bandwidth Monitoring Counters) feature. ABMC
> feature provides option to assign a hardware counter to an RMID and
> monitor the bandwidth as long as it is assigned. ABMC mode is enabled
> by default when supported.
> 
> Legacy mode works without the assignment option.
> 
> Provide an interface to display the monitor mode on the system.
> $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> [mbm_cntr_assign]
> legacy
> 
> Switching the mbm_mode will reset all the mbm counters of all resctrl
> groups.

> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 30586728a4cd..d4ec605b200a 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,40 @@ with the following files:
>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>  	    0=0x30;1=0x30;3=0x15;4=0x15
>  
> +"mbm_mode":
> +	Reports the list of assignable monitoring features supported. The
> +	enclosed brackets indicate which feature is enabled.
> +	::
> +
> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> +	  [mbm_cntr_assign]
> +	  legacy
> +
> +	"mbm_cntr_assign":
> +		AMD's ABMC feature is one of the mbm_cntr_assign mode supported.
> +		The bandwidth monitoring feature on AMD system only guarantees
> +		that RMIDs currently assigned to a processor will be tracked by
> +		hardware. The counters of any other RMIDs which are no longer
> +		being tracked will be reset to zero. The MBM event counters
> +		return "Unavailable" for the RMIDs that are not tracked by
> +		hardware. So, there can be only limited number of groups that can
> +		give guaranteed monitoring numbers. With ever changing configurations
> +		there is no way to definitely know which of these groups are being
> +		tracked for certain point of time. Users do not have the option to
> +		monitor a group or set of groups for certain period of time without
> +		worrying about RMID being reset in between.
> +
> +		The ABMC feature provides an option to the user to assign a hardware
> +		counter to an RMID and monitor the bandwidth as long as it is assigned.
> +		The assigned RMID will be tracked by the hardware until the user
> +		unassigns it manually. There is no need to worry about counters being
> +		reset during this period.

While debugging my rebase of MPAM on top of this series, I've come back to this wording a
few times to try and work out what I should expect to see ...

Is it possible to disentangle the AMD hardware feature description from the description of
the filesystem behaviour this enables? You are really describing what the hardware does if
you don't enable this mode...

An incomplete suggestion of the shape would be something like:

| In mbm_cntr_assign mode user-space is able to specify which control
| or monitor groups in resctrl should have a hardware counter assigned
| using the 'mbm_control' file. The number of hardware counters available
| is described in the 'num_mbm_cntrs' file.
| Changing this mode will cause all counters on a resource to reset.
|
| The feature is needed on platforms which support more control and monitor
| groups than hardware counters, meaning 'unassigned' control or monitor groups will
| report 'Unavailable' or not count all the traffic in an unpredictable way.
|
| Platforms with AMDs ABMC feature enable this mode by default so that counters
| remain assigned even when the corresponding RMID is not in use by any processor.


> +	"Legacy":

Calling "enough hardware counters" 'legacy' is a bit curious.... 'default'?
(but I haven't worked out the benefit of disabling this mode, so maybe it doesn't need a
name.)

> +		Legacy mode works without the assignment option. The monitoring works
> +		as long as there are enough RMID counters available to support number
> +		of monitoring groups.

How can user-space tell this is the case? Could we be specific as to what 'works' means?

Something like:
| By default resctrl assumes each control and monitor group has a hardware counter.
| Hardware without this property will still allow more control or monitor groups
| than 'num_mbm_cntrs' to be created. Reading the mbm files may report
| 'Unavailable' if there is no hardware resource assigned.


N.B. I don't suggest referring to the num_rmid file in these as MPAM doesn't have an
equivalent property.


Thanks,

James

