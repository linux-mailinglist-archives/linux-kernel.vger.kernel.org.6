Return-Path: <linux-kernel+bounces-171635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA75A8BE6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB4CB220D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94791607A2;
	Tue,  7 May 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrqCTgKv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388716078B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093906; cv=none; b=lxzPiM6eR9JxtpnMbzTLdR0Tq51A3DSlxWOueo2KUNn9lDfT2AiutqUJcRQ+sUdkid2HHOc+bQ3J6lkC1Sxce1BOkFdpjewwclHUmOtYUHQNufIhQ8/KTlKBSgcRnmfYwQRw6vl31tJVtxkNcbusfkfF4Q9LNGk5X6bmbtpVfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093906; c=relaxed/simple;
	bh=BoniYdVi6dZzCpHSJPcK6578i3gt0JCIXLT1l4PMHsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fr8A0ymAmKoEwNXfT92O4gqOSE1B4tfMZZAqgMvu8Qbmw+jcRdsvY9oB8vBs3ZeEocTggFhLPevytd372se9us8uazZGPh3Xdm5uc4et8aEag+q0hpV7gv7fjGlBxGNWer7cPncZFZHcm40Ph9qu1DNzyXaUVgzhPrCFmmFaCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrqCTgKv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715093904; x=1746629904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BoniYdVi6dZzCpHSJPcK6578i3gt0JCIXLT1l4PMHsA=;
  b=PrqCTgKvMVw+vn7QaeEDgZn+WFkCp/dFyNN2E9SEGr1gFSK2d2Vqd4ND
   m5q9UJrqdf196kCE6mSCNhEyieg5Eth9y6ue4wbPJSN7jkE7J2zAqgTNe
   H4WtiH8CUfH6khzrNaiV5AgBgWElmdpO8Rfq+qGcYTvbXVnhPi00t1qXC
   tRqqInJObIBfqVOBmjCUcpNudmROz02CMmFWLiu0+DEjegOHL3SNnHAq4
   AoVRRrmrl4RpFwe8wkjZfg+KmQB2f+b1YmszWrvqL3W28pEx7ll/Om1An
   1Fx2dbFxPiyl4a0uq1kR5TmkpYQs2RKowcKKStViuT4dGzmwMwMAhQZs+
   A==;
X-CSE-ConnectionGUID: 0zQDDlPoR4esKTX/mhuumg==
X-CSE-MsgGUID: ZH8ksL/TRX+vH/X26OS4qQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10827524"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="10827524"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 07:58:24 -0700
X-CSE-ConnectionGUID: ZTAuw5s8QYS94ZZgR+7DDA==
X-CSE-MsgGUID: uBftWuxfScWPw1YcL5CBow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="29063162"
Received: from bwkammey-mobl2.amr.corp.intel.com (HELO [10.125.19.152]) ([10.125.19.152])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 07:58:23 -0700
Message-ID: <ab3e92eb-d35e-4f5a-8e99-10b3ccb7c2cf@linux.intel.com>
Date: Tue, 7 May 2024 07:58:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Maksim Davydov <davydov-max@yandex-team.ru>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 22:30, Josh Poimboeuf wrote:
> In cloud environments it can be useful to *only* enable the vmexit
> mitigation and leave syscalls vulnerable.  Add that as an option.
> 
> This is similar to the old spectre_bhi=auto option which was removed
> with the following commit:
> 
>   36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")
> 
> with the main difference being that this has a more descriptive name and
> is disabled by default.
> 
> Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---

Does the KConfig option need to be updated to support this as well? Other than
that,
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>

>  Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++---
>  arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++-----
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 213d0719e2b7..9c1f63f04502 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6072,9 +6072,15 @@
>  			deployment of the HW BHI control and the SW BHB
>  			clearing sequence.
>  
> -			on   - (default) Enable the HW or SW mitigation
> -			       as needed.
> -			off  - Disable the mitigation.
> +			on     - (default) Enable the HW or SW mitigation as
> +				 needed.  This protects the kernel from
> +				 both syscalls and VMs.
> +			vmexit - On systems which don't have the HW mitigation
> +				 available, enable the SW mitigation on vmexit
> +				 ONLY.  On such systems, the host kernel is
> +				 protected from VM-originated BHI attacks, but
> +				 may still be vulnerable to syscall attacks.
> +			off    - Disable the mitigation.
>  
>  	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
>  			(indirect branch speculation) vulnerability.
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index ab18185894df..6974c8c9792d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1625,6 +1625,7 @@ static bool __init spec_ctrl_bhi_dis(void)
>  enum bhi_mitigations {
>  	BHI_MITIGATION_OFF,
>  	BHI_MITIGATION_ON,
> +	BHI_MITIGATION_VMEXIT_ONLY,
>  };
>  
>  static enum bhi_mitigations bhi_mitigation __ro_after_init =
> @@ -1639,6 +1640,8 @@ static int __init spectre_bhi_parse_cmdline(char *str)
>  		bhi_mitigation = BHI_MITIGATION_OFF;
>  	else if (!strcmp(str, "on"))
>  		bhi_mitigation = BHI_MITIGATION_ON;
> +	else if (!strcmp(str, "vmexit"))
> +		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
>  	else
>  		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
>  
> @@ -1659,19 +1662,22 @@ static void __init bhi_select_mitigation(void)
>  			return;
>  	}
>  
> +	/* Mitigate in hardware if supported */
>  	if (spec_ctrl_bhi_dis())
>  		return;
>  
>  	if (!IS_ENABLED(CONFIG_X86_64))
>  		return;
>  
> -	/* Mitigate KVM by default */
> -	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> -	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
> +	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
> +		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");
> +		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> +		return;
> +	}
>  
> -	/* Mitigate syscalls when the mitigation is forced =on */
> +	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and vm exit\n");
>  	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
> -	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
> +	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
>  }
>  
>  static void __init spectre_v2_select_mitigation(void)


