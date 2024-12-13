Return-Path: <linux-kernel+bounces-444371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1D9F05CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D239281FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC91993B6;
	Fri, 13 Dec 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjvfxRWq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252E1F95E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734076298; cv=none; b=ZCF+1DsxdBdqpvFxeWLAvWbGhvqt1EaM9IYek9tLfTn3Ig7t64lxhaRZBPQ082kjdi91W2+KCSTZDb+okjIAesrKXqKpGHef56zFPLl8LNrmqpCKOI9ZsP3lLz7rLl+pAIYWdTzY17+fal95UBk/9aVZ22lFf03HIzrOMBYB3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734076298; c=relaxed/simple;
	bh=larGpKh+9UFAJlnun5/y0CrGRBNQTeLHUSeUZEQa9Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYVp0HAHi3XfPQbi8RayoMdPBm/+EgjuZauusB1Cl72YLJJmUyRviVCd6ti2DfJk9ksEg8LQ1KMB+CGYRBotGrhRoxCNbv/e0rEtockZLKPyxu/sK8aiUH2kQh6rCgMysqxNKLqOmT+FKBG68a1HCJ9VxS1dBG49+8pU1t9kUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjvfxRWq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734076297; x=1765612297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=larGpKh+9UFAJlnun5/y0CrGRBNQTeLHUSeUZEQa9Ao=;
  b=WjvfxRWqvMICSidhk5PmFEx+6XIGGNmhncFNJ61oZ37EMyWEhbGMiyj6
   KifuonmdXFjiy1h8Zk9T81q20o5imXZZx364KgkP5Zn/CIKNV3+a06rw5
   9ukBBl0rf0PY+yBDs4dw9Ge5Mi/SYx3U4l4SgepmShNLeUgmT7dbt7Rir
   KDh+W2gi9oThbh3xqlwM4Sge/J7WTMeE6aRPm1n3Deo82mCWVtW+YWm6g
   RepdiseU+epxDK4CEA8lzDB0nRg3f3dWwoR8Ja8W8Inm2sXID01Q0lYii
   rRikDGlIhS4ZJokuirMR1esEZPIhsAFAq0mtRvZCGMysdfv7MZpWerij1
   g==;
X-CSE-ConnectionGUID: 8gZh43/uRDCIZenxWua26w==
X-CSE-MsgGUID: 2clWzORwQUSS2S559rNT8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="37367396"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="37367396"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 23:51:36 -0800
X-CSE-ConnectionGUID: 7KLrGwZaR+G1K8Ic5Dg/nw==
X-CSE-MsgGUID: NcTJzcdjSXCRR78uAdRyOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101432221"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.244.96]) ([10.124.244.96])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 23:51:31 -0800
Message-ID: <05d802b7-4491-4296-9e4f-223e9fdbae95@linux.intel.com>
Date: Fri, 13 Dec 2024 15:51:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: Disable global pages before writing to control
 page
To: David Woodhouse <dwmw2@infradead.org>, Dave Hansen
 <dave.hansen@intel.com>, Nathan Chancellor <nathan@kernel.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <20241212014418.GA532802@ax162>
 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
 <20241212150408.GA542727@ax162>
 <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
 <20241212174243.GA2149156@ax162>
 <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
 <4517cb69-3c5c-4e75-8a14-dab136b29c19@intel.com>
 <212CBB8E-CC94-4A56-8399-1419D8F2FA5C@infradead.org>
 <a14ff894-9268-4a62-87bd-3b2553e0bc01@intel.com>
 <ed7dd45f89e8f286478791137447a21d53735dbd.camel@infradead.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <ed7dd45f89e8f286478791137447a21d53735dbd.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/13 7:08, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The kernel switches to a new set of page tables during kexec. The global
> mappings (_PAGE_GLOBAL==1) can remain in the TLB after this switch. This
> is generally not a problem because the new page tables use a different
> portion of the virtual address space than the normal kernel mappings.
> 
> The critical exception to that generalisation (and the only mapping
> which isn't an identity mapping) is the kexec control page itself —
> which was ROX in the original kernel mapping, but should be RWX in the
> new page tables. If there is a global TLB entry for that in its prior
> read-only state, it definitely needs to be flushed before attempting to
> write through that virtual mapping.
> 
> It would be possible to just avoid writing to the virtual address of the
> page and defer all writes until they can be done through the identity
> mapping. But there's no good reason to keep the old TLB entries around,
> as they can cause nothing but trouble.
> 
> Clear the PGE bit in %cr4 early, before storing data in the control page.
> 
> Fixes: 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as ROX instead of RWX")
> Co-authored-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219592
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>

> ---
> This supersedes the previous 'Only write through identity mapping of
> control page' patch as Dave's approach is much saner now he's actually
> figured out what's going on.
> 
> 
>   arch/x86/kernel/relocate_kernel_64.S | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 553d67845b84..cbadf0142fcb 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -90,14 +90,20 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>   	movq	kexec_pa_table_page(%rip), %r9
>   	movq	%r9, %cr3
>   
> +	/* Leave CR4 in %r13 to enable the right paging mode later. */
> +	movq	%cr4, %r13
> +
> +	/* Disable global pages immediately to ensure this mapping is RWX */
> +	movq	%r13, %r12
> +	andq	$~(X86_CR4_PGE), %r12
> +	movq	%r12, %cr4
> +
>   	/* Save %rsp and CRs. */
> +	movq	%r13, saved_cr4(%rip)
>   	movq    %rsp, saved_rsp(%rip)
>   	movq	%rax, saved_cr3(%rip)
>   	movq	%cr0, %rax
>   	movq	%rax, saved_cr0(%rip)
> -	/* Leave CR4 in %r13 to enable the right paging mode later. */
> -	movq	%cr4, %r13
> -	movq	%r13, saved_cr4(%rip)
>   
>   	/* save indirection list for jumping back */
>   	movq	%rdi, pa_backup_pages_map(%rip)


