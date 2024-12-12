Return-Path: <linux-kernel+bounces-442530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7AB9EDDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482EB2822A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9613B791;
	Thu, 12 Dec 2024 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuA2dCIY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C661F60A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733972659; cv=none; b=tepZL02T7a6jgvu37432nzY4rX4wUFDtgLR0dPIZIOYtXE3Gqs7K55nGSjtq7i34/molg2UKNYbIcA1ojl1HasC+aJkAkUEfNCL+D257/SCor30JODXK0qQVvfe+3SWD0prYwLrsApxJB15GmVXQLvAfSVD6xYj3baVHShKO81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733972659; c=relaxed/simple;
	bh=Hrq+a6WXW51XWWS3wLmGanfVMJdQWcnIUm/Pwg0Okgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9wMejtUJ5qfZGQcy+fRzTveXUoFIoA3Q1mK3G3Hy1pTaxbHiYH1h1bUKLalJhT9hrLuAc4IjSvmbCmip2xvNu75Bzb4ZTGypgMPQElkTa3E5qqavDed3uSqGhgORniDV8Uw1VbZPRMBaz7wWNkhZ49ypbiNRAkomvv9c/kgdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuA2dCIY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733972657; x=1765508657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hrq+a6WXW51XWWS3wLmGanfVMJdQWcnIUm/Pwg0Okgg=;
  b=SuA2dCIYYI3suLE+PdVN+6yutCKQXLXWd1cI/PziPJOh4paveJ3uiKJQ
   ScvGRAWUAc7PsBuEXMITpFKMOURN29SxrbcqJ+z/oZvDSu3EpQkfAsxcP
   FxCBXaVJnfX8z6W34pHy9qSLJQpTlVXU9oV9Ua8usdjBRQFmxxqa3ByTx
   pe4aDbeGshFmu+LkimQccP6m0PwwohshcLgw3atF6rADm8yZaDVP6oKgI
   raU+hjvuPSqzILEGPXgubkKpXwb2vx+m1KlGMUhdLnpxRMUirl8aqD1UA
   DPsvqXdIrdxzW7EocU3L8fwvpUFlFQHiT7XAA3Wf6cCqVe1tXP2VJzfPf
   A==;
X-CSE-ConnectionGUID: oHxijjcUS7+h9NVe7yw/ug==
X-CSE-MsgGUID: iHRnE4LlT9OVtdEQEK18Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51790969"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="51790969"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 19:04:17 -0800
X-CSE-ConnectionGUID: galIJQFwT1iXUCWiYm5vaA==
X-CSE-MsgGUID: K9ut+D3ZSEGSLA9BXwX4ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96517966"
Received: from unknown (HELO [10.238.1.173]) ([10.238.1.173])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 19:04:12 -0800
Message-ID: <5bb26488-f5fb-4186-92c3-de6a07631f91@linux.intel.com>
Date: Thu, 12 Dec 2024 11:03:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
To: David Woodhouse <dwmw2@infradead.org>, kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <20241205153343.3275139-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/5 23:05, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> All writes to the page now happen before it gets marked as executable
> (or after it's already switched to the identmap page tables where it's
> OK to be RWX).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kernel/machine_kexec_64.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c9fd60f8f806..9232ad1562c8 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -323,7 +323,7 @@ int machine_kexec_prepare(struct kimage *image)
>   
>   	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
>   
> -	set_memory_x((unsigned long)control_page, 1);
> +	set_memory_rox((unsigned long)control_page, 1);
>   
>   	return 0;
>   }
> @@ -333,6 +333,7 @@ void machine_kexec_cleanup(struct kimage *image)
>   	void *control_page = page_address(image->control_code_page);
>   
>   	set_memory_nx((unsigned long)control_page, 1);
> +	set_memory_rw((unsigned long)control_page, 1);
>   
>   	free_transition_pgtable(image);
>   }

Hi David,

I've hit some kdump/kexec regression issue for guest kernel in KVM/QEMU 
based VM and reported in https://bugzilla.kernel.org/show_bug.cgi?id=219592.

based on further git bisect, it seems to be related with this commit, 
would you help to take a look?

